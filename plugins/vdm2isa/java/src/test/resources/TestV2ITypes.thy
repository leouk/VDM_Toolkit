(* VDM to Isabelle Translation @2021-11-18T14:45:38.376489Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2ITypes.vdmsl' at line 1:8
files = [./src/test/resources/TestV2ITypes.vdmsl]
*)
theory TestV2ITypes
imports VDMToolkit
begin


\<comment>\<open>in 'TestV2ITypes' (./src/test/resources/TestV2ITypes.vdmsl) at line 11:5\<close>
type_synonym TBasic1 = "VDMNat1"
	

\<comment>\<open>in 'TestV2ITypes' (./src/test/resources/TestV2ITypes.vdmsl) at line 11:5\<close>
definition
	inv_TBasic1 :: "TBasic1 \<Rightarrow> \<bool>"
where
	"inv_TBasic1 dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_TBasic1 specification\<close>
		((inv_VDMNat1 dummy0))"

		 

	
\<comment>\<open>in 'TestV2ITypes' (./src/test/resources/TestV2ITypes.vdmsl) at line 14:5\<close>
type_synonym TBasic2 = "VDMNat1"
	

\<comment>\<open>in 'TestV2ITypes' (./src/test/resources/TestV2ITypes.vdmsl) at line 15:9\<close>
definition
	inv_TBasic2 :: "TBasic2 \<Rightarrow> \<bool>"
where
	"inv_TBasic2 t \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_TBasic2 specification\<close>
		((inv_VDMNat1 t))  \<and> 
		\<comment>\<open>User defined body of inv_TBasic2\<close>
		(t > (10::VDMNat1))"

		 

\<comment>\<open>in 'TestV2ITypes' (./src/test/resources/TestV2ITypes.vdmsl) at line 16:23\<close>
definition
	eq_TBasic2 :: "TBasic2\<Rightarrow> TBasic2 \<Rightarrow> \<bool>"
where
	"eq_TBasic2 t1 t2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for eq_TBasic2 specification\<close>
		((inv_VDMNat1 t1)  \<and>  (inv_VDMNat1 t2))  \<and> 
		\<comment>\<open>User defined body of eq_TBasic2\<close>
		(t1 = t2)"

		 

\<comment>\<open>in 'TestV2ITypes' (./src/test/resources/TestV2ITypes.vdmsl) at line 17:23\<close>
definition
	ord_TBasic2 :: "TBasic2\<Rightarrow> TBasic2 \<Rightarrow> \<bool>"
where
	"ord_TBasic2 t1 t2 \<equiv> 
		\<comment>\<open>User defined body of ord_TBasic2\<close>
		(t1 < t2)"

		 

\<comment>\<open>in 'TestV2ITypes' (./src/test/resources/TestV2ITypes.vdmsl) at line 17:23\<close>
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

	

\<comment>\<open>in 'TestV2ITypes' (./src/test/resources/TestV2ITypes.vdmsl) at line 17:23\<close>
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

	

	
\<comment>\<open>in 'TestV2ITypes' (./src/test/resources/TestV2ITypes.vdmsl) at line 20:5\<close>
type_synonym TSet = "VDMNat1 VDMSet"
	

\<comment>\<open>in 'TestV2ITypes' (./src/test/resources/TestV2ITypes.vdmsl) at line 21:9\<close>
definition
	inv_TSet :: "TSet \<Rightarrow> \<bool>"
