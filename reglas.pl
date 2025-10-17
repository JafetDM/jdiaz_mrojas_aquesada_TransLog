:- ensure_loaded('base_datos.pl').

% ----------------------------------------
% Auxiliares
% ----------------------------------------
minuscula(Palabra, Minuscula) :-
    atom_codes(Palabra, Codigos),
    maplist(to_lower_code, Codigos, CodigosMin),
    atom_codes(Minuscula, CodigosMin).

to_lower_code(C, C) :- C >= 97, C =< 122, !.
to_lower_code(C, M) :- C >= 65, C =< 90, !, M is C + 32.
to_lower_code(C, C).

remover_puntuacion(Palabra, Limpia) :-
    atom_codes(Palabra, Codigos),
    include(no_es_puntuacion, Codigos, CodigosLimpios),
    atom_codes(Limpia, CodigosLimpios).

no_es_puntuacion(C) :- \+ member(C, [46,44,33,63,58,59,34,39]).

dividir_palabras(Oracion, Palabras) :-
    atomic_list_concat(Palabras, ' ', Oracion).

separar_puntuacion(Palabra, PalabraSin, Punc) :-
    atom_codes(Palabra, Codigos),
    ( Codigos \= [], last(Codigos, Ult),
      member(Ult, [46,44,33,63,58,59])
    -> atom_codes(Punc, [Ult]),
       append(CodigosSin, [Ult], Codigos),
       atom_codes(PalabraSin, CodigosSin)
    ;  PalabraSin = Palabra, Punc = '' ).

% ----------------------------------------
% Sintagmas Nominales
% ----------------------------------------
es_sintagma_nominal(Idioma, Palabra) :-
    minuscula(Palabra, PalMin),
    remover_puntuacion(PalMin, Limpia),
    ( articulo(Idioma, Limpia, _) ; pronombre(Idioma, Limpia, _)
    ; sustantivo(Idioma, Limpia, _) ; adjetivo(Idioma, Limpia, _) ).

extraer_sintagma_nominal(Idioma, [Palabra|Resto], [Palabra|SN], Restante) :-
    es_sintagma_nominal(Idioma, Palabra),
    extraer_sn_continuacion(Idioma, Resto, SN, Restante), !.
extraer_sintagma_nominal(_, Lista, [], Lista).

extraer_sn_continuacion(Idioma, [Palabra|Resto], [Palabra|SN], Restante) :-
    minuscula(Palabra, PalMin),
    remover_puntuacion(PalMin, Limpia),
    ( articulo(Idioma, Limpia, _) ; adjetivo(Idioma, Limpia, _) ), !,
    extraer_sn_continuacion(Idioma, Resto, SN, Restante).
extraer_sn_continuacion(Idioma, [Palabra|Resto], [Palabra], Resto) :-
    minuscula(Palabra, PalMin),
    remover_puntuacion(PalMin, Limpia),
    sustantivo(Idioma, Limpia, _), !.
extraer_sn_continuacion(_, Lista, [], Lista).

% ----------------------------------------
% Sintagmas Verbales
% ----------------------------------------
es_sintagma_verbal(Idioma, Palabra) :-
    minuscula(Palabra, PalMin),
    remover_puntuacion(PalMin, Limpia),
    verbo(Idioma, Limpia, _, _, _).

extraer_sintagma_verbal(Idioma, [Palabra|Resto], [Palabra|SV], Restante) :-
    es_sintagma_verbal(Idioma, Palabra),
    extraer_sv_continuacion(Resto, SV, Restante), !.
extraer_sintagma_verbal(_, Lista, [], Lista).

extraer_sv_continuacion([Palabra|Resto], [Palabra|SV], Restante) :-
    palabra_funcion(_, Palabra, _), !,
    extraer_sv_continuacion(Resto, SV, Restante).
extraer_sv_continuacion(Lista, [], Lista).

