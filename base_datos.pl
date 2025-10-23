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
sustantivo(en, 'man', 'hombre').
sustantivo(en, 'woman', 'mujer').
sustantivo(en, 'child', 'niño').
sustantivo(en, 'children', 'niños').
sustantivo(en, 'boy', 'chico').
sustantivo(en, 'girl', 'chica').
sustantivo(en, 'food', 'comida').
sustantivo(en, 'drink', 'bebida').
sustantivo(en, 'door', 'puerta').
sustantivo(en, 'window', 'ventana').
sustantivo(en, 'bed', 'cama').
sustantivo(en, 'room', 'habitación').
sustantivo(en, 'bathroom', 'baño').
sustantivo(en, 'kitchen', 'cocina').
sustantivo(en, 'store', 'tienda').
sustantivo(en, 'shop', 'tienda').
sustantivo(en, 'market', 'mercado').
sustantivo(en, 'money', 'dinero').
sustantivo(en, 'time', 'tiempo').
sustantivo(en, 'world', 'mundo').
sustantivo(en, 'person', 'persona').
sustantivo(en, 'family', 'familia').
sustantivo(en, 'hand', 'mano').
sustantivo(en, 'eye', 'ojo').
sustantivo(en, 'head', 'cabeza').
sustantivo(en, 'face', 'cara').
sustantivo(en, 'sun', 'sol').
sustantivo(en, 'moon', 'luna').
sustantivo(en, 'sea', 'mar').
sustantivo(en, 'mountain', 'montaña').
sustantivo(en, 'river', 'río').
sustantivo(en, 'schoolbag', 'mochila').
sustantivo(en, 'pencil', 'lápiz').
sustantivo(en, 'pen', 'bolígrafo').
sustantivo(en, 'notebook', 'cuaderno').
sustantivo(en, 'teacher', 'profesor').
sustantivo(en, 'student', 'estudiante').
sustantivo(en, 'family', 'familia').
sustantivo(en, 'friend', 'amigo').
sustantivo(en, 'baby', 'bebé').
sustantivo(en, 'childhood', 'infancia').
sustantivo(en, 'life', 'vida').
sustantivo(en, 'love', 'amor').
sustantivo(en, 'happiness', 'felicidad').
sustantivo(en, 'city', 'ciudad').
sustantivo(en, 'village', 'pueblo').
sustantivo(en, 'beach', 'playa').
sustantivo(en, 'mountain', 'montaña').
sustantivo(en, 'river', 'río').
sustantivo(en, 'forest', 'bosque').
sustantivo(en, 'ocean', 'océano').
sustantivo(en, 'weather', 'clima').
sustantivo(en, 'season', 'estación').

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
sustantivo(es, 'hombre', 'man').
sustantivo(es, 'mujer', 'woman').
sustantivo(es, 'niño', 'child').
sustantivo(es, 'niños', 'children').
sustantivo(es, 'chico', 'boy').
sustantivo(es, 'chica', 'girl').
sustantivo(es, 'bebida', 'drink').
sustantivo(es, 'puerta', 'door').
sustantivo(es, 'ventana', 'window').
sustantivo(es, 'cama', 'bed').
sustantivo(es, 'habitación', 'room').
sustantivo(es, 'baño', 'bathroom').
sustantivo(es, 'cocina', 'kitchen').
sustantivo(es, 'tienda', 'store').
sustantivo(es, 'mercado', 'market').
sustantivo(es, 'dinero', 'money').
sustantivo(es, 'tiempo', 'time').
sustantivo(es, 'mundo', 'world').
sustantivo(es, 'persona', 'person').
sustantivo(es, 'familia', 'family').
sustantivo(es, 'mano', 'hand').
sustantivo(es, 'ojo', 'eye').
sustantivo(es, 'cabeza', 'head').
sustantivo(es, 'cara', 'face').
sustantivo(es, 'sol', 'sun').
sustantivo(es, 'luna', 'moon').
sustantivo(es, 'mar', 'sea').
sustantivo(es, 'montaña', 'mountain').
sustantivo(es, 'río', 'river').

