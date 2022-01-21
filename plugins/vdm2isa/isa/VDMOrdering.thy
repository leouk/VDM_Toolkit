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

lemma vdm_ord_trans: "\<forall> x y z . x < y \<and> y < z \<longrightarrow> x < y"
  by simp

lemma vdm_ord_asym: "\<forall> x y . x < y \<longrightarrow> \<not> y < x"
  by (meson local.less_asym)

end

print_locale! VDMOrd
class_deps _ VDMOrd

end