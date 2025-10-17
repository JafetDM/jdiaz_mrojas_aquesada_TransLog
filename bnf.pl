:- module(bnf_parser, [parsear_oracion_bnf/3, parsear_bnf/3, validar_gramatica/2, mostrar_estructura/2]).
:- use_module('base_datos.pl', [articulo/3, pronombre/3, sustantivo/3, adjetivo/3, preposicion/3, verbo/5]).

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
oracion(Idioma, oracion(SN, SV)) -->
    sintagma_nominal(Idioma, SN),
    sintagma_verbal(Idioma, SV).

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
sintagma_verbal(Idioma, sv(verbo(Verbo, Persona, Numero, Infinitivo))) -->
    [Verbo],
    { verbo(Idioma, Verbo, Persona, Numero, Infinitivo) }.

% SV: Verbo + SN (objeto directo)
sintagma_verbal(Idioma, sv(verbo(Verbo, Persona, Numero, Infinitivo), SN)) -->
    [Verbo], { verbo(Idioma, Verbo, Persona, Numero, Infinitivo) },
    sintagma_nominal(Idioma, SN).

% SV: Verbo + Prep + SN
sintagma_verbal(Idioma, sv(verbo(Verbo, Persona, Numero, Infinitivo), prep(Prep), SN)) -->
    [Verbo], { verbo(Idioma, Verbo, Persona, Numero, Infinitivo) },
    [Prep], { es_preposicion(Idioma, Prep) },
    sintagma_nominal(Idioma, SN).

% SV: Verbo + Adj
sintagma_verbal(Idioma, sv(verbo(Verbo, Persona, Numero, Infinitivo), adj(Adj))) -->
    [Verbo], { verbo(Idioma, Verbo, Persona, Numero, Infinitivo) },
    [Adj], { es_adjetivo(Idioma, Adj) }.

% ========================================
% PARSER PRINCIPAL CON BNF
% ========================================

% Parsear usando la gramática BNF
parsear_bnf(Idioma, ListaPalabras, Estructura) :-
    phrase(oracion(Idioma, Estructura), ListaPalabras).

% Parsear desde string
parsear_oracion_bnf(Idioma, OracionTexto, Estructura) :-
    atomic_list_concat(Palabras, ' ', OracionTexto),
    maplist(downcase_atom, Palabras, PalabrasMin),
    parsear_bnf(Idioma, PalabrasMin, Estructura).

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
es_adjetivo(Idioma, Palabra) :- adjetivo(Idioma, Palabra, _).
es_preposicion(Idioma, Palabra) :- preposicion(Idioma, Palabra, _).

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