sustantivo(es, 'mochila', 'schoolbag').
sustantivo(es, 'lápiz', 'pencil').
sustantivo(es, 'bolígrafo', 'pen').
sustantivo(es, 'cuaderno', 'notebook').
sustantivo(es, 'profesor', 'teacher').
sustantivo(es, 'estudiante', 'student').
sustantivo(es, 'bebé', 'baby').
sustantivo(es, 'infancia', 'childhood').
sustantivo(es, 'vida', 'life').
sustantivo(es, 'amor', 'love').
sustantivo(es, 'felicidad', 'happiness').
sustantivo(es, 'pueblo', 'village').
sustantivo(es, 'playa', 'beach').
sustantivo(es, 'bosque', 'forest').
sustantivo(es, 'océano', 'ocean').
sustantivo(es, 'clima', 'weather').
sustantivo(es, 'estación', 'season').


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
traduccion_verbo(ir, go).
traduccion_verbo(ver, see).
traduccion_verbo(hacer, do).
traduccion_verbo(decir, say).
traduccion_verbo(poder, can).
traduccion_verbo(querer, want).
traduccion_verbo(necesitar, need).
traduccion_verbo(llegar, arrive).
traduccion_verbo(saber, know).
traduccion_verbo(cantar, sing).
traduccion_verbo(bailar, dance).
traduccion_verbo(jugar, play).
traduccion_verbo(escuchar, listen).
traduccion_verbo(escribir, write).
traduccion_verbo(leer, read).
traduccion_verbo(pensar, think).
traduccion_verbo(sentir, feel).
traduccion_verbo(trabajar, work).
traduccion_verbo(ayudar, help).

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

% EN: go
verbo(en, 'go',  primera, singular, 'go').
verbo(en, 'go',  segunda, singular, 'go').
verbo(en, 'goes', tercera, singular, 'go').
verbo(en, 'go',  primera, plural,   'go').
verbo(en, 'go',  segunda, plural,   'go').
verbo(en, 'go',  tercera, plural,   'go').

% ESP: ir
verbo(es, 'voy',     primera, singular, 'ir').
verbo(es, 'vas',     segunda, singular, 'ir').
verbo(es, 'va',      tercera, singular, 'ir').
verbo(es, 'vamos',   primera, plural,   'ir').
verbo(es, 'vais',    segunda, plural,   'ir').
verbo(es, 'van',     tercera, plural,   'ir').

% EN: see
verbo(en, 'see',  primera, singular, 'see').
verbo(en, 'see',  segunda, singular, 'see').
verbo(en, 'sees', tercera, singular, 'see').
verbo(en, 'see',  primera, plural,   'see').
verbo(en, 'see',  segunda, plural,   'see').
verbo(en, 'see',  tercera, plural,   'see').

% ESP: ver
verbo(es, 'veo',    primera, singular, 'ver').
verbo(es, 'ves',    segunda, singular, 'ver').
verbo(es, 've',     tercera, singular, 'ver').
verbo(es, 'vemos',  primera, plural,   'ver').
verbo(es, 'veis',   segunda, plural,   'ver').
verbo(es, 'ven',    tercera, plural,   'ver').

% EN: do
verbo(en, 'do',  primera, singular, 'do').
verbo(en, 'do',  segunda, singular, 'do').
verbo(en, 'does', tercera, singular, 'do').
verbo(en, 'do',  primera, plural,   'do').
verbo(en, 'do',  segunda, plural,   'do').
verbo(en, 'do',  tercera, plural,   'do').

% ESP: hacer
verbo(es, 'hago',    primera, singular, 'hacer').
verbo(es, 'haces',   segunda, singular, 'hacer').
verbo(es, 'hace',    tercera, singular, 'hacer').
verbo(es, 'hacemos', primera, plural,   'hacer').
verbo(es, 'hacéis',  segunda, plural,   'hacer').
verbo(es, 'hacen',   tercera, plural,   'hacer').

% ESP: cantar
verbo(es, 'canto',    primera, singular, 'cantar').
verbo(es, 'cantas',   segunda, singular, 'cantar').
verbo(es, 'canta',    tercera, singular, 'cantar').
verbo(es, 'cantamos', primera, plural,   'cantar').
verbo(es, 'cantáis',  segunda, plural,   'cantar').
verbo(es, 'cantan',   tercera, plural,   'cantar').

% EN: sing
verbo(en, 'sing',  primera, singular, 'sing').
verbo(en, 'sing',  segunda, singular, 'sing').
verbo(en, 'sings', tercera, singular, 'sing').
verbo(en, 'sing',  primera, plural,   'sing').
verbo(en, 'sing',  segunda, plural,   'sing').
verbo(en, 'sing',  tercera, plural,   'sing').

