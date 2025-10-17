% pruebas.pl - Ejecuta pruebas automáticas para TranLog

:- consult('traductor.pl').

run_all_tests :-
    writeln('==== PRUEBAS: INGLÉS → ESPAÑOL ===='),
    prueba_traduccion(en, 'the cat runs'),
    prueba_traduccion(en, 'I eat food'),
    prueba_traduccion(en, 'the big cat runs'),
    prueba_traduccion(en, 'he has a book'),
    prueba_traduccion(en, 'she speaks'),
    prueba_parrafo_en_es,
    writeln(''),
    writeln('==== PRUEBAS: ESPAÑOL → INGLÉS ===='),
    prueba_traduccion(es, 'el gato corre'),
    prueba_traduccion(es, 'yo como comida'),
    prueba_traduccion(es, 'el gato grande corre'),
    prueba_traduccion(es, 'él tiene un libro'),
    prueba_traduccion(es, 'ella habla'),
    % Añadir un caso de párrafo ES→EN
    ParrafoEs = "El gato corre. Yo como comida. Ella habla.",
    writeln('--- Caso de prueba: Español → Inglés ---'),
    writeln('Entrada:'), writeln(ParrafoEs), writeln(''),
    ( traducir_parrafo(es, en, ParrafoEs, Trad) -> writeln('Traducción:'), writeln(Trad) ; writeln('Error') ),
    writeln('----------------------------------------').
