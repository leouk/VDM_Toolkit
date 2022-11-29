(* VDM to Isabelle Translation @2022-02-27T11:35:55.311633Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/Examples/Traffic/traffic.vdmsl' at line 1:8
files = [./src/test/resources/Examples/Traffic/traffic.vdmsl]
*)
theory traffic
imports "VDMToolkit" 
begin


\<comment>\<open>VDM source: Light = (<Amber> | <Green> | <Red>)\<close>
\<comment>\<open>in 'traffic' (./src/test/resources/Examples/Traffic/traffic.vdmsl) at line 11:3\<close>
datatype Light = U_Amber  | 
		 U_Green  | 
		 U_Red 
	

\<comment>\<open>VDM source: inv_Light: (Light +> bool)
	inv_Light(dummy0) ==
null\<close>
\<comment>\<open>in 'traffic' (./src/test/resources/Examples/Traffic/traffic.vdmsl) at line 11:3\<close>
definition
	inv_Light :: "Light \<Rightarrow> bool"
where
	"inv_Light dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_Light` specification.\<close>
		((((inv_True dummy0))))"
 
lemmas inv_Light_defs = inv_Light_def inv_True_def 


	
	
\<comment>\<open>VDM source: Time = real
	inv t == (t >= 0)\<close>
\<comment>\<open>in 'traffic' (./src/test/resources/Examples/Traffic/traffic.vdmsl) at line 13:3\<close>
type_synonym Time = "VDMReal"
	

\<comment>\<open>VDM source: inv_Time: (real +> bool)
	inv_Time(t) ==
(t >= 0)\<close>
\<comment>\<open>in 'traffic' (./src/test/resources/Examples/Traffic/traffic.vdmsl) at line 14:7\<close>
definition
	inv_Time :: "Time \<Rightarrow> bool"
where
	"inv_Time t \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_Time` specification.\<close>
		(((inv_VDMReal t)))  \<and> 
		\<comment>\<open>User defined body of inv_Time.\<close>
		(t \<ge> (0::VDMNat))"

		 
lemmas inv_Time_defs = inv_Time_def inv_VDMReal_def 


	
	
\<comment>\<open>VDM source: Path = token\<close>
\<comment>\<open>in 'traffic' (./src/test/resources/Examples/Traffic/traffic.vdmsl) at line 16:3\<close>
type_synonym Path = "VDMChar VDMSeq VDMToken"
	

\<comment>\<open>VDM source: inv_Path: (Path +> bool)
	inv_Path(dummy0) ==
null\<close>
\<comment>\<open>in 'traffic' (./src/test/resources/Examples/Traffic/traffic.vdmsl) at line 16:3\<close>
definition
	inv_Path :: "Path \<Rightarrow> bool"
where
	"inv_Path dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_Path` specification.\<close>
		(((inv_VDMToken' (inv_VDMSeq' (inv_VDMChar)) dummy0)))"
 
lemmas inv_Path_defs = inv_Path_def inv_VDMChar_def inv_VDMSeq'_def inv_VDMSeq'_defs inv_VDMToken'_def 


	
	
\<comment>\<open>VDM source: Conflict = compose Conflict of path1:Path, path2:Path end
	inv mk_Conflict(path1, path2) == (path1 <> path2)\<close>
\<comment>\<open>in 'traffic' (./src/test/resources/Examples/Traffic/traffic.vdmsl) at line 18:3\<close>
record Conflict = 
	path1\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t :: "Path"
		 
		 path2\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t :: "Path"
	

\<comment>\<open>VDM source: inv_Conflict: (Conflict +> bool)
	inv_Conflict(mk_Conflict(path1, path2)) ==
(path1 <> path2)\<close>
\<comment>\<open>in 'traffic' (./src/test/resources/Examples/Traffic/traffic.vdmsl) at line 20:7\<close>
definition
	inv_Conflict :: "Conflict \<Rightarrow> bool"
