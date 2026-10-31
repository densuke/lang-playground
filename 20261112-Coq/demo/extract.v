(* 「証明つきの関数」から OCaml を取り出す。
   insert / sort は「結果が整列していて、元の要素の並べ替えである」ことまで型で保証する。 *)
From Stdlib Require Import List Sorted Permutation Arith Lia ExtrOcamlBasic ExtrOcamlNatInt.
Import ListNotations.

Fixpoint insert (x : nat) (l : list nat) : list nat :=
  match l with
  | [] => [x]
  | y :: l' => if x <=? y then x :: l else y :: insert x l'
  end.

Fixpoint isort (l : list nat) : list nat :=
  match l with [] => [] | x :: l' => insert x (isort l') end.

Lemma insert_perm : forall x l, Permutation (x :: l) (insert x l).
Proof.
  intros x l. induction l as [| y l IH]; simpl.
  - apply Permutation_refl.
  - destruct (x <=? y).
    + apply Permutation_refl.
    + eapply perm_trans; [apply perm_swap |].
      apply perm_skip. exact IH.
Qed.

Lemma insert_sorted : forall x l, Sorted le l -> Sorted le (insert x l).
Proof.
  intros x l Hs. induction Hs as [| y l Hs IH Hr]; simpl.
  - repeat constructor.
  - destruct (x <=? y) eqn:E.
    + apply Nat.leb_le in E. constructor; [constructor; assumption | constructor; exact E].
    + apply Nat.leb_gt in E. constructor; [exact IH |].
      destruct Hr as [| z l' Hyz].
      * simpl. constructor. lia.
      * simpl. destruct (x <=? z); constructor; try lia.
Qed.

Theorem isort_correct : forall l, Sorted le (isort l) /\ Permutation l (isort l).
Proof.
  induction l as [| x l [IHs IHp]]; simpl.
  - split; constructor.
  - split.
    + apply insert_sorted. exact IHs.
    + eapply perm_trans; [| apply insert_perm]. apply perm_skip. exact IHp.
Qed.

Print Assumptions isort_correct.

Set Extraction Output Directory ".".
Extraction "isort.ml" isort.
