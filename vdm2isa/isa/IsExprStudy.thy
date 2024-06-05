theory IsExprStudy
imports VDMToolkit
begin

lemma "\<not> isTest' (-10)
        (\<lambda> x . if inv_VDMNat x then Some x else None) 
        inv_VDMNat"
  unfolding isTest'_def inv_VDMNat_def by simp

lemma "isTest' [1,2,3::VDMNat] 
        (\<lambda> x . Some { x$i | i . i \<in> inds x }) 
        (inv_VDMSet' inv_VDMNat)"
  unfolding isTest'_def
  apply simp
  unfolding inv_VDMSet'_def inv_VDMSet_def inv_VDMNat_def inv_SetElems_def
  apply (simp, safe)
  unfolding applyVDMSeq_def inv_VDMNat1_def len_def
  apply simp
  by (simp add: nth_Cons')

lemma "isTest' {1,2,3::VDMReal}
        (\<lambda> x . Some { the(vdmint_of_real i) | i . i \<in> x \<and> vdmint_of_real i \<noteq> None })
        (inv_VDMSet' inv_VDMInt)"
  unfolding isTest'_def
  apply simp
  unfolding inv_VDMSet'_def inv_VDMSet_def inv_VDMInt_def inv_SetElems_def
  by (simp)

text \<open>A total VDM type coercion is one where every element in the type space of
      interest is convertible under the given type coercion 
      (e.g., set of real = {1,2,3} into set of nat is total; whereas 
             set of real = {0.5,2,3} into set of nat is not total given 0.5 is not nat).  
     \<close>
definition 
  total_coercion :: "'a VDMSet \<Rightarrow> ('a, 'b) VDMTypeCoercion \<Rightarrow> \<bool>"
  where
  "total_coercion space conv \<equiv> (\<forall> i \<in> space . conv i \<noteq> None)"

text \<open>To convert a VDM set s of type 'a into type 'b (e.g., set of real into set of nat),
      it must be possible to convert every element of s under given type coercion
     \<close>
definition 
  vdmset_of_t :: "('a, 'b) VDMTypeCoercion \<Rightarrow> ('a VDMSet, 'b VDMSet) VDMTypeCoercion" 
  where
  "vdmset_of_t conv \<equiv> 
      (\<lambda> x . if total_coercion x conv then
                Some { the(conv i) | i . i \<in> x \<and> conv i \<noteq> None }
             else
                None)"

text \<open>To convert a VDM seq s of type 'a into type 'b (e.g., seq of real into seq of nat),
      it must be possible to convert every element of s under given type coercion
     \<close>
definition 
  vdmseq_of_t :: "('a, 'b) VDMTypeCoercion \<Rightarrow> ('a VDMSeq, 'b VDMSeq) VDMTypeCoercion" 
  where
  "vdmseq_of_t conv \<equiv> 
      (\<lambda> x . if total_coercion (elems x) conv then
                Some [ the(conv i) . i \<leftarrow> x, conv i \<noteq> None ]
             else
                None)"

(*
definition 
  vdmmap_of_dr :: "('d1, 'd2) VDMTypeCoercion \<Rightarrow> ('r1, 'r2) VDMTypeCoercion \<Rightarrow> ('d1 \<rightharpoonup> 'r1, 'd2 \<rightharpoonup> 'r2) VDMTypeCoercion" 
  where
  "vdmmap_of_dr dconv rconv \<equiv> 
      \<comment> \<open>x is a 'd1 \<rightharpoonup> 'r1, d is a 'd2 \<Rightarrow> 'r2; where dconv/rconv is applied throughout and succeeded\<close>
      (\<lambda> x . if total_coercion (dom x) dconv \<and> total_coercion (rng x) rconv then 
                Some (\<lambda> d . if (\<exists> xd . d = dconv xd) then None else None)
             else
                None)"
*)

(* s1: set of real = {1,2,3}, is_(s1, set of int)? *)
lemma "isTest' {1,2,3::VDMReal} 
        (vdmset_of_t vdmint_of_real)
        (inv_VDMSet' inv_VDMInt)"
  unfolding isTest'_def vdmset_of_t_def total_coercion_def 
  apply simp
  unfolding inv_VDMSet'_def inv_VDMSet_def inv_VDMInt_def inv_SetElems_def
  apply (simp, safe)
  unfolding vdmint_of_real_def is_VDMRealWhole_def
  by (simp_all add: vdm_narrow_real_def)

(* s1: set of real = {1,2,3}, is_(s1, set of nat)? *)
lemma "isTest' {1,2,3::VDMReal} 
        (vdmset_of_t vdmint_of_real)
        (inv_VDMSet' inv_VDMNat)"
  unfolding isTest'_def vdmset_of_t_def total_coercion_def 
  apply simp
  unfolding inv_VDMSet'_def inv_VDMSet_def inv_VDMNat_def inv_SetElems_def
  apply (simp, safe)
  unfolding vdmint_of_real_def is_VDMRealWhole_def
  by (simp_all add: vdm_narrow_real_def)

datatype TUnion = U_VDMInt "VDMInt" | U_VDMReal "VDMReal"

consts u1 :: TUnion

lemma "isTest' u1
        (\<lambda> x . case x of U_VDMInt y \<Rightarrow> Some y 
                        |U_VDMReal r \<Rightarrow>  if inv_VDMNat x then Some x else None) 
        inv_VDMNat"
  unfolding isTest'_def inv_VDMNat_def by simp

end