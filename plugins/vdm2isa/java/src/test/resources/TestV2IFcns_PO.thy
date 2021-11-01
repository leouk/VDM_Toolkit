(* VDM to Isabelle Translated
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 21:5
*)
theory TestV2IFcns_PO
imports TestV2IFcns
begin

\<comment>\<open>@ in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 21:5
VDM po: g: post condition obligation in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 21:5
(forall x:nat, y:nat1 &
  pre_g(x, y) => post_g(x, y, (x + y)))

\<close>theorem g_FUNC_POST_CONDITION:
	"((\<forall> (x::VDMNat) (y::VDMNat1). ((pre_g x  y) \<longrightarrow> (post_g x  y  (x + y)))))"
	
	try
	oops
	
	\<comment>\<open>@ in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 29:18
VDM po: h: subtype obligation in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 29:18
(forall x:nat &
  x > 0)

\<close>theorem h_SUB_TYPE:
	"((\<forall> (x::VDMNat). (x > (0::VDMNat))))"
	
	try
	oops
	
	\<comment>\<open>@ in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 27:5
VDM po: h: post condition obligation in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 27:5
(forall x:nat &
  pre_h(x) => post_h(x, g(x, x)))

\<close>theorem h_FUNC_POST_CONDITION:
	"((\<forall> (x::VDMNat). ((pre_h x) \<longrightarrow> (post_h x  (g x  x)))))"
	
	try
	oops
	
	\<comment>\<open>@ in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 28:13
VDM po: h: function apply obligation in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 28:13
(forall x:nat & (pre_g(x, x) and (x < 20)) =>
  pre_g(x, x))

\<close>theorem h_FUNC_APPLY:
	"((\<forall> (x::VDMNat). (((pre_g x  x) \<and> (x < (20::VDMNat1))) \<longrightarrow> (pre_g x  x))))"
	
	try
	oops
	
	\<comment>\<open>@ in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 28:18
VDM po: h: subtype obligation in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 28:18
(forall x:nat & (pre_g(x, x) and (x < 20)) =>
  x > 0)

\<close>theorem h_SUB_TYPE:
	"((\<forall> (x::VDMNat). (((pre_g x  x) \<and> (x < (20::VDMNat1))) \<longrightarrow> (x > (0::VDMNat)))))"
	
	try
	oops
	
end