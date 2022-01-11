theory HEAP1SanityIJW
imports HEAP1ProofsIJW
begin

lemma new1_dispose_1_identity_isar: 
  assumes nat1n: "nat1 n" (* Needed to add? *)
  and n1_post: "new1_post f n f' r"
  and d1_post: "dispose1_post f' r n f''"
  and inv: "F1_inv f"
  shows "f = f''"
proof - 
  from n1_post show ?thesis
  unfolding new1_post_def
  proof
    assume n1_eq: "new1_post_eq f n f' r"
    then show "f = f''"
      unfolding new1_post_eq_def
    proof(elim conjE)
      assume r_in_dom: "r \<in> dom f"
      and eq_n: "the (f r) = n"
      and f'_restr: "f' = {r} -\<triangleleft> f"
      (* Shape of below *)
      have below_shape: "dispose1_below ({r} -\<triangleleft> f) r = empty"
        unfolding dispose1_below_def
        proof (rule l_dom_r_nothing_empty)
          from inv show "{x \<in> dom ({r} -\<triangleleft> f). x + the (({r} -\<triangleleft> f) x) = r} = {}"
          proof
            assume sepf: "sep f"
              have "{x \<in> dom ({r} -\<triangleleft> f). x + the (({r} -\<triangleleft> f) x) = r}
                 =  {x \<in> dom ({r} -\<triangleleft> f). x + the (f x) = r}" 
                  by (metis (full_types) Diff_iff l_dom_dom_ar f_in_dom_ar_apply_not_elem) 
              also have "... \<subseteq> {x \<in> dom (f). x + the (f x) = r}" 
                by (smt Collect_empty_eq l_dom_ar_not_in_dom r_in_dom sep_def sepf subsetI)   
              also have "... = {}"
                by (smt Collect_empty_eq r_in_dom sep_def sepf)
            finally show ?thesis by simp
          qed
        qed  
      (* Shape of above *)
      have above_shape: "dispose1_above ({r} -\<triangleleft> f) r n = empty"
      unfolding dispose1_above_def
      (*  proof (rule l_dom_r_nothing_empty) Why not work?? *)
          proof (rule l_dom_r_nothing_empty)
          from inv show "{x \<in> dom ({r} -\<triangleleft> f). x = r + n} = {}"
          proof
            assume sepf: "sep f"
              have "{x \<in> dom ({r} -\<triangleleft> f). x = r + n} \<subseteq> {x \<in> dom (f). x = r + n}" 
                by (smt Collect_cong Collect_empty_eq equals0D l_dom_ar_not_in_dom subsetI)
              also have "... = {}" by (smt empty_Collect_eq eq_n r_in_dom sep_def sepf)
            finally show ?thesis by simp
          qed
        qed
      (* Shape of min_loc *)
      have min_loc_shape:  "min_loc (dispose1_ext ({r} -\<triangleleft> f) r n) = r"
        unfolding dispose1_ext_def
      proof - 
        have "dispose1_above ({r} -\<triangleleft> f) r n \<union>m dispose1_below ({r} -\<triangleleft> f) r \<union>m [r \<mapsto> n]
             = [r \<mapsto> n]" 
              by (simp add: above_shape l_munion_empty_lhs below_shape)
        moreover have "min_loc [r \<mapsto> n] = r" 
          unfolding min_loc_def
          by simp
          ultimately show "min_loc (dispose1_above ({r} -\<triangleleft> f) r n 
                              \<union>m dispose1_below ({r} -\<triangleleft> f) r \<union>m [r \<mapsto> n]) = r"
           by simp
      qed
      (* Final shape rule *)
      have sum_size_shape:  "sum_size (dispose1_ext ({r} -\<triangleleft> f) r n) = the(f r)"
        unfolding dispose1_ext_def
      proof - 
        have "dispose1_above ({r} -\<triangleleft> f) r n \<union>m dispose1_below ({r} -\<triangleleft> f) r \<union>m [r \<mapsto> n]
             = [r \<mapsto> n]" 
              by (simp add: above_shape l_munion_empty_lhs below_shape)
        moreover have "sum_size [r \<mapsto> n] = n" 
          unfolding sum_size_def by simp
        moreover have "the (f r) = n"by (rule eq_n)
        ultimately show "sum_size (dispose1_above ({r} -\<triangleleft> f) r n
                \<union>m dispose1_below ({r} -\<triangleleft> f) r \<union>m [r \<mapsto> n]) = the (f r)"
             by simp
      qed
      (* We are now able to rewrite f'' *)
      from d1_post show ?thesis
      proof (simp only: dispose1_equiv, unfold dispose1_post2_def)
        assume "f'' = (dom (dispose1_below f' r) \<union> dom (dispose1_above f' r n)) -\<triangleleft> f' \<union>m
          [min_loc (dispose1_ext f' r n) \<mapsto> sum_size (dispose1_ext f' r n)]"
        then have "f'' = ((dom (empty) \<union> dom (empty)) -\<triangleleft> f'
                    \<union>m [min_loc (dispose1_ext f' r n) \<mapsto> sum_size (dispose1_ext f' r n)])"
             by (simp add: f'_restr below_shape above_shape)
        then have "f'' = {} -\<triangleleft> f'
                    \<union>m [min_loc (dispose1_ext f' r n) \<mapsto> sum_size (dispose1_ext f' r n)]"
                    by simp (* For some reason also wasn't working here!!! *)
        also have " ... =  f'
                    \<union>m [min_loc (dispose1_ext f' r n) \<mapsto> sum_size (dispose1_ext f' r n)]"          
            by (metis l_dom_ar_empty_lhs)
       also have "...= f' \<union>m [r \<mapsto> the (f r)]"
          by (simp add: min_loc_shape sum_size_shape f'_restr)
       also have "... = ({r} -\<triangleleft> f) \<union>m [r \<mapsto> the (f r)]"
          by (simp add: f'_restr)
       also have "... =  ({r} -\<triangleleft> f) \<dagger> [r \<mapsto> the (f r)]"
          proof -
            have "dom ({r} -\<triangleleft> f) \<inter> dom [r \<mapsto> the (f r)] = {}"
              by (metis Int_insert_right_if0 dom_eq_singleton_conv f_in_dom_ar_notelem inf_bot_right)
            thus ?thesis by (simp add: munion_def)
          qed 
      also have "... = f" using r_in_dom by (rule antirestr_then_dagger)
      finally show ?thesis ..
    qed
  qed
  next
    assume "new1_post_gr f n f' r"
    then show ?thesis
      unfolding new1_post_gr_def
    proof(elim conjE)
      assume r_in_dom: "r \<in> dom f"
      and gr_n: "the (f r) > n"
      and f'_restr: "f' = {r} -\<triangleleft> f \<union>m [r + n \<mapsto> the (f r) - n]"
      
      have disjoint_dom: " dom f \<inter> dom [r + n \<mapsto> the (f r) - n] = {}"
      proof (simp)
      show "r + n \<notin> dom  f"
      proof (rule l_plus_s_not_in_f)
        show "F1_inv f" by (metis inv)
        next
        show "r \<in> dom  f" by (rule r_in_dom)
        next
        show "n < the (f r)" by (rule gr_n)
        next
        show "nat1 n" by (rule nat1n)
      qed
    qed
      have disjoint_dom_antirestr: " dom ({r} -\<triangleleft> f) \<inter> dom [r + n \<mapsto> the (f r) - n] = {}"
        by (metis disjoint_dom l_dom_ar_disjoint_weakening)
      (* Shape of below *)
      have below_shape: "dispose1_below ({r} -\<triangleleft> f \<union>m [r + n \<mapsto> the (f r) - n]) r = empty"
         unfolding dispose1_below_def
        proof (rule l_dom_r_nothing_empty)
          from inv show "{x \<in> dom ({r} -\<triangleleft> f \<union>m [r + n \<mapsto> the (f r) - n]).
                  x + the (({r} -\<triangleleft> f \<union>m [r + n \<mapsto> the (f r) - n]) x) = r} = {}"
          proof
            assume sepf: "sep f"
              have "({r} -\<triangleleft> f \<union>m [r + n \<mapsto> the (f r) - n])
                            =({r} -\<triangleleft> f \<dagger> [r + n \<mapsto> the (f r) - n]) "
                          by (metis  disjoint_dom_antirestr munion_def)
              then have "{x \<in> dom ({r} -\<triangleleft> f \<union>m [r + n \<mapsto> the (f r) - n]).
                  x + the (({r} -\<triangleleft> f \<union>m [r + n \<mapsto> the (f r) - n]) x) = r}
                 = {x \<in> dom ({r} -\<triangleleft> f \<dagger> [r + n \<mapsto> the (f r) - n]).
                 x + the (({r} -\<triangleleft> f \<dagger> [r + n \<mapsto> the (f r) - n]) x) = r}"
                  by simp                  
             also have "... = {x \<in> dom ({r} -\<triangleleft> f).
                 x + the (({r} -\<triangleleft> f) x) = r} \<union> {x\<in> dom ([r + n \<mapsto> the (f r) - n]).
                          x + the  ([r + n \<mapsto> the (f r) - n] x) = r}"
             proof (subst l_dagger_dom)
                show "{x \<in> dom ({r} -\<triangleleft> f) \<union> dom [r + n \<mapsto> the (f r) - n]. 
                          x + the (({r} -\<triangleleft> f \<dagger> [r + n \<mapsto> the (f r) - n]) x) = r}
                   =   {x \<in> dom ({r} -\<triangleleft> f). x + the (({r} -\<triangleleft> f) x) = r} 
                     \<union> {x \<in> dom [r + n \<mapsto> the (f r) - n]. x + the ([r + n \<mapsto> the (f r) - n] x) = r}"
                proof (subst union_comp)
                  show "{x \<in> dom ({r} -\<triangleleft> f). x + the (({r} -\<triangleleft> f \<dagger> [r + n \<mapsto> the (f r) - n]) x) = r}
                      \<union> {x \<in> dom [r + n \<mapsto> the (f r) - n]. x + the (({r} -\<triangleleft> f \<dagger> [r + n \<mapsto> the (f r) - n]) x) = r}
                   =   {x \<in> dom ({r} -\<triangleleft> f). x + the (({r} -\<triangleleft> f) x) = r} 
                     \<union> {x \<in> dom [r + n \<mapsto> the (f r) - n]. x + the ([r + n \<mapsto> the (f r) - n] x) = r}"
                  proof - 
                    have " {x \<in> dom ({r} -\<triangleleft> f). x + the (({r} -\<triangleleft> f \<dagger> [r + n \<mapsto> the (f r) - n]) x) = r}
                      = {x \<in> dom ({r} -\<triangleleft> f). x + the (({r} -\<triangleleft> f) x) = r}"
                        by (metis Int_iff `{r} -\<triangleleft> f \<union>m [r + n \<mapsto> the (f r) - n] = {r} -\<triangleleft> f \<dagger> [r + n \<mapsto> the (f r) - n]`
                       disjoint_dom_antirestr dom_eq_singleton_conv empty_iff f'_restr the_dagger_dom_left)
                   moreover have " {x \<in> dom [r + n \<mapsto> the (f r) - n]. x + the (({r} -\<triangleleft> f \<dagger> [r + n \<mapsto> the (f r) - n]) x) = r}
                            = {x \<in> dom [r + n \<mapsto> the (f r) - n]. x + the ([r + n \<mapsto> the (f r) - n] x) = r}"
                            by (metis (lifting) l_dagger_apply)
                  ultimately show ?thesis by auto
                 qed
               qed
             qed
            also have "... = {}"
                proof - 
                  have "{x\<in> dom ([r + n \<mapsto> the (f r) - n]).
                          x + the  ([r + n \<mapsto> the (f r) - n] x) = r} = {}"
                   