% ESP: bailar
verbo(es, 'bailo',    primera, singular, 'bailar').
verbo(es, 'bailas',   segunda, singular, 'bailar').
verbo(es, 'baila',    tercera, singular, 'bailar').
verbo(es, 'bailamos', primera, plural,   'bailar').
verbo(es, 'bailáis',  segunda, plural,   'bailar').
verbo(es, 'bailan',   tercera, plural,   'bailar').

% EN: dance
verbo(en, 'dance',  primera, singular, 'dance').
verbo(en, 'dance',  segunda, singular, 'dance').
verbo(en, 'dances', tercera, singular, 'dance').
verbo(en, 'dance',  primera, plural,   'dance').
verbo(en, 'dance',  segunda, plural,   'dance').
verbo(en, 'dance',  tercera, plural,   'dance').

% ESP: jugar
verbo(es, 'juego',    primera, singular, 'jugar').
verbo(es, 'juegas',   segunda, singular, 'jugar').
verbo(es, 'juega',    tercera, singular, 'jugar').
verbo(es, 'jugamos',  primera, plural,   'jugar').
verbo(es, 'jugáis',   segunda, plural,   'jugar').
verbo(es, 'juegan',   tercera, plural,   'jugar').

% EN: play
verbo(en, 'play',  primera, singular, 'play').
verbo(en, 'play',  segunda, singular, 'play').
verbo(en, 'plays', tercera, singular, 'play').
verbo(en, 'play',  primera, plural,   'play').
verbo(en, 'play',  segunda, plural,   'play').
verbo(en, 'play',  tercera, plural,   'play').

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
adjetivo(en, 'angry', 'enojado').
adjetivo(en, 'hungry', 'hambriento').
adjetivo(en, 'thirsty', 'sediento').
adjetivo(en, 'beautiful', 'hermoso').
adjetivo(en, 'dark', 'oscuro').
adjetivo(en, 'light', 'claro').
adjetivo(en, 'expensive', 'caro').
adjetivo(en, 'cheap', 'barato').
adjetivo(en, 'clean', 'limpio').
adjetivo(en, 'dirty', 'sucio').
adjetivo(en, 'strong', 'fuerte').
adjetivo(en, 'weak', 'débil').
adjetivo(en, 'early', 'temprano').
adjetivo(en, 'late', 'tarde').
adjetivo(en, 'beautiful', 'bonito').
adjetivo(en, 'friendly', 'amable').
adjetivo(en, 'tired', 'cansado').

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



adjetivo(es, 'limpio', 'clean').
adjetivo(es, 'sucio', 'dirty').
adjetivo(es, 'fuerte', 'strong').
adjetivo(es, 'débil', 'weak').
adjetivo(es, 'temprano', 'early').
adjetivo(es, 'tarde', 'late').
adjetivo(es, 'amable', 'friendly').
adjetivo(es, 'cansado', 'tired').
adjetivo(es, 'enojado', 'angry').
adjetivo(es, 'hambriento', 'hungry').
adjetivo(es, 'sediento', 'thirsty').
adjetivo(es, 'oscuro', 'dark').
adjetivo(es, 'claro', 'light').
adjetivo(es, 'caro', 'expensive').
adjetivo(es, 'barato', 'cheap').


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
preposicion(en, 'before', 'antes de').
preposicion(en, 'after', 'después de').
preposicion(en, 'behind', 'detrás de').
preposicion(en, 'near', 'cerca de').
preposicion(en, 'inside', 'dentro de').
preposicion(en, 'outside', 'fuera de').
preposicion(en, 'above', 'encima de').
preposicion(en, 'below', 'debajo de').
preposicion(en, 'through', 'a través de').
preposicion(en, 'toward', 'hacia').
preposicion(en, 'against', 'contra').


preposicion(es, 'en', 'in').
preposicion(es, 'sobre', 'on').
preposicion(es, 'a', 'to').
preposicion(es, 'de', 'from').
preposicion(es, 'con', 'with').
preposicion(es, 'para', 'for').
preposicion(es, 'por', 'by').
preposicion(es, 'debajo de', 'under').
preposicion(es, 'entre', 'between').
preposicion(es, 'antes de', 'before').
preposicion(es, 'después de', 'after').
preposicion(es, 'detrás de', 'behind').
preposicion(es, 'cerca de', 'near').
preposicion(es, 'dentro de', 'inside').
preposicion(es, 'fuera de', 'outside').
preposicion(es, 'encima de', 'above').
preposicion(es, 'debajo de', 'below').
preposicion(es, 'a través de', 'through').
preposicion(es, 'hacia', 'toward').
preposicion(es, 'contra', 'against').

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
