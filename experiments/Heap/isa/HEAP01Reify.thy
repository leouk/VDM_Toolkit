theory HEAP01Reify
imports HEAP1 
begin 

(*========================================================================*)
section {* Refinement L0-L1 definitions *}
(*========================================================================*)

(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)
subsubsection {* State reification definitions *}
(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

definition
  retr0 :: "F1 \<Rightarrow> F0"
where
  "retr0 f1 = locs f1"

definition 
  contiguous :: "nat set \<Rightarrow> bool"
where
  "contiguous F \<equiv> \<exists> m l . nat1 l \<and> F = locs_of m l"

definition
  non_abutting :: "nat set \<Rightarrow> nat set \<Rightarrow> bool"
where
  "non_abutting F F' \<equiv> (\<forall> x \<in> F . \<forall> y \<in> F' . x > y+1 \<or> y > x + 1)"

locale level01_new = level1_new + level0_new
locale level01_dispose = level1_dispose + level0_dispose

(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)
subsubsection {* VDM auxiliary functions *}
(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

(*========================================================================*)
section {* VDM proof obligations for L0-L1 refinement *}
(*========================================================================*)

text {* Because of the (yet to be resolved) locale dependency/usage, we will
        avoid adding locale-based POs
      *}

(* TODO: PUT in locale? *)
definition
  PO_l01_adequacy :: "bool"
where
  "PO_l01_adequacy \<equiv> (\<forall> f0 . F0_inv f0 \<longrightarrow> (\<exists>! f1. f0 = retr0 f1 \<and> F1_inv f1))"

(*
lemma "PO_l01_adequacy" 
unfolding PO_l01_adequacy_def
apply auto
unfolding retr0_def
defer
find_theorems "locs _ = locs _"
oops
*)

(* TODO: PUT in locale? Do it separate first to avoid confusion of assumptions across 4 locales! *)
definition 
  PO_l01_new_widen_pre :: "bool"
where
  "PO_l01_new_widen_pre \<equiv> (\<forall> f1 s1 . F1_inv f1 \<and> nat1 s1 \<and> new0_pre (retr0 f1) s1 \<longrightarrow> new1_pre f1 s1)"

definition 
  PO_l01_new_narrow_post :: "bool"
where
  "PO_l01_new_narrow_post \<equiv> (\<forall> f1 f1' s1 r . F1_inv f1 \<and> F1_inv f1' \<and> nat1 s1 \<and> 
                                 new0_pre (retr0 f1) s1 \<and> new1_post f1 s1 f1' r \<longrightarrow> new0_post (retr0 f1) s1 (retr0 f1') r)"

definition 
  PO_l01_dispose_widen_pre :: "bool"
where
  "PO_l01_dispose_widen_pre \<equiv> (\<forall> f1 d1 s1 . F1_inv f1 \<and> nat1 s1 \<and> 
                                    dispose0_pre (retr0 f1) d1 s1 \<longrightarrow> dispose1_pre f1 d1 s1)"

definition 
  PO_l01_dispose_narrow_post :: "bool"
where
  "PO_l01_dispose_narrow_post \<equiv> (\<forall> f1 f1' d1 s1 . F1_inv f1 \<and> F1_inv f1' \<and> nat1 s1 \<and> 
                                    dispose0_pre (retr0 f1) d1 s1 \<and> dispose1_post f1 d1 s1 f1' \<longrightarrow> 
                                        dispose0_post (retr0 f1) d1 s1 (retr0 f1'))"

unused_thms

(*
lemma (in level1_dispose) "False"
nitpick [show_all]
oops
lemma (in level1_new) "False"
nitpick [show_all]
oops
*)
(* NOTE: Nitpick trick to see if any axiom involved in the locales is inconsistent.
         i.e. if axioms are inconsistent, then we shouldn't be able to find a mode
         for False. If we do, then the axioms are conistent (i.e. it's unprovable 
         as it should be).
 *)
end
