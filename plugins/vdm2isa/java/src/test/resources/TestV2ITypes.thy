(* VDM to Isabelle Translation @2021-11-14T16:33:06.360533Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2ITypes.vdmsl' at line 1:8
files = [./src/test/resources/TestV2ITypes.vdmsl]
*)
theory TestV2ITypes
imports VDMToolkit
begin


type_synonym TBasic1 = "VDMNat1"
	

definition
	inv_TBasic1 :: "TBasic1 \<Rightarrow> \<bool>"
where
	"inv_TBasic1 dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_TBasic1 specification\<close>
		((inv_VDMNat1 dummy0))"

		 

	
type_synonym TBasic2 = "VDMNat1"
	

definition
	inv_TBasic2 :: "TBasic2 \<Rightarrow> \<bool>"
where
	"inv_TBasic2 t \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_TBasic2 specification\<close>
		((inv_VDMNat1 t))  \<and> 
		\<comment>\<open>User defined body of inv_TBasic2\<close>
		(t > (10::VDMNat1))"

		 

definition
	eq_TBasic2 :: "TBasic2\<Rightarrow> TBasic2 \<Rightarrow> \<bool>"
where
	"eq_TBasic2 t1 t2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for eq_TBasic2 specification\<close>
		((inv_VDMNat1 t1)  \<and>  (inv_VDMNat1 t2))  \<and> 
		\<comment>\<open>User defined body of eq_TBasic2\<close>
		(t1 = t2)"

		 

definition
	ord_TBasic2 :: "TBasic2\<Rightarrow> TBasic2 \<Rightarrow> \<bool>"
where
	"ord_TBasic2 t1 t2 \<equiv> 
		\<comment>\<open>User defined body of ord_TBasic2\<close>
		(t1 < t2)"

		 

definition
	min_TBasic2 :: "TBasic2\<Rightarrow> TBasic2 \<Rightarrow> TBasic2"
where
	"min_TBasic2 a b \<equiv> 
		\<comment>\<open>User defined body of min_TBasic2\<close>
		(
		if (((a < b) \<or> (a = b))) then
		(a)
		else
		(b))"

	

definition
	max_TBasic2 :: "TBasic2\<Rightarrow> TBasic2 \<Rightarrow> TBasic2"
where
	"max_TBasic2 a b \<equiv> 
		\<comment>\<open>User defined body of max_TBasic2\<close>
		(
		if (((a < b) \<or> (a = b))) then
		(b)
		else
		(a))"

	

	
type_synonym TSet = "VDMNat1 VDMSet"
	

definition
	inv_TSet :: "TSet \<Rightarrow> \<bool>"
