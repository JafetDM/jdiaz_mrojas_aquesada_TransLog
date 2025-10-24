% ========================================
% MOTOR DE TRADUCCIÓN CON ANÁLISIS SINTÁCTICO
% reglas_traduccion.pl
% ========================================
%
% Contiene las reglas de traducción basadas en
% estructuras sintácticas parseadas con BNF
% (El corazón del SISTEMA EXPERTO: Reglas de Transformación Estructural)
% ========================================

% ========================================
% TRADUCCIÓN PRINCIPAL
% ========================================

% Cargar base de datos y el parser BNF para disponer de los predicados necesarios
:- use_module(base_datos, [
    traduccion_verbo/2, verbo/5, traducir/3,             
    articulo/3, pronombre/3, sustantivo/3, adjetivo/3, preposicion/3, % Componentes léxicos
    genero_sust_es/2, pron_feats/4                     
]).
:- use_module('bnf.pl', [parsear_oracion_bnf/3]).       
:- set_prolog_flag(encoding, utf8).                    

% Declaraciones para permitir que las cláusulas de estos predicados estén dispersas
:- discontiguous traducir_estructura/4.
:- discontiguous generar_oracion/3.
:- discontiguous generar_sv/3.
:- discontiguous traducir_sn/4.
:- discontiguous traducir_sv/5.

% ¿Existe exactamente esta palabra en el léxico? (Auxiliar para chequeo de palabra suelta)
palabra_en_lexico(Idioma, Pal) :-
    (   articulo(Idioma, Pal, _)
    ;   pronombre(Idioma, Pal, _)
    ;   sustantivo(Idioma, Pal, _)
    ;   adjetivo(Idioma, Pal, _)
    ;   preposicion(Idioma, Pal, _)
    ).

% Predicado principal que gestiona la traducción:
% 1. Intenta traducción estructural (BNF).
% 2. Si falla (oración inválida o vacía), intenta traducción léxica de una sola palabra.
traducir_con_bnf(IdiomaOrigen, OracionTexto, Traduccion) :-
    % Primer intento: Analizar y traducir la oración completa con BNF
    (   bnf_parser:parsear_oracion_bnf(IdiomaOrigen, OracionTexto, Estructura)
    ->  idioma_destino(IdiomaOrigen, IdiomaDestino),
        % 1. Traducir la estructura sintáctica (e.g., SN, SV)
        traducir_estructura(Estructura, IdiomaOrigen, IdiomaDestino, EstructuraTraducida),
        % 2. Generar el texto final a partir de la estructura traducida
        generar_oracion(EstructuraTraducida, IdiomaDestino, Traduccion)
    % Si el parser BNF falla (cuerpo del 'else' o ';'):
    ;   split_string(OracionTexto, " ", " \t\n\r", Toks),
        Toks = [Uno],                                   % Solo si hay exactamente 1 token (palabra)
        string_lower(Uno, LowStr),
        atom_string(LowAtom, LowStr),
        palabra_en_lexico(IdiomaOrigen, LowAtom),       % Verificar que la palabra esté en la BD
        base_datos:traducir(IdiomaOrigen, LowAtom, TAtom), % Traducir palabra suelta
        atom_string(TAtom, Traduccion)
    ).

% Determinar idioma destino (Mapeo simple)
idioma_destino(en, es).
idioma_destino(es, en).

% ========================================
% TRADUCCIÓN DE ESTRUCTURAS (Nivel de Oración)
% ========================================

% Regla para traducir una Oración simple (Oracion = SN + SV)
traducir_estructura(oracion(SN, SV), IdiomaOrigen, IdiomaDestino,
                   oracion(SNTrad, SVTrad)) :-
    traducir_sn(SN, IdiomaOrigen, IdiomaDestino, SNTrad),
    % El SV se traduce usando el SN, ya que el sujeto (SN) afecta la conjugación
    traducir_sv(SV, IdiomaOrigen, IdiomaDestino, SVTrad, SN).

% ========================================
% TRADUCCIÓN DE SINTAGMA NOMINAL (SN)
% ========================================

% SN = Pronombre
traducir_sn(sn(pron(Pron)), IdiomaOrigen, _Destino, sn(pron(PronTrad))) :-
    base_datos:traducir(IdiomaOrigen, Pron, PronTrad).

% SN = Numeral (solo)
traducir_sn(sn(num(Num)), IdiomaOrigen, _Destino, sn(num(NumTrad))) :-
    base_datos:numeral(IdiomaOrigen, Num, NumTrad).

