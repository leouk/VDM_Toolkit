(* VDM to Isabelle Translation @2021-12-21T07:27:59.430295Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2ITypesOrdering.vdmsl' at line 1:8
files = [./src/test/resources/TestV2ITypesOrdering.vdmsl]
*)
theory TestV2ITypesOrdering
imports "VDMToolkit" 
begin


\<comment>\<open>VDM source: TOrder1 = nat1
	inv oI == (oI > 1)
	eq o1 = o2 == (o1 = o2)
	ord o1 < o2 == (o1 > o2)\<close>
\<comment>\<open>in 'TestV2ITypesOrdering' (./src/test/resources/TestV2ITypesOrdering.vdmsl) at line 7:5\<close>
type_synonym TOrder1 = "VDMNat1"
	

\<comment>\<open>VDM source: inv_TOrder1: (nat1 +> bool)
	inv_TOrder1(oI) ==
(oI > 1)\<close>
\<comment>\<open>in 'TestV2ITypesOrdering' (./src/test/resources/TestV2ITypesOrdering.vdmsl) at line 8:9\<close>
definition
	inv_TOrder1 :: "TOrder1 \<Rightarrow> bool"
where
	"inv_TOrder1 oI \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_TOrder1` specification.\<close>
		(((inv_VDMNat1 oI)))  \<and> 
		\<comment>\<open>User defined body of inv_TOrder1.\<close>
		(oI > (1::VDMNat1))"
 

\<comment>\<open>VDM source: eq_TOrder1: (nat1 * nat1 +> bool)
	eq_TOrder1(o1, o2) ==
(o1 = o2)\<close>
\<comment>\<open>in 'TestV2ITypesOrdering' (./src/test/resources/TestV2ITypesOrdering.vdmsl) at line 10:8\<close>
definition
	eq_TOrder1 :: "TOrder1\<Rightarrow> TOrder1 \<Rightarrow> bool"
where
	"eq_TOrder1 o1  o2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `eq_TOrder1` specification.\<close>
		((inv_TOrder1 o1)  \<and>  (inv_TOrder1 o2))  \<and> 
		\<comment>\<open>User defined body of eq_TOrder1.\<close>
		(o1 = o2)"
 

\<comment>\<open>VDM source: ord_TOrder1: (nat1 * nat1 +> bool)
	ord_TOrder1(o1, o2) ==
(o1 > o2)\<close>
\<comment>\<open>in 'TestV2ITypesOrdering' (./src/test/resources/TestV2ITypesOrdering.vdmsl) at line 9:9\<close>
definition
	ord_TOrder1 :: "TOrder1\<Rightarrow> TOrder1 \<Rightarrow> bool"
where
	"ord_TOrder1 o1  o2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `ord_TOrder1` specification.\<close>
		((inv_TOrder1 o1)  \<and>  (inv_TOrder1 o2))  \<and> 
		\<comment>\<open>User defined body of ord_TOrder1.\<close>
		(o1 > o2)"
 

\<comment>\<open>VDM source: min_TOrder1: (TOrder1 * TOrder1 +> TOrder1)
	min_TOrder1(a, b) ==
(if ((a < b) or (a = b))
then a
else b)\<close>
\<comment>\<open>in 'TestV2ITypesOrdering' (./src/test/resources/TestV2ITypesOrdering.vdmsl) at line 9:9\<close>
definition
	min_TOrder1 :: "TOrder1\<Rightarrow> TOrder1 \<Rightarrow> TOrder1"
where
	"min_TOrder1 a  b \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `min_TOrder1` specification.\<close>
		(if ((inv_TOrder1 a)  \<and>  (inv_TOrder1 b)) then
			
		\<comment>\<open>User defined body of min_TOrder1.\<close>
		(
		if (((ord_TOrder1 a  b) \<or> (eq_TOrder1 a  b))) then
		(a)
		else
		(b))
			else
			undefined)"

	

\<comment>\<open>VDM source: max_TOrder1: (TOrder1 * TOrder1 +> TOrder1)
	max_TOrder1(a, b) ==
(if ((a < b) or (a = b))
then b
else a)\<close>
\<comment>\<open>in 'TestV2ITypesOrdering' (./src/test/resources/TestV2ITypesOrdering.vdmsl) at line 9:9\<close>
definition
	max_TOrder1 :: "TOrder1\<Rightarrow> TOrder1 \<Rightarrow> TOrder1"
where
	"max_TOrder1 a  b \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `max_TOrder1` specification.\<close>
		(if ((inv_TOrder1 a)  \<and>  (inv_TOrder1 b)) then
			
		\<comment>\<open>User defined body of max_TOrder1.\<close>
		(
		if (((ord_TOrder1 a  b) \<or> (eq_TOrder1 a  b))) then
		(b)
		else
		(a))
			else
			undefined)"

	

	
\<comment>\<open>VDM source: TRenamed = TOrder1
	inv r == (r > 10)\<close>
