(* VDM to Isabelle Translation @2021-12-02T15:20:28.989565Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2IExprsMaps.vdmsl' at line 1:8
files = [./src/test/resources/TestV2IExprsMaps.vdmsl]
*)
theory TestV2IExprsMaps
imports VDMToolkit
begin


(* v95= { x |-> 10 | x in set {1,2,3} } *)
abbreviation
	v95 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"v95 \<equiv> (\<comment>\<open>VDM Map comprehension is translated as a lambda-term through mapCompSetBound\<close>
		mapCompSetBound 
		{ x .   ((x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}))  } 
		{ (10::VDMNat1) | x .  ((x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}))  } 
		(inv_VDMNat1) 
		(inv_VDMNat1) 
		(
	\<lambda> (x :: VDMNat1)  (dummy0EitherDom :: VDMNat1) .
		(if (((inv_VDMNat1 x))) \<and>  (((inv_VDMNat1 dummy0EitherDom))) \<and> (inv_VDMNat1 x) then
		x
	 else
		undefined
	)
	) 
		(
	\<lambda> (x :: VDMNat1)  (dummy0EitherDom :: VDMNat1) .
		(if (((inv_VDMNat1 x))) \<and>  (((inv_VDMNat1 dummy0EitherDom))) \<and> (inv_VDMNat1 (10::VDMNat1)) then
		(10::VDMNat1)
	 else
		undefined
	)
	) 
		(
	\<lambda> (x :: VDMNat1)  (dummy0EitherDom :: VDMNat1) .
		(if (((inv_VDMNat1 x))) \<and>  (((inv_VDMNat1 dummy0EitherDom))) \<and> (inv_bool (True::\<bool>)) then
		(True::\<bool>)
	 else
		undefined
	)
	))"

	definition
	inv_v95 :: "\<bool>"
where
	"inv_v95  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v95)"

	
	
abbreviation
	v952 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"v952 \<equiv> (\<comment>\<open>VDM Map comprehension is translated as a lambda-term through mapCompSetBound\<close>
		mapCompSetBound 
		{ (x + y) | x  y .  ((x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)})) \<and>  ((y \<in>{(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}))  } 
		{ (10::VDMNat1) | x  y .  ((x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)})) \<and>  ((y \<in>{(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}))  } 
		(inv_VDMNat1) 
		(inv_VDMNat1) 
		(
	\<lambda> (x :: VDMNat1)  (y :: VDMNat1) .
		(if (((inv_VDMNat1 x))) \<and>  (((inv_VDMNat1 y))) \<and> (inv_VDMNat1 (x + y)) then
		(x + y)
	 else
		undefined
	)
	) 
		(
	\<lambda> (x :: VDMNat1)  (y :: VDMNat1) .
		(if (((inv_VDMNat1 x))) \<and>  (((inv_VDMNat1 y))) \<and> (inv_VDMNat1 (10::VDMNat1)) then
		(10::VDMNat1)
	 else
		undefined
	)
	) 
		(
	\<lambda> (x :: VDMNat1)  (y :: VDMNat1) .
		(if (((inv_VDMNat1 x))) \<and>  (((inv_VDMNat1 y))) \<and> (inv_bool (True::\<bool>)) then
		(True::\<bool>)
	 else
		undefined
	)
	))"

	definition
	inv_v952 :: "\<bool>"
where
	"inv_v952  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v952)"

	
end