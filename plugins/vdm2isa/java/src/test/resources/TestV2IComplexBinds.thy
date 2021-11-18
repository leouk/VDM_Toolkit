(* VDM to Isabelle Translation @2021-11-18T07:19:41.738356Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2IComplexBinds.vdmsl' at line 1:8
files = [./src/test/resources/TestV2IComplexBinds.vdmsl]
*)
theory TestV2IComplexBinds
imports VDMToolkit
begin


\<comment>\<open>in 'TestV2IComplexBinds' (./src/test/resources/TestV2IComplexBinds.vdmsl) at line 6:5\<close>
abbreviation
	v0 :: "VDMNat"
where
	"v0 \<equiv> (10::VDMNat1)"

	definition
	inv_v0 :: "\<bool>"
where
	"inv_v0  \<equiv> (inv_VDMNat v0)"

	
end