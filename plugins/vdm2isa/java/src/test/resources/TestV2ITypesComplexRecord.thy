(* VDM to Isabelle Translation @2021-12-01T15:26:51.252103Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2ITypesComplexRecord.vdmsl' at line 1:8
files = [./src/test/resources/TestV2ITypesComplexRecord.vdmsl]
*)
theory TestV2ITypesComplexRecord
imports VDMToolkit
begin


\<comment>\<open>in 'TestV2ITypesComplexRecord' (./src/test/resources/TestV2ITypesComplexRecord.vdmsl) at line 7:5\<close>
record A = 
	a\<^sub>A :: "VDMInt"
	

\<comment>\<open>in 'TestV2ITypesComplexRecord' (./src/test/resources/TestV2ITypesComplexRecord.vdmsl) at line 8:9\<close>
definition
	inv_A :: "A \<Rightarrow> bool"
where
	"inv_A dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_A specification\<close>
		( (((inv_VDMInt (a\<^sub>A dummy0))) ))  \<and> 
		\<comment>\<open>Implicit record pattern projection conversion\<close>
		(let v = (a\<^sub>A dummy0) in 
		\<comment>\<open>User defined body of inv_A\<close>
		(v > (0::VDMNat)))"

		

	
\<comment>\<open>in 'TestV2ITypesComplexRecord' (./src/test/resources/TestV2ITypesComplexRecord.vdmsl) at line 11:5\<close>
record B = 
	b\<^sub>B :: "A"
	

\<comment>\<open>in 'TestV2ITypesComplexRecord' (./src/test/resources/TestV2ITypesComplexRecord.vdmsl) at line 11:5\<close>
definition
	inv_B :: "B \<Rightarrow> bool"
where
	"inv_B dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_B specification\<close>
		( ((inv_A (b\<^sub>B dummy0)) ))"

		

	
\<comment>\<open>in 'TestV2ITypesComplexRecord' (./src/test/resources/TestV2ITypesComplexRecord.vdmsl) at line 12:5\<close>
record C = 
	c\<^sub>C :: "B"
	

\<comment>\<open>in 'TestV2ITypesComplexRecord' (./src/test/resources/TestV2ITypesComplexRecord.vdmsl) at line 13:9\<close>
definition
	inv_C :: "C \<Rightarrow> bool"
where
	"inv_C x \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_C specification\<close>
		( ((inv_B (c\<^sub>C x)) ))  \<and> 
		\<comment>\<open>User defined body of inv_C\<close>
		((a\<^sub>A ((b\<^sub>B ((c\<^sub>C (x)))))) > (10::VDMNat1))"

		

	
\<comment>\<open>in 'TestV2ITypesComplexRecord' (./src/test/resources/TestV2ITypesComplexRecord.vdmsl) at line 16:5\<close>
record D = 
	d\<^sub>D :: "C"
	

\<comment>\<open>in 'TestV2ITypesComplexRecord' (./src/test/resources/TestV2ITypesComplexRecord.vdmsl) at line 17:9\<close>
definition
	inv_D :: "D \<Rightarrow> bool"
where
	"inv_D dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_D specification\<close>
		( ((inv_C (d\<^sub>D dummy0)) ))  \<and> 
		\<comment>\<open>Implicit record pattern projection conversion\<close>
		(let dummy00 = (d\<^sub>D dummy0); dummy000 = (c\<^sub>C dummy00); dummy0000 = (b\<^sub>B dummy000); a = (a\<^sub>A dummy0000) in 
		\<comment>\<open>User defined body of inv_D\<close>
		(a > (10::VDMNat1)))"

		

	
\<comment>\<open>in 'TestV2ITypesComplexRecord' (./src/test/resources/TestV2ITypesComplexRecord.vdmsl) at line 20:5\<close>
record E = 
	d\<^sub>E :: "C"
		 e\<^sub>E :: "D"
	

\<comment>\<open>in 'TestV2ITypesComplexRecord' (./src/test/resources/TestV2ITypesComplexRecord.vdmsl) at line 22:9\<close>
definition
	inv_E :: "E \<Rightarrow> bool"
