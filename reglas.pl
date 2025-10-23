% ========================================
% MOTOR DE TRADUCCIÓN CON ANÁLISIS SINTÁCTICO
% reglas_traduccion.pl
% ========================================
%
% Contiene las reglas de traducción basadas en
% estructuras sintácticas parseadas con BNF
% ========================================

% ========================================
% TRADUCCIÓN PRINCIPAL
% ========================================

% Cargar base de datos y el parser BNF para disponer de los predicados
:- use_module(base_datos, [
    traduccion_verbo/2, verbo/5, traducir/3,
    articulo/3, pronombre/3, sustantivo/3, adjetivo/3, preposicion/3,
    genero_sust_es/2, pron_feats/4
]).
:- use_module('bnf.pl', [parsear_oracion_bnf/3]).
:- set_prolog_flag(encoding, utf8).
:- discontiguous traducir_estructura/4.
:- discontiguous generar_oracion/3.
:- discontiguous generar_sv/3.

% ¿Existe exactamente esta palabra en el léxico?
palabra_en_lexico(Idioma, Pal) :-
    (   articulo(Idioma, Pal, _)
    ;   pronombre(Idioma, Pal, _)
    ;   sustantivo(Idioma, Pal, _)
    ;   adjetivo(Idioma, Pal, _)
    ;   preposicion(Idioma, Pal, _)
    ).

% Traduce: primero intenta BNF; si falla, permite SOLO palabra suelta del léxico
traducir_con_bnf(IdiomaOrigen, OracionTexto, Traduccion) :-
    (   bnf_parser:parsear_oracion_bnf(IdiomaOrigen, OracionTexto, Estructura)
    ->  idioma_destino(IdiomaOrigen, IdiomaDestino),
        traducir_estructura(Estructura, IdiomaOrigen, IdiomaDestino, EstructuraTraducida),
        generar_oracion(EstructuraTraducida, IdiomaDestino, Traduccion)
    ;   split_string(OracionTexto, " ", " \t\n\r", Toks),
        Toks = [Uno],
        string_lower(Uno, LowStr),
        atom_string(LowAtom, LowStr),
        palabra_en_lexico(IdiomaOrigen, LowAtom),
        base_datos:traducir(IdiomaOrigen, LowAtom, TAtom),
        atom_string(TAtom, Traduccion)
    ).

% Determinar idioma destino
idioma_destino(en, es).
idioma_destino(es, en).

% ========================================
% TRADUCCIÓN DE ESTRUCTURAS
% ========================================

traducir_estructura(oracion(SN, SV), IdiomaOrigen, IdiomaDestino,
                    oracion(SNTrad, SVTrad)) :-
    traducir_sn(SN, IdiomaOrigen, IdiomaDestino, SNTrad),
    traducir_sv(SV, IdiomaOrigen, IdiomaDestino, SVTrad, SN).

% ========================================
% TRADUCCIÓN DE SINTAGMA NOMINAL
% ========================================

traducir_sn(sn(pron(Pron)), IdiomaOrigen, _Destino, sn(pron(PronTrad))) :-
    base_datos:traducir(IdiomaOrigen, Pron, PronTrad).

traducir_sn(sn(sust(Sust)), IdiomaOrigen, _Destino, sn(sust(SustTrad))) :-
    base_datos:traducir(IdiomaOrigen, Sust, SustTrad).

traducir_sn(sn(det(Det), sust(Sust)), IdiomaOrigen, _Destino,
            sn(det(DetTrad), sust(SustTrad))) :-
    base_datos:traducir(IdiomaOrigen, Det, DetTrad),
    base_datos:traducir(IdiomaOrigen, Sust, SustTrad).

% EN Det+Adj+N -> ES Det+N+Adj
traducir_sn(sn(det(Det), adj(Adj), sust(Sust)), en, es,
            sn(det(DetTrad), sust(SustTrad), adj(AdjTrad))) :-
    base_datos:traducir(en, Det, DetTrad),
    base_datos:traducir(en, Sust, SustTrad),
    base_datos:traducir(en, Adj, AdjTrad).

