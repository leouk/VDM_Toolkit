(* VDM to Isabelle Translated
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

files = [./src/main/resources/TestV2I.vdmsl]
*)
theory TestV2I
imports VDMToolkit
begin

(* S = seq of nat1; 
   T = seq of S;

   R = seq of seq nat1;
   s = [1,2]
   t = [s,s]  *)
lemma "inv_VDMSeq' (inv_VDMSeq' inv_VDMNat1) [[1,2],[1,2]]"
  unfolding inv_VDMSeq'_def 
  unfolding inv_SeqElems_def inv_VDMNat1_def apply simp done

abbreviation
	a :: "bool"
where
	"a \<equiv> (True::\<bool>)"

definition
	inv_a :: "\<bool>"
where
	"inv_a \<equiv> inv_bool a"

abbreviation
	c :: "VDMChar"
where
	"c \<equiv> (CHR ''A''::VDMChar)"

definition
	inv_c :: "\<bool>"
where
	"inv_c \<equiv> inv_VDMChar c"

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
	s1 :: "VDMNat1 VDMSet1"
where
	"s1 \<equiv> {(1::VDMNat),(2::VDMNat),(3::VDMNat)}"

definition
	inv_s1 :: "\<bool>"
where
	"inv_s1 \<equiv> inv_VDMSet1 s1"

abbreviation
	s2 :: "VDMNat1 VDMSeq1"
where
	"s2 \<equiv> [(1::VDMNat),(2::VDMNat),(3::VDMNat)]"

definition
	inv_s2 :: "\<bool>"
where
	"inv_s2 \<equiv> inv_VDMNat1 VDMSeq1 s2"

abbreviation
	ss1 :: "VDMNat1 VDMSet1 VDMSet1"
where
	"ss1 \<equiv> {{(1::VDMNat),(2::VDMNat)},{(2::VDMNat),(4::VDMNat)}}"

definition
	inv_ss1 :: "\<bool>"
where
	"inv_ss1 \<equiv> inv_VDMNat1 VDMSet1 VDMSet1 ss1"

abbreviation
	ss2 :: "VDMNat1 VDMSeq1 VDMSeq1"
where
	"ss2 \<equiv> [[(1::VDMNat),(2::VDMNat)],[(3::VDMNat),(4::VDMNat)]]"

definition
	inv_ss2 :: "\<bool>"
where
	"inv_ss2 \<equiv> inv_VDMNat1 VDMSeq1 VDMSeq1 ss2"

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

abbreviation
	v4 :: "VDMNat1"
where
	"v4 \<equiv> (vdm_card s1)"

definition
	inv_v4 :: "\<bool>"
where
	"inv_v4 \<equiv> inv_VDMNat1 v4"

abbreviation
	v5 :: "VDMNat1"
where
	"v5 \<equiv> (len s2)"

definition
	inv_v5 :: "\<bool>"
where
	"inv_v5 \<equiv> inv_VDMNat1 v5"

abbreviation
	v6 :: "VDMNat1"
where
	"v6 \<equiv> (hd s2)"

definition
	inv_v6 :: "\<bool>"
where
	"inv_v6 \<equiv> inv_VDMNat1 v6"

abbreviation
	v7 :: "VDMNat1 VDMSeq"
where
	"v7 \<equiv> (tl s2)"

definition
	inv_v7 :: "\<bool>"
where
	"inv_v7 \<equiv> inv_VDMNat1 VDMSeq v7"

abbreviation
	v8 :: "VDMNat1 VDMSet"
where
	"v8 \<equiv> (inds s2)"

definition
	inv_v8 :: "\<bool>"
where
	"inv_v8 \<equiv> inv_VDMNat1 VDMSet v8"

abbreviation
	v9 :: "VDMNat1 VDMSeq1"
where
	"v9 \<equiv> (conc ss2)"

definition
	inv_v9 :: "\<bool>"
where
	"inv_v9 \<equiv> inv_VDMNat1 VDMSeq1 v9"

abbreviation
	v10 :: "VDMNat1 VDMSet1"
where
	"v10 \<equiv> (\<Inter> ss1)"

definition
	inv_v10 :: "\<bool>"
where
	"inv_v10 \<equiv> inv_VDMNat1 VDMSet1 v10"

abbreviation
	v11 :: "VDMNat1 VDMSet1"
where
	"v11 \<equiv> (\<Union> ss1)"

definition
	inv_v11 :: "\<bool>"
where
	"inv_v11 \<equiv> inv_VDMNat1 VDMSet1 v11"


end