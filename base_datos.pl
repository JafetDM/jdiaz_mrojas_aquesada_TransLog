:- module(base_datos,[ traduccion_verbo/2, verbo/5, traducir/3, articulo/3, pronombre/3, sustantivo/3, adjetivo/3, preposicion/3, sinonimo/3,genero_sust_es/2, pron_feats/4]).
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

% Ingles
pron_feats(en,'i',      primera, singular).
pron_feats(en,'you',    segunda, singular). 
pron_feats(en,'he',     tercera, singular).
pron_feats(en,'she',    tercera, singular).
pron_feats(en,'it',     tercera, singular).
pron_feats(en,'we',     primera, plural).
pron_feats(en,'they',   tercera, plural).

% Español
pron_feats(es,'yo',       primera, singular).
pron_feats(es,'tú',       segunda, singular).
pron_feats(es,'él',       tercera, singular).
pron_feats(es,'ella',     tercera, singular).
pron_feats(es,'eso',      tercera, singular).
pron_feats(es,'nosotros', primera, plural).
pron_feats(es,'ellos',    tercera, plural).

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
sustantivo(en, 'airport', 'aeropuerto').
sustantivo(en, 'train', 'tren').
sustantivo(en, 'bus', 'autobús').
sustantivo(en, 'bicycle', 'bicicleta').
sustantivo(en, 'mountain', 'montaña').
sustantivo(en, 'forest', 'bosque').
sustantivo(en, 'island', 'isla').
sustantivo(en, 'desert', 'desierto').
sustantivo(en, 'lake', 'lago').
sustantivo(en, 'river', 'río').
sustantivo(en, 'ocean', 'océano').
sustantivo(en, 'beach', 'playa').
sustantivo(en, 'school', 'escuela').
sustantivo(en, 'university', 'universidad').
sustantivo(en, 'hospital', 'hospital').
sustantivo(en, 'restaurant', 'restaurante').
sustantivo(en, 'cafe', 'cafetería').
sustantivo(en, 'hotel', 'hotel').
sustantivo(en, 'market', 'mercado').
sustantivo(en, 'supermarket', 'supermercado').
sustantivo(en, 'church', 'iglesia').
sustantivo(en, 'museum', 'museo').
sustantivo(en, 'library', 'biblioteca').
sustantivo(en, 'park', 'parque').
sustantivo(en, 'garden', 'jardín').
sustantivo(en, 'street', 'calle').
sustantivo(en, 'square', 'plaza').
sustantivo(en, 'bridge', 'puente').
sustantivo(en, 'tower', 'torre').
sustantivo(en, 'castle', 'castillo').
sustantivo(en, 'road', 'carretera').
sustantivo(en, 'station', 'estación').
sustantivo(en, 'factory', 'fábrica').
sustantivo(en, 'shop', 'tienda').
sustantivo(en, 'store', 'almacén').
sustantivo(en, 'apartment', 'apartamento').
sustantivo(en, 'house', 'casa').
sustantivo(en, 'room', 'habitación').
sustantivo(en, 'kitchen', 'cocina').
sustantivo(en, 'bathroom', 'baño').
sustantivo(en, 'bedroom', 'dormitorio').
sustantivo(en, 'garden', 'jardín').
sustantivo(en, 'window', 'ventana').
sustantivo(en, 'door', 'puerta').
sustantivo(en, 'floor', 'piso').
sustantivo(en, 'ceiling', 'techo').
sustantivo(en, 'wall', 'pared').
sustantivo(en, 'roof', 'techo').
sustantivo(en, 'chair', 'silla').
sustantivo(en, 'table', 'mesa').
sustantivo(en, 'lion', 'león').
sustantivo(en, 'tiger', 'tigre').
sustantivo(en, 'bear', 'oso').
sustantivo(en, 'elephant', 'elefante').
sustantivo(en, 'monkey', 'mono').
sustantivo(en, 'rabbit', 'conejo').
sustantivo(en, 'horse', 'caballo').
sustantivo(en, 'sheep', 'oveja').
sustantivo(en, 'goat', 'cabra').
sustantivo(en, 'chicken', 'pollo').
sustantivo(en, 'duck', 'pato').
sustantivo(en, 'fish', 'pez').
sustantivo(en, 'bread', 'pan').
sustantivo(en, 'cheese', 'queso').
sustantivo(en, 'butter', 'mantequilla').
sustantivo(en, 'milk', 'leche').
sustantivo(en, 'coffee', 'café').
sustantivo(en, 'tea', 'té').
sustantivo(en, 'apple', 'manzana').
sustantivo(en, 'banana', 'plátano').
sustantivo(en, 'orange', 'naranja').
sustantivo(en, 'grape', 'uva').
sustantivo(en, 'meat', 'carne').
sustantivo(en, 'rice', 'arroz').
sustantivo(en, 'egg', 'huevo').
sustantivo(en, 'bag', 'bolsa').
sustantivo(en, 'hat', 'sombrero').
sustantivo(en, 'shirt', 'camisa').
sustantivo(en, 'shoe', 'zapato').
sustantivo(en, 'watch', 'reloj').
sustantivo(en, 'ring', 'anillo').
sustantivo(en, 'key', 'llave').
sustantivo(en, 'lamp', 'lámpara').
sustantivo(en, 'mirror', 'espejo').
sustantivo(en, 'phone', 'teléfono').
sustantivo(en, 'station', 'estación').
sustantivo(en, 'airport', 'aeropuerto').
sustantivo(en, 'restaurant', 'restaurante').
sustantivo(en, 'mall', 'centro comercial').
sustantivo(en, 'cinema', 'cine').
sustantivo(en, 'park', 'parque').
sustantivo(en, 'hotel', 'hotel').
sustantivo(en, 'beach', 'playa').
sustantivo(en, 'mountain', 'montaña').
sustantivo(en, 'river', 'río').
sustantivo(en, 'doctor', 'médico').
sustantivo(en, 'nurse', 'enfermero').
sustantivo(en, 'engineer', 'ingeniero').
sustantivo(en, 'teacher', 'profesor').
sustantivo(en, 'student', 'estudiante').
sustantivo(en, 'driver', 'conductor').
sustantivo(en, 'police', 'policía').
sustantivo(en, 'chef', 'chef').
sustantivo(en, 'artist', 'artista').
sustantivo(en, 'writer', 'escritor').

