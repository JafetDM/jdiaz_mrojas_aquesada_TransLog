% ========================================
% TRANLOG - TRADUCTOR CONVERSACIONAL
% main.pl
% ========================================

% Cargar módulos
:- consult('base_datos.pl').
:- consult('bnf.pl').
:- consult('reglas.pl').

% ========================================
% INTERFAZ PRINCIPAL
% ========================================

% Iniciar el sistema
iniciar :-
    limpiar_pantalla,
    mostrar_banner,
    seleccionar_modo.

% Banner del sistema
mostrar_banner :-
    writeln(''),
    writeln('╔════════════════════════════════════════════╗'),
    writeln('║                                            ║'),
    writeln('║          🌐 TRANLOG SYSTEM 🌐              ║'),
    writeln('║    Traductor Conversacional Inteligente   ║'),
    writeln('║                                            ║'),
    writeln('╚════════════════════════════════════════════╝'),
    writeln('').

% Seleccionar modo de traducción
seleccionar_modo :-
    writeln('Seleccione el modo de traducción:'),
    writeln(''),
    writeln('  1. 🇬🇧 Inglés → Español (EI)'),
    writeln('  2. 🇪🇸 Español → Inglés (IE)'),
    writeln('  3. ❓ Ayuda'),
    writeln('  4. 🚪 Salir'),
    writeln(''),
        write('👉 Opción (escriba el número y pulse Enter): '),
        read_line_to_string(user_input, OptRaw),
        % aceptar entradas como "1" o "1." (el usuario no necesita poner el punto final)
        ( OptRaw = "" -> seleccionar_modo
        ; ( sub_string(OptRaw, _, 1, 0, ".") -> sub_string(OptRaw, 0, _, 1, OptStr) ; OptStr = OptRaw ),
            ( catch(number_string(Opcion, OptStr), _, fail)
            -> ejecutar_modo(Opcion)
            ; writeln('Entrada inválida. Ingrese 1, 2, 3 o 4.'), seleccionar_modo
            )
        ).

% Ejecutar modo seleccionado
ejecutar_modo(1) :-
    iniciar_conversacion(en, es, 'TranLogEI').

ejecutar_modo(2) :-
    iniciar_conversacion(es, en, 'TranLogIE').

ejecutar_modo(3) :-
    mostrar_ayuda,
    seleccionar_modo.

ejecutar_modo(4) :-
    despedirse.

ejecutar_modo(_) :-
    writeln(''),
    writeln('❌ Opción inválida. Intente de nuevo.'),
    writeln(''),
    seleccionar_modo.

% ========================================
% MODO CONVERSACIONAL
% ========================================

% Iniciar conversación
iniciar_conversacion(IdiomaOrigen, IdiomaDestino, NombreBot) :-
    limpiar_pantalla,
    format('~n╔════════════════════════════════════════════╗~n', []),
    format('║  Modo Conversacional: ~w~n', [NombreBot]),
    format('╚════════════════════════════════════════════╝~n~n', []),
    
    idioma_nombre(IdiomaOrigen, NombreOrigen),
    idioma_nombre(IdiomaDestino, NombreDestino),
    format('📝 Escriba en ~w y le responderé en ~w~n', [NombreOrigen, NombreDestino]),
    writeln('💡 Escriba "salir" para volver al menú principal'),
    writeln('💡 Escriba "ayuda" para ver comandos'),
    writeln(''),
    writeln('─────────────────────────────────────────────'),
    writeln(''),
    
    bucle_conversacion(IdiomaOrigen, IdiomaDestino, NombreBot).

% Bucle de conversación
bucle_conversacion(IdiomaOrigen, IdiomaDestino, NombreBot) :-
    write('Usuario: '),
    read_line_to_string(user_input, Entrada),
    atom_string(EntradaAtom, Entrada),
    
    (   procesar_comando(EntradaAtom, IdiomaOrigen, IdiomaDestino, NombreBot)
    ->  true
    ;   traducir_y_responder(EntradaAtom, IdiomaOrigen, IdiomaDestino, NombreBot),
        bucle_conversacion(IdiomaOrigen, IdiomaDestino, NombreBot)
    ).

