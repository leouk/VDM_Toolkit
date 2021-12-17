(* VDM to Isabelle Translation @2021-12-17T14:01:51.182686Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in 'TestV2IExprsRecords' (./src/test/resources/TestV2IExprsRecords.vdmsl) at line 7:5
files = [./src/test/resources/TestV2IExprsRecords.vdmsl]
*)
theory TestV2IExprsRecords_PO
imports TestV2IExprsRecords
begin


\<comment>\<open>VDM source: R = ?\<close>
\<comment>\<open>in 'TestV2IExprsRecords' (./src/test/resources/TestV2IExprsRecords.vdmsl) at line 7:5\<close>
theorem R_INV_SATISFIABILITY:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<exists> (r :: R)  . (((
		(((inv_VDMNat (x\<^sub>R r))) \<and> 
		 ((inv_VDMNat (y\<^sub>R r)))
		))) \<longrightarrow> ((x\<^sub>R (r)) < (y\<^sub>R (r))))))"
	
	oops
	
	
	
\<comment>\<open>VDM source: mkr = ?\<close>
\<comment>\<open>in 'TestV2IExprsRecords' (./src/test/resources/TestV2IExprsRecords.vdmsl) at line 15:15\<close>
theorem mkr_SUB_TYPE:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (n :: VDMNat)  . ((((inv_VDMNat n))) \<longrightarrow> (inv_R \<lparr>x\<^sub>R = n, y\<^sub>R = (n + (1::VDMNat1))\<rparr>))))"
	
	oops
	
	
	
\<comment>\<open>VDM source: recbindSpec = ?\<close>
\<comment>\<open>in 'TestV2IExprsRecords' (./src/test/resources/TestV2IExprsRecords.vdmsl) at line 22:5\<close>
theorem recbindSpec_FUNC_POST_CONDITION:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (dummy0 :: R)  . ((( (((inv_VDMNat (x\<^sub>R dummy0))) \<and> 
		 ((inv_VDMNat (y\<^sub>R dummy0))) ))) \<longrightarrow> (let x = (x\<^sub>R dummy0); y = (y\<^sub>R dummy0) in ((pre_recbindSpec \<lparr>x\<^sub>R = x, y\<^sub>R = y\<rparr>) \<longrightarrow> (post_recbindSpec \<lparr>x\<^sub>R = x, y\<^sub>R = y\<rparr>  (x + y)))))))"
	
	oops
	
	
	
\<comment>\<open>VDM source: letbest = ?\<close>
\<comment>\<open>in 'TestV2IExprsRecords' (./src/test/resources/TestV2IExprsRecords.vdmsl) at line 30:22\<close>
theorem letbest_LET_BE_EXISTS:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<exists> (dummy0 :: R)  . (((
		(((inv_VDMNat (x\<^sub>R dummy0))) \<and> 
		 ((inv_VDMNat (y\<^sub>R dummy0)))
		))) \<longrightarrow> (let x = (x\<^sub>R dummy0); y = (y\<^sub>R dummy0) in (x > y)))))"
	
	oops
	
	
	
\<comment>\<open>VDM source: v65 = ?\<close>
\<comment>\<open>in 'TestV2IExprsRecords' (./src/test/resources/TestV2IExprsRecords.vdmsl) at line 38:14\<close>
theorem v65_SUB_TYPE:
	"((inv_R \<lparr>x\<^sub>R = (1::VDMNat1), y\<^sub>R = (2::VDMNat1)\<rparr>))"
	
	oops
	
	
	
\<comment>\<open>VDM source: v651 = ?\<close>
\<comment>\<open>in 'TestV2IExprsRecords' (./src/test/resources/TestV2IExprsRecords.vdmsl) at line 39:12\<close>
theorem v651_SUB_TYPE:
	"((inv_R \<lparr>x\<^sub>R = (1::VDMNat1), y\<^sub>R = (2::VDMNat1)\<rparr>))"
	
	oops
	
	
	
\<comment>\<open>VDM source: v731 = ?\<close>
\<comment>\<open>in 'TestV2IExprsRecords' (./src/test/resources/TestV2IExprsRecords.vdmsl) at line 44:11\<close>
theorem v731_UNIQUE_EXISTENCE:
	"((\<exists>! dummy0 \<in> {v65}  . (let x = (x\<^sub>R dummy0); y = (y\<^sub>R dummy0) in (x < y))))"
	
	oops
	
	
	
\<comment>\<open>VDM source: v801 = ?\<close>
\<comment>\<open>in 'TestV2IExprsRecords' (./src/test/resources/TestV2IExprsRecords.vdmsl) at line 50:15\<close>
theorem v801_LET_BE_EXISTS:
	"((\<exists> dummy0 \<in> {v65}  . (let x = (x\<^sub>R dummy0); y = (y\<^sub>R dummy0) in (x < y))))"
	
	oops
	
	
\<comment>\<open>Processing VDM exports as Isabelle hidden declarations\<close>
hide_const "v731"
hide_const "v651"
hide_const "recbindSpec"
hide_const "R"
hide_const "mkr"
hide_const "letbest"
hide_const "v801"
hide_const "v65"

end