sustantivo(es, 'león', 'lion').
sustantivo(es, 'tigre', 'tiger').
sustantivo(es, 'oso', 'bear').
sustantivo(es, 'elefante', 'elephant').
sustantivo(es, 'mono', 'monkey').
sustantivo(es, 'conejo', 'rabbit').
sustantivo(es, 'caballo', 'horse').
sustantivo(es, 'oveja', 'sheep').
sustantivo(es, 'cabra', 'goat').
sustantivo(es, 'pollo', 'chicken').
sustantivo(es, 'pato', 'duck').
sustantivo(es, 'pez', 'fish').
sustantivo(es, 'pan', 'bread').
sustantivo(es, 'queso', 'cheese').
sustantivo(es, 'mantequilla', 'butter').
sustantivo(es, 'leche', 'milk').
sustantivo(es, 'café', 'coffee').
sustantivo(es, 'té', 'tea').
sustantivo(es, 'manzana', 'apple').
sustantivo(es, 'plátano', 'banana').
sustantivo(es, 'naranja', 'orange').
sustantivo(es, 'uva', 'grape').
sustantivo(es, 'carne', 'meat').
sustantivo(es, 'arroz', 'rice').
sustantivo(es, 'huevo', 'egg').
sustantivo(es, 'bolsa', 'bag').
sustantivo(es, 'sombrero', 'hat').
sustantivo(es, 'camisa', 'shirt').
sustantivo(es, 'zapato', 'shoe').
sustantivo(es, 'reloj', 'watch').
sustantivo(es, 'anillo', 'ring').
sustantivo(es, 'llave', 'key').
sustantivo(es, 'lámpara', 'lamp').
sustantivo(es, 'espejo', 'mirror').
sustantivo(es, 'centro comercial', 'mall').
sustantivo(es, 'cine', 'cinema').
sustantivo(es, 'médico', 'doctor').
sustantivo(es, 'enfermero', 'nurse').
sustantivo(es, 'ingeniero', 'engineer').
sustantivo(es, 'conductor', 'driver').
sustantivo(es, 'policía', 'police').
sustantivo(es, 'chef', 'chef').
sustantivo(es, 'artista', 'artist').
sustantivo(es, 'escritor', 'writer').
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
sustantivo(es, 'aeropuerto', 'airport').
sustantivo(es, 'tren', 'train').
sustantivo(es, 'autobús', 'bus').
sustantivo(es, 'bicicleta', 'bicycle').
sustantivo(es, 'isla', 'island').
sustantivo(es, 'desierto', 'desert').
sustantivo(es, 'lago', 'lake').
sustantivo(es, 'universidad', 'university').
sustantivo(es, 'hospital', 'hospital').
sustantivo(es, 'restaurante', 'restaurant').
sustantivo(es, 'cafetería', 'cafe').
sustantivo(es, 'hotel', 'hotel').
sustantivo(es, 'supermercado', 'supermarket').
sustantivo(es, 'iglesia', 'church').
sustantivo(es, 'museo', 'museum').
sustantivo(es, 'biblioteca', 'library').
sustantivo(es, 'parque', 'park').
sustantivo(es, 'plaza', 'square').
sustantivo(es, 'puente', 'bridge').
sustantivo(es, 'torre', 'tower').
sustantivo(es, 'castillo', 'castle').
sustantivo(es, 'estación', 'station').
sustantivo(es, 'fábrica', 'factory').
sustantivo(es, 'apartamento', 'apartment').
sustantivo(es, 'dormitorio', 'bedroom').
sustantivo(es, 'piso', 'floor').
sustantivo(es, 'pared', 'wall').
sustantivo(es, 'techo', 'ceiling').
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
% GENERO DE SUSTANTIVOS ESPAÑOLES
% -------------------------
genero_sust_es('león', masc).
genero_sust_es('tigre', masc).
genero_sust_es('oso', masc).
genero_sust_es('elefante', masc).
genero_sust_es('mono', masc).
genero_sust_es('conejo', masc).
genero_sust_es('caballo', masc).
genero_sust_es('oveja', fem).
genero_sust_es('cabra', fem).
genero_sust_es('pollo', masc).
genero_sust_es('pato', masc).
genero_sust_es('pez', masc).
genero_sust_es('pan', masc).
genero_sust_es('queso', masc).
genero_sust_es('mantequilla', fem).
genero_sust_es('leche', fem).
genero_sust_es('café', masc).
genero_sust_es('té', masc).
genero_sust_es('manzana', fem).
genero_sust_es('plátano', masc).
genero_sust_es('naranja', fem).
genero_sust_es('uva', fem).
genero_sust_es('carne', fem).
genero_sust_es('arroz', masc).
genero_sust_es('huevo', masc).
genero_sust_es('bolsa', fem).
genero_sust_es('sombrero', masc).
genero_sust_es('camisa', fem).
genero_sust_es('zapato', masc).
genero_sust_es('reloj', masc).
genero_sust_es('anillo', masc).
genero_sust_es('llave', fem).
genero_sust_es('lámpara', fem).
genero_sust_es('espejo', masc).
genero_sust_es('centro comercial', masc).
genero_sust_es('cine', masc).
genero_sust_es('médico', masc).
genero_sust_es('enfermero', masc).
genero_sust_es('ingeniero', masc).
genero_sust_es('conductor', masc).
genero_sust_es('policía', masc).
genero_sust_es('chef', masc).
genero_sust_es('artista', masc).
genero_sust_es('escritor', masc).
genero_sust_es('gato', masc).
genero_sust_es('perro', masc).
genero_sust_es('casa', fem).
genero_sust_es('hogar', masc).
genero_sust_es('coche', masc).
genero_sust_es('carro', masc).
genero_sust_es('auto', masc).
genero_sust_es('libro', masc).
genero_sust_es('mesa', fem).
genero_sust_es('silla', fem).
genero_sust_es('agua', fem).
genero_sust_es('comida', fem).
genero_sust_es('amigo', masc).
genero_sust_es('madre', fem).
genero_sust_es('padre', masc).
genero_sust_es('hermana', fem).
genero_sust_es('hermano', masc).
genero_sust_es('escuela', fem).
genero_sust_es('ciudad', fem).
genero_sust_es('país', masc).
genero_sust_es('árbol', masc).
genero_sust_es('flor', fem).
genero_sust_es('día', masc).
genero_sust_es('noche', fem).
genero_sust_es('calle', fem).
genero_sust_es('carretera', fem).
genero_sust_es('computadora', fem).
genero_sust_es('teléfono', masc).
genero_sust_es('música', fem).
genero_sust_es('película', fem).
genero_sust_es('trabajo', masc).
genero_sust_es('juego', masc).
genero_sust_es('hombre', masc).
genero_sust_es('mujer', fem).
genero_sust_es('niño', masc).
genero_sust_es('niños', masc).
genero_sust_es('chico', masc).
genero_sust_es('chica', fem).
genero_sust_es('bebida', fem).
genero_sust_es('puerta', fem).
genero_sust_es('ventana', fem).
genero_sust_es('cama', fem).
genero_sust_es('habitación', fem).
genero_sust_es('baño', masc).
genero_sust_es('cocina', fem).
genero_sust_es('tienda', fem).
genero_sust_es('mercado', masc).
genero_sust_es('dinero', masc).
genero_sust_es('tiempo', masc).
genero_sust_es('mundo', masc).
genero_sust_es('persona', fem).
genero_sust_es('familia', fem).
genero_sust_es('mano', fem).
genero_sust_es('ojo', masc).
genero_sust_es('cabeza', fem).
genero_sust_es('cara', fem).
genero_sust_es('sol', masc).
genero_sust_es('luna', fem).
genero_sust_es('mar', masc).
genero_sust_es('montaña', fem).
genero_sust_es('río', masc).
genero_sust_es('aeropuerto', masc).
genero_sust_es('tren', masc).
genero_sust_es('autobús', masc).
genero_sust_es('bicicleta', fem).
genero_sust_es('isla', fem).
genero_sust_es('desierto', masc).
genero_sust_es('lago', masc).
genero_sust_es('universidad', fem).
genero_sust_es('hospital', masc).
genero_sust_es('restaurante', masc).
genero_sust_es('cafetería', fem).
genero_sust_es('hotel', masc).
genero_sust_es('supermercado', masc).
genero_sust_es('iglesia', fem).
genero_sust_es('museo', masc).
genero_sust_es('biblioteca', fem).
genero_sust_es('parque', masc).
genero_sust_es('plaza', fem).
genero_sust_es('puente', masc).
genero_sust_es('torre', fem).
genero_sust_es('castillo', masc).
genero_sust_es('estación', fem).
genero_sust_es('fábrica', fem).
genero_sust_es('apartamento', masc).
genero_sust_es('dormitorio', masc).
genero_sust_es('piso', masc).
genero_sust_es('pared', fem).
genero_sust_es('techo', masc).
genero_sust_es('mochila', fem).
genero_sust_es('lápiz', masc).
genero_sust_es('bolígrafo', masc).
genero_sust_es('cuaderno', masc).
genero_sust_es('profesor', masc).
genero_sust_es('estudiante', masc).
genero_sust_es('bebé', masc).
genero_sust_es('infancia', fem).
genero_sust_es('vida', fem).
genero_sust_es('amor', masc).
genero_sust_es('felicidad', fem).
genero_sust_es('pueblo', masc).
genero_sust_es('playa', fem).
genero_sust_es('bosque', masc).
genero_sust_es('océano', masc).
genero_sust_es('clima', masc).

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
traduccion_verbo(comprar, buy).
traduccion_verbo(vender, sell).
traduccion_verbo(encontrar, find).
traduccion_verbo(perder, lose).
traduccion_verbo(caminar, walk).
traduccion_verbo(creer, believe).
traduccion_verbo(entender, understand).
traduccion_verbo(decidir, decide).
traduccion_verbo(salir, leave).
traduccion_verbo(abrir, open).
traduccion_verbo(cerrar, close).
traduccion_verbo(cocinar, cook).
traduccion_verbo(beber, drink).
traduccion_verbo(dibujar, draw).
traduccion_verbo(dar, give).
traduccion_verbo(recibir, receive).
traduccion_verbo(enviar, send).

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