where
	"inv_TSet s \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_TSet specification\<close>
		((inv_VDMSet' (inv_VDMNat1) s))  \<and> 
		\<comment>\<open>User defined body of inv_TSet\<close>
		(s \<noteq> {})"

		 

\<comment>\<open>in 'TestV2ITypes' (./src/test/resources/TestV2ITypes.vdmsl) at line 22:23\<close>
definition
	eq_TSet :: "TSet\<Rightarrow> TSet \<Rightarrow> \<bool>"
where
	"eq_TSet s1 s2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for eq_TSet specification\<close>
		((inv_VDMSet' (inv_VDMNat1) s1)  \<and>  (inv_VDMSet' (inv_VDMNat1) s2))  \<and> 
		\<comment>\<open>User defined body of eq_TSet\<close>
		(s1 \<subseteq> s2)"

		 

\<comment>\<open>in 'TestV2ITypes' (./src/test/resources/TestV2ITypes.vdmsl) at line 23:28\<close>
definition
	ord_TSet :: "TSet\<Rightarrow> TSet \<Rightarrow> \<bool>"
where
	"ord_TSet s1 s2 \<equiv> 
		\<comment>\<open>User defined body of ord_TSet\<close>
		((vdm_card s1) < (vdm_card s2))"

		 

\<comment>\<open>in 'TestV2ITypes' (./src/test/resources/TestV2ITypes.vdmsl) at line 23:28\<close>
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

	

\<comment>\<open>in 'TestV2ITypes' (./src/test/resources/TestV2ITypes.vdmsl) at line 23:28\<close>
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

	

	
\<comment>\<open>in 'TestV2ITypes' (./src/test/resources/TestV2ITypes.vdmsl) at line 26:5\<close>
type_synonym TSeq = "VDMNat1 VDMSeq1"
	

\<comment>\<open>in 'TestV2ITypes' (./src/test/resources/TestV2ITypes.vdmsl) at line 27:9\<close>
definition
	inv_TSeq :: "TSeq \<Rightarrow> \<bool>"
where
	"inv_TSeq s \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_TSeq specification\<close>
		((inv_VDMSeq1' (inv_VDMNat1) s))  \<and> 
		\<comment>\<open>User defined body of inv_TSeq\<close>
		((vdm_card (elems s)) = (len s))"

		 

\<comment>\<open>in 'TestV2ITypes' (./src/test/resources/TestV2ITypes.vdmsl) at line 28:29\<close>
definition
	eq_TSeq :: "TSeq\<Rightarrow> TSeq \<Rightarrow> \<bool>"
where
	"eq_TSeq s1 s2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for eq_TSeq specification\<close>
		((inv_VDMSeq1' (inv_VDMNat1) s1)  \<and>  (inv_VDMSeq1' (inv_VDMNat1) s2))  \<and> 
		\<comment>\<open>User defined body of eq_TSeq\<close>
		((elems s1) = (elems s2))"

		 

\<comment>\<open>in 'TestV2ITypes' (./src/test/resources/TestV2ITypes.vdmsl) at line 29:27\<close>
definition
	ord_TSeq :: "TSeq\<Rightarrow> TSeq \<Rightarrow> \<bool>"
where
	"ord_TSeq s1 s2 \<equiv> 
		\<comment>\<open>User defined body of ord_TSeq\<close>
		((len s1) < (len s2))"

		 

\<comment>\<open>in 'TestV2ITypes' (./src/test/resources/TestV2ITypes.vdmsl) at line 29:27\<close>
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

	

\<comment>\<open>in 'TestV2ITypes' (./src/test/resources/TestV2ITypes.vdmsl) at line 29:27\<close>
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

	

	
\<comment>\<open>in 'TestV2ITypes' (./src/test/resources/TestV2ITypes.vdmsl) at line 32:5\<close>
type_synonym TMap = "(VDMNat1 \<rightharpoonup> VDMNat1)"
	

\<comment>\<open>in 'TestV2ITypes' (./src/test/resources/TestV2ITypes.vdmsl) at line 33:9\<close>
definition
	inv_TMap :: "TMap \<Rightarrow> \<bool>"
where
	"inv_TMap m \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_TMap specification\<close>
		((inv_Map (inv_VDMNat1) (inv_VDMNat1) m))  \<and> 
		\<comment>\<open>User defined body of inv_TMap\<close>
		((dom m) \<noteq> {})"

		 

\<comment>\<open>in 'TestV2ITypes' (./src/test/resources/TestV2ITypes.vdmsl) at line 34:35\<close>
definition
	eq_TMap :: "TMap\<Rightarrow> TMap \<Rightarrow> \<bool>"
where
	"eq_TMap m1 m2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for eq_TMap specification\<close>
		((inv_Map (inv_VDMNat1) (inv_VDMNat1) m1)  \<and>  (inv_Map (inv_VDMNat1) (inv_VDMNat1) m2))  \<and> 
		\<comment>\<open>User defined body of eq_TMap\<close>
		(((dom m1) = (dom m2)) \<and> (\<forall> x \<in> (dom m1)  . ((the(m1 x)) = (the(m2 x)))))"

		 

\<comment>\<open>in 'TestV2ITypes' (./src/test/resources/TestV2ITypes.vdmsl) at line 37:9\<close>
definition
	ord_TMap :: "TMap\<Rightarrow> TMap \<Rightarrow> \<bool>"
where
	"ord_TMap m1 m2 \<equiv> 
		\<comment>\<open>User defined body of ord_TMap\<close>
		(((dom m1) \<subseteq> (dom m2)) \<or> (((dom m1) = (dom m2)) \<and> (\<forall> x \<in> (dom m1)  . ((the(m1 x)) < (the(m2 x))))))"

		 

\<comment>\<open>in 'TestV2ITypes' (./src/test/resources/TestV2ITypes.vdmsl) at line 37:9\<close>
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

	

\<comment>\<open>in 'TestV2ITypes' (./src/test/resources/TestV2ITypes.vdmsl) at line 37:9\<close>
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