theory Recursion
imports VDMToolkit
begin

text \<open>Isabelle requires constructive (on datatype constructor)  patterns\<close>
(*fun
  fold :: "(VDMNat \<Rightarrow> VDMNat \<Rightarrow> VDMNat) \<Rightarrow> VDMNat \<Rightarrow> VDMNat VDMSeq \<Rightarrow> VDMNat"
  where
  "fold f e [] = e"
| "fold f e [x] = x"
| "fold f e s1 @ s2 = f (fold f e s1) (fold f e s2)"
*)

fun
  fold :: "(VDMNat \<Rightarrow> VDMNat \<Rightarrow> VDMNat) \<Rightarrow> VDMNat \<Rightarrow> VDMNat VDMSeq \<Rightarrow> VDMNat"
  where
  "fold f e [] = e"
| "fold f e [x]  = x"
| "fold f e (x # s) = f (fold f e [x]) (fold f e s)"

text \<open>Isabelle found termination order
      @{term "(\<lambda>p. size_list (nat \<circ> abs) (snd (snd p))) <*mlex*> {}"}\<close>

fun 
  knuth_arrow :: "\<nat> \<Rightarrow> \<nat> \<Rightarrow> \<nat> \<Rightarrow> \<nat>" 
  where
  "knuth_arrow a n b = 
    (if n = 0 then 
      a * b
    else if b = 0 then
      1
    else
      knuth_arrow a (n - 1) (knuth_arrow a n (b - 1)))"

text \<open>Isabelle found termination order
      @{term "(\<lambda>p. size (fst (snd p))) <*mlex*> (\<lambda>p. size (snd (snd p))) <*mlex*> {}"}\<close>

fun
  ack :: "\<nat> \<Rightarrow> \<nat> \<Rightarrow> \<nat>"
  where
  "ack m n =
      (if m = 0 then
           n + 1
       else if n = 0 then
           ack (m-1) 1
       else 
           ack (m-1) (ack m (n-1)))"

text \<open>Isabelle found termination order
      @{term "(\<lambda>p. size (fst p)) <*mlex*> (\<lambda>p. size (snd p)) <*mlex*> {}"}\<close>


end