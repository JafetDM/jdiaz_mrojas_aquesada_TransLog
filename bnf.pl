:- module(bnf_parser, [parsear_oracion_bnf/3, parsear_bnf/3, validar_gramatica/2, mostrar_estructura/2]).
:- use_module('base_datos.pl', [articulo/3, pronombre/3, sustantivo/3, adjetivo/3, preposicion/3, verbo/5]).
:- set_prolog_flag(encoding, utf8).
:- discontiguous oracion/4.
:- discontiguous sintagma_verbal/5.

% ========================================
% GRAMÁTICA BNF PARA TRADUCCIÓN
% gramatica_bnf.pl
% ========================================
% 
% Definición formal de la gramática en BNF para
% oraciones simples en inglés y español
% ========================================

% ========================================
% BNF - BACKUS-NAUR FORM
% ========================================

/*
GRAMÁTICA FORMAL EN BNF:

<oracion> ::= <sintagma_nominal> <sintagma_verbal>

<sintagma_nominal> ::= <determinante> <sustantivo>
                     | <determinante> <adjetivo> <sustantivo>      (inglés)
                     | <determinante> <sustantivo> <adjetivo>      (español)
                     | <pronombre>
                     | <sustantivo>

<sintagma_verbal> ::= <verbo>
                    | <verbo> <sintagma_nominal>
                    | <verbo> <preposicion> <sintagma_nominal>
                    | <verbo> <adjetivo>

<determinante> ::= "the" | "a" | "an" | "el" | "la" | "los" | "las" | "un" | "una"

<pronombre> ::= "I" | "you" | "he" | "she" | "it" | "we" | "they"
              | "yo" | "tú" | "él" | "ella" | "eso" | "nosotros" | "ellos"

<sustantivo> ::= "cat" | "dog" | "house" | "book" | ... 
               | "gato" | "perro" | "casa" | "libro" | ...

<verbo> ::= <forma_conjugada>

<adjetivo> ::= "big" | "small" | "good" | "bad" | ...
             | "grande" | "pequeño" | "bueno" | "malo" | ...

<preposicion> ::= "in" | "on" | "at" | "to" | "from" | "with" | "for"
                | "en" | "sobre" | "a" | "de" | "con" | "para"
*/

% ========================================
% IMPLEMENTACIÓN DE LA GRAMÁTICA BNF
% Usando DCG (Definite Clause Grammar)
% ========================================

% ORACIÓN: SN + SV
% ahora pasamos el SN al SV para que el verbo pueda concordar en
% persona/número con el sujeto (especialmente pronombres)
oracion(Idioma, oracion(SN, SV)) -->
    sintagma_nominal(Idioma, SN),
    sintagma_verbal(Idioma, SN, SV).

% ========================================
% SINTAGMA NOMINAL
% ========================================

% SN: Pronombre
sintagma_nominal(Idioma, sn(pron(Pron))) -->
    [Pron],
    { es_pronombre(Idioma, Pron) }.

% SN: Sustantivo solo
sintagma_nominal(Idioma, sn(sust(Sust))) -->
    [Sust],
    { es_sustantivo(Idioma, Sust) }.

% SN: Número solo (e.g., 'two')
sintagma_nominal(Idioma, sn(num(Num))) -->
    [Num],
    { es_numero(Idioma, Num) }.

% SN: Número + Sustantivo (e.g., 'two cats')
sintagma_nominal(Idioma, sn(num(Num), sust(Sust))) -->
    [Num], { es_numero(Idioma, Num) },
    [Sust], { es_sustantivo(Idioma, Sust) }.

% SN: Det + Número + Sustantivo (e.g., 'the two cats')
sintagma_nominal(Idioma, sn(det(Det), num(Num), sust(Sust))) -->
    [Det], { es_determinante(Idioma, Det) },
    [Num], { es_numero(Idioma, Num) },
    [Sust], { es_sustantivo(Idioma, Sust) }.

% SN: Det + Sust
sintagma_nominal(Idioma, sn(det(Det), sust(Sust))) -->
    [Det], { es_determinante(Idioma, Det) },
    [Sust], { es_sustantivo(Idioma, Sust) }.