where
	"inv_Conflict dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_Conflict` specification.\<close>
		( (((inv_Path (path1\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t dummy0))) \<and> 
		 ((inv_Path (path2\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t dummy0))) ))  \<and> 
		\<comment>\<open>Implicit pattern context conversion\<close>
		(let path1 = (path1\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t dummy0); path2 = (path2\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t dummy0) in 
		\<comment>\<open>User defined body of inv_Conflict.\<close>
		(path1 \<noteq> path2))"

		
lemmas inv_Conflict_defs = inv_Conflict_def inv_Path_def inv_VDMChar_def inv_VDMSeq'_def inv_VDMSeq'_defs inv_VDMToken'_def 


	
	
\<comment>\<open>VDM source: Kernel = compose Kernel of lights:map (Path) to (Light), conflicts:set of (Conflict) end
	inv mk_Kernel(ls, cs) == (forall c in set cs & ((mk_Conflict((c.path2), (c.path1)) in set cs) and (((c.path1) in set (dom ls)) and (((c.path2) in set (dom ls)) and ((ls((c.path1)) = <Red>) or (ls((c.path2)) = <Red>))))))\<close>
\<comment>\<open>in 'traffic' (./src/test/resources/Examples/Traffic/traffic.vdmsl) at line 27:3\<close>
record Kernel = 
	lights\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l :: "(Path \<rightharpoonup> Light)"
		 
		 conflicts\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l :: "Conflict VDMSet"
	

\<comment>\<open>VDM source: inv_Kernel: (Kernel +> bool)
	inv_Kernel(mk_Kernel(ls, cs)) ==
(forall c in set cs & ((mk_Conflict((c.path2), (c.path1)) in set cs) and (((c.path1) in set (dom ls)) and (((c.path2) in set (dom ls)) and ((ls((c.path1)) = <Red>) or (ls((c.path2)) = <Red>))))))\<close>
\<comment>\<open>in 'traffic' (./src/test/resources/Examples/Traffic/traffic.vdmsl) at line 29:7\<close>
definition
	inv_Kernel :: "Kernel \<Rightarrow> bool"
