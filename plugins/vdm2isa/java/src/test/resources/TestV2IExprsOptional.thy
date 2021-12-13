(* VDM to Isabelle Translation @2021-12-13T09:52:48.329691Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2IExprsOptional.vdmsl' at line 1:8
files = [./src/test/resources/TestV2IExprsOptional.vdmsl]
*)
theory TestV2IExprsOptional
imports "VDMToolkit" 
begin


\<comment>\<open>VDM source: v37:[nat] = nil\<close>
\<comment>\<open>in 'TestV2IExprsOptional' (./src/test/resources/TestV2IExprsOptional.vdmsl) at line 5:5\<close>
abbreviation
	v37 :: "VDMNat option"
where
	"v37 \<equiv> None"

	definition
	inv_v37 :: "\<bool>"
where
	"inv_v37  \<equiv> (inv_Option (inv_VDMNat) v37)"

	
	
\<comment>\<open>VDM source: v371:[nat] = 100\<close>
\<comment>\<open>in 'TestV2IExprsOptional' (./src/test/resources/TestV2IExprsOptional.vdmsl) at line 6:5\<close>
abbreviation
	v371 :: "VDMNat option"
where
	"v371 \<equiv> Some((100::VDMNat1))"

	definition
	inv_v371 :: "\<bool>"
where
	"inv_v371  \<equiv> (inv_Option (inv_VDMNat) v371)"

	
	
\<comment>\<open>VDM source: v93:nat = (cases v37 :
nil -> 0,
v -> (v + v)
end)\<close>
\<comment>\<open>in 'TestV2IExprsOptional' (./src/test/resources/TestV2IExprsOptional.vdmsl) at line 7:5\<close>
abbreviation
	v93 :: "VDMNat"
where
	"v93 \<equiv> (
		 case \<comment>\<open>Optional type variable `v37` might not need extra @{term the} operator!\<close>(the(v37)) of 
		 None \<Rightarrow> (0::VDMNat) | 
			 v \<Rightarrow> (\<comment>\<open>Optional type variable `v` might not need extra @{term the} operator!\<close>(the(v)) + \<comment>\<open>Optional type variable `v` might not need extra @{term the} operator!\<close>(the(v))))"

	definition
	inv_v93 :: "\<bool>"
where
	"inv_v93  \<equiv> (inv_VDMNat v93)"

	
end