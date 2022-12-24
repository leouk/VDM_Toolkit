(* VDM to Isabelle Translation @2022-12-24T08:20:03.165Z  
   Copyright 2019-22, Leo Freitas, leo.freitas@newcastle.ac.uk

   VDM translation of module TestV2ITypesOptional_PO
   in 'TestV2ITypesOptional' (./lvl0/TestV2ITypesOptional.vdmsl) at line 7:25
   files = [./lvl0/TestV2ITypesOptional.vdmsl]
*)
theory TestV2ITypesOptional_PO
imports VDMToolkit "TestV2ITypesOptional" 
begin


\<comment>\<open>VDM source: TOptional = ?\<close>
\<comment>\<open>in 'TestV2ITypesOptional' (./lvl0/TestV2ITypesOptional.vdmsl) at line 7:25\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_53_TOptional_TOTAL :: \<open>\<bool>\<close>
where
	\<open>PO_53_TOptional_TOTAL  \<equiv> (\<forall> (o1 :: VDMNat1 option)  . ((((inv_Option (inv_VDMNat1) o1))) \<longrightarrow> isTest ((inv_TOptional o1)) (inv_bool)))\<close>

	

\<comment>\<open>VDM source: TOptional = ?\<close>
\<comment>\<open>in 'TestV2ITypesOptional' (./lvl0/TestV2ITypesOptional.vdmsl) at line 7:28\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_54_TOptional_SUB_TYPE :: \<open>\<bool>\<close>
where
	\<open>PO_54_TOptional_SUB_TYPE  \<equiv> (\<forall> (o1 :: VDMNat1 option)  . ((((inv_Option (inv_VDMNat1) o1))) \<longrightarrow> ((o1 \<noteq> None) \<longrightarrow> isTest (o1) (inv_VDMNat1))))\<close>

	

\<comment>\<open>VDM source: TOptional = ?\<close>
\<comment>\<open>in 'TestV2ITypesOptional' (./lvl0/TestV2ITypesOptional.vdmsl) at line 6:5\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_55_TOptional_INV_SATISFIABILITY :: \<open>\<bool>\<close>
where
	\<open>PO_55_TOptional_INV_SATISFIABILITY  \<equiv> (\<exists> (o1 :: VDMNat1 option)  . ((((inv_Option (inv_VDMNat1) o1))) \<longrightarrow> ((o1 \<noteq> None) \<longrightarrow> (o1 > (10::VDMNat1)))))\<close>

	
 

end 