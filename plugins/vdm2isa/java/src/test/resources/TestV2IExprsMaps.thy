(* VDM to Isabelle Translation @2021-12-11T08:01:20.908713Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2IExprsMaps.vdmsl' at line 1:8
files = [./src/test/resources/TestV2IExprsMaps.vdmsl]
*)
theory TestV2IExprsMaps
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
	v3 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"v3 \<equiv> (\<comment>\<open>VDM Map comprehension is translated as a lambda-term through mapCompSetBound\<close>
		mapCompSetBound 
		{ (x + y) | x  y .  ((x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)})) \<and>  ((y \<in>{(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}))  \<and> (x < y) } 
		{ ((10::VDMNat1) + fv) | x  y .  ((x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)})) \<and>  ((y \<in>{(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}))  \<and> (x < y) } 
		(inv_VDMNat1) 
		(inv_VDMNat1) 
		(
	\<lambda> (dummy0DOMAIN :: VDMNat1)  (dummy0RANGE :: VDMNat1) .
		(if (((inv_VDMNat1 dummy0DOMAIN))) \<and>  (((inv_VDMNat1 dummy0RANGE))) \<and> (inv_VDMNat1 (
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}  . (((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)})) \<and> ((dummy0DOMAIN = (x + y)) \<and> (x < y)))))) then
		(dummy0DOMAIN)
		else
		(undefined))) then
		(
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}  . (((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)})) \<and> ((dummy0DOMAIN = (x + y)) \<and> (x < y)))))) then
		(dummy0DOMAIN)
		else
		(undefined))
	 else
		undefined
	)
	) 
		(
	\<lambda> (dummy0DOMAIN :: VDMNat1)  (dummy0RANGE :: VDMNat1) .
		(if (((inv_VDMNat1 dummy0DOMAIN))) \<and>  (((inv_VDMNat1 dummy0RANGE))) \<and> (inv_VDMNat1 (
		if ((\<exists>   . (False::\<bool>))) then
		(dummy0RANGE)
		else
		(undefined))) then
		(
		if ((\<exists>   . (False::\<bool>))) then
		(dummy0RANGE)
		else
		(undefined))
	 else
		undefined
	)
	) 
		(
	\<lambda> (dummy0DOMAIN :: VDMNat1)  (dummy0RANGE :: VDMNat1) .
		(if (((inv_VDMNat1 dummy0DOMAIN))) \<and>  (((inv_VDMNat1 dummy0RANGE))) \<and> (inv_bool (
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}  . (((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)})) \<and> (x < y))))) then
		((True::\<bool>))
		else
		(undefined))) then
		(
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}  . (((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)})) \<and> (x < y))))) then
		((True::\<bool>))
		else
		(undefined))
	 else
		undefined
	)
	))"

	definition
	inv_v3 :: "\<bool>"
where
	"inv_v3  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v3)"

	
end