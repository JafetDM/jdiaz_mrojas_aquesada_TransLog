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
:- use_module(base_datos, [traduccion_verbo/2, verbo/5, traducir/3]).
% Load parser BNF by file (module is declared in bnf.pl)
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
    % 1) Intentar análisis BNF
    (   bnf_parser:parsear_oracion_bnf(IdiomaOrigen, OracionTexto, Estructura)
    ->  idioma_destino(IdiomaOrigen, IdiomaDestino),
        traducir_estructura(Estructura, IdiomaOrigen, IdiomaDestino, EstructuraTraducida),
        generar_oracion(EstructuraTraducida, IdiomaDestino, Traduccion)

    ;   % 2) Si no parsea: admitir SOLO 1 palabra y que esté en el léxico
        split_string(OracionTexto, " ", " \t\n\r", Toks),
        Toks = [Uno],                                % exactamente una palabra
        string_lower(Uno, LowStr),
        atom_string(LowAtom, LowStr),
        palabra_en_lexico(IdiomaOrigen, LowAtom),    % debe existir en el diccionario
        base_datos:traducir(IdiomaOrigen, LowAtom, TAtom),
        atom_string(TAtom, Traduccion)
    ).

% Determinar idioma destino
idioma_destino(en, es).
idioma_destino(es, en).

% ========================================
% TRADUCCIÓN DE ESTRUCTURAS
% ========================================

% Traducir estructura completa de oración
traducir_estructura(oracion(SN, SV), IdiomaOrigen, IdiomaDestino, 
                   oracion(SNTrad, SVTrad)) :-
    traducir_sn(SN, IdiomaOrigen, IdiomaDestino, SNTrad),
    traducir_sv(SV, IdiomaOrigen, IdiomaDestino, SVTrad, SN).

% ========================================
% TRADUCCIÓN DE SINTAGMA NOMINAL
% ========================================

% SN: Pronombre
traducir_sn(sn(pron(Pron)), IdiomaOrigen, _IdiomaDestino, sn(pron(PronTrad))) :-
    base_datos:traducir(IdiomaOrigen, Pron, PronTrad).

% SN: Sustantivo solo
traducir_sn(sn(sust(Sust)), IdiomaOrigen, _IdiomaDestino, sn(sust(SustTrad))) :-
    base_datos:traducir(IdiomaOrigen, Sust, SustTrad).

% SN: Det + Sust
traducir_sn(sn(det(Det), sust(Sust)), IdiomaOrigen, _IdiomaDestino, 
        sn(det(DetTrad), sust(SustTrad))) :-
    base_datos:traducir(IdiomaOrigen, Det, DetTrad),
    base_datos:traducir(IdiomaOrigen, Sust, SustTrad).

% SN: Det + Adj + Sust (inglés) -> Det + Sust + Adj (español)
traducir_sn(sn(det(Det), adj(Adj), sust(Sust)), en, es, 
           sn(det(DetTrad), sust(SustTrad), adj(AdjTrad))) :-
    base_datos:traducir(en, Det, DetTrad),
    base_datos:traducir(en, Sust, SustTrad),
    base_datos:traducir(en, Adj, AdjTrad).

% SN: Det + Sust + Adj (español) -> Det + Adj + Sust (inglés)
traducir_sn(sn(det(Det), sust(Sust), adj(Adj)), es, en, 
           sn(det(DetTrad), adj(AdjTrad), sust(SustTrad))) :-
    base_datos:traducir(es, Det, DetTrad),
    base_datos:traducir(es, Sust, SustTrad),
    base_datos:traducir(es, Adj, AdjTrad).

% ========================================
% TRADUCCIÓN DE SINTAGMA VERBAL
% ========================================

% SV: Verbo simple
traducir_sv(sv(verbo(_Verbo, Persona, Numero, Infinitivo)), 
        IdiomaOrigen, IdiomaDestino, 
        sv(verbo(VerboTrad, Persona, Numero, InfTrad)), _SN) :-
    % Nota: IdiomaDestino se usa en la llamada a traducir_verbo_conjugado
    traducir_verbo_conjugado(Infinitivo, Persona, Numero, IdiomaOrigen, IdiomaDestino, 
                            VerboTrad, InfTrad).

% SV: Verbo + SN (objeto directo)
traducir_sv(sv(verbo(_Verbo, Persona, Numero, Infinitivo), SN), 
        IdiomaOrigen, IdiomaDestino, 
        sv(verbo(VerboTrad, Persona, Numero, InfTrad), SNTrad), _SNSujeto) :-
    % Nota: IdiomaDestino se usa en la llamada a traducir_verbo_conjugado
    traducir_verbo_conjugado(Infinitivo, Persona, Numero, IdiomaOrigen, IdiomaDestino, 
                            VerboTrad, InfTrad),
    traducir_sn(SN, IdiomaOrigen, IdiomaDestino, SNTrad).

% SV: Verbo + Prep + SN
traducir_sv(sv(verbo(_Verbo, Persona, Numero, Infinitivo), prep(Prep), SN), 
        IdiomaOrigen, IdiomaDestino, 
        sv(verbo(VerboTrad, Persona, Numero, InfTrad), prep(PrepTrad), SNTrad), _SNSujeto) :-
    % Nota: IdiomaDestino se usa en la llamada a traducir_verbo_conjugado
    traducir_verbo_conjugado(Infinitivo, Persona, Numero, IdiomaOrigen, IdiomaDestino, 
                            VerboTrad, InfTrad),
    base_datos:traducir(IdiomaOrigen, Prep, PrepTrad),
    traducir_sn(SN, IdiomaOrigen, IdiomaDestino, SNTrad).

