(* VDM to Isabelle Translation @2021-12-16T10:45:57.299Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 11:5
files = [/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl]
*)
theory TestV2IFcns_PO
imports TestV2IFcns
begin


\<comment>\<open>VDM source: constS = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 11:5\<close>
theorem constS_FUNC_POST_CONDITION:
	"(((pre_constS ) \<longrightarrow> (post_constS (10::VDMNat1))))"
	
	oops
	
	
	
\<comment>\<open>VDM source: g = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 21:5\<close>
theorem g_FUNC_POST_CONDITION:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (x :: VDMNat)  (y :: VDMNat1)  . ((((inv_VDMNat x))) \<and>  (((inv_VDMNat1 y))) \<longrightarrow> ((pre_g x  y) \<longrightarrow> (post_g x  y  (x + y))))))"
	
	using inv_VDMNat1_def inv_VDMNat_def post_g_def by fastforce
	oops
	
	
	
\<comment>\<open>VDM source: h = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 29:18\<close>
theorem h_SUB_TYPE:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> (x > (0::VDMNat)))))"
	nitpick
	oops
	
	
	
\<comment>\<open>VDM source: h = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 27:5\<close>
theorem h_FUNC_POST_CONDITION:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((pre_h x) \<longrightarrow> (post_h x  (g x  x))))))"
	using pre_g_def pre_h_def by force
	oops
	
	
	
\<comment>\<open>VDM source: h = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 30:20\<close>
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
	
	
	
\<comment>\<open>VDM source: h = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 30:23\<close>
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
	
	
	
\<comment>\<open>VDM source: h = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 28:13\<close>
theorem h_FUNC_APPLY:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> (((pre_g x  x) \<and> (x < (20::VDMNat1))) \<longrightarrow> (pre_g x  x)))))"
	
	oops
	
	
	
\<comment>\<open>VDM source: h = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 28:18\<close>
theorem h_SUB_TYPE:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> (((pre_g x  x) \<and> (x < (20::VDMNat1))) \<longrightarrow> (x > (0::VDMNat))))))"
	
	oops
	
	
	
\<comment>\<open>VDM source: h' = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 33:5\<close>
theorem h'_FUNC_POST_CONDITION:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((pre_h' x) \<longrightarrow> (post_h' x  (g x  x))))))"
	
	oops
	
	
	
\<comment>\<open>VDM source: h' = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 34:14\<close>
theorem h'_FUNC_APPLY:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((x < (20::VDMNat1)) \<longrightarrow> (pre_g x  x)))))"
	
	oops
	
	
	
\<comment>\<open>VDM source: h' = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 34:19\<close>
theorem h'_SUB_TYPE:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((x < (20::VDMNat1)) \<longrightarrow> (x > (0::VDMNat))))))"
	
	oops
	
	
	
\<comment>\<open>VDM source: h'' = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 39:5\<close>
theorem h''_FUNC_POST_CONDITION:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((pre_h'' x) \<longrightarrow> (post_h'' x  (g x  x))))))"
	
	oops
	
	
	
\<comment>\<open>VDM source: h'' = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 42:18\<close>
theorem h''_SUB_TYPE:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((x < (20::VDMNat1)) \<longrightarrow> (
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
	
	
	
\<comment>\<open>VDM source: h'' = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 40:15\<close>
theorem h''_FUNC_APPLY:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((x < (20::VDMNat1)) \<longrightarrow> (pre_g x  x)))))"
	
	oops
	
	
	
\<comment>\<open>VDM source: h'' = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 40:20\<close>
theorem h''_SUB_TYPE:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((x < (20::VDMNat1)) \<longrightarrow> (x > (0::VDMNat))))))"
	
	oops
	
	
	
\<comment>\<open>VDM source: curriedS = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 49:5\<close>
theorem curriedS_FUNC_POST_CONDITION:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (x :: VDMNat)  (y :: VDMNat)  . ((((inv_VDMNat x))) \<and>  (((inv_VDMNat y))) \<longrightarrow> (((pre_curriedS x) y) \<longrightarrow> ((post_curriedS x) y  (x + y))))))"
	
	oops
	
	
\<comment>\<open>Processing VDM exports as Isabelle hidden declarations\<close>
hide_const "curriedS"
hide_const "h'"
hide_const "constS"
hide_const "h''"
hide_const "g"
hide_const "h"

end