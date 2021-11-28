(* VDM to Isabelle Translation @2021-11-28T06:54:35.717996Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2IWarnings.vdmsl' at line 1:8
files = [./src/test/resources/TestV2IWarnings.vdmsl]
*)
theory TestV2IWarnings
imports VDMToolkit
begin


abbreviation
	v38 :: "'UNKNOWN option"
where
	"v38 \<equiv> None"

	definition
	inv_v38 :: "\<bool>"
where
	"inv_v38  \<equiv> (inv_Option inv_True
	\<comment>\<open>Unknown VDM types will generate Isabelle additional type variable `a warning.\<close> v38)"

	
end