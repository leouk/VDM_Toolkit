(* VDM to Isabelle Translation @2022-12-08T10:15:15.450Z  
   Copyright 2019-22, Leo Freitas, leo.freitas@newcastle.ac.uk

   Comment
   Location
*)
theory TemplateTheory
imports Main  
begin

type_synonym MyType  = \<open>nat\<close>

datatype MyDType = A | B | C

lemmas LemmasNames  = Lemma1 Lemma2 Lemma3

theorem test [simp, elim]  :
    \<open>x > 0\<close>  
  oops

abbreviation 
    abbrev :: \<open>nat\<close> where
    \<open>abbrev  \<equiv> 10\<close>

definition
    geqDef :: \<open>nat \<Rightarrow> bool\<close> where
      [simp]  :  \<open>geqDef x  \<equiv> x > 1\<close>

record myRec = 
    field1 :: \<open>nat\<close> 
    field2 :: \<open>int\<close> 

record myRec2 = 
    field1 :: \<open>nat\<close> 
    field2 :: \<open>int\<close> 

definition
  pre_myFunDef :: \<open>nat \<Rightarrow> nat \<Rightarrow> bool\<close>
  where 
  \<open>pre_myFunDef x y \<equiv> True\<close>

\<comment>\<open>VDM function definition\<close>
definition
    myFunDef :: \<open>nat \<Rightarrow> nat \<Rightarrow> bool\<close> where
     \<open>myFunDef x y \<equiv> 
                    (if pre_myFunDef  x y then 
                        x+y > 10
                    else 
                        undefined
                    )\<close>

\<comment>\<open>Isabelle automatic recursive definition\<close> 
declare pre_fact_def n [simp] 

fun (domintros) 
    fact :: \<open>nat \<Rightarrow> nat\<close>  where
      [iff]  :  \<open>fact n = 
                    (if pre_fact  n then 
                        (if n = 0 then 1 else n*fact(n-1))
                    else 
                        undefined
                    )\<close> 

declare pre_fact_def n [simp del] 
\<comment>\<open>Isabelle even\<close> 
\<comment>\<open>Isabelle odd\<close> 
declare pre_even_def n [simp] 
        pre_odd_def n [simp] 

fun (domintros) 
    even :: \<open>nat \<Rightarrow> bool\<close>  and
    odd :: \<open>nat \<Rightarrow> bool\<close>  where
     \<open>even n = 
                    (if pre_even  n then 
                        (if n = 0 then True else odd (n-1))
                    else 
                        undefined
                    )\<close> 
    |    \<open>odd n = 
                    (if pre_odd  n then 
                        (if n = 0 then False else even (n-1))
                    else 
                        undefined
                    )\<close> 

declare pre_even_def n [simp del] 
pre_odd_def n [simp del] 
hide_const \<open>whichever\<close>  

end 