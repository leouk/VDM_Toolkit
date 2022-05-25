(* VDM to Isabelle Translation @2022-05-12T12:09:42.377Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in 'plugins/vdm2isa/java/src/test/resources/TestV2IStateNoInit.vdmsl' at line 1:8
files = [plugins/vdm2isa/java/src/test/resources/TestV2IStateNoInit.vdmsl]
*)
theory TestV2IStateNoInit
imports "VDMToolkit" 
begin


\<comment>\<open>VDM source: state S of
x:nat
y:real
end\<close>
\<comment>\<open>in 'TestV2IStateNoInit' (plugins/vdm2isa/java/src/test/resources/TestV2IStateNoInit.vdmsl) at line 5:7\<close>
record S = 
		x\<^sub>S :: "VDMNat"
		 
		 y\<^sub>S :: "VDMReal"
		

\<comment>\<open>VDM source: inv_S: (S +> bool)
	inv_S(dummy0) ==
null\<close>
\<comment>\<open>in 'TestV2IStateNoInit' (plugins/vdm2isa/java/src/test/resources/TestV2IStateNoInit.vdmsl) at line 5:7\<close>
definition
	inv_S :: "S \<Rightarrow> bool"
where
	"inv_S dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_S` specification.\<close>
		( (((inv_VDMNat (x\<^sub>S dummy0))) \<and> 
		 ((inv_VDMReal (y\<^sub>S dummy0))) ))"

		



end