% ES Det+N+Adj -> EN Det+Adj+N
traducir_sn(sn(det(Det), sust(Sust), adj(Adj)), es, en,
            sn(det(DetTrad), adj(AdjTrad), sust(SustTrad))) :-
    base_datos:traducir(es, Det, DetTrad),
    base_datos:traducir(es, Sust, SustTrad),
    base_datos:traducir(es, Adj, AdjTrad).

% ========================================
% TRADUCCIÓN DE SINTAGMA VERBAL
% ========================================

traducir_sv(sv(verbo(_V, Persona, Numero, Inf)), IdiomaO, IdiomaD,
            sv(verbo(VerboTrad, Persona, Numero, InfTrad)), _SN) :-
    traducir_verbo_conjugado(Inf, Persona, Numero, IdiomaO, IdiomaD, VerboTrad, InfTrad),
    Inf = Inf.

traducir_sv(sv(verbo(_V, Persona, Numero, Inf), SN), IdiomaO, IdiomaD,
            sv(verbo(VerboTrad, Persona, Numero, InfTrad), SNTrad), _Suj) :-
    traducir_verbo_conjugado(Inf, Persona, Numero, IdiomaO, IdiomaD, VerboTrad, InfTrad),
    traducir_sn(SN, IdiomaO, IdiomaD, SNTrad).

traducir_sv(sv(verbo(_V, Persona, Numero, Inf), prep(Prep), SN), IdiomaO, IdiomaD,
            sv(verbo(VerboTrad, Persona, Numero, InfTrad), prep(PrepTrad), SNTrad), _Suj) :-
    traducir_verbo_conjugado(Inf, Persona, Numero, IdiomaO, IdiomaD, VerboTrad, InfTrad),
    base_datos:traducir(IdiomaO, Prep, PrepTrad),
    traducir_sn(SN, IdiomaO, IdiomaD, SNTrad).

traducir_sv(sv(verbo(_V, Persona, Numero, Inf), adj(Adj)), IdiomaO, IdiomaD,
            sv(verbo(VerboTrad, Persona, Numero, InfTrad), adj(AdjTrad)), _Suj) :-
    traducir_verbo_conjugado(Inf, Persona, Numero, IdiomaO, IdiomaD, VerboTrad, InfTrad),
    base_datos:traducir(IdiomaO, Adj, AdjTrad).

% -------------------------
% SV NEGATIVO (ES -> EN)
% -------------------------

traducir_sv(sv(neg, verbo(_V, Persona, Numero, Inf)), es, en,
            sv(neg_do(Form), verbo(base(InfDst), Persona, Numero, InfDst)), _SN) :-
    ( base_datos:traduccion_verbo(Inf, InfDst) -> true ; InfDst = Inf ),
    InfDst \= be,
    aux_form(Persona, Numero, Form).

traducir_sv(sv(neg, verbo(_V, Persona, Numero, be)), es, en,
            sv(neg_be, verbo(Be, Persona, Numero, be)), _SN) :-
    base_datos:verbo(en, Be, Persona, Numero, be).

traducir_sv(sv(neg, verbo(_V, Persona, Numero, Inf), SN), es, en,
            sv(neg_do(Form), verbo(base(InfDst), Persona, Numero, InfDst), SNTrad), _Suj) :-
    Inf \= be,
    ( base_datos:traduccion_verbo(Inf, InfDst) -> true ; InfDst = Inf ),
    aux_form(Persona, Numero, Form),
    traducir_sn(SN, es, en, SNTrad).

traducir_sv(sv(neg, verbo(_V, Persona, Numero, be), adj(Adj)), es, en,
            sv(neg_be, verbo(Be, Persona, Numero, be), adj(AdjTrad)), _Suj) :-
    base_datos:verbo(en, Be, Persona, Numero, be),
    base_datos:traducir(es, Adj, AdjTrad).

% -------------------------
% SV NEGATIVO (EN -> ES)
% -------------------------