% ESP: decir
verbo(es, 'digo',    primera, singular, 'decir').
verbo(es, 'dices',   segunda, singular, 'decir').
verbo(es, 'dice',    tercera, singular, 'decir').
verbo(es, 'decimos', primera, plural,   'decir').
verbo(es, 'decís',   segunda, plural,   'decir').
verbo(es, 'dicen',   tercera, plural,   'decir').

% EN: say
verbo(en, 'say',    primera, singular, 'say').
verbo(en, 'say',    segunda, singular, 'say').
verbo(en, 'says',   tercera, singular, 'say').
verbo(en, 'say',    primera, plural,   'say').
verbo(en, 'say',    segunda, plural,   'say').
verbo(en, 'say',    tercera, plural,   'say').

% ESP: poder
verbo(es, 'puedo',   primera, singular, 'poder').
verbo(es, 'puedes',  segunda, singular, 'poder').
verbo(es, 'puede',   tercera, singular, 'poder').
verbo(es, 'podemos', primera, plural,   'poder').
verbo(es, 'podéis',  segunda, plural,   'poder').
verbo(es, 'pueden',  tercera, plural,   'poder').

% EN: can
verbo(en, 'can',    primera, singular, 'can').
verbo(en, 'can',    segunda, singular, 'can').
verbo(en, 'can',    tercera, singular, 'can').
verbo(en, 'can',    primera, plural,   'can').
verbo(en, 'can',    segunda, plural,   'can').
verbo(en, 'can',    tercera, plural,   'can').

