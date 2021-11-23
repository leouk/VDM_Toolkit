(* VDM to Isabelle Translation @2021-11-23T15:08:13.211654Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2ITypesStructured.vdmsl' at line 1:8
files = [./src/test/resources/TestV2ITypesStructured.vdmsl]
*)
theory TestV2ITypesStructured
imports VDMToolkit
begin


\<comment>\<open>in 'TestV2ITypesStructured' (./src/test/resources/TestV2ITypesStructured.vdmsl) at line 10:5\<close>
type_synonym TSet = "VDMNat1 VDMSet"
	

\<comment>\<open>in 'TestV2ITypesStructured' (./src/test/resources/TestV2ITypesStructured.vdmsl) at line 11:9\<close>
definition
	inv_TSet :: "TSet \<Rightarrow> \<bool>"
where
	"inv_TSet s \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_TSet specification\<close>
		(((inv_VDMSet' (inv_VDMNat1) s)))  \<and> 
		\<comment>\<open>User defined body of inv_TSet\<close>
		(s \<noteq> {})"
 

\<comment>\<open>in 'TestV2ITypesStructured' (./src/test/resources/TestV2ITypesStructured.vdmsl) at line 12:23\<close>
definition
	eq_TSet :: "TSet\<Rightarrow> TSet \<Rightarrow> \<bool>"
where
	"eq_TSet s1 s2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for eq_TSet specification\<close>
		((inv_TSet s1)  \<and>  (inv_TSet s2))  \<and> 
		\<comment>\<open>User defined body of eq_TSet\<close>
		(s1 \<subseteq> s2)"
 

\<comment>\<open>in 'TestV2ITypesStructured' (./src/test/resources/TestV2ITypesStructured.vdmsl) at line 13:28\<close>
definition
	ord_TSet :: "TSet\<Rightarrow> TSet \<Rightarrow> \<bool>"
where
	"ord_TSet s1 s2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for ord_TSet specification\<close>
		((inv_TSet s1)  \<and>  (inv_TSet s2))  \<and> 
		\<comment>\<open>User defined body of ord_TSet\<close>
		((vdm_card s1) < (vdm_card s2))"
 

\<comment>\<open>in 'TestV2ITypesStructured' (./src/test/resources/TestV2ITypesStructured.vdmsl) at line 13:28\<close>
definition
	min_TSet :: "TSet\<Rightarrow> TSet \<Rightarrow> TSet"
where
	"min_TSet a b \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for min_TSet specification\<close>
		(if ((inv_TSet a)  \<and>  (inv_TSet b)) then
			
		\<comment>\<open>User defined body of min_TSet\<close>
		(
		if (((a < b) \<or> (a = b))) then
		(a)
		else
		(b))
			else
			undefined)"

	

\<comment>\<open>in 'TestV2ITypesStructured' (./src/test/resources/TestV2ITypesStructured.vdmsl) at line 13:28\<close>
definition
	max_TSet :: "TSet\<Rightarrow> TSet \<Rightarrow> TSet"
where
	"max_TSet a b \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for max_TSet specification\<close>
		(if ((inv_TSet a)  \<and>  (inv_TSet b)) then
			
		\<comment>\<open>User defined body of max_TSet\<close>
		(
		if (((a < b) \<or> (a = b))) then
		(b)
		else
		(a))
			else
			undefined)"

	

	
\<comment>\<open>in 'TestV2ITypesStructured' (./src/test/resources/TestV2ITypesStructured.vdmsl) at line 16:5\<close>
type_synonym TSet2 = "TSet"
	

\<comment>\<open>in 'TestV2ITypesStructured' (./src/test/resources/TestV2ITypesStructured.vdmsl) at line 17:9\<close>
definition
	inv_TSet2 :: "TSet2 \<Rightarrow> \<bool>"
where
	"inv_TSet2 s \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_TSet2 specification\<close>
		((inv_TSet s))  \<and> 
		\<comment>\<open>User defined body of inv_TSet2\<close>
		((vdm_card s) > (10::VDMNat1))"

		 

	
\<comment>\<open>in 'TestV2ITypesStructured' (./src/test/resources/TestV2ITypesStructured.vdmsl) at line 19:5\<close>
type_synonym TSet3 = "TSet VDMSet"
	

\<comment>\<open>in 'TestV2ITypesStructured' (./src/test/resources/TestV2ITypesStructured.vdmsl) at line 19:5\<close>
definition
	inv_TSet3 :: "TSet3 \<Rightarrow> \<bool>"
where
	"inv_TSet3 dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_TSet3 specification\<close>
		(((inv_VDMSet' (inv_TSet) dummy0)))"

		 

	
\<comment>\<open>in 'TestV2ITypesStructured' (./src/test/resources/TestV2ITypesStructured.vdmsl) at line 21:5\<close>
type_synonym TSet4 = "TSet3 VDMSet"
	

\<comment>\<open>in 'TestV2ITypesStructured' (./src/test/resources/TestV2ITypesStructured.vdmsl) at line 22:9\<close>
definition
	inv_TSet4 :: "TSet4 \<Rightarrow> \<bool>"
where
	"inv_TSet4 s \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_TSet4 specification\<close>
		(((inv_VDMSet' (inv_TSet3) s)))  \<and> 
		\<comment>\<open>User defined body of inv_TSet4\<close>
		((vdm_card s) > (20::VDMNat1))"

		 

	
\<comment>\<open>in 'TestV2ITypesStructured' (./src/test/resources/TestV2ITypesStructured.vdmsl) at line 24:5\<close>
type_synonym TSeq = "VDMNat1 VDMSeq1"
	

\<comment>\<open>in 'TestV2ITypesStructured' (./src/test/resources/TestV2ITypesStructured.vdmsl) at line 25:9\<close>
definition
	inv_TSeq :: "TSeq \<Rightarrow> \<bool>"
where
	"inv_TSeq s \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_TSeq specification\<close>
		(((inv_VDMSeq1' (inv_VDMNat1) s)))  \<and> 
		\<comment>\<open>User defined body of inv_TSeq\<close>
		((vdm_card (elems s)) = (len s))"

		 

\<comment>\<open>in 'TestV2ITypesStructured' (./src/test/resources/TestV2ITypesStructured.vdmsl) at line 26:29\<close>
definition
	eq_TSeq :: "TSeq\<Rightarrow> TSeq \<Rightarrow> \<bool>"
where
	"eq_TSeq s1 s2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for eq_TSeq specification\<close>
		((inv_TSeq s1)  \<and>  (inv_TSeq s2))  \<and> 
		\<comment>\<open>User defined body of eq_TSeq\<close>
		((elems s1) = (elems s2))"

		 

\<comment>\<open>in 'TestV2ITypesStructured' (./src/test/resources/TestV2ITypesStructured.vdmsl) at line 27:27\<close>
definition
	ord_TSeq :: "TSeq\<Rightarrow> TSeq \<Rightarrow> \<bool>"
where
	"ord_TSeq s1 s2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for ord_TSeq specification\<close>
		((inv_TSeq s1)  \<and>  (inv_TSeq s2))  \<and> 
		\<comment>\<open>User defined body of ord_TSeq\<close>
		((len s1) < (len s2))"

		 

\<comment>\<open>in 'TestV2ITypesStructured' (./src/test/resources/TestV2ITypesStructured.vdmsl) at line 27:27\<close>
definition
	min_TSeq :: "TSeq\<Rightarrow> TSeq \<Rightarrow> TSeq"
where
	"min_TSeq a b \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for min_TSeq specification\<close>
		(if ((inv_TSeq a)  \<and>  (inv_TSeq b)) then
			
		\<comment>\<open>User defined body of min_TSeq\<close>
		(
		if (((a < b) \<or> (a = b))) then
		(a)
		else
		(b))
			else
			undefined)"

	

\<comment>\<open>in 'TestV2ITypesStructured' (./src/test/resources/TestV2ITypesStructured.vdmsl) at line 27:27\<close>
definition
	max_TSeq :: "TSeq\<Rightarrow> TSeq \<Rightarrow> TSeq"
where
	"max_TSeq a b \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for max_TSeq specification\<close>
		(if ((inv_TSeq a)  \<and>  (inv_TSeq b)) then
			
		\<comment>\<open>User defined body of max_TSeq\<close>
		(
		if (((a < b) \<or> (a = b))) then
		(b)
		else
		(a))
			else
			undefined)"

	

	
\<comment>\<open>in 'TestV2ITypesStructured' (./src/test/resources/TestV2ITypesStructured.vdmsl) at line 30:5\<close>
type_synonym TSeq2 = "TSet VDMSeq1"
	

\<comment>\<open>in 'TestV2ITypesStructured' (./src/test/resources/TestV2ITypesStructured.vdmsl) at line 31:9\<close>
definition
	inv_TSeq2 :: "TSeq2 \<Rightarrow> \<bool>"
where
	"inv_TSeq2 s \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_TSeq2 specification\<close>
		(((inv_VDMSeq1' (inv_TSet) s)))  \<and> 
		\<comment>\<open>User defined body of inv_TSeq2\<close>
		((vdm_card (elems s)) = (len s))"

		 

\<comment>\<open>in 'TestV2ITypesStructured' (./src/test/resources/TestV2ITypesStructured.vdmsl) at line 32:29\<close>
definition
	eq_TSeq2 :: "TSeq2\<Rightarrow> TSeq2 \<Rightarrow> \<bool>"
where
	"eq_TSeq2 s1 s2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for eq_TSeq2 specification\<close>
		((inv_TSeq2 s1)  \<and>  (inv_TSeq2 s2))  \<and> 
		\<comment>\<open>User defined body of eq_TSeq2\<close>
		((elems s1) = (elems s2))"

		 

\<comment>\<open>in 'TestV2ITypesStructured' (./src/test/resources/TestV2ITypesStructured.vdmsl) at line 33:27\<close>
definition
	ord_TSeq2 :: "TSeq2\<Rightarrow> TSeq2 \<Rightarrow> \<bool>"
where
	"ord_TSeq2 s1 s2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for ord_TSeq2 specification\<close>
		((inv_TSeq2 s1)  \<and>  (inv_TSeq2 s2))  \<and> 
		\<comment>\<open>User defined body of ord_TSeq2\<close>
		((len s1) < (len s2))"

		 

\<comment>\<open>in 'TestV2ITypesStructured' (./src/test/resources/TestV2ITypesStructured.vdmsl) at line 33:27\<close>
definition
	min_TSeq2 :: "TSeq2\<Rightarrow> TSeq2 \<Rightarrow> TSeq2"
where
	"min_TSeq2 a b \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for min_TSeq2 specification\<close>
		(if ((inv_TSeq2 a)  \<and>  (inv_TSeq2 b)) then
			
		\<comment>\<open>User defined body of min_TSeq2\<close>
		(
		if (((a < b) \<or> (a = b))) then
		(a)
		else
		(b))
			else
			undefined)"

	

\<comment>\<open>in 'TestV2ITypesStructured' (./src/test/resources/TestV2ITypesStructured.vdmsl) at line 33:27\<close>
definition
	max_TSeq2 :: "TSeq2\<Rightarrow> TSeq2 \<Rightarrow> TSeq2"
where
	"max_TSeq2 a b \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for max_TSeq2 specification\<close>
		(if ((inv_TSeq2 a)  \<and>  (inv_TSeq2 b)) then
			
		\<comment>\<open>User defined body of max_TSeq2\<close>
		(
		if (((a < b) \<or> (a = b))) then
		(b)
		else
		(a))
			else
			undefined)"

	

	
\<comment>\<open>in 'TestV2ITypesStructured' (./src/test/resources/TestV2ITypesStructured.vdmsl) at line 36:5\<close>
type_synonym TMap = "(VDMNat1 \<rightharpoonup> VDMNat1)"
	

\<comment>\<open>in 'TestV2ITypesStructured' (./src/test/resources/TestV2ITypesStructured.vdmsl) at line 37:9\<close>
definition
	inv_TMap :: "TMap \<Rightarrow> \<bool>"
where
	"inv_TMap m \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_TMap specification\<close>
		(((inv_Map (inv_VDMNat1) (inv_VDMNat1) m)))  \<and> 
		\<comment>\<open>User defined body of inv_TMap\<close>
		((dom m) \<noteq> {})"

		 

\<comment>\<open>in 'TestV2ITypesStructured' (./src/test/resources/TestV2ITypesStructured.vdmsl) at line 38:35\<close>
definition
	eq_TMap :: "TMap\<Rightarrow> TMap \<Rightarrow> \<bool>"
where
	"eq_TMap m1 m2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for eq_TMap specification\<close>
		((inv_TMap m1)  \<and>  (inv_TMap m2))  \<and> 
		\<comment>\<open>User defined body of eq_TMap\<close>
		(((dom m1) = (dom m2)) \<and> (\<forall> x \<in> (dom m1)  . ((the(m1 x)) = (the(m2 x)))))"

		 

\<comment>\<open>in 'TestV2ITypesStructured' (./src/test/resources/TestV2ITypesStructured.vdmsl) at line 41:9\<close>
definition
	ord_TMap :: "TMap\<Rightarrow> TMap \<Rightarrow> \<bool>"
where
	"ord_TMap m1 m2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for ord_TMap specification\<close>
		((inv_TMap m1)  \<and>  (inv_TMap m2))  \<and> 
		\<comment>\<open>User defined body of ord_TMap\<close>
		(((dom m1) \<subseteq> (dom m2)) \<or> (((dom m1) = (dom m2)) \<and> (\<forall> x \<in> (dom m1)  . ((the(m1 x)) < (the(m2 x))))))"

		 

\<comment>\<open>in 'TestV2ITypesStructured' (./src/test/resources/TestV2ITypesStructured.vdmsl) at line 41:9\<close>
definition
	min_TMap :: "TMap\<Rightarrow> TMap \<Rightarrow> TMap"
where
	"min_TMap a b \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for min_TMap specification\<close>
		(if ((inv_TMap a)  \<and>  (inv_TMap b)) then
			
		\<comment>\<open>User defined body of min_TMap\<close>
		(
		if (((a < b) \<or> (a = b))) then
		(a)
		else
		(b))
			else
			undefined)"

	

\<comment>\<open>in 'TestV2ITypesStructured' (./src/test/resources/TestV2ITypesStructured.vdmsl) at line 41:9\<close>
definition
	max_TMap :: "TMap\<Rightarrow> TMap \<Rightarrow> TMap"
where
	"max_TMap a b \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for max_TMap specification\<close>
		(if ((inv_TMap a)  \<and>  (inv_TMap b)) then
			
		\<comment>\<open>User defined body of max_TMap\<close>
		(
		if (((a < b) \<or> (a = b))) then
		(b)
		else
		(a))
			else
			undefined)"

	

	
\<comment>\<open>in 'TestV2ITypesStructured' (./src/test/resources/TestV2ITypesStructured.vdmsl) at line 45:5\<close>
type_synonym TMap2 = "(TSet4 \<rightharpoonup> TSeq2)"
	

\<comment>\<open>in 'TestV2ITypesStructured' (./src/test/resources/TestV2ITypesStructured.vdmsl) at line 45:5\<close>
definition
	inv_TMap2 :: "TMap2 \<Rightarrow> \<bool>"
where
	"inv_TMap2 dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_TMap2 specification\<close>
		(((inv_Map (inv_TSet4) (inv_TSeq2) dummy0)))"

		 

	
\<comment>\<open>in 'TestV2ITypesStructured' (./src/test/resources/TestV2ITypesStructured.vdmsl) at line 47:5\<close>
type_synonym TMap3 = "(TMap2 \<rightharpoonup> TMap)"
	

\<comment>\<open>in 'TestV2ITypesStructured' (./src/test/resources/TestV2ITypesStructured.vdmsl) at line 47:5\<close>
definition
	inv_TMap3 :: "TMap3 \<Rightarrow> \<bool>"
where
	"inv_TMap3 dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_TMap3 specification\<close>
		(((inv_Map (inv_TMap2) (inv_TMap) dummy0)))"

		 

end