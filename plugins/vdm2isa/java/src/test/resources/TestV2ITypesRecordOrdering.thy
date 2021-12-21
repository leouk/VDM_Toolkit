(* VDM to Isabelle Translation @2021-12-21T07:54:20.229866Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2ITypesRecordOrdering.vdmsl' at line 1:8
files = [./src/test/resources/TestV2ITypesRecordOrdering.vdmsl]
*)
theory TestV2ITypesRecordOrdering
imports "VDMToolkit" 
begin


\<comment>\<open>VDM source: Time = compose Time of r:real, i:nat end
	inv mk_Time(r, -) == (r >= 0)
	eq a = b == (((a.r) = (b.r)) and ((a.i) = (b.i)))
	ord a < b == (((a.r) < (b.r)) or (((a.r) = (b.r)) and ((a.i) < (b.i))))\<close>
\<comment>\<open>in 'TestV2ITypesRecordOrdering' (./src/test/resources/TestV2ITypesRecordOrdering.vdmsl) at line 7:5\<close>
record Time = 
	r\<^sub>T\<^sub>i\<^sub>m\<^sub>e :: "VDMReal"
		 i\<^sub>T\<^sub>i\<^sub>m\<^sub>e :: "VDMNat"
	

\<comment>\<open>VDM source: inv_Time: (Time +> bool)
	inv_Time(mk_Time(r, -)) ==
(r >= 0)\<close>
\<comment>\<open>in 'TestV2ITypesRecordOrdering' (./src/test/resources/TestV2ITypesRecordOrdering.vdmsl) at line 10:9\<close>
definition
	inv_Time :: "Time \<Rightarrow> bool"
where
	"inv_Time dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_Time` specification.\<close>
		( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e dummy0))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e dummy0))) ))  \<and> 
		\<comment>\<open>Implicit pattern context conversion\<close>
		(let r = (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e dummy0); dummy0_ignore = (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e dummy0) in 
		\<comment>\<open>User defined body of inv_Time.\<close>
		(r \<ge> (0::VDMNat)))"
 

\<comment>\<open>VDM source: eq_Time: (Time * Time +> bool)
	eq_Time(a, b) ==
(((a.r) = (b.r)) and ((a.i) = (b.i)))\<close>
\<comment>\<open>in 'TestV2ITypesRecordOrdering' (./src/test/resources/TestV2ITypesRecordOrdering.vdmsl) at line 11:8\<close>
definition
	eq_Time :: "Time\<Rightarrow> Time \<Rightarrow> bool"
where
	"eq_Time a  b \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `eq_Time` specification.\<close>
		(inv_Time a  \<and>  inv_Time b)  \<and> 
		\<comment>\<open>User defined body of eq_Time.\<close>
		(((r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (a)) = (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (b))) \<and> ((i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (a)) = (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (b))))"
 

\<comment>\<open>VDM source: ord_Time: (Time * Time +> bool)
	ord_Time(a, b) ==
(((a.r) < (b.r)) or (((a.r) = (b.r)) and ((a.i) < (b.i))))\<close>
\<comment>\<open>in 'TestV2ITypesRecordOrdering' (./src/test/resources/TestV2ITypesRecordOrdering.vdmsl) at line 12:9\<close>
definition
	ord_Time :: "Time\<Rightarrow> Time \<Rightarrow> bool"
where
	"ord_Time a  b \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `ord_Time` specification.\<close>
		(inv_Time a  \<and>  inv_Time b)  \<and> 
		\<comment>\<open>User defined body of ord_Time.\<close>
		(((r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (a)) < (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (b))) \<or> (((r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (a)) = (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (b))) \<and> ((i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (a)) < (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (b)))))"
 

	
\<comment>\<open>VDM source: User = compose User of time:Time, endtime:Time end\<close>
\<comment>\<open>in 'TestV2ITypesRecordOrdering' (./src/test/resources/TestV2ITypesRecordOrdering.vdmsl) at line 14:5\<close>
record User = 
	time\<^sub>U\<^sub>s\<^sub>e\<^sub>r :: "Time"
		 endtime\<^sub>U\<^sub>s\<^sub>e\<^sub>r :: "Time"
	

\<comment>\<open>VDM source: inv_User: (User +> bool)
	inv_User(dummy0) ==
null\<close>
\<comment>\<open>in 'TestV2ITypesRecordOrdering' (./src/test/resources/TestV2ITypesRecordOrdering.vdmsl) at line 14:5\<close>
definition
	inv_User :: "User \<Rightarrow> bool"
where
	"inv_User dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_User` specification.\<close>
		( ((inv_Time (time\<^sub>U\<^sub>s\<^sub>e\<^sub>r dummy0)) \<and> 
		 (inv_Time (endtime\<^sub>U\<^sub>s\<^sub>e\<^sub>r dummy0)) ))"
 

	
\<comment>\<open>VDM source: f: (Time * Time -> bool)
	f(t1, t2) ==
(t1 >= t2)\<close>
\<comment>\<open>in 'TestV2ITypesRecordOrdering' (./src/test/resources/TestV2ITypesRecordOrdering.vdmsl) at line 19:5\<close>

\<comment>\<open>VDM source: pre_f: (Time * Time +> bool)
	pre_f(t1, t2) ==
