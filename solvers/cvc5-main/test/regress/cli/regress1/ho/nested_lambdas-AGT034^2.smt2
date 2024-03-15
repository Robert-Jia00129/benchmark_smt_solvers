; COMMAND-LINE: --no-produce-models --ho-elim
; EXPECT: unsat

(set-logic HO_ALL)
(declare-sort $$unsorted 0)
(declare-sort mu 0)
(declare-fun meq_ind (mu mu $$unsorted) Bool)
(assert (= meq_ind (lambda ((X mu) (Y mu) (W $$unsorted)) (= X Y))))
(declare-fun meq_prop ((-> $$unsorted Bool) (-> $$unsorted Bool) $$unsorted) Bool)
(assert (= meq_prop (lambda ((X (-> $$unsorted Bool)) (Y (-> $$unsorted Bool)) (W $$unsorted)) (= (X W) (Y W)))))
(declare-fun mnot ((-> $$unsorted Bool) $$unsorted) Bool)
(assert (= mnot (lambda ((Phi (-> $$unsorted Bool)) (W $$unsorted)) (not (Phi W)))))
(declare-fun mor ((-> $$unsorted Bool) (-> $$unsorted Bool) $$unsorted) Bool)
(assert (= mor (lambda ((Phi (-> $$unsorted Bool)) (Psi (-> $$unsorted Bool)) (W $$unsorted)) (or (Phi W) (Psi W)))))
(declare-fun mand ((-> $$unsorted Bool) (-> $$unsorted Bool) $$unsorted) Bool)
(assert (= mand (lambda ((Phi (-> $$unsorted Bool)) (Psi (-> $$unsorted Bool)) (__flatten_var_0 $$unsorted)) (mnot (mor (mnot Phi) (mnot Psi)) __flatten_var_0))))
(declare-fun mimplies ((-> $$unsorted Bool) (-> $$unsorted Bool) $$unsorted) Bool)
(assert (= mimplies (lambda ((Phi (-> $$unsorted Bool)) (Psi (-> $$unsorted Bool)) (__flatten_var_0 $$unsorted)) (mor (mnot Phi) Psi __flatten_var_0))))
(declare-fun mimplied ((-> $$unsorted Bool) (-> $$unsorted Bool) $$unsorted) Bool)
(assert (= mimplied (lambda ((Phi (-> $$unsorted Bool)) (Psi (-> $$unsorted Bool)) (__flatten_var_0 $$unsorted)) (mor (mnot Psi) Phi __flatten_var_0))))
(declare-fun mequiv ((-> $$unsorted Bool) (-> $$unsorted Bool) $$unsorted) Bool)
(assert (= mequiv (lambda ((Phi (-> $$unsorted Bool)) (Psi (-> $$unsorted Bool)) (__flatten_var_0 $$unsorted)) (mand (mimplies Phi Psi) (mimplies Psi Phi) __flatten_var_0))))
(declare-fun mxor ((-> $$unsorted Bool) (-> $$unsorted Bool) $$unsorted) Bool)
(assert (= mxor (lambda ((Phi (-> $$unsorted Bool)) (Psi (-> $$unsorted Bool)) (__flatten_var_0 $$unsorted)) (mnot (mequiv Phi Psi) __flatten_var_0))))
(declare-fun mforall_ind ((-> mu $$unsorted Bool) $$unsorted) Bool)
(assert (= mforall_ind (lambda ((Phi (-> mu $$unsorted Bool)) (W $$unsorted)) (forall ((X mu)) (Phi X W) ))))
(declare-fun mforall_prop ((-> (-> $$unsorted Bool) $$unsorted Bool) $$unsorted) Bool)
(assert (= mforall_prop (lambda ((Phi (-> (-> $$unsorted Bool) $$unsorted Bool)) (W $$unsorted)) (forall ((P (-> $$unsorted Bool))) (Phi P W) ))))
(declare-fun mexists_ind ((-> mu $$unsorted Bool) $$unsorted) Bool)
(assert (= mexists_ind (lambda ((Phi (-> mu $$unsorted Bool)) (__flatten_var_0 $$unsorted)) (mnot (mforall_ind (lambda ((X mu) (__flatten_var_0 $$unsorted)) (mnot (Phi X) __flatten_var_0))) __flatten_var_0))))
(declare-fun mexists_prop ((-> (-> $$unsorted Bool) $$unsorted Bool) $$unsorted) Bool)
(assert (= mexists_prop (lambda ((Phi (-> (-> $$unsorted Bool) $$unsorted Bool)) (__flatten_var_0 $$unsorted)) (mnot (mforall_prop (lambda ((P (-> $$unsorted Bool)) (__flatten_var_0 $$unsorted)) (mnot (Phi P) __flatten_var_0))) __flatten_var_0))))
(declare-fun mtrue ($$unsorted) Bool)
(assert (= mtrue (lambda ((W $$unsorted)) true)))
(declare-fun mfalse ($$unsorted) Bool)
(assert (= mfalse (mnot mtrue)))
(declare-fun mbox ((-> $$unsorted $$unsorted Bool) (-> $$unsorted Bool) $$unsorted) Bool)
(assert (= mbox (lambda ((R (-> $$unsorted $$unsorted Bool)) (Phi (-> $$unsorted Bool)) (W $$unsorted)) (forall ((V $$unsorted)) (or (not (R W V)) (Phi V)) ))))
(declare-fun mdia ((-> $$unsorted $$unsorted Bool) (-> $$unsorted Bool) $$unsorted) Bool)
(assert (= mdia (lambda ((R (-> $$unsorted $$unsorted Bool)) (Phi (-> $$unsorted Bool)) (__flatten_var_0 $$unsorted)) (mnot (mbox R (mnot Phi)) __flatten_var_0))))
(declare-fun mreflexive ((-> $$unsorted $$unsorted Bool)) Bool)
(assert (= mreflexive (lambda ((R (-> $$unsorted $$unsorted Bool))) (forall ((S $$unsorted)) (R S S) ))))
(declare-fun msymmetric ((-> $$unsorted $$unsorted Bool)) Bool)
(assert (= msymmetric (lambda ((R (-> $$unsorted $$unsorted Bool))) (forall ((S $$unsorted) (T $$unsorted)) (=> (R S T) (R T S)) ))))
(declare-fun mserial ((-> $$unsorted $$unsorted Bool)) Bool)
(assert (= mserial (lambda ((R (-> $$unsorted $$unsorted Bool))) (forall ((S $$unsorted)) (exists ((T $$unsorted)) (R S T) ) ))))
(declare-fun mtransitive ((-> $$unsorted $$unsorted Bool)) Bool)
(assert (= mtransitive (lambda ((R (-> $$unsorted $$unsorted Bool))) (forall ((S $$unsorted) (T $$unsorted) (U $$unsorted)) (=> (and (R S T) (R T U)) (R S U)) ))))
(declare-fun meuclidean ((-> $$unsorted $$unsorted Bool)) Bool)
(assert (= meuclidean (lambda ((R (-> $$unsorted $$unsorted Bool))) (forall ((S $$unsorted) (T $$unsorted) (U $$unsorted)) (=> (and (R S T) (R S U)) (R T U)) ))))
(declare-fun mpartially_functional ((-> $$unsorted $$unsorted Bool)) Bool)
(assert (= mpartially_functional (lambda ((R (-> $$unsorted $$unsorted Bool))) (forall ((S $$unsorted) (T $$unsorted) (U $$unsorted)) (=> (and (R S T) (R S U)) (= T U)) ))))
(declare-fun mfunctional ((-> $$unsorted $$unsorted Bool)) Bool)
(assert (= mfunctional (lambda ((R (-> $$unsorted $$unsorted Bool))) (forall ((S $$unsorted)) (exists ((T $$unsorted)) (and (R S T) (forall ((U $$unsorted)) (=> (R S U) (= T U)) )) ) ))))
(declare-fun mweakly_dense ((-> $$unsorted $$unsorted Bool)) Bool)
(assert (= mweakly_dense (lambda ((R (-> $$unsorted $$unsorted Bool))) (forall ((S $$unsorted) (T $$unsorted) (U $$unsorted)) (=> (R S T) (exists ((U $$unsorted)) (and (R S U) (R U T)) )) ))))
(declare-fun mweakly_connected ((-> $$unsorted $$unsorted Bool)) Bool)
(assert (= mweakly_connected (lambda ((R (-> $$unsorted $$unsorted Bool))) (forall ((S $$unsorted) (T $$unsorted) (U $$unsorted)) (=> (and (R S T) (R S U)) (or (R T U) (= T U) (R U T))) ))))
(declare-fun mweakly_directed ((-> $$unsorted $$unsorted Bool)) Bool)
(assert (= mweakly_directed (lambda ((R (-> $$unsorted $$unsorted Bool))) (forall ((S $$unsorted) (T $$unsorted) (U $$unsorted)) (=> (and (R S T) (R S U)) (exists ((V $$unsorted)) (and (R T V) (R U V)) )) ))))
(declare-fun mvalid ((-> $$unsorted Bool)) Bool)
(assert (= mvalid (lambda ((Phi (-> $$unsorted Bool))) (forall ((W $$unsorted)) (Phi W) ))))
(declare-fun minvalid ((-> $$unsorted Bool)) Bool)
(assert (= minvalid (lambda ((Phi (-> $$unsorted Bool))) (forall ((W $$unsorted)) (not (Phi W)) ))))
(declare-fun msatisfiable ((-> $$unsorted Bool)) Bool)
(assert (= msatisfiable (lambda ((Phi (-> $$unsorted Bool))) (exists ((W $$unsorted)) (Phi W) ))))
(declare-fun mcountersatisfiable ((-> $$unsorted Bool)) Bool)
(assert (= mcountersatisfiable (lambda ((Phi (-> $$unsorted Bool))) (exists ((W $$unsorted)) (not (Phi W)) ))))
(declare-fun a1 ($$unsorted $$unsorted) Bool)
(declare-fun a2 ($$unsorted $$unsorted) Bool)
(declare-fun a3 ($$unsorted $$unsorted) Bool)
(declare-fun jan () mu)
(declare-fun piotr () mu)
(declare-fun cola () mu)
(declare-fun pepsi () mu)
(declare-fun beer () mu)
(declare-fun likes (mu mu $$unsorted) Bool)
(declare-fun very_much_likes (mu mu $$unsorted) Bool)
(declare-fun possibly_likes (mu mu $$unsorted) Bool)
(assert (mvalid (mbox a1 (likes jan cola))))
(assert (mvalid (mbox a1 (likes piotr pepsi))))
(assert (mvalid (mforall_ind (lambda ((X mu) (__flatten_var_0 $$unsorted)) (mbox a1 (mimplies (mdia a1 (likes X pepsi)) (likes X cola)) __flatten_var_0)))))
(assert (mvalid (mforall_ind (lambda ((X mu) (__flatten_var_0 $$unsorted)) (mbox a1 (mimplies (mdia a1 (likes X cola)) (likes X pepsi)) __flatten_var_0)))))
(assert (mvalid (mbox a2 (likes jan pepsi))))
(assert (mvalid (mbox a1 (likes piotr cola))))
(assert (mvalid (mbox a1 (likes piotr beer))))
(assert (mvalid (mforall_ind (lambda ((X mu) (__flatten_var_0 $$unsorted)) (mbox a2 (mimplies (likes X pepsi) (likes X cola)) __flatten_var_0)))))
(assert (mvalid (mforall_ind (lambda ((X mu) (__flatten_var_0 $$unsorted)) (mbox a2 (mimplies (likes X cola) (likes X pepsi)) __flatten_var_0)))))
(assert (mvalid (mbox a3 (likes jan cola))))
(assert (mvalid (mdia a3 (likes piotr pepsi))))
(assert (mvalid (mdia a1 (likes piotr beer))))
(assert (mvalid (mforall_ind (lambda ((X mu) (__flatten_var_0 $$unsorted)) (mforall_ind (lambda ((Y mu) (__flatten_var_0 $$unsorted)) (mbox a3 (mimplies (mand (likes X Y) (mand (mbox a1 (likes X Y)) (mbox a2 (likes X Y)))) (very_much_likes X Y)) __flatten_var_0)) __flatten_var_0)))))
(assert (mvalid (mforall_ind (lambda ((X mu) (__flatten_var_0 $$unsorted)) (mforall_ind (lambda ((Y mu) (__flatten_var_0 $$unsorted)) (mimplies (mbox a3 (very_much_likes X Y)) (very_much_likes X Y) __flatten_var_0)) __flatten_var_0)))))
(assert (mvalid (mforall_ind (lambda ((X mu) (__flatten_var_0 $$unsorted)) (mforall_ind (lambda ((Y mu) (__flatten_var_0 $$unsorted)) (mimplies (mdia a3 (very_much_likes X Y)) (likes X Y) __flatten_var_0)) __flatten_var_0)))))
(assert (mvalid (mforall_ind (lambda ((X mu) (__flatten_var_0 $$unsorted)) (mforall_ind (lambda ((Y mu) (__flatten_var_0 $$unsorted)) (mimplies (mdia a1 (likes X Y)) (possibly_likes X Y) __flatten_var_0)) __flatten_var_0)))))
(assert (mvalid (mforall_ind (lambda ((X mu) (__flatten_var_0 $$unsorted)) (mforall_ind (lambda ((Y mu) (__flatten_var_0 $$unsorted)) (mimplies (mdia a2 (likes X Y)) (possibly_likes X Y) __flatten_var_0)) __flatten_var_0)))))
(assert (mvalid (mforall_ind (lambda ((X mu) (__flatten_var_0 $$unsorted)) (mforall_ind (lambda ((Y mu) (__flatten_var_0 $$unsorted)) (mimplies (mdia a3 (likes X Y)) (possibly_likes X Y) __flatten_var_0)) __flatten_var_0)))))
(assert (not (mvalid (very_much_likes jan cola))))
(set-info :filename "AGT034^2")

(check-sat)
