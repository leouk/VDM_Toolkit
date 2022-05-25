(* VDM to Isabelle Translation @2022-05-25T11:47:01.194969Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2IOperation.vdmsl' at line 1:8
files = [./src/test/resources/TestV2IOperation.vdmsl]
*)
theory TestV2IOperation
imports "VDMToolkit" 
begin


\<comment>\<open>VDM source: state S of
x:nat
y:real
	inv mk_S(x, y) == ((x > 15) and (y < 5))
	init s == (s = mk_S(25, 0))
end\<close>
\<comment>\<open>in 'TestV2IOperation' (./src/test/resources/TestV2IOperation.vdmsl) at line 5:7\<close>
record S =  x\<^sub>S :: "VDMNat"
		 
		 y\<^sub>S :: "VDMReal" 

\<comment>\<open>VDM source: inv_S: (S +> bool)
	inv_S(mk_S(x, y)) ==
((x > 15) and (y < 5))\<close>
\<comment>\<open>in 'TestV2IOperation' (./src/test/resources/TestV2IOperation.vdmsl) at line 8:25\<close>
definition
	inv_S :: "S \<Rightarrow> bool"
where
	"inv_S dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_S` specification.\<close>
		( (((inv_VDMNat (x\<^sub>S dummy0))) \<and> 
		 ((inv_VDMReal (y\<^sub>S dummy0))) ))  \<and> 
		\<comment>\<open>Implicit pattern context projection for `function parameters`\<close>
		(\<comment>\<open>Implicit pattern context projection for `pattern list`\<close>
	
			let x = (x\<^sub>S dummy0); y = (y\<^sub>S dummy0) in 
		\<comment>\<open>User defined body of inv_S.\<close>
		((x > (15::VDMNat1)) \<and> (y < (5::VDMNat1))))"
 

\<comment>\<open>VDM source: init_S: (S -> bool)
	init_S ==
mk_S(25, 0)\<close>
\<comment>\<open>in 'TestV2IOperation' (./src/test/resources/TestV2IOperation.vdmsl) at line 9:13\<close>
definition
	init_S :: "S"
where
	"init_S  \<equiv> 
		\<comment>\<open>User defined body of init_S.\<close>
		\<lparr>x\<^sub>S = (25::VDMNat1), y\<^sub>S = (0::VDMNat)\<rparr>"

	
	
\<comment>\<open>VDM source: Explicit: (nat1 ==> ())
	Explicit(inc) ==
(

x := (x + inc)
)
	pre ((inc < 10) and (x > 0))
	post (x < x)\<close>
\<comment>\<open>in 'TestV2IOperation' (./src/test/resources/TestV2IOperation.vdmsl) at line 14:1\<close>

\<comment>\<open>VDM source: pre_Explicit: (nat1 * S +> bool)
	pre_Explicit(inc, S) ==
((inc < 10) and (x > 0))\<close>
\<comment>\<open>in 'TestV2IOperation' (./src/test/resources/TestV2IOperation.vdmsl) at line 17:15\<close>
definition
	pre_Explicit :: "VDMNat1 \<Rightarrow> S \<Rightarrow> bool"
where
	"pre_Explicit inc   S \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_Explicit` specification.\<close>
		((inv_VDMNat1 inc)  \<and>  inv_S S)  \<and> 
		\<comment>\<open>User defined body of pre_Explicit.\<close>
		((inc < (10::VDMNat1)) \<and> (x > (0::VDMNat)))"


\<comment>\<open>VDM source: post_Explicit: (nat1 * S * S +> bool)
	post_Explicit(inc, S~, S) ==
(x < x)\<close>
\<comment>\<open>in 'TestV2IOperation' (./src/test/resources/TestV2IOperation.vdmsl) at line 18:10\<close>
definition
	post_Explicit :: "VDMNat1 \<Rightarrow> S \<Rightarrow> S \<Rightarrow> bool"
where
	"post_Explicit inc   S~   S \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_Explicit` specification.\<close>
		((inv_VDMNat1 inc)  \<and>  inv_S S~  \<and>  inv_S S)  \<and> 
		\<comment>\<open>User defined body of post_Explicit.\<close>
		(x~ < x)"

definition
	Explicit :: "VDMNat1 \<Rightarrow> S \<Rightarrow> S"
where
	"Explicit inc   dummy0 \<equiv> 
	\<comment>\<open>Implicit pattern context projection for `function parameters`\<close>
	(\<comment>\<open>Implicit pattern context projection for `pattern list`\<close>
	
			let x = (x\<^sub>S dummy0); y = (y\<^sub>S dummy0) in 
	\<comment>\<open>User defined body of Explicit.\<close>
	let dummy0 = dummy0\<lparr>x\<^sub>S:=(x+inc)\<rparr> in
	\<comment>\<open>Implicit pattern context projection for `pattern list`\<close>
	 let x = (x\<^sub>S dummy0); y = (y\<^sub>S dummy0) in 
	
	dummy0)"

	
	
