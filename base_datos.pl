% ========================================
% BASE DE DATOS TRADUCTOR INGLÉS-ESPAÑOL
% ========================================

% ARTÍCULOS
% articulo(Idioma, Palabra, Traducción)
articulo(en, 'the', 'el').
articulo(en, 'the', 'la').
articulo(en, 'the', 'los').
articulo(en, 'the', 'las').
articulo(en, 'a', 'un').
articulo(en, 'a', 'una').
articulo(en, 'an', 'un').
articulo(en, 'an', 'una').

articulo(es, 'el', 'the').
articulo(es, 'la', 'the').
articulo(es, 'los', 'the').
articulo(es, 'las', 'the').
articulo(es, 'un', 'a').
articulo(es, 'una', 'a').
articulo(es, 'unos', 'some').
articulo(es, 'unas', 'some').

% PRONOMBRES PERSONALES
% pronombre(Idioma, Palabra, Traducción)
pronombre(en, 'I', 'yo').
pronombre(en, 'you', 'tú').
pronombre(en, 'he', 'él').
pronombre(en, 'she', 'ella').
pronombre(en, 'it', 'eso').
pronombre(en, 'we', 'nosotros').
pronombre(en, 'they', 'ellos').

pronombre(es, 'yo', 'I').
pronombre(es, 'tú', 'you').
pronombre(es, 'él', 'he').
pronombre(es, 'ella', 'she').
pronombre(es, 'eso', 'it').
pronombre(es, 'nosotros', 'we').
pronombre(es, 'ellos', 'they').

% SUSTANTIVOS
% sustantivo(Idioma, Palabra, Traducción)
sustantivo(en, 'cat', 'gato').
sustantivo(en, 'dog', 'perro').
sustantivo(en, 'house', 'casa').
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

sustantivo(es, 'gato', 'cat').
sustantivo(es, 'perro', 'dog').
sustantivo(es, 'casa', 'house').
sustantivo(es, 'coche', 'car').
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

% ===========================
% VERBOS - ESTRUCTURA NUEVA
% verbo(Idioma, FormaConjugada, Persona, Numero, Infinitivo)
% Persona: primera | segunda | tercera
% Numero: singular | plural
% Infinitivo: atom (en su idioma)
% ===========================

% --- ESPAÑOL: CORRER (inf: correr) ---
verbo(es, 'corro',    primera, singular, 'correr').
verbo(es, 'corres',   segunda, singular, 'correr').
verbo(es, 'corre',    tercera, singular, 'correr').
verbo(es, 'corremos', primera, plural,   'correr').
verbo(es, 'corréis',  segunda, plural,   'correr').
verbo(es, 'corren',   tercera, plural,   'correr').

% --- INGLÉS: RUN (inf: run) ---
verbo(en, 'run',  primera, singular, 'run').
verbo(en, 'run',  segunda, singular, 'run').
verbo(en, 'runs', tercera, singular, 'run').
verbo(en, 'run',  primera, plural,   'run').
verbo(en, 'run',  segunda, plural,   'run').
verbo(en, 'run',  tercera, plural,   'run').

% --- ESPAÑOL: HABLAR ---
verbo(es, 'hablo',    primera, singular, 'hablar').
verbo(es, 'hablas',   segunda, singular, 'hablar').
verbo(es, 'habla',    tercera, singular, 'hablar').
verbo(es, 'hablamos', primera, plural,   'hablar').
verbo(es, 'habláis',  segunda, plural,   'hablar').
verbo(es, 'hablan',   tercera, plural,   'hablar').

% --- INGLÉS: SPEAK ---
verbo(en, 'speak',  primera, singular, 'speak').
verbo(en, 'speak',  segunda, singular, 'speak').
verbo(en, 'speaks', tercera, singular, 'speak').
verbo(en, 'speak',  primera, plural,   'speak').
verbo(en, 'speak',  segunda, plural,   'speak').
verbo(en, 'speak',  tercera, plural,   'speak').

% --- ESPAÑOL: COMER ---
verbo(es, 'como',    primera, singular, 'comer').
verbo(es, 'comes',   segunda, singular, 'comer').
verbo(es, 'come',    tercera, singular, 'comer').
verbo(es, 'comemos', primera, plural,   'comer').
verbo(es, 'coméis',  segunda, plural,   'comer').
verbo(es, 'comen',   tercera, plural,   'comer').

% --- INGLÉS: EAT ---
verbo(en, 'eat',  primera, singular, 'eat').
verbo(en, 'eat',  segunda, singular, 'eat').
verbo(en, 'eats', tercera, singular, 'eat').
verbo(en, 'eat',  primera, plural,   'eat').
verbo(en, 'eat',  segunda, plural,   'eat').
verbo(en, 'eat',  tercera, plural,   'eat').

