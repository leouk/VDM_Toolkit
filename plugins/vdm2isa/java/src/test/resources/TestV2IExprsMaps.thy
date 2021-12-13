(* VDM to Isabelle Translation @2021-12-13T09:52:48.319248Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2IExprsMaps.vdmsl' at line 1:8
files = [./src/test/resources/TestV2IExprsMaps.vdmsl]
*)
theory TestV2IExprsMaps
imports "VDMToolkit" 
begin


\<comment>\<open>VDM source: fv:nat1 = 1\<close>
\<comment>\<open>in 'TestV2IExprsMaps' (./src/test/resources/TestV2IExprsMaps.vdmsl) at line 7:5\<close>
abbreviation
	fv :: "VDMNat1"
where
	"fv \<equiv> (1::VDMNat1)"

	definition
	inv_fv :: "\<bool>"
where
	"inv_fv  \<equiv> (inv_VDMNat1 fv)"

	
	
\<comment>\<open>VDM source: v1:map (nat1) to (nat1) = {1 |-> 5 | x in set {1, 2, 3}}\<close>
\<comment>\<open>in 'TestV2IExprsMaps' (./src/test/resources/TestV2IExprsMaps.vdmsl) at line 11:5\<close>
abbreviation
	v1 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"v1 \<equiv> ([(1::VDMNat1)\<mapsto>(5::VDMNat1)])"

	definition
	inv_v1 :: "\<bool>"
where
	"inv_v1  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v1)"

	
	
\<comment>\<open>VDM source: v11:map (nat1) to (nat1) = {1 |-> 5 | x in set {1, 2, 3} & true}\<close>
\<comment>\<open>in 'TestV2IExprsMaps' (./src/test/resources/TestV2IExprsMaps.vdmsl) at line 14:5\<close>
abbreviation
	v11 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"v11 \<equiv> ([(1::VDMNat1)\<mapsto>(5::VDMNat1)])"

	definition
	inv_v11 :: "\<bool>"
where
	"inv_v11  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v11)"

	
	
\<comment>\<open>VDM source: v12:map (nat1) to (nat1) = {1 |-> 5 | x in set {1, 2, 3} & (x > 5)}\<close>
\<comment>\<open>in 'TestV2IExprsMaps' (./src/test/resources/TestV2IExprsMaps.vdmsl) at line 16:5\<close>
abbreviation
	v12 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"v12 \<equiv> (\<comment>\<open>VDM Map comprehension is translated as a lambda-term through mapCompSetBound\<close>
		mapCompSetBound 
		{ (1::VDMNat1) | x .  ((x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}))  \<and> (x > (5::VDMNat1)) } 
		{ (5::VDMNat1) | x .  ((x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}))  \<and> (x > (5::VDMNat1)) } 
		(inv_VDMNat1) 
		(inv_VDMNat1) 
		(domcnst (1::VDMNat1)) 
		(rngcnst (5::VDMNat1)) 
		(
	\<lambda> (dummy0DOMAIN :: VDMNat1)  (dummy0RANGE :: VDMNat1) .
		(if (((inv_VDMNat1 dummy0DOMAIN))) \<and>  (((inv_VDMNat1 dummy0RANGE))) \<and> (inv_bool (
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . ((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (x > (5::VDMNat1))))) then
		((True::\<bool>))
		else
		(undefined))) then
		(
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . ((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (x > (5::VDMNat1))))) then
		((True::\<bool>))
		else
		(undefined))
	 else
		undefined
	)
	))"

	definition
	inv_v12 :: "\<bool>"
where
	"inv_v12  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v12)"

	
	
\<comment>\<open>VDM source: v2:map (nat1) to (nat1) = {x |-> 10 | x in set {1, 2, 3}}\<close>
\<comment>\<open>in 'TestV2IExprsMaps' (./src/test/resources/TestV2IExprsMaps.vdmsl) at line 21:5\<close>
abbreviation
	v2 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"v2 \<equiv> (\<comment>\<open>VDM Map comprehension is translated as a lambda-term through mapCompSetBound\<close>
		mapCompSetBound 
		{ x .   ((x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}))  } 
		{(10::VDMNat1)} 
		(inv_VDMNat1) 
		(inv_VDMNat1) 
		(domid ) 
		(rngcnst (10::VDMNat1)) 
		(truecnst ))"

	definition
	inv_v2 :: "\<bool>"