where
	"inv_E dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_E specification\<close>
		( ((inv_C (d\<^sub>E dummy0)) \<and> 
		 (inv_D (e\<^sub>E dummy0)) ))  \<and> 
		\<comment>\<open>Implicit record pattern projection conversion\<close>
		(let dummy00 = (d\<^sub>E dummy0); x = (c\<^sub>C dummy00); e = (e\<^sub>E dummy0) in 
		\<comment>\<open>User defined body of inv_E\<close>
		((c\<^sub>C ((d\<^sub>D (e)))) = x))"

		

	
\<comment>\<open>in 'TestV2ITypesComplexRecord' (./src/test/resources/TestV2ITypesComplexRecord.vdmsl) at line 27:5\<close>
record G = 
	g\<^sub>G :: "(VDMInt\<times> VDMInt)"
	

\<comment>\<open>in 'TestV2ITypesComplexRecord' (./src/test/resources/TestV2ITypesComplexRecord.vdmsl) at line 28:9\<close>
definition
	inv_G :: "G \<Rightarrow> bool"
where
	"inv_G dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_G specification\<close>
		( ((
		((inv_VDMInt (fst (g\<^sub>G dummy0)))\<and>
		 (inv_VDMInt (snd (g\<^sub>G dummy0)))
		)) ))  \<and> 
		\<comment>\<open>Implicit record pattern projection conversion\<close>
		(let dummy00 = (g\<^sub>G dummy0); l = (fst dummy00); r = (snd dummy00) in 
		\<comment>\<open>User defined body of inv_G\<close>
		(l < r))"

		

	
\<comment>\<open>in 'TestV2ITypesComplexRecord' (./src/test/resources/TestV2ITypesComplexRecord.vdmsl) at line 30:5\<close>
record R = 
	r\<^sub>R :: "VDMReal"
		 i\<^sub>R :: "VDMNat"
	

\<comment>\<open>in 'TestV2ITypesComplexRecord' (./src/test/resources/TestV2ITypesComplexRecord.vdmsl) at line 34:9\<close>
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
		(r > (0::VDMNat)))"

		

	
\<comment>\<open>in 'TestV2ITypesComplexRecord' (./src/test/resources/TestV2ITypesComplexRecord.vdmsl) at line 36:5\<close>
record T = 
	k\<^sub>T :: "VDMInt"
	

\<comment>\<open>in 'TestV2ITypesComplexRecord' (./src/test/resources/TestV2ITypesComplexRecord.vdmsl) at line 36:5\<close>
definition
	inv_T :: "T \<Rightarrow> bool"
where
	"inv_T dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_T specification\<close>
		( (((inv_VDMInt (k\<^sub>T dummy0))) ))"

		

	
\<comment>\<open>in 'TestV2ITypesComplexRecord' (./src/test/resources/TestV2ITypesComplexRecord.vdmsl) at line 39:5\<close>
record S0 = 
	x\<^sub>S\<^sub>0 :: "R"
		 y\<^sub>S\<^sub>0 :: "T"
	

\<comment>\<open>in 'TestV2ITypesComplexRecord' (./src/test/resources/TestV2ITypesComplexRecord.vdmsl) at line 42:9\<close>
definition
	inv_S0 :: "S0 \<Rightarrow> bool"
where
	"inv_S0 s \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_S0 specification\<close>
		( ((inv_R (x\<^sub>S\<^sub>0 s)) \<and> 
		 (inv_T (y\<^sub>S\<^sub>0 s)) ))  \<and> 
		\<comment>\<open>User defined body of inv_S0\<close>
		((r\<^sub>R ((x\<^sub>S\<^sub>0 (s)))) > (k\<^sub>T ((y\<^sub>S\<^sub>0 (s)))))"

		

	