where
	"inv_TSet s \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_TSet specification\<close>
		((inv_VDMSet' (inv_VDMNat1) s))  \<and> 
		\<comment>\<open>User defined body of inv_TSet\<close>
		(s \<noteq> {})"

		 

definition
	eq_TSet :: "TSet\<Rightarrow> TSet \<Rightarrow> \<bool>"
where
	"eq_TSet s1 s2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for eq_TSet specification\<close>
		((inv_VDMSet' (inv_VDMNat1) s1)  \<and>  (inv_VDMSet' (inv_VDMNat1) s2))  \<and> 
		\<comment>\<open>User defined body of eq_TSet\<close>
		(s1 \<subseteq> s2)"

		 

definition
	ord_TSet :: "TSet\<Rightarrow> TSet \<Rightarrow> \<bool>"
where
	"ord_TSet s1 s2 \<equiv> 
		\<comment>\<open>User defined body of ord_TSet\<close>
		((vdm_card s1) < (vdm_card s2))"

		 

definition
	min_TSet :: "TSet\<Rightarrow> TSet \<Rightarrow> TSet"
where
	"min_TSet a b \<equiv> 
		\<comment>\<open>User defined body of min_TSet\<close>
		(
		if (((a < b) \<or> (a = b))) then
		(a)
		else
		(b))"

	

definition
	max_TSet :: "TSet\<Rightarrow> TSet \<Rightarrow> TSet"
where
	"max_TSet a b \<equiv> 
		\<comment>\<open>User defined body of max_TSet\<close>
		(
		if (((a < b) \<or> (a = b))) then
		(b)
		else
		(a))"

	

	
type_synonym TSeq = "VDMNat1 VDMSeq1"
	

definition
	inv_TSeq :: "TSeq \<Rightarrow> \<bool>"
where
	"inv_TSeq s \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_TSeq specification\<close>
		((inv_VDMSeq1' (inv_VDMNat1) s))  \<and> 
		\<comment>\<open>User defined body of inv_TSeq\<close>
		((vdm_card (elems s)) = (len s))"

		 

definition
	eq_TSeq :: "TSeq\<Rightarrow> TSeq \<Rightarrow> \<bool>"
where
	"eq_TSeq s1 s2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for eq_TSeq specification\<close>
		((inv_VDMSeq1' (inv_VDMNat1) s1)  \<and>  (inv_VDMSeq1' (inv_VDMNat1) s2))  \<and> 
		\<comment>\<open>User defined body of eq_TSeq\<close>
		((elems s1) = (elems s2))"

		 

definition
	ord_TSeq :: "TSeq\<Rightarrow> TSeq \<Rightarrow> \<bool>"
where
	"ord_TSeq s1 s2 \<equiv> 
		\<comment>\<open>User defined body of ord_TSeq\<close>
		((len s1) < (len s2))"

		 

definition
	min_TSeq :: "TSeq\<Rightarrow> TSeq \<Rightarrow> TSeq"
where
	"min_TSeq a b \<equiv> 
		\<comment>\<open>User defined body of min_TSeq\<close>
		(
		if (((a < b) \<or> (a = b))) then
		(a)
		else
		(b))"

	

definition
	max_TSeq :: "TSeq\<Rightarrow> TSeq \<Rightarrow> TSeq"
where
	"max_TSeq a b \<equiv> 
		\<comment>\<open>User defined body of max_TSeq\<close>
		(
		if (((a < b) \<or> (a = b))) then
		(b)
		else
		(a))"

	

	
type_synonym TMap = "(VDMNat1 \<rightharpoonup> VDMNat1)"
	

definition
	inv_TMap :: "TMap \<Rightarrow> \<bool>"
where
	"inv_TMap m \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_TMap specification\<close>
		((inv_Map (inv_VDMNat1) (inv_VDMNat1) m))  \<and> 
		\<comment>\<open>User defined body of inv_TMap\<close>
		((dom m) \<noteq> {})"

		 

definition
	eq_TMap :: "TMap\<Rightarrow> TMap \<Rightarrow> \<bool>"
where
	"eq_TMap m1 m2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for eq_TMap specification\<close>
		((inv_Map (inv_VDMNat1) (inv_VDMNat1) m1)  \<and>  (inv_Map (inv_VDMNat1) (inv_VDMNat1) m2))  \<and> 
		\<comment>\<open>User defined body of eq_TMap\<close>
		(((dom m1) = (dom m2)) \<and> (\<forall> x \<in> (dom m1)  . ((the(m1 x)) = (the(m2 x)))))"

		 

definition
	ord_TMap :: "TMap\<Rightarrow> TMap \<Rightarrow> \<bool>"
where
	"ord_TMap m1 m2 \<equiv> 
		\<comment>\<open>User defined body of ord_TMap\<close>
		(((dom m1) \<subseteq> (dom m2)) \<or> (((dom m1) = (dom m2)) \<and> (\<forall> x \<in> (dom m1)  . ((the(m1 x)) < (the(m2 x))))))"

		 

definition
	min_TMap :: "TMap\<Rightarrow> TMap \<Rightarrow> TMap"
where
	"min_TMap a b \<equiv> 
		\<comment>\<open>User defined body of min_TMap\<close>
		(
		if (((a < b) \<or> (a = b))) then
		(a)
		else
		(b))"

	

definition
	max_TMap :: "TMap\<Rightarrow> TMap \<Rightarrow> TMap"
where
	"max_TMap a b \<equiv> 
		\<comment>\<open>User defined body of max_TMap\<close>
		(
		if (((a < b) \<or> (a = b))) then
		(b)
		else
		(a))"

	

end