(* 「リストを 2 回ひっくり返すと元に戻る」を、標準ライブラリを使わず自分で書いた rev で証明する。 *)
Inductive list (A : Type) : Type :=
  | nil : list A
  | cons : A -> list A -> list A.
Arguments nil {A}.
Arguments cons {A}.

Fixpoint app {A} (xs ys : list A) : list A :=
  match xs with nil => ys | cons x xs' => cons x (app xs' ys) end.

Fixpoint rev {A} (xs : list A) : list A :=
  match xs with nil => nil | cons x xs' => app (rev xs') (cons x nil) end.

Lemma app_nil_r : forall A (xs : list A), app xs nil = xs.
Proof. intros A xs. induction xs; simpl; [reflexivity | rewrite IHxs; reflexivity]. Qed.

Lemma app_assoc : forall A (xs ys zs : list A), app (app xs ys) zs = app xs (app ys zs).
Proof. intros A xs ys zs. induction xs; simpl; [reflexivity | rewrite IHxs; reflexivity]. Qed.

Lemma rev_app : forall A (xs ys : list A), rev (app xs ys) = app (rev ys) (rev xs).
Proof.
  intros A xs ys. induction xs as [| x xs IH]; simpl.
  - rewrite app_nil_r. reflexivity.
  - rewrite IH. rewrite app_assoc. reflexivity.
Qed.

Theorem rev_rev : forall A (xs : list A), rev (rev xs) = xs.
Proof.
  intros A xs. induction xs as [| x xs IH]; simpl.
  - reflexivity.
  - rewrite rev_app. simpl. rewrite IH. reflexivity.
Qed.

Print Assumptions rev_rev.