% --- ESPAÑOL: TENER ---
verbo(es, 'tengo',   primera, singular, 'tener').
verbo(es, 'tienes',  segunda, singular, 'tener').
verbo(es, 'tiene',   tercera, singular, 'tener').
verbo(es, 'tenemos', primera, plural,   'tener').
verbo(es, 'tenéis',  segunda, plural,   'tener').
verbo(es, 'tienen',  tercera, plural,   'tener').

% --- INGLÉS: HAVE ---
verbo(en, 'have',  primera, singular, 'have').
verbo(en, 'have',  segunda, singular, 'have').
verbo(en, 'has',   tercera, singular, 'have').
verbo(en, 'have',  primera, plural,   'have').
verbo(en, 'have',  segunda, plural,   'have').
verbo(en, 'have',  tercera, plural,   'have').

% --- ESPAÑOL: DORMIR ---
verbo(es, 'duermo',   primera, singular, 'dormir').
verbo(es, 'duermes',  segunda, singular, 'dormir').
verbo(es, 'duerme',   tercera, singular, 'dormir').
verbo(es, 'dormimos', primera, plural,   'dormir').
verbo(es, 'dormís',   segunda, plural,   'dormir').
verbo(es, 'duermen',  tercera, plural,   'dormir').

% --- INGLÉS: SLEEP ---
verbo(en, 'sleep',  primera, singular, 'sleep').
verbo(en, 'sleep',  segunda, singular, 'sleep').
verbo(en, 'sleeps', tercera, singular, 'sleep').
verbo(en, 'sleep',  primera, plural,   'sleep').
verbo(en, 'sleep',  segunda, plural,   'sleep').
verbo(en, 'sleep',  tercera, plural,   'sleep').


% ADJETIVOS
% adjetivo(Idioma, Palabra, Traducción)
adjetivo(en, 'big', 'grande').
adjetivo(en, 'small', 'pequeño').
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

adjetivo(es, 'grande', 'big').
adjetivo(es, 'pequeño', 'small').
adjetivo(es, 'bueno', 'good').
adjetivo(es, 'malo', 'bad').
adjetivo(es, 'feliz', 'happy').
adjetivo(es, 'triste', 'sad').
adjetivo(es, 'caliente', 'hot').
adjetivo(es, 'frío', 'cold').
adjetivo(es, 'rápido', 'fast').
adjetivo(es, 'lento', 'slow').
adjetivo(es, 'nuevo', 'new').
adjetivo(es, 'viejo', 'old').
adjetivo(es, 'hermoso', 'beautiful').
adjetivo(es, 'feo', 'ugly').

% PREPOSICIONES
% preposicion(Idioma, Palabra, Traducción)
preposicion(en, 'in', 'en').
preposicion(en, 'on', 'sobre').
preposicion(en, 'at', 'en').
preposicion(en, 'to', 'a').
preposicion(en, 'from', 'de').
preposicion(en, 'with', 'con').
preposicion(en, 'for', 'para').
preposicion(en, 'by', 'por').
preposicion(en, 'about', 'acerca de').

preposicion(es, 'en', 'in').
preposicion(es, 'sobre', 'on').
preposicion(es, 'a', 'to').
preposicion(es, 'de', 'from').
preposicion(es, 'con', 'with').
preposicion(es, 'para', 'for').
preposicion(es, 'por', 'by').
preposicion(es, 'acerca de', 'about').

% PALABRAS DE FUNCIÓN
% palabra_funcion(Idioma, Palabra, Traducción)
palabra_funcion(en, 'and', 'y').
palabra_funcion(en, 'or', 'o').
palabra_funcion(en, 'but', 'pero').
palabra_funcion(en, 'not', 'no').
palabra_funcion(en, 'yes', 'sí').
palabra_funcion(en, 'no', 'no').

palabra_funcion(es, 'y', 'and').
palabra_funcion(es, 'o', 'or').
palabra_funcion(es, 'pero', 'but').
palabra_funcion(es, 'no', 'not').
palabra_funcion(es, 'sí', 'yes').

% TRADUCCIONES

% traducir(IdiomaOrigen, PalabraOrigen, Traducción)
traducir(Idioma, Palabra, Traduccion) :-
    articulo(Idioma, Palabra, Traduccion), !.
    
traducir(Idioma, Palabra, Traduccion) :-
    pronombre(Idioma, Palabra, Traduccion), !.
    
traducir(Idioma, Palabra, Traduccion) :-
    sustantivo(Idioma, Palabra, Traduccion), !.
    
traducir(Idioma, Palabra, Traduccion) :-
    adjetivo(Idioma, Palabra, Traduccion), !.
    
traducir(Idioma, Palabra, Traduccion) :-
    preposicion(Idioma, Palabra, Traduccion), !.
    
traducir(Idioma, Palabra, Traduccion) :-
    palabra_funcion(Idioma, Palabra, Traduccion), !.

traducir(_, Palabra, Palabra) :-
    write('Palabra no encontrada: '), write(Palabra), nl,
    write('Se mantiene la palabra original.'), nl.