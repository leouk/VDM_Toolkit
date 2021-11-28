theory IsExprStudy
imports VDMToolkit
begin

type_synonym ('a, 'b) VDMTypeCoercion = "'a \<rightharpoonup> 'b"

definition
  is_VDMRealWhole :: "VDMReal \<Rightarrow> \<bool>"
  where
 "is_VDMRealWhole r \<equiv> r \<ge> 1 \<and> (r - real_of_int \<lfloor>r\<rfloor>) = 0"

definition
  vdmint_of_real :: "VDMReal \<rightharpoonup> VDMInt"
  where
 "vdmint_of_real r \<equiv> if is_VDMRealWhole r then Some \<lfloor>r\<rfloor> else None"

definition
  is_VDMRatWhole :: "VDMRat \<Rightarrow> \<bool>"
  where
 "is_VDMRatWhole r \<equiv> r \<ge> 1 \<and> (r - rat_of_int \<lfloor>r\<rfloor>) = 0"

definition
  vdmint_of_rat :: "VDMRat \<rightharpoonup> VDMInt"
  where
 "vdmint_of_rat r \<equiv> if is_VDMRatWhole r then Some \<lfloor>r\<rfloor> else None"

definition 
  isTest' :: "'a \<Rightarrow> ('a, 'b) VDMTypeCoercion \<Rightarrow> ('b \<Rightarrow> \<bool>) \<Rightarrow> \<bool>"
  where
  [intro!]: "isTest' x conv inv_X \<equiv> 
    (case conv x of
        None \<Rightarrow> False 
      | Some x \<Rightarrow> inv_X x)"

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

datatype TUnion = U_VDMInt "VDMInt" | U_VDMReal "VDMReal"

consts u1 :: TUnion

lemma "isTest' u1
        (\<lambda> x . case x of U_VDMInt y \<Rightarrow> Some y 
                        |U_VDMReal r \<Rightarrow>  if inv_VDMNat x then Some x else None) 
        inv_VDMNat"
  unfolding isTest'_def inv_VDMNat_def by simp

end