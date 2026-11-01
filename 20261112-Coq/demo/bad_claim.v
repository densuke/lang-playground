(* 偽の主張は証明できない。Qed が通らず失敗する。 *)
From Stdlib Require Import Arith.

Theorem add_one_same : forall n : nat, n + 1 = n.
Proof.
  intro n.
  induction n as [| k IH].
  - simpl. reflexivity.   (* 0 + 1 = 0 は成り立たない *)
  - simpl. rewrite IH. reflexivity.
Qed.
