theory UnionTypesStudy
imports VDMToolkit
begin

datatype TUnion5 = Uint "VDMInt" | Ureal "VDMReal"

definition
		inv_TUnion5 :: "TUnion5 => bool"
where
		"inv_TUnion5 u == 
			(case u of
				Uint v  => inv_VDMInt v \<and> v > 0
			|	Ureal v => inv_VDMReal v \<and> v > 0)"  

value "Uint 10"

datatype TUnion4 = Uint "VDMInt" | Unat "VDMNat"

definition
		inv_TUnion4 :: "TUnion4 => bool"
where
		"inv_TUnion4 u == 
			(case u of
				Uint v => (inv_VDMInt v \<and> v < 0)
			|	Unat v => inv_VDMNat v \<and> v > 0)"  

value "Uint 10"
value "Uint 0"
value "Uint (-1)"
value "inv_TUnion4 (Uint 10)"
value "inv_TUnion4 (Uint (-1))"
value "inv_TUnion4 (Uint 0)"
value "inv_TUnion4 (Unat 10)"
value "inv_TUnion4 (Unat (-1))"
value "inv_TUnion4 (Unat 0)"


	
\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 11:5\<close>
datatype TUnion2 = TUnion2_VDMNat_VDMSeq "VDMNat VDMSeq" | 
		 TUnion2_VDMReal_VDMSet "VDMReal VDMSet"
	

\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 11:5\<close>
definition
	inv_TUnion2 :: "TUnion2 \<Rightarrow> \<bool>"
where
	"inv_TUnion2 dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_TUnion2 specification\<close>
		(((case dummy0 of
		 TUnion2_VDMNat_VDMSeq dummy01 \<Rightarrow> (inv_VDMSeq' (inv_VDMNat) dummy01)
		  | TUnion2_VDMReal_VDMSet dummy02 \<Rightarrow> (inv_VDMSet' (inv_VDMReal) dummy02)
		 )))"

		 \<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 11:5\<close>
datatype TUnion2' = TUnion2'_VDMNat_VDMSeq "VDMNat VDMSeq" | 
		 TUnion2'_VDMReal_VDMSeq "VDMReal VDMSeq"
	

\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 11:5\<close>
definition
	inv_TUnion2' :: "TUnion2' \<Rightarrow> \<bool>"
where
	"inv_TUnion2' dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_TUnion2 specification\<close>
		(((case dummy0 of
		 TUnion2'_VDMNat_VDMSeq dummy01 \<Rightarrow> (inv_VDMSeq' (inv_VDMNat) dummy01)
		  | TUnion2'_VDMReal_VDMSeq dummy02 \<Rightarrow> (inv_VDMSeq' (inv_VDMReal) dummy02)
		 )))"

	
\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 31:5\<close>
datatype TUnion6 = U_VDMInt "VDMInt"
	

\<comment>\<open>in 'TestV2ITypesUnion' (./src/test/resources/TestV2ITypesUnion.vdmsl) at line 32:9\<close>
definition
	inv_TUnion6 :: "TUnion6 \<Rightarrow> \<bool>"
where
	"inv_TUnion6 u \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_TUnion6 specification\<close>
		(((case u of
		 U_VDMInt u1 \<Rightarrow> (inv_VDMInt u1)
		 )))  \<and> 
		\<comment>\<open>User defined body of inv_TUnion6\<close>
    (case u of 
      U_VDMInt u1 \<Rightarrow>
		((isTest (u1) inv_VDMInt \<longrightarrow> (u1 < (0::VDMNat))) \<and> (isTest (u1) inv_VDMNat \<longrightarrow> (u1 > (0::VDMNat)))))"

(* f3(u6) == u6 > 10 *)
definition 
  f3 :: "TUnion6 \<Rightarrow> \<bool>"
  where
  "f3 u6 \<equiv> 
    (case u6 of U_VDMInt u6 \<Rightarrow> u6 > 10)"

value "f3 (U_VDMInt 20)"

definition 
  f3' :: "TUnion2 \<Rightarrow> \<bool>"
  where
  "f3' u2 \<equiv> 
    (case u2 of 
        TUnion2_VDMNat_VDMSeq u2 \<Rightarrow> vdm_card (elems u2) = len u2 
      | TUnion2_VDMReal_VDMSet u2 \<Rightarrow> vdm_card u2 > 0)"