% SN = Sustantivo (solo). Si es plural en origen, intenta normalizar al singular y pluralizar en destino.
traducir_sn(sn(sust(Sust)), IdiomaOrigen, IdiomaDestino, sn(sust(SustTrad))) :-
        % 1) Si la misma forma está en el léxico de sustantivos (singular/plural recogido), usar traducir/3
        ( base_datos:sustantivo(IdiomaOrigen, Sust, _) -> base_datos:traducir(IdiomaOrigen, Sust, SustTrad)
        ; % 2) Si no, intentar heurística: si termina en 's' y su raíz está en el léxico, traducir la raíz y pluralizar en destino
            ( atom_concat(Stem, 's', Sust), Stem \= '', base_datos:sustantivo(IdiomaOrigen, Stem, _) )
                -> ( base_datos:traducir(IdiomaOrigen, Stem, StemTrad), pluralize(StemTrad, IdiomaDestino, SustTrad) )
        ; % 3) fallback: devolver la misma forma si no se encuentra en el léxico
            SustTrad = Sust
        ).

% SN = Determinante + Sustantivo
traducir_sn(sn(det(Det), sust(Sust)), IdiomaOrigen, _Destino,
            sn(det(DetTrad), sust(SustTrad))) :-
    base_datos:traducir(IdiomaOrigen, Det, DetTrad),
    base_datos:traducir(IdiomaOrigen, Sust, SustTrad).

% SN = Det + Num + Sust (Aplica reglas de pluralización basadas en el numeral)
traducir_sn(sn(det(Det), num(Num), sust(Sust)), IdiomaOrigen, IdiomaDestino,
    sn(det(DetTrad), num(NumTrad), sust(SustTrad))) :-
    base_datos:traducir(IdiomaOrigen, Det, DetTrad),
    base_datos:numeral(IdiomaOrigen, Num, NumTrad),
    % Normalizar sustantivo a singular para buscar la traducción base
    ( base_datos:sustantivo(IdiomaOrigen, Sust, _) -> Base = Sust
    ; atom_concat(Stem, 's', Sust), base_datos:sustantivo(IdiomaOrigen, Stem, _) -> Base = Stem
    ; Base = Sust
    ),
    base_datos:traducir(IdiomaOrigen, Base, SustBaseTrad),
    % Pluralizar en el idioma destino si el numeral no es 'uno'/'one' (lógica de experto)
    ( is_singular_number(NumTrad, IdiomaDestino) -> SustTrad = SustBaseTrad
    ; pluralize(SustBaseTrad, IdiomaDestino, SustTrad)
    ).

% SN = Num + Sust (Similar a la anterior, aplica pluralización)
traducir_sn(sn(num(Num), sust(Sust)), IdiomaOrigen, IdiomaDestino,
    sn(num(NumTrad), sust(SustTrad))) :-
    base_datos:numeral(IdiomaOrigen, Num, NumTrad),
    % Normalizar a singular
    ( base_datos:sustantivo(IdiomaOrigen, Sust, _) -> Base = Sust
    ; atom_concat(Stem, 's', Sust), base_datos:sustantivo(IdiomaOrigen, Stem, _) -> Base = Stem
    ; Base = Sust
    ),
    base_datos:traducir(IdiomaOrigen, Base, SustBaseTrad),
    % Pluralizar
    ( is_singular_number(NumTrad, IdiomaDestino) -> SustTrad = SustBaseTrad
    ; pluralize(SustBaseTrad, IdiomaDestino, SustTrad)
    ).

% -------------------------
% Helpers: determine if a translated numeral represents singular in the target language
% -------------------------
is_singular_number(NumAtom, es) :- atom_string(NumAtom, S), member(S, ['uno', '1']). % 'uno' en español
is_singular_number(NumAtom, en) :- atom_string(NumAtom, S), member(S, ['one', '1']). % 'one' en inglés
is_singular_number(NumAtom, _) :- atom_string(NumAtom, S), S = '1'.

% -------------------------
% Very small pluralizer for target language (ES/EN). Covers common regular cases.
% -------------------------
pluralize(Noun, es, Plural) :-
    ( ends_con(Noun, 'z') -> sub_atom(Noun, 0, _, 1, Stem), atom_concat(Stem, 'ces', Plural) % Luz -> Luces
    ; ultima_letra_vocal(Noun) -> atom_concat(Noun, 's', Plural)                        
    ; atom_concat(Noun, 'es', Plural)                                                   
    ).

pluralize(Noun, en, Plural) :-
    ( ends_con(Noun, 'y'), \+ ultima_letra_vocal(Noun) -> sub_atom(Noun, 0, _, 1, Stem), atom_concat(Stem, 'ies', Plural) % Lady -> Ladies
    ; ends_con(Noun, 's') ; ends_con(Noun, 'x') ; ends_con(Noun, 'z') ; ends_con(Noun, 'ch') ; ends_con(Noun, 'sh') -> atom_concat(Noun, 'es', Plural) 
    ; atom_concat(Noun, 's', Plural)                                                                                  
    ).