traducir_sv(sv(neg_do(_), verbo(base(Inf), Persona, Numero, Inf)), en, es,
            sv(neg, verbo(VerboEs, Persona, Numero, InfEs)), _SN) :-
    ( base_datos:traduccion_verbo(InfEs, Inf) -> true ; InfEs = Inf ),
    base_datos:verbo(es, VerboEs, Persona, Numero, InfEs).

traducir_sv(sv(neg_do(_), verbo(base(Inf), Persona, Numero, Inf), SN), en, es,
            sv(neg, verbo(VerboEs, Persona, Numero, InfEs), SNTrad), _Suj) :-
    ( base_datos:traduccion_verbo(InfEs, Inf) -> true ; InfEs = Inf ),
    base_datos:verbo(es, VerboEs, Persona, Numero, InfEs),
    traducir_sn(SN, en, es, SNTrad).

traducir_sv(sv(neg_be, verbo(Be, Persona, Numero, be)), en, es,
            sv(neg, verbo(VerboEs, Persona, Numero, ser_o_estar), _), _SN) :-
    base_datos:verbo(es, VerboEs, Persona, Numero, estar).

traducir_sv(sv(neg_be, verbo(Be, Persona, Numero, be), adj(Adj)), en, es,
            sv(neg, verbo(VerboEs, Persona, Numero, ser_o_estar), adj(AdjTrad)), _S) :-
    base_datos:verbo(en, Be, Persona, Numero, be),
    base_datos:verbo(es, VerboEs, Persona, Numero, estar),
    base_datos:traducir(en, Adj, AdjTrad).

% -------------------------
% PREGUNTAS SÍ/NO
% -------------------------

traducir_estructura(pregunta(SN, sv(q_do(_), verbo(base(Inf), Persona, Numero, Inf))), en, es,
                    oracion(SNes, SVes)) :-
    traducir_sn(SN, en, es, SNes),
    base_datos:traduccion_verbo(InfEs, Inf),
    base_datos:verbo(es, V, Persona, Numero, InfEs),
    SVes = sv(verbo(V, Persona, Numero, InfEs)).

traducir_estructura(pregunta(SN, sv(q_do(_), verbo(base(Inf), Persona, Numero, Inf), SN2)), en, es,
                    oracion(SNes, SVes)) :-
    traducir_sn(SN, en, es, SNes),
    traducir_sn(SN2, en, es, SN2es),
    base_datos:traduccion_verbo(InfEs, Inf),
    base_datos:verbo(es, V, Persona, Numero, InfEs),
    SVes = sv(verbo(V, Persona, Numero, InfEs), SN2es).

traducir_estructura(pregunta(SN, sv(q_be, verbo(Be, Persona, Numero, be))), en, es,
                    oracion(SNes, SVes)) :-
    traducir_sn(SN, en, es, SNes),
    base_datos:verbo(es, V, Persona, Numero, ser),
    SVes = sv(verbo(V, Persona, Numero, ser)).

traducir_estructura(pregunta(SN, sv(q_be, verbo(Be, Persona, Numero, be), adj(Adj))), en, es,
                    oracion(SNes, SVes)) :-
    traducir_sn(SN, en, es, SNes),
    base_datos:verbo(es, V, Persona, Numero, estar),
    base_datos:traducir(en, Adj, AdjEs),
    SVes = sv(verbo(V, Persona, Numero, estar), adj(AdjEs)).

traducir_estructura(pregunta(SN, sv(q_es, verbo(Ve, Persona, Numero, Inf))), es, en,
                    oracion(SNen, SVen)) :-
    traducir_sn(SN, es, en, SNen),
    ( base_datos:traduccion_verbo(Inf, InfEn) -> true ; InfEn = Inf ),
    ( InfEn = be
      -> base_datos:verbo(en, Vaux, Persona, Numero, be),
         SVen = sv(neg_be, verbo(Vaux, Persona, Numero, be))
      ;  aux_form(Persona, Numero, Form),
         SVen = sv(q_do(Form), verbo(base(InfEn), Persona, Numero, InfEn))
    ).