definition
  f2 :: "TUnion6 \<Rightarrow> TUnion2 \<Rightarrow> \<bool>"
  where
  "f2 u6 u2 \<equiv> 
    (case u6 of 
      U_VDMInt u61 \<Rightarrow>
        (case u2 of
           TUnion2_VDMNat_VDMSeq u21 \<Rightarrow> 
              isTest u61 inv_VDMInt \<longrightarrow> 
                  (isTest u21 (inv_VDMSeq' inv_VDMNat) \<longrightarrow> u61 \<in> elems u21)
                  \<and>
                  (isTest u21 (inv_VDMSet' inv_VDMReal) \<longrightarrow> u61 \<in> u21)
                  \<and>
              isTest u61 inv_VDMNat \<longrightarrow> 
                  (isTest u21 (inv_VDMSeq' inv_VDMNat) \<longrightarrow> u61 \<notin> elems u21)
                  \<and>
                  (isTest u21 (inv_VDMSet' inv_VDMReal) \<longrightarrow> u61 \<notin> u21)
         | TUnion2_VDMReal_VDMSet u22 \<Rightarrow> 
              isTest u61 inv_VDMInt \<longrightarrow> 
                  (isTest u22 (inv_VDMSeq' inv_VDMNat) \<longrightarrow> u61 \<in> elems u22)
                  \<and>
                  (isTest u22 (inv_VDMSet' inv_VDMReal) \<longrightarrow> u61 \<in> u22)
                  \<and>
              isTest u61 inv_VDMNat \<longrightarrow> 
                  (isTest u22 (inv_VDMSeq' inv_VDMNat) \<longrightarrow> u61 \<notin> elems u22)
                  \<and>
                  (isTest u22 (inv_VDMSet' inv_VDMReal) \<longrightarrow> u61 \<notin> u22)
           )
    )"

find_theorems "_::int \<Rightarrow> real"

definition
  f2 :: "TUnion6 \<Rightarrow> TUnion2 \<Rightarrow> \<bool>"
  where
  "f2 u6 u2 \<equiv> 
    (case u6 of 
      U_VDMInt u61 \<Rightarrow>
        (case u2 of
           TUnion2_VDMNat_VDMSeq u21 \<Rightarrow> 
              isTest u61 inv_VDMInt \<longrightarrow> 
                  (isTest u21 (inv_VDMSeq' inv_VDMNat) \<longrightarrow> u61 \<in> elems u21)
                  \<and>
                  (isTest { real_of_int x | x . x \<in> (elems u21) } (inv_VDMSet' inv_VDMReal) \<longrightarrow> u61 \<in> elems u21)
                  \<and>
              isTest u61 inv_VDMNat \<longrightarrow> 
                  (isTest u21 (inv_VDMSeq' inv_VDMNat) \<longrightarrow> u61 \<notin> elems u21)
                  \<and>
                  (isTest { real_of_int x | x . x \<in> (elems u21) } (inv_VDMSet' inv_VDMReal) \<longrightarrow> u61 \<notin> elems u21)
         | TUnion2_VDMReal_VDMSet u22 \<Rightarrow> 
              isTest u61 inv_VDMInt \<longrightarrow> 
                  (isTest u22 (inv_VDMSeq' inv_VDMNat) \<longrightarrow> u61 \<in> elems u22)
                  \<and>
                  (isTest u22 (inv_VDMSet' inv_VDMReal) \<longrightarrow> u61 \<in> u22)
                  \<and>
              isTest u61 inv_VDMNat \<longrightarrow> 
                  (isTest u22 (inv_VDMSeq' inv_VDMNat) \<longrightarrow> u61 \<notin> elems u22)
                  \<and>
                  (isTest u22 (inv_VDMSet' inv_VDMReal) \<longrightarrow> u61 \<notin> u22)
           )
    )"

definition
  f2 :: "TUnion6 \<Rightarrow> TUnion2 \<Rightarrow> \<bool>"
  where
  "f2 u6 u2 \<equiv> 
    (case u6 of 
      U_VDMInt u61 \<Rightarrow>
        (case u2 of
           TUnion2_VDMNat_VDMSeq u21 \<Rightarrow> 
              isTest u61 inv_VDMInt \<longrightarrow> 
                  (isTest u21 (inv_VDMSeq' inv_VDMNat) \<longrightarrow> u61 \<in> elems u21)
                  \<and>
              isTest u61 inv_VDMNat \<longrightarrow> 
                  (isTest u21 (inv_VDMSeq' inv_VDMNat) \<longrightarrow> u61 \<notin> elems u21)
         | TUnion2_VDMReal_VDMSet u22 \<Rightarrow> 
              isTest u61 inv_VDMInt \<longrightarrow> 
                  (isTest u22 (inv_VDMSet' inv_VDMReal) \<longrightarrow> u61 \<in> u22)
                  \<and>
              isTest u61 inv_VDMNat \<longrightarrow> 
                  (isTest u22 (inv_VDMSet' inv_VDMReal) \<longrightarrow> u61 \<notin> u22)
           )
    )"

definition
  f2_wrong :: "TUnion6 \<Rightarrow> TUnion2 \<Rightarrow> \<bool>"
  where
  "f2_wrong u6 u2 \<equiv> 
    (case u6 of 
      U_VDMInt u61 \<Rightarrow>
        (case u2 of
           TUnion2_VDMNat_VDMSeq u21 \<Rightarrow> 
              isTest u61 inv_VDMInt \<longrightarrow> 
                  (isTest u21 (inv_VDMSeq' inv_VDMNat) \<longrightarrow> u61 \<in> elems u21)
         | TUnion2_VDMReal_VDMSet u22 \<Rightarrow> 
              isTest u61 inv_VDMNat \<longrightarrow> 
                  (isTest u22 (inv_VDMSet' inv_VDMReal) \<longrightarrow> u61 \<notin> u22)
           )
    )"

definition
  f2' :: "TUnion6 \<Rightarrow> TUnion2' \<Rightarrow> \<bool>"
  where
  "f2' u6 u2 \<equiv> 
    (case u6 of 
      U_VDMInt u61 \<Rightarrow>
        (case u2 of
           TUnion2'_VDMNat_VDMSeq u21 \<Rightarrow> u61 \<in> elems u21
         | TUnion2'_VDMReal_VDMSeq u22 \<Rightarrow> u61 \<in> elems u22
           ) 
    )"

end