% SN: Det + Adj + Sust (INGLÉS)
sintagma_nominal(en, sn(det(Det), adj(Adj), sust(Sust))) -->
    [Det], { es_determinante(en, Det) },
    [Adj], { es_adjetivo(en, Adj) },
    [Sust], { es_sustantivo(en, Sust) }.

% SN: Det + Sust + Adj (ESPAÑOL)
sintagma_nominal(es, sn(det(Det), sust(Sust), adj(Adj))) -->
    [Det], { es_determinante(es, Det) },
    [Sust], { es_sustantivo(es, Sust) },
    [Adj], { es_adjetivo(es, Adj) }.

% ========================================
% SINTAGMA VERBAL
% ========================================

% SV: Verbo simple
sintagma_verbal(Idioma, SN, sv(verbo(Verbo, Persona, Numero, Infinitivo))) -->
        [Verbo],
        { % intentar deducir persona/numero a partir del sujeto cuando sea posible
            sujeto_persona_numero(Idioma, SN, PersonaSN, NumeroSN),
            % preferir la concordancia con el sujeto; si no existe esa forma,
            % caer atrás a cualquier forma conocida del verbo
            ( verbo(Idioma, Verbo, PersonaSN, NumeroSN, Infinitivo)
            -> Persona = PersonaSN, Numero = NumeroSN
            ; verbo(Idioma, Verbo, Persona, Numero, Infinitivo)
            )
        }.

% SV: Verbo + SN (objeto directo)
sintagma_verbal(Idioma, SNsubj, sv(verbo(Verbo, Persona, Numero, Infinitivo), SN)) -->
        [Verbo],
        { sujeto_persona_numero(Idioma, SNsubj, PersonaSN, NumeroSN),
            ( verbo(Idioma, Verbo, PersonaSN, NumeroSN, Infinitivo)
            -> Persona = PersonaSN, Numero = NumeroSN
            ; verbo(Idioma, Verbo, Persona, Numero, Infinitivo)
            )
        },
        sintagma_nominal(Idioma, SN).

% SV: Verbo + Prep + SN
sintagma_verbal(Idioma, SNsubj, sv(verbo(Verbo, Persona, Numero, Infinitivo), prep(Prep), SN)) -->
        [Verbo],
        { sujeto_persona_numero(Idioma, SNsubj, PersonaSN, NumeroSN),
            ( verbo(Idioma, Verbo, PersonaSN, NumeroSN, Infinitivo)
            -> Persona = PersonaSN, Numero = NumeroSN
            ; verbo(Idioma, Verbo, Persona, Numero, Infinitivo)
            )
        },
        [Prep], { es_preposicion(Idioma, Prep) },
        sintagma_nominal(Idioma, SN).

% SV: Verbo + Adj
sintagma_verbal(Idioma, SNsubj, sv(verbo(Verbo, Persona, Numero, Infinitivo), adj(Adj))) -->
        [Verbo],
        { sujeto_persona_numero(Idioma, SNsubj, PersonaSN, NumeroSN),
            ( verbo(Idioma, Verbo, PersonaSN, NumeroSN, Infinitivo)
            -> Persona = PersonaSN, Numero = NumeroSN
            ; verbo(Idioma, Verbo, Persona, Numero, Infinitivo)
            )
        },
        [Adj], { es_adjetivo(Idioma, Adj) }.

% Helper: obtener persona/numero a partir del sujeto (SN)
sujeto_persona_numero(Idioma, sn(pron(Pron)), Persona, Numero) :- !,
        % pronombres y rasgos ya están en la base (pron_feats) y en minúsculas
        ( pron_feats(Idioma, Pron, Persona, Numero) -> true
        ; % fallback si no hay features registrados
            Persona = tercera, Numero = singular
        ).
sujeto_persona_numero(_, sn(num(_)), tercera, plural) :- !.
sujeto_persona_numero(_, sn(num(_), sust(_)), tercera, plural) :- !.
sujeto_persona_numero(_, sn(det(_), num(_), sust(_)), tercera, plural) :- !.
sujeto_persona_numero(_, _SN, tercera, singular).

% =========================
% NEGACIÓN
% =========================
% ES:  SN + "no" + Verbo (+ SN/Adj/Prep ...)
% ahora las reglas aceptan el sujeto (SNsubj) como primer argumento
sintagma_verbal(es, _SNsubj, sv(neg, verbo(Verbo,Persona,Numero,Inf))) -->
    ['no'], [Verbo],
    { verbo(es, Verbo, Persona, Numero, Inf) }.

