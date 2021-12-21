theory RecursiveFunctionsStudy
imports VDMToolkit
begin

function  
  test :: "int \<Rightarrow> int \<Rightarrow> int"
  where
  "test 0 r = r" 
| "test (n+1) r = test n (n + 1 + r)"
     apply (metis add.left_inverse group_cancel.add1 small_lazy'.cases verit_sum_simplify)
    apply force
   apply simp_all 
  oops (* ah, negative case! *)
function  
  test :: "int \<Rightarrow> int \<Rightarrow> int"
  where
  "test n r = r" 
| "test (n+1) r = test n (n + 1 + r)"
     apply (meson surj_pair)
    apply fastforce
   apply simp_all
  oops (* still struggling *)

  print_quot_maps 
  thm map_VDMToken_def map_pre_VDMToken_def
  print_quotients

(* Going to quotient type doesn't seem to be as useful *)
  thm Rep_Integ_def Abs_Integ_def

(* Perhaps with guards? *)
function  
  test :: "int \<Rightarrow> int \<Rightarrow> int"
  where
  "n \<le> 0 \<Longrightarrow> test n r = r" 
| "test (n+1) r = test n (n + 1 + r)"
  apply (metis add.left_commute add.left_inverse group_cancel.rule0 old.prod.exhaust)
    apply fastforce
   apply simp_all
  oops (* same story; go look into HOL theories *)

(* Surprisingly few definitions *)
function iterate_upto :: "(natural \<Rightarrow> 'a) \<Rightarrow> natural \<Rightarrow> natural \<Rightarrow> 'a Predicate.pred"
where
  "iterate_upto f n m =
    Predicate.Seq (%u. if n > m then Predicate.Empty
     else Predicate.Insert (f n) (iterate_upto f (n + 1) m))"
by pat_completeness auto

(* Seem to be prefereable to have if-then-else pattern ? *)
function around_zero :: "int \<Rightarrow> int list"
where
  "around_zero i = (if i < 0 then [] else (if i = 0 then [0] else around_zero (i - 1) @ [i, -i]))"
  by pat_completeness auto
termination by (relation "measure nat") auto

definition measureM :: "('a \<Rightarrow> nat) \<Rightarrow> ('a \<times> 'a) set"
  where "measureM = inv_image less_than"

lemma "measureM (\<lambda> a . a+1) = R"
  unfolding measureM_def 
  unfolding less_than_def
  unfolding inv_image_def 
  unfolding less_than_def pred_nat_def
  apply simp oops

term "(\<lambda> (n, r) . nat n)"
lemma "measure (\<lambda> (n, r) . nat n) = A" oops

(* testInt : nat * nat \<rightarrow> nat 
   testInt(n,r) == if n = 0 then r else testInt(n-1, n+1+r)
   measure n;
 *)

function  
  testInt :: "int \<Rightarrow> int \<Rightarrow> int"
  where
  "testInt n r = (if n \<le> 0 then r else testInt (n - 1) (n+1+r))"
  by pat_completeness auto
termination
  apply (relation "measure (\<lambda> (n, r) . nat n)")
   apply fastforce
  by simp

(* testSet : set of nat * nat \<rightarrow> nat 
   testInt(s,r) == if s = {} then r else let x in set s in testInt(s \ {x}, x+r)
   measure card s;
 *)

function  
  testSet :: "int set \<Rightarrow> int \<Rightarrow> int"
  where
  "testSet s r = (if s = {} then r else testSet (s - { x . x \<in> s }) (1+r))"
  by pat_completeness auto
termination
  apply (relation "measure (\<lambda> (s, r) . card s)")
   apply fastforce
  apply (simp add: card_gt_0_iff) 
  oops
(* Will need a pretty involved pattern matching process; and in this one x is not part of the result!  *)

lemma l_insert_equals: "insert x xs = insert y ys \<Longrightarrow> xs \<union> {x} = ys \<union> {y}"
  by force

function 
  f :: "VDMNat VDMSet \<Rightarrow> VDMNat" 
  where
  "f {} = 0"
| "f (insert x s) = x + f s"
     apply (simp_all | blast)+
  oops

  term measures
function 
  f :: "VDMNat VDMSet \<Rightarrow> VDMNat" 
  where
  "f s = (if s = {} then 0 else (SOME r . r \<in> { x + f (s - {x}) | x . x \<in> s }))"
  by pat_completeness simp
termination
  
  apply (relation "measure (\<lambda> s . card s)")
   apply simp_all
  apply (subgoal_tac "xb \<in> s") oops

  term fold

function 
  sum :: "nat set \<Rightarrow> nat" 
  where
  "sum {} = 0" 
| "x \<notin> s \<Longrightarrow> sum ({x} \<union> s) = x + (sum s)"

function 
  f' :: "VDMNat VDMSet \<Rightarrow> VDMNat" 
  where
  "f' {} = 0" 
| "x \<notin> s \<Longrightarrow> f' ({x} \<union> s) = x + (f' s)"
     apply simp_all
   apply (metis equals0I mk_disjoint_insert)
  apply (elim equalityE, simp)
  apply safe  
   apply (metis subset_antisym subset_insert)
  apply (case_tac "s = {}", simp_all)
  apply (case_tac "sa = {}", simp_all)
  unfolding insert_compr
  apply (elim subsetCE,simp_all)
     apply (meson all_not_in_conv mk_disjoint_insert)
    apply simp+
  oops

(*
g: set of nat \<rightarrow> nat
g(s) == 
  cases s:
    {} \<rightarrow> 0,
    {x} union xs \<rightarrow> x + g(xs)
  end
*)
function
  g :: "nat \<Rightarrow> VDMNat VDMSet \<Rightarrow> VDMNat"
  where
  "g n s = if "
end