% ----------------------------------------
% Complementos
% ----------------------------------------
analizar_complementos(_, [], []).
analizar_complementos(Idioma, [Palabra|Resto], [Palabra|Comp]) :-
    preposicion(Idioma, Palabra, _), !,
    analizar_complementos(Idioma, Resto, Comp).
analizar_complementos(Idioma, [Palabra|Resto], [SN|Comp]) :-
    es_sintagma_nominal(Idioma, Palabra), !,
    extraer_sintagma_nominal(Idioma, [Palabra|Resto], SN, Resto2),
    analizar_complementos(Idioma, Resto2, Comp).
analizar_complementos(Idioma, [Palabra|Resto], [[Palabra]|Comp]) :-
    palabra_funcion(Idioma, Palabra, _), !,
    analizar_complementos(Idioma, Resto, Comp).
analizar_complementos(Idioma, [_|Resto], Comp) :-
    analizar_complementos(Idioma, Resto, Comp).

% ----------------------------------------
% Traducción
% ----------------------------------------
traducir_palabra(IdiomaOrigen, IdiomaDestino, Palabra, Traduccion) :-
    separar_puntuacion(Palabra, PalSin, Punc),
    minuscula(PalSin, PalMin),
    ( verbo(IdiomaOrigen, PalMin, Persona, Numero, InfOrigen),
      traduccion_verbo(InfOrigen, InfDestino),
      ( verbo(IdiomaDestino, FormaDestino, Persona, Numero, InfDestino)
        -> Traduccion0 = FormaDestino
        ;  Traduccion0 = InfDestino
      )
    -> true
    ; ( articulo(IdiomaOrigen, PalMin, Trad)
      ; pronombre(IdiomaOrigen, PalMin, Trad)
      ; sustantivo(IdiomaOrigen, PalMin, Trad)
      ; adjetivo(IdiomaOrigen, PalMin, Trad)
      ; preposicion(IdiomaOrigen, PalMin, Trad)
      ; palabra_funcion(IdiomaOrigen, PalMin, Trad)
      )
      -> Traduccion0 = Trad
      ; Traduccion0 = PalMin
    ),
    ( Punc = '' -> Traduccion = Traduccion0 ; atom_concat(Traduccion0, Punc, Traduccion) ).

traducir_palabras(_, _, [], []).
traducir_palabras(IdiomaOrigen, IdiomaDestino, [Palabra|Resto], [T|Traducidas]) :-
    traducir_palabra(IdiomaOrigen, IdiomaDestino, Palabra, T),
    traducir_palabras(IdiomaOrigen, IdiomaDestino, Resto, Traducidas).

traducir_oracion(IdiomaOrigen, IdiomaDestino, Oracion, OracionTraducida) :-
    dividir_palabras(Oracion, Palabras),
    traducir_palabras(IdiomaOrigen, IdiomaDestino, Palabras, PalabrasTraducidas),
    atomic_list_concat(PalabrasTraducidas, ' ', OracionTraducida).

% ----------------------------------------
% Detección de idioma
% ----------------------------------------
detectar_idioma(Palabra, Idioma) :-
    minuscula(Palabra, PalMin),
    remover_puntuacion(PalMin, Limpia),
    ( articulo(en, Limpia, _) ; pronombre(en, Limpia, _) ; sustantivo(en, Limpia, _)
    ; verbo(en, Limpia, _, _, _) ; adjetivo(en, Limpia, _) ; preposicion(en, Limpia, _)
    ; palabra_funcion(en, Limpia, _) ) -> Idioma = en ; Idioma = es.

traducir_automatico(Oracion, OracionTraducida) :-
    dividir_palabras(Oracion, [Primera|_]),
    detectar_idioma(Primera, IdiomaOrigen),
    ( IdiomaOrigen = en -> IdiomaDestino = es ; IdiomaDestino = en ),
    traducir_oracion(IdiomaOrigen, IdiomaDestino, Oracion, OracionTraducida).