\<comment>\<open>VDM source: Explicit_no_condition: (real * real ==> ())
	Explicit_no_condition(M, A) ==
(

y := (y * M);
y := (y + A)
)\<close>
\<comment>\<open>in 'TestV2IOperation' (./src/test/resources/TestV2IOperation.vdmsl) at line 20:1\<close>

\<comment>\<open>VDM source: pre_Explicit_no_condition: (real * real * (unresolved TestV2IOperation`S) * (unresolved TestV2IOperation`S) +> bool)
	pre_Explicit_no_condition(M, A) ==
null\<close>
\<comment>\<open>in 'TestV2IOperation' (./src/test/resources/TestV2IOperation.vdmsl) at line 20:1\<close>
definition
	pre_Explicit_no_condition :: "VDMReal \<Rightarrow> VDMReal \<Rightarrow> S \<Rightarrow> bool"
where
	"pre_Explicit_no_condition M   A \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_Explicit_no_condition` specification.\<close>
		((inv_VDMReal M)  \<and>  (inv_VDMReal A))"


\<comment>\<open>VDM source: post_Explicit_no_condition: (real * real * (unresolved TestV2IOperation`S) * (unresolved TestV2IOperation`S) +> bool)
	post_Explicit_no_condition(M, A, RESULT) ==
null\<close>
\<comment>\<open>in 'TestV2IOperation' (./src/test/resources/TestV2IOperation.vdmsl) at line 20:1\<close>
definition
	post_Explicit_no_condition :: "VDMReal \<Rightarrow> VDMReal \<Rightarrow> () \<Rightarrow> bool"
where
	"post_Explicit_no_condition M   A   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_Explicit_no_condition` specification.\<close>
		((inv_VDMReal M)  \<and>  (inv_VDMReal A)  \<and>  ())"

definition
	Explicit_no_condition :: "VDMReal \<Rightarrow> VDMReal \<Rightarrow> S \<Rightarrow> S"
where
	"Explicit_no_condition M   A   dummy0 \<equiv> 
	\<comment>\<open>Implicit pattern context projection for `function parameters`\<close>
	(\<comment>\<open>Implicit pattern context projection for `pattern list`\<close>
	
			let x = (x\<^sub>S dummy0); y = (y\<^sub>S dummy0) in 
	\<comment>\<open>User defined body of Explicit_no_condition.\<close>
	let dummy0 = dummy0\<lparr>y\<^sub>S:=(y*M)\<rparr> in
	\<comment>\<open>Implicit pattern context projection for `pattern list`\<close>
	 let x = (x\<^sub>S dummy0); y = (y\<^sub>S dummy0) in 
	
	let dummy0 = dummy0\<lparr>y\<^sub>S:=(y+A)\<rparr> in
	\<comment>\<open>Implicit pattern context projection for `pattern list`\<close>
	 let x = (x\<^sub>S dummy0); y = (y\<^sub>S dummy0) in 
	
	dummy0)"

	
	
\<comment>\<open>VDM source: Implicit((M, A:real))
	pre ((M > 0) and (A > 0))
	post (((y - A) / M) = y)\<close>
\<comment>\<open>in 'TestV2IOperation' (./src/test/resources/TestV2IOperation.vdmsl) at line 25:1\<close>

\<comment>\<open>VDM source: pre_Implicit: (real * real * S +> bool)
	pre_Implicit(M, A, S) ==
((M > 0) and (A > 0))\<close>
\<comment>\<open>in 'TestV2IOperation' (./src/test/resources/TestV2IOperation.vdmsl) at line 27:11\<close>
definition
	pre_Implicit :: "VDMReal \<Rightarrow> VDMReal \<Rightarrow> S \<Rightarrow> bool"
where
	"pre_Implicit M   A   S \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_Implicit` specification.\<close>
		((inv_VDMReal M)  \<and>  (inv_VDMReal A)  \<and>  inv_S S)  \<and> 
		\<comment>\<open>User defined body of pre_Implicit.\<close>
		((M > (0::VDMNat)) \<and> (A > (0::VDMNat)))"


\<comment>\<open>VDM source: post_Implicit: (real * real * S * S +> bool)
	post_Implicit(M, A, S~, S) ==
(((y - A) / M) = y)\<close>
\<comment>\<open>in 'TestV2IOperation' (./src/test/resources/TestV2IOperation.vdmsl) at line 28:16\<close>
definition
	post_Implicit :: "VDMReal \<Rightarrow> VDMReal \<Rightarrow> S \<Rightarrow> S \<Rightarrow> bool"
where
	"post_Implicit M   A   S~   S \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_Implicit` specification.\<close>
		((inv_VDMReal M)  \<and>  (inv_VDMReal A)  \<and>  inv_S S~  \<and>  inv_S S)  \<and> 
		\<comment>\<open>User defined body of post_Implicit.\<close>
		(((y - A) / M) = y~)"

definition
	Implicit :: "VDMReal \<Rightarrow> VDMReal \<Rightarrow> S \<Rightarrow> S"
