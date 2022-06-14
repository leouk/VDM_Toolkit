theory VDMEisbach
  imports (*"HOL-Eisbach.Eisbach_Tools"*) Complex_Main
begin

named_theorems 
  VDM_basic_defs      and

  VDM_num_defs        and
  VDM_num_fcns        and
  VDM_num_spec_pre    and
  VDM_num_spec_post   and
  VDM_num_spec        and
  VDM_num             and

  VDM_set_defs        and
  VDM_set_fcns        and
  VDM_set_spec_pre    and
  VDM_set_spec_post   and
  VDM_set_spec        and
  VDM_set             and

  VDM_seq_defs        and
  VDM_seq_fcns_1      and
  VDM_seq_fcns_2      and
  VDM_seq_fcns_3      and
  VDM_seq_fcns        and
  VDM_seq_spec_pre    and
  VDM_seq_spec_post_1 and
  VDM_seq_spec_post_2 and
  VDM_seq_spec_post_3 and
  VDM_seq_spec_post   and
  VDM_seq_spec        and
  VDM_seq             and

  VDM_map_defs        and

  VDM_map_fcns_simps  and 
  VDM_map_fcns_1_simps and 
  VDM_map_fcns_2_simps and 

  VDM_map_fcns        and
  VDM_map_fcns_1      and
  VDM_map_fcns_2      and
  VDM_map_fcns_3      and
  VDM_map_fcns_4      and

  VDM_map_comp        and
  VDM_map_comp_1      and
  VDM_map_comp_2      and
  VDM_map_comp_3      and

  VDM_map             and

  VDM_num_crc         and
  VDM_num_crc_1       and
  VDM_num_crc_2       and
  VDM_num_crc_3       and
                  
  VDM_stms_defs       and 
  VDM_stms            and

  VDM_spec            and
  VDM_all

end