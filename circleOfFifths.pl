/*this program allows you to print the circle of fifths.
  to do this call circle(X). X will be the key you would like to generate
  the circle of fifths in. The first line printed is the outer circle the second line is
  the inner circle. To generate a major7 chord call genMajorChord(X) where X is the root note
  of the chord you would like to generate*/

/*
SAMPLE OUTPUT:

?- circle(c).
c g d a e b fSharp_gflat cSharp_dflat gSharp_aflat dSharp_eflat aSharp_bflat f
a e b fSharp_gflat cSharp_dflat gSharp_aflat dSharp_eflat aSharp_bflat f c g d
true.

?- genMajorChord(c).
c  e  g  b
true.

?- genMajorChord(d).
d  fSharp_gflat  a  cSharp_dflat
true.

?- 

*/



/*half step relations of each note*/
half(c,cSharp_dflat).
half(cSharp_dflat,d).
half(d, dSharp_eflat).
half(dSharp_eflat, e).
half(e, f).
half(f, fSharp_gflat).
half(fSharp_gflat, g).
half(g, gSharp_aflat).
half(gSharp_aflat, a).
half(a, aSharp_bflat).
half(aSharp_bflat, b).
half(b, c).

halfStep(X,Y) :- half(X,Y).

/*Define wholestep: two half steps*/
wholeStep(X,Y) :- half(X,Z), half(Z,Y).

/*Get the note fifth and sixth note of the X scale*/
getFifth(X,Y):- wholeStep(X,T), wholeStep(T,U), wholeStep(U,V), halfStep(V,Y).
getSixth(X,Y):- wholeStep(X,A), wholeStep(A,B), wholeStep(B,C), wholeStep(C,D), halfStep(D,Y).

/*circle of fifths helper method accepts root note X
  calls itself once two generate outer circle prints new line
  then gets the sixth note of the scale and calls itself again
  to generate inner circle */
circle(X):-
  circle(X,0),
  write("\n"),
  getSixth(X,Y),
  circle(Y,0).

/*base case ends recursion when all notes of the circle of fifths has been printed*/
circle(X,12):-!.

/*recursive case accepts current note X and iteration counter N
  adds one to N, gets the next fifth Y, outputs X(current fifth)
  calls itself with Y and NplusOne*/
circle(X,N):-
  NplusOne is N + 1,
  getFifth(X,Y),
  write(X), write(" "),
  circle(Y, NplusOne).

/*generates a major7 chord using the circle of fifths. The first call two itself returns
  two consecutive clockwise elements on the circle(root and fifth) of fifths outer circle,
  then calls getsixth and uses this sixth two call itself again in order to get the third and seventh
  notes of the chord, then prints the root, third, fifth and seventh notes */
genMajorChord(Root):-
  genMajorChord(Root, Fifth),
  getSixth(Root, Sixth),
  getFifth(Sixth, Third),
  genMajorChord(Third, Seventh),
  write(Root), write("  "), write(Third), write("  "), write(Fifth), write("  "), write(Seventh).

genMajorChord(X,Y):-
  getFifth(X,Y).
