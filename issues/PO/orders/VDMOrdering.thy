theory VDMOrdering
imports Main
begin

class VDMEq = equal
begin

lemma vdm_eq_refl : "\<forall> x . x = x"
  by simp

lemma vdm_eq_sym  : "\<forall> x y . x = y \<longrightarrow> y = x"
  by simp

lemma vdm_eq_trans: "\<forall> x y z . x = y \<and> y = z \<longrightarrow> x = z"
  by simp

end

print_locale! VDMEq
class_deps _ VDMEq

class VDMOrd = preorder 
begin

lemma vdm_ord_irrefl: "\<forall> x . \<not> x < x"
  by simp

lemma vdm_ord_trans: "\<forall> x y z . x < y \<and> y < z \<longrightarrow> x < z"
  by (meson local.order.strict_trans)

lemma vdm_ord_asym: "\<forall> x y . x < y \<longrightarrow> \<not> y < x"
  by (meson local.less_asym)

lemma "\<forall> x y z . \<not> x < x \<and> (x < y \<and> y < z \<longrightarrow> x < z) \<and> (x < y \<longrightarrow> \<not> y < x) \<longrightarrow> x \<le> y \<or> y \<le> x"
  apply (intro allI impI, elim conjE, simp)
  apply (elim impE)
  oops

lemma vdm_total: "\<forall> x y . x \<le> y \<or> y \<le> x" 
  nitpick oops

end

print_locale! VDMOrd
class_deps _ VDMOrd

lemma "\<not> x < x \<and> (x < y \<and> y < z \<longrightarrow> x < y) \<and> (x < y \<longrightarrow> \<not> y < x) \<longrightarrow> x \<le> y \<or> y \<le> (x::('a::preorder))"
  apply (intro impI, elim conjE, simp)
  apply (elim impE)
  defer
   apply (intro disjI1)  
  apply (insert antisym_conv1[of x y])
  oops

  print_locale dense_linorder

end