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
mismo_sentido((X1, Y1), (X2, Y2), (X3, Y3)) :- fila(X1), fila(X2), fila(X3), columna(Y1), columna(Y2), columna(Y3), X2-X1 = X3-X2, Y2-Y1 = Y3-Y2.

% Regla para garantizar q la direccion de entrada y de salida son la misma
:- blanco(P), segmento(P, P1), segmento(P, P2), P1 != P2, not mismo_sentido(P1, P, P2).

% Comprueba si los dos segmentos del punto negro son perpendiculares
negro(P) :- segmento(P, P1), segmento(P, P2), P1 != P2, mismo_sentido(P1, P, P2). 

% Regla para identificar los puntos con numeros diferentes de 0 
punto_con_numero(P, N) :- number(P, N), N != 0. 

% Regla para contar la longitud de las rectas que salen de un punto numerado
longitud(P, P', L) :- segmento(P, P'), L = 1.
longitud(P, P', L) :- segmento(P, P'), segmento(P', P''), P' != P'', mismo_sentido(P, P', P''), longitud(P', P'', L1), L = L1 + 1.

% Regla para calcular la suma de las longitudes de las dos rectas que salen de un punto numerado
suma_longitudes(P, S) :- punto_con_numero(P, N), longitud(P, P1, L1), longitud(P, P2, L2), P1 != P2, S = L1 + L2.

% Regla para comprobar que la suma de las longitudes de las dos rectas que salen de un punto numerado es igual al número del punto
%:- punto_con_numero(P, N), suma_longitudes(P, S), S != |N|.

#show suma_longitudes/2.

% Regla para indicar la longitud entre dos puntos adyacentes 
%longitud_segmento(P, P', 1) :- adyacente(P, P'), segmento(P, P'). 

% Regla para calcular la suma de las longitudes de los segmentos hasta cambiar de dirección desde un punto numerado 
%suma_longitud(P, P', L) :- longitud_segmento(P, P', L). 
%longitud_segmento(P, P', L) :- longitud_segmento(P, P', L1), suma_longitud(P', P'', L2), P != P'', L = L1 + L2. 

% Regla para definir una recta que termina en un punto P' 
%recta(P, P') :- segmento(P, P'), segmento(P', P''), not mismo_sentido(P, P', P''). 

% Regla para calcular la longitud de cada recta que sale de un punto numerado 
%longitud_recta(P, P', L) :- recta(P, P'), longitud_segmento(P, P', L). 

% Regla para calcular la longitud total de los segmentos que salen de un punto numerado 
%longitud_total(P, L) :- punto_con_numero(P, _), recta(P, P1), recta(P, P2), P1 != P2, longitud_recta(P, P1, L1), longitud_recta(P, P2, L2), L = L1 + L2. 

% Regla para comparar la longitud total de los segmentos que salen de un punto numerado con el número del punto 
%:- punto_con_numero(P, N), longitud_total(P, L), |N| != L. 

%#show longitud_total/2.


% Una recta consiste en dos puntos conectados con la misma dirección
%recta(P, P'') :- conectado(P, P'), conectado(P', P''), mismo_sentido(P, P', P'').

%suma_longitud_total(P, N, L1 + L2) :- punto_blanco_con_numero(P, N), recta(P, P1), recta(P, P2), P1 != P2, suma_longitud(P, P1, L1), suma_longitud(P, P2, L2).

% Regla para comprobar que la longitud total de un punto numerado coincide con el numero del punto
%:- punto_blanco_con_numero(P, N), longitud_total(P, T), N != T.
%#show suma_longitud_total/3.

% Regla para calcular la suma de las longitudes de los segmentos hasta cambiar de direccion desde un punto numerado

% Regla para sumar las longitudes de los dos segmentos que salen de un punto numerado

% Regla para comprobar que la longitud total de un punto numerado coincide con el numero del punto

% Regla para encontrar puntos adyacentes en una dirección
%adyacente_dir((X1, Y1), (X2, Y2), Dir) :- adyacente((X1, Y1), (X2, Y2)), mismo_sentido((X1, Y1), (X2, Y2), Dir).

% Regla auxiliar para obtener direcciones posibles a partir de un punto con número
%direccion_posible(P, Dir) :- punto_blanco_con_numero(P, N), adyacente_dir(P, _, Dir).

% Regla para calcular la longitud de la recta a partir de un punto con número en una dirección
%longitud_recta(P, Dir, 0) :- punto_blanco_con_numero(P, N), direccion_posible(P, Dir), not adyacente_dir(P, _, Dir).
%longitud_recta(P, Dir, L) :- punto_blanco_con_numero(P, N), direccion_posible(P, Dir), adyacente_dir(P, P_next, Dir), longitud_recta(P_next, Dir, L_next), L = 1 + L_next.

% Regla para calcular la longitud total de ambas rectas a partir de un punto con número
%longitud_total(P, L_total) :- punto_blanco_con_numero(P, N), longitud_recta(P, Dir1, L1), longitud_recta(P, Dir2, L2), Dir1 != Dir2, L_total = L1 + L2.

% Regla para verificar si el número de un punto coincide con su longitud total
%coincide_numero_longitud(P) :- punto_blanco_con_numero(P, N), longitud_total(P, L_total), N == L_total.

% Regla para verificar si todos los puntos con número cumplen la condición
%solucion_valida :- not punto_incorrecto.
%punto_incorrecto :- punto_blanco_con_numero(P, N), not coincide_numero_longitud(P).



%     Posiblemente incorrectas

% Restricción para garantizar que la suma de las longitudes de los segmentos sea correcta para todos los puntos blancos con número
%:- punto_blanco_con_numero(P, N), not suma_longitudes(P, N).

% Restricción para garantizar que la suma de las longitudes de los segmentos sea correcta para todos los puntos negros con número
%:- punto_negro_con_numero(P, |N|), not suma_longitudes(P, N).

%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++




% Regla para calcular la longitud de un camino entre dos puntos conectados
%longitud_segmento(P, P', L) :- reach(P, P'), L = 1, adyacente(P, P').
%longitud_segmento(P, P', L) :- reach(P, P'), L = L1 + 1, adyacente(P, P1), segmento(P, P1), longitud_segmento(P1, P', L1), mismo_sentido(P, P1, P1, P').

% Regla para calcular la suma de las longitudes de los segmentos rectos que salen de un círculo numerado
%suma_longitudes_rectas(P, N, L) :- punto_blanco_con_numero(P, N), segmento(P, P1), segmento(P, P2), P1 != P2, longitud_segmento(P, P1, L1), longitud_segmento(P, P2, L2), mismo_sentido(P, P1, P, P2), L = L1 + L2.

% Restricción para garantizar que el número en cada círculo blanco sea la suma de las longitudes de los dos segmentos que salen de ese círculo
%:- punto_blanco_con_numero(P, N), suma_longitudes_rectas(P, N, L), N != L.

% Regla para calcular la longitud de un camino entre dos puntos conectados
%longitud_camino(P, P', L) :- longitud_segmento(P, P', L).
%longitud_camino(P, P'', L + L') :- longitud_segmento(P, P'), conectado(P', P''), longitud_camino(P', P'', L'), P != P''.

% Regla para calcular la longitud total de los dos segmentos que salen de un círculo
%suma_longitudes(P, N, L1 + L2) :- punto_blanco_con_numero(P, N), segmento(P, P1), segmento(P, P2), P1 != P2, longitud_camino(P, P1, L1), longitud_camino(P, P2, L2).

% Restricción para garantizar que el número en cada círculo blanco sea la suma de las longitudes de los dos segmentos que salen de ese círculo
%:- punto_blanco_con_numero(P, N), suma_longitudes(P, N, L), N != L.



% suma_misma_direccion(P, Sum) :- punto_blanco_con_numero(P, N), N > 0, Sum = #sum { 1 : segmento(P, P'), segmento(P, P''), P' != P'', mismo_sentido(P', P, P'') }.
% Suma recursiva
%longitud_segmento(P, P'', L) :- segmento(P, P'), adyacente(P, P'), longitud_segmento(P', P'', L1), L = L1 + 1, adyacente(P', P''), mismo_sentido(P, P', P''), not segmento(P, P'').
%longitud(P, L) :- punto_blanco_con_numero(P, N), longitud_segmento(P, _, L).
%suma_longitudes(P, Total) :- punto_blanco_con_numero(P, _), Total = #sum{ L : longitud(P, L) }.

%suma_longitudes(P, Total) :- punto_blanco_con_numero(P, _), Total = #sum{ L, P': longitud(P, P', L) }.
%longitud(P, P', L) :- longitud_segmento(P, P', L).

% Función auxiliar para contar la longitud de un segmento
%longitud_segmento(P, P', L) :- reach(P, P'), L = 1, adyacente(P, P').
%longitud_segmento(P, P', L) :- reach(P, P'), L = L1 + 1, adyacente(P, P1), longitud_segmento(P1, P', L1).

% Función auxiliar para contar la longitud de un segmento en un solo sentido
%longitud_segmento_unidireccional(P, P', L) :- segmento(P, P'), L = 1.
%longitud_segmento_unidireccional(P, P', L) :- segmento(P, P1), longitud_segmento_unidireccional(P1, P', L1), L = L1 + 1, P != P'.

% Función auxiliar para contar la longitud de un segmento en ambos sentidos
%longitud_segmento(P, P', L) :- longitud_segmento_unidireccional(P, P', L).
%longitud_segmento(P, P', L) :- longitud_segmento_unidireccional(P', P, L).

% Regla para verificar si la suma de las longitudes de los dos segmentos que salen de un punto blanco es igual al número dentro del punto
%suma_longitudes_correcta(P, N) :- punto_blanco_con_numero(P, N), segmento(P, P1), segmento(P, P2),
%  P1 != P2, longitud_segmento(P, P1, L1), longitud_segmento(P, P2, L2), N = L1 + L2.

% Verificar si la suma de las longitudes de los segmentos que salen de un punto blanco con número es igual al número en ese punto
%:- punto_blanco_con_numero(P, N), #sum{L, P': longitud_segmento(P, P', L)} != N.

% Verificar si la suma de las longitudes de los segmentos que salen de un punto negro con número es igual al número en ese punto (considerando el valor positivo de N)
%:- punto_negro_con_numero(P, M), #sum{L, P': longitud_segmento(P, P', L)} != M.


%mismo_sentido((X1, Y1), (X2, Y2), (X3, Y3)) :- fila(X1), fila(X2), fila(X3), columna(Y1), columna(Y2), columna(Y3), (X2-X1) = (X3-X2), (Y2-Y1) = (Y3-Y2).
%mismo_sentido((X1, Y1), (X2, Y2), (X3, Y3)) :- fila(X1), fila(X2), fila(X3), columna(Y1), columna(Y2), columna(Y3), DX1 = X2-X1, DX2 = X3-X2, DX1 = DX2, Y1 = Y2, Y2 = Y3.
%mismo_sentido((X1, Y1), (X2, Y2), (X3, Y3)) :- fila(X1), fila(X2), fila(X3), columna(Y1), columna(Y2), columna(Y3), DY1 = Y2-Y1, DY2 = Y3-Y2, DY1 = DY2, X1 = X2, X2 = X3.

%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


% Muestra el tamaño de la matriz
#show size/1.

% Solamente muestra los segmentos en la solucion
#show segmento/2.