where
	"inv_v2  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v2)"

	
	
\<comment>\<open>VDM source: v21:map (nat1) to (nat1) = {x |-> 10 | x in set {1, 2, 3} & (x > 2)}\<close>
\<comment>\<open>in 'TestV2IExprsMaps' (./src/test/resources/TestV2IExprsMaps.vdmsl) at line 24:5\<close>
abbreviation
	v21 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"v21 \<equiv> (\<comment>\<open>VDM Map comprehension is translated as a lambda-term through mapCompSetBound\<close>
		mapCompSetBound 
		{ x .   ((x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}))  \<and> (x > (2::VDMNat1)) } 
		{ (10::VDMNat1) | x .  ((x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}))  \<and> (x > (2::VDMNat1)) } 
		(inv_VDMNat1) 
		(inv_VDMNat1) 
		(domid ) 
		(rngcnst (10::VDMNat1)) 
		(
	\<lambda> (dummy0DOMAIN :: VDMNat1)  (dummy0RANGE :: VDMNat1) .
		(if (((inv_VDMNat1 dummy0DOMAIN))) \<and>  (((inv_VDMNat1 dummy0RANGE))) \<and> (inv_bool (
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . ((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (x > (2::VDMNat1))))) then
		((True::\<bool>))
		else
		(undefined))) then
		(
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . ((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (x > (2::VDMNat1))))) then
		((True::\<bool>))
		else
		(undefined))
	 else
		undefined
	)
	))"

	definition
	inv_v21 :: "\<bool>"
where
	"inv_v21  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v21)"

	
	
\<comment>\<open>VDM source: v22:map (nat1) to (nat1) = {1 |-> x | x in set {1, 2, 3} & (x > 2)}\<close>
\<comment>\<open>in 'TestV2IExprsMaps' (./src/test/resources/TestV2IExprsMaps.vdmsl) at line 28:5\<close>
abbreviation
	v22 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"v22 \<equiv> (\<comment>\<open>VDM Map comprehension is translated as a lambda-term through mapCompSetBound\<close>
		mapCompSetBound 
		{ (1::VDMNat1) | x .  ((x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}))  \<and> (x > (2::VDMNat1)) } 
		{ x .   ((x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}))  \<and> (x > (2::VDMNat1)) } 
		(inv_VDMNat1) 
		(inv_VDMNat1) 
		(domcnst (1::VDMNat1)) 
		(rngid ) 
		(
	\<lambda> (dummy0DOMAIN :: VDMNat1)  (dummy0RANGE :: VDMNat1) .
		(if (((inv_VDMNat1 dummy0DOMAIN))) \<and>  (((inv_VDMNat1 dummy0RANGE))) \<and> (inv_bool (
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . ((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (x > (2::VDMNat1))))) then
		((True::\<bool>))
		else
		(undefined))) then
		(
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . ((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (x > (2::VDMNat1))))) then
		((True::\<bool>))
		else
		(undefined))
	 else
		undefined
	)
	))"

	definition
	inv_v22 :: "\<bool>"
where
	"inv_v22  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v22)"

	
	
