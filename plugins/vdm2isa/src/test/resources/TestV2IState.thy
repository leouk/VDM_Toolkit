(* VDM to Isabelle Translation @2022-03-08T13:31:44.152579Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2IState.vdmsl' at line 1:8
files = [./src/test/resources/TestV2IState.vdmsl]
*)
theory TestV2IState
imports "VDMToolkit" 
begin

STATE! = 
\<comment>\<open>VDM source: state S of
x:nat
	inv mk_S(x) == (x > 10)
	init s == (s = mk_S(20))
end\<close>
\<comment>\<open>in 'TestV2IState' (./src/test/resources/TestV2IState.vdmsl) at line 5:7\<close>



end