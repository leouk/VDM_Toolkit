(* VDM to Isabelle Translated
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

files = [./src/test/resources/TestV2IFcns.vdmsl]
*)
theory TestV2IFcns
imports "VDMToolkit"
begin

definition
	f :: "VDMNat\<Rightarrow> VDMNat1 \<Rightarrow> VDMNat1"
where
	"f x y \<equiv> 
		\<comment>\<open>User defined body\<close>
		(x + y)"

end