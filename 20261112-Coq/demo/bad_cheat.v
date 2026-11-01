(* 途中で投げて Qed と書いても、残りがあれば通らない。 *)
Theorem and_swap : forall P Q : Prop, P /\ Q -> Q /\ P.
Proof.
  intros P Q H.
  destruct H as [HP HQ].
  split.
  - exact HQ.
Qed.
