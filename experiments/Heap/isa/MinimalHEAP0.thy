theory MinimalHEAP0
imports Nat Finite_Set Set_Interval 
begin

type_synonym Loc = nat
type_synonym F0 = "Loc set"

definition 
  nat1 :: "nat \<Rightarrow> bool"
where
  (*<*) [iff]: (*>*) "nat1 n \<equiv> n > 0"

definition 
  locs_of :: "Loc \<Rightarrow> nat \<Rightarrow> (Loc set)"
where
  (*"locs_of l n \<equiv> (if nat1 n then { i. i \<ge> l \<and> i < (l + n) } else undefined)"*)  
  "locs_of l n \<equiv> (if nat1 n then {l ..< l+n} else undefined)"

definition 
  is_block :: "Loc \<Rightarrow> nat \<Rightarrow> (Loc set) \<Rightarrow> bool"
where
	"is_block l n ls \<equiv> nat1 n \<and> locs_of l n \<subseteq> ls"

definition 
  F0_inv :: "F0 \<Rightarrow> bool" 
where
  [intro!]: "F0_inv f \<equiv> finite f"

definition 
  new0_pre :: "F0 \<Rightarrow> nat \<Rightarrow> bool"
where
  "new0_pre f s \<equiv> (\<exists> l. (is_block l s f))"

definition
   new0_post :: "F0 \<Rightarrow> nat \<Rightarrow> F0 \<Rightarrow> Loc \<Rightarrow> bool"
where
   "new0_post f s f' r \<equiv> (is_block r s f) \<and> f' = f - (locs_of r s)"

definition 
   dispose0_pre :: "F0 \<Rightarrow> Loc \<Rightarrow> nat \<Rightarrow> bool"
where
  "dispose0_pre f d s \<equiv> locs_of d s \<inter> f = {}"

definition 
   dispose0_post :: "F0 \<Rightarrow> Loc \<Rightarrow> nat \<Rightarrow> F0 \<Rightarrow> bool"
where
   "dispose0_post f d s f' \<equiv> f' = f \<union> locs_of d s"

definition 
  PO_new0_fsb :: "bool"
where
  "PO_new0_fsb \<equiv> (\<forall> f s . F0_inv f \<and> nat1 s \<and> new0_pre f s \<longrightarrow> 
                        (\<exists> f' r' . new0_post f s f' r' \<and> F0_inv f'))"

definition
  PO_dispose0_fsb :: "bool"
where
  "PO_dispose0_fsb \<equiv> (\<forall> f d s . F0_inv f \<and> nat1 s \<and> dispose0_pre f d s \<longrightarrow> 
                        (\<exists> f' . dispose0_post f d s f' \<and> F0_inv f'))"

(*********************************************************************)
section {* Voila! Translate to Haskell please! *}

(*
export_code nat1 locs_of is_block (*F0_inv*) in Haskell module_name MinimalHEAP0 file "haskell/"
*)

lemma "PO_new0_fsb"
unfolding PO_new0_fsb_def
(* (prov_test FEAS new0) and \<not> (prov_test EXPOSE_POST new0) *)
unfolding new0_post_def
(* (prov_test EXPOSE_POST new0) and \<not> (prov_test FULLY_WITNESSED new0) *)
apply simp
(* ONE_POINT_WITNESS? *)
(* INV_BREAK_DOWN? + ONE_POINT_WITNESS *)
unfolding F0_inv_def
apply simp
(* STRUCTURAL_BREAK_DOWN + FULLY_WITNESSED *)
unfolding is_block_def 
apply simp
apply (intro allI impI, elim conjE)
oops

lemma "PO_new0_fsb"
unfolding PO_new0_fsb_def
(* (prov_test FEAS new0) and \<not> (prov_test EXPOSE_POST new0) *)
unfolding new0_post_def
(* (prov_test EXPOSE_POST new0) and \<not> (prov_test FULLY_WITNESSED new0) *)
apply simp
(* ONE_POINT_WITNESS? *)
(* INV_BREAK_DOWN? + ONE_POINT_WITNESS *)
unfolding F0_inv_def
apply simp
(* EXPOSE_PRE + STRUCTURAL_BREAKDOWN *)
unfolding new0_pre_def 
apply (intro allI impI, elim conjE exE)
(* FULLY_WITNESSED *)
apply (intro exI)
apply simp
done

end
