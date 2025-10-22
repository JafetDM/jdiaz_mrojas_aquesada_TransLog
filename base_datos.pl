:- module(base_datos,
  [ traduccion_verbo/2, verbo/5, traducir/3
  , articulo/3, pronombre/3, sustantivo/3, adjetivo/3, preposicion/3
  , sinonimo/3
  ]).
:- set_prolog_flag(encoding, utf8).

% ========================================
% BASE DE DATOS TRADUCTOR INGLÉS-ESPAÑOL
% ========================================

% -------------------------
% ARTÍCULOS / DETERMINANTES
% -------------------------
articulo(en, 'the', 'el').
articulo(en, 'the', 'la').
articulo(en, 'the', 'los').
articulo(en, 'the', 'las').
articulo(en, 'a',   'un').
articulo(en, 'a',   'una').
articulo(en, 'an',  'un').
articulo(en, 'an',  'una').
articulo(en, 'some','unos').
articulo(en, 'some','unas').

articulo(es, 'el',   'the').
articulo(es, 'la',   'the').
articulo(es, 'los',  'the').
articulo(es, 'las',  'the').
articulo(es, 'un',   'a').
articulo(es, 'una',  'a').
articulo(es, 'unos', 'some').
articulo(es, 'unas', 'some').

% -------------------------
% PRONOMBRES
% -------------------------
pronombre(en, 'I', 'yo').
pronombre(en, 'i', 'yo').
pronombre(en, 'you', 'tú').
pronombre(en, 'he', 'él').
pronombre(en, 'she', 'ella').
pronombre(en, 'it', 'eso').
pronombre(en, 'we', 'nosotros').
pronombre(en, 'they', 'ellos').

pronombre(es, 'yo', 'i').
pronombre(es, 'tú', 'you').
pronombre(es, 'él', 'he').
pronombre(es, 'ella', 'she').
pronombre(es, 'eso', 'it').
pronombre(es, 'nosotros', 'we').
pronombre(es, 'ellos', 'they').

% -------------------------
% SUSTANTIVOS 
% -------------------------
sustantivo(en, 'cat', 'gato').
sustantivo(en, 'dog', 'perro').
sustantivo(en, 'house', 'casa').
sustantivo(en, 'home', 'hogar').
sustantivo(en, 'car', 'coche').
sustantivo(en, 'book', 'libro').
sustantivo(en, 'table', 'mesa').
sustantivo(en, 'chair', 'silla').
sustantivo(en, 'water', 'agua').
sustantivo(en, 'food', 'comida').
sustantivo(en, 'friend', 'amigo').
sustantivo(en, 'mother', 'madre').
sustantivo(en, 'father', 'padre').
sustantivo(en, 'sister', 'hermana').
sustantivo(en, 'brother', 'hermano').
sustantivo(en, 'school', 'escuela').
sustantivo(en, 'city', 'ciudad').
sustantivo(en, 'country', 'país').
sustantivo(en, 'tree', 'árbol').
sustantivo(en, 'flower', 'flor').
sustantivo(en, 'day', 'día').
sustantivo(en, 'night', 'noche').
sustantivo(en, 'street', 'calle').
sustantivo(en, 'road', 'carretera').
sustantivo(en, 'computer', 'computadora').
sustantivo(en, 'phone', 'teléfono').
sustantivo(en, 'music', 'música').
sustantivo(en, 'movie', 'película').
sustantivo(en, 'work', 'trabajo').
sustantivo(en, 'game', 'juego').