using nat1n by auto
                 moreover have "{x \<in> dom ({r} -\<triangleleft> f).
                 x + the (({r} -\<triangleleft> f) x) = r} = {}"
                 proof -  
                  have "{x \<in> dom ({r} -\<triangleleft> f). x + the (({r} -\<triangleleft> f) x) = r}
                    \<subseteq> {x \<in> dom (f). x + the (f x) = r}"
                      by (smt Collect_cong eq_refl f_in_dom_ar_the_subsume l_dom_ar_not_in_dom r_in_dom sep_def sepf)
                  also have "... = {}"
                    by (smt Collect_empty_eq r_in_dom sep_def sepf)
                  finally show ?thesis by simp
                 qed
                ultimately show ?thesis by simp
            qed
            finally show ?thesis by simp
          qed
        qed
      have above_shape: "dispose1_above ({r} -\<triangleleft> f \<union>m [r + n \<mapsto> the (f r) - n]) r n = [r + n \<mapsto> the(f r) - n]"
      unfolding dispose1_above_def
      proof -
        have "{x \<in> dom ({r} -\<triangleleft> f \<union>m [r + n \<mapsto> the (f r) - n]). x = r + n} = {r+n}"
        proof -
          have "{x \<in> dom ({r} -\<triangleleft> f \<union>m [r + n \<mapsto> the (f r) - n]). x = r + n} =
                    {x \<in> dom ({r} -\<triangleleft> f \<dagger> [r + n \<mapsto> the (f r) - n]). x = r + n}"
                    unfolding munion_def by (subst disjoint_dom_antirestr, simp) 
          also have "... =  {x \<in> dom ({r} -\<triangleleft> f). x = r + n} \<union> 
                {x \<in> dom ([r + n \<mapsto> the (f r) - n]). x = r + n}"
                by(subst l_dagger_dom,rule union_comp)
          also have "... = {x \<in> dom ({r} -\<triangleleft> f). x = r + n} \<union> {r+n}"
            by auto
          also have "... = {r+n}"
          proof - 
            have " {x \<in> dom ({r} -\<triangleleft> f). x = r + n} = {}" 
              by (metis (lifting, mono_tags) Collect_empty_eq gr_n inv l_dom_ar_not_in_dom l_plus_s_not_in_f nat1n r_in_dom)
            thus ?thesis by auto
         qed
         finally show ?thesis by simp
       qed
        moreover have "{r+n} \<triangleleft> ({r} -\<triangleleft> f \<union>m [r + n \<mapsto> the (f r) - n]) = [r + n \<mapsto> the (f r) - n]"
        proof (subst l_dom_r_singleton)
          show "r + n \<in> dom ({r} -\<triangleleft> f \<union>m [r + n \<mapsto> the (f r) - n])" 
            by (smt calculation empty_Collect_eq insert_compr)
         next
         show "[r + n \<mapsto> the (({r} -\<triangleleft> f \<union>m [r + n \<mapsto> the (f r) - n]) (r + n))] 
                = [r + n \<mapsto> the (f r) - n]"
                by (metis dagger_upd_dist disjoint_dom_antirestr fun_upd_same munion_def option.sel)
        qed
        ultimately show " {x \<in> dom ({r} -\<triangleleft> f \<union>m [r + n \<mapsto> the (f r) - n]). x = r + n} \<triangleleft> ({r} -\<triangleleft> f \<union>m [r + n \<mapsto> the (f r) - n]) = [r + n \<mapsto> the (f r) - n]"
        by auto
      qed
      have min_loc_shape: "min_loc (dispose1_ext ({r} -\<triangleleft> f \<union>m [r + n \<mapsto> the (f r) - n]) r n) = r"
        unfolding dispose1_ext_def
      proof ( simp add: above_shape below_shape)
        show "min_loc ([r + n \<mapsto> the (f r) - n] \<union>m Map.empty \<union>m [r \<mapsto> n]) = r"
        proof - 
            have without_empty: "[r + n \<mapsto> the (f r) - n] \<union>m Map.empty \<union>m [r \<mapsto> n]
            = [r + n \<mapsto> the (f r) - n] \<union>m [r \<mapsto> n]"
              by (metis l_munion_empty_rhs)
           then have "min_loc ([r + n \<mapsto> the (f r) - n] \<union>m [r \<mapsto> n]) 
                    = min_loc ([r + n \<mapsto> the (f r) - n] \<dagger> [r \<mapsto> n])"
           proof -
            have "dom ([r + n \<mapsto> the (f r) - n])\<inter> dom( [r \<mapsto> n]) = {r+n} \<inter> {r}"
              by auto
            also have "... = {}" using nat1n by auto
            finally show ?thesis by (simp add: munion_def)
           qed
           also have "...  = min (min_loc [r + n \<mapsto> the (f r) - n]) (min_loc [r \<mapsto> n])"
           by(rule min_loc_dagger,simp_all)
          also have "... = min (r+n) (r)" by (simp add: min_loc_singleton) 
          also have "... = r" by simp
          finally show ?thesis using without_empty by simp 
        qed
      qed
      have sum_size_shape: "sum_size (dispose1_ext ({r} -\<triangleleft> f \<union>m [r + n \<mapsto> the (f r) - n]) r n) = the(f r)"
        unfolding dispose1_ext_def
      proof ( simp add: above_shape below_shape)
        show "sum_size ([r + n \<mapsto> the (f r) - n] \<union>m empty \<union>m [r \<mapsto> n]) = the (f r)"
        proof - 
            have without_empty: "[r + n \<mapsto> the (f r) - n] \<union>m Map.empty \<union>m [r \<mapsto> n]
            = [r + n \<mapsto> the (f r) - n] \<union>m [r \<mapsto> n]"
              by (metis l_munion_empty_rhs)
            then have "sum_size ([r + n \<mapsto> the (f r) - n] \<union>m [r \<mapsto> n]) 
                 = sum_size ([r + n \<mapsto> the (f r) - n]) + sum_size ([r \<mapsto> n])"
                 apply (subst  sum_size_munion, simp_all)
                 by (metis nat1_def nat1n)
            also have "... = the (f r) - n + n" by (simp add: sum_size_singleton)
            also have "... = the (f r)" 