where
	"Implicit M   A   dummy0 \<equiv> 
	\<comment>\<open>Implicit pattern context projection for `function parameters`\<close>
	(\<comment>\<open>Implicit pattern context projection for `pattern list`\<close>
	
			let x = (x\<^sub>S dummy0); y = (y\<^sub>S dummy0) in 
	\<comment>\<open>User defined body of Implicit.\<close>
	let dummy0 = dummy0\<lparr>y\<^sub>S:=((y*M)+A)\<rparr> in
	\<comment>\<open>Implicit pattern context projection for `pattern list`\<close>
	 let x = (x\<^sub>S dummy0); y = (y\<^sub>S dummy0) in 
	
	dummy0)"

	
	
\<comment>\<open>VDM source: Implicit_no_body((M, A:real))
	pre ((M > 0) and (A > 0))
	post (((y - A) / M) = y)\<close>
\<comment>\<open>in 'TestV2IOperation' (./src/test/resources/TestV2IOperation.vdmsl) at line 30:1\<close>

\<comment>\<open>VDM source: pre_Implicit_no_body: (real * real * S +> bool)
	pre_Implicit_no_body(M, A, S) ==
((M > 0) and (A > 0))\<close>
\<comment>\<open>in 'TestV2IOperation' (./src/test/resources/TestV2IOperation.vdmsl) at line 31:11\<close>
definition
	pre_Implicit_no_body :: "VDMReal \<Rightarrow> VDMReal \<Rightarrow> S \<Rightarrow> bool"
where
	"pre_Implicit_no_body M   A   S \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_Implicit_no_body` specification.\<close>
		((inv_VDMReal M)  \<and>  (inv_VDMReal A)  \<and>  inv_S S)  \<and> 
		\<comment>\<open>User defined body of pre_Implicit_no_body.\<close>
		((M > (0::VDMNat)) \<and> (A > (0::VDMNat)))"


\<comment>\<open>VDM source: post_Implicit_no_body: (real * real * S * S +> bool)
	post_Implicit_no_body(M, A, S~, S) ==
(((y - A) / M) = y)\<close>
\<comment>\<open>in 'TestV2IOperation' (./src/test/resources/TestV2IOperation.vdmsl) at line 32:16\<close>
definition
	post_Implicit_no_body :: "VDMReal \<Rightarrow> VDMReal \<Rightarrow> S \<Rightarrow> S \<Rightarrow> bool"
where
	"post_Implicit_no_body M   A   S~   S \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_Implicit_no_body` specification.\<close>
		((inv_VDMReal M)  \<and>  (inv_VDMReal A)  \<and>  inv_S S~  \<and>  inv_S S)  \<and> 
		\<comment>\<open>User defined body of post_Implicit_no_body.\<close>
		(((y - A) / M) = y~)"


	
	
\<comment>\<open>VDM source: Implicit_return((M, A:real)) r:real
	pre ((M > 0) and (A > 0))
	post ((((y - A) / M) = y) and (r > A))\<close>
\<comment>\<open>in 'TestV2IOperation' (./src/test/resources/TestV2IOperation.vdmsl) at line 34:1\<close>

\<comment>\<open>VDM source: pre_Implicit_return: (real * real * S +> bool)
	pre_Implicit_return(M, A, S) ==
((M > 0) and (A > 0))\<close>
\<comment>\<open>in 'TestV2IOperation' (./src/test/resources/TestV2IOperation.vdmsl) at line 35:11\<close>
definition
	pre_Implicit_return :: "VDMReal \<Rightarrow> VDMReal \<Rightarrow> S \<Rightarrow> bool"
where
	"pre_Implicit_return M   A   S \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_Implicit_return` specification.\<close>
		((inv_VDMReal M)  \<and>  (inv_VDMReal A)  \<and>  inv_S S)  \<and> 
		\<comment>\<open>User defined body of pre_Implicit_return.\<close>
		((M > (0::VDMNat)) \<and> (A > (0::VDMNat)))"


\<comment>\<open>VDM source: post_Implicit_return: (real * real * real * S * S +> bool)
	post_Implicit_return(M, A, r, S~, S) ==
((((y - A) / M) = y) and (r > A))\<close>
\<comment>\<open>in 'TestV2IOperation' (./src/test/resources/TestV2IOperation.vdmsl) at line 36:21\<close>
definition
	post_Implicit_return :: "VDMReal \<Rightarrow> VDMReal \<Rightarrow> VDMReal \<Rightarrow> S \<Rightarrow> S \<Rightarrow> bool"
where
	"post_Implicit_return M   A   r   S~   S \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_Implicit_return` specification.\<close>
		((inv_VDMReal M)  \<and>  (inv_VDMReal A)  \<and>  (inv_VDMReal r)  \<and>  inv_S S~  \<and>  inv_S S)  \<and> 
		\<comment>\<open>User defined body of post_Implicit_return.\<close>
		((((y - A) / M) = y~) \<and> (r > A))"




end