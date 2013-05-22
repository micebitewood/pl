/*1.*/
user(john).
user(tom).
user(alice).
user(cissy).

/*2.*/
requestJoin(john, tom).
requestJoin(alice, cissy).
requestJoin(john, cissy).
requestJoin(tom, alice).

/*3.*/
acceptJoin(tom, john).
acceptJoin(cissy, alice).
acceptJoin(cissy, john).

/*4.*/
join(X, Y):-requestJoin(X, Y), acceptJoin(Y, X).
join(X, Y):-requestJoin(Y, X), acceptJoin(X, Y).

/*9.*/
update(john, [hello, world]).
update(tom, [foo, bar]).
update(alice, [this, is, a, message]).
update(john, [this, is, also, a, message]).

/*10.*/
like(john, tom, [foo, bar]).
like(cissy, john, [hello, world]).

/*11.*/
feed(U, M):-update(UM, M), join(U, UM).
feed(U, M):-like(UM, UMM, M), join(U, UM).

/*13.*/
recommend(X, Y):-feed(X, M), update(Y, M), connection(X, Y, 2).