% ESP: querer
verbo(es, 'quiero',   primera, singular, 'querer').
verbo(es, 'quieres',  segunda, singular, 'querer').
verbo(es, 'quiere',   tercera, singular, 'querer').
verbo(es, 'queremos', primera, plural,   'querer').
verbo(es, 'queréis',  segunda, plural,   'querer').
verbo(es, 'quieren',  tercera, plural,   'querer').

% EN: want
verbo(en, 'want',    primera, singular, 'want').
verbo(en, 'want',    segunda, singular, 'want').
verbo(en, 'wants',   tercera, singular, 'want').
verbo(en, 'want',    primera, plural,   'want').
verbo(en, 'want',    segunda, plural,   'want').
verbo(en, 'want',    tercera, plural,   'want').

% ESP: necesitar
verbo(es, 'necesito',   primera, singular, 'necesitar').
verbo(es, 'necesitas',  segunda, singular, 'necesitar').
verbo(es, 'necesita',   tercera, singular, 'necesitar').
verbo(es, 'necesitamos', primera, plural, 'necesitar').
verbo(es, 'necesitáis', segunda, plural,   'necesitar').
verbo(es, 'necesitan',  tercera, plural,   'necesitar').

% EN: need
verbo(en, 'need',    primera, singular, 'need').
verbo(en, 'need',    segunda, singular, 'need').
verbo(en, 'needs',   tercera, singular, 'need').
verbo(en, 'need',    primera, plural,   'need').
verbo(en, 'need',    segunda, plural,   'need').
verbo(en, 'need',    tercera, plural,   'need').

% ESP: llegar
verbo(es, 'llego',    primera, singular, 'llegar').
verbo(es, 'llegas',   segunda, singular, 'llegar').
verbo(es, 'llega',    tercera, singular, 'llegar').
verbo(es, 'llegamos', primera, plural,   'llegar').
verbo(es, 'llegáis',  segunda, plural,   'llegar').
verbo(es, 'llegan',   tercera, plural,   'llegar').