sustantivo(es, 'gato', 'cat').
sustantivo(es, 'perro', 'dog').
sustantivo(es, 'casa', 'house').
sustantivo(es, 'hogar', 'home').
sustantivo(es, 'coche', 'car').
sustantivo(es, 'carro', 'car').
sustantivo(es, 'auto', 'car').
sustantivo(es, 'libro', 'book').
sustantivo(es, 'mesa', 'table').
sustantivo(es, 'silla', 'chair').
sustantivo(es, 'agua', 'water').
sustantivo(es, 'comida', 'food').
sustantivo(es, 'amigo', 'friend').
sustantivo(es, 'madre', 'mother').
sustantivo(es, 'padre', 'father').
sustantivo(es, 'hermana', 'sister').
sustantivo(es, 'hermano', 'brother').
sustantivo(es, 'escuela', 'school').
sustantivo(es, 'ciudad', 'city').
sustantivo(es, 'país', 'country').
sustantivo(es, 'árbol', 'tree').
sustantivo(es, 'flor', 'flower').
sustantivo(es, 'día', 'day').
sustantivo(es, 'noche', 'night').
sustantivo(es, 'calle', 'street').
sustantivo(es, 'carretera', 'road').
sustantivo(es, 'computadora', 'computer').
sustantivo(es, 'teléfono', 'phone').
sustantivo(es, 'música', 'music').
sustantivo(es, 'película', 'movie').
sustantivo(es, 'trabajo', 'work').
sustantivo(es, 'juego', 'game').

% -------------------------
% VERBOS (presente) + mapeo de infinitivos
% -------------------------
traduccion_verbo(correr, run).
traduccion_verbo(comer,  eat).
traduccion_verbo(hablar, speak).
traduccion_verbo(ser,    be).
traduccion_verbo(estar,  be).
traduccion_verbo(tener,  have).
traduccion_verbo(dormir, sleep).

% ESP: correr
verbo(es, 'corro',    primera, singular, 'correr').
verbo(es, 'corres',   segunda, singular, 'correr').
verbo(es, 'corre',    tercera, singular, 'correr').
verbo(es, 'corremos', primera, plural,   'correr').
verbo(es, 'corréis',  segunda, plural,   'correr').
verbo(es, 'corren',   tercera, plural,   'correr').

% EN: run
verbo(en, 'run',  primera, singular, 'run').
verbo(en, 'run',  segunda, singular, 'run').
verbo(en, 'runs', tercera, singular, 'run').
verbo(en, 'run',  primera, plural,   'run').
verbo(en, 'run',  segunda, plural,   'run').
verbo(en, 'run',  tercera, plural,   'run').

% ESP: hablar
verbo(es, 'hablo',    primera, singular, 'hablar').
verbo(es, 'hablas',   segunda, singular, 'hablar').
verbo(es, 'habla',    tercera, singular, 'hablar').
verbo(es, 'hablamos', primera, plural,   'hablar').
verbo(es, 'habláis',  segunda, plural,   'hablar').
verbo(es, 'hablan',   tercera, plural,   'hablar').

% EN: speak
verbo(en, 'speak',  primera, singular, 'speak').
verbo(en, 'speak',  segunda, singular, 'speak').
verbo(en, 'speaks', tercera, singular, 'speak').
verbo(en, 'speak',  primera, plural,   'speak').
verbo(en, 'speak',  segunda, plural,   'speak').
verbo(en, 'speak',  tercera, plural,   'speak').

% ESP: comer
verbo(es, 'como',    primera, singular, 'comer').
verbo(es, 'comes',   segunda, singular, 'comer').
verbo(es, 'come',    tercera, singular, 'comer').
verbo(es, 'comemos', primera, plural,   'comer').
verbo(es, 'coméis',  segunda, plural,   'comer').
verbo(es, 'comen',   tercera, plural,   'comer').

% EN: eat
verbo(en, 'eat',  primera, singular, 'eat').
verbo(en, 'eat',  segunda, singular, 'eat').
verbo(en, 'eats', tercera, singular, 'eat').
verbo(en, 'eat',  primera, plural,   'eat').
verbo(en, 'eat',  segunda, plural,   'eat').
verbo(en, 'eat',  tercera, plural,   'eat').

% ESP: tener
verbo(es, 'tengo',   primera, singular, 'tener').
verbo(es, 'tienes',  segunda, singular, 'tener').
verbo(es, 'tiene',   tercera, singular, 'tener').
verbo(es, 'tenemos', primera, plural,   'tener').
verbo(es, 'tenéis',  segunda, plural,   'tener').
verbo(es, 'tienen',  tercera, plural,   'tener').