\<comment>\<open>VDM source: v23:map (nat1) to (nat1) = {d |-> r | d in set {1, 2, 3}, r in set {2, 4, 6} & (r = (d * 2))}\<close>
\<comment>\<open>in 'TestV2IExprsMaps' (./src/test/resources/TestV2IExprsMaps.vdmsl) at line 31:5\<close>
abbreviation
	v23 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"v23 \<equiv> (\<comment>\<open>VDM Map comprehension is translated as a lambda-term through mapCompSetBound\<close>
		mapCompSetBound 
		{ d | d  r .  ((d \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)})) \<and>  ((r \<in>{(2::VDMNat1), (4::VDMNat1), (6::VDMNat1)}))  \<and> (r = (d * (2::VDMNat1))) } 
		{ r | d  r .  ((d \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)})) \<and>  ((r \<in>{(2::VDMNat1), (4::VDMNat1), (6::VDMNat1)}))  \<and> (r = (d * (2::VDMNat1))) } 
		(inv_VDMNat1) 
		(inv_VDMNat1) 
		(domid ) 
		(rngid ) 
		(
	\<lambda> (dummy0DOMAIN :: VDMNat1)  (dummy0RANGE :: VDMNat1) .
		(if (((inv_VDMNat1 dummy0DOMAIN))) \<and>  (((inv_VDMNat1 dummy0RANGE))) \<and> (inv_bool (
		if ((\<exists> d \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> r \<in> {(2::VDMNat1), (4::VDMNat1), (6::VDMNat1)}  . (((d \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (r \<in> {(2::VDMNat1), (4::VDMNat1), (6::VDMNat1)})) \<and> (r = (d * (2::VDMNat1))))))) then
		((True::\<bool>))
		else
		(undefined))) then
		(
		if ((\<exists> d \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> r \<in> {(2::VDMNat1), (4::VDMNat1), (6::VDMNat1)}  . (((d \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (r \<in> {(2::VDMNat1), (4::VDMNat1), (6::VDMNat1)})) \<and> (r = (d * (2::VDMNat1))))))) then
		((True::\<bool>))
		else
		(undefined))
	 else
		undefined
	)
	))"

	definition
	inv_v23 :: "\<bool>"
where
	"inv_v23  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v23)"

	
	
\<comment>\<open>VDM source: v24:map (nat1) to (nat1) = {d |-> r | d in set {1, 2, 3}, r in set {2, 4, 6} & (r = ((d * 2) + fv))}\<close>
\<comment>\<open>in 'TestV2IExprsMaps' (./src/test/resources/TestV2IExprsMaps.vdmsl) at line 34:5\<close>
abbreviation
	v24 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"v24 \<equiv> (\<comment>\<open>VDM Map comprehension is translated as a lambda-term through mapCompSetBound\<close>
		mapCompSetBound 
		{ d | d  r .  ((d \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)})) \<and>  ((r \<in>{(2::VDMNat1), (4::VDMNat1), (6::VDMNat1)}))  \<and> (r = ((d * (2::VDMNat1)) + fv)) } 
		{ r | d  r .  ((d \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)})) \<and>  ((r \<in>{(2::VDMNat1), (4::VDMNat1), (6::VDMNat1)}))  \<and> (r = ((d * (2::VDMNat1)) + fv)) } 
		(inv_VDMNat1) 
		(inv_VDMNat1) 
		(domid ) 
		(rngid ) 
		(
	\<lambda> (dummy0DOMAIN :: VDMNat1)  (dummy0RANGE :: VDMNat1) .
		(if (((inv_VDMNat1 dummy0DOMAIN))) \<and>  (((inv_VDMNat1 dummy0RANGE))) \<and> (inv_bool (
		if ((\<exists> d \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> r \<in> {(2::VDMNat1), (4::VDMNat1), (6::VDMNat1)}  . (((d \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (r \<in> {(2::VDMNat1), (4::VDMNat1), (6::VDMNat1)})) \<and> (r = ((d * (2::VDMNat1)) + fv)))))) then
		((True::\<bool>))
		else
		(undefined))) then
		(
		if ((\<exists> d \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> r \<in> {(2::VDMNat1), (4::VDMNat1), (6::VDMNat1)}  . (((d \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (r \<in> {(2::VDMNat1), (4::VDMNat1), (6::VDMNat1)})) \<and> (r = ((d * (2::VDMNat1)) + fv)))))) then
		((True::\<bool>))
		else
		(undefined))
	 else
		undefined
	)
	))"

	definition
	inv_v24 :: "\<bool>"
where
	"inv_v24  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v24)"

	
	
