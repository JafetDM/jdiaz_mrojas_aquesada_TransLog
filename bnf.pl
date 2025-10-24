:- module(bnf_parser, [
    parsear_oracion_bnf/3,   % +Idioma, +Texto, -Estructura
    parsear_bnf/3,           % +Idioma, +ListaPalabras, -Estructura
    validar_gramatica/2,     % +Idioma, +Texto
    mostrar_estructura/2     % +Idioma, +Texto
]).

/* Importa el léxico y funciones auxiliares desde la base de datos.
   Nota: añadimos pron_feats/4 porque se usa para deducir persona/número
   a partir de pronombres del sujeto. */
:- use_module('base_datos.pl', [
    articulo/3, pronombre/3, sustantivo/3, adjetivo/3, preposicion/3,
    verbo/5, numeral/3, pron_feats/4
]).

:- set_prolog_flag(encoding, utf8).

/* Estas dos declaraciones evitan warnings porque las reglas DCG de
   oracion//2 y sintagma_verbal//3 están intercaladas (p. ej. preguntas
   antes que oraciones normales). */
:- discontiguous oracion/4.
:- discontiguous sintagma_verbal/5.

% ========================================
% GRAMÁTICA BNF PARA TRADUCCIÓN
% gramatica_bnf.pl (DCG)
% ========================================
% Gramática para oraciones simples (afirmativas, negativas y preguntas)
% en inglés y español, basada en un léxico (base_datos.pl).
% Se parsea a una estructura sintáctica canónica que luego usa el motor
% de traducción para mapear EN<->ES.
% ========================================

/*
------------- ESQUEMA EN BNF (documentación) -------------
<oracion> ::= <pregunta> | <sn> <sv>

<pregunta_en> ::= "do|does" <sn> <verbo_base> [<sn>]
                | <be> <sn> [<adjetivo>|<sn>]

<pregunta_es> ::= <verbo> <sn> [<sn>]

<sn> ::= <pron> | <sust> | <num> | <num> <sust>
       | <det> <sust>
       | <det> <num> <sust>
       | (en) <det> <adj> <sust>
       | (es) <det> <sust> <adj>

<sv> ::= <verbo>
       | <verbo> <sn>
       | <verbo> <prep> <sn>
       | <verbo> <adj>
       | (neg-es) "no" <verbo> [ ... ]
       | (neg-en) "do|does" "not" <verbo_base> [ ... ]
       | (neg-en-be) <be> "not" [ ... ]
-----------------------------------------------------------
*/

% ========================================
% PREGUNTAS SÍ/NO (sin signos)
% ========================================

% EN: do/does + SN + (base)verb
oracion(en, pregunta(SNsuj, sv(q_do(Form), verbo(base(Inf), Persona, Numero, Inf)))) -->
    [Aux], { aux_do(Aux, Form, Persona, Numero) },        % seleccionar 'do'/'does'
    sintagma_nominal(en, SNsuj),
    [Base], { base_english_verb(Base, Inf), \+ Inf = be }. % no cubre 'be' aquí

% EN: do/does + SN + (base)verb + SN (objeto)
oracion(en, pregunta(SNsuj, sv(q_do(Form), verbo(base(Inf), Persona, Numero, Inf), SN2))) -->
    [Aux], { aux_do(Aux, Form, Persona, Numero) },
    sintagma_nominal(en, SNsuj),
    [Base], { base_english_verb(Base, Inf), \+ Inf = be },
    sintagma_nominal(en, SN2).

% EN: 'be' + SN
oracion(en, pregunta(SNsuj, sv(q_be, verbo(Be, Persona, Numero, be)))) -->
    [Be], { verbo(en, Be, Persona, Numero, be) },
    sintagma_nominal(en, SNsuj).

% EN: 'be' + SN + Adj (p. ej. "Is she happy?")
oracion(en, pregunta(SNsuj, sv(q_be, verbo(Be, Persona, Numero, be), adj(Adj)))) -->
    [Be], { verbo(en, Be, Persona, Numero, be) },
    sintagma_nominal(en, SNsuj),
    [Adj], { es_adjetivo(en, Adj) }.

% EN: 'be' + SN + SN (p. ej. "Is she a teacher?")
oracion(en, pregunta(SNsuj, sv(q_be, verbo(Be, Persona, Numero, be), SNobj))) -->
    [Be], { verbo(en, Be, Persona, Numero, be) },
    sintagma_nominal(en, SNsuj),
    sintagma_nominal(en, SNobj).

