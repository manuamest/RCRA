%# TODO: Crear recursividad para aligned
%#       Optimizar el codigo para que use una variable en lugar de dos siempre que se pueda



% Tamaño del tablero
fila(0..N-1) :- size(N).
columna(0..N-1) :- size(N).

% Posiciones adyacentes del tablero, verticales y horizontales
adyacente((X,Y),(X,Y+1)) :- fila(X), columna(Y), columna(Y+1).
adyacente((X,Y),(X+1,Y)) :- fila(X), fila(X+1), columna(Y).

% Indica que los segmentos son entre dos puntos adyacentes, puede ser vertical o horizontal
{ segmento(P,P') } :- adyacente(P,P').

% Si existe un segmento entre P y P' tambien existe entre P' y P
segmento(P, P') :- segmento(P', P).

% Indica si un punto esta siendo usado en un segmento
usado(P) :- segmento(P,_).
usado(P) :- segmento(_,P).

% Cada punto debe estar conectado unicamente a dos segmentos siempre
:- usado(P), #count{P': segmento(P,P') } != 2.

% Indica que si hay un segmento entre un punto menor que otro, no hay construir otro segmento
segmento(P,P') :- segmento(P, P'), P<P'.

% Indica que los numeros que no son 0 se estan utilizando
:- number(P,N), N!=0, not usado(P).

% Dos puntos estan conectados si estan unidos a traves de un segmento
conectado(P, P') :- segmento(P, P').
conectado(P, P') :- segmento(P, P'), conectado(P', P'').

% La relacion conectado es simetrica
conectado(P, P') :- conectado(P', P).

% Reglas para indicar que un punto puede alcanzar a otros a los que este conectado
reach(P, P') :- conectado(P, P').
reach(P, P'') :- reach(P, P'), conectado(P', P'').

% Regla que garantiza que todos los puntos usados alcanzan los demas puntos alcanzados
:- usado(P), usado(P'), P != P', not reach(P, P').


% Regla para identificar los colores de los puntos
blanco(P) :- number(P, N), N > 0.
negro(P) :- number(P, N), N < 0.

% Restriccion para verificar q mantienen la direccion
mismo_sentido((X1, Y1), (X2, Y2), (X3, Y3)) :- fila(X1), fila(X2), fila(X3), columna(Y1), columna(Y2), columna(Y3), X2-X1 = X3-X2, Y2-Y1 = Y3-Y2.

% Regla para garantizar q la direccion de entrada y de salida son la misma
:- blanco(P), segmento(P, P1), segmento(P, P2), P1 != P2, not mismo_sentido(P1, P, P2).

% Comprueba si los dos segmentos del punto negro son perpendiculares
:- negro(P), segmento(P, P1), segmento(P, P2), P1 != P2, mismo_sentido(P1, P, P2). 

% Regla para identificar los puntos con numeros diferentes de 0 
punto_con_numero(P, N) :- number(P, N), N != 0.

% Reglas para definir aligned
aligned(P, P1) :- punto_con_numero(P, _), segmento(P, P1).
aligned(P, P2) :- aligned(P, P1), segmento(P1, P2), mismo_sentido(P, P1, P2), P != P2.
aligned(P, P3) :- aligned(P, P1), segmento(P1, P2), segmento(P2, P3), mismo_sentido(P, P1, P2), mismo_sentido(P1, P2, P3), P != P3, P != P2.
aligned(P, P4) :- aligned(P, P1), segmento(P1, P2), segmento(P2, P3), segmento(P3, P4), mismo_sentido(P, P1, P2), mismo_sentido(P1, P2, P3), mismo_sentido(P2, P3, P4), P != P3, P != P2, P != P4.
aligned(P, P5) :- aligned(P, P1), segmento(P1, P2), segmento(P2, P3), segmento(P3, P4), segmento(P4, P5), mismo_sentido(P, P1, P2), mismo_sentido(P1, P2, P3), mismo_sentido(P2, P3, P4), mismo_sentido(P3, P4, P5), P != P4, P != P3, P != P2, P != P5.
aligned(P, P6) :- aligned(P, P1), segmento(P1, P2), segmento(P2, P3), segmento(P3, P4), segmento(P4, P5), segmento(P5, P6), mismo_sentido(P, P1, P2), mismo_sentido(P1, P2, P3), mismo_sentido(P2, P3, P4), mismo_sentido(P3, P4, P5), mismo_sentido(P4, P5, P6), P != P5, P != P4, P != P3, P != P2, P != P6.
aligned(P, P7) :- aligned(P, P1), segmento(P1, P2), segmento(P2, P3), segmento(P3, P4), segmento(P4, P5), segmento(P5, P6), segmento(P6, P7), mismo_sentido(P, P1, P2), mismo_sentido(P1, P2, P3), mismo_sentido(P2, P3, P4), mismo_sentido(P3, P4, P5), mismo_sentido(P4, P5, P6), mismo_sentido(P5, P6, P7), P != P6, P != P5, P != P4, P != P3, P != P2, P != P7.
aligned(P, P8) :- aligned(P, P1), segmento(P1, P2), segmento(P2, P3), segmento(P3, P4), segmento(P4, P5), segmento(P5, P6), segmento(P6, P7), segmento(P7, P8), mismo_sentido(P, P1, P2), mismo_sentido(P1, P2, P3), mismo_sentido(P2, P3, P4), mismo_sentido(P3, P4, P5), mismo_sentido(P4, P5, P6), mismo_sentido(P5, P6, P7), mismo_sentido(P6, P7, P8), P != P7, P != P6, P != P5, P != P4, P != P3, P != P2, P != P8.
aligned(P, P9) :- aligned(P, P1), segmento(P1, P2), segmento(P2, P3), segmento(P3, P4), segmento(P4, P5), segmento(P5, P6), segmento(P6, P7), segmento(P7, P8), segmento(P8, P9), mismo_sentido(P, P1, P2), mismo_sentido(P1, P2, P3), mismo_sentido(P2, P3, P4), mismo_sentido(P3, P4, P5), mismo_sentido(P4, P5, P6), mismo_sentido(P5, P6, P7), mismo_sentido(P6, P7, P8), mismo_sentido(P7, P8, P9), P != P7, P != P6, P != P5, P != P4, P != P3, P != P2, P != P8, P != P9.
aligned(P, P10) :- aligned(P, P1), segmento(P1, P2), segmento(P2, P3), segmento(P3, P4), segmento(P4, P5), segmento(P5, P6), segmento(P6, P7), segmento(P7, P8), segmento(P8, P9), segmento(P9, P10), mismo_sentido(P, P1, P2), mismo_sentido(P1, P2, P3), mismo_sentido(P2, P3, P4), mismo_sentido(P3, P4, P5), mismo_sentido(P4, P5, P6), mismo_sentido(P5, P6, P7), mismo_sentido(P6, P7, P8), mismo_sentido(P7, P8, P9), mismo_sentido(P8, P9, P10), P != P7, P != P6, P != P5, P != P4, P != P3, P != P2, P != P8, P != P9, P != P10.
aligned(P, P11) :- aligned(P, P1), segmento(P1, P2), segmento(P2, P3), segmento(P3, P4), segmento(P4, P5), segmento(P5, P6), segmento(P6, P7), segmento(P7, P8), segmento(P8, P9), segmento(P9, P10), segmento(P10, P11), mismo_sentido(P, P1, P2), mismo_sentido(P1, P2, P3), mismo_sentido(P2, P3, P4), mismo_sentido(P3, P4, P5), mismo_sentido(P4, P5, P6), mismo_sentido(P5, P6, P7), mismo_sentido(P6, P7, P8), mismo_sentido(P7, P8, P9), mismo_sentido(P8, P9, P10), mismo_sentido(P9, P10, P11), P != P7, P != P6, P != P5, P != P4, P != P3, P != P2, P != P8, P != P9, P != P10, P != P11.
aligned(P, P12) :- aligned(P, P1), segmento(P1, P2), segmento(P2, P3), segmento(P3, P4), segmento(P4, P5), segmento(P5, P6), segmento(P6, P7), segmento(P7, P8), segmento(P8, P9), segmento(P9, P10), segmento(P10, P11), segmento(P11, P12), mismo_sentido(P, P1, P2), mismo_sentido(P1, P2, P3), mismo_sentido(P2, P3, P4), mismo_sentido(P3, P4, P5), mismo_sentido(P4, P5, P6), mismo_sentido(P5, P6, P7), mismo_sentido(P6, P7, P8), mismo_sentido(P7, P8, P9), mismo_sentido(P8, P9, P10), mismo_sentido(P9, P10, P11), mismo_sentido(P10, P11, P12), P != P7, P != P6, P != P5, P != P4, P != P3, P != P2, P != P8, P != P9, P != P10, P != P11, P != P12.
aligned(P, P13) :- aligned(P, P1), segmento(P1, P2), segmento(P2, P3), segmento(P3, P4), segmento(P4, P5), segmento(P5, P6), segmento(P6, P7), segmento(P7, P8), segmento(P8, P9), segmento(P9, P10), segmento(P10, P11), segmento(P11, P12), segmento(P12, P13), mismo_sentido(P, P1, P2), mismo_sentido(P1, P2, P3), mismo_sentido(P2, P3, P4), mismo_sentido(P3, P4, P5), mismo_sentido(P4, P5, P6), mismo_sentido(P5, P6, P7), mismo_sentido(P6, P7, P8), mismo_sentido(P7, P8, P9), mismo_sentido(P8, P9, P10), mismo_sentido(P9, P10, P11), mismo_sentido(P10, P11, P12), mismo_sentido(P11, P12, P13), P != P7, P != P6, P != P5, P != P4, P != P3, P != P2, P != P8, P != P9, P != P10, P != P11, P != P12, P != P13.
aligned(P, P14) :- aligned(P, P1), segmento(P1, P2), segmento(P2, P3), segmento(P3, P4), segmento(P4, P5), segmento(P5, P6), segmento(P6, P7), segmento(P7, P8), segmento(P8, P9), segmento(P9, P10), segmento(P10, P11), segmento(P11, P12), segmento(P12, P13), segmento(P13, P14), mismo_sentido(P, P1, P2), mismo_sentido(P1, P2, P3), mismo_sentido(P2, P3, P4), mismo_sentido(P3, P4, P5), mismo_sentido(P4, P5, P6), mismo_sentido(P5, P6, P7), mismo_sentido(P6, P7, P8), mismo_sentido(P7, P8, P9), mismo_sentido(P8, P9, P10), mismo_sentido(P9, P10, P11), mismo_sentido(P10, P11, P12), mismo_sentido(P11, P12, P13), mismo_sentido(P12, P13, P14), P != P7, P != P6, P != P5, P != P4, P != P3, P != P2, P != P8, P != P9, P != P10, P != P11, P != P12, P != P13, P != P14.

% Regla para calcular la longitud dado un punto con numero
longitud(P, L, N) :- punto_con_numero(P, N), #count{Q:aligned(P, Q)} = L.

% Regla para comprobar si la longitud conincide con N
:- longitud(P, L, N), punto_con_numero(P, N), |N| != L.

% Muestra el tamaño de la matriz
#show size/1.

% Solamente muestra los segmentos en la solucion
#show segmento/2.