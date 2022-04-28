(* VDM to Isabelle Translation @2022-02-23T14:31:20.925805Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2IExprsComplexMaps.vdmsl' at line 1:8
files = [./src/test/resources/TestV2IExprsComplexMaps.vdmsl]
*)
theory TestV2IExprsComplexMaps
imports "VDMToolkit" 
begin


\<comment>\<open>VDM source: R = compose R of x:nat, y:nat end
	inv r == ((r.x) < (r.y))\<close>
\<comment>\<open>in 'TestV2IExprsComplexMaps' (./src/test/resources/TestV2IExprsComplexMaps.vdmsl) at line 6:5\<close>
record R = 
	x\<^sub>R :: "VDMNat"
		 
		 y\<^sub>R :: "VDMNat"
	

\<comment>\<open>VDM source: inv_R: (R +> bool)
	inv_R(r) ==
((r.x) < (r.y))\<close>
\<comment>\<open>in 'TestV2IExprsComplexMaps' (./src/test/resources/TestV2IExprsComplexMaps.vdmsl) at line 9:9\<close>
definition
	inv_R :: "R \<Rightarrow> bool"
where
	"inv_R r \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_R` specification.\<close>
		( (((inv_VDMNat (x\<^sub>R r))) \<and> 
		 ((inv_VDMNat (y\<^sub>R r))) ))  \<and> 
		\<comment>\<open>User defined body of inv_R.\<close>
		((x\<^sub>R r) < (y\<^sub>R r))"

		
lemmas inv_R_defs = inv_R_def inv_VDMNat_def 

definition
	v5_manual :: "(R \<rightharpoonup> VDMNat1)"
where
	"v5_manual \<equiv> (\<comment>\<open>VDM Map comprehension is translated as a lambda-term through mapCompSetBound\<close>
		mapCompSetBound 
    \<comment> \<open>@LF Add 'parts' Isa comments \<close>
  \<comment> \<open>@LF domain set\<close>
		{ dummy0DOMAIN | (dummy0DOMAIN :: R) . 
          \<comment> \<open>@LF remove the type bound warning, but has to do with the R! \<close>
          \<comment>\<open>Type bound set compression will generate a (possibly spurious, i.e. inv_VDMSet') difficult set finiteness proof!!!\<close>  
        (inv_R dummy0DOMAIN)   
          \<and>
        (let x = x\<^sub>R dummy0DOMAIN; y = y\<^sub>R dummy0DOMAIN in  
        \<comment> \<open>@LF this will be tricky: have to get the context outside of the bound and into the predicate part
                that's needed because the bound variables are not x and y but R! \<close>  
          ((x \<in>{(1::VDMNat1) , (2::VDMNat1) , (3::VDMNat1)}))  \<and>  
           ((y \<in>{(4::VDMNat1) , (5::VDMNat1) , (6::VDMNat1)})) \<and>
          (x < y)) }
  \<comment> \<open>@LF range set\<close>
		{ (10::VDMNat1) | x  y .  ((x \<in>{(1::VDMNat1) , (2::VDMNat1) , (3::VDMNat1)}))  \<and>  ((y \<in>{(4::VDMNat1) , (5::VDMNat1) , (6::VDMNat1)}))  \<and> (x < y) } 
  \<comment> \<open>@LF domain invariant\<close>		
		inv_R 
  \<comment> \<open>@LF range invariant\<close>
		(inv_VDMNat1)
    domid
    (rngcnst 10)
    truecnst 
)"

definition
	v5_manual' :: "(R \<rightharpoonup> VDMNat1)"