% **REGLA CLAVE DE TRANSFORMACIÓN ESTRUCTURAL:**
% EN: Det+Adj+N -> ES: Det+N+Adj (Cambio de posición del adjetivo)
traducir_sn(sn(det(Det), adj(Adj), sust(Sust)), en, es,
            sn(det(DetTrad), sust(SustTrad), adj(AdjTrad))) :-
    base_datos:traducir(en, Det, DetTrad),
    base_datos:traducir(en, Sust, SustTrad),
    base_datos:traducir(en, Adj, AdjTrad).

% **REGLA CLAVE DE TRANSFORMACIÓN ESTRUCTURAL:**
% ES: Det+N+Adj -> EN: Det+Adj+N (Cambio de posición del adjetivo)
traducir_sn(sn(det(Det), sust(Sust), adj(Adj)), es, en,
            sn(det(DetTrad), adj(AdjTrad), sust(SustTrad))) :-
    base_datos:traducir(es, Det, DetTrad),
    base_datos:traducir(es, Sust, SustTrad),
    base_datos:traducir(es, Adj, AdjTrad).

% ========================================
% TRADUCCIÓN DE SINTAGMA VERBAL (SV)
% ========================================

% SV = Verbo (intransitivo)
traducir_sv(sv(verbo(_V, Persona, Numero, Inf)), IdiomaO, IdiomaD,
            sv(verbo(VerboTrad, Persona, Numero, InfTrad)), _SN) :-
    % Traducir y conjugar el verbo
    traducir_verbo_conjugado(Inf, Persona, Numero, IdiomaO, IdiomaD, VerboTrad, InfTrad),
    Inf = Inf. % Se mantiene el infinitivo original (visto en el parser)

% SV = Verbo + SN (transitivo)
traducir_sv(sv(verbo(_V, Persona, Numero, Inf), SN), IdiomaO, IdiomaD,
            sv(verbo(VerboTrad, Persona, Numero, InfTrad), SNTrad), _Suj) :-
    traducir_verbo_conjugado(Inf, Persona, Numero, IdiomaO, IdiomaD, VerboTrad, InfTrad),
    traducir_sn(SN, IdiomaO, IdiomaD, SNTrad).

% SV = Verbo + Preposición + SN (frasal o complementado)
traducir_sv(sv(verbo(_V, Persona, Numero, Inf), prep(Prep), SN), IdiomaO, IdiomaD,
            sv(verbo(VerboTrad, Persona, Numero, InfTrad), prep(PrepTrad), SNTrad), _Suj) :-
    traducir_verbo_conjugado(Inf, Persona, Numero, IdiomaO, IdiomaD, VerboTrad, InfTrad),
    base_datos:traducir(IdiomaO, Prep, PrepTrad),
    traducir_sn(SN, IdiomaO, IdiomaD, SNTrad).

% SV = Verbo + Adjetivo (predicativo, ej. "está feliz")
traducir_sv(sv(verbo(_V, Persona, Numero, Inf), adj(Adj)), IdiomaO, IdiomaD,
            sv(verbo(VerboTrad, Persona, Numero, InfTrad), adj(AdjTrad)), _Suj) :-
    traducir_verbo_conjugado(Inf, Persona, Numero, IdiomaO, IdiomaD, VerboTrad, InfTrad),
    base_datos:traducir(IdiomaO, Adj, AdjTrad).

% -------------------------
% Traducción de SV NEGATIVO (ES -> EN)
% -------------------------

% SV Negativo (ES) -> SNegativo (EN, con auxiliar 'do/does')
traducir_sv(sv(neg, verbo(_V, Persona, Numero, Inf)), es, en,
            sv(neg_do(Form), verbo(base(InfDst), Persona, Numero, InfDst)), _SN) :-
    ( base_datos:traduccion_verbo(Inf, InfDst) -> true ; InfDst = Inf ), % Obtener Infinitivo EN
    InfDst \= be,                                                      % No aplica a 'to be'
    aux_form(Persona, Numero, Form).                                   % Determinar si es 'do' o 'does'

% SV Negativo con verbo 'ser/estar' (ES -> EN)
traducir_sv(sv(neg, verbo(_V, Persona, Numero, be)), es, en,
            sv(neg_be, verbo(Be, Persona, Numero, be)), _SN) :-
    base_datos:verbo(en, Be, Persona, Numero, be).                     % Obtener conjugación de 'to be'

% SV Negativo con complemento (ES -> EN)
traducir_sv(sv(neg, verbo(_V, Persona, Numero, Inf), SN), es, en,
            sv(neg_do(Form), verbo(base(InfDst), Persona, Numero, InfDst), SNTrad), _Suj) :-
    Inf \= be,
    ( base_datos:traduccion_verbo(Inf, InfDst) -> true ; InfDst = Inf ),
    aux_form(Persona, Numero, Form),
    traducir_sn(SN, es, en, SNTrad).

