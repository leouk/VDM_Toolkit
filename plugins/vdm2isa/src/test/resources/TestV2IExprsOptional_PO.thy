(* VDM to Isabelle Translation @2021-12-17T14:01:51.181455Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in 'TestV2IExprsOptional' (./src/test/resources/TestV2IExprsOptional.vdmsl) at line 7:37
files = [./src/test/resources/TestV2IExprsOptional.vdmsl]
*)
theory TestV2IExprsOptional_PO
imports TestV2IExprsOptional
begin


\<comment>\<open>VDM source: v93 = ?\<close>
\<comment>\<open>in 'TestV2IExprsOptional' (./src/test/resources/TestV2IExprsOptional.vdmsl) at line 7:37\<close>
theorem v93_SUB_TYPE:
	"(((\<not> (None = \<comment>\<open>Optional type variable `v37` might not need extra @{term the} operator!\<close>(the(v37)))) \<longrightarrow> (\<exists> (v :: VDMNat option)  . ((((inv_Option (inv_VDMNat) v))) \<longrightarrow> ((\<comment>\<open>Optional type variable `v` might not need extra @{term the} operator!\<close>(the(v)) = \<comment>\<open>Optional type variable `v37` might not need extra @{term the} operator!\<close>(the(v37))) \<longrightarrow> (
		let 
(v::VDMNat option) = \<comment>\<open>Optional type variable `v37` might not need extra @{term the} operator!\<close>(the(v37))
		in
			(if ((inv_Option (inv_VDMNat) v)) then
			isTest (\<comment>\<open>Optional type variable `v` might not need extra @{term the} operator!\<close>(the(v))) (inv_VDMNat)
		 else
			undefined
		)
		))))))"
	
	oops
	
	
	
\<comment>\<open>VDM source: v93 = ?\<close>
\<comment>\<open>in 'TestV2IExprsOptional' (./src/test/resources/TestV2IExprsOptional.vdmsl) at line 7:39\<close>
theorem v93_SUB_TYPE:
	"(((\<not> (None = \<comment>\<open>Optional type variable `v37` might not need extra @{term the} operator!\<close>(the(v37)))) \<longrightarrow> (\<exists> (v :: VDMNat option)  . ((((inv_Option (inv_VDMNat) v))) \<longrightarrow> ((\<comment>\<open>Optional type variable `v` might not need extra @{term the} operator!\<close>(the(v)) = \<comment>\<open>Optional type variable `v37` might not need extra @{term the} operator!\<close>(the(v37))) \<longrightarrow> (
		let 
(v::VDMNat option) = \<comment>\<open>Optional type variable `v37` might not need extra @{term the} operator!\<close>(the(v37))
		in
			(if ((inv_Option (inv_VDMNat) v)) then
			isTest (\<comment>\<open>Optional type variable `v` might not need extra @{term the} operator!\<close>(the(v))) (inv_VDMNat)
		 else
			undefined
		)
		))))))"
	
	oops
	
	
	
\<comment>\<open>VDM source: v93 = ?\<close>
\<comment>\<open>in 'TestV2IExprsOptional' (./src/test/resources/TestV2IExprsOptional.vdmsl) at line 7:11\<close>
theorem v93_CASES_EXHAUSTIVE:
	"(((\<comment>\<open>Optional type variable `v37` might not need extra @{term the} operator!\<close>(the(v37)) = None) \<or> (\<exists> (v :: VDMNat option)  . ((((inv_Option (inv_VDMNat) v))) \<longrightarrow> (\<comment>\<open>Optional type variable `v37` might not need extra @{term the} operator!\<close>(the(v37)) = \<comment>\<open>Optional type variable `v` might not need extra @{term the} operator!\<close>(the(v)))))))"
	
	oops
	
	
\<comment>\<open>Processing VDM exports as Isabelle hidden declarations\<close>
hide_const "v93"

end