by (simp add: gr_n less_imp_le)
          finally show ?thesis using without_empty by simp 
        qed
     qed
       from d1_post show ?thesis
      proof (simp only: dispose1_equiv, unfold dispose1_post2_def)
      assume "f'' = (dom (dispose1_below f' r) \<union> dom (dispose1_above f' r n)) -\<triangleleft> f' 
          \<union>m [min_loc (dispose1_ext f' r n) \<mapsto> sum_size (dispose1_ext f' r n)]"
      then have "f'' = 
              {r+n}  -\<triangleleft> f' \<union>m [min_loc (dispose1_ext f' r n) \<mapsto> sum_size (dispose1_ext f' r n)]"
               by (simp add: f'_restr below_shape above_shape)
     also have "... = ({r} -\<triangleleft> f) \<union>m [min_loc (dispose1_ext f' r n) \<mapsto> sum_size (dispose1_ext f' r n)]"
        proof -
          have "{r+n} -\<triangleleft> f' = {r+n} -\<triangleleft> ({r} -\<triangleleft> f \<union>m [r + n \<mapsto> the (f r) - n])"
            by (simp add: f'_restr)
          also have "... =  {r+n} -\<triangleleft> ({r} -\<triangleleft> (f \<union>m [r + n \<mapsto> the (f r) - n]))"
          proof(subst l_munion_dom_ar_assoc)
            show " {r} \<subseteq> dom f" by (simp add: r_in_dom)
          next
            show " dom f \<inter> dom [r + n \<mapsto> the (f r) - n] = {}" by (rule disjoint_dom)
          next 
            show "{r + n} -\<triangleleft> {r} -\<triangleleft> (f \<union>m [r + n \<mapsto> the (f r) - n]) =
                  {r + n} -\<triangleleft> {r} -\<triangleleft> (f \<union>m [r + n \<mapsto> the (f r) - n])" ..
          qed
          also have "... =  {r} -\<triangleleft> ({r+n} -\<triangleleft> (f \<union>m [r + n \<mapsto> the (f r) - n]))"
            by (metis l_dom_ar_singletons_comm)
           also have "... =  {r} -\<triangleleft> ({r+n} -\<triangleleft> (f \<dagger> [r + n \<mapsto> the (f r) - n]))"
            unfolding munion_def
            by (simp only: disjoint_dom,simp)
           also have "... =  {r} -\<triangleleft> f"
           proof (subst antirestr_then_dagger_notin)
            show "r+n \<notin> dom f" using disjoint_dom by auto
            next
            show " {r} -\<triangleleft> f = {r} -\<triangleleft> f" ..
           qed
           finally show ?thesis by simp
         qed
         also have "... =  ({r} -\<triangleleft> f) \<union>m [r \<mapsto> the (f r)]"
            by (simp add: min_loc_shape sum_size_shape f'_restr)
         also have "... =  ({r} -\<triangleleft> f) \<dagger> [r \<mapsto> the (f r)]"
          proof -
            have "dom ({r} -\<triangleleft> f) \<inter> dom [r \<mapsto> the (f r)] = {}"
              by (metis Collect_conj_eq Collect_conv_if2 Collect_mem_eq dom_eq_singleton_conv f_in_dom_ar_notelem inf_commute singleton_conv2)
            thus ?thesis by (simp add: munion_def)
          qed 
      also have "... = f" using r_in_dom by (rule antirestr_then_dagger)
      finally show ?thesis ..
    qed
  qed
qed
qed

end