where
	"v5_manual' \<equiv> (\<comment>\<open>VDM Map comprehension is translated as a lambda-term through mapCompSetBound\<close>
		mapCompSetBound 
    \<comment> \<open>@LF Add 'parts' Isa comments \<close>
  \<comment> \<open>@LF domain set\<close>
		{ \<lparr>x\<^sub>R = x, y\<^sub>R = y\<rparr> | x y . 
          \<comment> \<open>@LF remove the type bound warning, but has to do with the R! \<close>
          \<comment>\<open>Type bound set compression will generate a (possibly spurious, i.e. inv_VDMSet') difficult set finiteness proof!!!\<close>  
        (inv_R \<lparr>x\<^sub>R = x, y\<^sub>R = y\<rparr>)   
          \<and>
        \<comment> \<open>@LF this will be tricky: have to get the context outside of the bound and into the predicate part
                that's needed because the bound variables are not x and y but R! \<close>  
          ((x \<in>{(1::VDMNat1) , (2::VDMNat1) , (3::VDMNat1)}))  \<and>  
           ((y \<in>{(4::VDMNat1) , (5::VDMNat1) , (6::VDMNat1)})) \<and>
          (x < y) }
  \<comment> \<open>@LF range set\<close>
		{ (10::VDMNat1) | x  y .  ((x \<in>{(1::VDMNat1) , (2::VDMNat1) , (3::VDMNat1)}))  \<and>  ((y \<in>{(4::VDMNat1) , (5::VDMNat1) , (6::VDMNat1)}))  \<and> (x < y) } 
  \<comment> \<open>@LF domain invariant\<close>		
		inv_R 
  \<comment> \<open>@LF range invariant\<close>
		(inv_VDMNat1)
  \<comment> \<open>@LF domain expression as just the record itself; if it had been \<^term>\<open>\<lparr>x\<^sub>R = x+x, y\<^sub>R = y+y\<rparr>\<close>
          then get the complicated expression with the lambda+if+expression below\<close>
    domid
  \<comment> \<open>@LF range expression\<close>
    (rngcnst 10)
  \<comment> \<open>@LF predicate expression depends on inner parts of R, so no chance of simple expression! \<close>
    (\<lambda> (dummy0DOMAIN :: R) (dummy0RANGE :: VDMNat1) .
      \<comment> \<open>@LF don't test the inner record parts but the overall record invariant!\<close>
      (if inv_R dummy0DOMAIN  \<and> inv_VDMNat1 dummy0RANGE \<and> 
            \<comment> \<open>@LF remove inv_bool for all terms except undefined? \<close>
            (inv_bool (if (
              (\<exists> x \<in> {(1::VDMNat1) , (2::VDMNat1) , (3::VDMNat1)} . 
                  (\<exists> y \<in> {(4::VDMNat1) , (5::VDMNat1) , (6::VDMNat1)} . 
                    (((x \<in> {(1::VDMNat1) , (2::VDMNat1) , (3::VDMNat1)}) \<and> 
                      (y \<in> {(4::VDMNat1) , (5::VDMNat1) , (6::VDMNat1)})) \<and> (x < y))))) then
                        True
                    else
                        undefined)
          ) then
        (
      if ((\<exists> x \<in> {(1::VDMNat1) , (2::VDMNat1) , (3::VDMNat1)}  . (\<exists> y \<in> {(4::VDMNat1) , (5::VDMNat1) , (6::VDMNat1)}  . (((x \<in> {(1::VDMNat1) , (2::VDMNat1) , (3::VDMNat1)}) \<and> (y \<in> {(4::VDMNat1) , (5::VDMNat1) , (6::VDMNat1)})) \<and> (x < y))))) then
      ((True::\<bool>))
      else
      (undefined))
       else
        undefined
      )
		) 
)"

