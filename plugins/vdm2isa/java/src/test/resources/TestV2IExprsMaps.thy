(* VDM to Isabelle Translation @2021-12-02T14:39:23.641244Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2IExprsMaps.vdmsl' at line 1:8
files = [./src/test/resources/TestV2IExprsMaps.vdmsl]
*)
theory TestV2IExprsMaps
imports VDMToolkit
begin


\<comment>\<open>in 'TestV2IExprsMaps' (./src/test/resources/TestV2IExprsMaps.vdmsl) at line 7:5\<close>
record R = 
	x\<^sub>R :: "VDMNat"
		 y\<^sub>R :: "VDMNat"
	

\<comment>\<open>in 'TestV2IExprsMaps' (./src/test/resources/TestV2IExprsMaps.vdmsl) at line 10:9\<close>
definition
	inv_R :: "R \<Rightarrow> bool"
where
	"inv_R r \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_R specification\<close>
		( (((inv_VDMNat (x\<^sub>R r))) \<and> 
		 ((inv_VDMNat (y\<^sub>R r))) ))  \<and> 
		\<comment>\<open>User defined body of inv_R\<close>
		((x\<^sub>R (r)) < (y\<^sub>R (r)))"

		

	
abbreviation
	t9 :: "VDMNat1 VDMSet1"
where
	"t9 \<equiv> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}"

	definition
	inv_t9 :: "\<bool>"
where
	"inv_t9  \<equiv> (inv_VDMSet1' (inv_VDMNat1) t9)"

	
	
abbreviation
	v65 :: "R"
where
	"v65 \<equiv> \<lparr>x\<^sub>R = (1::VDMNat1), y\<^sub>R = (2::VDMNat1)\<rparr>"

	definition
	inv_v65 :: "\<bool>"
where
	"inv_v65  \<equiv> inv_R v65"

	
	
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

	
	
abbreviation
	v953 :: "(R \<rightharpoonup> VDMNat1)"
where
	"v953 \<equiv> (\<comment>\<open>VDM Map comprehension is translated as a lambda-term through mapCompSetBound\<close>
		mapCompSetBound 
		{ \<lparr>x\<^sub>R = x, y\<^sub>R = y\<rparr> | x  y .  ((x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)})) \<and>  ((y \<in>{(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}))  } 
		{ (10::VDMNat1) | x  y .  ((x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)})) \<and>  ((y \<in>{(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}))  } 
		
    (\<lambda> R .
		(((inv_VDMNat (x\<^sub>R R))) \<and> 
		 ((inv_VDMNat (y\<^sub>R R)))
		) )
		(inv_VDMNat1) 
		(
	\<lambda> (dummy::R) (dummy2::VDMNat1) .
		(if inv_R dummy \<and> inv_VDMNat1 dummy2 
		 then 
    let x = (x\<^sub>R dummy); y = (y\<^sub>R dummy) in
  		\<lparr>x\<^sub>R = x, y\<^sub>R = y\<rparr>
	 else
		undefined
	)
	) 
		(
	\<lambda> (dummy :: R)  (dummy2 :: VDMNat1) .
		(if inv_R dummy \<and> inv_VDMNat1 dummy2 \<and> (inv_VDMNat1 (10::VDMNat1)) then
		(10::VDMNat1)
	 else
		undefined
	)
	) 
		(
	\<lambda> (dummy :: R)  (dummy2 :: VDMNat1) .
		(if inv_R dummy \<and> inv_VDMNat1 dummy2 \<and> (inv_bool (True::\<bool>)) then
		(True::\<bool>)
	 else
		undefined
	)
	))"

	definition
	inv_v953 :: "\<bool>"
where
	"inv_v953  \<equiv> (inv_Map inv_R  (inv_VDMNat1) v953)"

	
	
abbreviation
	v97 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"v97 \<equiv> (\<comment>\<open>VDM Map comprehension is translated as a lambda-term through mapCompSetBound\<close>
		mapCompSetBound 
		{ x .   ((x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)})) \<and>  ((y \<in>{(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}))  } 
		{ (10::VDMNat1) | x  y .  ((x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)})) \<and>  ((y \<in>{(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}))  } 
		(inv_VDMNat1) 
		(inv_VDMNat1) 
		(
	\<lambda> (x :: VDMNat1)  (y :: VDMNat1) .
		(if (((inv_VDMNat1 x))) \<and>  (((inv_VDMNat1 y))) \<and> (inv_VDMNat1 x) then
		x
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
	inv_v97 :: "\<bool>"
where
	"inv_v97  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v97)"

	
	
abbreviation
	v98 :: "(VDMNat \<rightharpoonup> VDMNat1)"
where
	"v98 \<equiv> (\<comment>\<open>VDM Map comprehension is translated as a lambda-term through mapCompSetBound\<close>
		mapCompSetBound 
		{ d .   ((d \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)})) \<and>  ((r \<in>{(2::VDMNat1), (4::VDMNat1), (6::VDMNat1)}))  \<and> (r = (d * (2::VDMNat1))) } 
		{ r .   ((d \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)})) \<and>  ((r \<in>{(2::VDMNat1), (4::VDMNat1), (6::VDMNat1)}))  \<and> (r = (d * (2::VDMNat1))) } 
		(inv_VDMNat1) 
		(inv_VDMNat1) 
		(
	\<lambda> (d :: VDMNat1)  (r :: VDMNat1) .
		(if (((inv_VDMNat1 d))) \<and>  (((inv_VDMNat1 r))) \<and> (inv_VDMNat1 d) then
		d
	 else
		undefined
	)
	) 
		(
	\<lambda> (d :: VDMNat1)  (r :: VDMNat1) .
		(if (((inv_VDMNat1 d))) \<and>  (((inv_VDMNat1 r))) \<and> (inv_VDMNat1 r) then
		r
	 else
		undefined
	)
	) 
		(
	\<lambda> (d :: VDMNat1)  (r :: VDMNat1) .
		(if (((inv_VDMNat1 d))) \<and>  (((inv_VDMNat1 r))) \<and> (inv_bool (r = (d * (2::VDMNat1)))) then
		(r = (d * (2::VDMNat1)))
	 else
		undefined
	)
	))"

	definition
	inv_v98 :: "\<bool>"
where
	"inv_v98  \<equiv> (inv_Map (inv_VDMNat) (inv_VDMNat1) v98)"

	
end