\<comment>\<open>VDM source: v3:map (nat1) to (nat1) = {(x + y) |-> (10 + fv) | x in set {1, 2, 3}, y in set {4, 5, 6} & (x < y)}\<close>
\<comment>\<open>in 'TestV2IExprsMaps' (./src/test/resources/TestV2IExprsMaps.vdmsl) at line 37:5\<close>
abbreviation
	v3 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"v3 \<equiv> (\<comment>\<open>VDM Map comprehension is translated as a lambda-term through mapCompSetBound\<close>
		mapCompSetBound 
		{ (x + y) | x  y .  ((x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)})) \<and>  ((y \<in>{(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}))  \<and> (x < y) } 
		{ ((10::VDMNat1) + fv) | x  y .  ((x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)})) \<and>  ((y \<in>{(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}))  \<and> (x < y) } 
		(inv_VDMNat1) 
		(inv_VDMNat1) 
		(
	\<lambda> (dummy0DOMAIN :: VDMNat1)  (dummy0RANGE :: VDMNat1) .
		(if (((inv_VDMNat1 dummy0DOMAIN))) \<and>  (((inv_VDMNat1 dummy0RANGE))) \<and> (inv_VDMNat1 (
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}  . (((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)})) \<and> ((dummy0DOMAIN = (x + y)) \<and> (x < y)))))) then
		(dummy0DOMAIN)
		else
		(undefined))) then
		(
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}  . (((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)})) \<and> ((dummy0DOMAIN = (x + y)) \<and> (x < y)))))) then
		(dummy0DOMAIN)
		else
		(undefined))
	 else
		undefined
	)
	) 
		(rngcnst ((10::VDMNat1) + fv)) 
		(
	\<lambda> (dummy0DOMAIN :: VDMNat1)  (dummy0RANGE :: VDMNat1) .
		(if (((inv_VDMNat1 dummy0DOMAIN))) \<and>  (((inv_VDMNat1 dummy0RANGE))) \<and> (inv_bool (
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}  . (((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)})) \<and> (x < y))))) then
		((True::\<bool>))
		else
		(undefined))) then
		(
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}  . (((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)})) \<and> (x < y))))) then
		((True::\<bool>))
		else
		(undefined))
	 else
		undefined
	)
	))"

	definition
	inv_v3 :: "\<bool>"
where
	"inv_v3  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v3)"

	
	
\<comment>\<open>VDM source: v30:map (nat1) to (nat1) = {(x + y) |-> (10 + fv) | x in set {1, 2, 3}, y in set {4, 5, 6}}\<close>
\<comment>\<open>in 'TestV2IExprsMaps' (./src/test/resources/TestV2IExprsMaps.vdmsl) at line 38:5\<close>
abbreviation
	v30 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"v30 \<equiv> (\<comment>\<open>VDM Map comprehension is translated as a lambda-term through mapCompSetBound\<close>
		mapCompSetBound 
		{ (x + y) | x  y .  ((x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)})) \<and>  ((y \<in>{(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}))  } 
		{((10::VDMNat1) + fv)} 
		(inv_VDMNat1) 
		(inv_VDMNat1) 
		(
	\<lambda> (dummy0DOMAIN :: VDMNat1)  (dummy0RANGE :: VDMNat1) .
		(if (((inv_VDMNat1 dummy0DOMAIN))) \<and>  (((inv_VDMNat1 dummy0RANGE))) \<and> (inv_VDMNat1 (
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}  . (((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)})) \<and> ((dummy0DOMAIN = (x + y)) \<and> (True::\<bool>)))))) then
		(dummy0DOMAIN)
		else
		(undefined))) then
		(
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}  . (((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)})) \<and> ((dummy0DOMAIN = (x + y)) \<and> (True::\<bool>)))))) then
		(dummy0DOMAIN)
		else
		(undefined))
	 else
		undefined
	)
	) 
		(rngcnst ((10::VDMNat1) + fv)) 
		(truecnst ))"

	definition
	inv_v30 :: "\<bool>"
where
	"inv_v30  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v30)"

	
	
