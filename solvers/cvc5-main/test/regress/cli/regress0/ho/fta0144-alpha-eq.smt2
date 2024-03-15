; EXPECT: unsat
(set-logic HO_ALL)
(declare-sort Nat$ 0)
(declare-sort Complex$ 0)
(declare-sort Real_set$ 0)
(declare-fun g$ (Nat$) Complex$)
(declare-fun r$ () Real)
(declare-fun uu$ (Real Real) Real)
(declare-fun uua$ (Real_set$ Real) Bool)
(declare-fun less$ (Nat$ Nat$) Bool)
(declare-fun norm$ (Complex$) Real)
(declare-fun zero$ () Complex$)
(declare-fun minus$ (Complex$ Complex$) Complex$)
(declare-fun norm$a (Real) Real)
(declare-fun zero$a () Nat$)
(declare-fun set.member$ (Real Real_set$) Bool)
(declare-fun minus$a (Nat$ Nat$) Nat$)
(declare-fun thesis$ () Bool)
(declare-fun collect$ ((-> Real Bool)) Real_set$)
(declare-fun less_eq$ (Nat$ Nat$) Bool)
(declare-fun strict_mono$ ((-> Nat$ Nat$)) Bool)
(declare-fun strict_mono$a ((-> Real Real)) Bool)
(declare-fun strict_mono$b ((-> Nat$ Real)) Bool)
(declare-fun strict_mono$c ((-> Real Nat$)) Bool)
(assert (! (not thesis$) :named a2))
(assert (! (forall ((?v0 (-> Nat$ Nat$)) (?v1 Complex$)) (=> (and true (forall ((?v2 Real)) (=> true (exists ((?v3 Nat$)) (forall ((?v4 Nat$)) (=> (less_eq$ ?v3 ?v4) (< (norm$ (minus$ (g$ (?v0 ?v4)) ?v1)) ?v2))))))) thesis$)) :named a3))
(assert (! (exists ((?v0 (-> Nat$ Nat$)) (?v1 Complex$)) (and true (forall ((?v2 Real)) (=> true (exists ((?v3 Nat$)) (forall ((?v4 Nat$)) (=> (less_eq$ ?v3 ?v4) (< (norm$ (minus$ (g$ (?v0 ?v4)) ?v1)) ?v2)))))))) :named a4))
(check-sat)
