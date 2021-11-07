(* VDM to Isabelle Translated
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 29:18files = [./src/test/resources/TestV2IFcns.vdmsl]
*)
theory TestV2IFcns_PO
imports TestV2IFcns
begin


theorem h_SUB_TYPE:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> (x > (0::VDMNat)))))"
	
	oops
	
	
	
theorem h'_SUB_TYPE:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((x < (20::VDMNat1)) \<longrightarrow> (x > (0::VDMNat))))))"
	
	oops
	
	
end
(*
	Could not translate VDM PO because of a com.fujitsu.vdmj.messages.VDMErrorsException error:
	VDM PO: constS: post condition obligation in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 11:5
pre_constS() => post_constS(10)

	Reason: Error 3182: Name 'pre_constS' is not in scope in 'TestV2IFcns' (console) at line 1:1
Error 3182: Name 'post_constS' is not in scope in 'TestV2IFcns' (console) at line 1:17
*)

(*
	Could not translate VDM PO because of a com.fujitsu.vdmj.messages.VDMErrorsException error:
	VDM PO: g: post condition obligation in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 21:5
(forall x:nat, y:nat1 &
  pre_g(x, y) => post_g(x, y, (x + y)))

	Reason: Error 3182: Name 'pre_g' is not in scope in 'TestV2IFcns' (console) at line 2:3
Error 3182: Name 'post_g' is not in scope in 'TestV2IFcns' (console) at line 2:18
*)

(*
	Could not translate VDM PO because of a com.fujitsu.vdmj.messages.VDMErrorsException error:
	VDM PO: h: post condition obligation in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 27:5
(forall x:nat &
  pre_h(x) => post_h(x, g(x, x)))

	Reason: Error 3182: Name 'pre_h' is not in scope in 'TestV2IFcns' (console) at line 2:3
Error 3182: Name 'g' is not in scope in 'TestV2IFcns' (console) at line 2:25
Error 3182: Name 'post_h' is not in scope in 'TestV2IFcns' (console) at line 2:15
*)

(*
	Could not translate VDM PO because of a com.fujitsu.vdmj.messages.VDMErrorsException error:
	VDM PO: h: subtype obligation in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 30:20
(forall x:nat &
  ((pre_g(x, x) and (x < 20)) => let RESULT:nat = g(x, x) in 
    x > 0))

	Reason: Error 3182: Name 'pre_g' is not in scope in 'TestV2IFcns' (console) at line 2:5
Error 3182: Name 'g' is not in scope in 'TestV2IFcns' (console) at line 2:51
*)

(*
	Could not translate VDM PO because of a com.fujitsu.vdmj.messages.VDMErrorsException error:
	VDM PO: h: subtype obligation in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 30:23
(forall x:nat &
  ((pre_g(x, x) and (x < 20)) => let RESULT:nat = g(x, x) in 
    RESULT > 0))

	Reason: Error 3182: Name 'pre_g' is not in scope in 'TestV2IFcns' (console) at line 2:5
Error 3182: Name 'g' is not in scope in 'TestV2IFcns' (console) at line 2:51
*)

(*
	Could not translate VDM PO because of a com.fujitsu.vdmj.messages.VDMErrorsException error:
	VDM PO: h: function apply obligation in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 28:13
(forall x:nat & (pre_g(x, x) and (x < 20)) =>
  pre_g(x, x))

	Reason: Error 3182: Name 'pre_g' is not in scope in 'TestV2IFcns' (console) at line 1:18
Error 3182: Name 'pre_g' is not in scope in 'TestV2IFcns' (console) at line 2:3
*)

(*
	Could not translate VDM PO because of a com.fujitsu.vdmj.messages.VDMErrorsException error:
	VDM PO: h: subtype obligation in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 28:18
(forall x:nat & (pre_g(x, x) and (x < 20)) =>
  x > 0)

	Reason: Error 3182: Name 'pre_g' is not in scope in 'TestV2IFcns' (console) at line 1:18
*)

(*
	Could not translate VDM PO because of a com.fujitsu.vdmj.messages.VDMErrorsException error:
	VDM PO: h': post condition obligation in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 33:5
(forall x:nat &
  pre_h'(x) => post_h'(x, g(x, x)))

	Reason: Error 3182: Name 'pre_h'' is not in scope in 'TestV2IFcns' (console) at line 2:3
Error 3182: Name 'g' is not in scope in 'TestV2IFcns' (console) at line 2:27
Error 3182: Name 'post_h'' is not in scope in 'TestV2IFcns' (console) at line 2:16
*)

(*
	Could not translate VDM PO because of a com.fujitsu.vdmj.messages.VDMErrorsException error:
	VDM PO: h': function apply obligation in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 34:14
(forall x:nat & (x < 20) =>
  pre_g(x, x))

	Reason: Error 3182: Name 'pre_g' is not in scope in 'TestV2IFcns' (console) at line 2:3
*)

(*
	Could not translate VDM PO because of a com.fujitsu.vdmj.messages.VDMErrorsException error:
	VDM PO: curriedS: post condition obligation in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 43:5
(forall x:nat, y:nat &
  pre_curriedS(x)(y) => post_curriedS(x)(y, (x + y)))

	Reason: Error 3182: Name 'pre_curriedS' is not in scope in 'TestV2IFcns' (console) at line 2:3
Error 3182: Name 'post_curriedS' is not in scope in 'TestV2IFcns' (console) at line 2:25
*)