where
	"inv_Kernel dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_Kernel` specification.\<close>
		( (((inv_Map (inv_Path) (inv_Light) (lights\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l dummy0))) \<and> 
		 ((inv_VDMSet' inv_Conflict  (conflicts\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l dummy0))) ))  \<and> 
		\<comment>\<open>Implicit pattern context conversion\<close>
		(let ls = (lights\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l dummy0); cs = (conflicts\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l dummy0) in 
		\<comment>\<open>User defined body of inv_Kernel.\<close>
		(\<forall> c \<in> cs  . ((\<lparr>path1\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t = (path2\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t c), path2\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t = (path1\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t c)\<rparr> \<in> cs) \<and> (((path1\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t c) \<in> (dom ls)) \<and> (((path2\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t c) \<in> (dom ls)) \<and> ((((the(ls (path1\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t c)))) = Light.U_Red ) \<or> (((the(ls (path2\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t c)))) = Light.U_Red )))))))"
 
lemmas inv_Kernel_defs = inv_Conflict_def inv_Kernel_def inv_Light_def inv_Map_def inv_Map_defs inv_Path_def inv_True_def inv_VDMChar_def inv_VDMSeq'_def inv_VDMSeq'_defs inv_VDMSet'_def inv_VDMSet'_defs inv_VDMToken'_def 


	
	
\<comment>\<open>VDM source: P1:Path = mk_token("A1North")\<close>
\<comment>\<open>in 'traffic' (./src/test/resources/Examples/Traffic/traffic.vdmsl) at line 41:3\<close>
abbreviation
	P1 :: "Path"
where
	"P1 \<equiv> (Token (''A1North''))"

	definition
	inv_P1 :: "\<bool>"
where
	"inv_P1  \<equiv> ((inv_VDMToken' (inv_VDMSeq' (inv_VDMChar))))P1"

	
	
	
\<comment>\<open>VDM source: P2:Path = mk_token("A1South")\<close>
\<comment>\<open>in 'traffic' (./src/test/resources/Examples/Traffic/traffic.vdmsl) at line 43:3\<close>
abbreviation
	P2 :: "Path"
where
	"P2 \<equiv> (Token (''A1South''))"

	definition
	inv_P2 :: "\<bool>"
where
	"inv_P2  \<equiv> ((inv_VDMToken' (inv_VDMSeq' (inv_VDMChar))))P2"

	
	
	
\<comment>\<open>VDM source: P3:Path = mk_token("A66East")\<close>
\<comment>\<open>in 'traffic' (./src/test/resources/Examples/Traffic/traffic.vdmsl) at line 45:3\<close>
abbreviation
	P3 :: "Path"
where
	"P3 \<equiv> (Token (''A66East''))"

	definition
	inv_P3 :: "\<bool>"
where
	"inv_P3  \<equiv> ((inv_VDMToken' (inv_VDMSeq' (inv_VDMChar))))P3"

	
	
	
\<comment>\<open>VDM source: P4:Path = mk_token("A66West")\<close>
\<comment>\<open>in 'traffic' (./src/test/resources/Examples/Traffic/traffic.vdmsl) at line 47:3\<close>
abbreviation
	P4 :: "Path"
where
	"P4 \<equiv> (Token (''A66West''))"

	definition
	inv_P4 :: "\<bool>"
where
	"inv_P4  \<equiv> ((inv_VDMToken' (inv_VDMSeq' (inv_VDMChar))))P4"

	
	
	
\<comment>\<open>VDM source: LIGHTS:map (Path) to (Light) = {P1 |-> <Red>, P2 |-> <Red>, P3 |-> <Green>, P4 |-> <Green>}\<close>
\<comment>\<open>in 'traffic' (./src/test/resources/Examples/Traffic/traffic.vdmsl) at line 61:3\<close>
abbreviation
	LIGHTS :: "(Path \<rightharpoonup> Light)"
where
	"LIGHTS \<equiv> [P1\<mapsto>Light.U_Red ,P2\<mapsto>Light.U_Red ,P3\<mapsto>Light.U_Green ,P4\<mapsto>Light.U_Green ]"

	definition
	inv_LIGHTS :: "\<bool>"
where
	"inv_LIGHTS  \<equiv> (inv_Map ((inv_VDMToken' (inv_VDMSeq' (inv_VDMChar)))) ((inv_Light )) LIGHTS)"

	
	
	
\<comment>\<open>VDM source: CONFLICTS:set of (Conflict) = {mk_Conflict(P1, P3), mk_Conflict(P1, P4), mk_Conflict(P2, P3), mk_Conflict(P2, P4), mk_Conflict(P3, P1), mk_Conflict(P4, P1), mk_Conflict(P3, P2), mk_Conflict(P4, P2)}\<close>
\<comment>\<open>in 'traffic' (./src/test/resources/Examples/Traffic/traffic.vdmsl) at line 67:3\<close>
abbreviation
	CONFLICTS :: "Conflict VDMSet"
where
	"CONFLICTS \<equiv> {\<lparr>path1\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t = P1, path2\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t = P3\<rparr> , \<lparr>path1\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t = P1, path2\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t = P4\<rparr> , \<lparr>path1\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t = P2, path2\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t = P3\<rparr> , \<lparr>path1\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t = P2, path2\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t = P4\<rparr> , \<lparr>path1\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t = P3, path2\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t = P1\<rparr> , \<lparr>path1\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t = P4, path2\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t = P1\<rparr> , \<lparr>path1\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t = P3, path2\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t = P2\<rparr> , \<lparr>path1\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t = P4, path2\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t = P2\<rparr>}"

	definition
	inv_CONFLICTS :: "\<bool>"
where
	"inv_CONFLICTS  \<equiv> (inv_VDMSet' inv_Conflict  CONFLICTS)"

	
	
	
\<comment>\<open>VDM source: KERNEL:Kernel = mk_Kernel(LIGHTS, CONFLICTS)\<close>
\<comment>\<open>in 'traffic' (./src/test/resources/Examples/Traffic/traffic.vdmsl) at line 77:3\<close>
abbreviation
	KERNEL :: "Kernel"
where
	"KERNEL \<equiv> \<lparr>lights\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l = LIGHTS, conflicts\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l = CONFLICTS\<rparr>"

	definition
	inv_KERNEL :: "\<bool>"
where
	"inv_KERNEL  \<equiv> inv_Kernel KERNEL"

	
	
	
\<comment>\<open>VDM source: ChgLight: (map (Path) to (Light) * Path * Light -> map (Path) to (Light))
	ChgLight(lights, p, colour) ==
(lights ++ {p |-> colour})\<close>
\<comment>\<open>in 'traffic' (./src/test/resources/Examples/Traffic/traffic.vdmsl) at line 83:3\<close>

\<comment>\<open>VDM source: pre_ChgLight: (map (Path) to (Light) * Path * Light +> bool)
	pre_ChgLight(lights, p, colour) ==
null\<close>
\<comment>\<open>in 'traffic' (./src/test/resources/Examples/Traffic/traffic.vdmsl) at line 83:3\<close>
definition
	pre_ChgLight :: "(Path \<rightharpoonup> Light) \<Rightarrow> Path \<Rightarrow> Light \<Rightarrow> bool"
where
	"pre_ChgLight lights   p   colour \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_ChgLight` specification.\<close>
		((inv_Map (inv_Path) (inv_Light) lights)  \<and>  (inv_Path p)  \<and>  (inv_Light colour))"


\<comment>\<open>VDM source: post_ChgLight: (map (Path) to (Light) * Path * Light * map (Path) to (Light) +> bool)
	post_ChgLight(lights, p, colour, RESULT) ==
null\<close>
\<comment>\<open>in 'traffic' (./src/test/resources/Examples/Traffic/traffic.vdmsl) at line 83:3\<close>
definition
	post_ChgLight :: "(Path \<rightharpoonup> Light) \<Rightarrow> Path \<Rightarrow> Light \<Rightarrow> (Path \<rightharpoonup> Light) \<Rightarrow> bool"
where
	"post_ChgLight lights   p   colour   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_ChgLight` specification.\<close>
		((inv_Map (inv_Path) (inv_Light) lights)  \<and>  (inv_Path p)  \<and>  (inv_Light colour)  \<and>  (inv_Map (inv_Path) (inv_Light) RESULT))"

definition
	ChgLight :: "(Path \<rightharpoonup> Light) \<Rightarrow> Path \<Rightarrow> Light \<Rightarrow> (Path \<rightharpoonup> Light)"
where
	"ChgLight lights   p   colour \<equiv> 
	\<comment>\<open>User defined body of ChgLight.\<close>
	(
	\<comment>\<open>Implicit union type parameters projection\<close>
	((lights \<dagger> [p\<mapsto>colour])))"

	
	
\<comment>\<open>VDM source: ToGreen: (Path * Kernel -> Kernel)
	ToGreen(p, mk_Kernel(lights, conflicts)) ==
mk_Kernel(ChgLight(lights, p, <Green>), conflicts)
	pre ((p in set (dom lights)) and ((lights(p) = <Red>) and (forall mk_Conflict(p1, p2) in set conflicts & ((p = p1) => (lights(p2) = <Red>)))))\<close>
\<comment>\<open>in 'traffic' (./src/test/resources/Examples/Traffic/traffic.vdmsl) at line 87:3\<close>

\<comment>\<open>VDM source: pre_ToGreen: (Path * Kernel +> bool)
	pre_ToGreen(p, mk_Kernel(lights, conflicts)) ==
((p in set (dom lights)) and ((lights(p) = <Red>) and (forall mk_Conflict(p1, p2) in set conflicts & ((p = p1) => (lights(p2) = <Red>)))))\<close>
\<comment>\<open>in 'traffic' (./src/test/resources/Examples/Traffic/traffic.vdmsl) at line 90:27\<close>
definition
	pre_ToGreen :: "Path \<Rightarrow> Kernel \<Rightarrow> bool"
where
	"pre_ToGreen p   dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_ToGreen` specification.\<close>
		((inv_Path p)  \<and>  inv_Kernel dummy0)  \<and> 
		\<comment>\<open>Implicit pattern context conversion\<close>
		(let lights = (lights\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l dummy0); conflicts = (conflicts\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l dummy0) in 
		\<comment>\<open>User defined body of pre_ToGreen.\<close>
		((p \<in> (dom lights)) \<and> ((((the(lights p))) = Light.U_Red ) \<and> (\<forall> dummy0 \<in> conflicts  . (let p1 = (path1\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t dummy0); p2 = (path2\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t dummy0) in ((p = p1) \<longrightarrow> (((the(lights p2))) = Light.U_Red )))))))"


\<comment>\<open>VDM source: post_ToGreen: (Path * Kernel * Kernel +> bool)
	post_ToGreen(p, mk_Kernel(lights, conflicts), RESULT) ==
null\<close>
\<comment>\<open>in 'traffic' (./src/test/resources/Examples/Traffic/traffic.vdmsl) at line 87:3\<close>
definition
	post_ToGreen :: "Path \<Rightarrow> Kernel \<Rightarrow> Kernel \<Rightarrow> bool"
where
	"post_ToGreen p   dummy0   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_ToGreen` specification.\<close>
		((inv_Path p)  \<and>  inv_Kernel dummy0  \<and>  inv_Kernel RESULT)"

definition
	ToGreen :: "Path \<Rightarrow> Kernel \<Rightarrow> Kernel"
where
	"ToGreen p   dummy0 \<equiv> 
	\<comment>\<open>Implicit pattern context conversion\<close>
	(let lights = (lights\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l dummy0); conflicts = (conflicts\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l dummy0) in 
	\<comment>\<open>User defined body of ToGreen.\<close>
	\<lparr>lights\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l = (ChgLight lights   p   Light.U_Green ), conflicts\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l = conflicts\<rparr>)"

	
	
\<comment>\<open>VDM source: ToRed: (Path * Kernel -> Kernel)
	ToRed(p, mk_Kernel(lights, conflicts)) ==
mk_Kernel(ChgLight(lights, p, <Red>), conflicts)
	pre ((p in set (dom lights)) and (lights(p) = <Amber>))\<close>
\<comment>\<open>in 'traffic' (./src/test/resources/Examples/Traffic/traffic.vdmsl) at line 97:3\<close>

\<comment>\<open>VDM source: pre_ToRed: (Path * Kernel +> bool)
	pre_ToRed(p, mk_Kernel(lights, conflicts)) ==
((p in set (dom lights)) and (lights(p) = <Amber>))\<close>
\<comment>\<open>in 'traffic' (./src/test/resources/Examples/Traffic/traffic.vdmsl) at line 100:27\<close>
definition
	pre_ToRed :: "Path \<Rightarrow> Kernel \<Rightarrow> bool"
where
	"pre_ToRed p   dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_ToRed` specification.\<close>
		((inv_Path p)  \<and>  inv_Kernel dummy0)  \<and> 
		\<comment>\<open>Implicit pattern context conversion\<close>
		(let lights = (lights\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l dummy0); conflicts = (conflicts\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l dummy0) in 
		\<comment>\<open>User defined body of pre_ToRed.\<close>
		((p \<in> (dom lights)) \<and> (((the(lights p))) = Light.U_Amber )))"


\<comment>\<open>VDM source: post_ToRed: (Path * Kernel * Kernel +> bool)
	post_ToRed(p, mk_Kernel(lights, conflicts), RESULT) ==
null\<close>
\<comment>\<open>in 'traffic' (./src/test/resources/Examples/Traffic/traffic.vdmsl) at line 97:3\<close>
definition
	post_ToRed :: "Path \<Rightarrow> Kernel \<Rightarrow> Kernel \<Rightarrow> bool"
where
	"post_ToRed p   dummy0   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_ToRed` specification.\<close>
		((inv_Path p)  \<and>  inv_Kernel dummy0  \<and>  inv_Kernel RESULT)"

definition
	ToRed :: "Path \<Rightarrow> Kernel \<Rightarrow> Kernel"
where
	"ToRed p   dummy0 \<equiv> 
	\<comment>\<open>Implicit pattern context conversion\<close>
	(let lights = (lights\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l dummy0); conflicts = (conflicts\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l dummy0) in 
	\<comment>\<open>User defined body of ToRed.\<close>
	\<lparr>lights\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l = (ChgLight lights   p   Light.U_Red ), conflicts\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l = conflicts\<rparr>)"

	
	
\<comment>\<open>VDM source: ToAmber: (Path * Kernel -> Kernel)
	ToAmber(p, mk_Kernel(lights, conflicts)) ==
mk_Kernel(ChgLight(lights, p, <Amber>), conflicts)
	pre ((p in set (dom lights)) and (lights(p) = <Green>))\<close>
\<comment>\<open>in 'traffic' (./src/test/resources/Examples/Traffic/traffic.vdmsl) at line 104:3\<close>

\<comment>\<open>VDM source: pre_ToAmber: (Path * Kernel +> bool)
	pre_ToAmber(p, mk_Kernel(lights, conflicts)) ==
((p in set (dom lights)) and (lights(p) = <Green>))\<close>
\<comment>\<open>in 'traffic' (./src/test/resources/Examples/Traffic/traffic.vdmsl) at line 107:27\<close>
definition
	pre_ToAmber :: "Path \<Rightarrow> Kernel \<Rightarrow> bool"
where
	"pre_ToAmber p   dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_ToAmber` specification.\<close>
		((inv_Path p)  \<and>  inv_Kernel dummy0)  \<and> 
		\<comment>\<open>Implicit pattern context conversion\<close>
		(let lights = (lights\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l dummy0); conflicts = (conflicts\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l dummy0) in 
		\<comment>\<open>User defined body of pre_ToAmber.\<close>
		((p \<in> (dom lights)) \<and> (((the(lights p))) = Light.U_Green )))"


\<comment>\<open>VDM source: post_ToAmber: (Path * Kernel * Kernel +> bool)
	post_ToAmber(p, mk_Kernel(lights, conflicts), RESULT) ==
null\<close>
\<comment>\<open>in 'traffic' (./src/test/resources/Examples/Traffic/traffic.vdmsl) at line 104:3\<close>
definition
	post_ToAmber :: "Path \<Rightarrow> Kernel \<Rightarrow> Kernel \<Rightarrow> bool"
where
	"post_ToAmber p   dummy0   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_ToAmber` specification.\<close>
		((inv_Path p)  \<and>  inv_Kernel dummy0  \<and>  inv_Kernel RESULT)"

definition
	ToAmber :: "Path \<Rightarrow> Kernel \<Rightarrow> Kernel"
where
	"ToAmber p   dummy0 \<equiv> 
	\<comment>\<open>Implicit pattern context conversion\<close>
	(let lights = (lights\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l dummy0); conflicts = (conflicts\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l dummy0) in 
	\<comment>\<open>User defined body of ToAmber.\<close>
	\<lparr>lights\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l = (ChgLight lights   p   Light.U_Amber ), conflicts\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l = conflicts\<rparr>)"

end