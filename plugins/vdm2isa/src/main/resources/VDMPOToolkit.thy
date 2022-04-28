theory VDMPOToolkit
  imports Main
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

end