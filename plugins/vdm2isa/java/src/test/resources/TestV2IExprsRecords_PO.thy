(* VDM to Isabelle Translation @2021-11-20T08:55:02.441968Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in 'TestV2IExprsRecords' (./src/test/resources/TestV2IExprsRecords.vdmsl) at line 7:5
files = [./src/test/resources/TestV2IExprsRecords.vdmsl]
*)
theory TestV2IExprsRecords_PO
imports TestV2IExprsRecords
begin


\<comment>\<open>in 'TestV2IExprsRecords' (./src/test/resources/TestV2IExprsRecords.vdmsl) at line 7:5\<close>
theorem R_INV_SATISFIABILITY:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<exists> (r :: R)  . (((
		 (((inv_VDMNat (x\<^sub>R r))) \<and>
		 ((inv_VDMNat (y\<^sub>R r)))
		 ))) \<longrightarrow> ((x\<^sub>R (r)) < (y\<^sub>R (r))))))"
	
	oops
	
	
	
\<comment>\<open>in 'TestV2IExprsRecords' (./src/test/resources/TestV2IExprsRecords.vdmsl) at line 18:15\<close>
theorem mkr_SUB_TYPE:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (n :: VDMNat)  . ((((inv_VDMNat n))) \<longrightarrow> (inv_R \<lparr>x\<^sub>R = n, y\<^sub>R = (n+(1::VDMNat1))\<rparr>))))"
	
	oops
	
	
	
\<comment>\<open>in 'TestV2IExprsRecords' (./src/test/resources/TestV2IExprsRecords.vdmsl) at line 25:5\<close>
theorem recbindSpec_FUNC_POST_CONDITION:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (dummy0 :: R)  . ((( (((inv_VDMNat (x\<^sub>R dummy0))) \<and>
		 ((inv_VDMNat (y\<^sub>R dummy0))) ))) \<longrightarrow> (let x = (x\<^sub>R dummy0); y = (y\<^sub>R dummy0) in ((pre_recbindSpec \<lparr>x\<^sub>R = x, y\<^sub>R = y\<rparr>) \<longrightarrow> (post_recbindSpec \<lparr>x\<^sub>R = x, y\<^sub>R = y\<rparr>  (x + y)))))))"
	
	oops
	
	
	
\<comment>\<open>in 'TestV2IExprsRecords' (./src/test/resources/TestV2IExprsRecords.vdmsl) at line 33:22\<close>
theorem letbest_LET_BE_EXISTS:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<exists> (dummy0 :: R)  . (((
		 (((inv_VDMNat (x\<^sub>R dummy0))) \<and>
		 ((inv_VDMNat (y\<^sub>R dummy0)))
		 ))) \<longrightarrow> (let x = (x\<^sub>R dummy0); y = (y\<^sub>R dummy0) in (x > y)))))"
	
	oops
	
	
	
\<comment>\<open>in 'TestV2IExprsRecords' (./src/test/resources/TestV2IExprsRecords.vdmsl) at line 41:14\<close>
theorem v65_SUB_TYPE:
	"((inv_R \<lparr>x\<^sub>R = (1::VDMNat1), y\<^sub>R = (2::VDMNat1)\<rparr>))"
	
	oops
	
	
	
\<comment>\<open>in 'TestV2IExprsRecords' (./src/test/resources/TestV2IExprsRecords.vdmsl) at line 42:12\<close>
theorem v651_SUB_TYPE:
	"((inv_R \<lparr>x\<^sub>R = (1::VDMNat1), y\<^sub>R = (2::VDMNat1)\<rparr>))"
	
	oops
	
	
	
\<comment>\<open>in 'TestV2IExprsRecords' (./src/test/resources/TestV2IExprsRecords.vdmsl) at line 47:11\<close>
theorem v731_UNIQUE_EXISTENCE:
	"((\<exists>! dummy0 \<in> {v65}  . (let x = (x\<^sub>R dummy0); y = (y\<^sub>R dummy0) in (x < y))))"
	
	oops
	
	
	
\<comment>\<open>in 'TestV2IExprsRecords' (./src/test/resources/TestV2IExprsRecords.vdmsl) at line 53:15\<close>
theorem v801_LET_BE_EXISTS:
	"((\<exists> dummy0 \<in> {v65}  . (let x = (x\<^sub>R dummy0); y = (y\<^sub>R dummy0) in (x < y))))"
	
	oops
	
	
end