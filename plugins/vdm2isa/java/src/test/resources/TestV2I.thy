(* VDM to Isabelle Translated
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

files = [./src/test/resources/TestV2I.vdmsl]
*)
theory TestV2I
imports "VDMToolkit"
begin

record R = 
	field1 :: "VDMNat"
	field2 :: "VDMNat"

definition
	inv_R :: "R \<Rightarrow> \<bool>"
where
	"inv_R x \<equiv> 
		(((inv_VDMNat (field1 x))) \<and>
		 ((inv_VDMNat (field2 x)))
		)"

end