% Procesar comandos especiales
procesar_comando('salir', _, _, _) :-
    writeln(''),
    writeln('👋 Volviendo al menú principal...'),
    writeln(''),
    sleep(1),
    seleccionar_modo.

procesar_comando('ayuda', IdiomaOrigen, IdiomaDestino, NombreBot) :-
    writeln(''),
    writeln('═══════════════════ AYUDA ═══════════════════'),
    writeln(''),
    writeln('📋 COMANDOS DISPONIBLES:'),
    writeln('  • salir    - Volver al menú principal'),
    writeln('  • ayuda    - Mostrar esta ayuda'),
    writeln('  • ejemplos - Ver ejemplos de oraciones'),
    writeln('  • bnf      - Mostrar gramática BNF'),
    writeln(''),
    writeln('📝 FORMATO DE ORACIONES:'),
    writeln('  • Pronombre + Verbo: "I run" / "Yo corro"'),
    writeln('  • Artículo + Sustantivo + Verbo: "The cat runs"'),
    writeln('  • Con adjetivos: "The big cat runs"'),
    writeln('  • Con objetos: "I eat food"'),
    writeln(''),
    writeln('═════════════════════════════════════════════'),
    writeln(''),
    bucle_conversacion(IdiomaOrigen, IdiomaDestino, NombreBot).

procesar_comando('ejemplos', IdiomaOrigen, IdiomaDestino, NombreBot) :-
    mostrar_ejemplos_conversacion(IdiomaOrigen),
    bucle_conversacion(IdiomaOrigen, IdiomaDestino, NombreBot).

procesar_comando('bnf', IdiomaOrigen, IdiomaDestino, NombreBot) :-
    mostrar_bnf,
    bucle_conversacion(IdiomaOrigen, IdiomaDestino, NombreBot).

% Traducir y responder
traducir_y_responder(Entrada, IdiomaOrigen, IdiomaDestino, NombreBot) :-
    % Si la entrada contiene varios signos de fin de oración, tratar como párrafo
    (   (sub_string(Entrada, _, 1, _, '.') ; sub_string(Entrada, _, 1, _, '?') ; sub_string(Entrada, _, 1, _, '!'))
    ->  (   traducir_parrafo(IdiomaOrigen, IdiomaDestino, Entrada, ParTrad)
        ->  format('~w: ~w~n~n', [NombreBot, ParTrad])
        ;   format('~w: ❌ No puedo traducir ese párrafo. Intente con otra entrada.~n~n', [NombreBot])
        )
    ;   % caso oración simple
        downcase_atom(Entrada, EntradaMin),
        (   traducir_con_bnf(IdiomaOrigen, EntradaMin, Traduccion)
        ->  format('~w: ~w~n~n', [NombreBot, Traduccion])
        ;   format('~w: ❌ No puedo traducir esa oración. Intente con otra.~n~n', [NombreBot]),
            writeln('💡 Consejo: Escriba "ejemplos" para ver oraciones válidas')
        )
    ).

% ========================================
% MOSTRAR INFORMACIÓN
% ========================================

% Mostrar gramática BNF
mostrar_bnf :-
    writeln(''),
    writeln('═══════════════ GRAMÁTICA BNF ═══════════════'),
    writeln(''),
    writeln('<oración> ::= <sintagma_nominal> <sintagma_verbal>'),
    writeln(''),
    writeln('<sintagma_nominal> ::= <determinante> <sustantivo>'),
    writeln('                     | <determinante> <adjetivo> <sustantivo>'),
    writeln('                     | <pronombre>'),
    writeln('                     | <sustantivo>'),
    writeln(''),
    writeln('<sintagma_verbal> ::= <verbo>'),
    writeln('                    | <verbo> <sintagma_nominal>'),
    writeln('                    | <verbo> <preposicion> <sintagma_nominal>'),
    writeln('                    | <verbo> <adjetivo>'),
    writeln(''),
    writeln('<determinante> ::= "the" | "a" | "an" | "el" | "la" | ...'),
    writeln('<pronombre> ::= "I" | "you" | "he" | "yo" | "tú" | ...'),
    writeln('<sustantivo> ::= "cat" | "dog" | "gato" | "perro" | ...'),
    writeln('<verbo> ::= "run" | "runs" | "eat" | "corro" | ...'),
    writeln('<adjetivo> ::= "big" | "small" | "grande" | ...'),
    writeln(''),
    writeln('═════════════════════════════════════════════'),
    writeln('').

