(* VDM to Isabelle Translation @2022-05-25T09:32:42.673414Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2IState.vdmsl' at line 1:8
files = [./src/test/resources/TestV2IState.vdmsl]
*)
theory TestV2IState
imports "VDMToolkit" 
begin


\<comment>\<open>VDM source: state S of
x:nat
y:real
	inv mk_S(x, y) == ((x > 15) and (y < 5))
	init s == (s = mk_S(25, 0))
end\<close>
\<comment>\<open>in 'TestV2IState' (./src/test/resources/TestV2IState.vdmsl) at line 5:7\<close>
record S = 
		x\<^sub>S :: "VDMNat"
		 
		 y\<^sub>S :: "VDMReal"
		

\<comment>\<open>VDM source: inv_S: (S +> bool)
	inv_S(mk_S(x, y)) ==
((x > 15) and (y < 5))\<close>
\<comment>\<open>in 'TestV2IState' (./src/test/resources/TestV2IState.vdmsl) at line 8:25\<close>
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
\<comment>\<open>in 'TestV2IState' (./src/test/resources/TestV2IState.vdmsl) at line 9:13\<close>
definition
	init_S :: "S"
where
	"init_S  \<equiv> 
		\<comment>\<open>User defined body of init_S.\<close>
		\<lparr>x\<^sub>S = (25::VDMNat1), y\<^sub>S = (0::VDMNat)\<rparr>"



end