null\<close>
\<comment>\<open>in 'TestV2ITypesRecordOrdering' (./src/test/resources/TestV2ITypesRecordOrdering.vdmsl) at line 19:5\<close>
definition
	pre_f :: "Time\<Rightarrow> Time \<Rightarrow> bool"
where
	"pre_f t1  t2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_f` specification.\<close>
		(inv_Time t1  \<and>  inv_Time t2)"


\<comment>\<open>VDM source: post_f: (Time * Time * bool +> bool)
	post_f(t1, t2, RESULT) ==
null\<close>
\<comment>\<open>in 'TestV2ITypesRecordOrdering' (./src/test/resources/TestV2ITypesRecordOrdering.vdmsl) at line 19:5\<close>
definition
	post_f :: "Time\<Rightarrow> Time\<Rightarrow> bool \<Rightarrow> bool"
where
	"post_f t1  t2  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_f` specification.\<close>
		(inv_Time t1  \<and>  inv_Time t2  \<and>  (inv_bool RESULT))"

definition
	f :: "Time\<Rightarrow> Time \<Rightarrow> bool"
where
	"f t1  t2 \<equiv> 
	\<comment>\<open>User defined body of f.\<close>
	\<comment>\<open>Transform a VDM `>` expression into a reversed `ord_Time` call\<close>
	(ord_Time t2  t1) \<or> 
	\<comment>\<open>Transform a VDM `=` expression into an `eq_Time` call\<close>
	(eq_Time t1  t2)"

	
\<comment>\<open>VDM source: g: (User -> bool)
	g(mk_User(bt, et)) ==
(et >= bt)\<close>
\<comment>\<open>in 'TestV2ITypesRecordOrdering' (./src/test/resources/TestV2ITypesRecordOrdering.vdmsl) at line 22:5\<close>

\<comment>\<open>VDM source: pre_g: (User +> bool)
	pre_g(mk_User(bt, et)) ==
null\<close>
\<comment>\<open>in 'TestV2ITypesRecordOrdering' (./src/test/resources/TestV2ITypesRecordOrdering.vdmsl) at line 22:5\<close>
definition
	pre_g :: "User \<Rightarrow> bool"
where
	"pre_g dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_g` specification.\<close>
		(inv_User dummy0)"


\<comment>\<open>VDM source: post_g: (User * bool +> bool)
	post_g(mk_User(bt, et), RESULT) ==
null\<close>
\<comment>\<open>in 'TestV2ITypesRecordOrdering' (./src/test/resources/TestV2ITypesRecordOrdering.vdmsl) at line 22:5\<close>
definition
	post_g :: "User\<Rightarrow> bool \<Rightarrow> bool"
where
	"post_g dummy0  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_g` specification.\<close>
		(inv_User dummy0  \<and>  (inv_bool RESULT))"

definition
	g :: "User \<Rightarrow> bool"
where
	"g dummy0 \<equiv> 
	\<comment>\<open>Implicit pattern context conversion\<close>
	(let bt = (time\<^sub>U\<^sub>s\<^sub>e\<^sub>r dummy0); et = (endtime\<^sub>U\<^sub>s\<^sub>e\<^sub>r dummy0) in 
	\<comment>\<open>User defined body of g.\<close>
	\<comment>\<open>Transform a VDM `>` expression into a reversed `ord_Time` call\<close>
	(ord_Time bt  et) \<or> 
	\<comment>\<open>Transform a VDM `=` expression into an `eq_Time` call\<close>
	(eq_Time et  bt))"

	
\<comment>\<open>VDM source: g': (User -> bool)
	g'(u) ==
((u.endtime) >= (u.time))\<close>
\<comment>\<open>in 'TestV2ITypesRecordOrdering' (./src/test/resources/TestV2ITypesRecordOrdering.vdmsl) at line 25:5\<close>

\<comment>\<open>VDM source: pre_g': (User +> bool)
	pre_g'(u) ==
null\<close>
\<comment>\<open>in 'TestV2ITypesRecordOrdering' (./src/test/resources/TestV2ITypesRecordOrdering.vdmsl) at line 25:5\<close>
definition
	pre_g' :: "User \<Rightarrow> bool"
where
	"pre_g' u \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_g'` specification.\<close>
		(inv_User u)"


\<comment>\<open>VDM source: post_g': (User * bool +> bool)
	post_g'(u, RESULT) ==
null\<close>
\<comment>\<open>in 'TestV2ITypesRecordOrdering' (./src/test/resources/TestV2ITypesRecordOrdering.vdmsl) at line 25:5\<close>
definition
	post_g' :: "User\<Rightarrow> bool \<Rightarrow> bool"
where
	"post_g' u  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_g'` specification.\<close>
		(inv_User u  \<and>  (inv_bool RESULT))"

definition
	g' :: "User \<Rightarrow> bool"
where
	"g' u \<equiv> 
	\<comment>\<open>User defined body of g'.\<close>
	\<comment>\<open>Transform a VDM `>` expression into a reversed `ord_Time` call\<close>
	(ord_Time (time\<^sub>U\<^sub>s\<^sub>e\<^sub>r (u))  (endtime\<^sub>U\<^sub>s\<^sub>e\<^sub>r (u))) \<or> 
	\<comment>\<open>Transform a VDM `=` expression into an `eq_Time` call\<close>
	(eq_Time (endtime\<^sub>U\<^sub>s\<^sub>e\<^sub>r (u))  (time\<^sub>U\<^sub>s\<^sub>e\<^sub>r (u)))"

end