% EN: have
verbo(en, 'have',  primera, singular, 'have').
verbo(en, 'have',  segunda, singular, 'have').
verbo(en, 'has',   tercera, singular, 'have').
verbo(en, 'have',  primera, plural,   'have').
verbo(en, 'have',  segunda, plural,   'have').
verbo(en, 'have',  tercera, plural,   'have').

% ESP: dormir
verbo(es, 'duermo',   primera, singular, 'dormir').
verbo(es, 'duermes',  segunda, singular, 'dormir').
verbo(es, 'duerme',   tercera, singular, 'dormir').
verbo(es, 'dormimos', primera, plural,   'dormir').
verbo(es, 'dormís',   segunda, plural,   'dormir').
verbo(es, 'duermen',  tercera, plural,   'dormir').

% EN: sleep
verbo(en, 'sleep',  primera, singular, 'sleep').
verbo(en, 'sleep',  segunda, singular, 'sleep').
verbo(en, 'sleeps', tercera, singular, 'sleep').
verbo(en, 'sleep',  primera, plural,   'sleep').
verbo(en, 'sleep',  segunda, plural,   'sleep').
verbo(en, 'sleep',  tercera, plural,   'sleep').

% ESP: ser
verbo(es, 'soy',    primera, singular, 'ser').
verbo(es, 'eres',   segunda, singular, 'ser').
verbo(es, 'es',     tercera, singular, 'ser').
verbo(es, 'somos',  primera, plural,   'ser').
verbo(es, 'sois',   segunda, plural,   'ser').
verbo(es, 'son',    tercera, plural,   'ser').

% ESP: estar
verbo(es, 'estoy',   primera, singular, 'estar').
verbo(es, 'estás',   segunda, singular, 'estar').
verbo(es, 'está',    tercera, singular, 'estar').
verbo(es, 'estamos', primera, plural,   'estar').
verbo(es, 'estáis',  segunda, plural,   'estar').
verbo(es, 'están',   tercera, plural,   'estar').

% EN: be
verbo(en, 'am',  primera, singular, 'be').
verbo(en, 'are', segunda, singular, 'be').
verbo(en, 'is',  tercera, singular,  'be').
verbo(en, 'are', primera, plural,    'be').
verbo(en, 'are', segunda, plural,    'be').
verbo(en, 'are', tercera, plural,    'be').

% -------------------------
% ADJETIVOS 
% -------------------------
adjetivo(en, 'big', 'grande').
adjetivo(en, 'large', 'grande').
adjetivo(en, 'huge', 'enorme').
adjetivo(en, 'small', 'pequeño').
adjetivo(en, 'little', 'pequeño').
adjetivo(en, 'good', 'bueno').
adjetivo(en, 'bad', 'malo').
adjetivo(en, 'happy', 'feliz').
adjetivo(en, 'sad', 'triste').
adjetivo(en, 'hot', 'caliente').
adjetivo(en, 'cold', 'frío').
adjetivo(en, 'fast', 'rápido').
adjetivo(en, 'slow', 'lento').
adjetivo(en, 'new', 'nuevo').
adjetivo(en, 'old', 'viejo').
adjetivo(en, 'beautiful', 'hermoso').
adjetivo(en, 'ugly', 'feo').
adjetivo(en, 'easy', 'fácil').
adjetivo(en, 'difficult', 'difícil').

adjetivo(es, 'grande', 'big').
adjetivo(es, 'enorme', 'huge').
adjetivo(es, 'pequeño', 'small').
adjetivo(es, 'chico', 'small').
adjetivo(es, 'bueno', 'good').
adjetivo(es, 'malo', 'bad').
adjetivo(es, 'feliz', 'happy').
adjetivo(es, 'contento', 'happy').
adjetivo(es, 'triste', 'sad').
adjetivo(es, 'caliente', 'hot').
adjetivo(es, 'frío', 'cold').
adjetivo(es, 'rápido', 'fast').
adjetivo(es, 'lento', 'slow').
adjetivo(es, 'nuevo', 'new').
adjetivo(es, 'viejo', 'old').
adjetivo(es, 'hermoso', 'beautiful').
adjetivo(es, 'bonito', 'beautiful').
adjetivo(es, 'feo', 'ugly').
adjetivo(es, 'fácil', 'easy').
adjetivo(es, 'difícil', 'difficult').