% Negativo con adjetivo y 'ser/estar' (ES -> EN)
traducir_sv(sv(neg, verbo(_V, Persona, Numero, be), adj(Adj)), es, en,
            sv(neg_be, verbo(Be, Persona, Numero, be), adj(AdjTrad)), _Suj) :-
    base_datos:verbo(en, Be, Persona, Numero, be),
    base_datos:traducir(es, Adj, AdjTrad).

% -------------------------
% Traducción de SV NEGATIVO (EN -> ES)
% -------------------------

% SV Negativo con 'do/does not' (EN) -> SV Negativo (ES: 'no' + verbo)
traducir_sv(sv(neg_do(_), verbo(base(Inf), Persona, Numero, Inf)), en, es,
            sv(neg, verbo(VerboEs, Persona, Numero, InfEs)), _SN) :-
    ( base_datos:traduccion_verbo(InfEs, Inf) -> true ; InfEs = Inf ), % Obtener Infinitivo ES
    base_datos:verbo(es, VerboEs, Persona, Numero, InfEs).             % Conjugar en ES

% SV Negativo con complemento (EN -> ES)
traducir_sv(sv(neg_do(_), verbo(base(Inf), Persona, Numero, Inf), SN), en, es,
            sv(neg, verbo(VerboEs, Persona, Numero, InfEs), SNTrad), _Suj) :-
    ( base_datos:traduccion_verbo(InfEs, Inf) -> true ; InfEs = Inf ),
    base_datos:verbo(es, VerboEs, Persona, Numero, InfEs),
    traducir_sn(SN, en, es, SNTrad).

% SV Negativo con 'be not' (EN) -> SV Negativo con 'estar' (ES)
traducir_sv(sv(neg_be, verbo(_Be, Persona, Numero, be)), en, es,
            sv(neg, verbo(VerboEs, Persona, Numero, ser_o_estar), _), _SN) :-
    % Aquí se asume 'estar' para negaciones simples (ej. "I am not")
    base_datos:verbo(es, VerboEs, Persona, Numero, estar).

% SV Negativo con adjetivo y 'be not' (EN -> ES)
traducir_sv(sv(neg_be, verbo(Be, Persona, Numero, be), adj(Adj)), en, es,
            sv(neg, verbo(VerboEs, Persona, Numero, ser_o_estar), adj(AdjTrad)), _S) :-
    base_datos:verbo(en, Be, Persona, Numero, be),
    base_datos:verbo(es, VerboEs, Persona, Numero, estar),
    base_datos:traducir(en, Adj, AdjTrad).

% -------------------------
% Traducción de PREGUNTAS SÍ/NO (Inversión de Sujeto-Verbo)
% -------------------------

% Pregunta con 'do' (EN -> ES: se transforma en Oración, la pregunta es por entonación en ES)
traducir_estructura(pregunta(SN, sv(q_do(_), verbo(base(Inf), Persona, Numero, Inf))), en, es,
                    oracion(SNes, SVes)) :-
    traducir_sn(SN, en, es, SNes),
    base_datos:traduccion_verbo(InfEs, Inf),
    base_datos:verbo(es, V, Persona, Numero, InfEs),
    SVes = sv(verbo(V, Persona, Numero, InfEs)). % Se pierde la marca de pregunta en la estructura

% Pregunta con 'do' y complemento (EN -> ES)
traducir_estructura(pregunta(SN, sv(q_do(_), verbo(base(Inf), Persona, Numero, Inf), SN2)), en, es,
                    oracion(SNes, SVes)) :-
    traducir_sn(SN, en, es, SNes),
    traducir_sn(SN2, en, es, SN2es),
    base_datos:traduccion_verbo(InfEs, Inf),
    base_datos:verbo(es, V, Persona, Numero, InfEs),
    SVes = sv(verbo(V, Persona, Numero, InfEs), SN2es).

% Pregunta con 'be' (EN -> ES)
traducir_estructura(pregunta(SN, sv(q_be, verbo(_Be, Persona, Numero, be))), en, es,
                    oracion(SNes, SVes)) :-
    traducir_sn(SN, en, es, SNes),
    base_datos:verbo(es, V, Persona, Numero, ser), % Se asume 'ser' para preguntas simples de 'to be'
    SVes = sv(verbo(V, Persona, Numero, ser)).

% Pregunta con 'be' y adjetivo (EN -> ES)
traducir_estructura(pregunta(SN, sv(q_be, verbo(_Be, Persona, Numero, be), adj(Adj))), en, es,
                    oracion(SNes, SVes)) :-
    traducir_sn(SN, en, es, SNes),
    base_datos:verbo(es, V, Persona, Numero, estar), % Se asume 'estar' con adjetivos
    base_datos:traducir(en, Adj, AdjEs),
    SVes = sv(verbo(V, Persona, Numero, estar), adj(AdjEs)).