% Mostrar ejemplos en conversación
mostrar_ejemplos_conversacion(en) :-
    writeln(''),
    writeln('═══════════ EJEMPLOS (Inglés) ═══════════════'),
    writeln(''),
    writeln('✅ Oraciones simples:'),
    writeln('   • I run'),
    writeln('   • The cat runs'),
    writeln('   • She eats'),
    writeln(''),
    writeln('✅ Con adjetivos:'),
    writeln('   • The big cat runs'),
    writeln('   • The small dog eats'),
    writeln(''),
    writeln('✅ Con objetos:'),
    writeln('   • I eat food'),
    writeln('   • He has a book'),
    writeln('   • The cat eats food'),
    writeln(''),
    writeln('═════════════════════════════════════════════'),
    writeln('').

mostrar_ejemplos_conversacion(es) :-
    writeln(''),
    writeln('═══════════ EJEMPLOS (Español) ══════════════'),
    writeln(''),
    writeln('✅ Oraciones simples:'),
    writeln('   • Yo corro'),
    writeln('   • El gato corre'),
    writeln('   • Ella come'),
    writeln(''),
    writeln('✅ Con adjetivos:'),
    writeln('   • El gato grande corre'),
    writeln('   • El perro pequeño come'),
    writeln(''),
    writeln('✅ Con objetos:'),
    writeln('   • Yo como comida'),
    writeln('   • Él tiene un libro'),
    writeln('   • El gato come comida'),
    writeln(''),
    writeln('═════════════════════════════════════════════'),
    writeln('').

% Mostrar ayuda general
mostrar_ayuda :-
    limpiar_pantalla,
    writeln(''),
    writeln('╔════════════════════════════════════════════╗'),
    writeln('║              AYUDA - TRANLOG               ║'),
    writeln('╚════════════════════════════════════════════╝'),
    writeln(''),
    writeln('📖 DESCRIPCIÓN:'),
    writeln('   TranLog es un sistema experto de traducción'),
    writeln('   que utiliza análisis sintáctico basado en BNF'),
    writeln('   para traducir oraciones entre inglés y español.'),
    writeln(''),
    writeln('🎯 CARACTERÍSTICAS:'),
    writeln('   ✓ Análisis gramatical con BNF'),
    writeln('   ✓ Traducción bidireccional (EN ↔ ES)'),
    writeln('   ✓ Manejo de sintagmas nominales y verbales'),
    writeln('   ✓ Conjugación verbal automática'),
    writeln('   ✓ Orden correcto de adjetivos por idioma'),
    writeln(''),
    writeln('💬 MODO CONVERSACIONAL:'),
    writeln('   • Escriba oraciones en lenguaje natural'),
    writeln('   • El sistema responderá con la traducción'),
    writeln('   • Use comandos especiales (ayuda, ejemplos, etc.)'),
    writeln(''),
    writeln('📚 Para ver la gramática BNF, seleccione un modo'),
    writeln('   y escriba "bnf" en la conversación.'),
    writeln(''),
    write('Presione ENTER para continuar...'),
    get_char(_),
    writeln('').

% ========================================
% UTILIDADES
% ========================================

% Nombres de idiomas
idioma_nombre(en, 'Inglés').
idioma_nombre(es, 'Español').

% Limpiar pantalla (multiplataforma)
limpiar_pantalla :-
    (   current_prolog_flag(windows, true)
    ->  shell('cls')
    ;   shell('clear')
    ).

% Despedida
despedirse :-
    writeln(''),
    writeln('╔════════════════════════════════════════════╗'),
    writeln('║                                            ║'),
    writeln('║        👋 ¡Gracias por usar TranLog! 👋    ║'),
    writeln('║                                            ║'),
    writeln('║         Sistema Experto de Traducción     ║'),
    writeln('║              Hasta pronto 🌟               ║'),
    writeln('║                                            ║'),
    writeln('╚════════════════════════════════════════════╝'),
    writeln('').

