(* 定理を書いて、tactic で証明する。n + 0 = n は定義から自明ではない (+ は左の引数で再帰する)。 *)
From Stdlib Require Import Arith.

Theorem add_zero_right : forall n : nat, n + 0 = n.
Proof.
  intro n.
  induction n as [| k IH].
  - reflexivity.            (* n = 0: 0 + 0 = 0 *)
  - simpl. rewrite IH.      (* n = S k: S (k + 0) = S k *)
    reflexivity.
Qed.

Check add_zero_right.
Print Assumptions add_zero_right.