% -------------------------
% Preguntas iniciadas por 'how' (EN -> ES)
% Se mapean a una estructura especial sv(how, ...) para generar 'cómo ...'
% how + do-question
traducir_estructura(pregunta_how(SN, sv(q_do(_), verbo(base(Inf), _PersonaAux, _NumeroAux, Inf))), en, es,
                    oracion(SNes, sv(how, verbo(V, PersonaSN, NumeroSN, InfEs)))) :-
    traducir_sn(SN, en, es, SNes),
    % determinar persona/numero a partir del sujeto SN (no del auxiliar)
    ( SN = sn(pron(Pron)) -> ( base_datos:pron_feats(en, Pron, PersonaSN, NumeroSN) -> true ; PersonaSN = tercera, NumeroSN = singular )
    ; ( SN = sn(num(_)) ; SN = sn(num(_), _) ; SN = sn(det(_), num(_), _) ) -> PersonaSN = tercera, NumeroSN = plural
    ; PersonaSN = tercera, NumeroSN = singular
    ),
    ( base_datos:traduccion_verbo(InfEs, Inf) -> true ; InfEs = Inf ),
    base_datos:verbo(es, V, PersonaSN, NumeroSN, InfEs).

traducir_estructura(pregunta_how(SN, sv(q_do(_), verbo(base(Inf), _PAux, _NAux, Inf), SN2)), en, es,
                    oracion(SNes, sv(how, verbo(V, PersonaSN, NumeroSN, InfEs), SN2es))) :-
    traducir_sn(SN, en, es, SNes),
    traducir_sn(SN2, en, es, SN2es),
    % determinar persona/numero a partir del sujeto SN
    ( SN = sn(pron(Pron)) -> ( base_datos:pron_feats(en, Pron, PersonaSN, NumeroSN) -> true ; PersonaSN = tercera, NumeroSN = singular )
    ; ( SN = sn(num(_)) ; SN = sn(num(_), _) ; SN = sn(det(_), num(_), _) ) -> PersonaSN = tercera, NumeroSN = plural
    ; PersonaSN = tercera, NumeroSN = singular
    ),
    ( base_datos:traduccion_verbo(InfEs, Inf) -> true ; InfEs = Inf ),
    base_datos:verbo(es, V, PersonaSN, NumeroSN, InfEs).

% how + be-question
traducir_estructura(pregunta_how(SN, sv(q_be, verbo(_Be, Persona, Numero, be))), en, es,
                    oracion(SNes, sv(how, verbo(V, Persona, Numero, estar)))) :-
    traducir_sn(SN, en, es, SNes),
    base_datos:verbo(es, V, Persona, Numero, estar).

traducir_estructura(pregunta_how(SN, sv(q_be, verbo(_Be, Persona, Numero, be), adj(Adj))), en, es,
                    oracion(SNes, sv(how, verbo(V, Persona, Numero, estar), adj(AdjEs)))) :-
    traducir_sn(SN, en, es, SNes),
    base_datos:traducir(en, Adj, AdjEs),
    base_datos:verbo(es, V, Persona, Numero, estar).


% Pregunta (ES -> EN: Inversión con auxiliar 'do' o 'be')
traducir_estructura(pregunta(SN, sv(q_es, verbo(_Ve, Persona, Numero, Inf))), es, en,
                    pregunta(SNen, SVen)) :-
    traducir_sn(SN, es, en, SNen),
    ( base_datos:traduccion_verbo(Inf, InfEn) -> true ; InfEn = Inf ), % Obtener Infinitivo EN
    % Lógica: Si el verbo en inglés es 'be', usa inversión con 'be'; si no, usa auxiliar 'do'
    ( InfEn = be
      -> base_datos:verbo(en, Vaux, Persona, Numero, be),
          SVen = sv(q_be, verbo(Vaux, Persona, Numero, be))
      ;  aux_form(Persona, Numero, Form),
          SVen = sv(q_do(Form), verbo(base(InfEn), Persona, Numero, InfEn))
    ).

% Pregunta con complemento (ES -> EN)
traducir_estructura(pregunta(SN, sv(q_es, verbo(_Ve, Persona, Numero, Inf), SN2)), es, en,
                    pregunta(SNen, SVen)) :-
    traducir_sn(SN, es, en, SNen),
    traducir_sn(SN2, es, en, SN2en),
    ( base_datos:traduccion_verbo(Inf, InfEn) -> true ; InfEn = Inf ),
    ( InfEn = be
      -> base_datos:verbo(en, Vaux, Persona, Numero, be),
          SVen = sv(q_be, verbo(Vaux, Persona, Numero, be), SN2en)
      ;  aux_form(Persona, Numero, Form),
          SVen = sv(q_do(Form), verbo(base(InfEn), Persona, Numero, InfEn), SN2en)
    ).

% -------------------------
% Generación (Generar la oración de salida a partir de la estructura traducida)
% -------------------------

