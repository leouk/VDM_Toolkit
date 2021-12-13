(* VDM to Isabelle Translation @2021-12-13T14:24:18.254Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in '/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsSets.vdmsl' at line 1:8
files = [/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsSets.vdmsl]
*)
theory TestV2IExprsSets
imports "VDMToolkit" 
begin


\<comment>\<open>VDM source: fv:nat1 = 1\<close>
\<comment>\<open>in 'TestV2IExprsSets' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsSets.vdmsl) at line 6:5\<close>
abbreviation
	fv :: "VDMNat1"
where
	"fv \<equiv> (1::VDMNat1)"

	definition
	inv_fv :: "\<bool>"
where
	"inv_fv  \<equiv> (inv_VDMNat1 fv)"

	
	
\<comment>\<open>VDM source: v0:set of (nat1) = {x | x in set {1, 2, 3}}\<close>
\<comment>\<open>in 'TestV2IExprsSets' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsSets.vdmsl) at line 7:5\<close>
abbreviation
	v0 :: "VDMNat1 VDMSet"
where
	"v0 \<equiv> { x .   ((x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}))  }"

	definition
	inv_v0 :: "\<bool>"
where
	"inv_v0  \<equiv> (inv_VDMSet' (inv_VDMNat1) v0)"

	
	
\<comment>\<open>VDM source: v1:set of (nat1) = {(1 + fv) | x in set {1, 2, 3}}\<close>
\<comment>\<open>in 'TestV2IExprsSets' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsSets.vdmsl) at line 8:5\<close>
abbreviation
	v1 :: "VDMNat1 VDMSet"
where
	"v1 \<equiv> {((1::VDMNat1)+fv)}"

	definition
	inv_v1 :: "\<bool>"
where
	"inv_v1  \<equiv> (inv_VDMSet' (inv_VDMNat1) v1)"

	
	
\<comment>\<open>VDM source: v2:set of (nat1) = {x | x in set {1, 2, 3}}\<close>
\<comment>\<open>in 'TestV2IExprsSets' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsSets.vdmsl) at line 9:5\<close>
abbreviation
	v2 :: "VDMNat1 VDMSet"
where
	"v2 \<equiv> { x .   ((x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}))  }"

	definition
	inv_v2 :: "\<bool>"
where
	"inv_v2  \<equiv> (inv_VDMSet' (inv_VDMNat1) v2)"

	
	
\<comment>\<open>VDM source: v3:set1 of (nat1) = {(1 + fv), (2 + fv), (3 + fv)}\<close>
\<comment>\<open>in 'TestV2IExprsSets' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsSets.vdmsl) at line 10:5\<close>
abbreviation
	v3 :: "VDMNat1 VDMSet1"
where
	"v3 \<equiv> {((1::VDMNat1) + fv), ((2::VDMNat1) + fv), ((3::VDMNat1) + fv)}"

	definition
	inv_v3 :: "\<bool>"
where
	"inv_v3  \<equiv> (inv_VDMSet1' (inv_VDMNat1) v3)"

	
end