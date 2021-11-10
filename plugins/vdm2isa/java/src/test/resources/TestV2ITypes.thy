(* VDM to Isabelle Translated
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2ITypes.vdmsl' at line 1:8files = [./src/test/resources/TestV2ITypes.vdmsl]
*)
theory TestV2ITypes
imports VDMToolkit
begin


type_synonym TBasic = "VDMNat1"
	
	definition
	inv_TBasic :: "VDMNat1 \<Rightarrow> \<bool>"
where
	"inv_TBasic  \<equiv> inv_TBasic  \<and> ((inv_TBasic TBasic))"

	
type_synonym TSet = "TBasic = "VDMNat1" VDMSet"
	
	definition
	inv_TSet :: "TBasic = "VDMNat1" VDMSet \<Rightarrow> \<bool>"
where
	"inv_TSet  \<equiv> inv_TSet  \<and> ((inv_TSet TSet))"

	
type_synonym TOptional = "VDMNat1\<Rightarrow>option"
	
	definition
	inv_TOptional :: "VDMNat1\<Rightarrow>option \<Rightarrow> \<bool>"
where
	"inv_TOptional  \<equiv> inv_TOptional  \<and> ((inv_TOptional TOptional))"

	
type_synonym TFcn = "VDMNat1 \<Rightarrow> VDMNat1"
	
	definition
	inv_TFcn :: "VDMNat1 \<Rightarrow> VDMNat1 \<Rightarrow> \<bool>"
where
	"inv_TFcn  \<equiv> inv_TFcn  \<and> ((inv_TFcn TFcn))"

	
abbreviation
	v :: "TFcn = "VDMNat1 \<Rightarrow> VDMNat1""
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