\<comment>\<open>in 'TestV2ITypesOrdering' (./src/test/resources/TestV2ITypesOrdering.vdmsl) at line 12:5\<close>
type_synonym TRenamed = "TOrder1"
	

\<comment>\<open>VDM source: inv_TRenamed: (TOrder1 +> bool)
	inv_TRenamed(r) ==
(r > 10)\<close>
\<comment>\<open>in 'TestV2ITypesOrdering' (./src/test/resources/TestV2ITypesOrdering.vdmsl) at line 13:9\<close>
definition
	inv_TRenamed :: "TRenamed \<Rightarrow> bool"
where
	"inv_TRenamed r \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_TRenamed` specification.\<close>
		((inv_TOrder1 r))  \<and> 
		\<comment>\<open>User defined body of inv_TRenamed.\<close>
		(ord_TOrder1 (10::VDMNat1)  r)"

		 

	
\<comment>\<open>VDM source: TRenamedOrdered = TOrder1
	eq o1 = o2 == (o1 = o2)
	ord o1 < o2 == (o1 < o2)\<close>
\<comment>\<open>in 'TestV2ITypesOrdering' (./src/test/resources/TestV2ITypesOrdering.vdmsl) at line 15:5\<close>
type_synonym TRenamedOrdered = "TOrder1"
	

\<comment>\<open>VDM source: inv_TRenamedOrdered: (TRenamedOrdered +> bool)
	inv_TRenamedOrdered(dummy0) ==
null\<close>
\<comment>\<open>in 'TestV2ITypesOrdering' (./src/test/resources/TestV2ITypesOrdering.vdmsl) at line 15:5\<close>
definition
	inv_TRenamedOrdered :: "TRenamedOrdered \<Rightarrow> bool"
where
	"inv_TRenamedOrdered dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_TRenamedOrdered` specification.\<close>
		((inv_TOrder1 dummy0))"

		 

\<comment>\<open>VDM source: eq_TRenamedOrdered: (TOrder1 * TOrder1 +> bool)
	eq_TRenamedOrdered(o1, o2) ==
(o1 = o2)\<close>
\<comment>\<open>in 'TestV2ITypesOrdering' (./src/test/resources/TestV2ITypesOrdering.vdmsl) at line 17:8\<close>
definition
	eq_TRenamedOrdered :: "TRenamedOrdered\<Rightarrow> TRenamedOrdered \<Rightarrow> bool"
where
	"eq_TRenamedOrdered o1  o2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `eq_TRenamedOrdered` specification.\<close>
		((inv_TRenamedOrdered o1)  \<and>  (inv_TRenamedOrdered o2))  \<and> 
		\<comment>\<open>User defined body of eq_TRenamedOrdered.\<close>
		(eq_TOrder1 o1  o2)"

		 

\<comment>\<open>VDM source: ord_TRenamedOrdered: (TOrder1 * TOrder1 +> bool)
	ord_TRenamedOrdered(o1, o2) ==
(o1 < o2)\<close>
\<comment>\<open>in 'TestV2ITypesOrdering' (./src/test/resources/TestV2ITypesOrdering.vdmsl) at line 16:9\<close>
definition
	ord_TRenamedOrdered :: "TRenamedOrdered\<Rightarrow> TRenamedOrdered \<Rightarrow> bool"
where
	"ord_TRenamedOrdered o1  o2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `ord_TRenamedOrdered` specification.\<close>
		((inv_TRenamedOrdered o1)  \<and>  (inv_TRenamedOrdered o2))  \<and> 
		\<comment>\<open>User defined body of ord_TRenamedOrdered.\<close>
		(ord_TOrder1 o1  o2)"

		 

\<comment>\<open>VDM source: min_TRenamedOrdered: (TRenamedOrdered * TRenamedOrdered +> TRenamedOrdered)
	min_TRenamedOrdered(a, b) ==
(if ((a < b) or (a = b))
then a
else b)\<close>
\<comment>\<open>in 'TestV2ITypesOrdering' (./src/test/resources/TestV2ITypesOrdering.vdmsl) at line 16:9\<close>
definition
	min_TRenamedOrdered :: "TRenamedOrdered\<Rightarrow> TRenamedOrdered \<Rightarrow> TRenamedOrdered"
where
	"min_TRenamedOrdered a  b \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `min_TRenamedOrdered` specification.\<close>
		(if ((inv_TRenamedOrdered a)  \<and>  (inv_TRenamedOrdered b)) then
			
		\<comment>\<open>User defined body of min_TRenamedOrdered.\<close>
		(
		if (((ord_TRenamedOrdered a  b) \<or> (eq_TRenamedOrdered a  b))) then
		(a)
		else
		(b))
			else
			undefined)"

	

\<comment>\<open>VDM source: max_TRenamedOrdered: (TRenamedOrdered * TRenamedOrdered +> TRenamedOrdered)
	max_TRenamedOrdered(a, b) ==
