% ========================================
% TRANLOG - INTERFAZ MÍNIMA (menú simple)
% ========================================

:- set_prolog_flag(encoding, utf8).
% Carga de los tres modulos principales del Sistema Experto:
:- consult('base_datos.pl').
:- consult('bnf.pl').
:- consult('reglas.pl').

% ---- Interfaz: dos predicados públicos ----
translog_ei(EsStr, EnStr) :- traducir_con_bnf(es, EsStr, EnStr).
translog_ie(EnStr, EsStr) :- traducir_con_bnf(en, EnStr, EsStr).

% ---- Menú ----
iniciar :-
    limpiar_pantalla,
    writeln('================================'),
    writeln(''),
    writeln('   ¡Bienvenido a TransLog!'),
    writeln(''),
    writeln('================================'),
    writeln('Seleccione una opción:'),
    writeln('  1) Inglés -> Español'),
    writeln('  2) Español -> Inglés'),
    writeln('  3) Salir'),
    writeln('================================'),
    write('Opción: '),
    read_line_to_string(user_input, S),
    % Lógica del menú principal (usa corte y unificación)
    (   S="1" -> nl, modo(en, es)
    ;   S="2" -> nl, modo(es, en)
    ;   S="3" -> true
    ;   writeln('Opción inválida.'), iniciar
    ).

% Configura y entra al modo de conversación seleccionado
modo(IdO, IdD) :-
    limpiar_pantalla,
    idioma_nombre(IdO, NO),
    idioma_nombre(IdD, ND),
    separador,
    format('   Modo Conversación: ~w -> ~w~n', [NO, ND]),
    writeln('   Escriba "salir" para volver al menú'),
    separador,
    nl,
    format('TransLog: Bienvenido!, estoy listo para traducir de ~w a ~w~n', [NO, ND]),
    loop(IdO, IdD).

% Bucle de conversación (Motor de Interacción)
loop(IdO, IdD) :-
    write('Usuario: '),
    read_line_to_string(user_input, In),
    ( In = "salir" ->
        iniciar
    ; contiene_fin_oracion(In) ->
        ( traducir_parrafo(IdO, IdD, In, OutPar)
        -> format('TranLog: ~w~n', [OutPar])
        ;  writeln('TranLog: no se pudo traducir el párrafo')
        ),
        loop(IdO, IdD)
    ; ( traducir_con_bnf(IdO, In, Out)
        -> format('TranLog: ~w~n', [Out])
        ;  writeln('TranLog: no te entendí, podrías repetirlo?')
      ),
      loop(IdO, IdD)
    ).

% ¿El texto contiene fin de oración?
contiene_fin_oracion(S) :-
    sub_string(S, _, 1, _, "."); sub_string(S, _, 1, _, "?"); sub_string(S, _, 1, _, "!").

% Traduce un párrafo: separa por . ? ! y traduce cada oración
traducir_parrafo(IdO, IdD, Parrafo, ParrafoTrad) :-
    % separa por .?!, quita espacios alrededor
    split_string(Parrafo, ".?!", " \t\n\r", Oraciones0),
    exclude(=(""), Oraciones0, Oraciones),
    traducir_lista_oraciones(IdO, IdD, Oraciones, Traducciones),
    % vuelve a unir con espacios
    atomic_list_concat(Traducciones, ' ', ParrafoTrad).

% Caso base: lista vacía
traducir_lista_oraciones(_, _, [], []).
% Caso recursivo: traduce O, formatea y sigue con el resto Os
traducir_lista_oraciones(IdO, IdD, [O|Os], [Tfmt|Ts]) :-
    % intenta traducir; si falla, conserva original con marca
    (   traducir_con_bnf(IdO, O, T0)
    ->  atom_string(T1, T0)
    ;   format(string(T1), '[NO_TRAD] ~w', [O])
    ),
    % capitaliza primera letra y añade punto final (.)
    capitalizar_y_punct(T1, '.', Tfmt),
    traducir_lista_oraciones(IdO, IdD, Os, Ts).

% Capitaliza primera letra (si existe) y asegura puntuación final Punct ('.' o '?' o '!')
capitalizar_y_punct(Sin, Punct, Con) :-
    ( Sin = "" -> Con = ""
    ; sub_string(Sin, 0, 1, Rest, F),
      sub_string(Sin, 1, Rest, 0, R),
      string_upper(F, FU),
      string_concat(FU, R, Cap),
      ( ends_with_punct(Cap) -> Con = Cap
      ; string_concat(Cap, Punct, Con)
      )
    ).

% Verifica si una cadena termina con un signo de puntuación
ends_with_punct(S) :-
    sub_string(S, _, 1, 0, "."); sub_string(S, _, 1, 0, "?"); sub_string(S, _, 1, 0, "!").

% Limpiar pantalla (tolerante a fallo)
limpiar_pantalla :-
    (   current_prolog_flag(windows, true)
    ->  catch(shell('cmd /c cls'), _, true)
    ;   catch(shell('clear'), _, true)
    ), !.

separador :- writeln('----------------------------------------------').

% Utilidad de mapeo de nombres de idioma
idioma_nombre(en, 'Inglés').
idioma_nombre(es, 'Español').

