% Con clingo --text vemos solo el grounding
% segmento((0,0),(0,1)).
% segmento((0,1),(0,0)).

fila(0..N-1) :- size(N).
columna(0..N-1) :- size(N).

adyacente((X,Y),(X,Y+1)) :- fila(X), columna(Y), columna(Y+1).
adyacente((X,Y),(X+1,Y)) :- fila(X), fila(X+1), columna(Y).
% adyacente(P,P') :- adyacente(P',P).

{ segmento(P,P') } :- adyacente(P,P').
segmento(P, P') :- segmento(P', P).
usado(P) :- segmento(P,_).
usado(P) :- segmento(_,P).
% :- fila(X), columna(Y), not usado( (X,Y) ).

:- usado(P), #count{P': segmento(P,P') } != 2.

seg(P,P') :- segmento(P, P'), P<P'.

:- number(P,N), N!=0, not usado(P).

% Crear predicado que indique q si se usan dos puntos estan conectados, codigo hamiltonia (4 variables)
% conectado((x,y),(x',y')).
% Puede hacerse con conectado((x,y)) representando los puntos por el menor
% Crear restriccion para blancos y negros

#show segmento/2.