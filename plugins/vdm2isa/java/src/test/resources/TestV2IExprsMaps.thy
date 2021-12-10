(* VDM to Isabelle Translation @2021-12-09T16:30:41.545992Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2IExprsMaps.vdmsl' at line 1:8
files = [./src/test/resources/TestV2IExprsMaps.vdmsl]
*)
theory TestV2IExprsMaps
imports VDMToolkit
begin


abbreviation
	fv :: "VDMNat1"
where
	"fv \<equiv> (1::VDMNat1)"

	definition
	inv_fv :: "\<bool>"
where
	"inv_fv  \<equiv> (inv_VDMNat1 fv)"
	
abbreviation
	v1 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"v1 \<equiv> ([(1::VDMNat1)\<mapsto>(5::VDMNat1)])"

	definition
	inv_v1 :: "\<bool>"
where
	"inv_v1  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v1)"
	
abbreviation
	v11 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"v11 \<equiv> ([(1::VDMNat1)\<mapsto>(5::VDMNat1)])"

	definition
	inv_v11 :: "\<bool>"
where
	"inv_v11  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v11)"
	
abbreviation
	v12 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"v12 \<equiv> (\<comment>\<open>VDM Map comprehension is translated as a lambda-term through mapCompSetBound\<close>
		mapCompSetBound 
		{ (1::VDMNat1) | x . ((x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}))  \<and> (x > (5::VDMNat1)) } 
		{ (5::VDMNat1) | x . ((x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}))  \<and> (x > (5::VDMNat1)) } 
		(inv_VDMNat1) 
		(inv_VDMNat1) 
		(domcnst (1::VDMNat1)) 
		(rngcnst (5::VDMNat1)) 
		(
	\<lambda> (dummy0DOMAIN :: VDMNat1)  (dummy0RANGE :: VDMNat1) .
		(if (((inv_VDMNat1 dummy0DOMAIN))) \<and>  (((inv_VDMNat1 dummy0RANGE))) \<and> (inv_bool (
		if ((\<exists> (dummy0DOMAIN :: VDMNat1)  (dummy0RANGE :: VDMNat1)  . ((((inv_VDMNat1 dummy0DOMAIN))) \<and>  (((inv_VDMNat1 dummy0RANGE))) \<longrightarrow> (True::\<bool>)))) then
		((x > (5::VDMNat1)))
		else
		(undefined))) then
		(
		if ((\<exists> (dummy0DOMAIN :: VDMNat1)  (dummy0RANGE :: VDMNat1)  . ((((inv_VDMNat1 dummy0DOMAIN))) \<and>  (((inv_VDMNat1 dummy0RANGE))) \<longrightarrow> (True::\<bool>)))) then
		((x > (5::VDMNat1)))
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
	\<lambda> (x :: VDMNat1)  (dummy0RANGE :: VDMNat1) .
		(if (((inv_VDMNat1 x))) \<and>  (((inv_VDMNat1 dummy0RANGE))) \<and> (inv_bool (
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> dummy0RANGE :: VDMNat1  . ((x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and>  ((inv_VDMNat1 dummy0RANGE)) \<longrightarrow> (x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}))))) then
		((x > (2::VDMNat1)))
		else
		(undefined))) then
		(
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> dummy0RANGE :: VDMNat1  . ((x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and>  ((inv_VDMNat1 dummy0RANGE)) \<longrightarrow> (x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}))))) then
		((x > (2::VDMNat1)))
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
	\<lambda> (dummy0DOMAIN :: VDMNat1)  (x :: VDMNat1) .
		(if (((inv_VDMNat1 dummy0DOMAIN))) \<and>  (((inv_VDMNat1 x))) \<and> (inv_bool (
		if ((\<exists> dummy0DOMAIN :: VDMNat1  . (\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (((inv_VDMNat1 dummy0DOMAIN)) \<and>  (x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<longrightarrow> (x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}))))) then
		((x > (2::VDMNat1)))
		else
		(undefined))) then
		(
		if ((\<exists> dummy0DOMAIN :: VDMNat1  . (\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (((inv_VDMNat1 dummy0DOMAIN)) \<and>  (x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<longrightarrow> (x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}))))) then
		((x > (2::VDMNat1)))
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

	
	
abbreviation
	v23 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"v23 \<equiv> (\<comment>\<open>VDM Map comprehension is translated as a lambda-term through mapCompSetBound\<close>
		mapCompSetBound 
		{ d .   ((d \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)})) \<and>  ((r \<in>{(2::VDMNat1), (4::VDMNat1), (6::VDMNat1)}))  \<and> (r = (d * (2::VDMNat1))) } 
		{ r .   ((d \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)})) \<and>  ((r \<in>{(2::VDMNat1), (4::VDMNat1), (6::VDMNat1)}))  \<and> (r = (d * (2::VDMNat1))) } 
		(inv_VDMNat1) 
		(inv_VDMNat1) 
		(domid ) 
		(rngid ) 
		(
	\<lambda> (d :: VDMNat1)  (r :: VDMNat1) .
		(if (((inv_VDMNat1 d))) \<and>  (((inv_VDMNat1 r))) \<and> (inv_bool (
		if ((\<exists> d \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> r \<in> {(2::VDMNat1), (4::VDMNat1), (6::VDMNat1)}  . ((d \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (r \<in> {(2::VDMNat1), (4::VDMNat1), (6::VDMNat1)}))))) then
		((r = (d * (2::VDMNat1))))
		else
		(undefined))) then
		(
		if ((\<exists> d \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> r \<in> {(2::VDMNat1), (4::VDMNat1), (6::VDMNat1)}  . ((d \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (r \<in> {(2::VDMNat1), (4::VDMNat1), (6::VDMNat1)}))))) then
		((r = (d * (2::VDMNat1))))
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

	
	
abbreviation
	v24 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"v24 \<equiv> (\<comment>\<open>VDM Map comprehension is translated as a lambda-term through mapCompSetBound\<close>
		mapCompSetBound 
		{ d .   ((d \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)})) \<and>  ((r \<in>{(2::VDMNat1), (4::VDMNat1), (6::VDMNat1)}))  \<and> (r = ((d * (2::VDMNat1)) + fv)) } 
		{ r .   ((d \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)})) \<and>  ((r \<in>{(2::VDMNat1), (4::VDMNat1), (6::VDMNat1)}))  \<and> (r = ((d * (2::VDMNat1)) + fv)) } 
		(inv_VDMNat1) 
		(inv_VDMNat1) 
		(domid ) 
		(rngid ) 
		(
	\<lambda> (d :: VDMNat1)  (r :: VDMNat1) .
		(if (((inv_VDMNat1 d))) \<and>  (((inv_VDMNat1 r))) \<and> (inv_bool (
		if ((\<exists> d \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> r \<in> {(2::VDMNat1), (4::VDMNat1), (6::VDMNat1)}  . ((d \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (r \<in> {(2::VDMNat1), (4::VDMNat1), (6::VDMNat1)}))))) then
		((r = ((d * (2::VDMNat1)) + fv)))
		else
		(undefined))) then
		(
		if ((\<exists> d \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> r \<in> {(2::VDMNat1), (4::VDMNat1), (6::VDMNat1)}  . ((d \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (r \<in> {(2::VDMNat1), (4::VDMNat1), (6::VDMNat1)}))))) then
		((r = ((d * (2::VDMNat1)) + fv)))
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
	\<lambda> (x :: VDMNat1)  (y :: VDMNat1)  (dummy0RANGE :: VDMNat1) .
		(if (((inv_VDMNat1 x))) \<and>  (((inv_VDMNat1 y))) \<and>  (((inv_VDMNat1 dummy0RANGE))) \<and> (inv_VDMNat1 (
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}  . (\<exists> dummy0RANGE :: VDMNat1  . ((x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and>  (y \<in>{(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}) \<and>  ((inv_VDMNat1 dummy0RANGE)) \<longrightarrow> (((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)})) \<and> (x < y))))))) then
		((x + y))
		else
		(undefined))) then
		(
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}  . (\<exists> dummy0RANGE :: VDMNat1  . ((x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and>  (y \<in>{(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}) \<and>  ((inv_VDMNat1 dummy0RANGE)) \<longrightarrow> (((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)})) \<and> (x < y))))))) then
		((x + y))
		else
		(undefined))
	 else
		undefined
	)
	) 
		(
	\<lambda> (x :: VDMNat1)  (y :: VDMNat1)  (dummy0RANGE :: VDMNat1) .
		(if (((inv_VDMNat1 x))) \<and>  (((inv_VDMNat1 y))) \<and>  (((inv_VDMNat1 dummy0RANGE))) \<and> (inv_VDMNat1 (
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}  . (\<exists> dummy0RANGE :: VDMNat1  . ((x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and>  (y \<in>{(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}) \<and>  ((inv_VDMNat1 dummy0RANGE)) \<longrightarrow> (((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)})) \<and> (x < y))))))) then
		(((10::VDMNat1) + fv))
		else
		(undefined))) then
		(
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}  . (\<exists> dummy0RANGE :: VDMNat1  . ((x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and>  (y \<in>{(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}) \<and>  ((inv_VDMNat1 dummy0RANGE)) \<longrightarrow> (((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)})) \<and> (x < y))))))) then
		(((10::VDMNat1) + fv))
		else
		(undefined))
	 else
		undefined
	)
	) 
		(
	\<lambda> (x :: VDMNat1)  (y :: VDMNat1)  (dummy0RANGE :: VDMNat1) .
		(if (((inv_VDMNat1 x))) \<and>  (((inv_VDMNat1 y))) \<and>  (((inv_VDMNat1 dummy0RANGE))) \<and> (inv_bool (
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}  . (\<exists> dummy0RANGE :: VDMNat1  . ((x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and>  (y \<in>{(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}) \<and>  ((inv_VDMNat1 dummy0RANGE)) \<longrightarrow> ((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}))))))) then
		((x < y))
		else
		(undefined))) then
		(
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}  . (\<exists> dummy0RANGE :: VDMNat1  . ((x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and>  (y \<in>{(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}) \<and>  ((inv_VDMNat1 dummy0RANGE)) \<longrightarrow> ((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}))))))) then
		((x < y))
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
	\<lambda> (x :: VDMNat1)  (y :: VDMNat1)  (dummy0RANGE :: VDMNat1) .
		(if (((inv_VDMNat1 x))) \<and>  (((inv_VDMNat1 y))) \<and>  (((inv_VDMNat1 dummy0RANGE))) \<and> (inv_VDMNat1 (
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}  . (\<exists> dummy0RANGE :: VDMNat1  . ((x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and>  (y \<in>{(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}) \<and>  ((inv_VDMNat1 dummy0RANGE)) \<longrightarrow> (((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)})) \<and> ((x + fv) < y))))))) then
		((x + y))
		else
		(undefined))) then
		(
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}  . (\<exists> dummy0RANGE :: VDMNat1  . ((x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and>  (y \<in>{(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}) \<and>  ((inv_VDMNat1 dummy0RANGE)) \<longrightarrow> (((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)})) \<and> ((x + fv) < y))))))) then
		((x + y))
		else
		(undefined))
	 else
		undefined
	)
	) 
		(
	\<lambda> (x :: VDMNat1)  (y :: VDMNat1)  (dummy0RANGE :: VDMNat1) .
		(if (((inv_VDMNat1 x))) \<and>  (((inv_VDMNat1 y))) \<and>  (((inv_VDMNat1 dummy0RANGE))) \<and> (inv_VDMNat1 (
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}  . (\<exists> dummy0RANGE :: VDMNat1  . ((x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and>  (y \<in>{(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}) \<and>  ((inv_VDMNat1 dummy0RANGE)) \<longrightarrow> (((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)})) \<and> ((x + fv) < y))))))) then
		(((10::VDMNat1) + fv))
		else
		(undefined))) then
		(
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}  . (\<exists> dummy0RANGE :: VDMNat1  . ((x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and>  (y \<in>{(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}) \<and>  ((inv_VDMNat1 dummy0RANGE)) \<longrightarrow> (((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)})) \<and> ((x + fv) < y))))))) then
		(((10::VDMNat1) + fv))
		else
		(undefined))
	 else
		undefined
	)
	) 
		(
	\<lambda> (x :: VDMNat1)  (y :: VDMNat1)  (dummy0RANGE :: VDMNat1) .
		(if (((inv_VDMNat1 x))) \<and>  (((inv_VDMNat1 y))) \<and>  (((inv_VDMNat1 dummy0RANGE))) \<and> (inv_bool (
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}  . (\<exists> dummy0RANGE :: VDMNat1  . ((x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and>  (y \<in>{(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}) \<and>  ((inv_VDMNat1 dummy0RANGE)) \<longrightarrow> ((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}))))))) then
		(((x + fv) < y))
		else
		(undefined))) then
		(
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}  . (\<exists> dummy0RANGE :: VDMNat1  . ((x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and>  (y \<in>{(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}) \<and>  ((inv_VDMNat1 dummy0RANGE)) \<longrightarrow> ((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}))))))) then
		(((x + fv) < y))
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
	\<lambda> (x :: VDMNat1)  (y :: VDMNat1)  (x :: VDMNat1)  (y :: VDMNat1) .
		(if (((inv_VDMNat1 x))) \<and>  (((inv_VDMNat1 y))) \<and>  (((inv_VDMNat1 x))) \<and>  (((inv_VDMNat1 y))) \<and> (inv_VDMNat1 (
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}  . (\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}  . (((((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)})) \<and> (x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)})) \<and> (y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)})) \<and> (((2::VDMNat1) * (x + fv)) > y))))))) then
		((x + y))
		else
		(undefined))) then
		(
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}  . (\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}  . (((((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)})) \<and> (x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)})) \<and> (y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)})) \<and> (((2::VDMNat1) * (x + fv)) > y))))))) then
		((x + y))
		else
		(undefined))
	 else
		undefined
	)
	) 
		(
	\<lambda> (x :: VDMNat1)  (y :: VDMNat1)  (x :: VDMNat1)  (y :: VDMNat1) .
		(if (((inv_VDMNat1 x))) \<and>  (((inv_VDMNat1 y))) \<and>  (((inv_VDMNat1 x))) \<and>  (((inv_VDMNat1 y))) \<and> (inv_VDMNat1 (
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}  . (\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}  . (((((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)})) \<and> (x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)})) \<and> (y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)})) \<and> (((2::VDMNat1) * (x + fv)) > y))))))) then
		((((x + y) * (2::VDMNat1)) + fv))
		else
		(undefined))) then
		(
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}  . (\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}  . (((((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)})) \<and> (x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)})) \<and> (y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)})) \<and> (((2::VDMNat1) * (x + fv)) > y))))))) then
		((((x + y) * (2::VDMNat1)) + fv))
		else
		(undefined))
	 else
		undefined
	)
	) 
		(
	\<lambda> (x :: VDMNat1)  (y :: VDMNat1)  (x :: VDMNat1)  (y :: VDMNat1) .
		(if (((inv_VDMNat1 x))) \<and>  (((inv_VDMNat1 y))) \<and>  (((inv_VDMNat1 x))) \<and>  (((inv_VDMNat1 y))) \<and> (inv_bool (
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}  . (\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}  . ((((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)})) \<and> (x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)})) \<and> (y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}))))))) then
		((((2::VDMNat1) * (x + fv)) > y))
		else
		(undefined))) then
		(
		if ((\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}  . (\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (\<exists> y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}  . ((((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> (y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)})) \<and> (x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)})) \<and> (y \<in> {(4::VDMNat1), (5::VDMNat1), (6::VDMNat1)}))))))) then
		((((2::VDMNat1) * (x + fv)) > y))
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
	\<lambda> (dummy0DOMAIN :: VDMNat1)  (x :: VDMNat1) .
		(if (((inv_VDMNat1 dummy0DOMAIN))) \<and>  (((inv_VDMNat1 x))) \<and> (inv_VDMNat1 (
		if ((\<exists> dummy0DOMAIN :: VDMNat1  . (\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (((inv_VDMNat1 dummy0DOMAIN)) \<and>  (x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<longrightarrow> ((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> ((x + fv) > (5::VDMNat1))))))) then
		((x + x))
		else
		(undefined))) then
		(
		if ((\<exists> dummy0DOMAIN :: VDMNat1  . (\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (((inv_VDMNat1 dummy0DOMAIN)) \<and>  (x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<longrightarrow> ((x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<and> ((x + fv) > (5::VDMNat1))))))) then
		((x + x))
		else
		(undefined))
	 else
		undefined
	)
	) 
		(
	\<lambda> (dummy0DOMAIN :: VDMNat1)  (x :: VDMNat1) .
		(if (((inv_VDMNat1 dummy0DOMAIN))) \<and>  (((inv_VDMNat1 x))) \<and> (inv_bool (
		if ((\<exists> dummy0DOMAIN :: VDMNat1  . (\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (((inv_VDMNat1 dummy0DOMAIN)) \<and>  (x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<longrightarrow> (x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}))))) then
		(((x + fv) > (5::VDMNat1)))
		else
		(undefined))) then
		(
		if ((\<exists> dummy0DOMAIN :: VDMNat1  . (\<exists> x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  . (((inv_VDMNat1 dummy0DOMAIN)) \<and>  (x \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}) \<longrightarrow> (x \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}))))) then
		(((x + fv) > (5::VDMNat1)))
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