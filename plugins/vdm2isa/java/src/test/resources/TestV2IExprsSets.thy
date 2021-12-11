(* VDM to Isabelle Translation @2021-12-11T09:47:21.202678Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2IExprsSets.vdmsl' at line 1:8
files = [./src/test/resources/TestV2IExprsSets.vdmsl]
*)
theory TestV2IExprsSets
imports VDMToolkit
begin


abbreviation
	fv :: "VDMNat1"
where
	"fv \<equiv> (1::VDMNat1)"

	definition
	inv_fv :: "\<bool>"
where
	"inv_fv  \<equiv> (inv_VDMNat1 fv)"

	
	
abbreviation
	v0 :: "VDMNat1 VDMSet"
where
	"v0 \<equiv> { x .   ((x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}))  }"

	definition
	inv_v0 :: "\<bool>"
where
	"inv_v0  \<equiv> (inv_VDMSet' (inv_VDMNat1) v0)"

	
	
abbreviation
	v1 :: "VDMNat1 VDMSet"
where
	"v1 \<equiv> {((1::VDMNat1)+fv)}"

	definition
	inv_v1 :: "\<bool>"
where
	"inv_v1  \<equiv> (inv_VDMSet' (inv_VDMNat1) v1)"

	
	
abbreviation
	v2 :: "VDMNat1 VDMSet"
where
	"v2 \<equiv> { x .   ((x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}))  }"

	definition
	inv_v2 :: "\<bool>"
where
	"inv_v2  \<equiv> (inv_VDMSet' (inv_VDMNat1) v2)"

	
	
abbreviation
	v3 :: "VDMNat1 VDMSet1"
where
	"v3 \<equiv> {((1::VDMNat1) + fv), ((2::VDMNat1) + fv), ((3::VDMNat1) + fv)}"

	definition
	inv_v3 :: "\<bool>"
where
	"inv_v3  \<equiv> (inv_VDMSet1' (inv_VDMNat1) v3)"

	
end