% -------------------------
% Generación (salida de texto)
% -------------------------

% Negación ES
generar_sv(sv(neg, verbo(V,_,_,_)), _, Texto) :- atomic_list_concat(['no', V], ' ', Texto).
generar_sv(sv(neg, verbo(V,_,_,_), SN), Idioma, Texto) :-
    generar_sn(SN, Idioma, TSN), atomic_list_concat(['no', V, TSN], ' ', Texto).
generar_sv(sv(neg, verbo(V,_,_,_), adj(A)), _, Texto) :-
    atomic_list_concat(['no', V, A], ' ', Texto).
generar_sv(sv(neg, verbo(V,_,_,_), prep(P), SN), Idioma, Texto) :-
    generar_sn(SN, Idioma, TSN), atomic_list_concat(['no', V, P, TSN], ' ', Texto).

% Negación EN
generar_sv(sv(neg_do(Form), verbo(base(Inf), Persona, Numero, _)), _, Texto) :-
    aux_word(Form, Persona, Numero, Aux),
    atom_string(Inf, S), atomic_list_concat([Aux,'not',S], ' ', Texto).

generar_sv(sv(neg_do(Form), verbo(base(Inf), Persona, Numero, _), SN), Idioma, Texto) :-
    aux_word(Form, Persona, Numero, Aux),
    atom_string(Inf, S), generar_sn(SN, Idioma, TSN),
    atomic_list_concat([Aux,'not',S,TSN], ' ', Texto).

generar_sv(sv(neg_be, verbo(Be,_,_,be)), _, Texto) :-
    atomic_list_concat([Be,'not'], ' ', Texto).
generar_sv(sv(neg_be, verbo(Be,_,_,be), adj(A)), _, Texto) :-
    atomic_list_concat([Be,'not',A], ' ', Texto).
generar_sv(sv(neg_be, verbo(Be,_,_,be), SN), Idioma, Texto) :-
    generar_sn(SN, Idioma, TSN), atomic_list_concat([Be,'not',TSN], ' ', Texto).

% Preguntas EN
generar_oracion(pregunta(SN, SV), en, Texto) :-
    generar_sn(SN, en, TSN), generar_sv_preg_en(SV, TSN, Texto).

generar_sv_preg_en(sv(q_do(Form), verbo(base(Inf), Persona, Numero, _)), TSN, Texto) :-
    aux_word(Form, Persona, Numero, Aux),
    atom_string(Inf, S), atomic_list_concat([Aux, TSN, S], ' ', Texto).
generar_sv_preg_en(sv(q_do(Form), verbo(base(Inf), Persona, Numero, _), SN2), TSN, Texto) :-
    aux_word(Form, Persona, Numero, Aux),
    atom_string(Inf, S), generar_sn(SN2, en, TSN2),
    atomic_list_concat([Aux, TSN, S, TSN2], ' ', Texto).
generar_sv_preg_en(sv(q_be, verbo(Be,_,_,be)), TSN, Texto) :-
    atomic_list_concat([Be, TSN], ' ', Texto).
generar_sv_preg_en(sv(q_be, verbo(Be,_,_,be), adj(A)), TSN, Texto) :-
    atomic_list_concat([Be, TSN, A], ' ', Texto).

% Aux selectores
aux_form(tercera, singular, s3) :- !.
aux_form(_,        _,        base).

aux_word(s3, _, _, 'does').
aux_word(base, _, plural, 'do').
aux_word(base, segunda, singular, 'do').
aux_word(base, primera, singular, 'do').

% ========================================
% TRADUCCIÓN DE VERBOS CONJUGADOS
% ========================================

traducir_verbo_conjugado(InfOrigen, Persona, Numero, IdiomaOrigen, IdiomaDestino,
                         VerboTrad, InfDestino) :-
    (IdiomaOrigen = es ->
        base_datos:traduccion_verbo(InfOrigen, InfDestino)
    ;
        base_datos:traduccion_verbo(InfDestino, InfOrigen)
    ),
    base_datos:verbo(IdiomaDestino, VerboTrad, Persona, Numero, InfDestino).