% Generación de Sintagma Verbal Negativo (ES)
generar_sv(sv(neg, verbo(V,_,_,_)), _, Texto) :- atomic_list_concat(['no', V], ' ', Texto).
generar_sv(sv(neg, verbo(V,_,_,_), SN), _Idioma, Texto) :-
    generar_sn(SN, es, TSN), atomic_list_concat(['no', V, TSN], ' ', Texto).
generar_sv(sv(neg, verbo(V,_,_,_), adj(A)), _, Texto) :-
    atomic_list_concat(['no', V, A], ' ', Texto).
generar_sv(sv(neg, verbo(V,_,_,_), prep(P), SN), _Idioma, Texto) :-
    generar_sn(SN, es, TSN), atomic_list_concat(['no', V, P, TSN], ' ', Texto).

% Generación de Sintagma Verbal Negativo (EN) - Con auxiliar 'do/does'
generar_sv(sv(neg_do(Form), verbo(base(Inf), Persona, Numero, _)), _, Texto) :-
    aux_word(Form, Persona, Numero, Aux), % Obtener 'do' o 'does'
    atom_string(Inf, S), atomic_list_concat([Aux,'not',S], ' ', Texto).

% Generación de Sintagma Verbal Negativo (EN) con complemento
generar_sv(sv(neg_do(Form), verbo(base(Inf), Persona, Numero, _), SN), Idioma, Texto) :-
    aux_word(Form, Persona, Numero, Aux),
    atom_string(Inf, S), generar_sn(SN, Idioma, TSN),
    atomic_list_concat([Aux,'not',S,TSN], ' ', Texto).

% Generación de Sintagma Verbal Negativo (EN) - Con verbo 'be'
generar_sv(sv(neg_be, verbo(Be,_,_,be)), _, Texto) :-
    atomic_list_concat([Be,'not'], ' ', Texto).
generar_sv(sv(neg_be, verbo(Be,_,_,be), adj(A)), _, Texto) :-
    atomic_list_concat([Be,'not',A], ' ', Texto).
generar_sv(sv(neg_be, verbo(Be,_,_,be), SN), Idioma, Texto) :-
    generar_sn(SN, Idioma, TSN), atomic_list_concat([Be,'not',TSN], ' ', Texto).

% Generación de Preguntas (EN)
generar_oracion(pregunta(SN, SV), en, Texto) :-
    generar_sn(SN, en, TSN), generar_sv_preg_en(SV, TSN, Texto).

% Generación SV Pregunta con auxiliar 'do/does' (EN)
generar_sv_preg_en(sv(q_do(Form), verbo(base(Inf), Persona, Numero, _)), TSN, Texto) :-
    aux_word(Form, Persona, Numero, Aux),
    atom_string(Inf, S), atomic_list_concat([Aux, TSN, S], ' ', Texto). % Estructura: Aux + SN + Verbo
generar_sv_preg_en(sv(q_do(Form), verbo(base(Inf), Persona, Numero, _), SN2), TSN, Texto) :-
    aux_word(Form, Persona, Numero, Aux),
    atom_string(Inf, S), generar_sn(SN2, en, TSN2),
    atomic_list_concat([Aux, TSN, S, TSN2], ' ', Texto).
% Generación SV Pregunta con 'be' (EN)
generar_sv_preg_en(sv(q_be, verbo(Be,_,_,be)), TSN, Texto) :-
    atomic_list_concat([Be, TSN], ' ', Texto). % Estructura: Be + SN
generar_sv_preg_en(sv(q_be, verbo(Be,_,_,be), adj(A)), TSN, Texto) :-
    atomic_list_concat([Be, TSN, A], ' ', Texto).

% Auxiliar para determinar la forma base o de tercera persona del auxiliar 'do'
aux_form(tercera, singular, s3) :- !. % 'does'
aux_form(_,        _,        base). % 'do'

% Mapeo de la forma auxiliar a la palabra real en inglés
aux_word(s3, _, _, 'does').
aux_word(base, _, plural, 'do').
aux_word(base, segunda, singular, 'do').
aux_word(base, primera, singular, 'do').

% ========================================
% TRADUCCIÓN DE VERBOS CONJUGADOS
% ========================================

% Se encarga de traducir el infinitivo y conjugarlo en el idioma destino.
traducir_verbo_conjugado(InfOrigen, Persona, Numero, IdiomaOrigen, IdiomaDestino,
                         VerboTrad, InfDestino) :-
    % 1. Determinar el infinitivo destino (usa la tabla de equivalencias de Infinitivos)
    (IdiomaOrigen = es ->
        base_datos:traduccion_verbo(InfOrigen, InfDestino)
    ;
        base_datos:traduccion_verbo(InfDestino, InfOrigen)
    ),
    % 2. Conjugar en el idioma destino
    base_datos:verbo(IdiomaDestino, VerboTrad, Persona, Numero, InfDestino).

