(* VDM to Isabelle Translation @2021-11-18T12:41:08.399772Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2IMaps.vdmsl' at line 1:8
files = [./src/test/resources/TestV2IMaps.vdmsl]
*)
theory TestV2IMaps
imports VDMToolkit
begin


\<comment>\<open>in 'TestV2IMaps' (./src/test/resources/TestV2IMaps.vdmsl) at line 7:5\<close>
record R = 
	x\<^sub>R :: "VDMNat"
		 y\<^sub>R :: "VDMNat"
	

\<comment>\<open>in 'TestV2IMaps' (./src/test/resources/TestV2IMaps.vdmsl) at line 10:9\<close>
definition
	inv_R :: "R \<Rightarrow> \<bool>"
where
	"inv_R r \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_R specification\<close>
		( (((inv_VDMNat (x\<^sub>R r))) \<and>
		 ((inv_VDMNat (y\<^sub>R r))) ))  \<and> 
		\<comment>\<open>User defined body of inv_R\<close>
		((x\<^sub>R (r)) < (y\<^sub>R (r)))"
 

	
abbreviation
	t9 :: "VDMNat1 VDMSet1"
where
	"t9 \<equiv> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}"

	definition
	inv_t9 :: "\<bool>"
where
	"inv_t9  \<equiv> (inv_VDMSet1' (inv_VDMNat1) t9)"

	
	
abbreviation
	v65 :: "R"
where
	"v65 \<equiv> \<lparr>x\<^sub>R = (1::VDMNat1), y\<^sub>R = (2::VDMNat1)\<rparr>"

	definition
	inv_v65 :: "\<bool>"
where
	"inv_v65  \<equiv> inv_R v65"

	
	
abbreviation
	v74 :: "VDMNat\<Rightarrow> VDMNat \<Rightarrow> VDMNat"
where
	"v74 \<equiv> (
	\<lambda> (var :: VDMNat)  (var2 :: VDMNat) .
		(if (((inv_VDMNat var))) \<and>  (((inv_VDMNat var2))) \<and> (inv_VDMNat (var + var2)) then
		(var + var2)
	 else
		undefined
	)
	)"

	definition
	inv_v74 :: "VDMNat\<Rightarrow> VDMNat \<Rightarrow> \<bool>"
where
	"inv_v74 dummy0 dummy1 \<equiv> 
	\<comment>\<open>function type invariant depends on its lambda definition dummy names used being equal.\<close>
	(inv_VDMNat (v74 dummy0 dummy1))"

	
	
abbreviation
	v741 :: "R \<Rightarrow> VDMNat"
where
	"v741 \<equiv> (
	\<lambda> (dummy0 :: R) .let x = (x\<^sub>R dummy0); y = (y\<^sub>R dummy0) in 
		(if (( (((inv_VDMNat (x\<^sub>R dummy0))) \<and>
		 ((inv_VDMNat (y\<^sub>R dummy0))) ))) \<and> (inv_VDMNat (x + y)) then
		(x + y)
	 else
		undefined
	)
	)"

	definition
	inv_v741 :: "R \<Rightarrow> \<bool>"
where
	"inv_v741 dummy0 \<equiv> 
	\<comment>\<open>function type invariant depends on its lambda definition dummy names used being equal.\<close>
	(inv_VDMNat (v741 dummy0))"

	
	
abbreviation
	v80 :: "VDMNat1"
where
	"v80 \<equiv> (
		SOME (dummy0::VDMNat1) .(dummy0 \<in> { (x + y) | x  y .  ((x \<in>t9)) \<and>  ((y \<in>t9))  \<and> ((x > (2::VDMNat1)) \<and> (y < x)) }))"

	definition
	inv_v80 :: "\<bool>"
where
	"inv_v80  \<equiv> (inv_VDMNat1 v80)"

	
	
abbreviation
	v801 :: "VDMNat"
where
	"v801 \<equiv> (
		SOME (dummy0::VDMNat) .(dummy0 \<in> { (let x = (x\<^sub>R dummy0); y = (y\<^sub>R dummy0) in (x + y)) | dummy0 .  ((dummy0 \<in>{v65}))  \<and> (let x = (x\<^sub>R dummy0); y = (y\<^sub>R dummy0) in (x < y)) }))"

	definition
	inv_v801 :: "\<bool>"
where
	"inv_v801  \<equiv> (inv_VDMNat v801)"

	
	
abbreviation
	v95 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"v95 \<equiv> "

	definition
	inv_v95 :: "\<bool>"
where
	"inv_v95  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v95)"

	
	
abbreviation
	v952 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"v952 \<equiv> "

	definition
	inv_v952 :: "\<bool>"
where
	"inv_v952  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v952)"

	
	
abbreviation
	v953 :: "(R \<rightharpoonup> VDMNat1)"
where
	"v953 \<equiv> "

	definition
	inv_v953 :: "\<bool>"
where
	"inv_v953  \<equiv> (inv_Map inv_R  (inv_VDMNat1) v953)"

	
	
abbreviation
	v954 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"v954 \<equiv> "

	definition
	inv_v954 :: "\<bool>"
where
	"inv_v954  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v954)"

	
	
abbreviation
	v97 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"v97 \<equiv> "

	definition
	inv_v97 :: "\<bool>"
where
	"inv_v97  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v97)"

	
	
abbreviation
	v98 :: "(VDMNat \<rightharpoonup> VDMNat1)"
where
	"v98 \<equiv> "

	definition
	inv_v98 :: "\<bool>"
where
	"inv_v98  \<equiv> (inv_Map (inv_VDMNat) (inv_VDMNat1) v98)"

	
	
\<comment>\<open>in 'TestV2IMaps' (./src/test/resources/TestV2IMaps.vdmsl) at line 28:5\<close>

\<comment>\<open>in 'TestV2IMaps' (./src/test/resources/TestV2IMaps.vdmsl) at line 28:5\<close>
definition
	pre_v96 :: "\<bool>"
where
	"pre_v96  \<equiv> True"


\<comment>\<open>in 'TestV2IMaps' (./src/test/resources/TestV2IMaps.vdmsl) at line 28:5\<close>
definition
	post_v96 :: "(VDMNat \<rightharpoonup> VDMNat) \<Rightarrow> \<bool>"
where
	"post_v96 RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_v96 specification\<close>
		((inv_Map (inv_VDMNat) (inv_VDMNat) RESULT))"

definition
	v96 :: "(VDMNat \<rightharpoonup> VDMNat)"
where
	"v96  \<equiv> 
	\<comment>\<open>User defined body of v96\<close>
	"

	
\<comment>\<open>in 'TestV2IMaps' (./src/test/resources/TestV2IMaps.vdmsl) at line 31:5\<close>

\<comment>\<open>in 'TestV2IMaps' (./src/test/resources/TestV2IMaps.vdmsl) at line 31:5\<close>
definition
	pre_v961 :: "\<bool>"
where
	"pre_v961  \<equiv> True"


\<comment>\<open>in 'TestV2IMaps' (./src/test/resources/TestV2IMaps.vdmsl) at line 31:5\<close>
definition
	post_v961 :: "(VDMNat \<rightharpoonup> VDMNat) \<Rightarrow> \<bool>"
where
	"post_v961 RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_v961 specification\<close>
		((inv_Map (inv_VDMNat) (inv_VDMNat) RESULT))"

definition
	v961 :: "(VDMNat \<rightharpoonup> VDMNat)"
where
	"v961  \<equiv> 
	\<comment>\<open>User defined body of v961\<close>
	"

end