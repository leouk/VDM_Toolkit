(* VDM to Isabelle Translated
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2ITypes.vdmsl' at line 1:8files = [./src/test/resources/TestV2ITypes.vdmsl]
*)
theory TestV2ITypes
imports VDMToolkit
begin


type_synonym TBasic = "TBasic = VDMNat1"
	
	definition
	inv_TBasic :: " \<Rightarrow> \<bool>"
where
	"inv_TBasic  \<equiv> inv_TBasic  \<and> "

	
type_synonym TSet = "TSet = TBasic = VDMNat1 VDMSet"
	
	definition
	inv_TSet :: " \<Rightarrow> \<bool>"
where
	"inv_TSet  \<equiv> inv_TSet  \<and> "

	
type_synonym TOptional = "TOptional = VDMNat1\<Rightarrow>option"
	
	definition
	inv_TOptional :: " \<Rightarrow> \<bool>"
where
	"inv_TOptional  \<equiv> inv_TOptional  \<and> "

	
type_synonym TFcn = "TFcn = VDMNat1 \<Rightarrow> VDMNat1"
	
	definition
	inv_TFcn :: " \<Rightarrow> \<bool>"
where
	"inv_TFcn  \<equiv> inv_TFcn  \<and> "

	
abbreviation
	v :: "TFcn = VDMNat1 \<Rightarrow> VDMNat1"
where
	"v \<equiv> (
	\<lambda> (x :: VDMNat1) .
		(if (((inv_VDMNat1 x))) then
		((x * x) + (10::VDMNat1))
	 else
		undefined
	)
	)"

	definition
	inv_v :: "\<bool>"
where
	"inv_v  \<equiv> (inv_TFcn v)"

	
end