% ========================================
% GENERACIÓN DE ORACIONES
% ========================================

% Generación especial para preguntas iniciadas por 'how' (sv(how,...))
% Produce la forma española: "cómo <verbo> [<SN_obj>]" (omitiendo normalmente el pronombre sujeto)
generar_oracion(oracion(_SN, sv(how, verbo(V,_,_,_))), es, Oracion) :-
    atomic_list_concat(['cómo', V], ' ', Oracion).

generar_oracion(oracion(_SN, sv(how, verbo(V,_,_,_), SNobj)), es, Oracion) :-
    generar_sn(SNobj, es, TSN),
    atomic_list_concat(['cómo', V, TSN], ' ', Oracion).

generar_oracion(oracion(_SN, sv(how, verbo(V,_,_,_), adj(Adj))), es, Oracion) :-
    atomic_list_concat(['cómo', V, Adj], ' ', Oracion).

% **REGLA CLAVE DE EXPERTO (Español):**
% Ajusta el adjetivo por género/número del SUJETO antes de generar el texto final.
generar_oracion(oracion(SN, SV0), es, Oracion) :-
    ajustar_sv_adj_por_SN_es(SN, SV0, SV1), % Aplica el ajuste (ej. 'la casa es roja')
    generar_sn(SN, es, TextoSN),
    generar_sv(SV1, es, TextoSV),
    atomic_list_concat([TextoSN, TextoSV], ' ', Oracion).

% Caso general (idiomas distintos de ES) sin ajustes adicionales de género/número.
generar_oracion(oracion(SN, SV), Idioma, Oracion) :-
    Idioma \= es,
    generar_sn(SN, Idioma, TextoSN),
    generar_sv(SV, Idioma, TextoSV),
    atomic_list_concat([TextoSN, TextoSV], ' ', Oracion).

% =========================
% Generar SN (Convierte la estructura SN en una cadena de texto)
% =========================

generar_sn(sn(pron(Pron)), _, Pron).
generar_sn(sn(sust(Sust)), _, Sust).

% Numerales
generar_sn(sn(num(Num)), _, Num).
generar_sn(sn(num(Num), sust(Sust)), _Idioma, Texto) :-
    atomic_list_concat([Num, Sust], ' ', Texto).
generar_sn(sn(det(Det), num(Num), sust(Sust)), _Idioma, Texto) :-
    atomic_list_concat([Det, Num, Sust], ' ', Texto).

% --- Español: Ajuste de artículo y (si procede) adjetivo ---
generar_sn(sn(det(Det), sust(Sust)), es, Texto) :-
    % Ajusta el artículo (ej. 'el' -> 'la') según el género del sustantivo
    ( genero_sust_es(Sust, G) -> ajustar_articulo_es(Det, G, DetAjust) ; DetAjust = Det ),
    atomic_list_concat([DetAjust, Sust], ' ', Texto).

% SN: Det + Adj + Sust (Estructura EN traducida a ES)
generar_sn(sn(det(Det), adj(Adj), sust(Sust)), es, Texto) :-
    ( genero_sust_es(Sust, G) -> ajustar_articulo_es(Det, G, DetAjust),
                                 ajustar_adjetivo_es(Adj, G, singular, AdjAj) % Ajustar adjetivo
    ; DetAjust = Det, AdjAj = Adj ),
    atomic_list_concat([DetAjust, AdjAj, Sust], ' ', Texto).

% SN: Det + Sust + Adj (Estructura ES, adjetivo va pospuesto)
generar_sn(sn(det(Det), sust(Sust), adj(Adj)), es, Texto) :-
    ( genero_sust_es(Sust, G) -> ajustar_articulo_es(Det, G, DetAjust),
                                 ajustar_adjetivo_es(Adj, G, singular, AdjAj) % Ajustar adjetivo
    ; DetAjust = Det, AdjAj = Adj ),
    atomic_list_concat([DetAjust, Sust, AdjAj], ' ', Texto).

% --- Otros idiomas: salida directa sin ajustes (asume inglés no requiere ajuste) ---
generar_sn(sn(det(Det), sust(Sust)), Idioma, Texto) :-
    Idioma \= es,
    atomic_list_concat([Det, Sust], ' ', Texto).
generar_sn(sn(det(Det), adj(Adj), sust(Sust)), Idioma, Texto) :-
    Idioma \= es,
    atomic_list_concat([Det, Adj, Sust], ' ', Texto).
generar_sn(sn(det(Det), sust(Sust), adj(Adj)), Idioma, Texto) :-
    Idioma \= es,
    atomic_list_concat([Det, Sust, Adj], ' ', Texto).

% Generar SV (simplemente une las palabras en orden)
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
% === Auxiliares de AJUSTE de ADJETIVOS (Solo para la salida en Español) ===
% ========================================