% ========================================
% GENERACIÓN DE ORACIONES
% ========================================

% *** Ajuste de adjetivo por género/número del SUJETO (solo salida ES) ***
generar_oracion(oracion(SN, SV0), es, Oracion) :-
    ajustar_sv_adj_por_SN_es(SN, SV0, SV1),
    generar_sn(SN, es, TextoSN),
    generar_sv(SV1, es, TextoSV),
    atomic_list_concat([TextoSN, TextoSV], ' ', Oracion).

% Caso general (idiomas distintos de ES) sin ajustes
generar_oracion(oracion(SN, SV), Idioma, Oracion) :-
    Idioma \= es,
    generar_sn(SN, Idioma, TextoSN),
    generar_sv(SV, Idioma, TextoSV),
    atomic_list_concat([TextoSN, TextoSV], ' ', Oracion).

% =========================
% Generar SN (con ajuste ES)
% =========================

generar_sn(sn(pron(Pron)), _, Pron).
generar_sn(sn(sust(Sust)), _, Sust).

% --- Español: ajustar artículo y (si procede) adjetivo ---
generar_sn(sn(det(Det), sust(Sust)), es, Texto) :-
    ( genero_sust_es(Sust, G) -> ajustar_articulo_es(Det, G, DetAjust) ; DetAjust = Det ),
    atomic_list_concat([DetAjust, Sust], ' ', Texto).

generar_sn(sn(det(Det), adj(Adj), sust(Sust)), es, Texto) :-
    ( genero_sust_es(Sust, G) -> ajustar_articulo_es(Det, G, DetAjust),
                                 ajustar_adjetivo_es(Adj, G, singular, AdjAj)
    ; DetAjust = Det, AdjAj = Adj ),
    atomic_list_concat([DetAjust, AdjAj, Sust], ' ', Texto).

generar_sn(sn(det(Det), sust(Sust), adj(Adj)), es, Texto) :-
    ( genero_sust_es(Sust, G) -> ajustar_articulo_es(Det, G, DetAjust),
                                 ajustar_adjetivo_es(Adj, G, singular, AdjAj)
    ; DetAjust = Det, AdjAj = Adj ),
    atomic_list_concat([DetAjust, Sust, AdjAj], ' ', Texto).

% --- Otros idiomas: salida directa sin ajustes ---
generar_sn(sn(det(Det), sust(Sust)), Idioma, Texto) :-
    Idioma \= es,
    atomic_list_concat([Det, Sust], ' ', Texto).
generar_sn(sn(det(Det), adj(Adj), sust(Sust)), Idioma, Texto) :-
    Idioma \= es,
    atomic_list_concat([Det, Adj, Sust], ' ', Texto).
generar_sn(sn(det(Det), sust(Sust), adj(Adj)), Idioma, Texto) :-
    Idioma \= es,
    atomic_list_concat([Det, Sust, Adj], ' ', Texto).

% Generar SV
generar_sv(sv(verbo(Verbo, _, _, _)), _, Verbo).
generar_sv(sv(verbo(Verbo, _, _, _), SN), Idioma, Texto) :-
    generar_sn(SN, Idioma, TextoSN),
    atomic_list_concat([Verbo, TextoSN], ' ', Texto).
generar_sv(sv(verbo(Verbo, _, _, _), prep(Prep), SN), Idioma, Texto) :-
    generar_sn(SN, Idioma, TextoSN),
    atomic_list_concat([Verbo, Prep, TextoSN], ' ', Texto).
generar_sv(sv(verbo(Verbo, _, _, _), adj(Adj)), _, Texto) :-
    atomic_list_concat([Verbo, Adj], ' ', Texto).

% ========================================
% === Auxiliares de AJUSTE de ADJETIVOS ===
% ========================================

