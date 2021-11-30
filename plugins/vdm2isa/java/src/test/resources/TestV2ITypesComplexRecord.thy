(* VDM to Isabelle Translation @2021-11-30T13:58:49.652546Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2ITypesComplexRecord.vdmsl' at line 1:8
files = [./src/test/resources/TestV2ITypesComplexRecord.vdmsl]
*)
theory TestV2ITypesComplexRecord
imports VDMToolkit
begin


\<comment>\<open>in 'TestV2ITypesComplexRecord' (./src/test/resources/TestV2ITypesComplexRecord.vdmsl) at line 6:5\<close>
record A = 
	a\<^sub>A :: "VDMInt"
	

\<comment>\<open>in 'TestV2ITypesComplexRecord' (./src/test/resources/TestV2ITypesComplexRecord.vdmsl) at line 6:5\<close>
definition
	inv_A :: "A \<Rightarrow> bool"
where
	"inv_A dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_A specification\<close>
		( (((inv_VDMInt (a\<^sub>A dummy0))) ))"

		

	
\<comment>\<open>in 'TestV2ITypesComplexRecord' (./src/test/resources/TestV2ITypesComplexRecord.vdmsl) at line 7:5\<close>
record B = 
	b\<^sub>B :: "A"
	

\<comment>\<open>in 'TestV2ITypesComplexRecord' (./src/test/resources/TestV2ITypesComplexRecord.vdmsl) at line 7:5\<close>
definition
	inv_B :: "B \<Rightarrow> bool"
where
	"inv_B dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_B specification\<close>
		( ((inv_A (b\<^sub>B dummy0)) ))"

		

	
\<comment>\<open>in 'TestV2ITypesComplexRecord' (./src/test/resources/TestV2ITypesComplexRecord.vdmsl) at line 8:5\<close>
record C = 
	c\<^sub>C :: "B"
	

\<comment>\<open>in 'TestV2ITypesComplexRecord' (./src/test/resources/TestV2ITypesComplexRecord.vdmsl) at line 9:9\<close>
definition
	inv_C :: "C \<Rightarrow> bool"
where
	"inv_C x \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_C specification\<close>
		( ((inv_B (c\<^sub>C x)) ))  \<and> 
		\<comment>\<open>User defined body of inv_C  	inv x == x.c.b.v > 10;\<close>
		((a\<^sub>A ((b\<^sub>B ((c\<^sub>C (x)))))) > 10)"

		

end