\<comment>\<open>VDM source: v31:map (nat1) to (nat1) = {(x + y) |-> (10 + fv) | x in set {1, 2, 3}, y in set {4, 5, 6} & ((x + fv) < y)}\<close>
\<comment>\<open>in 'TestV2IExprsMaps' (./src/test/resources/TestV2IExprsMaps.vdmsl) at line 39:5\<close>
abbreviation
	v31 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"v31 \<equiv> (\<comment>\<open>VDM Map comprehension is translated as a lambda-term through mapCompSetBound\<close>
		mapCompSetBound 
		{ (x + y) | x  y .  ((x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)})) \<and>  ((y \<in>{(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}))  \<and> ((x + fv) < y) } 
		{ ((10::VDMNat1) + fv) | x  y .  ((x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)})) \<and>  ((y \<in>{(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}))  \<and> ((x + fv) < y) } 
		(inv_VDMNat1) 
		(inv_VDMNat1) 
		(
	\<lambda> (dummy0DOMAIN :: VDMNat1)  (dummy0RANGE :: VDMNat1) .
		(if (((inv_VDMNat1 dummy0DOMAIN))) \<and>  (((inv_VDMNat1 dummy0RANGE))) \<and> (inv_VDMNat1 (
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}  . (((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)})) \<and> ((dummy0DOMAIN = (x + y)) \<and> ((x + fv) < y)))))) then
		(dummy0DOMAIN)
		else
		(undefined))) then
		(
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}  . (((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)})) \<and> ((dummy0DOMAIN = (x + y)) \<and> ((x + fv) < y)))))) then
		(dummy0DOMAIN)
		else
		(undefined))
	 else
		undefined
	)
	) 
		(rngcnst ((10::VDMNat1) + fv)) 
		(
	\<lambda> (dummy0DOMAIN :: VDMNat1)  (dummy0RANGE :: VDMNat1) .
		(if (((inv_VDMNat1 dummy0DOMAIN))) \<and>  (((inv_VDMNat1 dummy0RANGE))) \<and> (inv_bool (
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}  . (((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)})) \<and> ((x + fv) < y))))) then
		((True::\<bool>))
		else
		(undefined))) then
		(
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}  . (((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)})) \<and> ((x + fv) < y))))) then
		((True::\<bool>))
		else
		(undefined))
	 else
		undefined
	)
	))"

	definition
	inv_v31 :: "\<bool>"
where
	"inv_v31  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v31)"

	
	
\<comment>\<open>VDM source: v32:map (nat1) to (nat1) = {(x + y) |-> (((x + y) * 2) + fv) | x in set {1, 2, 3}, y in set {4, 5, 6} & ((2 * (x + fv)) > y)}\<close>
\<comment>\<open>in 'TestV2IExprsMaps' (./src/test/resources/TestV2IExprsMaps.vdmsl) at line 40:5\<close>
abbreviation
	v32 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"v32 \<equiv> (\<comment>\<open>VDM Map comprehension is translated as a lambda-term through mapCompSetBound\<close>
		mapCompSetBound 
		{ (x + y) | x  y .  ((x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)})) \<and>  ((y \<in>{(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}))  \<and> (((2::VDMNat1) * (x + fv)) > y) } 
		{ (((x + y) * (2::VDMNat1)) + fv) | x  y .  ((x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)})) \<and>  ((y \<in>{(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}))  \<and> (((2::VDMNat1) * (x + fv)) > y) } 
		(inv_VDMNat1) 
		(inv_VDMNat1) 
		(
	\<lambda> (dummy0DOMAIN :: VDMNat1)  (dummy0RANGE :: VDMNat1) .
		(if (((inv_VDMNat1 dummy0DOMAIN))) \<and>  (((inv_VDMNat1 dummy0RANGE))) \<and> (inv_VDMNat1 (
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}  . (((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)})) \<and> ((dummy0DOMAIN = (x + y)) \<and> (((2::VDMNat1) * (x + fv)) > y)))))) then
		(dummy0DOMAIN)
		else
		(undefined))) then
		(
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}  . (((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)})) \<and> ((dummy0DOMAIN = (x + y)) \<and> (((2::VDMNat1) * (x + fv)) > y)))))) then
		(dummy0DOMAIN)
		else
		(undefined))
	 else
		undefined
	)
	) 
		(
	\<lambda> (dummy0DOMAIN :: VDMNat1)  (dummy0RANGE :: VDMNat1) .
		(if (((inv_VDMNat1 dummy0DOMAIN))) \<and>  (((inv_VDMNat1 dummy0RANGE))) \<and> (inv_VDMNat1 (
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}  . (((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)})) \<and> ((dummy0RANGE = (((x + y) * (2::VDMNat1)) + fv)) \<and> (((2::VDMNat1) * (x + fv)) > y)))))) then
		(dummy0RANGE)
		else
		(undefined))) then
		(
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}  . (((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)})) \<and> ((dummy0RANGE = (((x + y) * (2::VDMNat1)) + fv)) \<and> (((2::VDMNat1) * (x + fv)) > y)))))) then
		(dummy0RANGE)
		else
		(undefined))
	 else
		undefined
	)
	) 
		(
	\<lambda> (dummy0DOMAIN :: VDMNat1)  (dummy0RANGE :: VDMNat1) .
		(if (((inv_VDMNat1 dummy0DOMAIN))) \<and>  (((inv_VDMNat1 dummy0RANGE))) \<and> (inv_bool (
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}  . (((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)})) \<and> (((2::VDMNat1) * (x + fv)) > y))))) then
		((True::\<bool>))
		else
		(undefined))) then
		(
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}  . (((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)})) \<and> (((2::VDMNat1) * (x + fv)) > y))))) then
		((True::\<bool>))
		else
		(undefined))
	 else
		undefined
	)
	))"

	definition
	inv_v32 :: "\<bool>"
