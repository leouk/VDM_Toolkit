(* VDM to Isabelle Translation @2021-11-30T14:24:35.126Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in '/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexRecord.vdmsl' at line 1:8
files = [/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexRecord.vdmsl]
*)
theory TestV2ITypesComplexRecord
imports VDMToolkit
begin


\<comment>\<open>in 'TestV2ITypesComplexRecord' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexRecord.vdmsl) at line 6:5\<close>
record A = 
	a\<^sub>A :: "VDMInt"
	

\<comment>\<open>in 'TestV2ITypesComplexRecord' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexRecord.vdmsl) at line 6:5\<close>
definition
	inv_A :: "A \<Rightarrow> bool"
where
	"inv_A dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_A specification\<close>
		( (((inv_VDMInt (a\<^sub>A dummy0))) ))"

		

	
\<comment>\<open>in 'TestV2ITypesComplexRecord' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexRecord.vdmsl) at line 7:5\<close>
record B = 
	b\<^sub>B :: "A"
	

\<comment>\<open>in 'TestV2ITypesComplexRecord' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexRecord.vdmsl) at line 7:5\<close>
definition
	inv_B :: "B \<Rightarrow> bool"
where
	"inv_B dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_B specification\<close>
		( ((inv_A (b\<^sub>B dummy0)) ))"

		

	
\<comment>\<open>in 'TestV2ITypesComplexRecord' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexRecord.vdmsl) at line 8:5\<close>
record C = 
	c\<^sub>C :: "B"
	

\<comment>\<open>in 'TestV2ITypesComplexRecord' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexRecord.vdmsl) at line 9:9\<close>
definition
	inv_C :: "C \<Rightarrow> bool"
where
	"inv_C x \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_C specification\<close>
		( ((inv_B (c\<^sub>C x)) ))  \<and> 
		\<comment>\<open>User defined body of inv_C\<close>
		((a\<^sub>A ((b\<^sub>B ((c\<^sub>C (x)))))) > 10)"

		

	
\<comment>\<open>in 'TestV2ITypesComplexRecord' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexRecord.vdmsl) at line 11:5\<close>
record R = 
	r\<^sub>R :: "VDMReal"
		 i\<^sub>R :: "VDMNat"
	

\<comment>\<open>in 'TestV2ITypesComplexRecord' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexRecord.vdmsl) at line 15:9\<close>
definition
	inv_R :: "R \<Rightarrow> bool"
where
	"inv_R dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_R specification\<close>
		( (((inv_VDMReal (r\<^sub>R dummy0))) \<and> 
		 ((inv_VDMNat (i\<^sub>R dummy0))) ))  \<and> 
		\<comment>\<open>Implicit record pattern projection conversion\<close>
		(let r = (r\<^sub>R dummy0); _ = (i\<^sub>R dummy0) in 
		\<comment>\<open>User defined body of inv_R\<close>
		(r > 0))"

		

	
\<comment>\<open>in 'TestV2ITypesComplexRecord' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexRecord.vdmsl) at line 17:5\<close>
record T = 
	k\<^sub>T :: "VDMInt"
	

\<comment>\<open>in 'TestV2ITypesComplexRecord' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexRecord.vdmsl) at line 17:5\<close>
definition
	inv_T :: "T \<Rightarrow> bool"
where
	"inv_T dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_T specification\<close>
		( (((inv_VDMInt (k\<^sub>T dummy0))) ))"

		

	
\<comment>\<open>in 'TestV2ITypesComplexRecord' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexRecord.vdmsl) at line 20:5\<close>
record S0 = 
	x\<^sub>S\<^sub>0 :: "R"
		 y\<^sub>S\<^sub>0 :: "T"
	

\<comment>\<open>in 'TestV2ITypesComplexRecord' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexRecord.vdmsl) at line 23:9\<close>
definition
	inv_S0 :: "S0 \<Rightarrow> bool"
where
	"inv_S0 s \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_S0 specification\<close>
		( ((inv_R (x\<^sub>S\<^sub>0 s)) \<and> 
		 (inv_T (y\<^sub>S\<^sub>0 s)) ))  \<and> 
		\<comment>\<open>User defined body of inv_S0\<close>
		((r\<^sub>R ((x\<^sub>S\<^sub>0 (s)))) > (k\<^sub>T ((y\<^sub>S\<^sub>0 (s)))))"

		

	
\<comment>\<open>in 'TestV2ITypesComplexRecord' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexRecord.vdmsl) at line 26:5\<close>
record S1 = 
	r\<^sub>S\<^sub>1 :: "R"
		 t\<^sub>S\<^sub>1 :: "R"
	

\<comment>\<open>in 'TestV2ITypesComplexRecord' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexRecord.vdmsl) at line 29:9\<close>
definition
	inv_S1 :: "S1 \<Rightarrow> bool"
where
	"inv_S1 s \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_S1 specification\<close>
		( ((inv_R (r\<^sub>S\<^sub>1 s)) \<and> 
		 (inv_R (t\<^sub>S\<^sub>1 s)) ))  \<and> 
		\<comment>\<open>User defined body of inv_S1\<close>
		((r\<^sub>R ((r\<^sub>S\<^sub>1 (s)))) > (r\<^sub>R ((t\<^sub>S\<^sub>1 (s)))))"

		

	
\<comment>\<open>in 'TestV2ITypesComplexRecord' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexRecord.vdmsl) at line 32:5\<close>
record S2 = 
	r\<^sub>S\<^sub>2 :: "R"
		 t\<^sub>S\<^sub>2 :: "R"
	

\<comment>\<open>in 'TestV2ITypesComplexRecord' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexRecord.vdmsl) at line 35:9\<close>
definition
	inv_S2 :: "S2 \<Rightarrow> bool"
where
	"inv_S2 dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_S2 specification\<close>
		( ((inv_R (r\<^sub>S\<^sub>2 dummy0)) \<and> 
		 (inv_R (t\<^sub>S\<^sub>2 dummy0)) ))  \<and> 
		\<comment>\<open>Implicit record pattern projection conversion\<close>
		(let r = (r\<^sub>S\<^sub>2 dummy0); t = (t\<^sub>S\<^sub>2 dummy0) in 
		\<comment>\<open>User defined body of inv_S2\<close>
		((r\<^sub>R (r)) > (r\<^sub>R (t))))"

		

	
\<comment>\<open>in 'TestV2ITypesComplexRecord' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexRecord.vdmsl) at line 38:5\<close>
record S3 = 
	r\<^sub>S\<^sub>3 :: "R"
		 t\<^sub>S\<^sub>3 :: "R"
	

\<comment>\<open>in 'TestV2ITypesComplexRecord' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesComplexRecord.vdmsl) at line 41:9\<close>
definition
	inv_S3 :: "S3 \<Rightarrow> bool"
where
	"inv_S3 dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_S3 specification\<close>
		( ((inv_R (r\<^sub>S\<^sub>3 dummy0)) \<and> 
		 (inv_R (t\<^sub>S\<^sub>3 dummy0)) ))  \<and> 
		\<comment>\<open>Implicit record pattern projection conversion\<close>
		(let dummy1 = (r\<^sub>S\<^sub>3 dummy0); dummy2 = (t\<^sub>S\<^sub>3 dummy0); rs = (r\<^sub>R dummy1); ts = (r\<^sub>R dummy2); i = (i\<^sub>R dummy1); j = (i\<^sub>R dummy2) in 
		\<comment>\<open>User defined body of inv_S3\<close>
		((rs > ts) \<and> (i > j)))"

		

end