% SV: Verbo + Adjetivo
traducir_sv(sv(verbo(_Verbo, Persona, Numero, Infinitivo), adj(Adj)), 
        IdiomaOrigen, IdiomaDestino, 
        sv(verbo(VerboTrad, Persona, Numero, InfTrad), adj(AdjTrad)), _SNSujeto) :-
    % Nota: IdiomaDestino se usa en la llamada a traducir_verbo_conjugado
    traducir_verbo_conjugado(Infinitivo, Persona, Numero, IdiomaOrigen, IdiomaDestino, 
                            VerboTrad, InfTrad),
    base_datos:traducir(IdiomaOrigen, Adj, AdjTrad).

% -------------------------
% SV NEGATIVO (ES -> EN)
% -------------------------
traducir_sv(sv(neg, verbo(_V, Persona, Numero, Inf)), es, en,
            sv(neg_do(Form), verbo(base(InfDst), Persona, Numero, InfDst)), _SN) :-
    % elegir infinitivo destino
    ( base_datos:traduccion_verbo(Inf, InfDst) -> true ; InfDst = Inf ),
    % 'be' se maneja aparte
    InfDst \= be,
    % 'do'/'does' según persona/número
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
    % elegimos 'estar' por defecto en atributo/estado
    base_datos:verbo(es, VerboEs, Persona, Numero, estar).

traducir_sv(sv(neg_be, verbo(Be, Persona, Numero, be), adj(Adj)), en, es,
            sv(neg, verbo(VerboEs, Persona, Numero, ser_o_estar), adj(AdjTrad)), _S) :-
    base_datos:verbo(en, Be, Persona, Numero, be),
    base_datos:verbo(es, VerboEs, Persona, Numero, estar),
    base_datos:traducir(en, Adj, AdjTrad).

% -------------------------
% PREGUNTAS SÍ/NO
% -------------------------
% EN -> ES (do/does)
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

% EN -> ES (be)
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

% ES -> EN inversión (Verbo + SN)
traducir_estructura(pregunta(SN, sv(q_es, verbo(Ve, Persona, Numero, Inf))), es, en,
                    oracion(SNen, SVen)) :-
    traducir_sn(SN, es, en, SNen),
    ( base_datos:traduccion_verbo(Inf, InfEn) -> true ; InfEn = Inf ),
    ( InfEn = be
      -> base_datos:verbo(en, Vaux, Persona, Numero, be),
         SVen = sv(neg_be, verbo(Vaux, Persona, Numero, be))  % aquí solo reusamos estructura; abajo generamos
      ;  aux_form(Persona, Numero, Form),
         SVen = sv(q_do(Form), verbo(base(InfEn), Persona, Numero, InfEn))
    ).

% -------------------------
% Generación (salida de texto)
% -------------------------
% Negación ES: ya la genera con "no" (regla existente de generar_sv/3 ampliada)
generar_sv(sv(neg, verbo(V,_,_,_)), _, Texto) :- atomic_list_concat(['no', V], ' ', Texto).
generar_sv(sv(neg, verbo(V,_,_,_), SN), Idioma, Texto) :-
    generar_sn(SN, Idioma, TSN), atomic_list_concat(['no', V, TSN], ' ', Texto).
generar_sv(sv(neg, verbo(V,_,_,_), adj(A)), _, Texto) :-
    atomic_list_concat(['no', V, A], ' ', Texto).
generar_sv(sv(neg, verbo(V,_,_,_), prep(P), SN), Idioma, Texto) :-
    generar_sn(SN, Idioma, TSN), atomic_list_concat(['no', V, P, TSN], ' ', Texto).

% Negación EN con do/does + not + base
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

% Preguntas EN: do/does + SN + base ...
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
    % Obtener infinitivo en idioma destino
    (IdiomaOrigen = es ->
        base_datos:traduccion_verbo(InfOrigen, InfDestino)
    ;
        base_datos:traduccion_verbo(InfDestino, InfOrigen)
    ),
    % Conjugar en idioma destino
    base_datos:verbo(IdiomaDestino, VerboTrad, Persona, Numero, InfDestino).

% ========================================
% GENERACIÓN DE ORACIONES
% ========================================

% Generar oración desde estructura
generar_oracion(oracion(SN, SV), Idioma, Oracion) :-
    generar_sn(SN, Idioma, TextoSN),
    generar_sv(SV, Idioma, TextoSV),
    atomic_list_concat([TextoSN, TextoSV], ' ', Oracion).

% Generar SN
generar_sn(sn(pron(Pron)), _, Pron).
generar_sn(sn(sust(Sust)), _, Sust).
generar_sn(sn(det(Det), sust(Sust)), _, Texto) :-
    atomic_list_concat([Det, Sust], ' ', Texto).
generar_sn(sn(det(Det), adj(Adj), sust(Sust)), _, Texto) :-
    atomic_list_concat([Det, Adj, Sust], ' ', Texto).
generar_sn(sn(det(Det), sust(Sust), adj(Adj)), _, Texto) :-
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