% EN: arrive
verbo(en, 'arrive',    primera, singular, 'arrive').
verbo(en, 'arrive',    segunda, singular, 'arrive').
verbo(en, 'arrives',   tercera, singular, 'arrive').
verbo(en, 'arrive',    primera, plural,   'arrive').
verbo(en, 'arrive',    segunda, plural,   'arrive').
verbo(en, 'arrive',    tercera, plural,   'arrive').

% ESP: saber
verbo(es, 'sé',       primera, singular, 'saber').
verbo(es, 'sabes',    segunda, singular, 'saber').
verbo(es, 'sabe',     tercera, singular, 'saber').
verbo(es, 'sabemos',  primera, plural,   'saber').
verbo(es, 'sabéis',   segunda, plural,   'saber').
verbo(es, 'saben',    tercera, plural,   'saber').

% EN: know
verbo(en, 'know',    primera, singular, 'know').
verbo(en, 'know',    segunda, singular, 'know').
verbo(en, 'knows',   tercera, singular, 'know').
verbo(en, 'know',    primera, plural,   'know').
verbo(en, 'know',    segunda, plural,   'know').
verbo(en, 'know',    tercera, plural,   'know').

% ESP: escuchar
verbo(es, 'escucho',    primera, singular, 'escuchar').
verbo(es, 'escuchas',   segunda, singular, 'escuchar').
verbo(es, 'escucha',    tercera, singular, 'escuchar').
verbo(es, 'escuchamos', primera, plural,   'escuchar').
verbo(es, 'escucháis',  segunda, plural,   'escuchar').
verbo(es, 'escuchan',   tercera, plural,   'escuchar').

% EN: listen
verbo(en, 'listen',    primera, singular, 'listen').
verbo(en, 'listen',    segunda, singular, 'listen').
verbo(en, 'listens',   tercera, singular, 'listen').
verbo(en, 'listen',    primera, plural,   'listen').
verbo(en, 'listen',    segunda, plural,   'listen').
verbo(en, 'listen',    tercera, plural,   'listen').

% ESP: escribir
verbo(es, 'escribo',    primera, singular, 'escribir').
verbo(es, 'escribes',   segunda, singular, 'escribir').
verbo(es, 'escribe',    tercera, singular, 'escribir').
verbo(es, 'escribimos', primera, plural,   'escribir').
verbo(es, 'escribís',   segunda, plural,   'escribir').
verbo(es, 'escriben',   tercera, plural,   'escribir').

% EN: write
verbo(en, 'write',    primera, singular, 'write').
verbo(en, 'write',    segunda, singular, 'write').
verbo(en, 'writes',   tercera, singular, 'write').
verbo(en, 'write',    primera, plural,   'write').
verbo(en, 'write',    segunda, plural,   'write').
verbo(en, 'write',    tercera, plural,   'write').

% ESP: leer
verbo(es, 'leo',    primera, singular, 'leer').
verbo(es, 'lees',   segunda, singular, 'leer').
verbo(es, 'lee',    tercera, singular, 'leer').
verbo(es, 'leemos', primera, plural,   'leer').
verbo(es, 'leéis',  segunda, plural,   'leer').
verbo(es, 'leen',   tercera, plural,   'leer').

% EN: read
verbo(en, 'read',    primera, singular, 'read').
verbo(en, 'read',    segunda, singular, 'read').
verbo(en, 'reads',   tercera, singular, 'read').
verbo(en, 'read',    primera, plural,   'read').
verbo(en, 'read',    segunda, plural,   'read').
verbo(en, 'read',    tercera, plural,   'read').

% ESP: pensar
verbo(es, 'pienso',    primera, singular, 'pensar').
verbo(es, 'piensas',   segunda, singular, 'pensar').
verbo(es, 'piensa',    tercera, singular, 'pensar').
verbo(es, 'pensamos',  primera, plural,   'pensar').
verbo(es, 'pensáis',   segunda, plural,   'pensar').
verbo(es, 'piensan',   tercera, plural,   'pensar').

% EN: think
verbo(en, 'think',    primera, singular, 'think').
verbo(en, 'think',    segunda, singular, 'think').
verbo(en, 'thinks',   tercera, singular, 'think').
verbo(en, 'think',    primera, plural,   'think').
verbo(en, 'think',    segunda, plural,   'think').
verbo(en, 'think',    tercera, plural,   'think').

% ESP: sentir
verbo(es, 'siento',    primera, singular, 'sentir').
verbo(es, 'sientes',   segunda, singular, 'sentir').
verbo(es, 'siente',    tercera, singular, 'sentir').
verbo(es, 'sentimos',  primera, plural,   'sentir').
verbo(es, 'sentís',    segunda, plural,   'sentir').
verbo(es, 'sienten',   tercera, plural,   'sentir').

% EN: feel
verbo(en, 'feel',    primera, singular, 'feel').
verbo(en, 'feel',    segunda, singular, 'feel').
verbo(en, 'feels',   tercera, singular, 'feel').
verbo(en, 'feel',    primera, plural,   'feel').
verbo(en, 'feel',    segunda, plural,   'feel').
verbo(en, 'feel',    tercera, plural,   'feel').