sintagma_verbal(es, _SNsubj, sv(neg, verbo(Verbo,Persona,Numero,Inf), SN)) -->
    ['no'], [Verbo],
    { verbo(es, Verbo, Persona, Numero, Inf) },
    sintagma_nominal(es, SN).

sintagma_verbal(es, _SNsubj, sv(neg, verbo(Verbo,Persona,Numero,Inf), adj(Adj))) -->
    ['no'], [Verbo],
    { verbo(es, Verbo, Persona, Numero, Inf) },
    [Adj], { es_adjetivo(es, Adj) }.

sintagma_verbal(es, _SNsubj, sv(neg, verbo(Verbo,Persona,Numero,Inf), prep(Prep), SN)) -->
    ['no'], [Verbo],
    { verbo(es, Verbo, Persona, Numero, Inf) },
    [Prep], { es_preposicion(es, Prep) },
    sintagma_nominal(es, SN).

% EN:  do/does + not + (base)verb (+ SN/Adj/Prep ...)
%     Caso general (no 'be')
sintagma_verbal(en, _SNsubj, sv(neg_do(Form), verbo(base(Inf),Persona,Numero,Inf))) -->
    [Aux], { aux_do(Aux, Form, Persona, Numero) },
    ['not'],
    [Base],
    { base_english_verb(Base, Inf), \+ Inf = be }.

sintagma_verbal(en, _SNsubj, sv(neg_do(Form), verbo(base(Inf),Persona,Numero,Inf), SNobj)) -->
    [Aux], { aux_do(Aux, Form, Persona, Numero) },
    ['not'],
    [Base], { base_english_verb(Base, Inf), \+ Inf = be },
    sintagma_nominal(en, SNobj).

sintagma_verbal(en, _SNsubj, sv(neg_do(Form), verbo(base(Inf),Persona,Numero,Inf), prep(Prep), SNobj)) -->
    [Aux], { aux_do(Aux, Form, Persona, Numero) },
    ['not'],
    [Base], { base_english_verb(Base, Inf), \+ Inf = be },
    [Prep], { es_preposicion(en, Prep) },
    sintagma_nominal(en, SNobj).

% EN:  'be' + not (+ Adj / + SN)
sintagma_verbal(en, _SNsubj, sv(neg_be, verbo(Be,Persona,Numero,be))) -->
    [Be], { verbo(en, Be, Persona, Numero, be) },
    ['not'].

sintagma_verbal(en, _SNsubj, sv(neg_be, verbo(Be,Persona,Numero,be), adj(Adj))) -->
    [Be], { verbo(en, Be, Persona, Numero, be) },
    ['not'],
    [Adj], { es_adjetivo(en, Adj) }.

sintagma_verbal(en, _SNsubj, sv(neg_be, verbo(Be,Persona,Numero,be), SNobj)) -->
    [Be], { verbo(en, Be, Persona, Numero, be) },
    ['not'],
    sintagma_nominal(en, SNobj).

% =========================
% PREGUNTAS SÍ/NO (sin signo)
% =========================
% EN: do/does + SN + (base)verb (+ SN)
oracion(en, pregunta(sn(SN), sv(q_do(Form), verbo(base(Inf),Persona,Numero,Inf)))) -->
    [Aux], { aux_do(Aux, Form, Persona, Numero) },
    sintagma_nominal(en, SN),
    [Base], { base_english_verb(Base, Inf), \+ Inf = be }.

oracion(en, pregunta(sn(SN), sv(q_do(Form), verbo(base(Inf),Persona,Numero,Inf), SN2))) -->
    [Aux], { aux_do(Aux, Form, Persona, Numero) },
    sintagma_nominal(en, SN),
    [Base], { base_english_verb(Base, Inf), \+ Inf = be },
    sintagma_nominal(en, SN2).

% EN: 'be' + SN (+ Adj / + SN)   e.g., "is she happy"
oracion(en, pregunta(sn(SN), sv(q_be, verbo(Be,Persona,Numero,be)))) -->
    [Be], { verbo(en, Be, Persona, Numero, be) },
    sintagma_nominal(en, SN).