\<comment>\<open>in 'TestV2ITypesComplexRecord' (./src/test/resources/TestV2ITypesComplexRecord.vdmsl) at line 45:5\<close>
record S1 = 
	r\<^sub>S\<^sub>1 :: "R"
		 t\<^sub>S\<^sub>1 :: "R"
	

\<comment>\<open>in 'TestV2ITypesComplexRecord' (./src/test/resources/TestV2ITypesComplexRecord.vdmsl) at line 48:9\<close>
definition
	inv_S1 :: "S1 \<Rightarrow> bool"
where
	"inv_S1 s \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_S1 specification\<close>
		( ((inv_R (r\<^sub>S\<^sub>1 s)) \<and> 
		 (inv_R (t\<^sub>S\<^sub>1 s)) ))  \<and> 
		\<comment>\<open>User defined body of inv_S1\<close>
		((r\<^sub>R ((r\<^sub>S\<^sub>1 (s)))) > (r\<^sub>R ((t\<^sub>S\<^sub>1 (s)))))"

		

	
\<comment>\<open>in 'TestV2ITypesComplexRecord' (./src/test/resources/TestV2ITypesComplexRecord.vdmsl) at line 51:5\<close>
record S2 = 
	r\<^sub>S\<^sub>2 :: "R"
		 t\<^sub>S\<^sub>2 :: "R"
	

\<comment>\<open>in 'TestV2ITypesComplexRecord' (./src/test/resources/TestV2ITypesComplexRecord.vdmsl) at line 54:9\<close>
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

		

	
\<comment>\<open>in 'TestV2ITypesComplexRecord' (./src/test/resources/TestV2ITypesComplexRecord.vdmsl) at line 57:5\<close>
record S3 = 
	r\<^sub>S\<^sub>3 :: "R"
		 t\<^sub>S\<^sub>3 :: "R"
	

\<comment>\<open>in 'TestV2ITypesComplexRecord' (./src/test/resources/TestV2ITypesComplexRecord.vdmsl) at line 60:9\<close>
definition
	inv_S3 :: "S3 \<Rightarrow> bool"
where
	"inv_S3 dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_S3 specification\<close>
		( ((inv_R (r\<^sub>S\<^sub>3 dummy0)) \<and> 
		 (inv_R (t\<^sub>S\<^sub>3 dummy0)) ))  \<and> 
		\<comment>\<open>Implicit record pattern projection conversion\<close>
		(let dummy00 = (r\<^sub>S\<^sub>3 dummy0); rs = (r\<^sub>R dummy00); i = (i\<^sub>R dummy00); dummy01 = (t\<^sub>S\<^sub>3 dummy0); ts = (r\<^sub>R dummy01); j = (i\<^sub>R dummy01) in 
		\<comment>\<open>User defined body of inv_S3\<close>
		((rs > ts) \<and> (i > j)))"

		

	
\<comment>\<open>in 'TestV2ITypesComplexRecord' (./src/test/resources/TestV2ITypesComplexRecord.vdmsl) at line 63:5\<close>
record S4 = 
	r\<^sub>S\<^sub>4 :: "R"
		 t\<^sub>S\<^sub>4 :: "R"
	

\<comment>\<open>in 'TestV2ITypesComplexRecord' (./src/test/resources/TestV2ITypesComplexRecord.vdmsl) at line 66:9\<close>
definition
	inv_S4 :: "S4 \<Rightarrow> bool"
where
	"inv_S4 dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_S4 specification\<close>
		( ((inv_R (r\<^sub>S\<^sub>4 dummy0)) \<and> 
		 (inv_R (t\<^sub>S\<^sub>4 dummy0)) ))  \<and> 
		\<comment>\<open>Implicit record pattern projection conversion\<close>
		(let dummy00 = (r\<^sub>S\<^sub>4 dummy0); rs = (r\<^sub>R dummy00); _ = (i\<^sub>R dummy00); dummy01 = (t\<^sub>S\<^sub>4 dummy0); ts = (r\<^sub>R dummy01); _ = (i\<^sub>R dummy01) in 
		\<comment>\<open>User defined body of inv_S4\<close>
		(rs > ts))"

		

end