% ESP: trabajar
verbo(es, 'trabajo',    primera, singular, 'trabajar').
verbo(es, 'trabajas',   segunda, singular, 'trabajar').
verbo(es, 'trabaja',    tercera, singular, 'trabajar').
verbo(es, 'trabajamos', primera, plural,   'trabajar').
verbo(es, 'trabajáis',  segunda, plural,   'trabajar').
verbo(es, 'trabajan',   tercera, plural,   'trabajar').

% EN: work
verbo(en, 'work',    primera, singular, 'work').
verbo(en, 'work',    segunda, singular, 'work').
verbo(en, 'works',   tercera, singular, 'work').
verbo(en, 'work',    primera, plural,   'work').
verbo(en, 'work',    segunda, plural,   'work').
verbo(en, 'work',    tercera, plural,   'work').

% ESP: ayudar
verbo(es, 'ayudo',    primera, singular, 'ayudar').
verbo(es, 'ayudas',   segunda, singular, 'ayudar').
verbo(es, 'ayuda',    tercera, singular, 'ayudar').
verbo(es, 'ayudamos', primera, plural,   'ayudar').
verbo(es, 'ayudáis',  segunda, plural,   'ayudar').
verbo(es, 'ayudan',   tercera, plural,   'ayudar').

% EN: help
verbo(en, 'help',    primera, singular, 'help').
verbo(en, 'help',    segunda, singular, 'help').
verbo(en, 'helps',   tercera, singular, 'help').
verbo(en, 'help',    primera, plural,   'help').
verbo(en, 'help',    segunda, plural,   'help').
verbo(en, 'help',    tercera, plural,   'help').

% ESP: comprar
verbo(es, 'compro',    primera, singular, 'comprar').
verbo(es, 'compras',   segunda, singular, 'comprar').
verbo(es, 'compra',    tercera, singular, 'comprar').
verbo(es, 'compramos', primera, plural,   'comprar').
verbo(es, 'compráis',  segunda, plural,   'comprar').
verbo(es, 'compran',   tercera, plural,   'comprar').

% EN: buy
verbo(en, 'buy',  primera, singular, 'buy').
verbo(en, 'buy',  segunda, singular, 'buy').
verbo(en, 'buys', tercera, singular, 'buy').
verbo(en, 'buy',  primera, plural,   'buy').
verbo(en, 'buy',  segunda, plural,   'buy').
verbo(en, 'buy',  tercera, plural,   'buy').

% ESP: vender
verbo(es, 'vendo',    primera, singular, 'vender').
verbo(es, 'vendes',   segunda, singular, 'vender').
verbo(es, 'vende',    tercera, singular, 'vender').
verbo(es, 'vendemos', primera, plural,   'vender').
verbo(es, 'vendéis',  segunda, plural,   'vender').
verbo(es, 'venden',   tercera, plural,   'vender').

% EN: sell
verbo(en, 'sell',  primera, singular, 'sell').
verbo(en, 'sell',  segunda, singular, 'sell').
verbo(en, 'sells', tercera, singular, 'sell').
verbo(en, 'sell',  primera, plural,   'sell').
verbo(en, 'sell',  segunda, plural,   'sell').
verbo(en, 'sell',  tercera, plural,   'sell').

% ESP: encontrar
verbo(es, 'encuentro',    primera, singular, 'encontrar').
verbo(es, 'encuentras',   segunda, singular, 'encontrar').
verbo(es, 'encuentra',    tercera, singular, 'encontrar').
verbo(es, 'encontramos',  primera, plural,   'encontrar').
verbo(es, 'encontráis',   segunda, plural,   'encontrar').
verbo(es, 'encuentran',   tercera, plural,   'encontrar').

% EN: find
verbo(en, 'find',  primera, singular, 'find').
verbo(en, 'find',  segunda, singular, 'find').
verbo(en, 'finds', tercera, singular, 'find').
verbo(en, 'find',  primera, plural,   'find').
verbo(en, 'find',  segunda, plural,   'find').
verbo(en, 'find',  tercera, plural,   'find').

% ESP: perder
verbo(es, 'pierdo',    primera, singular, 'perder').
verbo(es, 'pierdes',   segunda, singular, 'perder').
verbo(es, 'pierde',    tercera, singular, 'perder').
verbo(es, 'perdemos',  primera, plural,   'perder').
verbo(es, 'perdéis',   segunda, plural,   'perder').
verbo(es, 'pierden',   tercera, plural,   'perder').

% EN: lose
verbo(en, 'lose',  primera, singular, 'lose').
verbo(en, 'lose',  segunda, singular, 'lose').
verbo(en, 'loses', tercera, singular, 'lose').
verbo(en, 'lose',  primera, plural,   'lose').
verbo(en, 'lose',  segunda, plural,   'lose').
verbo(en, 'lose',  tercera, plural,   'lose').

% ESP: caminar
verbo(es, 'camino',    primera, singular, 'caminar').
verbo(es, 'caminas',   segunda, singular, 'caminar').
verbo(es, 'camina',    tercera, singular, 'caminar').
verbo(es, 'caminamos', primera, plural,   'caminar').
verbo(es, 'camináis',  segunda, plural,   'caminar').
verbo(es, 'caminan',   tercera, plural,   'caminar').

