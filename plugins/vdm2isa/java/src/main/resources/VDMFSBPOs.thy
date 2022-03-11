theory VDMFSBPOs
imports TestV2IFcns
begin

type_notation bool ("\<bool>")

locale FSB = 
  fixes 
      f    :: "'a \<Rightarrow> 'b"
  and invI :: "'a \<Rightarrow> \<bool>"
  and invO :: "'b \<Rightarrow> \<bool>"
  and pre  :: "'a \<Rightarrow> \<bool>"
  and post :: "'a \<Rightarrow> 'b \<Rightarrow> \<bool>"
assumes
  po_FUNC_POST_CONDITION: "\<forall> i . invI i \<and> pre i \<longrightarrow> invO (f i) \<and> post i (f i)"

interpretation g_POS : FSB 
  where
    f    = \<open>\<lambda> (x, y) . g x y\<close>
and invI = \<open>\<lambda> (x, y) . inv_VDMNat x \<and> inv_VDMNat1 y\<close> 
and invO = inv_VDMNat1
and pre  = \<open>\<lambda> (x,y) . pre_g x y\<close>
and post = \<open>\<lambda> (x,y) . \<lambda> R . post_g x y R \<and> R = g x y\<close>
  apply unfold_locales 
  by (simp add: g_def inv_VDMNat1_def post_g_def pre_g_def)
  
interpretation h_POS : FSB
  where
    f    = h
and invI = inv_VDMNat
and invO = inv_VDMNat
and pre  = pre_h
and post = post_h
  apply unfold_locales
  using pre_g_def pre_h_def by force

interpretation h'_POS : FSB
  where
    f    = h'
and invI = inv_VDMNat
and invO = inv_VDMNat
and pre  = pre_h'
and post = post_h'
  apply unfold_locales
  nitpick \<comment> \<open>Counter example \<^term>\<open>i = 17\<close>\<close>
  oops
end