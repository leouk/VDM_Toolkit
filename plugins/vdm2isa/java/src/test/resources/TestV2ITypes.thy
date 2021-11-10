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
definition
	inv_TBasic :: "TBasic \<Rightarrow> \<bool>"
where
	"inv_TBasic dummy0 \<equiv> (inv_TBasic dummy0)"

end