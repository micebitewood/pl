/*5.*/
join(john, tom).
join(tom, john).
join(tom, alice).

/*7.*/
setof(U, N^connection(john, U, N), User).

/*8.*/
connection(john, U, N).

/*12.*/
feed(john, M).

/*13.*/
recommend(cissy, User).