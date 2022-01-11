theory HEAP0ProofsIJW
imports HEAP0
begin


theorem (in level0_new)
  locale0_new_FSB: "PO_new0_feasibility"
unfolding PO_new0_feasibility_def  new0_postcondition_def new0_post_def
proof -  
 from l0_new0_precondition_def new0_pre_def obtain f0new r 
   where f0wit: "f0new = f0 - locs_of r s0" and isb: "is_block r s0 f0"
   by auto
 moreover have "F0_inv f0new" using l0_invariant_def F0_inv_def f0wit by simp
 ultimately show "\<exists>f' r'. (is_block r' s0 f0 \<and> f' = f0 - locs_of r' s0) \<and> F0_inv f'" by blast
qed


theorem (in level0_dispose)
  locale0_dispose_FSB: "PO_dispose0_feasibility"
unfolding PO_dispose0_feasibility_def dispose0_postcondition_def dispose0_post_def
proof -
  from l0_dispose0_precondition_def dispose0_pre_def obtain f0new 
    where f0wit: "f0new = (f0 \<union> locs_of d0 s0)" by auto
  moreover have "F0_inv f0new"
  proof -
  	have "finite (locs_of d0 s0)" using locs_of_def l0_input_notempty_def by auto
  	then have "F0_inv (f0 \<union> locs_of d0 s0)"
  	 using l0_invariant_def F0_inv_def by simp
  	thus "F0_inv f0new" 
  		using f0wit dispose0_post_def by auto  
  qed
  ultimately show "\<exists>f'. f' = f0 \<union> locs_of d0 s0 \<and> F0_inv f'" by blast
qed



(* The above proofs are straightforward, but there is a wee bit of clutter due to the depth of
   definitions that are being unfolded. Possibly this is overkill for Isar-style proofs where
   we can use forwards proof to control the zoom level? Of course, it is useful for the metis
   style of proof!
*)

end