% ES: inversión simple Verbo + SN (p. ej. "¿Hablas tú?")
oracion(es, pregunta(SNsuj, sv(q_es, verbo(Verbo, Persona, Numero, Inf)))) -->
    [Verbo], { verbo(es, Verbo, Persona, Numero, Inf) },
    sintagma_nominal(es, SNsuj).

% ES: Verbo + SN + SN (p. ej. "¿Eres tú profesor?")
oracion(es, pregunta(SNsuj, sv(q_es, verbo(Verbo, Persona, Numero, Inf), SN2))) -->
    [Verbo], { verbo(es, Verbo, Persona, Numero, Inf) },
    sintagma_nominal(es, SNsuj),
    sintagma_nominal(es, SN2).

% ========================================
% ORACIÓN NORMAL: SN + SV
% (IMPORTANTE: va después de las preguntas)
% ========================================
oracion(Idioma, oracion(SN, SV)) -->
    sintagma_nominal(Idioma, SN),
    sintagma_verbal(Idioma, SN, SV).

% ========================================
% SINTAGMA NOMINAL (SN)
% ========================================

% Pronombre (yo, tú / I, you, ...)
sintagma_nominal(Idioma, sn(pron(Pron))) -->
    [Pron], { es_pronombre(Idioma, Pron) }.

% Sustantivo solo (casa / house)
sintagma_nominal(Idioma, sn(sust(Sust))) -->
    [Sust], { es_sustantivo(Idioma, Sust) }.

% Número solo (dos / two)
sintagma_nominal(Idioma, sn(num(Num))) -->
    [Num], { es_numero(Idioma, Num) }.

% Número + Sustantivo (dos gatos / two cats)
sintagma_nominal(Idioma, sn(num(Num), sust(Sust))) -->
    [Num],  { es_numero(Idioma, Num)  },
    [Sust], { es_sustantivo(Idioma, Sust) }.

% Det + Número + Sustantivo (los dos gatos / the two cats)
sintagma_nominal(Idioma, sn(det(Det), num(Num), sust(Sust))) -->
    [Det], { es_determinante(Idioma, Det) },
    [Num], { es_numero(Idioma, Num) },
    [Sust], { es_sustantivo(Idioma, Sust) }.

% Det + Sust (el gato / the cat)
sintagma_nominal(Idioma, sn(det(Det), sust(Sust))) -->
    [Det],  { es_determinante(Idioma, Det) },
    [Sust], { es_sustantivo(Idioma, Sust) }.

% EN: Det + Adj + Sust (the big house)
sintagma_nominal(en, sn(det(Det), adj(Adj), sust(Sust))) -->
    [Det], { es_determinante(en, Det) },
    [Adj], { es_adjetivo(en, Adj) },
    [Sust], { es_sustantivo(en, Sust) }.

% ES: Det + Sust + Adj (la casa grande)
sintagma_nominal(es, sn(det(Det), sust(Sust), adj(Adj))) -->
    [Det],  { es_determinante(es, Det) },
    [Sust], { es_sustantivo(es, Sust) },
    [Adj],  { es_adjetivo(es, Adj) }.

% ========================================
% SINTAGMA VERBAL (SV)
% ========================================

% Verbo simple (concordando con el sujeto si es posible)
sintagma_verbal(Idioma, SN, sv(verbo(Verbo, Persona, Numero, Infinitivo))) -->
    [Verbo],
    {
      % Deducir persona/número del sujeto (SN) cuando se pueda
      sujeto_persona_numero(Idioma, SN, PersonaSN, NumeroSN),
      % Preferir la forma que concuerda con el sujeto; si no existe, usar cualquiera válida
      ( verbo(Idioma, Verbo, PersonaSN, NumeroSN, Infinitivo)
        -> Persona = PersonaSN, Numero = NumeroSN
        ;  verbo(Idioma, Verbo, Persona, Numero, Infinitivo)
      )
    }.

% Verbo + SN (objeto directo)
sintagma_verbal(Idioma, SNsubj, sv(verbo(Verbo, Persona, Numero, Infinitivo), SN)) -->
    [Verbo],
    {
      sujeto_persona_numero(Idioma, SNsubj, PersonaSN, NumeroSN),
      ( verbo(Idioma, Verbo, PersonaSN, NumeroSN, Infinitivo)
        -> Persona = PersonaSN, Numero = NumeroSN
        ;  verbo(Idioma, Verbo, Persona, Numero, Infinitivo)
      )
    },
    sintagma_nominal(Idioma, SN).

