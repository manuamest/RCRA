fila(0..N-1) :- size(N).
columna(0..N-1) :- size(N).

adyacente((X,Y),(X,Y+1)) :- fila(X), columna(Y), columna(Y+1).
adyacente((X,Y),(X+1,Y)) :- fila(X), fila(X+1), columna(Y).

{ segmento(P,P') } :- adyacente(P,P').
segmento(P, P') :- segmento(P', P).
usado(P) :- segmento(P,_).
usado(P) :- segmento(_,P).

:- usado(P), #count{P': segmento(P,P') } != 2.

seg(P,P') :- segmento(P, P'), P<P'.

:- number(P,N), N!=0, not usado(P).

#show segmento/2.