% ========================================
% PRUEBAS DEL SISTEMA
% ========================================

% Ejecutar suite de pruebas
ejecutar_pruebas :-
    writeln(''),
    writeln('╔════════════════════════════════════════════╗'),
    writeln('║         EJECUTANDO PRUEBAS DEL SISTEMA     ║'),
    writeln('╚════════════════════════════════════════════╝'),
    writeln(''),
    
    writeln('🧪 PRUEBAS INGLÉS → ESPAÑOL:'),
    writeln('─────────────────────────────────────────────'),
    prueba_traduccion(en, 'the cat runs'),
    prueba_traduccion(en, 'I eat food'),
    prueba_traduccion(en, 'the big cat runs'),
    prueba_traduccion(en, 'he has a book'),
    prueba_traduccion(en, 'she speaks'),
    prueba_traduccion(en, 'we have a house'),
    
    writeln(''),
    writeln('🧪 PRUEBAS ESPAÑOL → INGLÉS:'),
    writeln('─────────────────────────────────────────────'),
    prueba_traduccion(es, 'el gato corre'),
    prueba_traduccion(es, 'yo como comida'),
    prueba_traduccion(es, 'el gato grande corre'),
    prueba_traduccion(es, 'él tiene un libro'),
    prueba_traduccion(es, 'ella habla'),
    prueba_traduccion(es, 'nosotros tenemos una casa'),
    
    writeln(''),
    writeln('✅ Pruebas completadas'),
    writeln('').

% Ejecutar una prueba individual
prueba_traduccion(Idioma, Oracion) :-
    format('   📝 "~w" → ', [Oracion]),
    (   traducir_con_bnf(Idioma, Oracion, Traduccion)
    ->  format('✓ "~w"~n', [Traduccion])
    ;   writeln('✗ ERROR')
    ).

% Validar gramática de una oración
validar_oracion(Idioma, Oracion) :-
    writeln(''),
    write('Validando: "'), write(Oracion), writeln('"'),
    (   parsear_oracion_bnf(Idioma, Oracion, Estructura)
    ->  writeln('✅ Oración gramaticalmente correcta'),
        writeln(''),
        writeln('Estructura sintáctica:'),
        pretty_print_estructura(Estructura, 2)
    ;   writeln('❌ Oración no válida según la gramática BNF')
    ),
    writeln('').

% Imprimir estructura de forma legible
pretty_print_estructura(oracion(SN, SV), Indent) :-
    tab(Indent), writeln('ORACIÓN:'),
    IndentSN is Indent + 2,
    pretty_print_sn(SN, IndentSN),
    pretty_print_sv(SV, IndentSN).

pretty_print_sn(sn(pron(P)), Indent) :-
    tab(Indent), format('SN: Pronombre(~w)~n', [P]).

pretty_print_sn(sn(sust(S)), Indent) :-
    tab(Indent), format('SN: Sustantivo(~w)~n', [S]).

pretty_print_sn(sn(det(D), sust(S)), Indent) :-
    tab(Indent), writeln('SN:'),
    IndentNuevo is Indent + 2,
    tab(IndentNuevo), format('Det: ~w~n', [D]),
    tab(IndentNuevo), format('Sust: ~w~n', [S]).

pretty_print_sn(sn(det(D), adj(A), sust(S)), Indent) :-
    tab(Indent), writeln('SN:'),
    IndentNuevo is Indent + 2,
    tab(IndentNuevo), format('Det: ~w~n', [D]),
    tab(IndentNuevo), format('Adj: ~w~n', [A]),
    tab(IndentNuevo), format('Sust: ~w~n', [S]).

pretty_print_sn(sn(det(D), sust(S), adj(A)), Indent) :-
    tab(Indent), writeln('SN:'),
    IndentNuevo is Indent + 2,
    tab(IndentNuevo), format('Det: ~w~n', [D]),
    tab(IndentNuevo), format('Sust: ~w~n', [S]),
    tab(IndentNuevo), format('Adj: ~w~n', [A]).