% Verbo + Prep + SN
sintagma_verbal(Idioma, SNsubj, sv(verbo(Verbo, Persona, Numero, Infinitivo), prep(Prep), SN)) -->
    [Verbo],
    {
      sujeto_persona_numero(Idioma, SNsubj, PersonaSN, NumeroSN),
      ( verbo(Idioma, Verbo, PersonaSN, NumeroSN, Infinitivo)
        -> Persona = PersonaSN, Numero = NumeroSN
        ;  verbo(Idioma, Verbo, Persona, Numero, Infinitivo)
      )
    },
    [Prep], { es_preposicion(Idioma, Prep) },
    sintagma_nominal(Idioma, SN).

% Verbo + Adjetivo (p. ej. "está feliz" / "is happy")
sintagma_verbal(Idioma, SNsubj, sv(verbo(Verbo, Persona, Numero, Infinitivo), adj(Adj))) -->
    [Verbo],
    {
      sujeto_persona_numero(Idioma, SNsubj, PersonaSN, NumeroSN),
      ( verbo(Idioma, Verbo, PersonaSN, NumeroSN, Infinitivo)
        -> Persona = PersonaSN, Numero = NumeroSN
        ;  verbo(Idioma, Verbo, Persona, Numero, Infinitivo)
      )
    },
    [Adj], { es_adjetivo(Idioma, Adj) }.

% -------- Deducción de persona/número del SUJETO --------
sujeto_persona_numero(Idioma, sn(pron(Pron)), Persona, Numero) :- !,
    % Usa rasgos del pronombre si existen; si no, cae a 3a sing.
    ( pron_feats(Idioma, Pron, Persona, Numero)
      -> true
      ;  Persona = tercera, Numero = singular
    ).
sujeto_persona_numero(_, sn(num(_)), tercera, plural) :- !.
sujeto_persona_numero(_, sn(num(_), sust(_)), tercera, plural) :- !.
sujeto_persona_numero(_, sn(det(_), num(_), sust(_)), tercera, plural) :- !.
sujeto_persona_numero(_, _SN, tercera, singular).

% ========================================
% NEGACIÓN
% ========================================

% ES:  "no" + Verbo
sintagma_verbal(es, _SNsubj, sv(neg, verbo(Verbo, Persona, Numero, Inf))) -->
    ['no'], [Verbo],
    { verbo(es, Verbo, Persona, Numero, Inf) }.

% ES:  "no" + Verbo + SN
sintagma_verbal(es, _SNsubj, sv(neg, verbo(Verbo, Persona, Numero, Inf), SN)) -->
    ['no'], [Verbo],
    { verbo(es, Verbo, Persona, Numero, Inf) },
    sintagma_nominal(es, SN).

% ES:  "no" + Verbo + Adjetivo
sintagma_verbal(es, _SNsubj, sv(neg, verbo(Verbo, Persona, Numero, Inf), adj(Adj))) -->
    ['no'], [Verbo],
    { verbo(es, Verbo, Persona, Numero, Inf) },
    [Adj], { es_adjetivo(es, Adj) }.

% ES:  "no" + Verbo + Prep + SN
sintagma_verbal(es, _SNsubj, sv(neg, verbo(Verbo, Persona, Numero, Inf), prep(Prep), SN)) -->
    ['no'], [Verbo],
    { verbo(es, Verbo, Persona, Numero, Inf) },
    [Prep], { es_preposicion(es, Prep) },
    sintagma_nominal(es, SN).

% EN (no 'be'):  do/does + not + base_verb
sintagma_verbal(en, _SNsubj, sv(neg_do(Form), verbo(base(Inf), Persona, Numero, Inf))) -->
    [Aux], { aux_do(Aux, Form, Persona, Numero) },
    ['not'],
    [Base], { base_english_verb(Base, Inf), \+ Inf = be }.

% EN (no 'be'):  do/does + not + base_verb + SN
sintagma_verbal(en, _SNsubj, sv(neg_do(Form), verbo(base(Inf), Persona, Numero, Inf), SNobj)) -->
    [Aux], { aux_do(Aux, Form, Persona, Numero) },
    ['not'],
    [Base], { base_english_verb(Base, Inf), \+ Inf = be },
    sintagma_nominal(en, SNobj).

% EN (no 'be'):  do/does + not + base_verb + Prep + SN
sintagma_verbal(en, _SNsubj, sv(neg_do(Form), verbo(base(Inf), Persona, Numero, Inf), prep(Prep), SNobj)) -->
    [Aux], { aux_do(Aux, Form, Persona, Numero) },
    ['not'],
    [Base], { base_english_verb(Base, Inf), \+ Inf = be },
    [Prep], { es_preposicion(en, Prep) },
    sintagma_nominal(en, SNobj).

% EN ('be'):  be + not
sintagma_verbal(en, _SNsubj, sv(neg_be, verbo(Be, Persona, Numero, be))) -->
    [Be], { verbo(en, Be, Persona, Numero, be) },
    ['not'].