(*
		(
	\<lambda> (dummy0DOMAIN :: R)   (dummy0RANGE :: VDMNat1) .
		(if ((
		(((inv_VDMNat (x\<^sub>R dummy0DOMAIN))) \<and> 
		 ((inv_VDMNat (y\<^sub>R dummy0DOMAIN)))
		)))  \<and>  (((inv_VDMNat1 dummy0RANGE))) \<and> 
		(((inv_VDMNat (x\<^sub>R (
		if ((\<exists> (dummy0DOMAIN :: R)   (dummy0DOMAIN :: R)  . (((
		(((inv_VDMNat (x\<^sub>R dummy0DOMAIN))) \<and> 
		 ((inv_VDMNat (y\<^sub>R dummy0DOMAIN)))
		)))  \<and>  ((
		(((inv_VDMNat (x\<^sub>R dummy0DOMAIN))) \<and> 
		 ((inv_VDMNat (y\<^sub>R dummy0DOMAIN)))
		))) \<longrightarrow> ((dummy0DOMAIN = \<lparr>x\<^sub>R = x, y\<^sub>R = y\<rparr>) \<and> (x < y))))) then
		(dummy0DOMAIN)
		else
		(undefined))))) \<and> 
		 ((inv_VDMNat (y\<^sub>R (
		if ((\<exists> (dummy0DOMAIN :: R)   (dummy0DOMAIN :: R)  . (((
		(((inv_VDMNat (x\<^sub>R dummy0DOMAIN))) \<and> 
		 ((inv_VDMNat (y\<^sub>R dummy0DOMAIN)))
		)))  \<and>  ((
		(((inv_VDMNat (x\<^sub>R dummy0DOMAIN))) \<and> 
		 ((inv_VDMNat (y\<^sub>R dummy0DOMAIN)))
		))) \<longrightarrow> ((dummy0DOMAIN = \<lparr>x\<^sub>R = x, y\<^sub>R = y\<rparr>) \<and> (x < y))))) then
		(dummy0DOMAIN)
		else
		(undefined)))))
		) then
			(
		if ((\<exists> (dummy0DOMAIN :: R)   (dummy0DOMAIN :: R)  . (((
		(((inv_VDMNat (x\<^sub>R dummy0DOMAIN))) \<and> 
		 ((inv_VDMNat (y\<^sub>R dummy0DOMAIN)))
		)))  \<and>  ((
		(((inv_VDMNat (x\<^sub>R dummy0DOMAIN))) \<and> 
		 ((inv_VDMNat (y\<^sub>R dummy0DOMAIN)))
		))) \<longrightarrow> ((dummy0DOMAIN = \<lparr>x\<^sub>R = x, y\<^sub>R = y\<rparr>) \<and> (x < y))))) then
		(dummy0DOMAIN)
		else
		(undefined))
		 else
			undefined
		)
		) 
		(rngcnst (10::VDMNat1)) 
		(
	\<lambda> (dummy0DOMAIN :: R)   (dummy0RANGE :: VDMNat1) .
		(if ((
		(((inv_VDMNat (x\<^sub>R dummy0DOMAIN))) \<and> 
		 ((inv_VDMNat (y\<^sub>R dummy0DOMAIN)))
		)))  \<and>  (((inv_VDMNat1 dummy0RANGE))) \<and> (inv_bool (
		if ((\<exists> x \<in> {(1::VDMNat1) , (2::VDMNat1) , (3::VDMNat1)}  . (\<exists> y \<in> {(4::VDMNat1) , (5::VDMNat1) , (6::VDMNat1)}  . (((x \<in> {(1::VDMNat1) , (2::VDMNat1) , (3::VDMNat1)}) \<and> (y \<in> {(4::VDMNat1) , (5::VDMNat1) , (6::VDMNat1)})) \<and> (x < y))))) then
		((True::\<bool>))
		else
		(undefined))) then
			(
		if ((\<exists> x \<in> {(1::VDMNat1) , (2::VDMNat1) , (3::VDMNat1)}  . (\<exists> y \<in> {(4::VDMNat1) , (5::VDMNat1) , (6::VDMNat1)}  . (((x \<in> {(1::VDMNat1) , (2::VDMNat1) , (3::VDMNat1)}) \<and> (y \<in> {(4::VDMNat1) , (5::VDMNat1) , (6::VDMNat1)})) \<and> (x < y))))) then
		((True::\<bool>))
		else
		(undefined))
		 else
			undefined
		)
		))"
	*)
	
\<comment>\<open>VDM source: v5:map (R) to (nat1) = {mk_R(x, y) |-> 10 | x in set {1, 2, 3}, y in set {4, 5, 6} & (x < y)}\<close>
\<comment>\<open>in 'TestV2IExprsComplexMaps' (./src/test/resources/TestV2IExprsComplexMaps.vdmsl) at line 24:5\<close>
abbreviation
	v5 :: "(R \<rightharpoonup> VDMNat1)"
