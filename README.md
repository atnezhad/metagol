This branch removes an implicit ordering constraint which ensures that goals are proved in terms of atoms lower in the ordering.

This changes allows for the learning of mutually recursive programs. For example, learning the definition of even by inventing
odd:

```prolog
even(A):-s(A,B),term_gt(A,B),even_1(B).
even(0).
even_1(A):-s(A,B),term_gt(A,B),even(B).
```

However, to guarantee termination of the meta-interpreter, you need to explicitly state an ordering in a metarule. For instance, the chain metarule should be defined as follows:

```prolog
metarule([P,Q,R],([P,A,B]:-[[Q,A,C],[R,C,B]]),FullSig):-
  metagol:lower_sig([P,A,B],_,FullSig,LowerSig),
  member(Q/2,LowerSig),
  member(R/2,LowerSig).
```

This ensures that the goals Q(A,C) and R(C,B) are lower in the ordering than P(A,B).