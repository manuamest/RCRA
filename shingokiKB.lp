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
seg(P,P') :- segmento(P, P'), P<P'.

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
mismo_sentido((X1, Y1), (X2, Y2), (X3, Y3)) :- fila(X1), fila(X2), fila(X3), columna(Y1), columna(Y2), columna(Y3), (X2-X1) = (X3-X2), (Y2-Y1) = (Y3-Y2).

% Regla para garantizar q la direccion de entrada y de salida son la misma
:- blanco(P), segmento(P, P1), segmento(P, P2), P1 != P2, not mismo_sentido(P1, P, P2).

% Comprueba si los dos segmentos del punto negro son perpendiculares
:- negro(P), segmento(P, P1), segmento(P, P2), P1 != P2, mismo_sentido(P1, P, P2).

%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

% Muestra el tamaño de la matriz
#show size/1.

% Solamente muestra los segmentos en la solucion
#show segmento/2.