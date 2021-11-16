(* VDM to Isabelle Translation @2021-11-16T12:07:17.792386Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 11:5
files = [./src/test/resources/TestV2IFcns.vdmsl]
*)
theory TestV2IFcns_PO
imports TestV2IFcns
begin


theorem constS_FUNC_POST_CONDITION:
	"(((pre_constS ) \<longrightarrow> (post_constS (10::VDMNat1))))"
	
	oops
	
	
	
theorem g_FUNC_POST_CONDITION:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (x :: VDMNat)  (y :: VDMNat1)  . ((((inv_VDMNat x))) \<and>  (((inv_VDMNat1 y))) \<longrightarrow> ((pre_g x  y) \<longrightarrow> (post_g x  y  (x + y))))))"
	
	oops
	
	
	
theorem h_SUB_TYPE:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> (x > (0::VDMNat)))))"
	
	oops
	
	
	
theorem h_FUNC_POST_CONDITION:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((pre_h x) \<longrightarrow> (post_h x  (g x  x))))))"
	
	oops
	
	
	
theorem h_SUB_TYPE:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> (((pre_g x  x) \<and> (x < (20::VDMNat1))) \<longrightarrow> (
		let 
(RESULT::VDMNat) = (g x  x)
		in
			(if ((inv_VDMNat RESULT)) then
			(x > (0::VDMNat))
		 else
			undefined
		)
		)))))"
	
	oops
	
	
	
theorem h_SUB_TYPE:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> (((pre_g x  x) \<and> (x < (20::VDMNat1))) \<longrightarrow> (
		let 
(RESULT::VDMNat) = (g x  x)
		in
			(if ((inv_VDMNat RESULT)) then
			(RESULT > (0::VDMNat))
		 else
			undefined
		)
		)))))"
	
	oops
	
	
	
theorem h_FUNC_APPLY:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> (((pre_g x  x) \<and> (x < (20::VDMNat1))) \<longrightarrow> (pre_g x  x)))))"
	
	oops
	
	
	
theorem h_SUB_TYPE:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> (((pre_g x  x) \<and> (x < (20::VDMNat1))) \<longrightarrow> (x > (0::VDMNat))))))"
	
	oops
	
	
	
theorem h'_FUNC_POST_CONDITION:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((pre_h' x) \<longrightarrow> (post_h' x  (g x  x))))))"
	
	oops
	
	
	
theorem h'_FUNC_APPLY:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((x < (20::VDMNat1)) \<longrightarrow> (pre_g x  x)))))"
	
	oops
	
	
	
theorem h'_SUB_TYPE:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((x < (20::VDMNat1)) \<longrightarrow> (x > (0::VDMNat))))))"
	
	oops
	
	
	
theorem curriedS_FUNC_POST_CONDITION:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (x :: VDMNat)  (y :: VDMNat)  . ((((inv_VDMNat x))) \<and>  (((inv_VDMNat y))) \<longrightarrow> (((pre_curriedS x) y) \<longrightarrow> ((post_curriedS x) y  (x + y))))))"
	
	oops
	
	
end