pretty_print_sv(sv(verbo(V, Pers, Num, Inf)), Indent) :-
    tab(Indent), writeln('SV:'),
    IndentNuevo is Indent + 2,
    tab(IndentNuevo), format('Verbo: ~w (~w, ~w, inf:~w)~n', [V, Pers, Num, Inf]).

pretty_print_sv(sv(verbo(V, Pers, Num, Inf), SN), Indent) :-
    tab(Indent), writeln('SV:'),
    IndentNuevo is Indent + 2,
    tab(IndentNuevo), format('Verbo: ~w (~w, ~w, inf:~w)~n', [V, Pers, Num, Inf]),
    tab(IndentNuevo), writeln('Objeto Directo:'),
    IndentSN is IndentNuevo + 2,
    pretty_print_sn(SN, IndentSN).

pretty_print_sv(sv(verbo(V, Pers, Num, Inf), prep(P), SN), Indent) :-
    tab(Indent), writeln('SV:'),
    IndentNuevo is Indent + 2,
    tab(IndentNuevo), format('Verbo: ~w (~w, ~w, inf:~w)~n', [V, Pers, Num, Inf]),
    tab(IndentNuevo), format('Preposición: ~w~n', [P]),
    tab(IndentNuevo), writeln('Complemento:'),
    IndentSN is IndentNuevo + 2,
    pretty_print_sn(SN, IndentSN).

pretty_print_sv(sv(verbo(V, Pers, Num, Inf), adj(A)), Indent) :-
    tab(Indent), writeln('SV:'),
    IndentNuevo is Indent + 2,
    tab(IndentNuevo), format('Verbo: ~w (~w, ~w, inf:~w)~n', [V, Pers, Num, Inf]),
    tab(IndentNuevo), format('Atributo: ~w~n', [A]).

% ========================================
% MODO DEMOSTRACIÓN
% ========================================

% Demo interactiva del sistema
demo :-
    limpiar_pantalla,
    writeln(''),
    writeln('╔════════════════════════════════════════════╗'),
    writeln('║            DEMO INTERACTIVA                ║'),
    writeln('╚════════════════════════════════════════════╝'),
    writeln(''),
    writeln('Esta demostración mostrará las capacidades de TranLog'),
    writeln(''),
    write('Presione ENTER para comenzar...'),
    get_char(_),
    
    % Demo 1: Traducción simple
    writeln(''),
    writeln('═══════════════════════════════════════════════'),
    writeln('DEMO 1: Traducción Simple'),
    writeln('═══════════════════════════════════════════════'),
    demo_traduccion(en, 'the cat runs', 'Oración básica'),
    
    % Demo 2: Con adjetivos
    writeln(''),
    writeln('═══════════════════════════════════════════════'),
    writeln('DEMO 2: Manejo de Adjetivos'),
    writeln('═══════════════════════════════════════════════'),
    demo_traduccion(en, 'the big cat runs', 'Adjetivo antes (inglés) → después (español)'),
    
    % Demo 3: Con objetos
    writeln(''),
    writeln('═══════════════════════════════════════════════'),
    writeln('DEMO 3: Verbos Transitivos'),
    writeln('═══════════════════════════════════════════════'),
    demo_traduccion(en, 'I eat food', 'Verbo + Objeto directo'),
    
    % Demo 4: Análisis sintáctico
    writeln(''),
    writeln('═══════════════════════════════════════════════'),
    writeln('DEMO 4: Análisis Sintáctico BNF'),
    writeln('═══════════════════════════════════════════════'),
    validar_oracion(en, 'the big cat runs'),
    
    writeln(''),
    writeln('✅ Demo completada'),
    writeln(''),
    write('Presione ENTER para volver al menú...'),
    get_char(_),
    seleccionar_modo.

demo_traduccion(Idioma, Oracion, Descripcion) :-
    writeln(''),
    format('📌 ~w~n', [Descripcion]),
    format('   Entrada: "~w"~n', [Oracion]),
    (   traducir_con_bnf(Idioma, Oracion, Traduccion)
    ->  format('   Salida:  "~w"~n', [Traduccion])
    ;   writeln('   ❌ Error en traducción')
    ),
    writeln('').