% EN: walk
verbo(en, 'walk',  primera, singular, 'walk').
verbo(en, 'walk',  segunda, singular, 'walk').
verbo(en, 'walks', tercera, singular, 'walk').
verbo(en, 'walk',  primera, plural,   'walk').
verbo(en, 'walk',  segunda, plural,   'walk').
verbo(en, 'walk',  tercera, plural,   'walk').

% ESP: creer
verbo(es, 'creo',    primera, singular, 'creer').
verbo(es, 'crees',   segunda, singular, 'creer').
verbo(es, 'cree',    tercera, singular, 'creer').
verbo(es, 'creemos', primera, plural,   'creer').
verbo(es, 'creéis',  segunda, plural,   'creer').
verbo(es, 'creen',   tercera, plural,   'creer').

% EN: believe
verbo(en, 'believe',  primera, singular, 'believe').
verbo(en, 'believe',  segunda, singular, 'believe').
verbo(en, 'believes', tercera, singular, 'believe').
verbo(en, 'believe',  primera, plural,   'believe').
verbo(en, 'believe',  segunda, plural,   'believe').
verbo(en, 'believe',  tercera, plural,   'believe').

% ESP: entender
verbo(es, 'entiendo',    primera, singular, 'entender').
verbo(es, 'entiendes',   segunda, singular, 'entender').
verbo(es, 'entiende',    tercera, singular, 'entender').
verbo(es, 'entendemos',  primera, plural,   'entender').
verbo(es, 'entendéis',   segunda, plural,   'entender').
verbo(es, 'entienden',   tercera, plural,   'entender').

% EN: understand
verbo(en, 'understand',  primera, singular, 'understand').
verbo(en, 'understand',  segunda, singular, 'understand').
verbo(en, 'understands', tercera, singular, 'understand').
verbo(en, 'understand',  primera, plural,   'understand').
verbo(en, 'understand',  segunda, plural,   'understand').
verbo(en, 'understand',  tercera, plural,   'understand').

% ESP: decidir
verbo(es, 'decido',    primera, singular, 'decidir').
verbo(es, 'decides',   segunda, singular, 'decidir').
verbo(es, 'decide',    tercera, singular, 'decidir').
verbo(es, 'decidimos', primera, plural,   'decidir').
verbo(es, 'decidís',   segunda, plural,   'decidir').
verbo(es, 'deciden',   tercera, plural,   'decidir').

% EN: decide
verbo(en, 'decide',  primera, singular, 'decide').
verbo(en, 'decide',  segunda, singular, 'decide').
verbo(en, 'decides', tercera, singular, 'decide').
verbo(en, 'decide',  primera, plural,   'decide').
verbo(en, 'decide',  segunda, plural,   'decide').
verbo(en, 'decide',  tercera, plural,   'decide').

% ESP: salir
verbo(es, 'salgo',    primera, singular, 'salir').
verbo(es, 'sales',   segunda, singular, 'salir').
verbo(es, 'sale',    tercera, singular, 'salir').
verbo(es, 'salimos', primera, plural,   'salir').
verbo(es, 'salís',   segunda, plural,   'salir').
verbo(es, 'salen',   tercera, plural,   'salir').

% EN: leave
verbo(en, 'leave',  primera, singular, 'leave').
verbo(en, 'leave',  segunda, singular, 'leave').
verbo(en, 'leaves', tercera, singular, 'leave').
verbo(en, 'leave',  primera, plural,   'leave').
verbo(en, 'leave',  segunda, plural,   'leave').
verbo(en, 'leave',  tercera, plural,   'leave').

% ESP: abrir
verbo(es, 'abro',    primera, singular, 'abrir').
verbo(es, 'abres',   segunda, singular, 'abrir').
verbo(es, 'abre',    tercera, singular, 'abrir').
verbo(es, 'abrimos', primera, plural,   'abrir').
verbo(es, 'abrís',   segunda, plural,   'abrir').
verbo(es, 'abren',   tercera, plural,   'abrir').

% EN: open
verbo(en, 'open',  primera, singular, 'open').
verbo(en, 'open',  segunda, singular, 'open').
verbo(en, 'opens', tercera, singular, 'open').
verbo(en, 'open',  primera, plural,   'open').
verbo(en, 'open',  segunda, plural,   'open').
verbo(en, 'open',  tercera, plural,   'open').

% ESP: cerrar
verbo(es, 'cierro',    primera, singular, 'cerrar').
verbo(es, 'cierras',   segunda, singular, 'cerrar').
verbo(es, 'cierra',    tercera, singular, 'cerrar').
verbo(es, 'cerramos',  primera, plural,   'cerrar').
verbo(es, 'cerráis',   segunda, plural,   'cerrar').
verbo(es, 'cierran',   tercera, plural,   'cerrar').

