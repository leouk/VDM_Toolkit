(* VDM to Isabelle Translated
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/main/resources/TestV2I.vdmsl' at line 1:8
*)
theory TestV2I
imports VDMToolkit
begin

abbreviation
	a :: "\<bool>"
where
	"a \<equiv> (true::\<bool>)"

definition
	inv_a :: "\<bool>"
where
	"inv_a \<equiv> inv_\<bool> a"

abbreviation
	c :: "\<bool>"
where
	"c \<equiv> (a::VDMChar)"

definition
	inv_c :: "\<bool>"
where
	"inv_c \<equiv> inv_\<bool> c"

abbreviation
	i :: "VDMInt"
where
	"i \<equiv> (10::VDMNat)"

definition
	inv_i :: "\<bool>"
where
	"inv_i \<equiv> inv_VDMInt i"

abbreviation
	x :: "VDMNat"
where
	"x \<equiv> (10::VDMNat)"

definition
	inv_x :: "\<bool>"
where
	"inv_x \<equiv> inv_VDMNat x"

abbreviation
	y :: "VDMNat1"
where
	"y \<equiv> (20::VDMNat)"

definition
	inv_y :: "\<bool>"
where
	"inv_y \<equiv> inv_VDMNat1 y"

abbreviation
	r :: "VDMReal"
where
	"r \<equiv> (4.5::VDMReal)"

definition
	inv_r :: "\<bool>"
where
	"inv_r \<equiv> inv_VDMReal r"

abbreviation
	v1 :: "VDMNat1"
where
	"v1 \<equiv> (vdm_abs (10::VDMNat))"

definition
	inv_v1 :: "\<bool>"
where
	"inv_v1 \<equiv> inv_VDMNat1 v1"

abbreviation
	v2 :: "VDMInt"
where
	"v2 \<equiv> (vdm_floor (5::VDMNat))"

definition
	inv_v2 :: "\<bool>"
where
	"inv_v2 \<equiv> inv_VDMInt v2"

abbreviation
	v3 :: "VDMInt"
where
	"v3 \<equiv> (vdm_floor (4.5::VDMReal))"

definition
	inv_v3 :: "\<bool>"
where
	"inv_v3 \<equiv> inv_VDMInt v3"


end