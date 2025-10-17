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

% Traducir usando el parser BNF
traducir_con_bnf(IdiomaOrigen, OracionTexto, Traduccion) :-
    % Parsear con BNF
    parsear_oracion_bnf(IdiomaOrigen, OracionTexto, Estructura),
    % Traducir estructura
    idioma_destino(IdiomaOrigen, IdiomaDestino),
    traducir_estructura(Estructura, IdiomaOrigen, IdiomaDestino, EstructuraTraducida),
    % Generar texto traducido
    generar_oracion(EstructuraTraducida, IdiomaDestino, Traduccion).

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
traducir_sn(sn(pron(Pron)), IdiomaOrigen, IdiomaDestino, sn(pron(PronTrad))) :-
    traducir(IdiomaOrigen, Pron, PronTrad).

% SN: Sustantivo solo
traducir_sn(sn(sust(Sust)), IdiomaOrigen, IdiomaDestino, sn(sust(SustTrad))) :-
    traducir(IdiomaOrigen, Sust, SustTrad).

% SN: Det + Sust
traducir_sn(sn(det(Det), sust(Sust)), IdiomaOrigen, IdiomaDestino, 
           sn(det(DetTrad), sust(SustTrad))) :-
    traducir(IdiomaOrigen, Det, DetTrad),
    traducir(IdiomaOrigen, Sust, SustTrad).

% SN: Det + Adj + Sust (inglés) -> Det + Sust + Adj (español)
traducir_sn(sn(det(Det), adj(Adj), sust(Sust)), en, es, 
           sn(det(DetTrad), sust(SustTrad), adj(AdjTrad))) :-
    traducir(en, Det, DetTrad),
    traducir(en, Sust, SustTrad),
    traducir(en, Adj, AdjTrad).

% SN: Det + Sust + Adj (español) -> Det + Adj + Sust (inglés)
traducir_sn(sn(det(Det), sust(Sust), adj(Adj)), es, en, 
           sn(det(DetTrad), adj(AdjTrad), sust(SustTrad))) :-
    traducir(es, Det, DetTrad),
    traducir(es, Sust, SustTrad),
    traducir(es, Adj, AdjTrad).

% ========================================
% TRADUCCIÓN DE SINTAGMA VERBAL
% ========================================

% SV: Verbo simple
traducir_sv(sv(verbo(Verbo, Persona, Numero, Infinitivo)), 
           IdiomaOrigen, IdiomaDestino, 
           sv(verbo(VerboTrad, Persona, Numero, InfTrad)), _SN) :-
    traducir_verbo_conjugado(Infinitivo, Persona, Numero, IdiomaOrigen, IdiomaDestino, 
                            VerboTrad, InfTrad).

% SV: Verbo + SN (objeto directo)
traducir_sv(sv(verbo(Verbo, Persona, Numero, Infinitivo), SN), 
           IdiomaOrigen, IdiomaDestino, 
           sv(verbo(VerboTrad, Persona, Numero, InfTrad), SNTrad), _SNSujeto) :-
    traducir_verbo_conjugado(Infinitivo, Persona, Numero, IdiomaOrigen, IdiomaDestino, 
                            VerboTrad, InfTrad),
    traducir_sn(SN, IdiomaOrigen, IdiomaDestino, SNTrad).

% SV: Verbo + Prep + SN
traducir_sv(sv(verbo(Verbo, Persona, Numero, Infinitivo), prep(Prep), SN), 
           IdiomaOrigen, IdiomaDestino, 
           sv(verbo(VerboTrad, Persona, Numero, InfTrad), prep(PrepTrad), SNTrad), _SNSujeto) :-
    traducir_verbo_conjugado(Infinitivo, Persona, Numero, IdiomaOrigen, IdiomaDestino, 
                            VerboTrad, InfTrad),
    traducir(IdiomaOrigen, Prep, PrepTrad),
    traducir_sn(SN, IdiomaOrigen, IdiomaDestino, SNTrad).

% SV: Verbo + Adjetivo
traducir_sv(sv(verbo(Verbo, Persona, Numero, Infinitivo), adj(Adj)), 
           IdiomaOrigen, IdiomaDestino, 
           sv(verbo(VerboTrad, Persona, Numero, InfTrad), adj(AdjTrad)), _SNSujeto) :-
    traducir_verbo_conjugado(Infinitivo, Persona, Numero, IdiomaOrigen, IdiomaDestino, 
                            VerboTrad, InfTrad),
    traducir(IdiomaOrigen, Adj, AdjTrad).

% ========================================
% TRADUCCIÓN DE VERBOS CONJUGADOS
% ========================================

traducir_verbo_conjugado(InfOrigen, Persona, Numero, IdiomaOrigen, IdiomaDestino, 
                        VerboTrad, InfDestino) :-
    % Obtener infinitivo en idioma destino
    (IdiomaOrigen = es ->
        traduccion_verbo(InfOrigen, InfDestino)
    ;
        traduccion_verbo(InfDestino, InfOrigen)
    ),
    % Conjugar en idioma destino
    verbo(IdiomaDestino, VerboTrad, Persona, Numero, InfDestino).

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