% EN: close
verbo(en, 'close',  primera, singular, 'close').
verbo(en, 'close',  segunda, singular, 'close').
verbo(en, 'closes', tercera, singular, 'close').
verbo(en, 'close',  primera, plural,   'close').
verbo(en, 'close',  segunda, plural,   'close').
verbo(en, 'close',  tercera, plural,   'close').

% ESP: cocinar
verbo(es, 'cocino',    primera, singular, 'cocinar').
verbo(es, 'cocinas',   segunda, singular, 'cocinar').
verbo(es, 'cocina',    tercera, singular, 'cocinar').
verbo(es, 'cocinamos', primera, plural,   'cocinar').
verbo(es, 'cocináis',  segunda, plural,   'cocinar').
verbo(es, 'cocinan',   tercera, plural,   'cocinar').

% EN: cook
verbo(en, 'cook',  primera, singular, 'cook').
verbo(en, 'cook',  segunda, singular, 'cook').
verbo(en, 'cooks', tercera, singular, 'cook').
verbo(en, 'cook',  primera, plural,   'cook').
verbo(en, 'cook',  segunda, plural,   'cook').
verbo(en, 'cook',  tercera, plural,   'cook').

% ESP: beber
verbo(es, 'bebo',    primera, singular, 'beber').
verbo(es, 'bebes',   segunda, singular, 'beber').
verbo(es, 'bebe',    tercera, singular, 'beber').
verbo(es, 'bebemos', primera, plural,   'beber').
verbo(es, 'bebéis',  segunda, plural,   'beber').
verbo(es, 'beben',   tercera, plural,   'beber').

% EN: drink
verbo(en, 'drink',  primera, singular, 'drink').
verbo(en, 'drink',  segunda, singular, 'drink').
verbo(en, 'drinks', tercera, singular, 'drink').
verbo(en, 'drink',  primera, plural,   'drink').
verbo(en, 'drink',  segunda, plural,   'drink').
verbo(en, 'drink',  tercera, plural,   'drink').

% ESP: dibujar
verbo(es, 'dibujo',    primera, singular, 'dibujar').
verbo(es, 'dibujas',   segunda, singular, 'dibujar').
verbo(es, 'dibuja',    tercera, singular, 'dibujar').
verbo(es, 'dibujamos', primera, plural,   'dibujar').
verbo(es, 'dibujáis',  segunda, plural,   'dibujar').
verbo(es, 'dibujan',   tercera, plural,   'dibujar').

% EN: draw
verbo(en, 'draw',  primera, singular, 'draw').
verbo(en, 'draw',  segunda, singular, 'draw').
verbo(en, 'draws', tercera, singular, 'draw').
verbo(en, 'draw',  primera, plural,   'draw').
verbo(en, 'draw',  segunda, plural,   'draw').
verbo(en, 'draw',  tercera, plural,   'draw').

% ESP: dar
verbo(es, 'doy',      primera, singular, 'dar').
verbo(es, 'das',      segunda, singular, 'dar').
verbo(es, 'da',       tercera, singular, 'dar').
verbo(es, 'damos',    primera, plural,   'dar').
verbo(es, 'dais',     segunda, plural,   'dar').
verbo(es, 'dan',      tercera, plural,   'dar').

% EN: give
verbo(en, 'give',  primera, singular, 'give').
verbo(en, 'give',  segunda, singular, 'give').
verbo(en, 'gives', tercera, singular, 'give').
verbo(en, 'give',  primera, plural,   'give').
verbo(en, 'give',  segunda, plural,   'give').
verbo(en, 'give',  tercera, plural,   'give').

% ESP: recibir
verbo(es, 'recibo',    primera, singular, 'recibir').
verbo(es, 'recibes',   segunda, singular, 'recibir').
verbo(es, 'recibe',    tercera, singular, 'recibir').
verbo(es, 'recibimos', primera, plural,   'recibir').
verbo(es, 'recibís',   segunda, plural,   'recibir').
verbo(es, 'reciben',   tercera, plural,   'recibir').

% EN: receive
verbo(en, 'receive',  primera, singular, 'receive').
verbo(en, 'receive',  segunda, singular, 'receive').
verbo(en, 'receives', tercera, singular, 'receive').
verbo(en, 'receive',  primera, plural,   'receive').
verbo(en, 'receive',  segunda, plural,   'receive').
verbo(en, 'receive',  tercera, plural,   'receive').

% ESP: enviar
verbo(es, 'envío',    primera, singular, 'enviar').
verbo(es, 'envías',   segunda, singular, 'enviar').
verbo(es, 'envía',    tercera, singular, 'enviar').
verbo(es, 'enviamos', primera, plural,   'enviar').
verbo(es, 'enviáis',  segunda, plural,   'enviar').
verbo(es, 'envían',   tercera, plural,   'enviar').

% EN: send
verbo(en, 'send',  primera, singular, 'send').
verbo(en, 'send',  segunda, singular, 'send').
verbo(en, 'sends', tercera, singular, 'send').
verbo(en, 'send',  primera, plural,   'send').
verbo(en, 'send',  segunda, plural,   'send').
verbo(en, 'send',  tercera, plural,   'send').

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
