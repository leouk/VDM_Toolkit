(* VDM to Isabelle Translated
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 7:5files = [./src/test/resources/TestV2I.vdmsl]
*)
theory TestV2I_PO
imports TestV2I
begin

\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 7:5
VDM PO(1): "R: invariant satisfiability obligation in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 7:5
exists r : R & ((r.x) < (r.y))
"
\<close>
theorem R_INV_SATISFIABILITY:
	"((\<exists> (r::R). ((x\<^sub>R (r)) < (y\<^sub>R (r)))))"
	
	try
	oops
	
	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 18:15
VDM PO(2): "mkr: subtype obligation in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 18:15
(forall n:nat &
  inv_R(mk_R(n, (n + 1))))
"
\<close>
theorem mkr_SUB_TYPE:
	"((\<forall> (n::VDMNat). (inv_R \<lparr>x\<^sub>R = n, y\<^sub>R = (n + (1::VDMNat1))\<rparr>)))"
	
	try
	oops
	
	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 37:25
VDM PO(3): "t11: subtype obligation in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 37:25
{1, ... ,5} <> {} and is_({1, ... ,5}, set1 of (nat1))
"
\<close>
theorem t11_SUB_TYPE:
	"((({(1::VDMNat1)..(5::VDMNat1)} \<noteq> {}) \<and> not yet))"
	
	try
	oops
	
	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 40:29
VDM PO(4): "t14: map sequence compatible obligation in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 40:29
forall m1, m2 in set {{1 |-> 1}, {2 |-> 3}} & forall d3 in set dom m1, d4 in set dom m2 & d3 = d4 => m1(d3) = m2(d4)
"
\<close>
theorem t14_MAP_SEQ_OF_COMPATIBLE:
	"((\<forall> m1,m2 \<in> {[(1::VDMNat1)\<mapsto>(1::VDMNat1)], [(2::VDMNat1)\<mapsto>(3::VDMNat1)]}. (\<forall> d3 \<in> (dom m1) d4 \<in> (dom m2). ((d3 = d4) \<longrightarrow> ((m1 d3) = (m2 d4))))))"
	
	try
	oops
	
	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 52:17
VDM PO(5): "v9: non-empty set obligation in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 52:17
t12 <> {}
"
\<close>
theorem v9_NON_EMPTY_SET:
	"((t12 \<noteq> {}))"
	
	try
	oops
	
	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 62:16
VDM PO(6): "v19: map set compatible obligation in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 62:16
forall m1, m2 in set {t14, t15} & forall d3 in set dom m1, d4 in set dom m2 & d3 = d4 => m1(d3) = m2(d4)
"
\<close>
theorem v19_MAP_SET_OF_COMPATIBLE:
	"((\<forall> m1,m2 \<in> {t14, t15}. (\<forall> d3 \<in> (dom m1) d4 \<in> (dom m2). ((d3 = d4) \<longrightarrow> ((m1 d3) = (m2 d4))))))"
	
	try
	oops
	
	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 65:10
VDM PO(7): "v22: type invariant obligation in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 65:10
is_(t14, inmap nat1 to nat1)
"
\<close>
theorem v22_INVARIANT:
	"(not yet)"
	
	try
	oops
	
	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 87:10
VDM PO(8): "v44: map compatible obligation in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 87:10
forall ldom1 in set dom t14, rdom2 in set dom t15 & ldom1 = rdom2 => t14(ldom1) = t15(rdom2)
"
\<close>
theorem v44_MAP_COMPATIBLE:
	"((\<forall> ldom1 \<in> (dom t14) rdom2 \<in> (dom t15). ((ldom1 = rdom2) \<longrightarrow> ((t14 ldom1) = (t15 rdom2)))))"
	
	try
	oops
	
	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 88:14
VDM PO(9): "v45: map compose obligation in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 88:14
rng(t15) subset dom(t14)
"
\<close>
theorem v45_MAP_COMPOSE:
	"(((rng t15) \<subseteq> (dom t14)))"
	
	try
	oops
	
	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 104:10
VDM PO(10): "v61: map sequence compatible obligation in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 104:10
forall m1, m2 in set {{1 |-> 2}, {2 |-> 3}} & forall d3 in set dom m1, d4 in set dom m2 & d3 = d4 => m1(d3) = m2(d4)
"
\<close>
theorem v61_MAP_SEQ_OF_COMPATIBLE:
	"((\<forall> m1,m2 \<in> {[(1::VDMNat1)\<mapsto>(2::VDMNat1)], [(2::VDMNat1)\<mapsto>(3::VDMNat1)]}. (\<forall> d3 \<in> (dom m1) d4 \<in> (dom m2). ((d3 = d4) \<longrightarrow> ((m1 d3) = (m2 d4))))))"
	
	try
	oops
	
	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 111:14
VDM PO(11): "v65: subtype obligation in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 111:14
inv_R(mk_R(1, 2))
"
\<close>
theorem v65_SUB_TYPE:
	"((inv_R \<lparr>x\<^sub>R = (1::VDMNat1), y\<^sub>R = (2::VDMNat1)\<rparr>))"
	
	try
	oops
	
	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 112:12
VDM PO(12): "v651: subtype obligation in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 112:12
inv_R(mk_R(1, 2))
"
\<close>
theorem v651_SUB_TYPE:
	"((inv_R \<lparr>x\<^sub>R = (1::VDMNat1), y\<^sub>R = (2::VDMNat1)\<rparr>))"
	
	try
	oops
	
	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 124:39
VDM PO(13): "v722: subtype obligation in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 124:39
(let r:real = 4.0 in
  is_nat1(r))
"
\<close>
theorem v722_SUB_TYPE:
	"((
		let (r::VDMReal) = (4.0)
		in
			(if ((inv_VDMReal r)) then
			not yet
		 else
			undefined
		)
		))"
	
	try
	oops
	
	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 125:20
VDM PO(14): "v723: subtype obligation in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 125:20
is_nat1((6 / 2))
"
\<close>
theorem v723_SUB_TYPE:
	"(not yet)"
	
	try
	oops
	
	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 126:11
VDM PO(15): "v73: unique existence binding obligation in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 126:11
exists1 var in set t9 & (var < 2)
"
\<close>
theorem v73_UNIQUE_EXISTENCE:
	"((\<exists>! var \<in> t9. (var < (2::VDMNat1))))"
	
	try
	oops
	
end
(*
	Could not translate VDM PO because of a com.fujitsu.vdmj.messages.VDMErrorsException error:
	VDM PO: v12: non-empty sequence obligation in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 55:13
t10 <> []

	Reason: Error 3136: Left and right of '<>' different types in 'TestV2I' (console) at line 1:5
Left: seq1 of (nat1)
Right: []
*)