where
	"inv_v32  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v32)"

	
	
\<comment>\<open>VDM source: v33:map (nat1) to (nat1) = {1 |-> (x + x) | x in set {1, 2, 3} & ((x + fv) > 5)}\<close>
\<comment>\<open>in 'TestV2IExprsMaps' (./src/test/resources/TestV2IExprsMaps.vdmsl) at line 43:5\<close>
abbreviation
	v33 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"v33 \<equiv> (\<comment>\<open>VDM Map comprehension is translated as a lambda-term through mapCompSetBound\<close>
		mapCompSetBound 
		{ (1::VDMNat1) | x .  ((x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}))  \<and> ((x + fv) > (5::VDMNat1)) } 
		{ (x + x) | x .  ((x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}))  \<and> ((x + fv) > (5::VDMNat1)) } 
		(inv_VDMNat1) 
		(inv_VDMNat1) 
		(domcnst (1::VDMNat1)) 
		(
	\<lambda> (dummy0DOMAIN :: VDMNat1)  (dummy0RANGE :: VDMNat1) .
		(if (((inv_VDMNat1 dummy0DOMAIN))) \<and>  (((inv_VDMNat1 dummy0RANGE))) \<and> (inv_VDMNat1 (
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . ((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> ((dummy0RANGE = (x + x)) \<and> ((x + fv) > (5::VDMNat1)))))) then
		(dummy0RANGE)
		else
		(undefined))) then
		(
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . ((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> ((dummy0RANGE = (x + x)) \<and> ((x + fv) > (5::VDMNat1)))))) then
		(dummy0RANGE)
		else
		(undefined))
	 else
		undefined
	)
	) 
		(
	\<lambda> (dummy0DOMAIN :: VDMNat1)  (dummy0RANGE :: VDMNat1) .
		(if (((inv_VDMNat1 dummy0DOMAIN))) \<and>  (((inv_VDMNat1 dummy0RANGE))) \<and> (inv_bool (
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . ((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> ((x + fv) > (5::VDMNat1))))) then
		((True::\<bool>))
		else
		(undefined))) then
		(
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . ((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> ((x + fv) > (5::VDMNat1))))) then
		((True::\<bool>))
		else
		(undefined))
	 else
		undefined
	)
	))"

	definition
	inv_v33 :: "\<bool>"
where
	"inv_v33  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v33)"

	
end