where
	"v5 \<equiv> (\<comment>\<open>VDM Map comprehension is translated as a lambda-term through mapCompSetBound\<close>
		mapCompSetBound 
		{ \<lparr>x\<^sub>R = x, y\<^sub>R = y\<rparr> | (dummy0DOMAIN :: R) .  \<comment>\<open>Type bound set compression will generate a (possibly spurious, i.e. inv_VDMSet') difficult set finiteness proof!!!\<close>  ((
		(((inv_VDMNat (x\<^sub>R dummy0DOMAIN))) \<and> 
		 ((inv_VDMNat (y\<^sub>R dummy0DOMAIN)))
		)))  \<and>  ((
		(((inv_VDMNat (x\<^sub>R dummy0DOMAIN))) \<and> 
		 ((inv_VDMNat (y\<^sub>R dummy0DOMAIN)))
		)))  \<and> 
    (let x = x\<^sub>R dummy0DOMAIN; y = y\<^sub>R dummy0DOMAIN in  
    (x < y)) } 
		{ (10::VDMNat1) | x  y .  ((x \<in>{(1::VDMNat1) , (2::VDMNat1) , (3::VDMNat1)}))  \<and>  ((y \<in>{(4::VDMNat1) , (5::VDMNat1) , (6::VDMNat1)}))  \<and> (x < y) } 
		
		inv_R 
		(inv_VDMNat1) 
		(
	\<lambda> (dummy0DOMAIN :: R)   (dummy0RANGE :: VDMNat1) .
		(if ((
		(((inv_VDMNat (x\<^sub>R dummy0DOMAIN))) \<and> 
		 ((inv_VDMNat (y\<^sub>R dummy0DOMAIN)))
		)))  \<and>  (((inv_VDMNat1 dummy0RANGE))) \<and> 
		(((inv_VDMNat (x\<^sub>R (
		if ((\<exists> (dummy0DOMAIN :: R)   (dummy0DOMAIN :: R)  . (((
		(((inv_VDMNat (x\<^sub>R dummy0DOMAIN))) \<and> 
		 ((inv_VDMNat (y\<^sub>R dummy0DOMAIN)))
		)))  \<and>  ((
		(((inv_VDMNat (x\<^sub>R dummy0DOMAIN))) \<and> 
		 ((inv_VDMNat (y\<^sub>R dummy0DOMAIN)))
		))) \<longrightarrow> ((dummy0DOMAIN = \<lparr>x\<^sub>R = x, y\<^sub>R = y\<rparr>) \<and> (x < y))))) then
		(dummy0DOMAIN)
		else
		(undefined))))) \<and> 
		 ((inv_VDMNat (y\<^sub>R (
		if ((\<exists> (dummy0DOMAIN :: R)   (dummy0DOMAIN :: R)  . (((
		(((inv_VDMNat (x\<^sub>R dummy0DOMAIN))) \<and> 
		 ((inv_VDMNat (y\<^sub>R dummy0DOMAIN)))
		)))  \<and>  ((
		(((inv_VDMNat (x\<^sub>R dummy0DOMAIN))) \<and> 
		 ((inv_VDMNat (y\<^sub>R dummy0DOMAIN)))
		))) \<longrightarrow> ((dummy0DOMAIN = \<lparr>x\<^sub>R = x, y\<^sub>R = y\<rparr>) \<and> (x < y))))) then
		(dummy0DOMAIN)
		else
		(undefined)))))
		) then
			(
		if ((\<exists> (dummy0DOMAIN :: R)   (dummy0DOMAIN :: R)  . (((
		(((inv_VDMNat (x\<^sub>R dummy0DOMAIN))) \<and> 
		 ((inv_VDMNat (y\<^sub>R dummy0DOMAIN)))
		)))  \<and>  ((
		(((inv_VDMNat (x\<^sub>R dummy0DOMAIN))) \<and> 
		 ((inv_VDMNat (y\<^sub>R dummy0DOMAIN)))
		))) \<longrightarrow> ((dummy0DOMAIN = \<lparr>x\<^sub>R = x, y\<^sub>R = y\<rparr>) \<and> (x < y))))) then
		(dummy0DOMAIN)
		else
		(undefined))
		 else
			undefined
		)
		) 
		(rngcnst (10::VDMNat1)) 
		(
	\<lambda> (dummy0DOMAIN :: R)   (dummy0RANGE :: VDMNat1) .
		(if ((
		(((inv_VDMNat (x\<^sub>R dummy0DOMAIN))) \<and> 
		 ((inv_VDMNat (y\<^sub>R dummy0DOMAIN)))
		)))  \<and>  (((inv_VDMNat1 dummy0RANGE))) \<and> (inv_bool (
		if ((\<exists> x \<in> {(1::VDMNat1) , (2::VDMNat1) , (3::VDMNat1)}  . (\<exists> y \<in> {(4::VDMNat1) , (5::VDMNat1) , (6::VDMNat1)}  . (((x \<in> {(1::VDMNat1) , (2::VDMNat1) , (3::VDMNat1)}) \<and> (y \<in> {(4::VDMNat1) , (5::VDMNat1) , (6::VDMNat1)})) \<and> (x < y))))) then
		((True::\<bool>))
		else
		(undefined))) then
			(
		if ((\<exists> x \<in> {(1::VDMNat1) , (2::VDMNat1) , (3::VDMNat1)}  . (\<exists> y \<in> {(4::VDMNat1) , (5::VDMNat1) , (6::VDMNat1)}  . (((x \<in> {(1::VDMNat1) , (2::VDMNat1) , (3::VDMNat1)}) \<and> (y \<in> {(4::VDMNat1) , (5::VDMNat1) , (6::VDMNat1)})) \<and> (x < y))))) then
		((True::\<bool>))
		else
		(undefined))
		 else
			undefined
		)
		))"

	definition
	inv_v5 :: "\<bool>"
where
	"inv_v5  \<equiv> (inv_Map inv_R  (inv_VDMNat1) v5)"

	
end