(if ((a < b) or (a = b))
then b
else a)\<close>
\<comment>\<open>in 'TestV2ITypesOrdering' (./src/test/resources/TestV2ITypesOrdering.vdmsl) at line 16:9\<close>
definition
	max_TRenamedOrdered :: "TRenamedOrdered\<Rightarrow> TRenamedOrdered \<Rightarrow> TRenamedOrdered"
where
	"max_TRenamedOrdered a  b \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `max_TRenamedOrdered` specification.\<close>
		(if ((inv_TRenamedOrdered a)  \<and>  (inv_TRenamedOrdered b)) then
			
		\<comment>\<open>User defined body of max_TRenamedOrdered.\<close>
		(
		if (((ord_TRenamedOrdered a  b) \<or> (eq_TRenamedOrdered a  b))) then
		(b)
		else
		(a))
			else
			undefined)"

	

	
\<comment>\<open>VDM source: TRenamedPOrdered = TOrder1
	ord o1 < o2 == (o1 > o2)\<close>
\<comment>\<open>in 'TestV2ITypesOrdering' (./src/test/resources/TestV2ITypesOrdering.vdmsl) at line 19:5\<close>
type_synonym TRenamedPOrdered = "TOrder1"
	

\<comment>\<open>VDM source: inv_TRenamedPOrdered: (TRenamedPOrdered +> bool)
	inv_TRenamedPOrdered(dummy0) ==
null\<close>
\<comment>\<open>in 'TestV2ITypesOrdering' (./src/test/resources/TestV2ITypesOrdering.vdmsl) at line 19:5\<close>
definition
	inv_TRenamedPOrdered :: "TRenamedPOrdered \<Rightarrow> bool"
where
	"inv_TRenamedPOrdered dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_TRenamedPOrdered` specification.\<close>
		((inv_TOrder1 dummy0))"

		 

\<comment>\<open>VDM source: ord_TRenamedPOrdered: (TOrder1 * TOrder1 +> bool)
	ord_TRenamedPOrdered(o1, o2) ==
(o1 > o2)\<close>
\<comment>\<open>in 'TestV2ITypesOrdering' (./src/test/resources/TestV2ITypesOrdering.vdmsl) at line 20:9\<close>
definition
	ord_TRenamedPOrdered :: "TRenamedPOrdered\<Rightarrow> TRenamedPOrdered \<Rightarrow> bool"
where
	"ord_TRenamedPOrdered o1  o2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `ord_TRenamedPOrdered` specification.\<close>
		((inv_TRenamedPOrdered o1)  \<and>  (inv_TRenamedPOrdered o2))  \<and> 
		\<comment>\<open>User defined body of ord_TRenamedPOrdered.\<close>
		(ord_TOrder1 o2  o1)"

		 

\<comment>\<open>VDM source: min_TRenamedPOrdered: (TRenamedPOrdered * TRenamedPOrdered +> TRenamedPOrdered)
	min_TRenamedPOrdered(a, b) ==
(if ((a < b) or (a = b))
then a
else b)\<close>
\<comment>\<open>in 'TestV2ITypesOrdering' (./src/test/resources/TestV2ITypesOrdering.vdmsl) at line 20:9\<close>
definition
	min_TRenamedPOrdered :: "TRenamedPOrdered\<Rightarrow> TRenamedPOrdered \<Rightarrow> TRenamedPOrdered"
where
	"min_TRenamedPOrdered a  b \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `min_TRenamedPOrdered` specification.\<close>
		(if ((inv_TRenamedPOrdered a)  \<and>  (inv_TRenamedPOrdered b)) then
			
		\<comment>\<open>User defined body of min_TRenamedPOrdered.\<close>
		(
		if (((ord_TRenamedPOrdered a  b) \<or> (a = b))) then
		(a)
		else
		(b))
			else
			undefined)"

	

\<comment>\<open>VDM source: max_TRenamedPOrdered: (TRenamedPOrdered * TRenamedPOrdered +> TRenamedPOrdered)
	max_TRenamedPOrdered(a, b) ==
(if ((a < b) or (a = b))
then b
else a)\<close>
\<comment>\<open>in 'TestV2ITypesOrdering' (./src/test/resources/TestV2ITypesOrdering.vdmsl) at line 20:9\<close>
definition
	max_TRenamedPOrdered :: "TRenamedPOrdered\<Rightarrow> TRenamedPOrdered \<Rightarrow> TRenamedPOrdered"
where
	"max_TRenamedPOrdered a  b \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `max_TRenamedPOrdered` specification.\<close>
		(if ((inv_TRenamedPOrdered a)  \<and>  (inv_TRenamedPOrdered b)) then
			
		\<comment>\<open>User defined body of max_TRenamedPOrdered.\<close>
		(
		if (((ord_TRenamedPOrdered a  b) \<or> (a = b))) then
		(b)
		else
		(a))
			else
			undefined)"

	

end