% EN ('be'):  be + not + Adj
sintagma_verbal(en, _SNsubj, sv(neg_be, verbo(Be, Persona, Numero, be), adj(Adj))) -->
    [Be], { verbo(en, Be, Persona, Numero, be) },
    ['not'],
    [Adj], { es_adjetivo(en, Adj) }.

% EN ('be'):  be + not + SN
sintagma_verbal(en, _SNsubj, sv(neg_be, verbo(Be, Persona, Numero, be), SNobj)) -->
    [Be], { verbo(en, Be, Persona, Numero, be) },
    ['not'],
    sintagma_nominal(en, SNobj).

% ========================================
% AUXILIARES DCG
% ========================================

/* Selección de "do/does" según persona/número del sujeto (presente simple).
   Form = base (no 3a sing) | s3 (3a sing) */
aux_do('do',   base, Persona, plural)  :- member(Persona, [primera, segunda, tercera]).
aux_do('do',   base, Persona, singular):- member(Persona, [primera, segunda]).
aux_do('does', s3,   tercera, singular).

/* Verbo base inglés permitido por el léxico. W es el token de entrada,
   Inf es el infinitivo (átomo) que identificamos como base. */
base_english_verb(W, Inf) :-
    member(Inf, [run, eat, speak, have, sleep, be, go, see, do, say,
                 can, want, need, arrive, know, sing, dance, play,
                 listen, write, read, think, feel, work, help,
                 buy, sell, find, lose, walk, believe, understand,
                 decide, leave, open, close, cook, drink, draw,
                 give, receive, send]),
    W = Inf.

% ========================================
% PARSER PRINCIPAL (APIs del modulo)
% ========================================

/* parsear_bnf(+Idioma, +ListaPalabras, -Estructura)
   Aplica la DCG para obtener la estructura sintáctica. */
parsear_bnf(Idioma, ListaPalabras, Estructura) :-
    phrase(oracion(Idioma, Estructura), ListaPalabras).

/* parsear_oracion_bnf(+Idioma, +Texto, -Estructura)
   Divide el string en palabras, baja a minúsculas y llama a parsear_bnf/3. */
parsear_oracion_bnf(Idioma, OracionTexto, Estructura) :-
    atomic_list_concat(Palabras, ' ', OracionTexto),
    downcase_list(Palabras, PalabrasMin),
    parsear_bnf(Idioma, PalabrasMin, Estructura).

/* downcase_list(+ListaIn, -ListaOut)
   Normaliza cada token a minúsculas (átomos o strings). */
downcase_list([], []).
downcase_list([H|T], [H2|T2]) :-
    (   atom(H) -> downcase_atom(H, H2)
    ;   atom_string(AH, H), downcase_atom(AH, H2)
    ),
    downcase_list(T, T2).

% ========================================
% VALIDACIÓN / DEBUG
% ========================================

/* validar_gramatica(+Idioma, +Texto)
   Satisface si el texto se puede parsear con la gramática. */
validar_gramatica(Idioma, OracionTexto) :-
    parsear_oracion_bnf(Idioma, OracionTexto, _).

/* mostrar_estructura(+Idioma, +Texto)
   Imprime por consola la estructura sintáctica parseada (para depurar). */
mostrar_estructura(Idioma, OracionTexto) :-
    parsear_oracion_bnf(Idioma, OracionTexto, Estructura),
    writeln('Estructura sintáctica:'),
    write('  '), writeln(Estructura).

% ========================================
% PREDICADOS LÉXICO-AUXILIARES
% (puentes entre tokens y el léxico de base_datos.pl)
% ========================================

es_determinante(Idioma, Palabra) :- articulo(Idioma, Palabra, _).

es_pronombre(Idioma, Palabra) :- pronombre(Idioma, Palabra, _).

/* es_sustantivo/2
   1) Verifica literal en el léxico.
   2) Heurística simple de plural: si termina en 's', prueba sin 's'. */
es_sustantivo(Idioma, Palabra) :-
    sustantivo(Idioma, Palabra, _).
es_sustantivo(Idioma, Palabra) :-
    atom_concat(Stem, 's', Palabra),
    Stem \= '',
    sustantivo(Idioma, Stem, _).

es_adjetivo(Idioma, Palabra) :- adjetivo(Idioma, Palabra, _).

es_preposicion(Idioma, Palabra) :- preposicion(Idioma, Palabra, _).

% ¿Es un numeral reconocido en el léxico?
es_numero(Idioma, Palabra) :- numeral(Idioma, Palabra, _).