% Detecta si el SV lleva adjetivo y lo ajusta por rasgos del sujeto
ajustar_sv_adj_por_SN_es(SN, sv(verbo(V,P,N,Inf), adj(Adj0)), sv(verbo(V,P,N,Inf), adj(Adj1))) :-
    rasgos_sujeto_es(SN, Genero, Numero),
    ajustar_adjetivo_es(Adj0, Genero, Numero, Adj1), !.
ajustar_sv_adj_por_SN_es(SN, sv(neg, verbo(V,P,N,Inf), adj(Adj0)), sv(neg, verbo(V,P,N,Inf), adj(Adj1))) :-
    rasgos_sujeto_es(SN, Genero, Numero),
    ajustar_adjetivo_es(Adj0, Genero, Numero, Adj1), !.
ajustar_sv_adj_por_SN_es(_, SV, SV).

% Rasgos del sujeto a partir del SN traducido al español
rasgos_sujeto_es(sn(pron(Pron)), Genero, Numero) :-
    ( pron_feats(es, Pron, _Persona, Numero0) -> true ; Numero0 = singular ),
    ( Pron = 'ella' -> Genero = fem
    ; Pron = 'nosotros' -> Genero = masc
    ; Pron = 'ellos' -> Genero = masc
    ; Genero = masc
    ),
    Numero = Numero0.
rasgos_sujeto_es(sn(sust(Sust)), Genero, singular) :-
    ( genero_sust_es(Sust, G) -> Genero = G ; Genero = masc ).
rasgos_sujeto_es(sn(det(_), sust(Sust)), Genero, singular) :-
    ( genero_sust_es(Sust, G) -> Genero = G ; Genero = masc ).
rasgos_sujeto_es(sn(det(_), sust(Sust), _), Genero, singular) :-
    ( genero_sust_es(Sust, G) -> Genero = G ; Genero = masc ).
rasgos_sujeto_es(sn(det(_), adj(_), sust(Sust)), Genero, singular) :-
    ( genero_sust_es(Sust, G) -> Genero = G ; Genero = masc ).
rasgos_sujeto_es(_, masc, singular).

% Ajusta adjetivo español por género y número (reglas básicas)
ajustar_adjetivo_es(AdjIn, Genero, Numero, AdjOut) :-
    ajustar_genero_es(AdjIn, Genero, AdjG),
    ajustar_numero_es(AdjG, Numero, AdjOut).

% Género:
ajustar_genero_es(Adj, masc, Adj) :- !.
ajustar_genero_es(Adj, fem, AdjF) :-
    ( sub_atom(Adj, _, 1, 0, 'o') ->
        sub_atom(Adj, 0, _, 1, Raiz), atom_concat(Raiz, 'a', AdjF)
    ; ( ends_con(Adj, 'or') ; ends_con(Adj, 'ón') ; ends_con(Adj, 'án') ; ends_con(Adj, 'ín') ) ->
        atom_concat(Adj, 'a', AdjF)
    ; AdjF = Adj
    ).

% Número:
ajustar_numero_es(Adj, singular, Adj) :- !.
ajustar_numero_es(Adj, plural, AdjP) :-
    ( ultima_letra_vocal(Adj) -> atom_concat(Adj, 's', AdjP)
    ; atom_concat(Adj, 'es', AdjP)
    ).

% --- Ajuste de artículos al género (singular) ---
ajustar_articulo_es('el',  fem, 'la').
ajustar_articulo_es('un',  fem, 'una').
ajustar_articulo_es('la',  masc, 'el').   % por si viniera ya 'la' y el sustantivo fuera masculino
ajustar_articulo_es('una', masc, 'un').
ajustar_articulo_es(Art, _, Art).

% Utilidades
ends_con(Atom, Suf) :- atom_length(Suf, L), sub_atom(Atom, _, L, 0, Suf).
ultima_letra_vocal(A) :- sub_atom(A, _, 1, 0, L), member(L, [a,e,i,o,u,á,é,í,ó,ú]).