oracion(en, pregunta(sn(SN), sv(q_be, verbo(Be,Persona,Numero,be), adj(Adj)))) -->
    [Be], { verbo(en, Be, Persona, Numero, be) },
    sintagma_nominal(en, SN),
    [Adj], { es_adjetivo(en, Adj) }.

% ES: inversión simple Verbo + SN   e.g., "come ella comida"
oracion(es, pregunta(sn(SN), sv(q_es, verbo(Verbo,Persona,Numero,Inf)))) -->
    [Verbo], { verbo(es, Verbo, Persona, Numero, Inf) },
    sintagma_nominal(es, SN).

oracion(es, pregunta(sn(SN), sv(q_es, verbo(Verbo,Persona,Numero,Inf), SN2))) -->
    [Verbo], { verbo(es, Verbo, Persona, Numero, Inf) },
    sintagma_nominal(es, SN),
    sintagma_nominal(es, SN2).

% ====== Auxiliares de la DCG ======
% do/does según persona/número (presente)
aux_do('do',   base,  Persona, plural)  :- member(Persona,[primera,segunda,tercera]).
aux_do('do',   base,  Persona, singular):- member(Persona,[primera,segunda]).
aux_do('does', s3,    tercera, singular).

% Base verbal inglesa conocida (infinitivo “texto”)
base_english_verb(W, Inf) :- member(Inf,[run,eat,speak,have,sleep,be]), atom_string(Inf,W).

% ========================================
% PARSER PRINCIPAL CON BNF
% ========================================

% Parsear usando la gramática BNF
parsear_bnf(Idioma, ListaPalabras, Estructura) :-
    phrase(oracion(Idioma, Estructura), ListaPalabras).

% Parsear desde string
parsear_oracion_bnf(Idioma, OracionTexto, Estructura) :-
    atomic_list_concat(Palabras, ' ', OracionTexto),
    downcase_list(Palabras, PalabrasMin),
    parsear_bnf(Idioma, PalabrasMin, Estructura).

% downcase_list(+ListaIn, -ListaOut) - bajar a minúsculas cada átomo/string
downcase_list([], []).
downcase_list([H|T], [H2|T2]) :-
    (   atom(H) -> downcase_atom(H, H2)
    ;   atom_string(AH, H), downcase_atom(AH, H2)
    ),
    downcase_list(T, T2).

% ========================================
% VALIDACIÓN DE GRAMÁTICA
% ========================================

% Verificar si una oración es gramaticalmente válida
validar_gramatica(Idioma, OracionTexto) :-
    parsear_oracion_bnf(Idioma, OracionTexto, _).

% Mostrar estructura sintáctica
mostrar_estructura(Idioma, OracionTexto) :-
    parsear_oracion_bnf(Idioma, OracionTexto, Estructura),
    writeln('Estructura sintáctica:'),
    write('  '), writeln(Estructura).

% ========================================
% PREDICADOS AUXILIARES
% ========================================

es_determinante(Idioma, Palabra) :- articulo(Idioma, Palabra, _).
es_pronombre(Idioma, Palabra) :- pronombre(Idioma, Palabra, _).
es_sustantivo(Idioma, Palabra) :- sustantivo(Idioma, Palabra, _).
% simple plural heuristic: if word ends with 's' try stem without 's'
es_sustantivo(Idioma, Palabra) :-
    atom_concat(Stem, 's', Palabra),
    Stem \= '',
    sustantivo(Idioma, Stem, _).
es_adjetivo(Idioma, Palabra) :- adjetivo(Idioma, Palabra, _).
es_preposicion(Idioma, Palabra) :- preposicion(Idioma, Palabra, _).

% números
es_numero(Idioma, Palabra) :- numeral(Idioma, Palabra, _).

% ========================================
% EJEMPLOS DE USO
% ========================================

/*
?- parsear_oracion_bnf(en, 'the cat runs', E).
E = oracion(sn(det(the), sust(cat)), sv(verbo(runs, tercera, singular, run))).

?- parsear_oracion_bnf(es, 'el gato corre', E).
E = oracion(sn(det(el), sust(gato)), sv(verbo(corre, tercera, singular, correr))).

?- validar_gramatica(en, 'the cat runs').
true.

?- mostrar_estructura(en, 'the big cat runs').
Estructura sintáctica:
  oracion(sn(det(the), adj(big), sust(cat)), sv(verbo(runs, tercera, singular, run)))
*/