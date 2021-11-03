(* VDM to Isabelle Translated
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 11:5files = [./src/test/resources/TestV2IFcns.vdmsl]
*)
theory TestV2IFcns_PO
imports TestV2IFcns
begin

\<comment>\<open>@ in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 11:5
VDM PO(1): "constS: post condition obligation in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 11:5
pre_constS() => post_constS(10)
"
\<close>
theorem constS_FUNC_POST_CONDITION:
	"(((pre_constS ) \<longrightarrow> (post_constS (10::VDMNat1))))"
	
	try
	oops
	
	\<comment>\<open>@ in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 21:5
VDM PO(2): "g: post condition obligation in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 21:5
(forall x:nat, y:nat1 &
  pre_g(x, y) => post_g(x, y, (x + y)))
"
\<close>
theorem g_FUNC_POST_CONDITION:
	"(((x::VDMNat)  (y::VDMNat1) ((inv_VDMNat x) \<and> (inv_VDMNat1 y) \<and>  \<longrightarrow> ((pre_g x  y) \<longrightarrow> (post_g x  y  (x + y)))))"
	
	try
	oops
	
	\<comment>\<open>@ in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 29:18
VDM PO(3): "h: subtype obligation in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 29:18
(forall x:nat &
  x > 0)
"
\<close>
theorem h_SUB_TYPE:
	"(((x::VDMNat) ((inv_VDMNat x) \<and>  \<longrightarrow> (x > (0::VDMNat))))"
	
	try
	oops
	
	\<comment>\<open>@ in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 27:5
VDM PO(4): "h: post condition obligation in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 27:5
(forall x:nat &
  pre_h(x) => post_h(x, g(x, x)))
"
\<close>
theorem h_FUNC_POST_CONDITION:
	"(((x::VDMNat) ((inv_VDMNat x) \<and>  \<longrightarrow> ((pre_h x) \<longrightarrow> (post_h x  (g x  x)))))"
	
	try
	oops
	
	\<comment>\<open>@ in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 30:20
VDM PO(5): "h: subtype obligation in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 30:20
(forall x:nat &
  ((pre_g(x, x) and (x < 20)) => let RESULT:nat = g(x, x) in 
    x > 0))
"
\<close>
theorem h_SUB_TYPE:
	"(((x::VDMNat) ((inv_VDMNat x) \<and>  \<longrightarrow> (((pre_g x  x) \<and> (x < (20::VDMNat1))) \<longrightarrow> (
		let (result::VDMNat) = (g x  x)
		in
			(if ((inv_VDMNat result)) then
			(x > (0::VDMNat))
		 else
			undefined
		)
		))))"
	
	try
	oops
	
	\<comment>\<open>@ in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 30:23
VDM PO(6): "h: subtype obligation in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 30:23
(forall x:nat &
  ((pre_g(x, x) and (x < 20)) => let RESULT:nat = g(x, x) in 
    RESULT > 0))
"
\<close>
theorem h_SUB_TYPE:
	"(((x::VDMNat) ((inv_VDMNat x) \<and>  \<longrightarrow> (((pre_g x  x) \<and> (x < (20::VDMNat1))) \<longrightarrow> (
		let (result::VDMNat) = (g x  x)
		in
			(if ((inv_VDMNat result)) then
			(result > (0::VDMNat))
		 else
			undefined
		)
		))))"
	
	try
	oops
	
	\<comment>\<open>@ in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 28:13
VDM PO(7): "h: function apply obligation in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 28:13
(forall x:nat & (pre_g(x, x) and (x < 20)) =>
  pre_g(x, x))
"
\<close>
theorem h_FUNC_APPLY:
	"(((x::VDMNat) ((inv_VDMNat x) \<and>  \<longrightarrow> (((pre_g x  x) \<and> (x < (20::VDMNat1))) \<longrightarrow> (pre_g x  x))))"
	
	try
	oops
	
	\<comment>\<open>@ in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 28:18
VDM PO(8): "h: subtype obligation in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 28:18
(forall x:nat & (pre_g(x, x) and (x < 20)) =>
  x > 0)
"
\<close>
theorem h_SUB_TYPE:
	"(((x::VDMNat) ((inv_VDMNat x) \<and>  \<longrightarrow> (((pre_g x  x) \<and> (x < (20::VDMNat1))) \<longrightarrow> (x > (0::VDMNat)))))"
	
	try
	oops
	
	\<comment>\<open>@ in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 33:5
VDM PO(9): "h': post condition obligation in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 33:5
(forall x:nat &
  pre_h'(x) => post_h'(x, g(x, x)))
"
\<close>
theorem h'_FUNC_POST_CONDITION:
	"(((x::VDMNat) ((inv_VDMNat x) \<and>  \<longrightarrow> ((pre_h' x) \<longrightarrow> (post_h' x  (g x  x)))))"
	
	try
	oops
	
	\<comment>\<open>@ in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 34:14
VDM PO(10): "h': function apply obligation in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 34:14
(forall x:nat & (x < 20) =>
  pre_g(x, x))
"
\<close>
theorem h'_FUNC_APPLY:
	"(((x::VDMNat) ((inv_VDMNat x) \<and>  \<longrightarrow> ((x < (20::VDMNat1)) \<longrightarrow> (pre_g x  x))))"
	
	try
	oops
	
	\<comment>\<open>@ in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 34:19
VDM PO(11): "h': subtype obligation in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 34:19
(forall x:nat & (x < 20) =>
  x > 0)
"
\<close>
theorem h'_SUB_TYPE:
	"(((x::VDMNat) ((inv_VDMNat x) \<and>  \<longrightarrow> ((x < (20::VDMNat1)) \<longrightarrow> (x > (0::VDMNat)))))"
	
	try
	oops
	
	\<comment>\<open>@ in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 43:5
VDM PO(12): "curriedS: post condition obligation in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 43:5
(forall x:nat, y:nat &
  pre_curriedS(x)(y) => post_curriedS(x)(y, (x + y)))
"
\<close>
theorem curriedS_FUNC_POST_CONDITION:
	"(((x::VDMNat)  (y::VDMNat) ((inv_VDMNat x) \<and> (inv_VDMNat y) \<and>  \<longrightarrow> (((pre_curriedS x) y) \<longrightarrow> ((post_curriedS x) y  (x + y)))))"
	
	try
	oops
	
end