% -------------------------
% PREPOSICIONES
% -------------------------
preposicion(en, 'in', 'en').
preposicion(en, 'on', 'sobre').
preposicion(en, 'at', 'en').
preposicion(en, 'to', 'a').
preposicion(en, 'from', 'de').
preposicion(en, 'with', 'con').
preposicion(en, 'for', 'para').
preposicion(en, 'by', 'por').
preposicion(en, 'about', 'sobre').
preposicion(en, 'under', 'debajo de').
preposicion(en, 'over', 'sobre').
preposicion(en, 'between', 'entre').

preposicion(es, 'en', 'in').
preposicion(es, 'sobre', 'on').
preposicion(es, 'a', 'to').
preposicion(es, 'de', 'from').
preposicion(es, 'con', 'with').
preposicion(es, 'para', 'for').
preposicion(es, 'por', 'by').
preposicion(es, 'debajo de', 'under').
preposicion(es, 'entre', 'between').

% -------------------------
% SINÓNIMOS (normalización en la MISMA lengua)
%  sinonimo(Idioma, Variante, FormaBase)
%  Se usan SOLO para redirigir al léxico principal.
% -------------------------
% EN sustantivos
sinonimo(en, 'automobile', 'car').
sinonimo(en, 'auto',       'car').
sinonimo(en, 'vehicle',    'car').
sinonimo(en, 'cellphone',  'phone').
sinonimo(en, 'mobile',     'phone').
sinonimo(en, 'movie',      'film').      
sinonimo(en, 'film',       'movie').
sinonimo(en, 'workplace',  'work').
sinonimo(en, 'job',        'work').
sinonimo(en, 'friendship', 'friend').    

% EN adjetivos
sinonimo(en, 'huge',   'large').
sinonimo(en, 'tiny',   'small').
sinonimo(en, 'glad',   'happy').
sinonimo(en, 'unhappy','sad').
sinonimo(en, 'pretty', 'beautiful').
sinonimo(en, 'handsome','beautiful').

% ES sustantivos
sinonimo(es, 'carro',     'coche').
sinonimo(es, 'auto',      'coche').
sinonimo(es, 'computador','computadora').
sinonimo(es, 'celular',   'teléfono').
sinonimo(es, 'pelicula',  'película').
sinonimo(es, 'cine',      'película').
sinonimo(es, 'vivienda',  'casa').
sinonimo(es, 'hogar',     'casa').
sinonimo(es, 'alimento',  'comida').

% ES adjetivos
sinonimo(es, 'enorme', 'grande').
sinonimo(es, 'chico',  'pequeño').
sinonimo(es, 'contento','feliz').
sinonimo(es, 'apenado','triste').
sinonimo(es, 'bonito', 'hermoso').

% ===================================================
% TRADUCCIÓN LÉXICA BÁSICA (usa sinónimos primero)
% traducir(+Idioma, +Palabra, -Traducción)
% ===================================================
traducir(Idioma, Palabra, Traduccion) :-
    sinonimo(Idioma, Palabra, Base), !,
    traducir(Idioma, Base, Traduccion).
traducir(Idioma, Palabra, Traduccion) :- articulo(Idioma, Palabra, Traduccion), !.
traducir(Idioma, Palabra, Traduccion) :- pronombre(Idioma, Palabra, Traduccion), !.
traducir(Idioma, Palabra, Traduccion) :- sustantivo(Idioma, Palabra, Traduccion), !.
traducir(Idioma, Palabra, Traduccion) :- adjetivo(Idioma, Palabra, Traduccion), !.
traducir(Idioma, Palabra, Traduccion) :- preposicion(Idioma, Palabra, Traduccion), !.
traducir(_, Palabra, Palabra).