% =========================
% TRADUCCIÓN DE PÁRRAFOS
% =========================

% traducir_parrafo(+IdiomaOrigen, +IdiomaDestino, +ParrafoTexto, -ParrafoTraducido)
% Divide el párrafo en oraciones y traduce cada una con traducir_con_bnf/3.
traducir_parrafo(IdO, IdD, Parrafo, ParrafoTrad) :-
    % dividir en oraciones por . ? ! (separadores), eliminando espacios
    split_string(Parrafo, ".?!", " \t\n", OracionesRaw),
    exclude(=(""), OracionesRaw, Oraciones),
    traducir_lista_oraciones(IdO, IdD, Oraciones, TraduccionesRaw),
    % Capitalizar y añadir puntuación apropiada a cada oración traducida
    maplist(formatear_oracion_traducida, TraduccionesRaw, TraduccionesFormateadas),
    atomic_list_concat(TraduccionesFormateadas, ' ', ParrafoTrad).

traducir_lista_oraciones(_, _, [], []).
traducir_lista_oraciones(IdO, IdD, [O|Os], [T|Ts]) :-
        (   traducir_con_bnf(IdO, O, T0)
        ->  (   atom(T0) -> atom_string(T0, Tstr) ; Tstr = T0 ),
                T = Tstr
        ;   format(string(T), '[NO_TRAD] ~w', [O])
        ),
    traducir_lista_oraciones(IdO, IdD, Os, Ts).

% formatear_oracion_traducida(+OracionRawString, -OracionFormateadaAtom)
% Capitaliza la primera letra, añade punto final si hace falta.
formatear_oracion_traducida(OracionRaw, OracionForm) :-
        % Aceptar átomos y strings
        ( atom(OracionRaw) -> atom_string(OracionRaw, S) ; S = OracionRaw ),
        ( S == "" -> OracionForm = '' ;
            % Separar primera letra y resto
            string_length(S, Len),
            ( Len =:= 0 -> OracionForm = '' ;
                sub_string(S, 0, 1, RestLen, FirstChar),
                sub_string(S, 1, RestLen, 0, Rest),
                string_upper(FirstChar, FirstU),
                string_concat(FirstU, Rest, Cap),
                ( sub_string(Cap, _, 1, 0, ".") ; sub_string(Cap, _, 1, 0, "?") ; sub_string(Cap, _, 1, 0, "!")
                -> OracionForm = Cap
                ;  string_concat(Cap, ".", OracionForm)
                )
            )
        ).

% =========================
% CASO DE PRUEBA: PÁRRAFO DE 3 ORACIONES
% =========================

prueba_parrafo_en_es :-
    Parrafo = "The cat runs. I eat food. She speaks.",
    writeln('--- Caso de prueba: Inglés → Español ---'),
    writeln('Entrada:'), writeln(Parrafo), writeln(''),
    (   traducir_parrafo(en, es, Parrafo, Trad)
    ->  writeln('Traducción:'), writeln(Trad)
    ;   writeln('Error traduciendo el párrafo')
    ),
    writeln('----------------------------------------').


% ========================================
% MENSAJE DE BIENVENIDA AL CARGAR
% ========================================

:- initialization((
    writeln(''),
    writeln('╔════════════════════════════════════════════╗'),
    writeln('║                                            ║'),
    writeln('║          🌐 TRANLOG SYSTEM 🌐              ║'),
    writeln('║    Sistema Experto de Traducción          ║'),
    writeln('║              Cargado ✓                     ║'),
    writeln('║                                            ║'),
    writeln('╚════════════════════════════════════════════╝'),
    writeln(''),
    writeln('📚 Comandos disponibles:'),
    writeln('   • iniciar.          - Iniciar interfaz conversacional'),
    writeln('   • demo.             - Ver demostración interactiva'),
    writeln('   • ejecutar_pruebas. - Ejecutar suite de pruebas'),
    writeln('   • mostrar_bnf.      - Ver gramática BNF'),
    writeln(''),
    writeln('💡 Escriba "iniciar." para comenzar'),
    writeln('')
)).