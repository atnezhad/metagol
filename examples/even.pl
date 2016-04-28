%% Learning biochemical reactions
:- use_module('../metagol').

s(10,9).
s(9,8).
s(8,7).
s(7,6).
s(6,5).
s(5,4).
s(4,3).
s(3,2).
s(2,1).
s(1,0).

prim(s/2).

%% METARULES
metarule([P,A],([P,A]:-[])).

%% WITHOUT P>Q ORDER CONSTRAINT, BUT WITH A>B CONSTRAINT
metarule([P,Q,R],([P,A]:-[[Q,A,B],@term_gt(A,B),[R,B]]),PS):-
  member(Q/2,PS),
  member(R/1,PS).

%% WITH P>Q ORDER CONSTRAINT
metarule([P,Q,R],([P,A]:-[[Q,A,B],[R,B]]),PS1):-
  metagol:lower_sig([P,A],_,PS1,PS2),
  member(Q/2,PS2),
  member(R/1,PS2).

%% LEARNING A REACTION SEQUENCE FROM INITIAL TO FINAL STATE
a :-
  Pos = [even(10),even(8),even(6),even(4),even(2)],
  Neg = [even(3)],
  learn(Pos,Neg,H),
  pprint(H).

term_gt(A,B):-
  ground(A),
  A@>B.