% Mecanismo de ajuste: Si el SV tiene un adjetivo (ej. "es rojo"), se obtienen los rasgos
% del sujeto (SN) para ajustar el adjetivo.
ajustar_sv_adj_por_SN_es(SN, sv(verbo(V,P,N,Inf), adj(Adj0)), sv(verbo(V,P,N,Inf), adj(Adj1))) :-
    rasgos_sujeto_es(SN, Genero, Numero),
    ajustar_adjetivo_es(Adj0, Genero, Numero, Adj1), !. % Aplica ajuste de género/número
ajustar_sv_adj_por_SN_es(SN, sv(neg, verbo(V,P,N,Inf), adj(Adj0)), sv(neg, verbo(V,P,N,Inf), adj(Adj1))) :-
    rasgos_sujeto_es(SN, Genero, Numero),
    ajustar_adjetivo_es(Adj0, Genero, Numero, Adj1), !. % Aplica ajuste en negación
ajustar_sv_adj_por_SN_es(_, SV, SV). % No hay adjetivo en el SV, no se modifica

% Obtiene los rasgos de Género y Número del Sujeto (SN)
rasgos_sujeto_es(sn(pron(Pron)), Genero, Numero) :-
    % Intenta obtener número del pronombre, sino asume singular
    ( pron_feats(es, Pron, _Persona, Numero0) -> true ; Numero0 = singular ),
    % Asume género basado en pronombres explícitos
    ( Pron = 'ella' -> Genero = fem
    ; Pron = 'nosotros' -> Genero = masc
    ; Pron = 'ellos' -> Genero = masc
    ; Genero = masc % Default
    ),
    Numero = Numero0.
    
% Sustantivos simples o con determinantes/adjetivos
rasgos_sujeto_es(sn(sust(Sust)), Genero, singular) :-
    ( genero_sust_es(Sust, G) -> Genero = G ; Genero = masc ).
rasgos_sujeto_es(sn(det(_), sust(Sust)), Genero, singular) :-
    ( genero_sust_es(Sust, G) -> Genero = G ; Genero = masc ).
rasgos_sujeto_es(sn(det(_), sust(Sust), _), Genero, singular) :-
    ( genero_sust_es(Sust, G) -> Genero = G ; Genero = masc ).
rasgos_sujeto_es(sn(det(_), adj(_), sust(Sust)), Genero, singular) :-
    ( genero_sust_es(Sust, G) -> Genero = G ; Genero = masc ).
rasgos_sujeto_es(_, masc, singular). % Valor por defecto si no se puede determinar

% Ajusta adjetivo español por género y número (reglas lingüísticas básicas de concordancia)
ajustar_adjetivo_es(AdjIn, Genero, Numero, AdjOut) :-
    ajustar_genero_es(AdjIn, Genero, AdjG),
    ajustar_numero_es(AdjG, Numero, AdjOut).

% Reglas de Género:
ajustar_genero_es(Adj, masc, Adj) :- !. % No se ajusta si es masculino
ajustar_genero_es(Adj, fem, AdjF) :-
    % 1. Si termina en 'o', se reemplaza por 'a' (ej. 'rojo' -> 'roja')
    ( sub_atom(Adj, _, 1, 0, 'o') ->
        sub_atom(Adj, 0, _, 1, Raiz), atom_concat(Raiz, 'a', AdjF)
    % 2. Si termina en consonante + 'or/ón/án/ín', se añade 'a' (ej. 'trabajador' -> 'trabajadora')
    ; ( ends_con(Adj, 'or') ; ends_con(Adj, 'ón') ; ends_con(Adj, 'án') ; ends_con(Adj, 'ín') ) ->
        atom_concat(Adj, 'a', AdjF)
    % 3. No se modifica (ej. 'azul' queda 'azul' para femenino)
    ; AdjF = Adj
    ).

% Reglas de Número:
ajustar_numero_es(Adj, singular, Adj) :- !. % No se ajusta si es singular
ajustar_numero_es(Adj, plural, AdjP) :-
    ( ultima_letra_vocal(Adj) -> atom_concat(Adj, 's', AdjP) % Vocal: se añade 's'
    ; atom_concat(Adj, 'es', AdjP)                          % Consonante: se añade 'es'
    ).

% --- Ajuste de artículos al género (singular) ---
ajustar_articulo_es('el',  fem, 'la').
ajustar_articulo_es('un',  fem, 'una').
ajustar_articulo_es('la',  masc, 'el').   % Corrección si la estructura trajo el artículo incorrecto
ajustar_articulo_es('una', masc, 'un').
ajustar_articulo_es(Art, _, Art).

% Utilidades: Chequeos simples de final de palabra
ends_con(Atom, Suf) :- atom_length(Suf, L), sub_atom(Atom, _, L, 0, Suf).
ultima_letra_vocal(A) :- sub_atom(A, _, 1, 0, L), member(L, [a,e,i,o,u,á,é,í,ó,ú]).