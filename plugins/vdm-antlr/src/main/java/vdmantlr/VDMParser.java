// Generated from /Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm-antlr/src/main/antlr4/VDM.g4 by ANTLR 4.9.2
package vdmantlr;

//import com.fujitsu.vdmj.lex.Dialect;    

import org.antlr.v4.runtime.atn.*;
import org.antlr.v4.runtime.dfa.DFA;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.misc.*;
import org.antlr.v4.runtime.tree.*;
import java.util.List;
import java.util.Iterator;
import java.util.ArrayList;

@SuppressWarnings({"all", "warnings", "unchecked", "unused", "cast"})
public class VDMParser extends Parser {
	static { RuntimeMetaData.checkVersion("4.9.2", RuntimeMetaData.VERSION); }

	protected static final DFA[] _decisionToDFA;
	protected static final PredictionContextCache _sharedContextCache =
		new PredictionContextCache();
	public static final int
		SLK_inys=1, SLK_best=2, SLK_ninset=3, SLK_inset=4, SLK_inseq=5, SLK_set1of=6, 
		SLK_setof=7, SLK_seq1of=8, SLK_seqof=9, SLK_istest=10, SLK_abs=11, SLK_all=12, 
		SLK_always=13, SLK_and=14, SLK_as=15, SLK_atomic=16, SLK_bool=17, SLK_by=18, 
		SLK_card=19, SLK_cases=20, SLK_char=21, SLK_compose=22, SLK_comp=23, SLK_conc=24, 
		SLK_dcl=25, SLK_def=26, SLK_definitions=27, SLK_dinter=28, SLK_div=29, 
		SLK_do=30, SLK_dom=31, SLK_dunion=32, SLK_elems=33, SLK_else=34, SLK_elseif=35, 
		SLK_end=36, SLK_eq=37, SLK_error=38, SLK_errs=39, SLK_exists=40, SLK_exists1=41, 
		SLK_exit=42, SLK_exports=43, SLK_ext=44, SLK_false=45, SLK_floor=46, SLK_for=47, 
		SLK_forall=48, SLK_from=49, SLK_functions=50, SLK_hd=51, SLK_if=52, SLK_in=53, 
		SLK_inds=54, SLK_inmap=55, SLK_int=56, SLK_inter=57, SLK_imports=58, SLK_init=59, 
		SLK_inv=60, SLK_inverse=61, SLK_iota=62, SLK_lambda=63, SLK_len=64, SLK_let=65, 
		SLK_map=66, SLK_measure=67, SLK_merge=68, SLK_mod=69, SLK_module=70, SLK_mk=71, 
		SLK_mu=72, SLK_munion=73, SLK_narrow=74, SLK_nat=75, SLK_nat1=76, SLK_nil=77, 
		SLK_not=78, SLK_of=79, SLK_operations=80, SLK_or=81, SLK_ord=82, SLK_others=83, 
		SLK_post=84, SLK_power=85, SLK_pre=86, SLK_pure=87, SLK_psubset=88, SLK_rat=89, 
		SLK_rd=90, SLK_real=91, SLK_rem=92, SLK_renamed=93, SLK_return=94, SLK_reverse=95, 
		SLK_rng=96, SLK_skip=97, SLK_state=98, SLK_struct=99, SLK_subset=100, 
		SLK_then=101, SLK_tixe=102, SLK_tl=103, SLK_to=104, SLK_token=105, SLK_traces=106, 
		SLK_trap=107, SLK_true=108, SLK_types=109, SLK_undefined=110, SLK_union=111, 
		SLK_values=112, SLK_with=113, SLK_while=114, SLK_wr=115, SLK_RESULT=116, 
		PPK_isr=117, PPK_isc=118, PPK_access=119, PPK_instance=120, PPK_ibc=121, 
		PPK_ioc=122, PPK_class=123, PPK_new=124, PPK_obj=125, PPK_private=126, 
		PPK_protected=127, PPK_public=128, PPK_sbc=129, PPK_sc=130, PPK_self=131, 
		PPK_static=132, PPK_variables=133, RTK_active=134, RTK_act=135, RTK_fin=136, 
		RTK_req=137, RTK_waiting=138, RTK_async=139, RTK_cycles=140, RTK_duration=141, 
		RTK_periodic=142, RTK_per=143, RTK_mutex=144, RTK_sporadic=145, RTK_start=146, 
		RTK_startlist=147, RTK_stop=148, RTK_stoplist=149, RTK_sync=150, RTK_system=151, 
		RTK_time=152, RTK_threadid=153, RTK_thread=154, O_IFF=155, O_NEQ=156, 
		O_LEQ=157, O_GEQ=158, O_IMPLIES=159, O_EXP=160, O_NDRES=161, O_DRES=162, 
		O_NRRES=163, O_RRES=164, O_OVERRIDE=165, O_LT=166, O_GT=167, O_DIV=168, 
		O_DIFF=169, O_TIMES=170, O_PLUS=171, O_MINUS=172, O_CONCAT=173, O_EQUAL=174, 
		SEP_ann=175, SEP_parallel=176, SEP_optype=177, SEP_assign=178, SEP_rec=179, 
		SEP_range=180, SEP_maplet=181, SEP_def=182, SEP_tsel=183, SEP_pfcn=184, 
		SEP_tfcn=185, SEP_comma=186, SEP_dot=187, SEP_colon=188, SEP_scolon=189, 
		SEP_bar=190, SEP_qm=191, SEP_amp=192, SEP_tick=193, SEP_old=194, SEP_underscore=195, 
		PAREN_L=196, PAREN_R=197, BRACKET_L=198, BRACKET_R=199, BRACE_L=200, BRACE_R=201, 
		QUOTE_LITERAL=202, TYPE_VARIABLE_IDENTIFIER=203, NUMERIC_LITERAL=204, 
		CHARACTER_LITERAL=205, TEXT_LITERAL=206, IDENTIFIER=207, NUMERAL=208, 
		SPACE=209, TAB=210, CR=211, SINGLE_LINE_COMMENT=212, MULTIPLE_LINE_COMMENT=213, 
		UnrecognizedChar=214;
	public static final int
		RULE_sl_document = 0, RULE_module = 1, RULE_sl_interface = 2, RULE_import_definition_list = 3, 
		RULE_import_definition = 4, RULE_import_module_signature = 5, RULE_import_signature = 6, 
		RULE_import_types_signature = 7, RULE_type_import = 8, RULE_import_values_signature = 9, 
		RULE_value_import = 10, RULE_import_functions_signature = 11, RULE_function_import = 12, 
		RULE_import_operations_signature = 13, RULE_operation_import = 14, RULE_export_definition = 15, 
		RULE_export_module_signature = 16, RULE_export_signature = 17, RULE_export_types_signature = 18, 
		RULE_type_export = 19, RULE_export_values_signature = 20, RULE_value_signature = 21, 
		RULE_export_functions_signature = 22, RULE_function_signature = 23, RULE_export_operations_signature = 24, 
		RULE_operation_signature = 25, RULE_module_body = 26, RULE_rt_document = 27, 
		RULE_system = 28, RULE_rt_class_body = 29, RULE_pp_class = 30, RULE_inheritance_clause = 31, 
		RULE_class_body = 32, RULE_rt_definition_block = 33, RULE_pp_definition_block = 34, 
		RULE_sl_definition_block = 35, RULE_pp_type_definitions = 36, RULE_access_type_definition = 37, 
		RULE_access = 38, RULE_sl_type_definitions = 39, RULE_type_definition_list = 40, 
		RULE_type_definition = 41, RULE_invariant_type_definition = 42, RULE_type_specification = 43, 
		RULE_type = 44, RULE_void_function_type = 45, RULE_bracketed_type = 46, 
		RULE_basic_type = 47, RULE_quote_type = 48, RULE_composite_type = 49, 
		RULE_field = 50, RULE_union_type = 51, RULE_product_type = 52, RULE_optional_type = 53, 
		RULE_set_type = 54, RULE_set0_type = 55, RULE_set1_type = 56, RULE_seq_type = 57, 
		RULE_seq0_type = 58, RULE_seq1_type = 59, RULE_map_type = 60, RULE_general_map_type = 61, 
		RULE_injective_map_type = 62, RULE_function_type = 63, RULE_partial_function_type = 64, 
		RULE_total_function_type = 65, RULE_discretionary_type = 66, RULE_type_name = 67, 
		RULE_type_variable = 68, RULE_invariant = 69, RULE_eq_clause = 70, RULE_ord_clause = 71, 
		RULE_invariant_initial_function = 72, RULE_state_definition = 73, RULE_initialisation = 74, 
		RULE_sl_value_definitions = 75, RULE_pp_value_definitions = 76, RULE_access_value_definition = 77, 
		RULE_value_definition = 78, RULE_sl_function_definitions = 79, RULE_pp_function_definitions = 80, 
		RULE_access_function_definition = 81, RULE_function_definition = 82, RULE_explicit_function_definition = 83, 
		RULE_pre_expression = 84, RULE_post_expression = 85, RULE_measure_definition = 86, 
		RULE_implicit_function_definition = 87, RULE_extended_explicit_function_definition = 88, 
		RULE_type_variable_list = 89, RULE_parameter_types = 90, RULE_pattern_type_pair_list = 91, 
		RULE_identifier_type_pair_list = 92, RULE_identifier_type_pair = 93, RULE_parameters = 94, 
		RULE_function_body = 95, RULE_measure_body = 96, RULE_sl_operation_definitions = 97, 
		RULE_sl_access_operation_definition = 98, RULE_pp_operation_definitions = 99, 
		RULE_pp_access_operation_definition = 100, RULE_rt_operation_definitions = 101, 
		RULE_rt_access_operation_definition = 102, RULE_operation_definition = 103, 
		RULE_explicit_operation_definition = 104, RULE_implicit_operation_definition = 105, 
		RULE_implicit_operation_body = 106, RULE_extended_explicit_operation_definition = 107, 
		RULE_operation_type = 108, RULE_operation_body = 109, RULE_externals = 110, 
		RULE_var_information = 111, RULE_vdmmode = 112, RULE_exceptions = 113, 
		RULE_error = 114, RULE_instance_variable_definitions = 115, RULE_instance_variable_definition = 116, 
		RULE_access_assignment_definition = 117, RULE_invariant_definition = 118, 
		RULE_synchronization_definitions = 119, RULE_synchronization = 120, RULE_permission_predicates = 121, 
		RULE_mutex_predicate = 122, RULE_thread_definitions = 123, RULE_thread_definition = 124, 
		RULE_periodic_thread_definition = 125, RULE_periodic_obligation = 126, 
		RULE_sporadic_obligation = 127, RULE_procedural_thread_definition = 128, 
		RULE_traces_definitions = 129, RULE_named_trace_list = 130, RULE_named_trace = 131, 
		RULE_trace_definition_list = 132, RULE_trace_definition_term = 133, RULE_trace_definition = 134, 
		RULE_trace_binding_definition = 135, RULE_trace_let_def_binding = 136, 
		RULE_trace_let_best_binding = 137, RULE_trace_repeat_definition = 138, 
		RULE_trace_core_definition = 139, RULE_trace_apply_expression = 140, RULE_trace_concurrent_expression = 141, 
		RULE_trace_bracketed_expression = 142, RULE_annotations = 143, RULE_expression_list = 144, 
		RULE_expression = 145, RULE_bracketed_expression = 146, RULE_let_expression = 147, 
		RULE_let_be_expression = 148, RULE_def_expression = 149, RULE_if_expression = 150, 
		RULE_elseif_expression = 151, RULE_cases_expression = 152, RULE_cases_expression_alternatives = 153, 
		RULE_cases_expression_alternative = 154, RULE_others_expression = 155, 
		RULE_unary_expression = 156, RULE_quantified_expression = 157, RULE_all_expression = 158, 
		RULE_exists_expression = 159, RULE_exists_unique_expression = 160, RULE_iota_expression = 161, 
		RULE_set_enumeration = 162, RULE_set_comprehension = 163, RULE_set_range_expression = 164, 
		RULE_sequence_enumeration = 165, RULE_sequence_comprehension = 166, RULE_subsequence = 167, 
		RULE_map_enumeration = 168, RULE_maplet = 169, RULE_map_comprehension = 170, 
		RULE_tuple_constructor = 171, RULE_record_constructor = 172, RULE_tight_record_name = 173, 
		RULE_record_modifier = 174, RULE_record_modification = 175, RULE_apply = 176, 
		RULE_field_select = 177, RULE_tuple_select = 178, RULE_function_type_instantiation = 179, 
		RULE_lambda_expression = 180, RULE_narrow_expression = 181, RULE_new_expression = 182, 
		RULE_self_expression = 183, RULE_threadid_expression = 184, RULE_general_is_expression = 185, 
		RULE_is_expression = 186, RULE_type_judgement = 187, RULE_undefined_expression = 188, 
		RULE_precondition_expression = 189, RULE_isofbaseclass_expression = 190, 
		RULE_isofclass_expression = 191, RULE_samebaseclass_expression = 192, 
		RULE_sameclass_expression = 193, RULE_act_expression = 194, RULE_fin_expression = 195, 
		RULE_active_expression = 196, RULE_req_expression = 197, RULE_waiting_expression = 198, 
		RULE_time_expression = 199, RULE_name_list = 200, RULE_name = 201, RULE_old_name = 202, 
		RULE_symbolic_literal = 203, RULE_state_designator = 204, RULE_field_reference = 205, 
		RULE_map_seq_reference = 206, RULE_statement = 207, RULE_let_statement = 208, 
		RULE_local_definition_list = 209, RULE_local_definition = 210, RULE_let_be_statement = 211, 
		RULE_def_statement = 212, RULE_equals_definition_list = 213, RULE_equals_definition = 214, 
		RULE_block_statement = 215, RULE_dcl_statement = 216, RULE_assignment_definition = 217, 
		RULE_general_assignment_statement = 218, RULE_assignment_statement = 219, 
		RULE_multiple_assign_statement = 220, RULE_if_statement = 221, RULE_elseif_statement = 222, 
		RULE_cases_statement = 223, RULE_cases_statement_alternatives = 224, RULE_cases_statement_alternative = 225, 
		RULE_others_statement = 226, RULE_sequence_for_loop = 227, RULE_set_for_loop = 228, 
		RULE_index_for_loop = 229, RULE_while_loop = 230, RULE_nondeterministic_statement = 231, 
		RULE_call_statement = 232, RULE_return_statement = 233, RULE_pp_call_statement = 234, 
		RULE_object_designator = 235, RULE_object_field_reference = 236, RULE_object_apply = 237, 
		RULE_specification_statement = 238, RULE_start_statement = 239, RULE_start_list_statement = 240, 
		RULE_stop_statement = 241, RULE_stop_list_statement = 242, RULE_duration_statement = 243, 
		RULE_cycles_statement = 244, RULE_always_statement = 245, RULE_trap_statement = 246, 
		RULE_recursive_trap_statement = 247, RULE_traps = 248, RULE_exit_statement = 249, 
		RULE_error_statement = 250, RULE_identity_statement = 251, RULE_pattern = 252, 
		RULE_pattern_identifier = 253, RULE_match_value = 254, RULE_set_enum_pattern = 255, 
		RULE_set_union_pattern = 256, RULE_seq_enum_pattern = 257, RULE_seq_conc_pattern = 258, 
		RULE_map_enum_pattern = 259, RULE_maplet_pattern_list = 260, RULE_maplet_pattern = 261, 
		RULE_map_union_pattern = 262, RULE_tupple_pattern = 263, RULE_record_pattern = 264, 
		RULE_pp_object_pattern = 265, RULE_field_pattern_list = 266, RULE_field_pattern = 267, 
		RULE_pattern_list = 268, RULE_pattern_bind = 269, RULE_bind = 270, RULE_set_bind = 271, 
		RULE_seq_bind = 272, RULE_type_bind = 273, RULE_bind_list = 274, RULE_multiple_bind = 275, 
		RULE_multiple_set_bind = 276, RULE_multiple_seq_bind = 277, RULE_multiple_type_bind = 278, 
		RULE_type_bind_list = 279;
	private static String[] makeRuleNames() {
		return new String[] {
			"sl_document", "module", "sl_interface", "import_definition_list", "import_definition", 
			"import_module_signature", "import_signature", "import_types_signature", 
			"type_import", "import_values_signature", "value_import", "import_functions_signature", 
			"function_import", "import_operations_signature", "operation_import", 
			"export_definition", "export_module_signature", "export_signature", "export_types_signature", 
			"type_export", "export_values_signature", "value_signature", "export_functions_signature", 
			"function_signature", "export_operations_signature", "operation_signature", 
			"module_body", "rt_document", "system", "rt_class_body", "pp_class", 
			"inheritance_clause", "class_body", "rt_definition_block", "pp_definition_block", 
			"sl_definition_block", "pp_type_definitions", "access_type_definition", 
			"access", "sl_type_definitions", "type_definition_list", "type_definition", 
			"invariant_type_definition", "type_specification", "type", "void_function_type", 
			"bracketed_type", "basic_type", "quote_type", "composite_type", "field", 
			"union_type", "product_type", "optional_type", "set_type", "set0_type", 
			"set1_type", "seq_type", "seq0_type", "seq1_type", "map_type", "general_map_type", 
			"injective_map_type", "function_type", "partial_function_type", "total_function_type", 
			"discretionary_type", "type_name", "type_variable", "invariant", "eq_clause", 
			"ord_clause", "invariant_initial_function", "state_definition", "initialisation", 
			"sl_value_definitions", "pp_value_definitions", "access_value_definition", 
			"value_definition", "sl_function_definitions", "pp_function_definitions", 
			"access_function_definition", "function_definition", "explicit_function_definition", 
			"pre_expression", "post_expression", "measure_definition", "implicit_function_definition", 
			"extended_explicit_function_definition", "type_variable_list", "parameter_types", 
			"pattern_type_pair_list", "identifier_type_pair_list", "identifier_type_pair", 
			"parameters", "function_body", "measure_body", "sl_operation_definitions", 
			"sl_access_operation_definition", "pp_operation_definitions", "pp_access_operation_definition", 
			"rt_operation_definitions", "rt_access_operation_definition", "operation_definition", 
			"explicit_operation_definition", "implicit_operation_definition", "implicit_operation_body", 
			"extended_explicit_operation_definition", "operation_type", "operation_body", 
			"externals", "var_information", "vdmmode", "exceptions", "error", "instance_variable_definitions", 
			"instance_variable_definition", "access_assignment_definition", "invariant_definition", 
			"synchronization_definitions", "synchronization", "permission_predicates", 
			"mutex_predicate", "thread_definitions", "thread_definition", "periodic_thread_definition", 
			"periodic_obligation", "sporadic_obligation", "procedural_thread_definition", 
			"traces_definitions", "named_trace_list", "named_trace", "trace_definition_list", 
			"trace_definition_term", "trace_definition", "trace_binding_definition", 
			"trace_let_def_binding", "trace_let_best_binding", "trace_repeat_definition", 
			"trace_core_definition", "trace_apply_expression", "trace_concurrent_expression", 
			"trace_bracketed_expression", "annotations", "expression_list", "expression", 
			"bracketed_expression", "let_expression", "let_be_expression", "def_expression", 
			"if_expression", "elseif_expression", "cases_expression", "cases_expression_alternatives", 
			"cases_expression_alternative", "others_expression", "unary_expression", 
			"quantified_expression", "all_expression", "exists_expression", "exists_unique_expression", 
			"iota_expression", "set_enumeration", "set_comprehension", "set_range_expression", 
			"sequence_enumeration", "sequence_comprehension", "subsequence", "map_enumeration", 
			"maplet", "map_comprehension", "tuple_constructor", "record_constructor", 
			"tight_record_name", "record_modifier", "record_modification", "apply", 
			"field_select", "tuple_select", "function_type_instantiation", "lambda_expression", 
			"narrow_expression", "new_expression", "self_expression", "threadid_expression", 
			"general_is_expression", "is_expression", "type_judgement", "undefined_expression", 
			"precondition_expression", "isofbaseclass_expression", "isofclass_expression", 
			"samebaseclass_expression", "sameclass_expression", "act_expression", 
			"fin_expression", "active_expression", "req_expression", "waiting_expression", 
			"time_expression", "name_list", "name", "old_name", "symbolic_literal", 
			"state_designator", "field_reference", "map_seq_reference", "statement", 
			"let_statement", "local_definition_list", "local_definition", "let_be_statement", 
			"def_statement", "equals_definition_list", "equals_definition", "block_statement", 
			"dcl_statement", "assignment_definition", "general_assignment_statement", 
			"assignment_statement", "multiple_assign_statement", "if_statement", 
			"elseif_statement", "cases_statement", "cases_statement_alternatives", 
			"cases_statement_alternative", "others_statement", "sequence_for_loop", 
			"set_for_loop", "index_for_loop", "while_loop", "nondeterministic_statement", 
			"call_statement", "return_statement", "pp_call_statement", "object_designator", 
			"object_field_reference", "object_apply", "specification_statement", 
			"start_statement", "start_list_statement", "stop_statement", "stop_list_statement", 
			"duration_statement", "cycles_statement", "always_statement", "trap_statement", 
			"recursive_trap_statement", "traps", "exit_statement", "error_statement", 
			"identity_statement", "pattern", "pattern_identifier", "match_value", 
			"set_enum_pattern", "set_union_pattern", "seq_enum_pattern", "seq_conc_pattern", 
			"map_enum_pattern", "maplet_pattern_list", "maplet_pattern", "map_union_pattern", 
			"tupple_pattern", "record_pattern", "pp_object_pattern", "field_pattern_list", 
			"field_pattern", "pattern_list", "pattern_bind", "bind", "set_bind", 
			"seq_bind", "type_bind", "bind_list", "multiple_bind", "multiple_set_bind", 
			"multiple_seq_bind", "multiple_type_bind", "type_bind_list"
		};
	}
	public static final String[] ruleNames = makeRuleNames();

	private static String[] makeLiteralNames() {
		return new String[] {
			null, null, null, null, null, null, null, null, null, null, null, "'abs'", 
			"'all'", "'always'", "'and'", "'as'", "'atomic'", "'bool'", "'by'", "'card'", 
			"'cases'", "'char'", "'compose'", "'comp'", "'conc'", "'dcl'", "'def'", 
			"'definitions'", "'dinter'", "'div'", "'do'", "'dom'", "'dunion'", "'elems'", 
			"'else'", "'elseif'", "'end'", "'eq'", "'error'", "'errs'", "'exists'", 
			"'exists1'", "'exit'", "'exports'", "'ext'", "'false'", "'floor'", "'for'", 
			"'forall'", "'from'", "'functions'", "'hd'", "'if'", "'in'", "'inds'", 
			"'inmap'", "'int'", "'inter'", "'imports'", "'init'", "'inv'", "'inverse'", 
			"'iota'", "'lambda'", "'len'", "'let'", "'map'", "'measure'", "'merge'", 
			"'mod'", "'module'", "'mk_'", "'mu'", "'munion'", "'narrow_'", "'nat'", 
			"'nat1'", "'nil'", "'not'", "'of'", "'operations'", "'or'", "'ord'", 
			"'others'", "'post'", "'power'", "'pre'", "'pure'", "'psubset'", "'rat'", 
			"'rd'", "'real'", "'rem'", "'renamed'", "'return'", "'reverse'", "'rng'", 
			"'skip'", "'state'", "'struct'", "'subset'", "'then'", "'tixe'", "'tl'", 
			"'to'", "'token'", "'traces'", "'trap'", "'true'", "'types'", "'undefined'", 
			"'union'", "'values'", "'with'", "'while'", "'wr'", "'RESULT'", null, 
			null, "'access'", "'instance'", "'isofbaseclass'", "'isofclass'", "'class'", 
			"'new'", "'obj_'", "'private'", "'protected'", "'public'", "'samebaseclass'", 
			"'sameclass'", "'self'", "'static'", "'variables'", "'#active'", "'#act'", 
			"'#fin'", "'#req'", "'#waiting'", "'async'", "'cycles'", "'duration'", 
			"'periodic'", "'per'", "'mutex'", "'sporadic'", "'start'", "'startlist'", 
			"'stop'", "'stoplist'", "'sync'", "'system'", "'time'", "'threadid'", 
			"'thread'", "'<=>'", "'<>'", "'<='", "'>='", "'=>'", "'**'", "'<-:'", 
			"'<:'", "':->'", "':>'", "'++'", "'<'", "'>'", "'/'", "'\\'", "'*'", 
			"'+'", "'-'", "'^'", "'='", "'--@'", "'||'", "'==>'", "':='", "'::'", 
			"'...'", "'|->'", "'=='", "'.#'", "'->'", "'+>'", "','", "'.'", "':'", 
			"';'", "'|'", "'?'", "'&'", "'`'", "'~'", null, "'('", "')'", "'['", 
			"']'", "'{'", "'}'"
		};
	}
	private static final String[] _LITERAL_NAMES = makeLiteralNames();
	private static String[] makeSymbolicNames() {
		return new String[] {
			null, "SLK_inys", "SLK_best", "SLK_ninset", "SLK_inset", "SLK_inseq", 
			"SLK_set1of", "SLK_setof", "SLK_seq1of", "SLK_seqof", "SLK_istest", "SLK_abs", 
			"SLK_all", "SLK_always", "SLK_and", "SLK_as", "SLK_atomic", "SLK_bool", 
			"SLK_by", "SLK_card", "SLK_cases", "SLK_char", "SLK_compose", "SLK_comp", 
			"SLK_conc", "SLK_dcl", "SLK_def", "SLK_definitions", "SLK_dinter", "SLK_div", 
			"SLK_do", "SLK_dom", "SLK_dunion", "SLK_elems", "SLK_else", "SLK_elseif", 
			"SLK_end", "SLK_eq", "SLK_error", "SLK_errs", "SLK_exists", "SLK_exists1", 
			"SLK_exit", "SLK_exports", "SLK_ext", "SLK_false", "SLK_floor", "SLK_for", 
			"SLK_forall", "SLK_from", "SLK_functions", "SLK_hd", "SLK_if", "SLK_in", 
			"SLK_inds", "SLK_inmap", "SLK_int", "SLK_inter", "SLK_imports", "SLK_init", 
			"SLK_inv", "SLK_inverse", "SLK_iota", "SLK_lambda", "SLK_len", "SLK_let", 
			"SLK_map", "SLK_measure", "SLK_merge", "SLK_mod", "SLK_module", "SLK_mk", 
			"SLK_mu", "SLK_munion", "SLK_narrow", "SLK_nat", "SLK_nat1", "SLK_nil", 
			"SLK_not", "SLK_of", "SLK_operations", "SLK_or", "SLK_ord", "SLK_others", 
			"SLK_post", "SLK_power", "SLK_pre", "SLK_pure", "SLK_psubset", "SLK_rat", 
			"SLK_rd", "SLK_real", "SLK_rem", "SLK_renamed", "SLK_return", "SLK_reverse", 
			"SLK_rng", "SLK_skip", "SLK_state", "SLK_struct", "SLK_subset", "SLK_then", 
			"SLK_tixe", "SLK_tl", "SLK_to", "SLK_token", "SLK_traces", "SLK_trap", 
			"SLK_true", "SLK_types", "SLK_undefined", "SLK_union", "SLK_values", 
			"SLK_with", "SLK_while", "SLK_wr", "SLK_RESULT", "PPK_isr", "PPK_isc", 
			"PPK_access", "PPK_instance", "PPK_ibc", "PPK_ioc", "PPK_class", "PPK_new", 
			"PPK_obj", "PPK_private", "PPK_protected", "PPK_public", "PPK_sbc", "PPK_sc", 
			"PPK_self", "PPK_static", "PPK_variables", "RTK_active", "RTK_act", "RTK_fin", 
			"RTK_req", "RTK_waiting", "RTK_async", "RTK_cycles", "RTK_duration", 
			"RTK_periodic", "RTK_per", "RTK_mutex", "RTK_sporadic", "RTK_start", 
			"RTK_startlist", "RTK_stop", "RTK_stoplist", "RTK_sync", "RTK_system", 
			"RTK_time", "RTK_threadid", "RTK_thread", "O_IFF", "O_NEQ", "O_LEQ", 
			"O_GEQ", "O_IMPLIES", "O_EXP", "O_NDRES", "O_DRES", "O_NRRES", "O_RRES", 
			"O_OVERRIDE", "O_LT", "O_GT", "O_DIV", "O_DIFF", "O_TIMES", "O_PLUS", 
			"O_MINUS", "O_CONCAT", "O_EQUAL", "SEP_ann", "SEP_parallel", "SEP_optype", 
			"SEP_assign", "SEP_rec", "SEP_range", "SEP_maplet", "SEP_def", "SEP_tsel", 
			"SEP_pfcn", "SEP_tfcn", "SEP_comma", "SEP_dot", "SEP_colon", "SEP_scolon", 
			"SEP_bar", "SEP_qm", "SEP_amp", "SEP_tick", "SEP_old", "SEP_underscore", 
			"PAREN_L", "PAREN_R", "BRACKET_L", "BRACKET_R", "BRACE_L", "BRACE_R", 
			"QUOTE_LITERAL", "TYPE_VARIABLE_IDENTIFIER", "NUMERIC_LITERAL", "CHARACTER_LITERAL", 
			"TEXT_LITERAL", "IDENTIFIER", "NUMERAL", "SPACE", "TAB", "CR", "SINGLE_LINE_COMMENT", 
			"MULTIPLE_LINE_COMMENT", "UnrecognizedChar"
		};
	}
	private static final String[] _SYMBOLIC_NAMES = makeSymbolicNames();
	public static final Vocabulary VOCABULARY = new VocabularyImpl(_LITERAL_NAMES, _SYMBOLIC_NAMES);

	/**
	 * @deprecated Use {@link #VOCABULARY} instead.
	 */
	@Deprecated
	public static final String[] tokenNames;
	static {
		tokenNames = new String[_SYMBOLIC_NAMES.length];
		for (int i = 0; i < tokenNames.length; i++) {
			tokenNames[i] = VOCABULARY.getLiteralName(i);
			if (tokenNames[i] == null) {
				tokenNames[i] = VOCABULARY.getSymbolicName(i);
			}

			if (tokenNames[i] == null) {
				tokenNames[i] = "<INVALID>";
			}
		}
	}

	@Override
	@Deprecated
	public String[] getTokenNames() {
		return tokenNames;
	}

	@Override

	public Vocabulary getVocabulary() {
		return VOCABULARY;
	}

	@Override
	public String getGrammarFileName() { return "VDM.g4"; }

	@Override
	public String[] getRuleNames() { return ruleNames; }

	@Override
	public String getSerializedATN() { return _serializedATN; }

	@Override
	public ATN getATN() { return _ATN; }


	    // We can gate productions with the corresponding dialect given via semantic predicates on PP and RT productions
	    // See ANTLR4 book Section 11.1 Recognizing Multiple Language Dialect
	    //public static Dialect dialect = Dialect.VDM_SL;

	    public static boolean isVDMSL()
	    {
	        return true;//dialect == Dialect.VDM_SL;
	    }

	    public static boolean isVDMPP()
	    {
	        return false;//dialect == Dialect.VDM_PP;
	    }

	    public static boolean isVDMRT()
	    {
	        return false;//dialect == Dialect.VDM_RT;
	    }

	public VDMParser(TokenStream input) {
		super(input);
		_interp = new ParserATNSimulator(this,_ATN,_decisionToDFA,_sharedContextCache);
	}

	public static class Sl_documentContext extends ParserRuleContext {
		public List<ModuleContext> module() {
			return getRuleContexts(ModuleContext.class);
		}
		public ModuleContext module(int i) {
			return getRuleContext(ModuleContext.class,i);
		}
		public List<Sl_definition_blockContext> sl_definition_block() {
			return getRuleContexts(Sl_definition_blockContext.class);
		}
		public Sl_definition_blockContext sl_definition_block(int i) {
			return getRuleContext(Sl_definition_blockContext.class,i);
		}
		public Sl_documentContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_sl_document; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterSl_document(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitSl_document(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitSl_document(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Sl_documentContext sl_document() throws RecognitionException {
		Sl_documentContext _localctx = new Sl_documentContext(_ctx, getState());
		enterRule(_localctx, 0, RULE_sl_document);
		int _la;
		try {
			setState(570);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case SLK_module:
				enterOuterAlt(_localctx, 1);
				{
				setState(561); 
				_errHandler.sync(this);
				_la = _input.LA(1);
				do {
					{
					{
					setState(560);
					module();
					}
					}
					setState(563); 
					_errHandler.sync(this);
					_la = _input.LA(1);
				} while ( _la==SLK_module );
				}
				break;
			case SLK_functions:
			case SLK_operations:
			case SLK_state:
			case SLK_traces:
			case SLK_types:
			case SLK_values:
				enterOuterAlt(_localctx, 2);
				{
				setState(566); 
				_errHandler.sync(this);
				_la = _input.LA(1);
				do {
					{
					{
					setState(565);
					sl_definition_block();
					}
					}
					setState(568); 
					_errHandler.sync(this);
					_la = _input.LA(1);
				} while ( ((((_la - 50)) & ~0x3f) == 0 && ((1L << (_la - 50)) & ((1L << (SLK_functions - 50)) | (1L << (SLK_operations - 50)) | (1L << (SLK_state - 50)) | (1L << (SLK_traces - 50)) | (1L << (SLK_types - 50)) | (1L << (SLK_values - 50)))) != 0) );
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ModuleContext extends ParserRuleContext {
		public Token modName;
		public Token mod_Name;
		public TerminalNode SLK_module() { return getToken(VDMParser.SLK_module, 0); }
		public Sl_interfaceContext sl_interface() {
			return getRuleContext(Sl_interfaceContext.class,0);
		}
		public TerminalNode SLK_end() { return getToken(VDMParser.SLK_end, 0); }
		public List<TerminalNode> IDENTIFIER() { return getTokens(VDMParser.IDENTIFIER); }
		public TerminalNode IDENTIFIER(int i) {
			return getToken(VDMParser.IDENTIFIER, i);
		}
		public Module_bodyContext module_body() {
			return getRuleContext(Module_bodyContext.class,0);
		}
		public ModuleContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_module; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterModule(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitModule(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitModule(this);
			else return visitor.visitChildren(this);
		}
	}

	public final ModuleContext module() throws RecognitionException {
		ModuleContext _localctx = new ModuleContext(_ctx, getState());
		enterRule(_localctx, 2, RULE_module);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(572);
			match(SLK_module);
			setState(573);
			((ModuleContext)_localctx).modName = match(IDENTIFIER);
			setState(574);
			sl_interface();
			setState(576);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SLK_definitions) {
				{
				setState(575);
				module_body();
				}
			}

			setState(578);
			match(SLK_end);
			setState(579);
			((ModuleContext)_localctx).mod_Name = match(IDENTIFIER);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Sl_interfaceContext extends ParserRuleContext {
		public Export_definitionContext export_definition() {
			return getRuleContext(Export_definitionContext.class,0);
		}
		public Import_definition_listContext import_definition_list() {
			return getRuleContext(Import_definition_listContext.class,0);
		}
		public Sl_interfaceContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_sl_interface; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterSl_interface(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitSl_interface(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitSl_interface(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Sl_interfaceContext sl_interface() throws RecognitionException {
		Sl_interfaceContext _localctx = new Sl_interfaceContext(_ctx, getState());
		enterRule(_localctx, 4, RULE_sl_interface);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(582);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SLK_imports) {
				{
				setState(581);
				import_definition_list();
				}
			}

			setState(584);
			export_definition();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Import_definition_listContext extends ParserRuleContext {
		public TerminalNode SLK_imports() { return getToken(VDMParser.SLK_imports, 0); }
		public List<Import_definitionContext> import_definition() {
			return getRuleContexts(Import_definitionContext.class);
		}
		public Import_definitionContext import_definition(int i) {
			return getRuleContext(Import_definitionContext.class,i);
		}
		public List<TerminalNode> SEP_comma() { return getTokens(VDMParser.SEP_comma); }
		public TerminalNode SEP_comma(int i) {
			return getToken(VDMParser.SEP_comma, i);
		}
		public Import_definition_listContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_import_definition_list; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterImport_definition_list(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitImport_definition_list(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitImport_definition_list(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Import_definition_listContext import_definition_list() throws RecognitionException {
		Import_definition_listContext _localctx = new Import_definition_listContext(_ctx, getState());
		enterRule(_localctx, 6, RULE_import_definition_list);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(586);
			match(SLK_imports);
			setState(587);
			import_definition();
			setState(592);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==SEP_comma) {
				{
				{
				setState(588);
				match(SEP_comma);
				setState(589);
				import_definition();
				}
				}
				setState(594);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Import_definitionContext extends ParserRuleContext {
		public TerminalNode SLK_from() { return getToken(VDMParser.SLK_from, 0); }
		public TerminalNode IDENTIFIER() { return getToken(VDMParser.IDENTIFIER, 0); }
		public Import_module_signatureContext import_module_signature() {
			return getRuleContext(Import_module_signatureContext.class,0);
		}
		public Import_definitionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_import_definition; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterImport_definition(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitImport_definition(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitImport_definition(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Import_definitionContext import_definition() throws RecognitionException {
		Import_definitionContext _localctx = new Import_definitionContext(_ctx, getState());
		enterRule(_localctx, 8, RULE_import_definition);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(595);
			match(SLK_from);
			setState(596);
			match(IDENTIFIER);
			setState(597);
			import_module_signature();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Import_module_signatureContext extends ParserRuleContext {
		public TerminalNode SLK_all() { return getToken(VDMParser.SLK_all, 0); }
		public List<Import_signatureContext> import_signature() {
			return getRuleContexts(Import_signatureContext.class);
		}
		public Import_signatureContext import_signature(int i) {
			return getRuleContext(Import_signatureContext.class,i);
		}
		public Import_module_signatureContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_import_module_signature; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterImport_module_signature(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitImport_module_signature(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitImport_module_signature(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Import_module_signatureContext import_module_signature() throws RecognitionException {
		Import_module_signatureContext _localctx = new Import_module_signatureContext(_ctx, getState());
		enterRule(_localctx, 10, RULE_import_module_signature);
		int _la;
		try {
			setState(605);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case SLK_all:
				enterOuterAlt(_localctx, 1);
				{
				setState(599);
				match(SLK_all);
				}
				break;
			case SLK_functions:
			case SLK_operations:
			case SLK_types:
			case SLK_values:
				enterOuterAlt(_localctx, 2);
				{
				setState(601); 
				_errHandler.sync(this);
				_la = _input.LA(1);
				do {
					{
					{
					setState(600);
					import_signature();
					}
					}
					setState(603); 
					_errHandler.sync(this);
					_la = _input.LA(1);
				} while ( ((((_la - 50)) & ~0x3f) == 0 && ((1L << (_la - 50)) & ((1L << (SLK_functions - 50)) | (1L << (SLK_operations - 50)) | (1L << (SLK_types - 50)) | (1L << (SLK_values - 50)))) != 0) );
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Import_signatureContext extends ParserRuleContext {
		public Import_types_signatureContext import_types_signature() {
			return getRuleContext(Import_types_signatureContext.class,0);
		}
		public Import_values_signatureContext import_values_signature() {
			return getRuleContext(Import_values_signatureContext.class,0);
		}
		public Import_functions_signatureContext import_functions_signature() {
			return getRuleContext(Import_functions_signatureContext.class,0);
		}
		public Import_operations_signatureContext import_operations_signature() {
			return getRuleContext(Import_operations_signatureContext.class,0);
		}
		public Import_signatureContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_import_signature; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterImport_signature(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitImport_signature(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitImport_signature(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Import_signatureContext import_signature() throws RecognitionException {
		Import_signatureContext _localctx = new Import_signatureContext(_ctx, getState());
		enterRule(_localctx, 12, RULE_import_signature);
		try {
			setState(611);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case SLK_types:
				enterOuterAlt(_localctx, 1);
				{
				setState(607);
				import_types_signature();
				}
				break;
			case SLK_values:
				enterOuterAlt(_localctx, 2);
				{
				setState(608);
				import_values_signature();
				}
				break;
			case SLK_functions:
				enterOuterAlt(_localctx, 3);
				{
				setState(609);
				import_functions_signature();
				}
				break;
			case SLK_operations:
				enterOuterAlt(_localctx, 4);
				{
				setState(610);
				import_operations_signature();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Import_types_signatureContext extends ParserRuleContext {
		public TerminalNode SLK_types() { return getToken(VDMParser.SLK_types, 0); }
		public List<Type_importContext> type_import() {
			return getRuleContexts(Type_importContext.class);
		}
		public Type_importContext type_import(int i) {
			return getRuleContext(Type_importContext.class,i);
		}
		public List<TerminalNode> SEP_scolon() { return getTokens(VDMParser.SEP_scolon); }
		public TerminalNode SEP_scolon(int i) {
			return getToken(VDMParser.SEP_scolon, i);
		}
		public Import_types_signatureContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_import_types_signature; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterImport_types_signature(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitImport_types_signature(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitImport_types_signature(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Import_types_signatureContext import_types_signature() throws RecognitionException {
		Import_types_signatureContext _localctx = new Import_types_signatureContext(_ctx, getState());
		enterRule(_localctx, 14, RULE_import_types_signature);
		int _la;
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(613);
			match(SLK_types);
			setState(614);
			type_import();
			setState(619);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,9,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					{
					{
					setState(615);
					match(SEP_scolon);
					setState(616);
					type_import();
					}
					} 
				}
				setState(621);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,9,_ctx);
			}
			setState(623);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SEP_scolon) {
				{
				setState(622);
				match(SEP_scolon);
				}
			}

			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Type_importContext extends ParserRuleContext {
		public List<NameContext> name() {
			return getRuleContexts(NameContext.class);
		}
		public NameContext name(int i) {
			return getRuleContext(NameContext.class,i);
		}
		public TerminalNode SLK_renamed() { return getToken(VDMParser.SLK_renamed, 0); }
		public Type_definitionContext type_definition() {
			return getRuleContext(Type_definitionContext.class,0);
		}
		public Type_importContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_type_import; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterType_import(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitType_import(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitType_import(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Type_importContext type_import() throws RecognitionException {
		Type_importContext _localctx = new Type_importContext(_ctx, getState());
		enterRule(_localctx, 16, RULE_type_import);
		int _la;
		try {
			setState(635);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,13,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(625);
				name();
				setState(628);
				_errHandler.sync(this);
				_la = _input.LA(1);
				if (_la==SLK_renamed) {
					{
					setState(626);
					match(SLK_renamed);
					setState(627);
					name();
					}
				}

				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(630);
				type_definition();
				setState(633);
				_errHandler.sync(this);
				_la = _input.LA(1);
				if (_la==SLK_renamed) {
					{
					setState(631);
					match(SLK_renamed);
					setState(632);
					name();
					}
				}

				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Import_values_signatureContext extends ParserRuleContext {
		public TerminalNode SLK_values() { return getToken(VDMParser.SLK_values, 0); }
		public List<Value_importContext> value_import() {
			return getRuleContexts(Value_importContext.class);
		}
		public Value_importContext value_import(int i) {
			return getRuleContext(Value_importContext.class,i);
		}
		public List<TerminalNode> SEP_scolon() { return getTokens(VDMParser.SEP_scolon); }
		public TerminalNode SEP_scolon(int i) {
			return getToken(VDMParser.SEP_scolon, i);
		}
		public Import_values_signatureContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_import_values_signature; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterImport_values_signature(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitImport_values_signature(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitImport_values_signature(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Import_values_signatureContext import_values_signature() throws RecognitionException {
		Import_values_signatureContext _localctx = new Import_values_signatureContext(_ctx, getState());
		enterRule(_localctx, 18, RULE_import_values_signature);
		int _la;
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(637);
			match(SLK_values);
			setState(638);
			value_import();
			setState(643);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,14,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					{
					{
					setState(639);
					match(SEP_scolon);
					setState(640);
					value_import();
					}
					} 
				}
				setState(645);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,14,_ctx);
			}
			setState(647);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SEP_scolon) {
				{
				setState(646);
				match(SEP_scolon);
				}
			}

			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Value_importContext extends ParserRuleContext {
		public List<NameContext> name() {
			return getRuleContexts(NameContext.class);
		}
		public NameContext name(int i) {
			return getRuleContext(NameContext.class,i);
		}
		public TerminalNode SEP_colon() { return getToken(VDMParser.SEP_colon, 0); }
		public TypeContext type() {
			return getRuleContext(TypeContext.class,0);
		}
		public TerminalNode SLK_renamed() { return getToken(VDMParser.SLK_renamed, 0); }
		public Value_importContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_value_import; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterValue_import(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitValue_import(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitValue_import(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Value_importContext value_import() throws RecognitionException {
		Value_importContext _localctx = new Value_importContext(_ctx, getState());
		enterRule(_localctx, 20, RULE_value_import);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(649);
			name();
			setState(652);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SEP_colon) {
				{
				setState(650);
				match(SEP_colon);
				setState(651);
				type(0);
				}
			}

			setState(656);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SLK_renamed) {
				{
				setState(654);
				match(SLK_renamed);
				setState(655);
				name();
				}
			}

			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Import_functions_signatureContext extends ParserRuleContext {
		public TerminalNode SLK_functions() { return getToken(VDMParser.SLK_functions, 0); }
		public List<Function_importContext> function_import() {
			return getRuleContexts(Function_importContext.class);
		}
		public Function_importContext function_import(int i) {
			return getRuleContext(Function_importContext.class,i);
		}
		public List<TerminalNode> SEP_scolon() { return getTokens(VDMParser.SEP_scolon); }
		public TerminalNode SEP_scolon(int i) {
			return getToken(VDMParser.SEP_scolon, i);
		}
		public Import_functions_signatureContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_import_functions_signature; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterImport_functions_signature(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitImport_functions_signature(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitImport_functions_signature(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Import_functions_signatureContext import_functions_signature() throws RecognitionException {
		Import_functions_signatureContext _localctx = new Import_functions_signatureContext(_ctx, getState());
		enterRule(_localctx, 22, RULE_import_functions_signature);
		int _la;
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(658);
			match(SLK_functions);
			setState(659);
			function_import();
			setState(664);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,18,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					{
					{
					setState(660);
					match(SEP_scolon);
					setState(661);
					function_import();
					}
					} 
				}
				setState(666);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,18,_ctx);
			}
			setState(668);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SEP_scolon) {
				{
				setState(667);
				match(SEP_scolon);
				}
			}

			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Function_importContext extends ParserRuleContext {
		public List<NameContext> name() {
			return getRuleContexts(NameContext.class);
		}
		public NameContext name(int i) {
			return getRuleContext(NameContext.class,i);
		}
		public TerminalNode SEP_colon() { return getToken(VDMParser.SEP_colon, 0); }
		public Function_typeContext function_type() {
			return getRuleContext(Function_typeContext.class,0);
		}
		public TerminalNode SLK_renamed() { return getToken(VDMParser.SLK_renamed, 0); }
		public Type_variable_listContext type_variable_list() {
			return getRuleContext(Type_variable_listContext.class,0);
		}
		public Function_importContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_function_import; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterFunction_import(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitFunction_import(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitFunction_import(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Function_importContext function_import() throws RecognitionException {
		Function_importContext _localctx = new Function_importContext(_ctx, getState());
		enterRule(_localctx, 24, RULE_function_import);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(670);
			name();
			setState(676);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SEP_colon || _la==BRACKET_L) {
				{
				setState(672);
				_errHandler.sync(this);
				_la = _input.LA(1);
				if (_la==BRACKET_L) {
					{
					setState(671);
					type_variable_list();
					}
				}

				setState(674);
				match(SEP_colon);
				setState(675);
				function_type();
				}
			}

			setState(680);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SLK_renamed) {
				{
				setState(678);
				match(SLK_renamed);
				setState(679);
				name();
				}
			}

			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Import_operations_signatureContext extends ParserRuleContext {
		public TerminalNode SLK_operations() { return getToken(VDMParser.SLK_operations, 0); }
		public List<Operation_importContext> operation_import() {
			return getRuleContexts(Operation_importContext.class);
		}
		public Operation_importContext operation_import(int i) {
			return getRuleContext(Operation_importContext.class,i);
		}
		public List<TerminalNode> SEP_scolon() { return getTokens(VDMParser.SEP_scolon); }
		public TerminalNode SEP_scolon(int i) {
			return getToken(VDMParser.SEP_scolon, i);
		}
		public Import_operations_signatureContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_import_operations_signature; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterImport_operations_signature(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitImport_operations_signature(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitImport_operations_signature(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Import_operations_signatureContext import_operations_signature() throws RecognitionException {
		Import_operations_signatureContext _localctx = new Import_operations_signatureContext(_ctx, getState());
		enterRule(_localctx, 26, RULE_import_operations_signature);
		int _la;
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(682);
			match(SLK_operations);
			setState(683);
			operation_import();
			setState(688);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,23,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					{
					{
					setState(684);
					match(SEP_scolon);
					setState(685);
					operation_import();
					}
					} 
				}
				setState(690);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,23,_ctx);
			}
			setState(692);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SEP_scolon) {
				{
				setState(691);
				match(SEP_scolon);
				}
			}

			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Operation_importContext extends ParserRuleContext {
		public List<NameContext> name() {
			return getRuleContexts(NameContext.class);
		}
		public NameContext name(int i) {
			return getRuleContext(NameContext.class,i);
		}
		public TerminalNode SEP_colon() { return getToken(VDMParser.SEP_colon, 0); }
		public Operation_typeContext operation_type() {
			return getRuleContext(Operation_typeContext.class,0);
		}
		public TerminalNode SLK_renamed() { return getToken(VDMParser.SLK_renamed, 0); }
		public Operation_importContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_operation_import; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterOperation_import(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitOperation_import(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitOperation_import(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Operation_importContext operation_import() throws RecognitionException {
		Operation_importContext _localctx = new Operation_importContext(_ctx, getState());
		enterRule(_localctx, 28, RULE_operation_import);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(694);
			name();
			setState(697);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SEP_colon) {
				{
				setState(695);
				match(SEP_colon);
				setState(696);
				operation_type();
				}
			}

			setState(701);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SLK_renamed) {
				{
				setState(699);
				match(SLK_renamed);
				setState(700);
				name();
				}
			}

			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Export_definitionContext extends ParserRuleContext {
		public TerminalNode SLK_exports() { return getToken(VDMParser.SLK_exports, 0); }
		public Export_module_signatureContext export_module_signature() {
			return getRuleContext(Export_module_signatureContext.class,0);
		}
		public Export_definitionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_export_definition; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterExport_definition(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitExport_definition(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitExport_definition(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Export_definitionContext export_definition() throws RecognitionException {
		Export_definitionContext _localctx = new Export_definitionContext(_ctx, getState());
		enterRule(_localctx, 30, RULE_export_definition);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(703);
			match(SLK_exports);
			setState(704);
			export_module_signature();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Export_module_signatureContext extends ParserRuleContext {
		public TerminalNode SLK_all() { return getToken(VDMParser.SLK_all, 0); }
		public List<Export_signatureContext> export_signature() {
			return getRuleContexts(Export_signatureContext.class);
		}
		public Export_signatureContext export_signature(int i) {
			return getRuleContext(Export_signatureContext.class,i);
		}
		public Export_module_signatureContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_export_module_signature; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterExport_module_signature(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitExport_module_signature(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitExport_module_signature(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Export_module_signatureContext export_module_signature() throws RecognitionException {
		Export_module_signatureContext _localctx = new Export_module_signatureContext(_ctx, getState());
		enterRule(_localctx, 32, RULE_export_module_signature);
		int _la;
		try {
			setState(712);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case SLK_all:
				enterOuterAlt(_localctx, 1);
				{
				setState(706);
				match(SLK_all);
				}
				break;
			case SLK_functions:
			case SLK_operations:
			case SLK_types:
			case SLK_values:
				enterOuterAlt(_localctx, 2);
				{
				setState(708); 
				_errHandler.sync(this);
				_la = _input.LA(1);
				do {
					{
					{
					setState(707);
					export_signature();
					}
					}
					setState(710); 
					_errHandler.sync(this);
					_la = _input.LA(1);
				} while ( ((((_la - 50)) & ~0x3f) == 0 && ((1L << (_la - 50)) & ((1L << (SLK_functions - 50)) | (1L << (SLK_operations - 50)) | (1L << (SLK_types - 50)) | (1L << (SLK_values - 50)))) != 0) );
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Export_signatureContext extends ParserRuleContext {
		public Export_types_signatureContext export_types_signature() {
			return getRuleContext(Export_types_signatureContext.class,0);
		}
		public Export_values_signatureContext export_values_signature() {
			return getRuleContext(Export_values_signatureContext.class,0);
		}
		public Export_functions_signatureContext export_functions_signature() {
			return getRuleContext(Export_functions_signatureContext.class,0);
		}
		public Export_operations_signatureContext export_operations_signature() {
			return getRuleContext(Export_operations_signatureContext.class,0);
		}
		public Export_signatureContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_export_signature; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterExport_signature(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitExport_signature(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitExport_signature(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Export_signatureContext export_signature() throws RecognitionException {
		Export_signatureContext _localctx = new Export_signatureContext(_ctx, getState());
		enterRule(_localctx, 34, RULE_export_signature);
		try {
			setState(718);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case SLK_types:
				enterOuterAlt(_localctx, 1);
				{
				setState(714);
				export_types_signature();
				}
				break;
			case SLK_values:
				enterOuterAlt(_localctx, 2);
				{
				setState(715);
				export_values_signature();
				}
				break;
			case SLK_functions:
				enterOuterAlt(_localctx, 3);
				{
				setState(716);
				export_functions_signature();
				}
				break;
			case SLK_operations:
				enterOuterAlt(_localctx, 4);
				{
				setState(717);
				export_operations_signature();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Export_types_signatureContext extends ParserRuleContext {
		public TerminalNode SLK_types() { return getToken(VDMParser.SLK_types, 0); }
		public List<Type_exportContext> type_export() {
			return getRuleContexts(Type_exportContext.class);
		}
		public Type_exportContext type_export(int i) {
			return getRuleContext(Type_exportContext.class,i);
		}
		public List<TerminalNode> SEP_scolon() { return getTokens(VDMParser.SEP_scolon); }
		public TerminalNode SEP_scolon(int i) {
			return getToken(VDMParser.SEP_scolon, i);
		}
		public Export_types_signatureContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_export_types_signature; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterExport_types_signature(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitExport_types_signature(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitExport_types_signature(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Export_types_signatureContext export_types_signature() throws RecognitionException {
		Export_types_signatureContext _localctx = new Export_types_signatureContext(_ctx, getState());
		enterRule(_localctx, 36, RULE_export_types_signature);
		int _la;
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(720);
			match(SLK_types);
			setState(721);
			type_export();
			setState(726);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,30,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					{
					{
					setState(722);
					match(SEP_scolon);
					setState(723);
					type_export();
					}
					} 
				}
				setState(728);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,30,_ctx);
			}
			setState(730);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SEP_scolon) {
				{
				setState(729);
				match(SEP_scolon);
				}
			}

			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Type_exportContext extends ParserRuleContext {
		public NameContext name() {
			return getRuleContext(NameContext.class,0);
		}
		public TerminalNode SLK_struct() { return getToken(VDMParser.SLK_struct, 0); }
		public Type_exportContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_type_export; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterType_export(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitType_export(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitType_export(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Type_exportContext type_export() throws RecognitionException {
		Type_exportContext _localctx = new Type_exportContext(_ctx, getState());
		enterRule(_localctx, 38, RULE_type_export);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(733);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SLK_struct) {
				{
				setState(732);
				match(SLK_struct);
				}
			}

			setState(735);
			name();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Export_values_signatureContext extends ParserRuleContext {
		public TerminalNode SLK_values() { return getToken(VDMParser.SLK_values, 0); }
		public List<Value_signatureContext> value_signature() {
			return getRuleContexts(Value_signatureContext.class);
		}
		public Value_signatureContext value_signature(int i) {
			return getRuleContext(Value_signatureContext.class,i);
		}
		public List<TerminalNode> SEP_scolon() { return getTokens(VDMParser.SEP_scolon); }
		public TerminalNode SEP_scolon(int i) {
			return getToken(VDMParser.SEP_scolon, i);
		}
		public Export_values_signatureContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_export_values_signature; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterExport_values_signature(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitExport_values_signature(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitExport_values_signature(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Export_values_signatureContext export_values_signature() throws RecognitionException {
		Export_values_signatureContext _localctx = new Export_values_signatureContext(_ctx, getState());
		enterRule(_localctx, 40, RULE_export_values_signature);
		int _la;
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(737);
			match(SLK_values);
			setState(738);
			value_signature();
			setState(743);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,33,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					{
					{
					setState(739);
					match(SEP_scolon);
					setState(740);
					value_signature();
					}
					} 
				}
				setState(745);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,33,_ctx);
			}
			setState(747);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SEP_scolon) {
				{
				setState(746);
				match(SEP_scolon);
				}
			}

			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Value_signatureContext extends ParserRuleContext {
		public Name_listContext name_list() {
			return getRuleContext(Name_listContext.class,0);
		}
		public TerminalNode SEP_colon() { return getToken(VDMParser.SEP_colon, 0); }
		public TypeContext type() {
			return getRuleContext(TypeContext.class,0);
		}
		public Value_signatureContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_value_signature; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterValue_signature(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitValue_signature(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitValue_signature(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Value_signatureContext value_signature() throws RecognitionException {
		Value_signatureContext _localctx = new Value_signatureContext(_ctx, getState());
		enterRule(_localctx, 42, RULE_value_signature);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(749);
			name_list();
			setState(750);
			match(SEP_colon);
			setState(751);
			type(0);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Export_functions_signatureContext extends ParserRuleContext {
		public TerminalNode SLK_functions() { return getToken(VDMParser.SLK_functions, 0); }
		public List<Function_signatureContext> function_signature() {
			return getRuleContexts(Function_signatureContext.class);
		}
		public Function_signatureContext function_signature(int i) {
			return getRuleContext(Function_signatureContext.class,i);
		}
		public List<TerminalNode> SEP_scolon() { return getTokens(VDMParser.SEP_scolon); }
		public TerminalNode SEP_scolon(int i) {
			return getToken(VDMParser.SEP_scolon, i);
		}
		public Export_functions_signatureContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_export_functions_signature; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterExport_functions_signature(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitExport_functions_signature(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitExport_functions_signature(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Export_functions_signatureContext export_functions_signature() throws RecognitionException {
		Export_functions_signatureContext _localctx = new Export_functions_signatureContext(_ctx, getState());
		enterRule(_localctx, 44, RULE_export_functions_signature);
		int _la;
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(753);
			match(SLK_functions);
			setState(754);
			function_signature();
			setState(759);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,35,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					{
					{
					setState(755);
					match(SEP_scolon);
					setState(756);
					function_signature();
					}
					} 
				}
				setState(761);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,35,_ctx);
			}
			setState(763);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SEP_scolon) {
				{
				setState(762);
				match(SEP_scolon);
				}
			}

			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Function_signatureContext extends ParserRuleContext {
		public Name_listContext name_list() {
			return getRuleContext(Name_listContext.class,0);
		}
		public TerminalNode SEP_colon() { return getToken(VDMParser.SEP_colon, 0); }
		public Function_typeContext function_type() {
			return getRuleContext(Function_typeContext.class,0);
		}
		public Type_variable_listContext type_variable_list() {
			return getRuleContext(Type_variable_listContext.class,0);
		}
		public Function_signatureContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_function_signature; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterFunction_signature(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitFunction_signature(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitFunction_signature(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Function_signatureContext function_signature() throws RecognitionException {
		Function_signatureContext _localctx = new Function_signatureContext(_ctx, getState());
		enterRule(_localctx, 46, RULE_function_signature);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(765);
			name_list();
			setState(767);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==BRACKET_L) {
				{
				setState(766);
				type_variable_list();
				}
			}

			setState(769);
			match(SEP_colon);
			setState(770);
			function_type();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Export_operations_signatureContext extends ParserRuleContext {
		public TerminalNode SLK_operations() { return getToken(VDMParser.SLK_operations, 0); }
		public List<Operation_signatureContext> operation_signature() {
			return getRuleContexts(Operation_signatureContext.class);
		}
		public Operation_signatureContext operation_signature(int i) {
			return getRuleContext(Operation_signatureContext.class,i);
		}
		public List<TerminalNode> SEP_scolon() { return getTokens(VDMParser.SEP_scolon); }
		public TerminalNode SEP_scolon(int i) {
			return getToken(VDMParser.SEP_scolon, i);
		}
		public Export_operations_signatureContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_export_operations_signature; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterExport_operations_signature(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitExport_operations_signature(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitExport_operations_signature(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Export_operations_signatureContext export_operations_signature() throws RecognitionException {
		Export_operations_signatureContext _localctx = new Export_operations_signatureContext(_ctx, getState());
		enterRule(_localctx, 48, RULE_export_operations_signature);
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(772);
			match(SLK_operations);
			setState(773);
			operation_signature();
			setState(778);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,38,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					{
					{
					setState(774);
					match(SEP_scolon);
					setState(775);
					operation_signature();
					}
					} 
				}
				setState(780);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,38,_ctx);
			}
			setState(781);
			match(SEP_scolon);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Operation_signatureContext extends ParserRuleContext {
		public Name_listContext name_list() {
			return getRuleContext(Name_listContext.class,0);
		}
		public TerminalNode SEP_colon() { return getToken(VDMParser.SEP_colon, 0); }
		public Operation_typeContext operation_type() {
			return getRuleContext(Operation_typeContext.class,0);
		}
		public Operation_signatureContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_operation_signature; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterOperation_signature(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitOperation_signature(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitOperation_signature(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Operation_signatureContext operation_signature() throws RecognitionException {
		Operation_signatureContext _localctx = new Operation_signatureContext(_ctx, getState());
		enterRule(_localctx, 50, RULE_operation_signature);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(783);
			name_list();
			setState(784);
			match(SEP_colon);
			setState(785);
			operation_type();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Module_bodyContext extends ParserRuleContext {
		public TerminalNode SLK_definitions() { return getToken(VDMParser.SLK_definitions, 0); }
		public List<Sl_definition_blockContext> sl_definition_block() {
			return getRuleContexts(Sl_definition_blockContext.class);
		}
		public Sl_definition_blockContext sl_definition_block(int i) {
			return getRuleContext(Sl_definition_blockContext.class,i);
		}
		public Module_bodyContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_module_body; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterModule_body(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitModule_body(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitModule_body(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Module_bodyContext module_body() throws RecognitionException {
		Module_bodyContext _localctx = new Module_bodyContext(_ctx, getState());
		enterRule(_localctx, 52, RULE_module_body);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(787);
			match(SLK_definitions);
			setState(789); 
			_errHandler.sync(this);
			_la = _input.LA(1);
			do {
				{
				{
				setState(788);
				sl_definition_block();
				}
				}
				setState(791); 
				_errHandler.sync(this);
				_la = _input.LA(1);
			} while ( ((((_la - 50)) & ~0x3f) == 0 && ((1L << (_la - 50)) & ((1L << (SLK_functions - 50)) | (1L << (SLK_operations - 50)) | (1L << (SLK_state - 50)) | (1L << (SLK_traces - 50)) | (1L << (SLK_types - 50)) | (1L << (SLK_values - 50)))) != 0) );
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Rt_documentContext extends ParserRuleContext {
		public List<Pp_classContext> pp_class() {
			return getRuleContexts(Pp_classContext.class);
		}
		public Pp_classContext pp_class(int i) {
			return getRuleContext(Pp_classContext.class,i);
		}
		public List<SystemContext> system() {
			return getRuleContexts(SystemContext.class);
		}
		public SystemContext system(int i) {
			return getRuleContext(SystemContext.class,i);
		}
		public Rt_documentContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_rt_document; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterRt_document(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitRt_document(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitRt_document(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Rt_documentContext rt_document() throws RecognitionException {
		Rt_documentContext _localctx = new Rt_documentContext(_ctx, getState());
		enterRule(_localctx, 54, RULE_rt_document);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(795); 
			_errHandler.sync(this);
			_la = _input.LA(1);
			do {
				{
				setState(795);
				_errHandler.sync(this);
				switch (_input.LA(1)) {
				case PPK_class:
					{
					setState(793);
					pp_class();
					}
					break;
				case RTK_system:
					{
					setState(794);
					system();
					}
					break;
				default:
					throw new NoViableAltException(this);
				}
				}
				setState(797); 
				_errHandler.sync(this);
				_la = _input.LA(1);
			} while ( _la==PPK_class || _la==RTK_system );
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class SystemContext extends ParserRuleContext {
		public TerminalNode RTK_system() { return getToken(VDMParser.RTK_system, 0); }
		public List<TerminalNode> IDENTIFIER() { return getTokens(VDMParser.IDENTIFIER); }
		public TerminalNode IDENTIFIER(int i) {
			return getToken(VDMParser.IDENTIFIER, i);
		}
		public TerminalNode SLK_end() { return getToken(VDMParser.SLK_end, 0); }
		public Rt_class_bodyContext rt_class_body() {
			return getRuleContext(Rt_class_bodyContext.class,0);
		}
		public SystemContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_system; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterSystem(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitSystem(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitSystem(this);
			else return visitor.visitChildren(this);
		}
	}

	public final SystemContext system() throws RecognitionException {
		SystemContext _localctx = new SystemContext(_ctx, getState());
		enterRule(_localctx, 56, RULE_system);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(799);
			match(RTK_system);
			setState(800);
			match(IDENTIFIER);
			setState(802);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SLK_definitions) {
				{
				setState(801);
				rt_class_body();
				}
			}

			setState(804);
			match(SLK_end);
			setState(805);
			match(IDENTIFIER);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Rt_class_bodyContext extends ParserRuleContext {
		public TerminalNode SLK_definitions() { return getToken(VDMParser.SLK_definitions, 0); }
		public List<Rt_definition_blockContext> rt_definition_block() {
			return getRuleContexts(Rt_definition_blockContext.class);
		}
		public Rt_definition_blockContext rt_definition_block(int i) {
			return getRuleContext(Rt_definition_blockContext.class,i);
		}
		public Rt_class_bodyContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_rt_class_body; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterRt_class_body(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitRt_class_body(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitRt_class_body(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Rt_class_bodyContext rt_class_body() throws RecognitionException {
		Rt_class_bodyContext _localctx = new Rt_class_bodyContext(_ctx, getState());
		enterRule(_localctx, 58, RULE_rt_class_body);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(807);
			match(SLK_definitions);
			setState(809); 
			_errHandler.sync(this);
			_la = _input.LA(1);
			do {
				{
				{
				setState(808);
				rt_definition_block();
				}
				}
				setState(811); 
				_errHandler.sync(this);
				_la = _input.LA(1);
			} while ( ((((_la - 50)) & ~0x3f) == 0 && ((1L << (_la - 50)) & ((1L << (SLK_functions - 50)) | (1L << (SLK_operations - 50)) | (1L << (SLK_traces - 50)) | (1L << (SLK_types - 50)) | (1L << (SLK_values - 50)))) != 0) || ((((_la - 120)) & ~0x3f) == 0 && ((1L << (_la - 120)) & ((1L << (PPK_instance - 120)) | (1L << (RTK_sync - 120)) | (1L << (RTK_thread - 120)))) != 0) );
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Pp_classContext extends ParserRuleContext {
		public TerminalNode PPK_class() { return getToken(VDMParser.PPK_class, 0); }
		public List<TerminalNode> IDENTIFIER() { return getTokens(VDMParser.IDENTIFIER); }
		public TerminalNode IDENTIFIER(int i) {
			return getToken(VDMParser.IDENTIFIER, i);
		}
		public TerminalNode SLK_end() { return getToken(VDMParser.SLK_end, 0); }
		public Inheritance_clauseContext inheritance_clause() {
			return getRuleContext(Inheritance_clauseContext.class,0);
		}
		public Class_bodyContext class_body() {
			return getRuleContext(Class_bodyContext.class,0);
		}
		public Pp_classContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_pp_class; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterPp_class(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitPp_class(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitPp_class(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Pp_classContext pp_class() throws RecognitionException {
		Pp_classContext _localctx = new Pp_classContext(_ctx, getState());
		enterRule(_localctx, 60, RULE_pp_class);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(813);
			match(PPK_class);
			setState(814);
			match(IDENTIFIER);
			setState(816);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==PPK_isc) {
				{
				setState(815);
				inheritance_clause();
				}
			}

			setState(819);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SLK_definitions) {
				{
				setState(818);
				class_body();
				}
			}

			setState(821);
			match(SLK_end);
			setState(822);
			match(IDENTIFIER);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Inheritance_clauseContext extends ParserRuleContext {
		public TerminalNode PPK_isc() { return getToken(VDMParser.PPK_isc, 0); }
		public List<TerminalNode> IDENTIFIER() { return getTokens(VDMParser.IDENTIFIER); }
		public TerminalNode IDENTIFIER(int i) {
			return getToken(VDMParser.IDENTIFIER, i);
		}
		public List<TerminalNode> SEP_comma() { return getTokens(VDMParser.SEP_comma); }
		public TerminalNode SEP_comma(int i) {
			return getToken(VDMParser.SEP_comma, i);
		}
		public Inheritance_clauseContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_inheritance_clause; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterInheritance_clause(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitInheritance_clause(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitInheritance_clause(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Inheritance_clauseContext inheritance_clause() throws RecognitionException {
		Inheritance_clauseContext _localctx = new Inheritance_clauseContext(_ctx, getState());
		enterRule(_localctx, 62, RULE_inheritance_clause);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(824);
			match(PPK_isc);
			setState(825);
			match(IDENTIFIER);
			setState(830);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==SEP_comma) {
				{
				{
				setState(826);
				match(SEP_comma);
				setState(827);
				match(IDENTIFIER);
				}
				}
				setState(832);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Class_bodyContext extends ParserRuleContext {
		public TerminalNode SLK_definitions() { return getToken(VDMParser.SLK_definitions, 0); }
		public List<Pp_definition_blockContext> pp_definition_block() {
			return getRuleContexts(Pp_definition_blockContext.class);
		}
		public Pp_definition_blockContext pp_definition_block(int i) {
			return getRuleContext(Pp_definition_blockContext.class,i);
		}
		public Class_bodyContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_class_body; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterClass_body(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitClass_body(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitClass_body(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Class_bodyContext class_body() throws RecognitionException {
		Class_bodyContext _localctx = new Class_bodyContext(_ctx, getState());
		enterRule(_localctx, 64, RULE_class_body);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(833);
			match(SLK_definitions);
			setState(835); 
			_errHandler.sync(this);
			_la = _input.LA(1);
			do {
				{
				{
				setState(834);
				pp_definition_block();
				}
				}
				setState(837); 
				_errHandler.sync(this);
				_la = _input.LA(1);
			} while ( _la==SLK_functions || ((((_la - 80)) & ~0x3f) == 0 && ((1L << (_la - 80)) & ((1L << (SLK_operations - 80)) | (1L << (SLK_traces - 80)) | (1L << (SLK_types - 80)) | (1L << (SLK_values - 80)) | (1L << (PPK_instance - 80)))) != 0) );
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Rt_definition_blockContext extends ParserRuleContext {
		public Pp_definition_blockContext pp_definition_block() {
			return getRuleContext(Pp_definition_blockContext.class,0);
		}
		public Synchronization_definitionsContext synchronization_definitions() {
			return getRuleContext(Synchronization_definitionsContext.class,0);
		}
		public Thread_definitionsContext thread_definitions() {
			return getRuleContext(Thread_definitionsContext.class,0);
		}
		public Rt_definition_blockContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_rt_definition_block; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterRt_definition_block(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitRt_definition_block(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitRt_definition_block(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Rt_definition_blockContext rt_definition_block() throws RecognitionException {
		Rt_definition_blockContext _localctx = new Rt_definition_blockContext(_ctx, getState());
		enterRule(_localctx, 66, RULE_rt_definition_block);
		try {
			setState(842);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case SLK_functions:
			case SLK_operations:
			case SLK_traces:
			case SLK_types:
			case SLK_values:
			case PPK_instance:
				enterOuterAlt(_localctx, 1);
				{
				setState(839);
				pp_definition_block();
				}
				break;
			case RTK_sync:
				enterOuterAlt(_localctx, 2);
				{
				setState(840);
				synchronization_definitions();
				}
				break;
			case RTK_thread:
				enterOuterAlt(_localctx, 3);
				{
				setState(841);
				thread_definitions();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Pp_definition_blockContext extends ParserRuleContext {
		public Pp_type_definitionsContext pp_type_definitions() {
			return getRuleContext(Pp_type_definitionsContext.class,0);
		}
		public Pp_value_definitionsContext pp_value_definitions() {
			return getRuleContext(Pp_value_definitionsContext.class,0);
		}
		public Pp_function_definitionsContext pp_function_definitions() {
			return getRuleContext(Pp_function_definitionsContext.class,0);
		}
		public Pp_operation_definitionsContext pp_operation_definitions() {
			return getRuleContext(Pp_operation_definitionsContext.class,0);
		}
		public Traces_definitionsContext traces_definitions() {
			return getRuleContext(Traces_definitionsContext.class,0);
		}
		public Instance_variable_definitionsContext instance_variable_definitions() {
			return getRuleContext(Instance_variable_definitionsContext.class,0);
		}
		public Pp_definition_blockContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_pp_definition_block; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterPp_definition_block(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitPp_definition_block(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitPp_definition_block(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Pp_definition_blockContext pp_definition_block() throws RecognitionException {
		Pp_definition_blockContext _localctx = new Pp_definition_blockContext(_ctx, getState());
		enterRule(_localctx, 68, RULE_pp_definition_block);
		try {
			setState(850);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case SLK_types:
				enterOuterAlt(_localctx, 1);
				{
				setState(844);
				pp_type_definitions();
				}
				break;
			case SLK_values:
				enterOuterAlt(_localctx, 2);
				{
				setState(845);
				pp_value_definitions();
				}
				break;
			case SLK_functions:
				enterOuterAlt(_localctx, 3);
				{
				setState(846);
				pp_function_definitions();
				}
				break;
			case SLK_operations:
				enterOuterAlt(_localctx, 4);
				{
				setState(847);
				pp_operation_definitions();
				}
				break;
			case SLK_traces:
				enterOuterAlt(_localctx, 5);
				{
				setState(848);
				traces_definitions();
				}
				break;
			case PPK_instance:
				enterOuterAlt(_localctx, 6);
				{
				setState(849);
				instance_variable_definitions();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Sl_definition_blockContext extends ParserRuleContext {
		public Sl_type_definitionsContext sl_type_definitions() {
			return getRuleContext(Sl_type_definitionsContext.class,0);
		}
		public State_definitionContext state_definition() {
			return getRuleContext(State_definitionContext.class,0);
		}
		public Sl_value_definitionsContext sl_value_definitions() {
			return getRuleContext(Sl_value_definitionsContext.class,0);
		}
		public Sl_function_definitionsContext sl_function_definitions() {
			return getRuleContext(Sl_function_definitionsContext.class,0);
		}
		public Sl_operation_definitionsContext sl_operation_definitions() {
			return getRuleContext(Sl_operation_definitionsContext.class,0);
		}
		public Traces_definitionsContext traces_definitions() {
			return getRuleContext(Traces_definitionsContext.class,0);
		}
		public Sl_definition_blockContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_sl_definition_block; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterSl_definition_block(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitSl_definition_block(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitSl_definition_block(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Sl_definition_blockContext sl_definition_block() throws RecognitionException {
		Sl_definition_blockContext _localctx = new Sl_definition_blockContext(_ctx, getState());
		enterRule(_localctx, 70, RULE_sl_definition_block);
		try {
			setState(858);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case SLK_types:
				enterOuterAlt(_localctx, 1);
				{
				setState(852);
				sl_type_definitions();
				}
				break;
			case SLK_state:
				enterOuterAlt(_localctx, 2);
				{
				setState(853);
				state_definition();
				}
				break;
			case SLK_values:
				enterOuterAlt(_localctx, 3);
				{
				setState(854);
				sl_value_definitions();
				}
				break;
			case SLK_functions:
				enterOuterAlt(_localctx, 4);
				{
				setState(855);
				sl_function_definitions();
				}
				break;
			case SLK_operations:
				enterOuterAlt(_localctx, 5);
				{
				setState(856);
				sl_operation_definitions();
				}
				break;
			case SLK_traces:
				enterOuterAlt(_localctx, 6);
				{
				setState(857);
				traces_definitions();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Pp_type_definitionsContext extends ParserRuleContext {
		public TerminalNode SLK_types() { return getToken(VDMParser.SLK_types, 0); }
		public Access_type_definitionContext access_type_definition() {
			return getRuleContext(Access_type_definitionContext.class,0);
		}
		public Pp_type_definitionsContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_pp_type_definitions; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterPp_type_definitions(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitPp_type_definitions(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitPp_type_definitions(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Pp_type_definitionsContext pp_type_definitions() throws RecognitionException {
		Pp_type_definitionsContext _localctx = new Pp_type_definitionsContext(_ctx, getState());
		enterRule(_localctx, 72, RULE_pp_type_definitions);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(860);
			match(SLK_types);
			setState(861);
			access_type_definition();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Access_type_definitionContext extends ParserRuleContext {
		public TerminalNode PPK_static() { return getToken(VDMParser.PPK_static, 0); }
		public AccessContext access() {
			return getRuleContext(AccessContext.class,0);
		}
		public Type_definitionContext type_definition() {
			return getRuleContext(Type_definitionContext.class,0);
		}
		public Access_type_definitionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_access_type_definition; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterAccess_type_definition(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitAccess_type_definition(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitAccess_type_definition(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Access_type_definitionContext access_type_definition() throws RecognitionException {
		Access_type_definitionContext _localctx = new Access_type_definitionContext(_ctx, getState());
		enterRule(_localctx, 74, RULE_access_type_definition);
		int _la;
		try {
			setState(880);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,57,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(869);
				_errHandler.sync(this);
				switch ( getInterpreter().adaptivePredict(_input,53,_ctx) ) {
				case 1:
					{
					setState(864);
					_errHandler.sync(this);
					_la = _input.LA(1);
					if (_la==PPK_static) {
						{
						setState(863);
						match(PPK_static);
						}
					}

					}
					break;
				case 2:
					{
					setState(867);
					_errHandler.sync(this);
					_la = _input.LA(1);
					if (((((_la - 126)) & ~0x3f) == 0 && ((1L << (_la - 126)) & ((1L << (PPK_private - 126)) | (1L << (PPK_protected - 126)) | (1L << (PPK_public - 126)))) != 0)) {
						{
						setState(866);
						access();
						}
					}

					}
					break;
				}
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(877);
				_errHandler.sync(this);
				switch ( getInterpreter().adaptivePredict(_input,56,_ctx) ) {
				case 1:
					{
					setState(872);
					_errHandler.sync(this);
					_la = _input.LA(1);
					if (((((_la - 126)) & ~0x3f) == 0 && ((1L << (_la - 126)) & ((1L << (PPK_private - 126)) | (1L << (PPK_protected - 126)) | (1L << (PPK_public - 126)))) != 0)) {
						{
						setState(871);
						access();
						}
					}

					}
					break;
				case 2:
					{
					setState(875);
					_errHandler.sync(this);
					_la = _input.LA(1);
					if (_la==PPK_static) {
						{
						setState(874);
						match(PPK_static);
						}
					}

					}
					break;
				}
				setState(879);
				type_definition();
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class AccessContext extends ParserRuleContext {
		public TerminalNode PPK_public() { return getToken(VDMParser.PPK_public, 0); }
		public TerminalNode PPK_private() { return getToken(VDMParser.PPK_private, 0); }
		public TerminalNode PPK_protected() { return getToken(VDMParser.PPK_protected, 0); }
		public AccessContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_access; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterAccess(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitAccess(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitAccess(this);
			else return visitor.visitChildren(this);
		}
	}

	public final AccessContext access() throws RecognitionException {
		AccessContext _localctx = new AccessContext(_ctx, getState());
		enterRule(_localctx, 76, RULE_access);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(882);
			_la = _input.LA(1);
			if ( !(((((_la - 126)) & ~0x3f) == 0 && ((1L << (_la - 126)) & ((1L << (PPK_private - 126)) | (1L << (PPK_protected - 126)) | (1L << (PPK_public - 126)))) != 0)) ) {
			_errHandler.recoverInline(this);
			}
			else {
				if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
				_errHandler.reportMatch(this);
				consume();
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Sl_type_definitionsContext extends ParserRuleContext {
		public TerminalNode SLK_types() { return getToken(VDMParser.SLK_types, 0); }
		public Type_definition_listContext type_definition_list() {
			return getRuleContext(Type_definition_listContext.class,0);
		}
		public TerminalNode SEP_scolon() { return getToken(VDMParser.SEP_scolon, 0); }
		public Sl_type_definitionsContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_sl_type_definitions; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterSl_type_definitions(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitSl_type_definitions(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitSl_type_definitions(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Sl_type_definitionsContext sl_type_definitions() throws RecognitionException {
		Sl_type_definitionsContext _localctx = new Sl_type_definitionsContext(_ctx, getState());
		enterRule(_localctx, 78, RULE_sl_type_definitions);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(884);
			match(SLK_types);
			setState(885);
			type_definition_list();
			setState(887);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SEP_scolon) {
				{
				setState(886);
				match(SEP_scolon);
				}
			}

			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Type_definition_listContext extends ParserRuleContext {
		public List<Type_definitionContext> type_definition() {
			return getRuleContexts(Type_definitionContext.class);
		}
		public Type_definitionContext type_definition(int i) {
			return getRuleContext(Type_definitionContext.class,i);
		}
		public List<TerminalNode> SEP_scolon() { return getTokens(VDMParser.SEP_scolon); }
		public TerminalNode SEP_scolon(int i) {
			return getToken(VDMParser.SEP_scolon, i);
		}
		public Type_definition_listContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_type_definition_list; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterType_definition_list(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitType_definition_list(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitType_definition_list(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Type_definition_listContext type_definition_list() throws RecognitionException {
		Type_definition_listContext _localctx = new Type_definition_listContext(_ctx, getState());
		enterRule(_localctx, 80, RULE_type_definition_list);
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(889);
			type_definition();
			setState(894);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,59,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					{
					{
					setState(890);
					match(SEP_scolon);
					setState(891);
					type_definition();
					}
					} 
				}
				setState(896);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,59,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Type_definitionContext extends ParserRuleContext {
		public TerminalNode IDENTIFIER() { return getToken(VDMParser.IDENTIFIER, 0); }
		public Invariant_type_definitionContext invariant_type_definition() {
			return getRuleContext(Invariant_type_definitionContext.class,0);
		}
		public Type_definitionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_type_definition; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterType_definition(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitType_definition(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitType_definition(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Type_definitionContext type_definition() throws RecognitionException {
		Type_definitionContext _localctx = new Type_definitionContext(_ctx, getState());
		enterRule(_localctx, 82, RULE_type_definition);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(897);
			match(IDENTIFIER);
			setState(898);
			invariant_type_definition();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Invariant_type_definitionContext extends ParserRuleContext {
		public TerminalNode O_EQUAL() { return getToken(VDMParser.O_EQUAL, 0); }
		public TypeContext type() {
			return getRuleContext(TypeContext.class,0);
		}
		public Type_specificationContext type_specification() {
			return getRuleContext(Type_specificationContext.class,0);
		}
		public TerminalNode SEP_rec() { return getToken(VDMParser.SEP_rec, 0); }
		public List<FieldContext> field() {
			return getRuleContexts(FieldContext.class);
		}
		public FieldContext field(int i) {
			return getRuleContext(FieldContext.class,i);
		}
		public Invariant_type_definitionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_invariant_type_definition; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterInvariant_type_definition(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitInvariant_type_definition(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitInvariant_type_definition(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Invariant_type_definitionContext invariant_type_definition() throws RecognitionException {
		Invariant_type_definitionContext _localctx = new Invariant_type_definitionContext(_ctx, getState());
		enterRule(_localctx, 84, RULE_invariant_type_definition);
		int _la;
		try {
			setState(920);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,62,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(900);
				match(O_EQUAL);
				setState(901);
				type(0);
				setState(902);
				type_specification();
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(904);
				match(O_EQUAL);
				setState(905);
				type(0);
				}
				break;
			case 3:
				enterOuterAlt(_localctx, 3);
				{
				setState(906);
				match(SEP_rec);
				setState(908); 
				_errHandler.sync(this);
				_la = _input.LA(1);
				do {
					{
					{
					setState(907);
					field();
					}
					}
					setState(910); 
					_errHandler.sync(this);
					_la = _input.LA(1);
				} while ( (((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << SLK_set1of) | (1L << SLK_setof) | (1L << SLK_seq1of) | (1L << SLK_seqof) | (1L << SLK_bool) | (1L << SLK_char) | (1L << SLK_compose) | (1L << SLK_inmap) | (1L << SLK_int))) != 0) || ((((_la - 66)) & ~0x3f) == 0 && ((1L << (_la - 66)) & ((1L << (SLK_map - 66)) | (1L << (SLK_nat - 66)) | (1L << (SLK_nat1 - 66)) | (1L << (SLK_rat - 66)) | (1L << (SLK_real - 66)) | (1L << (SLK_token - 66)))) != 0) || ((((_la - 196)) & ~0x3f) == 0 && ((1L << (_la - 196)) & ((1L << (PAREN_L - 196)) | (1L << (BRACKET_L - 196)) | (1L << (QUOTE_LITERAL - 196)) | (1L << (TYPE_VARIABLE_IDENTIFIER - 196)) | (1L << (IDENTIFIER - 196)))) != 0) );
				setState(912);
				type_specification();
				}
				break;
			case 4:
				enterOuterAlt(_localctx, 4);
				{
				setState(914);
				match(SEP_rec);
				setState(916); 
				_errHandler.sync(this);
				_la = _input.LA(1);
				do {
					{
					{
					setState(915);
					field();
					}
					}
					setState(918); 
					_errHandler.sync(this);
					_la = _input.LA(1);
				} while ( (((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << SLK_set1of) | (1L << SLK_setof) | (1L << SLK_seq1of) | (1L << SLK_seqof) | (1L << SLK_bool) | (1L << SLK_char) | (1L << SLK_compose) | (1L << SLK_inmap) | (1L << SLK_int))) != 0) || ((((_la - 66)) & ~0x3f) == 0 && ((1L << (_la - 66)) & ((1L << (SLK_map - 66)) | (1L << (SLK_nat - 66)) | (1L << (SLK_nat1 - 66)) | (1L << (SLK_rat - 66)) | (1L << (SLK_real - 66)) | (1L << (SLK_token - 66)))) != 0) || ((((_la - 196)) & ~0x3f) == 0 && ((1L << (_la - 196)) & ((1L << (PAREN_L - 196)) | (1L << (BRACKET_L - 196)) | (1L << (QUOTE_LITERAL - 196)) | (1L << (TYPE_VARIABLE_IDENTIFIER - 196)) | (1L << (IDENTIFIER - 196)))) != 0) );
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Type_specificationContext extends ParserRuleContext {
		public InvariantContext invariant() {
			return getRuleContext(InvariantContext.class,0);
		}
		public Eq_clauseContext eq_clause() {
			return getRuleContext(Eq_clauseContext.class,0);
		}
		public Ord_clauseContext ord_clause() {
			return getRuleContext(Ord_clauseContext.class,0);
		}
		public Type_specificationContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_type_specification; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterType_specification(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitType_specification(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitType_specification(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Type_specificationContext type_specification() throws RecognitionException {
		Type_specificationContext _localctx = new Type_specificationContext(_ctx, getState());
		enterRule(_localctx, 86, RULE_type_specification);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(923);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SLK_inv) {
				{
				setState(922);
				invariant();
				}
			}

			setState(926);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SLK_eq) {
				{
				setState(925);
				eq_clause();
				}
			}

			setState(929);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SLK_ord) {
				{
				setState(928);
				ord_clause();
				}
			}

			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class TypeContext extends ParserRuleContext {
		public TypeContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_type; }
	 
		public TypeContext() { }
		public void copyFrom(TypeContext ctx) {
			super.copyFrom(ctx);
		}
	}
	public static class UnionTypeContext extends TypeContext {
		public List<TypeContext> type() {
			return getRuleContexts(TypeContext.class);
		}
		public TypeContext type(int i) {
			return getRuleContext(TypeContext.class,i);
		}
		public List<TerminalNode> SEP_bar() { return getTokens(VDMParser.SEP_bar); }
		public TerminalNode SEP_bar(int i) {
			return getToken(VDMParser.SEP_bar, i);
		}
		public UnionTypeContext(TypeContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterUnionType(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitUnionType(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitUnionType(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class TypeNameContext extends TypeContext {
		public Type_nameContext type_name() {
			return getRuleContext(Type_nameContext.class,0);
		}
		public TypeNameContext(TypeContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterTypeName(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitTypeName(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitTypeName(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class BasicTypeContext extends TypeContext {
		public Basic_typeContext basic_type() {
			return getRuleContext(Basic_typeContext.class,0);
		}
		public BasicTypeContext(TypeContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterBasicType(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitBasicType(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitBasicType(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class SeqTypeContext extends TypeContext {
		public Seq_typeContext seq_type() {
			return getRuleContext(Seq_typeContext.class,0);
		}
		public SeqTypeContext(TypeContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterSeqType(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitSeqType(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitSeqType(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class ProductTypeContext extends TypeContext {
		public List<TypeContext> type() {
			return getRuleContexts(TypeContext.class);
		}
		public TypeContext type(int i) {
			return getRuleContext(TypeContext.class,i);
		}
		public List<TerminalNode> O_TIMES() { return getTokens(VDMParser.O_TIMES); }
		public TerminalNode O_TIMES(int i) {
			return getToken(VDMParser.O_TIMES, i);
		}
		public ProductTypeContext(TypeContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterProductType(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitProductType(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitProductType(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class MapTypeContext extends TypeContext {
		public Map_typeContext map_type() {
			return getRuleContext(Map_typeContext.class,0);
		}
		public MapTypeContext(TypeContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterMapType(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitMapType(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitMapType(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class OptionalTypeContext extends TypeContext {
		public Optional_typeContext optional_type() {
			return getRuleContext(Optional_typeContext.class,0);
		}
		public OptionalTypeContext(TypeContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterOptionalType(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitOptionalType(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitOptionalType(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class TypeVariableContext extends TypeContext {
		public Type_variableContext type_variable() {
			return getRuleContext(Type_variableContext.class,0);
		}
		public TypeVariableContext(TypeContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterTypeVariable(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitTypeVariable(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitTypeVariable(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class SetTypeContext extends TypeContext {
		public Set_typeContext set_type() {
			return getRuleContext(Set_typeContext.class,0);
		}
		public SetTypeContext(TypeContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterSetType(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitSetType(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitSetType(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class PartialFunctionTypeContext extends TypeContext {
		public List<TypeContext> type() {
			return getRuleContexts(TypeContext.class);
		}
		public TypeContext type(int i) {
			return getRuleContext(TypeContext.class,i);
		}
		public TerminalNode SEP_pfcn() { return getToken(VDMParser.SEP_pfcn, 0); }
		public TerminalNode SEP_tfcn() { return getToken(VDMParser.SEP_tfcn, 0); }
		public PartialFunctionTypeContext(TypeContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterPartialFunctionType(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitPartialFunctionType(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitPartialFunctionType(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class VoidFunctionTypeContext extends TypeContext {
		public Void_function_typeContext void_function_type() {
			return getRuleContext(Void_function_typeContext.class,0);
		}
		public VoidFunctionTypeContext(TypeContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterVoidFunctionType(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitVoidFunctionType(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitVoidFunctionType(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class BracketedTypeContext extends TypeContext {
		public Bracketed_typeContext bracketed_type() {
			return getRuleContext(Bracketed_typeContext.class,0);
		}
		public BracketedTypeContext(TypeContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterBracketedType(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitBracketedType(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitBracketedType(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class QuoteTypeContext extends TypeContext {
		public Quote_typeContext quote_type() {
			return getRuleContext(Quote_typeContext.class,0);
		}
		public QuoteTypeContext(TypeContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterQuoteType(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitQuoteType(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitQuoteType(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class CompositeTypeContext extends TypeContext {
		public Composite_typeContext composite_type() {
			return getRuleContext(Composite_typeContext.class,0);
		}
		public CompositeTypeContext(TypeContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterCompositeType(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitCompositeType(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitCompositeType(this);
			else return visitor.visitChildren(this);
		}
	}

	public final TypeContext type() throws RecognitionException {
		return type(0);
	}

	private TypeContext type(int _p) throws RecognitionException {
		ParserRuleContext _parentctx = _ctx;
		int _parentState = getState();
		TypeContext _localctx = new TypeContext(_ctx, _parentState);
		TypeContext _prevctx = _localctx;
		int _startState = 88;
		enterRecursionRule(_localctx, 88, RULE_type, _p);
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(943);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,66,_ctx) ) {
			case 1:
				{
				_localctx = new BracketedTypeContext(_localctx);
				_ctx = _localctx;
				_prevctx = _localctx;

				setState(932);
				bracketed_type();
				}
				break;
			case 2:
				{
				_localctx = new TypeNameContext(_localctx);
				_ctx = _localctx;
				_prevctx = _localctx;
				setState(933);
				type_name();
				}
				break;
			case 3:
				{
				_localctx = new TypeVariableContext(_localctx);
				_ctx = _localctx;
				_prevctx = _localctx;
				setState(934);
				type_variable();
				}
				break;
			case 4:
				{
				_localctx = new SeqTypeContext(_localctx);
				_ctx = _localctx;
				_prevctx = _localctx;
				setState(935);
				seq_type();
				}
				break;
			case 5:
				{
				_localctx = new SetTypeContext(_localctx);
				_ctx = _localctx;
				_prevctx = _localctx;
				setState(936);
				set_type();
				}
				break;
			case 6:
				{
				_localctx = new MapTypeContext(_localctx);
				_ctx = _localctx;
				_prevctx = _localctx;
				setState(937);
				map_type();
				}
				break;
			case 7:
				{
				_localctx = new CompositeTypeContext(_localctx);
				_ctx = _localctx;
				_prevctx = _localctx;
				setState(938);
				composite_type();
				}
				break;
			case 8:
				{
				_localctx = new BasicTypeContext(_localctx);
				_ctx = _localctx;
				_prevctx = _localctx;
				setState(939);
				basic_type();
				}
				break;
			case 9:
				{
				_localctx = new QuoteTypeContext(_localctx);
				_ctx = _localctx;
				_prevctx = _localctx;
				setState(940);
				quote_type();
				}
				break;
			case 10:
				{
				_localctx = new OptionalTypeContext(_localctx);
				_ctx = _localctx;
				_prevctx = _localctx;
				setState(941);
				optional_type();
				}
				break;
			case 11:
				{
				_localctx = new VoidFunctionTypeContext(_localctx);
				_ctx = _localctx;
				_prevctx = _localctx;
				setState(942);
				void_function_type();
				}
				break;
			}
			_ctx.stop = _input.LT(-1);
			setState(967);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,70,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					if ( _parseListeners!=null ) triggerExitRuleEvent();
					_prevctx = _localctx;
					{
					setState(965);
					_errHandler.sync(this);
					switch ( getInterpreter().adaptivePredict(_input,69,_ctx) ) {
					case 1:
						{
						_localctx = new PartialFunctionTypeContext(new TypeContext(_parentctx, _parentState));
						pushNewRecursionContext(_localctx, _startState, RULE_type);
						setState(945);
						if (!(precpred(_ctx, 2))) throw new FailedPredicateException(this, "precpred(_ctx, 2)");
						setState(946);
						match(SEP_pfcn);
						setState(947);
						type(2);
						}
						break;
					case 2:
						{
						_localctx = new PartialFunctionTypeContext(new TypeContext(_parentctx, _parentState));
						pushNewRecursionContext(_localctx, _startState, RULE_type);
						setState(948);
						if (!(precpred(_ctx, 1))) throw new FailedPredicateException(this, "precpred(_ctx, 1)");
						setState(949);
						match(SEP_tfcn);
						setState(950);
						type(1);
						}
						break;
					case 3:
						{
						_localctx = new ProductTypeContext(new TypeContext(_parentctx, _parentState));
						pushNewRecursionContext(_localctx, _startState, RULE_type);
						setState(951);
						if (!(precpred(_ctx, 8))) throw new FailedPredicateException(this, "precpred(_ctx, 8)");
						setState(954); 
						_errHandler.sync(this);
						_alt = 1;
						do {
							switch (_alt) {
							case 1:
								{
								{
								setState(952);
								match(O_TIMES);
								setState(953);
								type(0);
								}
								}
								break;
							default:
								throw new NoViableAltException(this);
							}
							setState(956); 
							_errHandler.sync(this);
							_alt = getInterpreter().adaptivePredict(_input,67,_ctx);
						} while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER );
						}
						break;
					case 4:
						{
						_localctx = new UnionTypeContext(new TypeContext(_parentctx, _parentState));
						pushNewRecursionContext(_localctx, _startState, RULE_type);
						setState(958);
						if (!(precpred(_ctx, 7))) throw new FailedPredicateException(this, "precpred(_ctx, 7)");
						setState(961); 
						_errHandler.sync(this);
						_alt = 1;
						do {
							switch (_alt) {
							case 1:
								{
								{
								setState(959);
								match(SEP_bar);
								setState(960);
								type(0);
								}
								}
								break;
							default:
								throw new NoViableAltException(this);
							}
							setState(963); 
							_errHandler.sync(this);
							_alt = getInterpreter().adaptivePredict(_input,68,_ctx);
						} while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER );
						}
						break;
					}
					} 
				}
				setState(969);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,70,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			unrollRecursionContexts(_parentctx);
		}
		return _localctx;
	}

	public static class Void_function_typeContext extends ParserRuleContext {
		public TerminalNode PAREN_L() { return getToken(VDMParser.PAREN_L, 0); }
		public TerminalNode PAREN_R() { return getToken(VDMParser.PAREN_R, 0); }
		public TypeContext type() {
			return getRuleContext(TypeContext.class,0);
		}
		public TerminalNode SEP_pfcn() { return getToken(VDMParser.SEP_pfcn, 0); }
		public TerminalNode SEP_tfcn() { return getToken(VDMParser.SEP_tfcn, 0); }
		public Void_function_typeContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_void_function_type; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterVoid_function_type(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitVoid_function_type(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitVoid_function_type(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Void_function_typeContext void_function_type() throws RecognitionException {
		Void_function_typeContext _localctx = new Void_function_typeContext(_ctx, getState());
		enterRule(_localctx, 90, RULE_void_function_type);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(970);
			match(PAREN_L);
			setState(971);
			match(PAREN_R);
			setState(972);
			_la = _input.LA(1);
			if ( !(_la==SEP_pfcn || _la==SEP_tfcn) ) {
			_errHandler.recoverInline(this);
			}
			else {
				if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
				_errHandler.reportMatch(this);
				consume();
			}
			setState(973);
			type(0);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Bracketed_typeContext extends ParserRuleContext {
		public TerminalNode PAREN_L() { return getToken(VDMParser.PAREN_L, 0); }
		public TypeContext type() {
			return getRuleContext(TypeContext.class,0);
		}
		public TerminalNode PAREN_R() { return getToken(VDMParser.PAREN_R, 0); }
		public Bracketed_typeContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_bracketed_type; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterBracketed_type(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitBracketed_type(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitBracketed_type(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Bracketed_typeContext bracketed_type() throws RecognitionException {
		Bracketed_typeContext _localctx = new Bracketed_typeContext(_ctx, getState());
		enterRule(_localctx, 92, RULE_bracketed_type);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(975);
			match(PAREN_L);
			setState(976);
			type(0);
			setState(977);
			match(PAREN_R);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Basic_typeContext extends ParserRuleContext {
		public TerminalNode SLK_bool() { return getToken(VDMParser.SLK_bool, 0); }
		public TerminalNode SLK_nat() { return getToken(VDMParser.SLK_nat, 0); }
		public TerminalNode SLK_nat1() { return getToken(VDMParser.SLK_nat1, 0); }
		public TerminalNode SLK_int() { return getToken(VDMParser.SLK_int, 0); }
		public TerminalNode SLK_rat() { return getToken(VDMParser.SLK_rat, 0); }
		public TerminalNode SLK_real() { return getToken(VDMParser.SLK_real, 0); }
		public TerminalNode SLK_char() { return getToken(VDMParser.SLK_char, 0); }
		public TerminalNode SLK_token() { return getToken(VDMParser.SLK_token, 0); }
		public Basic_typeContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_basic_type; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterBasic_type(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitBasic_type(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitBasic_type(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Basic_typeContext basic_type() throws RecognitionException {
		Basic_typeContext _localctx = new Basic_typeContext(_ctx, getState());
		enterRule(_localctx, 94, RULE_basic_type);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(979);
			_la = _input.LA(1);
			if ( !((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << SLK_bool) | (1L << SLK_char) | (1L << SLK_int))) != 0) || ((((_la - 75)) & ~0x3f) == 0 && ((1L << (_la - 75)) & ((1L << (SLK_nat - 75)) | (1L << (SLK_nat1 - 75)) | (1L << (SLK_rat - 75)) | (1L << (SLK_real - 75)) | (1L << (SLK_token - 75)))) != 0)) ) {
			_errHandler.recoverInline(this);
			}
			else {
				if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
				_errHandler.reportMatch(this);
				consume();
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Quote_typeContext extends ParserRuleContext {
		public TerminalNode QUOTE_LITERAL() { return getToken(VDMParser.QUOTE_LITERAL, 0); }
		public Quote_typeContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_quote_type; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterQuote_type(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitQuote_type(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitQuote_type(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Quote_typeContext quote_type() throws RecognitionException {
		Quote_typeContext _localctx = new Quote_typeContext(_ctx, getState());
		enterRule(_localctx, 96, RULE_quote_type);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(981);
			match(QUOTE_LITERAL);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Composite_typeContext extends ParserRuleContext {
		public TerminalNode SLK_compose() { return getToken(VDMParser.SLK_compose, 0); }
		public TerminalNode IDENTIFIER() { return getToken(VDMParser.IDENTIFIER, 0); }
		public TerminalNode SLK_of() { return getToken(VDMParser.SLK_of, 0); }
		public TerminalNode SLK_end() { return getToken(VDMParser.SLK_end, 0); }
		public List<FieldContext> field() {
			return getRuleContexts(FieldContext.class);
		}
		public FieldContext field(int i) {
			return getRuleContext(FieldContext.class,i);
		}
		public Composite_typeContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_composite_type; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterComposite_type(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitComposite_type(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitComposite_type(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Composite_typeContext composite_type() throws RecognitionException {
		Composite_typeContext _localctx = new Composite_typeContext(_ctx, getState());
		enterRule(_localctx, 98, RULE_composite_type);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(983);
			match(SLK_compose);
			setState(984);
			match(IDENTIFIER);
			setState(985);
			match(SLK_of);
			setState(987); 
			_errHandler.sync(this);
			_la = _input.LA(1);
			do {
				{
				{
				setState(986);
				field();
				}
				}
				setState(989); 
				_errHandler.sync(this);
				_la = _input.LA(1);
			} while ( (((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << SLK_set1of) | (1L << SLK_setof) | (1L << SLK_seq1of) | (1L << SLK_seqof) | (1L << SLK_bool) | (1L << SLK_char) | (1L << SLK_compose) | (1L << SLK_inmap) | (1L << SLK_int))) != 0) || ((((_la - 66)) & ~0x3f) == 0 && ((1L << (_la - 66)) & ((1L << (SLK_map - 66)) | (1L << (SLK_nat - 66)) | (1L << (SLK_nat1 - 66)) | (1L << (SLK_rat - 66)) | (1L << (SLK_real - 66)) | (1L << (SLK_token - 66)))) != 0) || ((((_la - 196)) & ~0x3f) == 0 && ((1L << (_la - 196)) & ((1L << (PAREN_L - 196)) | (1L << (BRACKET_L - 196)) | (1L << (QUOTE_LITERAL - 196)) | (1L << (TYPE_VARIABLE_IDENTIFIER - 196)) | (1L << (IDENTIFIER - 196)))) != 0) );
			setState(991);
			match(SLK_end);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class FieldContext extends ParserRuleContext {
		public TypeContext type() {
			return getRuleContext(TypeContext.class,0);
		}
		public TerminalNode IDENTIFIER() { return getToken(VDMParser.IDENTIFIER, 0); }
		public TerminalNode SEP_colon() { return getToken(VDMParser.SEP_colon, 0); }
		public TerminalNode O_MINUS() { return getToken(VDMParser.O_MINUS, 0); }
		public FieldContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_field; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterField(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitField(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitField(this);
			else return visitor.visitChildren(this);
		}
	}

	public final FieldContext field() throws RecognitionException {
		FieldContext _localctx = new FieldContext(_ctx, getState());
		enterRule(_localctx, 100, RULE_field);
		int _la;
		try {
			setState(1000);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,73,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(993);
				type(0);
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				{
				setState(994);
				match(IDENTIFIER);
				setState(995);
				match(SEP_colon);
				setState(997);
				_errHandler.sync(this);
				_la = _input.LA(1);
				if (_la==O_MINUS) {
					{
					setState(996);
					match(O_MINUS);
					}
				}

				}
				setState(999);
				type(0);
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Union_typeContext extends ParserRuleContext {
		public List<TypeContext> type() {
			return getRuleContexts(TypeContext.class);
		}
		public TypeContext type(int i) {
			return getRuleContext(TypeContext.class,i);
		}
		public List<TerminalNode> SEP_bar() { return getTokens(VDMParser.SEP_bar); }
		public TerminalNode SEP_bar(int i) {
			return getToken(VDMParser.SEP_bar, i);
		}
		public Union_typeContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_union_type; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterUnion_type(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitUnion_type(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitUnion_type(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Union_typeContext union_type() throws RecognitionException {
		Union_typeContext _localctx = new Union_typeContext(_ctx, getState());
		enterRule(_localctx, 102, RULE_union_type);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1002);
			type(0);
			setState(1005); 
			_errHandler.sync(this);
			_la = _input.LA(1);
			do {
				{
				{
				setState(1003);
				match(SEP_bar);
				setState(1004);
				type(0);
				}
				}
				setState(1007); 
				_errHandler.sync(this);
				_la = _input.LA(1);
			} while ( _la==SEP_bar );
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Product_typeContext extends ParserRuleContext {
		public List<TypeContext> type() {
			return getRuleContexts(TypeContext.class);
		}
		public TypeContext type(int i) {
			return getRuleContext(TypeContext.class,i);
		}
		public List<TerminalNode> O_TIMES() { return getTokens(VDMParser.O_TIMES); }
		public TerminalNode O_TIMES(int i) {
			return getToken(VDMParser.O_TIMES, i);
		}
		public Product_typeContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_product_type; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterProduct_type(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitProduct_type(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitProduct_type(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Product_typeContext product_type() throws RecognitionException {
		Product_typeContext _localctx = new Product_typeContext(_ctx, getState());
		enterRule(_localctx, 104, RULE_product_type);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1009);
			type(0);
			setState(1012); 
			_errHandler.sync(this);
			_la = _input.LA(1);
			do {
				{
				{
				setState(1010);
				match(O_TIMES);
				setState(1011);
				type(0);
				}
				}
				setState(1014); 
				_errHandler.sync(this);
				_la = _input.LA(1);
			} while ( _la==O_TIMES );
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Optional_typeContext extends ParserRuleContext {
		public TerminalNode BRACKET_L() { return getToken(VDMParser.BRACKET_L, 0); }
		public TypeContext type() {
			return getRuleContext(TypeContext.class,0);
		}
		public TerminalNode BRACKET_R() { return getToken(VDMParser.BRACKET_R, 0); }
		public Optional_typeContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_optional_type; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterOptional_type(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitOptional_type(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitOptional_type(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Optional_typeContext optional_type() throws RecognitionException {
		Optional_typeContext _localctx = new Optional_typeContext(_ctx, getState());
		enterRule(_localctx, 106, RULE_optional_type);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1016);
			match(BRACKET_L);
			setState(1017);
			type(0);
			setState(1018);
			match(BRACKET_R);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Set_typeContext extends ParserRuleContext {
		public Set0_typeContext set0_type() {
			return getRuleContext(Set0_typeContext.class,0);
		}
		public Set1_typeContext set1_type() {
			return getRuleContext(Set1_typeContext.class,0);
		}
		public Set_typeContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_set_type; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterSet_type(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitSet_type(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitSet_type(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Set_typeContext set_type() throws RecognitionException {
		Set_typeContext _localctx = new Set_typeContext(_ctx, getState());
		enterRule(_localctx, 108, RULE_set_type);
		try {
			setState(1022);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case SLK_setof:
				enterOuterAlt(_localctx, 1);
				{
				setState(1020);
				set0_type();
				}
				break;
			case SLK_set1of:
				enterOuterAlt(_localctx, 2);
				{
				setState(1021);
				set1_type();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Set0_typeContext extends ParserRuleContext {
		public TerminalNode SLK_setof() { return getToken(VDMParser.SLK_setof, 0); }
		public TypeContext type() {
			return getRuleContext(TypeContext.class,0);
		}
		public Set0_typeContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_set0_type; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterSet0_type(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitSet0_type(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitSet0_type(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Set0_typeContext set0_type() throws RecognitionException {
		Set0_typeContext _localctx = new Set0_typeContext(_ctx, getState());
		enterRule(_localctx, 110, RULE_set0_type);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1024);
			match(SLK_setof);
			setState(1025);
			type(0);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Set1_typeContext extends ParserRuleContext {
		public TerminalNode SLK_set1of() { return getToken(VDMParser.SLK_set1of, 0); }
		public TypeContext type() {
			return getRuleContext(TypeContext.class,0);
		}
		public Set1_typeContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_set1_type; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterSet1_type(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitSet1_type(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitSet1_type(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Set1_typeContext set1_type() throws RecognitionException {
		Set1_typeContext _localctx = new Set1_typeContext(_ctx, getState());
		enterRule(_localctx, 112, RULE_set1_type);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1027);
			match(SLK_set1of);
			setState(1028);
			type(0);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Seq_typeContext extends ParserRuleContext {
		public Seq0_typeContext seq0_type() {
			return getRuleContext(Seq0_typeContext.class,0);
		}
		public Seq1_typeContext seq1_type() {
			return getRuleContext(Seq1_typeContext.class,0);
		}
		public Seq_typeContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_seq_type; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterSeq_type(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitSeq_type(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitSeq_type(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Seq_typeContext seq_type() throws RecognitionException {
		Seq_typeContext _localctx = new Seq_typeContext(_ctx, getState());
		enterRule(_localctx, 114, RULE_seq_type);
		try {
			setState(1032);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case SLK_seqof:
				enterOuterAlt(_localctx, 1);
				{
				setState(1030);
				seq0_type();
				}
				break;
			case SLK_seq1of:
				enterOuterAlt(_localctx, 2);
				{
				setState(1031);
				seq1_type();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Seq0_typeContext extends ParserRuleContext {
		public TerminalNode SLK_seqof() { return getToken(VDMParser.SLK_seqof, 0); }
		public TypeContext type() {
			return getRuleContext(TypeContext.class,0);
		}
		public Seq0_typeContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_seq0_type; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterSeq0_type(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitSeq0_type(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitSeq0_type(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Seq0_typeContext seq0_type() throws RecognitionException {
		Seq0_typeContext _localctx = new Seq0_typeContext(_ctx, getState());
		enterRule(_localctx, 116, RULE_seq0_type);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1034);
			match(SLK_seqof);
			setState(1035);
			type(0);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Seq1_typeContext extends ParserRuleContext {
		public TerminalNode SLK_seq1of() { return getToken(VDMParser.SLK_seq1of, 0); }
		public TypeContext type() {
			return getRuleContext(TypeContext.class,0);
		}
		public Seq1_typeContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_seq1_type; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterSeq1_type(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitSeq1_type(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitSeq1_type(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Seq1_typeContext seq1_type() throws RecognitionException {
		Seq1_typeContext _localctx = new Seq1_typeContext(_ctx, getState());
		enterRule(_localctx, 118, RULE_seq1_type);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1037);
			match(SLK_seq1of);
			setState(1038);
			type(0);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Map_typeContext extends ParserRuleContext {
		public General_map_typeContext general_map_type() {
			return getRuleContext(General_map_typeContext.class,0);
		}
		public Injective_map_typeContext injective_map_type() {
			return getRuleContext(Injective_map_typeContext.class,0);
		}
		public Map_typeContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_map_type; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterMap_type(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitMap_type(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitMap_type(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Map_typeContext map_type() throws RecognitionException {
		Map_typeContext _localctx = new Map_typeContext(_ctx, getState());
		enterRule(_localctx, 120, RULE_map_type);
		try {
			setState(1042);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case SLK_map:
				enterOuterAlt(_localctx, 1);
				{
				setState(1040);
				general_map_type();
				}
				break;
			case SLK_inmap:
				enterOuterAlt(_localctx, 2);
				{
				setState(1041);
				injective_map_type();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class General_map_typeContext extends ParserRuleContext {
		public TerminalNode SLK_map() { return getToken(VDMParser.SLK_map, 0); }
		public List<TypeContext> type() {
			return getRuleContexts(TypeContext.class);
		}
		public TypeContext type(int i) {
			return getRuleContext(TypeContext.class,i);
		}
		public TerminalNode SLK_to() { return getToken(VDMParser.SLK_to, 0); }
		public General_map_typeContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_general_map_type; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterGeneral_map_type(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitGeneral_map_type(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitGeneral_map_type(this);
			else return visitor.visitChildren(this);
		}
	}

	public final General_map_typeContext general_map_type() throws RecognitionException {
		General_map_typeContext _localctx = new General_map_typeContext(_ctx, getState());
		enterRule(_localctx, 122, RULE_general_map_type);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1044);
			match(SLK_map);
			setState(1045);
			type(0);
			setState(1046);
			match(SLK_to);
			setState(1047);
			type(0);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Injective_map_typeContext extends ParserRuleContext {
		public TerminalNode SLK_inmap() { return getToken(VDMParser.SLK_inmap, 0); }
		public List<TypeContext> type() {
			return getRuleContexts(TypeContext.class);
		}
		public TypeContext type(int i) {
			return getRuleContext(TypeContext.class,i);
		}
		public TerminalNode SLK_to() { return getToken(VDMParser.SLK_to, 0); }
		public Injective_map_typeContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_injective_map_type; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterInjective_map_type(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitInjective_map_type(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitInjective_map_type(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Injective_map_typeContext injective_map_type() throws RecognitionException {
		Injective_map_typeContext _localctx = new Injective_map_typeContext(_ctx, getState());
		enterRule(_localctx, 124, RULE_injective_map_type);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1049);
			match(SLK_inmap);
			setState(1050);
			type(0);
			setState(1051);
			match(SLK_to);
			setState(1052);
			type(0);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Function_typeContext extends ParserRuleContext {
		public Partial_function_typeContext partial_function_type() {
			return getRuleContext(Partial_function_typeContext.class,0);
		}
		public Total_function_typeContext total_function_type() {
			return getRuleContext(Total_function_typeContext.class,0);
		}
		public Function_typeContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_function_type; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterFunction_type(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitFunction_type(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitFunction_type(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Function_typeContext function_type() throws RecognitionException {
		Function_typeContext _localctx = new Function_typeContext(_ctx, getState());
		enterRule(_localctx, 126, RULE_function_type);
		try {
			setState(1056);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,79,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(1054);
				partial_function_type();
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(1055);
				total_function_type();
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Partial_function_typeContext extends ParserRuleContext {
		public Discretionary_typeContext discretionary_type() {
			return getRuleContext(Discretionary_typeContext.class,0);
		}
		public TerminalNode SEP_pfcn() { return getToken(VDMParser.SEP_pfcn, 0); }
		public TypeContext type() {
			return getRuleContext(TypeContext.class,0);
		}
		public Partial_function_typeContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_partial_function_type; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterPartial_function_type(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitPartial_function_type(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitPartial_function_type(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Partial_function_typeContext partial_function_type() throws RecognitionException {
		Partial_function_typeContext _localctx = new Partial_function_typeContext(_ctx, getState());
		enterRule(_localctx, 128, RULE_partial_function_type);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1058);
			discretionary_type();
			setState(1059);
			match(SEP_pfcn);
			setState(1060);
			type(0);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Total_function_typeContext extends ParserRuleContext {
		public Discretionary_typeContext discretionary_type() {
			return getRuleContext(Discretionary_typeContext.class,0);
		}
		public TerminalNode SEP_tfcn() { return getToken(VDMParser.SEP_tfcn, 0); }
		public TypeContext type() {
			return getRuleContext(TypeContext.class,0);
		}
		public Total_function_typeContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_total_function_type; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterTotal_function_type(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitTotal_function_type(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitTotal_function_type(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Total_function_typeContext total_function_type() throws RecognitionException {
		Total_function_typeContext _localctx = new Total_function_typeContext(_ctx, getState());
		enterRule(_localctx, 130, RULE_total_function_type);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1062);
			discretionary_type();
			setState(1063);
			match(SEP_tfcn);
			setState(1064);
			type(0);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Discretionary_typeContext extends ParserRuleContext {
		public Discretionary_typeContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_discretionary_type; }
	 
		public Discretionary_typeContext() { }
		public void copyFrom(Discretionary_typeContext ctx) {
			super.copyFrom(ctx);
		}
	}
	public static class VoidTypeContext extends Discretionary_typeContext {
		public TerminalNode PAREN_L() { return getToken(VDMParser.PAREN_L, 0); }
		public TerminalNode PAREN_R() { return getToken(VDMParser.PAREN_R, 0); }
		public VoidTypeContext(Discretionary_typeContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterVoidType(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitVoidType(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitVoidType(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class FunctionTypeContext extends Discretionary_typeContext {
		public TypeContext type() {
			return getRuleContext(TypeContext.class,0);
		}
		public FunctionTypeContext(Discretionary_typeContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterFunctionType(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitFunctionType(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitFunctionType(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Discretionary_typeContext discretionary_type() throws RecognitionException {
		Discretionary_typeContext _localctx = new Discretionary_typeContext(_ctx, getState());
		enterRule(_localctx, 132, RULE_discretionary_type);
		try {
			setState(1069);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,80,_ctx) ) {
			case 1:
				_localctx = new VoidTypeContext(_localctx);
				enterOuterAlt(_localctx, 1);
				{
				setState(1066);
				match(PAREN_L);
				setState(1067);
				match(PAREN_R);
				}
				break;
			case 2:
				_localctx = new FunctionTypeContext(_localctx);
				enterOuterAlt(_localctx, 2);
				{
				setState(1068);
				type(0);
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Type_nameContext extends ParserRuleContext {
		public NameContext name() {
			return getRuleContext(NameContext.class,0);
		}
		public Type_nameContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_type_name; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterType_name(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitType_name(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitType_name(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Type_nameContext type_name() throws RecognitionException {
		Type_nameContext _localctx = new Type_nameContext(_ctx, getState());
		enterRule(_localctx, 134, RULE_type_name);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1071);
			name();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Type_variableContext extends ParserRuleContext {
		public TerminalNode TYPE_VARIABLE_IDENTIFIER() { return getToken(VDMParser.TYPE_VARIABLE_IDENTIFIER, 0); }
		public Type_variableContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_type_variable; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterType_variable(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitType_variable(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitType_variable(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Type_variableContext type_variable() throws RecognitionException {
		Type_variableContext _localctx = new Type_variableContext(_ctx, getState());
		enterRule(_localctx, 136, RULE_type_variable);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1073);
			match(TYPE_VARIABLE_IDENTIFIER);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class InvariantContext extends ParserRuleContext {
		public TerminalNode SLK_inv() { return getToken(VDMParser.SLK_inv, 0); }
		public Invariant_initial_functionContext invariant_initial_function() {
			return getRuleContext(Invariant_initial_functionContext.class,0);
		}
		public InvariantContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_invariant; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterInvariant(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitInvariant(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitInvariant(this);
			else return visitor.visitChildren(this);
		}
	}

	public final InvariantContext invariant() throws RecognitionException {
		InvariantContext _localctx = new InvariantContext(_ctx, getState());
		enterRule(_localctx, 138, RULE_invariant);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1075);
			match(SLK_inv);
			setState(1076);
			invariant_initial_function();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Eq_clauseContext extends ParserRuleContext {
		public TerminalNode SLK_eq() { return getToken(VDMParser.SLK_eq, 0); }
		public PatternContext pattern() {
			return getRuleContext(PatternContext.class,0);
		}
		public TerminalNode O_EQUAL() { return getToken(VDMParser.O_EQUAL, 0); }
		public Invariant_initial_functionContext invariant_initial_function() {
			return getRuleContext(Invariant_initial_functionContext.class,0);
		}
		public Eq_clauseContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_eq_clause; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterEq_clause(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitEq_clause(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitEq_clause(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Eq_clauseContext eq_clause() throws RecognitionException {
		Eq_clauseContext _localctx = new Eq_clauseContext(_ctx, getState());
		enterRule(_localctx, 140, RULE_eq_clause);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1078);
			match(SLK_eq);
			setState(1079);
			pattern(0);
			setState(1080);
			match(O_EQUAL);
			setState(1081);
			invariant_initial_function();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Ord_clauseContext extends ParserRuleContext {
		public TerminalNode SLK_ord() { return getToken(VDMParser.SLK_ord, 0); }
		public PatternContext pattern() {
			return getRuleContext(PatternContext.class,0);
		}
		public TerminalNode O_LT() { return getToken(VDMParser.O_LT, 0); }
		public Invariant_initial_functionContext invariant_initial_function() {
			return getRuleContext(Invariant_initial_functionContext.class,0);
		}
		public Ord_clauseContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_ord_clause; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterOrd_clause(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitOrd_clause(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitOrd_clause(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Ord_clauseContext ord_clause() throws RecognitionException {
		Ord_clauseContext _localctx = new Ord_clauseContext(_ctx, getState());
		enterRule(_localctx, 142, RULE_ord_clause);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1083);
			match(SLK_ord);
			setState(1084);
			pattern(0);
			setState(1085);
			match(O_LT);
			setState(1086);
			invariant_initial_function();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Invariant_initial_functionContext extends ParserRuleContext {
		public PatternContext pattern() {
			return getRuleContext(PatternContext.class,0);
		}
		public TerminalNode SEP_def() { return getToken(VDMParser.SEP_def, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public Invariant_initial_functionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_invariant_initial_function; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterInvariant_initial_function(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitInvariant_initial_function(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitInvariant_initial_function(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Invariant_initial_functionContext invariant_initial_function() throws RecognitionException {
		Invariant_initial_functionContext _localctx = new Invariant_initial_functionContext(_ctx, getState());
		enterRule(_localctx, 144, RULE_invariant_initial_function);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1088);
			pattern(0);
			setState(1089);
			match(SEP_def);
			setState(1090);
			expression(0);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class State_definitionContext extends ParserRuleContext {
		public TerminalNode SLK_state() { return getToken(VDMParser.SLK_state, 0); }
		public TerminalNode IDENTIFIER() { return getToken(VDMParser.IDENTIFIER, 0); }
		public TerminalNode SLK_of() { return getToken(VDMParser.SLK_of, 0); }
		public TerminalNode SLK_end() { return getToken(VDMParser.SLK_end, 0); }
		public TerminalNode SEP_scolon() { return getToken(VDMParser.SEP_scolon, 0); }
		public List<FieldContext> field() {
			return getRuleContexts(FieldContext.class);
		}
		public FieldContext field(int i) {
			return getRuleContext(FieldContext.class,i);
		}
		public InvariantContext invariant() {
			return getRuleContext(InvariantContext.class,0);
		}
		public InitialisationContext initialisation() {
			return getRuleContext(InitialisationContext.class,0);
		}
		public State_definitionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_state_definition; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterState_definition(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitState_definition(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitState_definition(this);
			else return visitor.visitChildren(this);
		}
	}

	public final State_definitionContext state_definition() throws RecognitionException {
		State_definitionContext _localctx = new State_definitionContext(_ctx, getState());
		enterRule(_localctx, 146, RULE_state_definition);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1092);
			match(SLK_state);
			setState(1093);
			match(IDENTIFIER);
			setState(1094);
			match(SLK_of);
			setState(1096); 
			_errHandler.sync(this);
			_la = _input.LA(1);
			do {
				{
				{
				setState(1095);
				field();
				}
				}
				setState(1098); 
				_errHandler.sync(this);
				_la = _input.LA(1);
			} while ( (((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << SLK_set1of) | (1L << SLK_setof) | (1L << SLK_seq1of) | (1L << SLK_seqof) | (1L << SLK_bool) | (1L << SLK_char) | (1L << SLK_compose) | (1L << SLK_inmap) | (1L << SLK_int))) != 0) || ((((_la - 66)) & ~0x3f) == 0 && ((1L << (_la - 66)) & ((1L << (SLK_map - 66)) | (1L << (SLK_nat - 66)) | (1L << (SLK_nat1 - 66)) | (1L << (SLK_rat - 66)) | (1L << (SLK_real - 66)) | (1L << (SLK_token - 66)))) != 0) || ((((_la - 196)) & ~0x3f) == 0 && ((1L << (_la - 196)) & ((1L << (PAREN_L - 196)) | (1L << (BRACKET_L - 196)) | (1L << (QUOTE_LITERAL - 196)) | (1L << (TYPE_VARIABLE_IDENTIFIER - 196)) | (1L << (IDENTIFIER - 196)))) != 0) );
			setState(1101);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SLK_inv) {
				{
				setState(1100);
				invariant();
				}
			}

			setState(1104);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SLK_init) {
				{
				setState(1103);
				initialisation();
				}
			}

			setState(1106);
			match(SLK_end);
			setState(1107);
			match(SEP_scolon);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class InitialisationContext extends ParserRuleContext {
		public TerminalNode SLK_init() { return getToken(VDMParser.SLK_init, 0); }
		public Invariant_initial_functionContext invariant_initial_function() {
			return getRuleContext(Invariant_initial_functionContext.class,0);
		}
		public InitialisationContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_initialisation; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterInitialisation(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitInitialisation(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitInitialisation(this);
			else return visitor.visitChildren(this);
		}
	}

	public final InitialisationContext initialisation() throws RecognitionException {
		InitialisationContext _localctx = new InitialisationContext(_ctx, getState());
		enterRule(_localctx, 148, RULE_initialisation);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1109);
			match(SLK_init);
			setState(1110);
			invariant_initial_function();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Sl_value_definitionsContext extends ParserRuleContext {
		public TerminalNode SLK_values() { return getToken(VDMParser.SLK_values, 0); }
		public List<Value_definitionContext> value_definition() {
			return getRuleContexts(Value_definitionContext.class);
		}
		public Value_definitionContext value_definition(int i) {
			return getRuleContext(Value_definitionContext.class,i);
		}
		public List<TerminalNode> SEP_scolon() { return getTokens(VDMParser.SEP_scolon); }
		public TerminalNode SEP_scolon(int i) {
			return getToken(VDMParser.SEP_scolon, i);
		}
		public Sl_value_definitionsContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_sl_value_definitions; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterSl_value_definitions(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitSl_value_definitions(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitSl_value_definitions(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Sl_value_definitionsContext sl_value_definitions() throws RecognitionException {
		Sl_value_definitionsContext _localctx = new Sl_value_definitionsContext(_ctx, getState());
		enterRule(_localctx, 150, RULE_sl_value_definitions);
		int _la;
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(1112);
			match(SLK_values);
			setState(1124);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (((((_la - 45)) & ~0x3f) == 0 && ((1L << (_la - 45)) & ((1L << (SLK_false - 45)) | (1L << (SLK_mk - 45)) | (1L << (SLK_nil - 45)) | (1L << (SLK_true - 45)))) != 0) || ((((_la - 172)) & ~0x3f) == 0 && ((1L << (_la - 172)) & ((1L << (O_MINUS - 172)) | (1L << (PAREN_L - 172)) | (1L << (BRACKET_L - 172)) | (1L << (BRACE_L - 172)) | (1L << (QUOTE_LITERAL - 172)) | (1L << (NUMERIC_LITERAL - 172)) | (1L << (CHARACTER_LITERAL - 172)) | (1L << (TEXT_LITERAL - 172)) | (1L << (IDENTIFIER - 172)))) != 0)) {
				{
				setState(1113);
				value_definition();
				setState(1118);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,84,_ctx);
				while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
					if ( _alt==1 ) {
						{
						{
						setState(1114);
						match(SEP_scolon);
						setState(1115);
						value_definition();
						}
						} 
					}
					setState(1120);
					_errHandler.sync(this);
					_alt = getInterpreter().adaptivePredict(_input,84,_ctx);
				}
				setState(1122);
				_errHandler.sync(this);
				_la = _input.LA(1);
				if (_la==SEP_scolon) {
					{
					setState(1121);
					match(SEP_scolon);
					}
				}

				}
			}

			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Pp_value_definitionsContext extends ParserRuleContext {
		public TerminalNode SLK_values() { return getToken(VDMParser.SLK_values, 0); }
		public List<Access_value_definitionContext> access_value_definition() {
			return getRuleContexts(Access_value_definitionContext.class);
		}
		public Access_value_definitionContext access_value_definition(int i) {
			return getRuleContext(Access_value_definitionContext.class,i);
		}
		public List<TerminalNode> SEP_scolon() { return getTokens(VDMParser.SEP_scolon); }
		public TerminalNode SEP_scolon(int i) {
			return getToken(VDMParser.SEP_scolon, i);
		}
		public Pp_value_definitionsContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_pp_value_definitions; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterPp_value_definitions(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitPp_value_definitions(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitPp_value_definitions(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Pp_value_definitionsContext pp_value_definitions() throws RecognitionException {
		Pp_value_definitionsContext _localctx = new Pp_value_definitionsContext(_ctx, getState());
		enterRule(_localctx, 152, RULE_pp_value_definitions);
		int _la;
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(1126);
			match(SLK_values);
			setState(1138);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SLK_false || ((((_la - 71)) & ~0x3f) == 0 && ((1L << (_la - 71)) & ((1L << (SLK_mk - 71)) | (1L << (SLK_nil - 71)) | (1L << (SLK_true - 71)) | (1L << (PPK_private - 71)) | (1L << (PPK_protected - 71)) | (1L << (PPK_public - 71)))) != 0) || ((((_la - 172)) & ~0x3f) == 0 && ((1L << (_la - 172)) & ((1L << (O_MINUS - 172)) | (1L << (PAREN_L - 172)) | (1L << (BRACKET_L - 172)) | (1L << (BRACE_L - 172)) | (1L << (QUOTE_LITERAL - 172)) | (1L << (NUMERIC_LITERAL - 172)) | (1L << (CHARACTER_LITERAL - 172)) | (1L << (TEXT_LITERAL - 172)) | (1L << (IDENTIFIER - 172)))) != 0)) {
				{
				setState(1127);
				access_value_definition();
				setState(1132);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,87,_ctx);
				while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
					if ( _alt==1 ) {
						{
						{
						setState(1128);
						match(SEP_scolon);
						setState(1129);
						access_value_definition();
						}
						} 
					}
					setState(1134);
					_errHandler.sync(this);
					_alt = getInterpreter().adaptivePredict(_input,87,_ctx);
				}
				setState(1136);
				_errHandler.sync(this);
				_la = _input.LA(1);
				if (_la==SEP_scolon) {
					{
					setState(1135);
					match(SEP_scolon);
					}
				}

				}
			}

			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Access_value_definitionContext extends ParserRuleContext {
		public Value_definitionContext value_definition() {
			return getRuleContext(Value_definitionContext.class,0);
		}
		public AccessContext access() {
			return getRuleContext(AccessContext.class,0);
		}
		public Access_value_definitionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_access_value_definition; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterAccess_value_definition(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitAccess_value_definition(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitAccess_value_definition(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Access_value_definitionContext access_value_definition() throws RecognitionException {
		Access_value_definitionContext _localctx = new Access_value_definitionContext(_ctx, getState());
		enterRule(_localctx, 154, RULE_access_value_definition);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1141);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (((((_la - 126)) & ~0x3f) == 0 && ((1L << (_la - 126)) & ((1L << (PPK_private - 126)) | (1L << (PPK_protected - 126)) | (1L << (PPK_public - 126)))) != 0)) {
				{
				setState(1140);
				access();
				}
			}

			setState(1143);
			value_definition();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Value_definitionContext extends ParserRuleContext {
		public PatternContext pattern() {
			return getRuleContext(PatternContext.class,0);
		}
		public TerminalNode O_EQUAL() { return getToken(VDMParser.O_EQUAL, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public TerminalNode SEP_colon() { return getToken(VDMParser.SEP_colon, 0); }
		public TypeContext type() {
			return getRuleContext(TypeContext.class,0);
		}
		public Value_definitionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_value_definition; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterValue_definition(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitValue_definition(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitValue_definition(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Value_definitionContext value_definition() throws RecognitionException {
		Value_definitionContext _localctx = new Value_definitionContext(_ctx, getState());
		enterRule(_localctx, 156, RULE_value_definition);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1145);
			pattern(0);
			setState(1148);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SEP_colon) {
				{
				setState(1146);
				match(SEP_colon);
				setState(1147);
				type(0);
				}
			}

			setState(1150);
			match(O_EQUAL);
			setState(1151);
			expression(0);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Sl_function_definitionsContext extends ParserRuleContext {
		public TerminalNode SLK_functions() { return getToken(VDMParser.SLK_functions, 0); }
		public Function_definitionContext function_definition() {
			return getRuleContext(Function_definitionContext.class,0);
		}
		public Sl_function_definitionsContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_sl_function_definitions; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterSl_function_definitions(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitSl_function_definitions(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitSl_function_definitions(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Sl_function_definitionsContext sl_function_definitions() throws RecognitionException {
		Sl_function_definitionsContext _localctx = new Sl_function_definitionsContext(_ctx, getState());
		enterRule(_localctx, 158, RULE_sl_function_definitions);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1153);
			match(SLK_functions);
			setState(1154);
			function_definition();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Pp_function_definitionsContext extends ParserRuleContext {
		public TerminalNode SLK_functions() { return getToken(VDMParser.SLK_functions, 0); }
		public Access_function_definitionContext access_function_definition() {
			return getRuleContext(Access_function_definitionContext.class,0);
		}
		public Pp_function_definitionsContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_pp_function_definitions; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterPp_function_definitions(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitPp_function_definitions(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitPp_function_definitions(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Pp_function_definitionsContext pp_function_definitions() throws RecognitionException {
		Pp_function_definitionsContext _localctx = new Pp_function_definitionsContext(_ctx, getState());
		enterRule(_localctx, 160, RULE_pp_function_definitions);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1156);
			match(SLK_functions);
			setState(1157);
			access_function_definition();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Access_function_definitionContext extends ParserRuleContext {
		public Function_definitionContext function_definition() {
			return getRuleContext(Function_definitionContext.class,0);
		}
		public AccessContext access() {
			return getRuleContext(AccessContext.class,0);
		}
		public Access_function_definitionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_access_function_definition; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterAccess_function_definition(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitAccess_function_definition(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitAccess_function_definition(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Access_function_definitionContext access_function_definition() throws RecognitionException {
		Access_function_definitionContext _localctx = new Access_function_definitionContext(_ctx, getState());
		enterRule(_localctx, 162, RULE_access_function_definition);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1160);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (((((_la - 126)) & ~0x3f) == 0 && ((1L << (_la - 126)) & ((1L << (PPK_private - 126)) | (1L << (PPK_protected - 126)) | (1L << (PPK_public - 126)))) != 0)) {
				{
				setState(1159);
				access();
				}
			}

			setState(1162);
			function_definition();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Function_definitionContext extends ParserRuleContext {
		public Explicit_function_definitionContext explicit_function_definition() {
			return getRuleContext(Explicit_function_definitionContext.class,0);
		}
		public Implicit_function_definitionContext implicit_function_definition() {
			return getRuleContext(Implicit_function_definitionContext.class,0);
		}
		public Extended_explicit_function_definitionContext extended_explicit_function_definition() {
			return getRuleContext(Extended_explicit_function_definitionContext.class,0);
		}
		public Function_definitionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_function_definition; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterFunction_definition(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitFunction_definition(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitFunction_definition(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Function_definitionContext function_definition() throws RecognitionException {
		Function_definitionContext _localctx = new Function_definitionContext(_ctx, getState());
		enterRule(_localctx, 164, RULE_function_definition);
		try {
			setState(1167);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,93,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(1164);
				explicit_function_definition();
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(1165);
				implicit_function_definition();
				}
				break;
			case 3:
				enterOuterAlt(_localctx, 3);
				{
				setState(1166);
				extended_explicit_function_definition();
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Explicit_function_definitionContext extends ParserRuleContext {
		public List<TerminalNode> IDENTIFIER() { return getTokens(VDMParser.IDENTIFIER); }
		public TerminalNode IDENTIFIER(int i) {
			return getToken(VDMParser.IDENTIFIER, i);
		}
		public TerminalNode SEP_colon() { return getToken(VDMParser.SEP_colon, 0); }
		public Function_typeContext function_type() {
			return getRuleContext(Function_typeContext.class,0);
		}
		public TerminalNode SEP_def() { return getToken(VDMParser.SEP_def, 0); }
		public Function_bodyContext function_body() {
			return getRuleContext(Function_bodyContext.class,0);
		}
		public Type_variable_listContext type_variable_list() {
			return getRuleContext(Type_variable_listContext.class,0);
		}
		public List<ParametersContext> parameters() {
			return getRuleContexts(ParametersContext.class);
		}
		public ParametersContext parameters(int i) {
			return getRuleContext(ParametersContext.class,i);
		}
		public Pre_expressionContext pre_expression() {
			return getRuleContext(Pre_expressionContext.class,0);
		}
		public Post_expressionContext post_expression() {
			return getRuleContext(Post_expressionContext.class,0);
		}
		public Measure_definitionContext measure_definition() {
			return getRuleContext(Measure_definitionContext.class,0);
		}
		public Explicit_function_definitionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_explicit_function_definition; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterExplicit_function_definition(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitExplicit_function_definition(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitExplicit_function_definition(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Explicit_function_definitionContext explicit_function_definition() throws RecognitionException {
		Explicit_function_definitionContext _localctx = new Explicit_function_definitionContext(_ctx, getState());
		enterRule(_localctx, 166, RULE_explicit_function_definition);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1169);
			match(IDENTIFIER);
			setState(1171);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==BRACKET_L) {
				{
				setState(1170);
				type_variable_list();
				}
			}

			setState(1173);
			match(SEP_colon);
			setState(1174);
			function_type();
			setState(1175);
			match(IDENTIFIER);
			setState(1177); 
			_errHandler.sync(this);
			_la = _input.LA(1);
			do {
				{
				{
				setState(1176);
				parameters();
				}
				}
				setState(1179); 
				_errHandler.sync(this);
				_la = _input.LA(1);
			} while ( _la==PAREN_L );
			setState(1181);
			match(SEP_def);
			setState(1182);
			function_body();
			setState(1184);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SLK_pre) {
				{
				setState(1183);
				pre_expression();
				}
			}

			setState(1187);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SLK_post) {
				{
				setState(1186);
				post_expression();
				}
			}

			setState(1190);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SLK_measure) {
				{
				setState(1189);
				measure_definition();
				}
			}

			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Pre_expressionContext extends ParserRuleContext {
		public TerminalNode SLK_pre() { return getToken(VDMParser.SLK_pre, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public Pre_expressionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_pre_expression; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterPre_expression(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitPre_expression(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitPre_expression(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Pre_expressionContext pre_expression() throws RecognitionException {
		Pre_expressionContext _localctx = new Pre_expressionContext(_ctx, getState());
		enterRule(_localctx, 168, RULE_pre_expression);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1192);
			match(SLK_pre);
			setState(1193);
			expression(0);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Post_expressionContext extends ParserRuleContext {
		public TerminalNode SLK_post() { return getToken(VDMParser.SLK_post, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public Post_expressionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_post_expression; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterPost_expression(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitPost_expression(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitPost_expression(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Post_expressionContext post_expression() throws RecognitionException {
		Post_expressionContext _localctx = new Post_expressionContext(_ctx, getState());
		enterRule(_localctx, 170, RULE_post_expression);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1195);
			match(SLK_post);
			setState(1196);
			expression(0);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Measure_definitionContext extends ParserRuleContext {
		public TerminalNode SLK_measure() { return getToken(VDMParser.SLK_measure, 0); }
		public Measure_bodyContext measure_body() {
			return getRuleContext(Measure_bodyContext.class,0);
		}
		public Measure_definitionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_measure_definition; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterMeasure_definition(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitMeasure_definition(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitMeasure_definition(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Measure_definitionContext measure_definition() throws RecognitionException {
		Measure_definitionContext _localctx = new Measure_definitionContext(_ctx, getState());
		enterRule(_localctx, 172, RULE_measure_definition);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1198);
			match(SLK_measure);
			setState(1199);
			measure_body();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Implicit_function_definitionContext extends ParserRuleContext {
		public TerminalNode IDENTIFIER() { return getToken(VDMParser.IDENTIFIER, 0); }
		public Parameter_typesContext parameter_types() {
			return getRuleContext(Parameter_typesContext.class,0);
		}
		public Identifier_type_pair_listContext identifier_type_pair_list() {
			return getRuleContext(Identifier_type_pair_listContext.class,0);
		}
		public Post_expressionContext post_expression() {
			return getRuleContext(Post_expressionContext.class,0);
		}
		public Type_variable_listContext type_variable_list() {
			return getRuleContext(Type_variable_listContext.class,0);
		}
		public Pre_expressionContext pre_expression() {
			return getRuleContext(Pre_expressionContext.class,0);
		}
		public Implicit_function_definitionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_implicit_function_definition; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterImplicit_function_definition(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitImplicit_function_definition(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitImplicit_function_definition(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Implicit_function_definitionContext implicit_function_definition() throws RecognitionException {
		Implicit_function_definitionContext _localctx = new Implicit_function_definitionContext(_ctx, getState());
		enterRule(_localctx, 174, RULE_implicit_function_definition);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1201);
			match(IDENTIFIER);
			setState(1203);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==BRACKET_L) {
				{
				setState(1202);
				type_variable_list();
				}
			}

			setState(1205);
			parameter_types();
			setState(1206);
			identifier_type_pair_list();
			setState(1208);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SLK_pre) {
				{
				setState(1207);
				pre_expression();
				}
			}

			setState(1210);
			post_expression();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Extended_explicit_function_definitionContext extends ParserRuleContext {
		public TerminalNode IDENTIFIER() { return getToken(VDMParser.IDENTIFIER, 0); }
		public Parameter_typesContext parameter_types() {
			return getRuleContext(Parameter_typesContext.class,0);
		}
		public Identifier_type_pair_listContext identifier_type_pair_list() {
			return getRuleContext(Identifier_type_pair_listContext.class,0);
		}
		public Type_variable_listContext type_variable_list() {
			return getRuleContext(Type_variable_listContext.class,0);
		}
		public Pre_expressionContext pre_expression() {
			return getRuleContext(Pre_expressionContext.class,0);
		}
		public Post_expressionContext post_expression() {
			return getRuleContext(Post_expressionContext.class,0);
		}
		public Measure_definitionContext measure_definition() {
			return getRuleContext(Measure_definitionContext.class,0);
		}
		public Extended_explicit_function_definitionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_extended_explicit_function_definition; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterExtended_explicit_function_definition(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitExtended_explicit_function_definition(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitExtended_explicit_function_definition(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Extended_explicit_function_definitionContext extended_explicit_function_definition() throws RecognitionException {
		Extended_explicit_function_definitionContext _localctx = new Extended_explicit_function_definitionContext(_ctx, getState());
		enterRule(_localctx, 176, RULE_extended_explicit_function_definition);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1212);
			match(IDENTIFIER);
			setState(1214);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==BRACKET_L) {
				{
				setState(1213);
				type_variable_list();
				}
			}

			setState(1216);
			parameter_types();
			setState(1217);
			identifier_type_pair_list();
			setState(1219);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SLK_pre) {
				{
				setState(1218);
				pre_expression();
				}
			}

			setState(1222);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SLK_post) {
				{
				setState(1221);
				post_expression();
				}
			}

			setState(1225);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SLK_measure) {
				{
				setState(1224);
				measure_definition();
				}
			}

			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Type_variable_listContext extends ParserRuleContext {
		public TerminalNode BRACKET_L() { return getToken(VDMParser.BRACKET_L, 0); }
		public List<TerminalNode> TYPE_VARIABLE_IDENTIFIER() { return getTokens(VDMParser.TYPE_VARIABLE_IDENTIFIER); }
		public TerminalNode TYPE_VARIABLE_IDENTIFIER(int i) {
			return getToken(VDMParser.TYPE_VARIABLE_IDENTIFIER, i);
		}
		public TerminalNode BRACKET_R() { return getToken(VDMParser.BRACKET_R, 0); }
		public List<TerminalNode> SEP_comma() { return getTokens(VDMParser.SEP_comma); }
		public TerminalNode SEP_comma(int i) {
			return getToken(VDMParser.SEP_comma, i);
		}
		public Type_variable_listContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_type_variable_list; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterType_variable_list(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitType_variable_list(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitType_variable_list(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Type_variable_listContext type_variable_list() throws RecognitionException {
		Type_variable_listContext _localctx = new Type_variable_listContext(_ctx, getState());
		enterRule(_localctx, 178, RULE_type_variable_list);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1227);
			match(BRACKET_L);
			setState(1228);
			match(TYPE_VARIABLE_IDENTIFIER);
			setState(1233);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==SEP_comma) {
				{
				{
				setState(1229);
				match(SEP_comma);
				setState(1230);
				match(TYPE_VARIABLE_IDENTIFIER);
				}
				}
				setState(1235);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(1236);
			match(BRACKET_R);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Parameter_typesContext extends ParserRuleContext {
		public TerminalNode PAREN_L() { return getToken(VDMParser.PAREN_L, 0); }
		public Pattern_type_pair_listContext pattern_type_pair_list() {
			return getRuleContext(Pattern_type_pair_listContext.class,0);
		}
		public TerminalNode PAREN_R() { return getToken(VDMParser.PAREN_R, 0); }
		public Parameter_typesContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_parameter_types; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterParameter_types(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitParameter_types(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitParameter_types(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Parameter_typesContext parameter_types() throws RecognitionException {
		Parameter_typesContext _localctx = new Parameter_typesContext(_ctx, getState());
		enterRule(_localctx, 180, RULE_parameter_types);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1238);
			match(PAREN_L);
			setState(1239);
			pattern_type_pair_list();
			setState(1240);
			match(PAREN_R);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Pattern_type_pair_listContext extends ParserRuleContext {
		public List<Pattern_listContext> pattern_list() {
			return getRuleContexts(Pattern_listContext.class);
		}
		public Pattern_listContext pattern_list(int i) {
			return getRuleContext(Pattern_listContext.class,i);
		}
		public List<TerminalNode> SEP_colon() { return getTokens(VDMParser.SEP_colon); }
		public TerminalNode SEP_colon(int i) {
			return getToken(VDMParser.SEP_colon, i);
		}
		public List<TypeContext> type() {
			return getRuleContexts(TypeContext.class);
		}
		public TypeContext type(int i) {
			return getRuleContext(TypeContext.class,i);
		}
		public List<TerminalNode> SEP_comma() { return getTokens(VDMParser.SEP_comma); }
		public TerminalNode SEP_comma(int i) {
			return getToken(VDMParser.SEP_comma, i);
		}
		public Pattern_type_pair_listContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_pattern_type_pair_list; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterPattern_type_pair_list(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitPattern_type_pair_list(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitPattern_type_pair_list(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Pattern_type_pair_listContext pattern_type_pair_list() throws RecognitionException {
		Pattern_type_pair_listContext _localctx = new Pattern_type_pair_listContext(_ctx, getState());
		enterRule(_localctx, 182, RULE_pattern_type_pair_list);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1242);
			pattern_list();
			setState(1243);
			match(SEP_colon);
			setState(1244);
			type(0);
			setState(1252);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==SEP_comma) {
				{
				{
				setState(1245);
				match(SEP_comma);
				setState(1246);
				pattern_list();
				setState(1247);
				match(SEP_colon);
				setState(1248);
				type(0);
				}
				}
				setState(1254);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Identifier_type_pair_listContext extends ParserRuleContext {
		public List<Identifier_type_pairContext> identifier_type_pair() {
			return getRuleContexts(Identifier_type_pairContext.class);
		}
		public Identifier_type_pairContext identifier_type_pair(int i) {
			return getRuleContext(Identifier_type_pairContext.class,i);
		}
		public List<TerminalNode> SEP_comma() { return getTokens(VDMParser.SEP_comma); }
		public TerminalNode SEP_comma(int i) {
			return getToken(VDMParser.SEP_comma, i);
		}
		public Identifier_type_pair_listContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_identifier_type_pair_list; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterIdentifier_type_pair_list(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitIdentifier_type_pair_list(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitIdentifier_type_pair_list(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Identifier_type_pair_listContext identifier_type_pair_list() throws RecognitionException {
		Identifier_type_pair_listContext _localctx = new Identifier_type_pair_listContext(_ctx, getState());
		enterRule(_localctx, 184, RULE_identifier_type_pair_list);
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(1255);
			identifier_type_pair();
			setState(1260);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,107,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					{
					{
					setState(1256);
					match(SEP_comma);
					setState(1257);
					identifier_type_pair();
					}
					} 
				}
				setState(1262);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,107,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Identifier_type_pairContext extends ParserRuleContext {
		public TerminalNode IDENTIFIER() { return getToken(VDMParser.IDENTIFIER, 0); }
		public TerminalNode SEP_colon() { return getToken(VDMParser.SEP_colon, 0); }
		public TypeContext type() {
			return getRuleContext(TypeContext.class,0);
		}
		public Identifier_type_pairContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_identifier_type_pair; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterIdentifier_type_pair(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitIdentifier_type_pair(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitIdentifier_type_pair(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Identifier_type_pairContext identifier_type_pair() throws RecognitionException {
		Identifier_type_pairContext _localctx = new Identifier_type_pairContext(_ctx, getState());
		enterRule(_localctx, 186, RULE_identifier_type_pair);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1263);
			match(IDENTIFIER);
			setState(1264);
			match(SEP_colon);
			setState(1265);
			type(0);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ParametersContext extends ParserRuleContext {
		public TerminalNode PAREN_L() { return getToken(VDMParser.PAREN_L, 0); }
		public TerminalNode PAREN_R() { return getToken(VDMParser.PAREN_R, 0); }
		public Pattern_listContext pattern_list() {
			return getRuleContext(Pattern_listContext.class,0);
		}
		public ParametersContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_parameters; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterParameters(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitParameters(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitParameters(this);
			else return visitor.visitChildren(this);
		}
	}

	public final ParametersContext parameters() throws RecognitionException {
		ParametersContext _localctx = new ParametersContext(_ctx, getState());
		enterRule(_localctx, 188, RULE_parameters);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1267);
			match(PAREN_L);
			setState(1269);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (((((_la - 45)) & ~0x3f) == 0 && ((1L << (_la - 45)) & ((1L << (SLK_false - 45)) | (1L << (SLK_mk - 45)) | (1L << (SLK_nil - 45)) | (1L << (SLK_true - 45)))) != 0) || ((((_la - 172)) & ~0x3f) == 0 && ((1L << (_la - 172)) & ((1L << (O_MINUS - 172)) | (1L << (PAREN_L - 172)) | (1L << (BRACKET_L - 172)) | (1L << (BRACE_L - 172)) | (1L << (QUOTE_LITERAL - 172)) | (1L << (NUMERIC_LITERAL - 172)) | (1L << (CHARACTER_LITERAL - 172)) | (1L << (TEXT_LITERAL - 172)) | (1L << (IDENTIFIER - 172)))) != 0)) {
				{
				setState(1268);
				pattern_list();
				}
			}

			setState(1271);
			match(PAREN_R);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Function_bodyContext extends ParserRuleContext {
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public TerminalNode SLK_inys() { return getToken(VDMParser.SLK_inys, 0); }
		public Function_bodyContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_function_body; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterFunction_body(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitFunction_body(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitFunction_body(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Function_bodyContext function_body() throws RecognitionException {
		Function_bodyContext _localctx = new Function_bodyContext(_ctx, getState());
		enterRule(_localctx, 190, RULE_function_body);
		try {
			setState(1275);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,109,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(1273);
				expression(0);
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(1274);
				match(SLK_inys);
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Measure_bodyContext extends ParserRuleContext {
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public TerminalNode SLK_inys() { return getToken(VDMParser.SLK_inys, 0); }
		public Measure_bodyContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_measure_body; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterMeasure_body(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitMeasure_body(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitMeasure_body(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Measure_bodyContext measure_body() throws RecognitionException {
		Measure_bodyContext _localctx = new Measure_bodyContext(_ctx, getState());
		enterRule(_localctx, 192, RULE_measure_body);
		try {
			setState(1279);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,110,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(1277);
				expression(0);
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(1278);
				match(SLK_inys);
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Sl_operation_definitionsContext extends ParserRuleContext {
		public TerminalNode SLK_operations() { return getToken(VDMParser.SLK_operations, 0); }
		public Sl_access_operation_definitionContext sl_access_operation_definition() {
			return getRuleContext(Sl_access_operation_definitionContext.class,0);
		}
		public Sl_operation_definitionsContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_sl_operation_definitions; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterSl_operation_definitions(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitSl_operation_definitions(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitSl_operation_definitions(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Sl_operation_definitionsContext sl_operation_definitions() throws RecognitionException {
		Sl_operation_definitionsContext _localctx = new Sl_operation_definitionsContext(_ctx, getState());
		enterRule(_localctx, 194, RULE_sl_operation_definitions);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1281);
			match(SLK_operations);
			setState(1282);
			sl_access_operation_definition();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Sl_access_operation_definitionContext extends ParserRuleContext {
		public Operation_definitionContext operation_definition() {
			return getRuleContext(Operation_definitionContext.class,0);
		}
		public TerminalNode SLK_pure() { return getToken(VDMParser.SLK_pure, 0); }
		public Sl_access_operation_definitionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_sl_access_operation_definition; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterSl_access_operation_definition(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitSl_access_operation_definition(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitSl_access_operation_definition(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Sl_access_operation_definitionContext sl_access_operation_definition() throws RecognitionException {
		Sl_access_operation_definitionContext _localctx = new Sl_access_operation_definitionContext(_ctx, getState());
		enterRule(_localctx, 196, RULE_sl_access_operation_definition);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1285);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SLK_pure) {
				{
				setState(1284);
				match(SLK_pure);
				}
			}

			setState(1287);
			operation_definition();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Pp_operation_definitionsContext extends ParserRuleContext {
		public TerminalNode SLK_operations() { return getToken(VDMParser.SLK_operations, 0); }
		public Pp_access_operation_definitionContext pp_access_operation_definition() {
			return getRuleContext(Pp_access_operation_definitionContext.class,0);
		}
		public Pp_operation_definitionsContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_pp_operation_definitions; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterPp_operation_definitions(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitPp_operation_definitions(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitPp_operation_definitions(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Pp_operation_definitionsContext pp_operation_definitions() throws RecognitionException {
		Pp_operation_definitionsContext _localctx = new Pp_operation_definitionsContext(_ctx, getState());
		enterRule(_localctx, 198, RULE_pp_operation_definitions);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1289);
			match(SLK_operations);
			setState(1290);
			pp_access_operation_definition();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Pp_access_operation_definitionContext extends ParserRuleContext {
		public Operation_definitionContext operation_definition() {
			return getRuleContext(Operation_definitionContext.class,0);
		}
		public TerminalNode SLK_pure() { return getToken(VDMParser.SLK_pure, 0); }
		public AccessContext access() {
			return getRuleContext(AccessContext.class,0);
		}
		public TerminalNode PPK_static() { return getToken(VDMParser.PPK_static, 0); }
		public Pp_access_operation_definitionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_pp_access_operation_definition; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterPp_access_operation_definition(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitPp_access_operation_definition(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitPp_access_operation_definition(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Pp_access_operation_definitionContext pp_access_operation_definition() throws RecognitionException {
		Pp_access_operation_definitionContext _localctx = new Pp_access_operation_definitionContext(_ctx, getState());
		enterRule(_localctx, 200, RULE_pp_access_operation_definition);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1295);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case SLK_pure:
				{
				setState(1292);
				match(SLK_pure);
				}
				break;
			case PPK_private:
			case PPK_protected:
			case PPK_public:
				{
				setState(1293);
				access();
				}
				break;
			case PPK_static:
				{
				setState(1294);
				match(PPK_static);
				}
				break;
			case IDENTIFIER:
				break;
			default:
				break;
			}
			setState(1297);
			operation_definition();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Rt_operation_definitionsContext extends ParserRuleContext {
		public TerminalNode SLK_operations() { return getToken(VDMParser.SLK_operations, 0); }
		public Rt_access_operation_definitionContext rt_access_operation_definition() {
			return getRuleContext(Rt_access_operation_definitionContext.class,0);
		}
		public Rt_operation_definitionsContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_rt_operation_definitions; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterRt_operation_definitions(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitRt_operation_definitions(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitRt_operation_definitions(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Rt_operation_definitionsContext rt_operation_definitions() throws RecognitionException {
		Rt_operation_definitionsContext _localctx = new Rt_operation_definitionsContext(_ctx, getState());
		enterRule(_localctx, 202, RULE_rt_operation_definitions);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1299);
			match(SLK_operations);
			setState(1300);
			rt_access_operation_definition();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Rt_access_operation_definitionContext extends ParserRuleContext {
		public Operation_definitionContext operation_definition() {
			return getRuleContext(Operation_definitionContext.class,0);
		}
		public TerminalNode SLK_pure() { return getToken(VDMParser.SLK_pure, 0); }
		public TerminalNode RTK_async() { return getToken(VDMParser.RTK_async, 0); }
		public AccessContext access() {
			return getRuleContext(AccessContext.class,0);
		}
		public TerminalNode PPK_static() { return getToken(VDMParser.PPK_static, 0); }
		public Rt_access_operation_definitionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_rt_access_operation_definition; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterRt_access_operation_definition(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitRt_access_operation_definition(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitRt_access_operation_definition(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Rt_access_operation_definitionContext rt_access_operation_definition() throws RecognitionException {
		Rt_access_operation_definitionContext _localctx = new Rt_access_operation_definitionContext(_ctx, getState());
		enterRule(_localctx, 204, RULE_rt_access_operation_definition);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1306);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case SLK_pure:
				{
				setState(1302);
				match(SLK_pure);
				}
				break;
			case RTK_async:
				{
				setState(1303);
				match(RTK_async);
				}
				break;
			case PPK_private:
			case PPK_protected:
			case PPK_public:
				{
				setState(1304);
				access();
				}
				break;
			case PPK_static:
				{
				setState(1305);
				match(PPK_static);
				}
				break;
			case IDENTIFIER:
				break;
			default:
				break;
			}
			setState(1308);
			operation_definition();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Operation_definitionContext extends ParserRuleContext {
		public Explicit_operation_definitionContext explicit_operation_definition() {
			return getRuleContext(Explicit_operation_definitionContext.class,0);
		}
		public Implicit_operation_definitionContext implicit_operation_definition() {
			return getRuleContext(Implicit_operation_definitionContext.class,0);
		}
		public Extended_explicit_operation_definitionContext extended_explicit_operation_definition() {
			return getRuleContext(Extended_explicit_operation_definitionContext.class,0);
		}
		public Operation_definitionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_operation_definition; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterOperation_definition(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitOperation_definition(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitOperation_definition(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Operation_definitionContext operation_definition() throws RecognitionException {
		Operation_definitionContext _localctx = new Operation_definitionContext(_ctx, getState());
		enterRule(_localctx, 206, RULE_operation_definition);
		try {
			setState(1313);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,114,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(1310);
				explicit_operation_definition();
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(1311);
				implicit_operation_definition();
				}
				break;
			case 3:
				enterOuterAlt(_localctx, 3);
				{
				setState(1312);
				extended_explicit_operation_definition();
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Explicit_operation_definitionContext extends ParserRuleContext {
		public List<TerminalNode> IDENTIFIER() { return getTokens(VDMParser.IDENTIFIER); }
		public TerminalNode IDENTIFIER(int i) {
			return getToken(VDMParser.IDENTIFIER, i);
		}
		public TerminalNode SEP_colon() { return getToken(VDMParser.SEP_colon, 0); }
		public Operation_typeContext operation_type() {
			return getRuleContext(Operation_typeContext.class,0);
		}
		public ParametersContext parameters() {
			return getRuleContext(ParametersContext.class,0);
		}
		public TerminalNode SEP_def() { return getToken(VDMParser.SEP_def, 0); }
		public Operation_bodyContext operation_body() {
			return getRuleContext(Operation_bodyContext.class,0);
		}
		public Pre_expressionContext pre_expression() {
			return getRuleContext(Pre_expressionContext.class,0);
		}
		public Post_expressionContext post_expression() {
			return getRuleContext(Post_expressionContext.class,0);
		}
		public Explicit_operation_definitionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_explicit_operation_definition; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterExplicit_operation_definition(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitExplicit_operation_definition(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitExplicit_operation_definition(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Explicit_operation_definitionContext explicit_operation_definition() throws RecognitionException {
		Explicit_operation_definitionContext _localctx = new Explicit_operation_definitionContext(_ctx, getState());
		enterRule(_localctx, 208, RULE_explicit_operation_definition);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1315);
			match(IDENTIFIER);
			setState(1316);
			match(SEP_colon);
			setState(1317);
			operation_type();
			setState(1318);
			match(IDENTIFIER);
			setState(1319);
			parameters();
			setState(1320);
			match(SEP_def);
			setState(1321);
			operation_body();
			setState(1323);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SLK_pre) {
				{
				setState(1322);
				pre_expression();
				}
			}

			setState(1326);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SLK_post) {
				{
				setState(1325);
				post_expression();
				}
			}

			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Implicit_operation_definitionContext extends ParserRuleContext {
		public TerminalNode IDENTIFIER() { return getToken(VDMParser.IDENTIFIER, 0); }
		public Parameter_typesContext parameter_types() {
			return getRuleContext(Parameter_typesContext.class,0);
		}
		public Implicit_operation_bodyContext implicit_operation_body() {
			return getRuleContext(Implicit_operation_bodyContext.class,0);
		}
		public Identifier_type_pair_listContext identifier_type_pair_list() {
			return getRuleContext(Identifier_type_pair_listContext.class,0);
		}
		public Implicit_operation_definitionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_implicit_operation_definition; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterImplicit_operation_definition(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitImplicit_operation_definition(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitImplicit_operation_definition(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Implicit_operation_definitionContext implicit_operation_definition() throws RecognitionException {
		Implicit_operation_definitionContext _localctx = new Implicit_operation_definitionContext(_ctx, getState());
		enterRule(_localctx, 210, RULE_implicit_operation_definition);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1328);
			match(IDENTIFIER);
			setState(1329);
			parameter_types();
			setState(1331);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==IDENTIFIER) {
				{
				setState(1330);
				identifier_type_pair_list();
				}
			}

			setState(1333);
			implicit_operation_body();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Implicit_operation_bodyContext extends ParserRuleContext {
		public Post_expressionContext post_expression() {
			return getRuleContext(Post_expressionContext.class,0);
		}
		public ExternalsContext externals() {
			return getRuleContext(ExternalsContext.class,0);
		}
		public Pre_expressionContext pre_expression() {
			return getRuleContext(Pre_expressionContext.class,0);
		}
		public ExceptionsContext exceptions() {
			return getRuleContext(ExceptionsContext.class,0);
		}
		public Implicit_operation_bodyContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_implicit_operation_body; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterImplicit_operation_body(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitImplicit_operation_body(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitImplicit_operation_body(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Implicit_operation_bodyContext implicit_operation_body() throws RecognitionException {
		Implicit_operation_bodyContext _localctx = new Implicit_operation_bodyContext(_ctx, getState());
		enterRule(_localctx, 212, RULE_implicit_operation_body);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1336);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SLK_ext) {
				{
				setState(1335);
				externals();
				}
			}

			setState(1339);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SLK_pre) {
				{
				setState(1338);
				pre_expression();
				}
			}

			setState(1341);
			post_expression();
			setState(1343);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SLK_errs) {
				{
				setState(1342);
				exceptions();
				}
			}

			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Extended_explicit_operation_definitionContext extends ParserRuleContext {
		public TerminalNode IDENTIFIER() { return getToken(VDMParser.IDENTIFIER, 0); }
		public Parameter_typesContext parameter_types() {
			return getRuleContext(Parameter_typesContext.class,0);
		}
		public TerminalNode SEP_def() { return getToken(VDMParser.SEP_def, 0); }
		public Operation_bodyContext operation_body() {
			return getRuleContext(Operation_bodyContext.class,0);
		}
		public Identifier_type_pair_listContext identifier_type_pair_list() {
			return getRuleContext(Identifier_type_pair_listContext.class,0);
		}
		public ExternalsContext externals() {
			return getRuleContext(ExternalsContext.class,0);
		}
		public Pre_expressionContext pre_expression() {
			return getRuleContext(Pre_expressionContext.class,0);
		}
		public Post_expressionContext post_expression() {
			return getRuleContext(Post_expressionContext.class,0);
		}
		public ExceptionsContext exceptions() {
			return getRuleContext(ExceptionsContext.class,0);
		}
		public Extended_explicit_operation_definitionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_extended_explicit_operation_definition; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterExtended_explicit_operation_definition(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitExtended_explicit_operation_definition(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitExtended_explicit_operation_definition(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Extended_explicit_operation_definitionContext extended_explicit_operation_definition() throws RecognitionException {
		Extended_explicit_operation_definitionContext _localctx = new Extended_explicit_operation_definitionContext(_ctx, getState());
		enterRule(_localctx, 214, RULE_extended_explicit_operation_definition);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1345);
			match(IDENTIFIER);
			setState(1346);
			parameter_types();
			setState(1348);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==IDENTIFIER) {
				{
				setState(1347);
				identifier_type_pair_list();
				}
			}

			setState(1350);
			match(SEP_def);
			setState(1351);
			operation_body();
			setState(1353);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SLK_ext) {
				{
				setState(1352);
				externals();
				}
			}

			setState(1356);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SLK_pre) {
				{
				setState(1355);
				pre_expression();
				}
			}

			setState(1359);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SLK_post) {
				{
				setState(1358);
				post_expression();
				}
			}

			setState(1362);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SLK_errs) {
				{
				setState(1361);
				exceptions();
				}
			}

			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Operation_typeContext extends ParserRuleContext {
		public List<Discretionary_typeContext> discretionary_type() {
			return getRuleContexts(Discretionary_typeContext.class);
		}
		public Discretionary_typeContext discretionary_type(int i) {
			return getRuleContext(Discretionary_typeContext.class,i);
		}
		public TerminalNode SEP_optype() { return getToken(VDMParser.SEP_optype, 0); }
		public Operation_typeContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_operation_type; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterOperation_type(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitOperation_type(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitOperation_type(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Operation_typeContext operation_type() throws RecognitionException {
		Operation_typeContext _localctx = new Operation_typeContext(_ctx, getState());
		enterRule(_localctx, 216, RULE_operation_type);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1364);
			discretionary_type();
			setState(1365);
			match(SEP_optype);
			setState(1366);
			discretionary_type();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Operation_bodyContext extends ParserRuleContext {
		public StatementContext statement() {
			return getRuleContext(StatementContext.class,0);
		}
		public TerminalNode SLK_inys() { return getToken(VDMParser.SLK_inys, 0); }
		public Operation_bodyContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_operation_body; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterOperation_body(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitOperation_body(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitOperation_body(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Operation_bodyContext operation_body() throws RecognitionException {
		Operation_bodyContext _localctx = new Operation_bodyContext(_ctx, getState());
		enterRule(_localctx, 218, RULE_operation_body);
		try {
			setState(1370);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case SLK_always:
			case SLK_atomic:
			case SLK_cases:
			case SLK_def:
			case SLK_error:
			case SLK_exit:
			case SLK_for:
			case SLK_if:
			case SLK_let:
			case SLK_return:
			case SLK_skip:
			case SLK_tixe:
			case SLK_trap:
			case SLK_while:
			case RTK_cycles:
			case RTK_duration:
			case RTK_start:
			case RTK_startlist:
			case RTK_stop:
			case RTK_stoplist:
			case SEP_parallel:
			case PAREN_L:
			case BRACKET_L:
			case IDENTIFIER:
				enterOuterAlt(_localctx, 1);
				{
				setState(1368);
				statement();
				}
				break;
			case SLK_inys:
				enterOuterAlt(_localctx, 2);
				{
				setState(1369);
				match(SLK_inys);
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ExternalsContext extends ParserRuleContext {
		public TerminalNode SLK_ext() { return getToken(VDMParser.SLK_ext, 0); }
		public List<Var_informationContext> var_information() {
			return getRuleContexts(Var_informationContext.class);
		}
		public Var_informationContext var_information(int i) {
			return getRuleContext(Var_informationContext.class,i);
		}
		public ExternalsContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_externals; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterExternals(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitExternals(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitExternals(this);
			else return visitor.visitChildren(this);
		}
	}

	public final ExternalsContext externals() throws RecognitionException {
		ExternalsContext _localctx = new ExternalsContext(_ctx, getState());
		enterRule(_localctx, 220, RULE_externals);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1372);
			match(SLK_ext);
			setState(1374); 
			_errHandler.sync(this);
			_la = _input.LA(1);
			do {
				{
				{
				setState(1373);
				var_information();
				}
				}
				setState(1376); 
				_errHandler.sync(this);
				_la = _input.LA(1);
			} while ( _la==SLK_rd || _la==SLK_wr );
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Var_informationContext extends ParserRuleContext {
		public VdmmodeContext vdmmode() {
			return getRuleContext(VdmmodeContext.class,0);
		}
		public Name_listContext name_list() {
			return getRuleContext(Name_listContext.class,0);
		}
		public TerminalNode SEP_colon() { return getToken(VDMParser.SEP_colon, 0); }
		public TypeContext type() {
			return getRuleContext(TypeContext.class,0);
		}
		public Var_informationContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_var_information; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterVar_information(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitVar_information(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitVar_information(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Var_informationContext var_information() throws RecognitionException {
		Var_informationContext _localctx = new Var_informationContext(_ctx, getState());
		enterRule(_localctx, 222, RULE_var_information);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1378);
			vdmmode();
			setState(1379);
			name_list();
			setState(1382);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SEP_colon) {
				{
				setState(1380);
				match(SEP_colon);
				setState(1381);
				type(0);
				}
			}

			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class VdmmodeContext extends ParserRuleContext {
		public TerminalNode SLK_rd() { return getToken(VDMParser.SLK_rd, 0); }
		public TerminalNode SLK_wr() { return getToken(VDMParser.SLK_wr, 0); }
		public VdmmodeContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_vdmmode; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterVdmmode(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitVdmmode(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitVdmmode(this);
			else return visitor.visitChildren(this);
		}
	}

	public final VdmmodeContext vdmmode() throws RecognitionException {
		VdmmodeContext _localctx = new VdmmodeContext(_ctx, getState());
		enterRule(_localctx, 224, RULE_vdmmode);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1384);
			_la = _input.LA(1);
			if ( !(_la==SLK_rd || _la==SLK_wr) ) {
			_errHandler.recoverInline(this);
			}
			else {
				if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
				_errHandler.reportMatch(this);
				consume();
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ExceptionsContext extends ParserRuleContext {
		public TerminalNode SLK_errs() { return getToken(VDMParser.SLK_errs, 0); }
		public List<ErrorContext> error() {
			return getRuleContexts(ErrorContext.class);
		}
		public ErrorContext error(int i) {
			return getRuleContext(ErrorContext.class,i);
		}
		public ExceptionsContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_exceptions; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterExceptions(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitExceptions(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitExceptions(this);
			else return visitor.visitChildren(this);
		}
	}

	public final ExceptionsContext exceptions() throws RecognitionException {
		ExceptionsContext _localctx = new ExceptionsContext(_ctx, getState());
		enterRule(_localctx, 226, RULE_exceptions);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1386);
			match(SLK_errs);
			setState(1388); 
			_errHandler.sync(this);
			_la = _input.LA(1);
			do {
				{
				{
				setState(1387);
				error();
				}
				}
				setState(1390); 
				_errHandler.sync(this);
				_la = _input.LA(1);
			} while ( _la==IDENTIFIER );
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ErrorContext extends ParserRuleContext {
		public TerminalNode IDENTIFIER() { return getToken(VDMParser.IDENTIFIER, 0); }
		public TerminalNode SEP_colon() { return getToken(VDMParser.SEP_colon, 0); }
		public List<ExpressionContext> expression() {
			return getRuleContexts(ExpressionContext.class);
		}
		public ExpressionContext expression(int i) {
			return getRuleContext(ExpressionContext.class,i);
		}
		public TerminalNode SEP_pfcn() { return getToken(VDMParser.SEP_pfcn, 0); }
		public ErrorContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_error; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterError(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitError(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitError(this);
			else return visitor.visitChildren(this);
		}
	}

	public final ErrorContext error() throws RecognitionException {
		ErrorContext _localctx = new ErrorContext(_ctx, getState());
		enterRule(_localctx, 228, RULE_error);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1392);
			match(IDENTIFIER);
			setState(1393);
			match(SEP_colon);
			setState(1394);
			expression(0);
			setState(1395);
			match(SEP_pfcn);
			setState(1396);
			expression(0);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Instance_variable_definitionsContext extends ParserRuleContext {
		public TerminalNode PPK_instance() { return getToken(VDMParser.PPK_instance, 0); }
		public TerminalNode PPK_variables() { return getToken(VDMParser.PPK_variables, 0); }
		public List<Instance_variable_definitionContext> instance_variable_definition() {
			return getRuleContexts(Instance_variable_definitionContext.class);
		}
		public Instance_variable_definitionContext instance_variable_definition(int i) {
			return getRuleContext(Instance_variable_definitionContext.class,i);
		}
		public List<TerminalNode> SEP_scolon() { return getTokens(VDMParser.SEP_scolon); }
		public TerminalNode SEP_scolon(int i) {
			return getToken(VDMParser.SEP_scolon, i);
		}
		public Instance_variable_definitionsContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_instance_variable_definitions; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterInstance_variable_definitions(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitInstance_variable_definitions(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitInstance_variable_definitions(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Instance_variable_definitionsContext instance_variable_definitions() throws RecognitionException {
		Instance_variable_definitionsContext _localctx = new Instance_variable_definitionsContext(_ctx, getState());
		enterRule(_localctx, 230, RULE_instance_variable_definitions);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1398);
			match(PPK_instance);
			setState(1399);
			match(PPK_variables);
			setState(1408);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SLK_inv || ((((_la - 126)) & ~0x3f) == 0 && ((1L << (_la - 126)) & ((1L << (PPK_private - 126)) | (1L << (PPK_protected - 126)) | (1L << (PPK_public - 126)) | (1L << (PPK_static - 126)))) != 0) || _la==IDENTIFIER) {
				{
				setState(1400);
				instance_variable_definition();
				setState(1405);
				_errHandler.sync(this);
				_la = _input.LA(1);
				while (_la==SEP_scolon) {
					{
					{
					setState(1401);
					match(SEP_scolon);
					setState(1402);
					instance_variable_definition();
					}
					}
					setState(1407);
					_errHandler.sync(this);
					_la = _input.LA(1);
				}
				}
			}

			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Instance_variable_definitionContext extends ParserRuleContext {
		public Access_assignment_definitionContext access_assignment_definition() {
			return getRuleContext(Access_assignment_definitionContext.class,0);
		}
		public Invariant_definitionContext invariant_definition() {
			return getRuleContext(Invariant_definitionContext.class,0);
		}
		public Instance_variable_definitionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_instance_variable_definition; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterInstance_variable_definition(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitInstance_variable_definition(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitInstance_variable_definition(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Instance_variable_definitionContext instance_variable_definition() throws RecognitionException {
		Instance_variable_definitionContext _localctx = new Instance_variable_definitionContext(_ctx, getState());
		enterRule(_localctx, 232, RULE_instance_variable_definition);
		try {
			setState(1412);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case PPK_private:
			case PPK_protected:
			case PPK_public:
			case PPK_static:
			case IDENTIFIER:
				enterOuterAlt(_localctx, 1);
				{
				setState(1410);
				access_assignment_definition();
				}
				break;
			case SLK_inv:
				enterOuterAlt(_localctx, 2);
				{
				setState(1411);
				invariant_definition();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Access_assignment_definitionContext extends ParserRuleContext {
		public Assignment_definitionContext assignment_definition() {
			return getRuleContext(Assignment_definitionContext.class,0);
		}
		public AccessContext access() {
			return getRuleContext(AccessContext.class,0);
		}
		public TerminalNode PPK_static() { return getToken(VDMParser.PPK_static, 0); }
		public Access_assignment_definitionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_access_assignment_definition; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterAccess_assignment_definition(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitAccess_assignment_definition(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitAccess_assignment_definition(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Access_assignment_definitionContext access_assignment_definition() throws RecognitionException {
		Access_assignment_definitionContext _localctx = new Access_assignment_definitionContext(_ctx, getState());
		enterRule(_localctx, 234, RULE_access_assignment_definition);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1426);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,137,_ctx) ) {
			case 1:
				{
				{
				setState(1415);
				_errHandler.sync(this);
				_la = _input.LA(1);
				if (((((_la - 126)) & ~0x3f) == 0 && ((1L << (_la - 126)) & ((1L << (PPK_private - 126)) | (1L << (PPK_protected - 126)) | (1L << (PPK_public - 126)))) != 0)) {
					{
					setState(1414);
					access();
					}
				}

				setState(1418);
				_errHandler.sync(this);
				_la = _input.LA(1);
				if (_la==PPK_static) {
					{
					setState(1417);
					match(PPK_static);
					}
				}

				}
				}
				break;
			case 2:
				{
				{
				setState(1421);
				_errHandler.sync(this);
				_la = _input.LA(1);
				if (_la==PPK_static) {
					{
					setState(1420);
					match(PPK_static);
					}
				}

				setState(1424);
				_errHandler.sync(this);
				_la = _input.LA(1);
				if (((((_la - 126)) & ~0x3f) == 0 && ((1L << (_la - 126)) & ((1L << (PPK_private - 126)) | (1L << (PPK_protected - 126)) | (1L << (PPK_public - 126)))) != 0)) {
					{
					setState(1423);
					access();
					}
				}

				}
				}
				break;
			}
			setState(1428);
			assignment_definition();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Invariant_definitionContext extends ParserRuleContext {
		public TerminalNode SLK_inv() { return getToken(VDMParser.SLK_inv, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public Invariant_definitionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_invariant_definition; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterInvariant_definition(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitInvariant_definition(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitInvariant_definition(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Invariant_definitionContext invariant_definition() throws RecognitionException {
		Invariant_definitionContext _localctx = new Invariant_definitionContext(_ctx, getState());
		enterRule(_localctx, 236, RULE_invariant_definition);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1430);
			match(SLK_inv);
			setState(1431);
			expression(0);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Synchronization_definitionsContext extends ParserRuleContext {
		public TerminalNode RTK_sync() { return getToken(VDMParser.RTK_sync, 0); }
		public SynchronizationContext synchronization() {
			return getRuleContext(SynchronizationContext.class,0);
		}
		public Synchronization_definitionsContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_synchronization_definitions; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterSynchronization_definitions(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitSynchronization_definitions(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitSynchronization_definitions(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Synchronization_definitionsContext synchronization_definitions() throws RecognitionException {
		Synchronization_definitionsContext _localctx = new Synchronization_definitionsContext(_ctx, getState());
		enterRule(_localctx, 238, RULE_synchronization_definitions);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1433);
			match(RTK_sync);
			setState(1435);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==RTK_per || _la==RTK_mutex || _la==IDENTIFIER) {
				{
				setState(1434);
				synchronization();
				}
			}

			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class SynchronizationContext extends ParserRuleContext {
		public Permission_predicatesContext permission_predicates() {
			return getRuleContext(Permission_predicatesContext.class,0);
		}
		public SynchronizationContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_synchronization; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterSynchronization(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitSynchronization(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitSynchronization(this);
			else return visitor.visitChildren(this);
		}
	}

	public final SynchronizationContext synchronization() throws RecognitionException {
		SynchronizationContext _localctx = new SynchronizationContext(_ctx, getState());
		enterRule(_localctx, 240, RULE_synchronization);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1437);
			permission_predicates();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Permission_predicatesContext extends ParserRuleContext {
		public TerminalNode RTK_per() { return getToken(VDMParser.RTK_per, 0); }
		public NameContext name() {
			return getRuleContext(NameContext.class,0);
		}
		public TerminalNode O_IMPLIES() { return getToken(VDMParser.O_IMPLIES, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public Mutex_predicateContext mutex_predicate() {
			return getRuleContext(Mutex_predicateContext.class,0);
		}
		public Permission_predicatesContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_permission_predicates; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterPermission_predicates(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitPermission_predicates(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitPermission_predicates(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Permission_predicatesContext permission_predicates() throws RecognitionException {
		Permission_predicatesContext _localctx = new Permission_predicatesContext(_ctx, getState());
		enterRule(_localctx, 242, RULE_permission_predicates);
		try {
			setState(1445);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case RTK_per:
				enterOuterAlt(_localctx, 1);
				{
				setState(1439);
				match(RTK_per);
				setState(1440);
				name();
				setState(1441);
				match(O_IMPLIES);
				setState(1442);
				expression(0);
				}
				break;
			case RTK_mutex:
			case IDENTIFIER:
				enterOuterAlt(_localctx, 2);
				{
				setState(1444);
				mutex_predicate();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Mutex_predicateContext extends ParserRuleContext {
		public TerminalNode RTK_mutex() { return getToken(VDMParser.RTK_mutex, 0); }
		public TerminalNode PAREN_L() { return getToken(VDMParser.PAREN_L, 0); }
		public TerminalNode SLK_all() { return getToken(VDMParser.SLK_all, 0); }
		public Name_listContext name_list() {
			return getRuleContext(Name_listContext.class,0);
		}
		public TerminalNode PAREN_R() { return getToken(VDMParser.PAREN_R, 0); }
		public Mutex_predicateContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_mutex_predicate; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterMutex_predicate(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitMutex_predicate(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitMutex_predicate(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Mutex_predicateContext mutex_predicate() throws RecognitionException {
		Mutex_predicateContext _localctx = new Mutex_predicateContext(_ctx, getState());
		enterRule(_localctx, 244, RULE_mutex_predicate);
		try {
			setState(1453);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case RTK_mutex:
				enterOuterAlt(_localctx, 1);
				{
				setState(1447);
				match(RTK_mutex);
				setState(1448);
				match(PAREN_L);
				setState(1449);
				match(SLK_all);
				}
				break;
			case IDENTIFIER:
				enterOuterAlt(_localctx, 2);
				{
				setState(1450);
				name_list();
				setState(1451);
				match(PAREN_R);
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Thread_definitionsContext extends ParserRuleContext {
		public TerminalNode RTK_thread() { return getToken(VDMParser.RTK_thread, 0); }
		public Thread_definitionContext thread_definition() {
			return getRuleContext(Thread_definitionContext.class,0);
		}
		public Thread_definitionsContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_thread_definitions; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterThread_definitions(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitThread_definitions(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitThread_definitions(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Thread_definitionsContext thread_definitions() throws RecognitionException {
		Thread_definitionsContext _localctx = new Thread_definitionsContext(_ctx, getState());
		enterRule(_localctx, 246, RULE_thread_definitions);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1455);
			match(RTK_thread);
			setState(1457);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (((((_la - 13)) & ~0x3f) == 0 && ((1L << (_la - 13)) & ((1L << (SLK_always - 13)) | (1L << (SLK_atomic - 13)) | (1L << (SLK_cases - 13)) | (1L << (SLK_def - 13)) | (1L << (SLK_error - 13)) | (1L << (SLK_exit - 13)) | (1L << (SLK_for - 13)) | (1L << (SLK_if - 13)) | (1L << (SLK_let - 13)))) != 0) || ((((_la - 94)) & ~0x3f) == 0 && ((1L << (_la - 94)) & ((1L << (SLK_return - 94)) | (1L << (SLK_skip - 94)) | (1L << (SLK_tixe - 94)) | (1L << (SLK_trap - 94)) | (1L << (SLK_while - 94)) | (1L << (RTK_cycles - 94)) | (1L << (RTK_duration - 94)) | (1L << (RTK_periodic - 94)) | (1L << (RTK_sporadic - 94)) | (1L << (RTK_start - 94)) | (1L << (RTK_startlist - 94)) | (1L << (RTK_stop - 94)) | (1L << (RTK_stoplist - 94)))) != 0) || ((((_la - 176)) & ~0x3f) == 0 && ((1L << (_la - 176)) & ((1L << (SEP_parallel - 176)) | (1L << (PAREN_L - 176)) | (1L << (BRACKET_L - 176)) | (1L << (IDENTIFIER - 176)))) != 0)) {
				{
				setState(1456);
				thread_definition();
				}
			}

			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Thread_definitionContext extends ParserRuleContext {
		public Periodic_thread_definitionContext periodic_thread_definition() {
			return getRuleContext(Periodic_thread_definitionContext.class,0);
		}
		public Procedural_thread_definitionContext procedural_thread_definition() {
			return getRuleContext(Procedural_thread_definitionContext.class,0);
		}
		public Thread_definitionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_thread_definition; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterThread_definition(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitThread_definition(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitThread_definition(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Thread_definitionContext thread_definition() throws RecognitionException {
		Thread_definitionContext _localctx = new Thread_definitionContext(_ctx, getState());
		enterRule(_localctx, 248, RULE_thread_definition);
		try {
			setState(1461);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case RTK_periodic:
			case RTK_sporadic:
				enterOuterAlt(_localctx, 1);
				{
				setState(1459);
				periodic_thread_definition();
				}
				break;
			case SLK_always:
			case SLK_atomic:
			case SLK_cases:
			case SLK_def:
			case SLK_error:
			case SLK_exit:
			case SLK_for:
			case SLK_if:
			case SLK_let:
			case SLK_return:
			case SLK_skip:
			case SLK_tixe:
			case SLK_trap:
			case SLK_while:
			case RTK_cycles:
			case RTK_duration:
			case RTK_start:
			case RTK_startlist:
			case RTK_stop:
			case RTK_stoplist:
			case SEP_parallel:
			case PAREN_L:
			case BRACKET_L:
			case IDENTIFIER:
				enterOuterAlt(_localctx, 2);
				{
				setState(1460);
				procedural_thread_definition();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Periodic_thread_definitionContext extends ParserRuleContext {
		public Periodic_obligationContext periodic_obligation() {
			return getRuleContext(Periodic_obligationContext.class,0);
		}
		public Sporadic_obligationContext sporadic_obligation() {
			return getRuleContext(Sporadic_obligationContext.class,0);
		}
		public Periodic_thread_definitionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_periodic_thread_definition; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterPeriodic_thread_definition(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitPeriodic_thread_definition(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitPeriodic_thread_definition(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Periodic_thread_definitionContext periodic_thread_definition() throws RecognitionException {
		Periodic_thread_definitionContext _localctx = new Periodic_thread_definitionContext(_ctx, getState());
		enterRule(_localctx, 250, RULE_periodic_thread_definition);
		try {
			setState(1465);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case RTK_periodic:
				enterOuterAlt(_localctx, 1);
				{
				setState(1463);
				periodic_obligation();
				}
				break;
			case RTK_sporadic:
				enterOuterAlt(_localctx, 2);
				{
				setState(1464);
				sporadic_obligation();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Periodic_obligationContext extends ParserRuleContext {
		public TerminalNode RTK_periodic() { return getToken(VDMParser.RTK_periodic, 0); }
		public List<TerminalNode> PAREN_L() { return getTokens(VDMParser.PAREN_L); }
		public TerminalNode PAREN_L(int i) {
			return getToken(VDMParser.PAREN_L, i);
		}
		public List<ExpressionContext> expression() {
			return getRuleContexts(ExpressionContext.class);
		}
		public ExpressionContext expression(int i) {
			return getRuleContext(ExpressionContext.class,i);
		}
		public List<TerminalNode> SEP_comma() { return getTokens(VDMParser.SEP_comma); }
		public TerminalNode SEP_comma(int i) {
			return getToken(VDMParser.SEP_comma, i);
		}
		public List<TerminalNode> PAREN_R() { return getTokens(VDMParser.PAREN_R); }
		public TerminalNode PAREN_R(int i) {
			return getToken(VDMParser.PAREN_R, i);
		}
		public NameContext name() {
			return getRuleContext(NameContext.class,0);
		}
		public Periodic_obligationContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_periodic_obligation; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterPeriodic_obligation(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitPeriodic_obligation(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitPeriodic_obligation(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Periodic_obligationContext periodic_obligation() throws RecognitionException {
		Periodic_obligationContext _localctx = new Periodic_obligationContext(_ctx, getState());
		enterRule(_localctx, 252, RULE_periodic_obligation);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1467);
			match(RTK_periodic);
			setState(1468);
			match(PAREN_L);
			setState(1469);
			expression(0);
			setState(1470);
			match(SEP_comma);
			setState(1471);
			expression(0);
			setState(1472);
			match(SEP_comma);
			setState(1473);
			expression(0);
			setState(1474);
			match(SEP_comma);
			setState(1475);
			expression(0);
			setState(1476);
			match(PAREN_R);
			setState(1477);
			match(PAREN_L);
			setState(1478);
			name();
			setState(1479);
			match(PAREN_R);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Sporadic_obligationContext extends ParserRuleContext {
		public TerminalNode RTK_sporadic() { return getToken(VDMParser.RTK_sporadic, 0); }
		public List<TerminalNode> PAREN_L() { return getTokens(VDMParser.PAREN_L); }
		public TerminalNode PAREN_L(int i) {
			return getToken(VDMParser.PAREN_L, i);
		}
		public List<ExpressionContext> expression() {
			return getRuleContexts(ExpressionContext.class);
		}
		public ExpressionContext expression(int i) {
			return getRuleContext(ExpressionContext.class,i);
		}
		public List<TerminalNode> SEP_comma() { return getTokens(VDMParser.SEP_comma); }
		public TerminalNode SEP_comma(int i) {
			return getToken(VDMParser.SEP_comma, i);
		}
		public List<TerminalNode> PAREN_R() { return getTokens(VDMParser.PAREN_R); }
		public TerminalNode PAREN_R(int i) {
			return getToken(VDMParser.PAREN_R, i);
		}
		public NameContext name() {
			return getRuleContext(NameContext.class,0);
		}
		public Sporadic_obligationContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_sporadic_obligation; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterSporadic_obligation(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitSporadic_obligation(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitSporadic_obligation(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Sporadic_obligationContext sporadic_obligation() throws RecognitionException {
		Sporadic_obligationContext _localctx = new Sporadic_obligationContext(_ctx, getState());
		enterRule(_localctx, 254, RULE_sporadic_obligation);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1481);
			match(RTK_sporadic);
			setState(1482);
			match(PAREN_L);
			setState(1483);
			expression(0);
			setState(1484);
			match(SEP_comma);
			setState(1485);
			expression(0);
			setState(1486);
			match(SEP_comma);
			setState(1487);
			expression(0);
			setState(1488);
			match(SEP_comma);
			setState(1489);
			expression(0);
			setState(1490);
			match(PAREN_R);
			setState(1491);
			match(PAREN_L);
			setState(1492);
			name();
			setState(1493);
			match(PAREN_R);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Procedural_thread_definitionContext extends ParserRuleContext {
		public StatementContext statement() {
			return getRuleContext(StatementContext.class,0);
		}
		public Procedural_thread_definitionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_procedural_thread_definition; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterProcedural_thread_definition(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitProcedural_thread_definition(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitProcedural_thread_definition(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Procedural_thread_definitionContext procedural_thread_definition() throws RecognitionException {
		Procedural_thread_definitionContext _localctx = new Procedural_thread_definitionContext(_ctx, getState());
		enterRule(_localctx, 256, RULE_procedural_thread_definition);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1495);
			statement();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Traces_definitionsContext extends ParserRuleContext {
		public TerminalNode SLK_traces() { return getToken(VDMParser.SLK_traces, 0); }
		public List<Named_trace_listContext> named_trace_list() {
			return getRuleContexts(Named_trace_listContext.class);
		}
		public Named_trace_listContext named_trace_list(int i) {
			return getRuleContext(Named_trace_listContext.class,i);
		}
		public Traces_definitionsContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_traces_definitions; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterTraces_definitions(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitTraces_definitions(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitTraces_definitions(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Traces_definitionsContext traces_definitions() throws RecognitionException {
		Traces_definitionsContext _localctx = new Traces_definitionsContext(_ctx, getState());
		enterRule(_localctx, 258, RULE_traces_definitions);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1497);
			match(SLK_traces);
			setState(1501);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==IDENTIFIER) {
				{
				{
				setState(1498);
				named_trace_list();
				}
				}
				setState(1503);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Named_trace_listContext extends ParserRuleContext {
		public List<Named_traceContext> named_trace() {
			return getRuleContexts(Named_traceContext.class);
		}
		public Named_traceContext named_trace(int i) {
			return getRuleContext(Named_traceContext.class,i);
		}
		public List<TerminalNode> SEP_scolon() { return getTokens(VDMParser.SEP_scolon); }
		public TerminalNode SEP_scolon(int i) {
			return getToken(VDMParser.SEP_scolon, i);
		}
		public Named_trace_listContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_named_trace_list; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterNamed_trace_list(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitNamed_trace_list(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitNamed_trace_list(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Named_trace_listContext named_trace_list() throws RecognitionException {
		Named_trace_listContext _localctx = new Named_trace_listContext(_ctx, getState());
		enterRule(_localctx, 260, RULE_named_trace_list);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1504);
			named_trace();
			setState(1509);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==SEP_scolon) {
				{
				{
				setState(1505);
				match(SEP_scolon);
				setState(1506);
				named_trace();
				}
				}
				setState(1511);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Named_traceContext extends ParserRuleContext {
		public List<TerminalNode> IDENTIFIER() { return getTokens(VDMParser.IDENTIFIER); }
		public TerminalNode IDENTIFIER(int i) {
			return getToken(VDMParser.IDENTIFIER, i);
		}
		public TerminalNode SEP_colon() { return getToken(VDMParser.SEP_colon, 0); }
		public Trace_definition_listContext trace_definition_list() {
			return getRuleContext(Trace_definition_listContext.class,0);
		}
		public List<TerminalNode> O_DIV() { return getTokens(VDMParser.O_DIV); }
		public TerminalNode O_DIV(int i) {
			return getToken(VDMParser.O_DIV, i);
		}
		public Named_traceContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_named_trace; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterNamed_trace(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitNamed_trace(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitNamed_trace(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Named_traceContext named_trace() throws RecognitionException {
		Named_traceContext _localctx = new Named_traceContext(_ctx, getState());
		enterRule(_localctx, 262, RULE_named_trace);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1512);
			match(IDENTIFIER);
			setState(1517);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==O_DIV) {
				{
				{
				setState(1513);
				match(O_DIV);
				setState(1514);
				match(IDENTIFIER);
				}
				}
				setState(1519);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(1520);
			match(SEP_colon);
			setState(1521);
			trace_definition_list();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Trace_definition_listContext extends ParserRuleContext {
		public List<Trace_definition_termContext> trace_definition_term() {
			return getRuleContexts(Trace_definition_termContext.class);
		}
		public Trace_definition_termContext trace_definition_term(int i) {
			return getRuleContext(Trace_definition_termContext.class,i);
		}
		public List<TerminalNode> SEP_scolon() { return getTokens(VDMParser.SEP_scolon); }
		public TerminalNode SEP_scolon(int i) {
			return getToken(VDMParser.SEP_scolon, i);
		}
		public Trace_definition_listContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_trace_definition_list; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterTrace_definition_list(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitTrace_definition_list(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitTrace_definition_list(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Trace_definition_listContext trace_definition_list() throws RecognitionException {
		Trace_definition_listContext _localctx = new Trace_definition_listContext(_ctx, getState());
		enterRule(_localctx, 264, RULE_trace_definition_list);
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(1523);
			trace_definition_term();
			setState(1528);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,147,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					{
					{
					setState(1524);
					match(SEP_scolon);
					setState(1525);
					trace_definition_term();
					}
					} 
				}
				setState(1530);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,147,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Trace_definition_termContext extends ParserRuleContext {
		public List<Trace_definitionContext> trace_definition() {
			return getRuleContexts(Trace_definitionContext.class);
		}
		public Trace_definitionContext trace_definition(int i) {
			return getRuleContext(Trace_definitionContext.class,i);
		}
		public List<TerminalNode> SEP_bar() { return getTokens(VDMParser.SEP_bar); }
		public TerminalNode SEP_bar(int i) {
			return getToken(VDMParser.SEP_bar, i);
		}
		public Trace_definition_termContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_trace_definition_term; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterTrace_definition_term(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitTrace_definition_term(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitTrace_definition_term(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Trace_definition_termContext trace_definition_term() throws RecognitionException {
		Trace_definition_termContext _localctx = new Trace_definition_termContext(_ctx, getState());
		enterRule(_localctx, 266, RULE_trace_definition_term);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1531);
			trace_definition();
			setState(1536);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==SEP_bar) {
				{
				{
				setState(1532);
				match(SEP_bar);
				setState(1533);
				trace_definition();
				}
				}
				setState(1538);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Trace_definitionContext extends ParserRuleContext {
		public Trace_binding_definitionContext trace_binding_definition() {
			return getRuleContext(Trace_binding_definitionContext.class,0);
		}
		public Trace_repeat_definitionContext trace_repeat_definition() {
			return getRuleContext(Trace_repeat_definitionContext.class,0);
		}
		public Trace_definitionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_trace_definition; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterTrace_definition(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitTrace_definition(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitTrace_definition(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Trace_definitionContext trace_definition() throws RecognitionException {
		Trace_definitionContext _localctx = new Trace_definitionContext(_ctx, getState());
		enterRule(_localctx, 268, RULE_trace_definition);
		try {
			setState(1541);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case SLK_let:
				enterOuterAlt(_localctx, 1);
				{
				setState(1539);
				trace_binding_definition();
				}
				break;
			case SEP_parallel:
			case PAREN_L:
			case IDENTIFIER:
				enterOuterAlt(_localctx, 2);
				{
				setState(1540);
				trace_repeat_definition();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Trace_binding_definitionContext extends ParserRuleContext {
		public Trace_let_def_bindingContext trace_let_def_binding() {
			return getRuleContext(Trace_let_def_bindingContext.class,0);
		}
		public Trace_let_best_bindingContext trace_let_best_binding() {
			return getRuleContext(Trace_let_best_bindingContext.class,0);
		}
		public Trace_binding_definitionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_trace_binding_definition; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterTrace_binding_definition(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitTrace_binding_definition(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitTrace_binding_definition(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Trace_binding_definitionContext trace_binding_definition() throws RecognitionException {
		Trace_binding_definitionContext _localctx = new Trace_binding_definitionContext(_ctx, getState());
		enterRule(_localctx, 270, RULE_trace_binding_definition);
		try {
			setState(1545);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,150,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(1543);
				trace_let_def_binding();
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(1544);
				trace_let_best_binding();
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Trace_let_def_bindingContext extends ParserRuleContext {
		public TerminalNode SLK_let() { return getToken(VDMParser.SLK_let, 0); }
		public Local_definition_listContext local_definition_list() {
			return getRuleContext(Local_definition_listContext.class,0);
		}
		public TerminalNode SLK_in() { return getToken(VDMParser.SLK_in, 0); }
		public Trace_definitionContext trace_definition() {
			return getRuleContext(Trace_definitionContext.class,0);
		}
		public Trace_let_def_bindingContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_trace_let_def_binding; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterTrace_let_def_binding(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitTrace_let_def_binding(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitTrace_let_def_binding(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Trace_let_def_bindingContext trace_let_def_binding() throws RecognitionException {
		Trace_let_def_bindingContext _localctx = new Trace_let_def_bindingContext(_ctx, getState());
		enterRule(_localctx, 272, RULE_trace_let_def_binding);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1547);
			match(SLK_let);
			setState(1548);
			local_definition_list();
			setState(1549);
			match(SLK_in);
			setState(1550);
			trace_definition();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Trace_let_best_bindingContext extends ParserRuleContext {
		public TerminalNode SLK_let() { return getToken(VDMParser.SLK_let, 0); }
		public Multiple_bindContext multiple_bind() {
			return getRuleContext(Multiple_bindContext.class,0);
		}
		public TerminalNode SLK_in() { return getToken(VDMParser.SLK_in, 0); }
		public Trace_definitionContext trace_definition() {
			return getRuleContext(Trace_definitionContext.class,0);
		}
		public TerminalNode SLK_best() { return getToken(VDMParser.SLK_best, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public Trace_let_best_bindingContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_trace_let_best_binding; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterTrace_let_best_binding(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitTrace_let_best_binding(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitTrace_let_best_binding(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Trace_let_best_bindingContext trace_let_best_binding() throws RecognitionException {
		Trace_let_best_bindingContext _localctx = new Trace_let_best_bindingContext(_ctx, getState());
		enterRule(_localctx, 274, RULE_trace_let_best_binding);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1552);
			match(SLK_let);
			setState(1553);
			multiple_bind();
			setState(1556);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SLK_best) {
				{
				setState(1554);
				match(SLK_best);
				setState(1555);
				expression(0);
				}
			}

			setState(1558);
			match(SLK_in);
			setState(1559);
			trace_definition();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Trace_repeat_definitionContext extends ParserRuleContext {
		public Trace_core_definitionContext trace_core_definition() {
			return getRuleContext(Trace_core_definitionContext.class,0);
		}
		public TerminalNode O_TIMES() { return getToken(VDMParser.O_TIMES, 0); }
		public TerminalNode O_PLUS() { return getToken(VDMParser.O_PLUS, 0); }
		public TerminalNode SEP_qm() { return getToken(VDMParser.SEP_qm, 0); }
		public TerminalNode BRACE_L() { return getToken(VDMParser.BRACE_L, 0); }
		public List<TerminalNode> NUMERIC_LITERAL() { return getTokens(VDMParser.NUMERIC_LITERAL); }
		public TerminalNode NUMERIC_LITERAL(int i) {
			return getToken(VDMParser.NUMERIC_LITERAL, i);
		}
		public TerminalNode BRACE_R() { return getToken(VDMParser.BRACE_R, 0); }
		public TerminalNode SEP_comma() { return getToken(VDMParser.SEP_comma, 0); }
		public Trace_repeat_definitionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_trace_repeat_definition; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterTrace_repeat_definition(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitTrace_repeat_definition(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitTrace_repeat_definition(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Trace_repeat_definitionContext trace_repeat_definition() throws RecognitionException {
		Trace_repeat_definitionContext _localctx = new Trace_repeat_definitionContext(_ctx, getState());
		enterRule(_localctx, 276, RULE_trace_repeat_definition);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1561);
			trace_core_definition();
			setState(1572);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case O_TIMES:
				{
				setState(1562);
				match(O_TIMES);
				}
				break;
			case O_PLUS:
				{
				setState(1563);
				match(O_PLUS);
				}
				break;
			case SEP_qm:
				{
				setState(1564);
				match(SEP_qm);
				}
				break;
			case BRACE_L:
				{
				setState(1565);
				match(BRACE_L);
				setState(1566);
				match(NUMERIC_LITERAL);
				setState(1569);
				_errHandler.sync(this);
				_la = _input.LA(1);
				if (_la==SEP_comma) {
					{
					setState(1567);
					match(SEP_comma);
					setState(1568);
					match(NUMERIC_LITERAL);
					}
				}

				setState(1571);
				match(BRACE_R);
				}
				break;
			case EOF:
			case SLK_end:
			case SLK_functions:
			case SLK_operations:
			case SLK_state:
			case SLK_traces:
			case SLK_types:
			case SLK_values:
			case PPK_instance:
			case RTK_sync:
			case RTK_thread:
			case SEP_comma:
			case SEP_scolon:
			case SEP_bar:
			case PAREN_R:
			case IDENTIFIER:
				break;
			default:
				break;
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Trace_core_definitionContext extends ParserRuleContext {
		public Trace_apply_expressionContext trace_apply_expression() {
			return getRuleContext(Trace_apply_expressionContext.class,0);
		}
		public Trace_concurrent_expressionContext trace_concurrent_expression() {
			return getRuleContext(Trace_concurrent_expressionContext.class,0);
		}
		public Trace_bracketed_expressionContext trace_bracketed_expression() {
			return getRuleContext(Trace_bracketed_expressionContext.class,0);
		}
		public Trace_core_definitionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_trace_core_definition; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterTrace_core_definition(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitTrace_core_definition(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitTrace_core_definition(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Trace_core_definitionContext trace_core_definition() throws RecognitionException {
		Trace_core_definitionContext _localctx = new Trace_core_definitionContext(_ctx, getState());
		enterRule(_localctx, 278, RULE_trace_core_definition);
		try {
			setState(1577);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case IDENTIFIER:
				enterOuterAlt(_localctx, 1);
				{
				setState(1574);
				trace_apply_expression();
				}
				break;
			case SEP_parallel:
				enterOuterAlt(_localctx, 2);
				{
				setState(1575);
				trace_concurrent_expression();
				}
				break;
			case PAREN_L:
				enterOuterAlt(_localctx, 3);
				{
				setState(1576);
				trace_bracketed_expression();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Trace_apply_expressionContext extends ParserRuleContext {
		public Call_statementContext call_statement() {
			return getRuleContext(Call_statementContext.class,0);
		}
		public Trace_apply_expressionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_trace_apply_expression; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterTrace_apply_expression(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitTrace_apply_expression(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitTrace_apply_expression(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Trace_apply_expressionContext trace_apply_expression() throws RecognitionException {
		Trace_apply_expressionContext _localctx = new Trace_apply_expressionContext(_ctx, getState());
		enterRule(_localctx, 280, RULE_trace_apply_expression);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1579);
			call_statement();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Trace_concurrent_expressionContext extends ParserRuleContext {
		public TerminalNode SEP_parallel() { return getToken(VDMParser.SEP_parallel, 0); }
		public TerminalNode PAREN_L() { return getToken(VDMParser.PAREN_L, 0); }
		public List<Trace_definitionContext> trace_definition() {
			return getRuleContexts(Trace_definitionContext.class);
		}
		public Trace_definitionContext trace_definition(int i) {
			return getRuleContext(Trace_definitionContext.class,i);
		}
		public List<TerminalNode> SEP_comma() { return getTokens(VDMParser.SEP_comma); }
		public TerminalNode SEP_comma(int i) {
			return getToken(VDMParser.SEP_comma, i);
		}
		public TerminalNode PAREN_R() { return getToken(VDMParser.PAREN_R, 0); }
		public Trace_concurrent_expressionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_trace_concurrent_expression; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterTrace_concurrent_expression(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitTrace_concurrent_expression(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitTrace_concurrent_expression(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Trace_concurrent_expressionContext trace_concurrent_expression() throws RecognitionException {
		Trace_concurrent_expressionContext _localctx = new Trace_concurrent_expressionContext(_ctx, getState());
		enterRule(_localctx, 282, RULE_trace_concurrent_expression);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1581);
			match(SEP_parallel);
			setState(1582);
			match(PAREN_L);
			setState(1583);
			trace_definition();
			setState(1584);
			match(SEP_comma);
			setState(1585);
			trace_definition();
			setState(1590);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==SEP_comma) {
				{
				{
				setState(1586);
				match(SEP_comma);
				setState(1587);
				trace_definition();
				}
				}
				setState(1592);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(1593);
			match(PAREN_R);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Trace_bracketed_expressionContext extends ParserRuleContext {
		public TerminalNode PAREN_L() { return getToken(VDMParser.PAREN_L, 0); }
		public Trace_definition_listContext trace_definition_list() {
			return getRuleContext(Trace_definition_listContext.class,0);
		}
		public TerminalNode PAREN_R() { return getToken(VDMParser.PAREN_R, 0); }
		public Trace_bracketed_expressionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_trace_bracketed_expression; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterTrace_bracketed_expression(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitTrace_bracketed_expression(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitTrace_bracketed_expression(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Trace_bracketed_expressionContext trace_bracketed_expression() throws RecognitionException {
		Trace_bracketed_expressionContext _localctx = new Trace_bracketed_expressionContext(_ctx, getState());
		enterRule(_localctx, 284, RULE_trace_bracketed_expression);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1595);
			match(PAREN_L);
			setState(1596);
			trace_definition_list();
			setState(1597);
			match(PAREN_R);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class AnnotationsContext extends ParserRuleContext {
		public TerminalNode SEP_ann() { return getToken(VDMParser.SEP_ann, 0); }
		public TerminalNode IDENTIFIER() { return getToken(VDMParser.IDENTIFIER, 0); }
		public TerminalNode PAREN_L() { return getToken(VDMParser.PAREN_L, 0); }
		public TerminalNode PAREN_R() { return getToken(VDMParser.PAREN_R, 0); }
		public TerminalNode CR() { return getToken(VDMParser.CR, 0); }
		public AnnotationsContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_annotations; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterAnnotations(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitAnnotations(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitAnnotations(this);
			else return visitor.visitChildren(this);
		}
	}

	public final AnnotationsContext annotations() throws RecognitionException {
		AnnotationsContext _localctx = new AnnotationsContext(_ctx, getState());
		enterRule(_localctx, 286, RULE_annotations);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1599);
			match(SEP_ann);
			setState(1600);
			match(IDENTIFIER);
			setState(1601);
			match(PAREN_L);
			setState(1602);
			match(PAREN_R);
			setState(1603);
			match(CR);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Expression_listContext extends ParserRuleContext {
		public List<ExpressionContext> expression() {
			return getRuleContexts(ExpressionContext.class);
		}
		public ExpressionContext expression(int i) {
			return getRuleContext(ExpressionContext.class,i);
		}
		public List<TerminalNode> SEP_comma() { return getTokens(VDMParser.SEP_comma); }
		public TerminalNode SEP_comma(int i) {
			return getToken(VDMParser.SEP_comma, i);
		}
		public Expression_listContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_expression_list; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterExpression_list(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitExpression_list(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitExpression_list(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Expression_listContext expression_list() throws RecognitionException {
		Expression_listContext _localctx = new Expression_listContext(_ctx, getState());
		enterRule(_localctx, 288, RULE_expression_list);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1605);
			expression(0);
			setState(1610);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==SEP_comma) {
				{
				{
				setState(1606);
				match(SEP_comma);
				setState(1607);
				expression(0);
				}
				}
				setState(1612);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ExpressionContext extends ParserRuleContext {
		public Bracketed_expressionContext bracketed_expression() {
			return getRuleContext(Bracketed_expressionContext.class,0);
		}
		public Let_expressionContext let_expression() {
			return getRuleContext(Let_expressionContext.class,0);
		}
		public Let_be_expressionContext let_be_expression() {
			return getRuleContext(Let_be_expressionContext.class,0);
		}
		public Def_expressionContext def_expression() {
			return getRuleContext(Def_expressionContext.class,0);
		}
		public If_expressionContext if_expression() {
			return getRuleContext(If_expressionContext.class,0);
		}
		public Cases_expressionContext cases_expression() {
			return getRuleContext(Cases_expressionContext.class,0);
		}
		public Unary_expressionContext unary_expression() {
			return getRuleContext(Unary_expressionContext.class,0);
		}
		public Quantified_expressionContext quantified_expression() {
			return getRuleContext(Quantified_expressionContext.class,0);
		}
		public Iota_expressionContext iota_expression() {
			return getRuleContext(Iota_expressionContext.class,0);
		}
		public Set_enumerationContext set_enumeration() {
			return getRuleContext(Set_enumerationContext.class,0);
		}
		public Set_comprehensionContext set_comprehension() {
			return getRuleContext(Set_comprehensionContext.class,0);
		}
		public Set_range_expressionContext set_range_expression() {
			return getRuleContext(Set_range_expressionContext.class,0);
		}
		public Sequence_enumerationContext sequence_enumeration() {
			return getRuleContext(Sequence_enumerationContext.class,0);
		}
		public Sequence_comprehensionContext sequence_comprehension() {
			return getRuleContext(Sequence_comprehensionContext.class,0);
		}
		public Map_enumerationContext map_enumeration() {
			return getRuleContext(Map_enumerationContext.class,0);
		}
		public Map_comprehensionContext map_comprehension() {
			return getRuleContext(Map_comprehensionContext.class,0);
		}
		public Record_modifierContext record_modifier() {
			return getRuleContext(Record_modifierContext.class,0);
		}
		public Lambda_expressionContext lambda_expression() {
			return getRuleContext(Lambda_expressionContext.class,0);
		}
		public Narrow_expressionContext narrow_expression() {
			return getRuleContext(Narrow_expressionContext.class,0);
		}
		public General_is_expressionContext general_is_expression() {
			return getRuleContext(General_is_expressionContext.class,0);
		}
		public Undefined_expressionContext undefined_expression() {
			return getRuleContext(Undefined_expressionContext.class,0);
		}
		public Precondition_expressionContext precondition_expression() {
			return getRuleContext(Precondition_expressionContext.class,0);
		}
		public Self_expressionContext self_expression() {
			return getRuleContext(Self_expressionContext.class,0);
		}
		public Threadid_expressionContext threadid_expression() {
			return getRuleContext(Threadid_expressionContext.class,0);
		}
		public Isofbaseclass_expressionContext isofbaseclass_expression() {
			return getRuleContext(Isofbaseclass_expressionContext.class,0);
		}
		public Isofclass_expressionContext isofclass_expression() {
			return getRuleContext(Isofclass_expressionContext.class,0);
		}
		public Samebaseclass_expressionContext samebaseclass_expression() {
			return getRuleContext(Samebaseclass_expressionContext.class,0);
		}
		public Sameclass_expressionContext sameclass_expression() {
			return getRuleContext(Sameclass_expressionContext.class,0);
		}
		public Act_expressionContext act_expression() {
			return getRuleContext(Act_expressionContext.class,0);
		}
		public Fin_expressionContext fin_expression() {
			return getRuleContext(Fin_expressionContext.class,0);
		}
		public Active_expressionContext active_expression() {
			return getRuleContext(Active_expressionContext.class,0);
		}
		public Req_expressionContext req_expression() {
			return getRuleContext(Req_expressionContext.class,0);
		}
		public Waiting_expressionContext waiting_expression() {
			return getRuleContext(Waiting_expressionContext.class,0);
		}
		public Time_expressionContext time_expression() {
			return getRuleContext(Time_expressionContext.class,0);
		}
		public Old_nameContext old_name() {
			return getRuleContext(Old_nameContext.class,0);
		}
		public NameContext name() {
			return getRuleContext(NameContext.class,0);
		}
		public Symbolic_literalContext symbolic_literal() {
			return getRuleContext(Symbolic_literalContext.class,0);
		}
		public Tuple_constructorContext tuple_constructor() {
			return getRuleContext(Tuple_constructorContext.class,0);
		}
		public Record_constructorContext record_constructor() {
			return getRuleContext(Record_constructorContext.class,0);
		}
		public New_expressionContext new_expression() {
			return getRuleContext(New_expressionContext.class,0);
		}
		public List<ExpressionContext> expression() {
			return getRuleContexts(ExpressionContext.class);
		}
		public ExpressionContext expression(int i) {
			return getRuleContext(ExpressionContext.class,i);
		}
		public TerminalNode O_EXP() { return getToken(VDMParser.O_EXP, 0); }
		public TerminalNode SLK_comp() { return getToken(VDMParser.SLK_comp, 0); }
		public TerminalNode PAREN_L() { return getToken(VDMParser.PAREN_L, 0); }
		public List<TerminalNode> SEP_comma() { return getTokens(VDMParser.SEP_comma); }
		public TerminalNode SEP_comma(int i) {
			return getToken(VDMParser.SEP_comma, i);
		}
		public TerminalNode SEP_range() { return getToken(VDMParser.SEP_range, 0); }
		public TerminalNode PAREN_R() { return getToken(VDMParser.PAREN_R, 0); }
		public Expression_listContext expression_list() {
			return getRuleContext(Expression_listContext.class,0);
		}
		public TerminalNode BRACE_L() { return getToken(VDMParser.BRACE_L, 0); }
		public List<TypeContext> type() {
			return getRuleContexts(TypeContext.class);
		}
		public TypeContext type(int i) {
			return getRuleContext(TypeContext.class,i);
		}
		public TerminalNode BRACE_R() { return getToken(VDMParser.BRACE_R, 0); }
		public TerminalNode SEP_dot() { return getToken(VDMParser.SEP_dot, 0); }
		public TerminalNode IDENTIFIER() { return getToken(VDMParser.IDENTIFIER, 0); }
		public TerminalNode SEP_tsel() { return getToken(VDMParser.SEP_tsel, 0); }
		public TerminalNode NUMERAL() { return getToken(VDMParser.NUMERAL, 0); }
		public TerminalNode O_NRRES() { return getToken(VDMParser.O_NRRES, 0); }
		public TerminalNode O_RRES() { return getToken(VDMParser.O_RRES, 0); }
		public TerminalNode O_NDRES() { return getToken(VDMParser.O_NDRES, 0); }
		public TerminalNode O_DRES() { return getToken(VDMParser.O_DRES, 0); }
		public TerminalNode SLK_munion() { return getToken(VDMParser.SLK_munion, 0); }
		public TerminalNode O_OVERRIDE() { return getToken(VDMParser.O_OVERRIDE, 0); }
		public TerminalNode SLK_div() { return getToken(VDMParser.SLK_div, 0); }
		public TerminalNode SLK_mod() { return getToken(VDMParser.SLK_mod, 0); }
		public TerminalNode SLK_rem() { return getToken(VDMParser.SLK_rem, 0); }
		public TerminalNode O_DIV() { return getToken(VDMParser.O_DIV, 0); }
		public TerminalNode O_TIMES() { return getToken(VDMParser.O_TIMES, 0); }
		public TerminalNode O_MINUS() { return getToken(VDMParser.O_MINUS, 0); }
		public TerminalNode O_PLUS() { return getToken(VDMParser.O_PLUS, 0); }
		public TerminalNode O_DIFF() { return getToken(VDMParser.O_DIFF, 0); }
		public TerminalNode SLK_union() { return getToken(VDMParser.SLK_union, 0); }
		public TerminalNode SLK_inter() { return getToken(VDMParser.SLK_inter, 0); }
		public TerminalNode O_CONCAT() { return getToken(VDMParser.O_CONCAT, 0); }
		public TerminalNode O_GEQ() { return getToken(VDMParser.O_GEQ, 0); }
		public TerminalNode O_LEQ() { return getToken(VDMParser.O_LEQ, 0); }
		public TerminalNode O_GT() { return getToken(VDMParser.O_GT, 0); }
		public TerminalNode O_LT() { return getToken(VDMParser.O_LT, 0); }
		public TerminalNode O_NEQ() { return getToken(VDMParser.O_NEQ, 0); }
		public TerminalNode O_EQUAL() { return getToken(VDMParser.O_EQUAL, 0); }
		public TerminalNode SLK_ninset() { return getToken(VDMParser.SLK_ninset, 0); }
		public TerminalNode SLK_inset() { return getToken(VDMParser.SLK_inset, 0); }
		public TerminalNode SLK_psubset() { return getToken(VDMParser.SLK_psubset, 0); }
		public TerminalNode SLK_subset() { return getToken(VDMParser.SLK_subset, 0); }
		public TerminalNode SLK_and() { return getToken(VDMParser.SLK_and, 0); }
		public TerminalNode SLK_or() { return getToken(VDMParser.SLK_or, 0); }
		public TerminalNode O_IMPLIES() { return getToken(VDMParser.O_IMPLIES, 0); }
		public TerminalNode O_IFF() { return getToken(VDMParser.O_IFF, 0); }
		public ExpressionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_expression; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterExpression(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitExpression(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitExpression(this);
			else return visitor.visitChildren(this);
		}
	}

	public final ExpressionContext expression() throws RecognitionException {
		return expression(0);
	}

	private ExpressionContext expression(int _p) throws RecognitionException {
		ParserRuleContext _parentctx = _ctx;
		int _parentState = getState();
		ExpressionContext _localctx = new ExpressionContext(_ctx, _parentState);
		ExpressionContext _prevctx = _localctx;
		int _startState = 290;
		enterRecursionRule(_localctx, 290, RULE_expression, _p);
		int _la;
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(1667);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,157,_ctx) ) {
			case 1:
				{
				setState(1614);
				bracketed_expression();
				}
				break;
			case 2:
				{
				setState(1615);
				let_expression();
				}
				break;
			case 3:
				{
				setState(1616);
				let_be_expression();
				}
				break;
			case 4:
				{
				setState(1617);
				def_expression();
				}
				break;
			case 5:
				{
				setState(1618);
				if_expression();
				}
				break;
			case 6:
				{
				setState(1619);
				cases_expression();
				}
				break;
			case 7:
				{
				setState(1620);
				unary_expression();
				}
				break;
			case 8:
				{
				setState(1621);
				quantified_expression();
				}
				break;
			case 9:
				{
				setState(1622);
				iota_expression();
				}
				break;
			case 10:
				{
				setState(1623);
				set_enumeration();
				}
				break;
			case 11:
				{
				setState(1624);
				set_comprehension();
				}
				break;
			case 12:
				{
				setState(1625);
				set_range_expression();
				}
				break;
			case 13:
				{
				setState(1626);
				sequence_enumeration();
				}
				break;
			case 14:
				{
				setState(1627);
				sequence_comprehension();
				}
				break;
			case 15:
				{
				setState(1628);
				map_enumeration();
				}
				break;
			case 16:
				{
				setState(1629);
				map_comprehension();
				}
				break;
			case 17:
				{
				setState(1630);
				record_modifier();
				}
				break;
			case 18:
				{
				setState(1631);
				lambda_expression();
				}
				break;
			case 19:
				{
				setState(1632);
				narrow_expression();
				}
				break;
			case 20:
				{
				setState(1633);
				general_is_expression();
				}
				break;
			case 21:
				{
				setState(1634);
				undefined_expression();
				}
				break;
			case 22:
				{
				setState(1635);
				precondition_expression();
				}
				break;
			case 23:
				{
				setState(1636);
				if (!(!isVDMSL())) throw new FailedPredicateException(this, "!isVDMSL()");
				setState(1637);
				self_expression();
				}
				break;
			case 24:
				{
				setState(1638);
				if (!(isVDMRT())) throw new FailedPredicateException(this, "isVDMRT()");
				setState(1639);
				threadid_expression();
				}
				break;
			case 25:
				{
				setState(1640);
				if (!(!isVDMSL())) throw new FailedPredicateException(this, "!isVDMSL()");
				setState(1641);
				isofbaseclass_expression();
				}
				break;
			case 26:
				{
				setState(1642);
				if (!(!isVDMSL())) throw new FailedPredicateException(this, "!isVDMSL()");
				setState(1643);
				isofclass_expression();
				}
				break;
			case 27:
				{
				setState(1644);
				if (!(!isVDMSL())) throw new FailedPredicateException(this, "!isVDMSL()");
				setState(1645);
				samebaseclass_expression();
				}
				break;
			case 28:
				{
				setState(1646);
				if (!(!isVDMSL())) throw new FailedPredicateException(this, "!isVDMSL()");
				setState(1647);
				sameclass_expression();
				}
				break;
			case 29:
				{
				setState(1648);
				if (!(isVDMRT())) throw new FailedPredicateException(this, "isVDMRT()");
				setState(1649);
				act_expression();
				}
				break;
			case 30:
				{
				setState(1650);
				if (!(isVDMRT())) throw new FailedPredicateException(this, "isVDMRT()");
				setState(1651);
				fin_expression();
				}
				break;
			case 31:
				{
				setState(1652);
				if (!(isVDMRT())) throw new FailedPredicateException(this, "isVDMRT()");
				setState(1653);
				active_expression();
				}
				break;
			case 32:
				{
				setState(1654);
				if (!(isVDMRT())) throw new FailedPredicateException(this, "isVDMRT()");
				setState(1655);
				req_expression();
				}
				break;
			case 33:
				{
				setState(1656);
				if (!(isVDMRT())) throw new FailedPredicateException(this, "isVDMRT()");
				setState(1657);
				waiting_expression();
				}
				break;
			case 34:
				{
				setState(1658);
				if (!(isVDMRT())) throw new FailedPredicateException(this, "isVDMRT()");
				setState(1659);
				time_expression();
				}
				break;
			case 35:
				{
				setState(1660);
				old_name();
				}
				break;
			case 36:
				{
				setState(1661);
				name();
				}
				break;
			case 37:
				{
				setState(1662);
				symbolic_literal();
				}
				break;
			case 38:
				{
				setState(1663);
				tuple_constructor();
				}
				break;
			case 39:
				{
				setState(1664);
				record_constructor();
				}
				break;
			case 40:
				{
				setState(1665);
				if (!(!isVDMSL())) throw new FailedPredicateException(this, "!isVDMSL()");
				setState(1666);
				new_expression();
				}
				break;
			}
			_ctx.stop = _input.LT(-1);
			setState(1803);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,161,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					if ( _parseListeners!=null ) triggerExitRuleEvent();
					_prevctx = _localctx;
					{
					setState(1801);
					_errHandler.sync(this);
					switch ( getInterpreter().adaptivePredict(_input,160,_ctx) ) {
					case 1:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expression);
						setState(1669);
						if (!(precpred(_ctx, 41))) throw new FailedPredicateException(this, "precpred(_ctx, 41)");
						setState(1670);
						match(O_EXP);
						setState(1671);
						expression(41);
						}
						break;
					case 2:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expression);
						setState(1672);
						if (!(precpred(_ctx, 40))) throw new FailedPredicateException(this, "precpred(_ctx, 40)");
						setState(1673);
						match(SLK_comp);
						setState(1674);
						expression(40);
						}
						break;
					case 3:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expression);
						setState(1675);
						if (!(precpred(_ctx, 39))) throw new FailedPredicateException(this, "precpred(_ctx, 39)");
						setState(1676);
						match(PAREN_L);
						setState(1677);
						expression(0);
						setState(1678);
						match(SEP_comma);
						setState(1679);
						match(SEP_range);
						setState(1680);
						match(SEP_comma);
						setState(1681);
						expression(0);
						setState(1682);
						match(PAREN_R);
						}
						break;
					case 4:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expression);
						setState(1684);
						if (!(precpred(_ctx, 38))) throw new FailedPredicateException(this, "precpred(_ctx, 38)");
						setState(1685);
						match(PAREN_L);
						setState(1687);
						_errHandler.sync(this);
						switch ( getInterpreter().adaptivePredict(_input,158,_ctx) ) {
						case 1:
							{
							setState(1686);
							expression_list();
							}
							break;
						}
						setState(1689);
						match(PAREN_R);
						}
						break;
					case 5:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expression);
						setState(1690);
						if (!(precpred(_ctx, 37))) throw new FailedPredicateException(this, "precpred(_ctx, 37)");
						setState(1691);
						match(BRACE_L);
						setState(1692);
						type(0);
						setState(1697);
						_errHandler.sync(this);
						_la = _input.LA(1);
						while (_la==SEP_comma) {
							{
							{
							setState(1693);
							match(SEP_comma);
							setState(1694);
							type(0);
							}
							}
							setState(1699);
							_errHandler.sync(this);
							_la = _input.LA(1);
						}
						setState(1700);
						match(BRACE_R);
						}
						break;
					case 6:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expression);
						setState(1702);
						if (!(precpred(_ctx, 36))) throw new FailedPredicateException(this, "precpred(_ctx, 36)");
						setState(1703);
						match(SEP_dot);
						setState(1704);
						match(IDENTIFIER);
						}
						break;
					case 7:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expression);
						setState(1705);
						if (!(precpred(_ctx, 35))) throw new FailedPredicateException(this, "precpred(_ctx, 35)");
						setState(1706);
						match(SEP_tsel);
						setState(1707);
						match(NUMERAL);
						}
						break;
					case 8:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expression);
						setState(1708);
						if (!(precpred(_ctx, 34))) throw new FailedPredicateException(this, "precpred(_ctx, 34)");
						{
						setState(1709);
						match(O_NRRES);
						setState(1710);
						expression(0);
						}
						}
						break;
					case 9:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expression);
						setState(1711);
						if (!(precpred(_ctx, 33))) throw new FailedPredicateException(this, "precpred(_ctx, 33)");
						{
						setState(1712);
						match(O_RRES);
						setState(1713);
						expression(0);
						}
						}
						break;
					case 10:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expression);
						setState(1714);
						if (!(precpred(_ctx, 32))) throw new FailedPredicateException(this, "precpred(_ctx, 32)");
						{
						setState(1715);
						match(O_NDRES);
						setState(1716);
						expression(0);
						}
						}
						break;
					case 11:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expression);
						setState(1717);
						if (!(precpred(_ctx, 31))) throw new FailedPredicateException(this, "precpred(_ctx, 31)");
						{
						setState(1718);
						match(O_DRES);
						setState(1719);
						expression(0);
						}
						}
						break;
					case 12:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expression);
						setState(1720);
						if (!(precpred(_ctx, 30))) throw new FailedPredicateException(this, "precpred(_ctx, 30)");
						{
						setState(1721);
						match(SLK_munion);
						setState(1722);
						expression(0);
						}
						}
						break;
					case 13:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expression);
						setState(1723);
						if (!(precpred(_ctx, 29))) throw new FailedPredicateException(this, "precpred(_ctx, 29)");
						{
						setState(1724);
						match(O_OVERRIDE);
						setState(1725);
						expression(0);
						}
						}
						break;
					case 14:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expression);
						setState(1726);
						if (!(precpred(_ctx, 28))) throw new FailedPredicateException(this, "precpred(_ctx, 28)");
						{
						setState(1727);
						match(SLK_div);
						setState(1728);
						expression(0);
						}
						}
						break;
					case 15:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expression);
						setState(1729);
						if (!(precpred(_ctx, 27))) throw new FailedPredicateException(this, "precpred(_ctx, 27)");
						{
						setState(1730);
						match(SLK_mod);
						setState(1731);
						expression(0);
						}
						}
						break;
					case 16:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expression);
						setState(1732);
						if (!(precpred(_ctx, 26))) throw new FailedPredicateException(this, "precpred(_ctx, 26)");
						{
						setState(1733);
						match(SLK_rem);
						setState(1734);
						expression(0);
						}
						}
						break;
					case 17:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expression);
						setState(1735);
						if (!(precpred(_ctx, 25))) throw new FailedPredicateException(this, "precpred(_ctx, 25)");
						{
						setState(1736);
						match(O_DIV);
						setState(1737);
						expression(0);
						}
						}
						break;
					case 18:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expression);
						setState(1738);
						if (!(precpred(_ctx, 24))) throw new FailedPredicateException(this, "precpred(_ctx, 24)");
						{
						setState(1739);
						match(O_TIMES);
						setState(1740);
						expression(0);
						}
						}
						break;
					case 19:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expression);
						setState(1741);
						if (!(precpred(_ctx, 23))) throw new FailedPredicateException(this, "precpred(_ctx, 23)");
						{
						setState(1742);
						match(O_MINUS);
						setState(1743);
						expression(0);
						}
						}
						break;
					case 20:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expression);
						setState(1744);
						if (!(precpred(_ctx, 22))) throw new FailedPredicateException(this, "precpred(_ctx, 22)");
						{
						setState(1745);
						match(O_PLUS);
						setState(1746);
						expression(0);
						}
						}
						break;
					case 21:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expression);
						setState(1747);
						if (!(precpred(_ctx, 21))) throw new FailedPredicateException(this, "precpred(_ctx, 21)");
						{
						setState(1748);
						match(O_DIFF);
						setState(1749);
						expression(0);
						}
						}
						break;
					case 22:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expression);
						setState(1750);
						if (!(precpred(_ctx, 20))) throw new FailedPredicateException(this, "precpred(_ctx, 20)");
						{
						setState(1751);
						match(SLK_union);
						setState(1752);
						expression(0);
						}
						}
						break;
					case 23:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expression);
						setState(1753);
						if (!(precpred(_ctx, 19))) throw new FailedPredicateException(this, "precpred(_ctx, 19)");
						{
						setState(1754);
						match(SLK_inter);
						setState(1755);
						expression(0);
						}
						}
						break;
					case 24:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expression);
						setState(1756);
						if (!(precpred(_ctx, 18))) throw new FailedPredicateException(this, "precpred(_ctx, 18)");
						{
						setState(1757);
						match(O_CONCAT);
						setState(1758);
						expression(0);
						}
						}
						break;
					case 25:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expression);
						setState(1759);
						if (!(precpred(_ctx, 17))) throw new FailedPredicateException(this, "precpred(_ctx, 17)");
						{
						setState(1760);
						match(O_GEQ);
						setState(1761);
						expression(0);
						}
						}
						break;
					case 26:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expression);
						setState(1762);
						if (!(precpred(_ctx, 16))) throw new FailedPredicateException(this, "precpred(_ctx, 16)");
						{
						setState(1763);
						match(O_LEQ);
						setState(1764);
						expression(0);
						}
						}
						break;
					case 27:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expression);
						setState(1765);
						if (!(precpred(_ctx, 15))) throw new FailedPredicateException(this, "precpred(_ctx, 15)");
						{
						setState(1766);
						match(O_GT);
						setState(1767);
						expression(0);
						}
						}
						break;
					case 28:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expression);
						setState(1768);
						if (!(precpred(_ctx, 14))) throw new FailedPredicateException(this, "precpred(_ctx, 14)");
						{
						setState(1769);
						match(O_LT);
						setState(1770);
						expression(0);
						}
						}
						break;
					case 29:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expression);
						setState(1771);
						if (!(precpred(_ctx, 13))) throw new FailedPredicateException(this, "precpred(_ctx, 13)");
						{
						setState(1772);
						match(O_NEQ);
						setState(1773);
						expression(0);
						}
						}
						break;
					case 30:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expression);
						setState(1774);
						if (!(precpred(_ctx, 12))) throw new FailedPredicateException(this, "precpred(_ctx, 12)");
						{
						setState(1775);
						match(O_EQUAL);
						setState(1776);
						expression(0);
						}
						}
						break;
					case 31:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expression);
						setState(1777);
						if (!(precpred(_ctx, 11))) throw new FailedPredicateException(this, "precpred(_ctx, 11)");
						{
						setState(1778);
						match(SLK_ninset);
						setState(1779);
						expression(0);
						}
						}
						break;
					case 32:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expression);
						setState(1780);
						if (!(precpred(_ctx, 10))) throw new FailedPredicateException(this, "precpred(_ctx, 10)");
						{
						setState(1781);
						match(SLK_inset);
						setState(1782);
						expression(0);
						}
						}
						break;
					case 33:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expression);
						setState(1783);
						if (!(precpred(_ctx, 9))) throw new FailedPredicateException(this, "precpred(_ctx, 9)");
						{
						setState(1784);
						match(SLK_psubset);
						setState(1785);
						expression(0);
						}
						}
						break;
					case 34:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expression);
						setState(1786);
						if (!(precpred(_ctx, 8))) throw new FailedPredicateException(this, "precpred(_ctx, 8)");
						{
						setState(1787);
						match(SLK_subset);
						setState(1788);
						expression(0);
						}
						}
						break;
					case 35:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expression);
						setState(1789);
						if (!(precpred(_ctx, 7))) throw new FailedPredicateException(this, "precpred(_ctx, 7)");
						{
						setState(1790);
						match(SLK_and);
						setState(1791);
						expression(0);
						}
						}
						break;
					case 36:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expression);
						setState(1792);
						if (!(precpred(_ctx, 6))) throw new FailedPredicateException(this, "precpred(_ctx, 6)");
						{
						setState(1793);
						match(SLK_or);
						setState(1794);
						expression(0);
						}
						}
						break;
					case 37:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expression);
						setState(1795);
						if (!(precpred(_ctx, 5))) throw new FailedPredicateException(this, "precpred(_ctx, 5)");
						{
						setState(1796);
						match(O_IMPLIES);
						setState(1797);
						expression(0);
						}
						}
						break;
					case 38:
						{
						_localctx = new ExpressionContext(_parentctx, _parentState);
						pushNewRecursionContext(_localctx, _startState, RULE_expression);
						setState(1798);
						if (!(precpred(_ctx, 4))) throw new FailedPredicateException(this, "precpred(_ctx, 4)");
						{
						setState(1799);
						match(O_IFF);
						setState(1800);
						expression(0);
						}
						}
						break;
					}
					} 
				}
				setState(1805);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,161,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			unrollRecursionContexts(_parentctx);
		}
		return _localctx;
	}

	public static class Bracketed_expressionContext extends ParserRuleContext {
		public TerminalNode PAREN_L() { return getToken(VDMParser.PAREN_L, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public TerminalNode PAREN_R() { return getToken(VDMParser.PAREN_R, 0); }
		public Bracketed_expressionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_bracketed_expression; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterBracketed_expression(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitBracketed_expression(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitBracketed_expression(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Bracketed_expressionContext bracketed_expression() throws RecognitionException {
		Bracketed_expressionContext _localctx = new Bracketed_expressionContext(_ctx, getState());
		enterRule(_localctx, 292, RULE_bracketed_expression);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1806);
			match(PAREN_L);
			setState(1807);
			expression(0);
			setState(1808);
			match(PAREN_R);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Let_expressionContext extends ParserRuleContext {
		public TerminalNode SLK_let() { return getToken(VDMParser.SLK_let, 0); }
		public Local_definition_listContext local_definition_list() {
			return getRuleContext(Local_definition_listContext.class,0);
		}
		public TerminalNode SLK_in() { return getToken(VDMParser.SLK_in, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public Let_expressionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_let_expression; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterLet_expression(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitLet_expression(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitLet_expression(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Let_expressionContext let_expression() throws RecognitionException {
		Let_expressionContext _localctx = new Let_expressionContext(_ctx, getState());
		enterRule(_localctx, 294, RULE_let_expression);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1810);
			match(SLK_let);
			setState(1811);
			local_definition_list();
			setState(1812);
			match(SLK_in);
			setState(1813);
			expression(0);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Let_be_expressionContext extends ParserRuleContext {
		public TerminalNode SLK_let() { return getToken(VDMParser.SLK_let, 0); }
		public Multiple_bindContext multiple_bind() {
			return getRuleContext(Multiple_bindContext.class,0);
		}
		public TerminalNode SLK_in() { return getToken(VDMParser.SLK_in, 0); }
		public List<ExpressionContext> expression() {
			return getRuleContexts(ExpressionContext.class);
		}
		public ExpressionContext expression(int i) {
			return getRuleContext(ExpressionContext.class,i);
		}
		public TerminalNode SLK_best() { return getToken(VDMParser.SLK_best, 0); }
		public Let_be_expressionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_let_be_expression; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterLet_be_expression(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitLet_be_expression(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitLet_be_expression(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Let_be_expressionContext let_be_expression() throws RecognitionException {
		Let_be_expressionContext _localctx = new Let_be_expressionContext(_ctx, getState());
		enterRule(_localctx, 296, RULE_let_be_expression);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1815);
			match(SLK_let);
			setState(1816);
			multiple_bind();
			setState(1819);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SLK_best) {
				{
				setState(1817);
				match(SLK_best);
				setState(1818);
				expression(0);
				}
			}

			setState(1821);
			match(SLK_in);
			setState(1822);
			expression(0);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Def_expressionContext extends ParserRuleContext {
		public TerminalNode SLK_def() { return getToken(VDMParser.SLK_def, 0); }
		public List<Pattern_bindContext> pattern_bind() {
			return getRuleContexts(Pattern_bindContext.class);
		}
		public Pattern_bindContext pattern_bind(int i) {
			return getRuleContext(Pattern_bindContext.class,i);
		}
		public List<TerminalNode> O_EQUAL() { return getTokens(VDMParser.O_EQUAL); }
		public TerminalNode O_EQUAL(int i) {
			return getToken(VDMParser.O_EQUAL, i);
		}
		public List<ExpressionContext> expression() {
			return getRuleContexts(ExpressionContext.class);
		}
		public ExpressionContext expression(int i) {
			return getRuleContext(ExpressionContext.class,i);
		}
		public TerminalNode SLK_in() { return getToken(VDMParser.SLK_in, 0); }
		public List<TerminalNode> SEP_scolon() { return getTokens(VDMParser.SEP_scolon); }
		public TerminalNode SEP_scolon(int i) {
			return getToken(VDMParser.SEP_scolon, i);
		}
		public Def_expressionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_def_expression; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterDef_expression(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitDef_expression(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitDef_expression(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Def_expressionContext def_expression() throws RecognitionException {
		Def_expressionContext _localctx = new Def_expressionContext(_ctx, getState());
		enterRule(_localctx, 298, RULE_def_expression);
		int _la;
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(1824);
			match(SLK_def);
			setState(1825);
			pattern_bind();
			setState(1826);
			match(O_EQUAL);
			setState(1827);
			expression(0);
			setState(1835);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,163,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					{
					{
					setState(1828);
					match(SEP_scolon);
					setState(1829);
					pattern_bind();
					setState(1830);
					match(O_EQUAL);
					setState(1831);
					expression(0);
					}
					} 
				}
				setState(1837);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,163,_ctx);
			}
			setState(1839);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SEP_scolon) {
				{
				setState(1838);
				match(SEP_scolon);
				}
			}

			setState(1841);
			match(SLK_in);
			setState(1842);
			expression(0);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class If_expressionContext extends ParserRuleContext {
		public TerminalNode SLK_if() { return getToken(VDMParser.SLK_if, 0); }
		public List<ExpressionContext> expression() {
			return getRuleContexts(ExpressionContext.class);
		}
		public ExpressionContext expression(int i) {
			return getRuleContext(ExpressionContext.class,i);
		}
		public TerminalNode SLK_then() { return getToken(VDMParser.SLK_then, 0); }
		public TerminalNode SLK_else() { return getToken(VDMParser.SLK_else, 0); }
		public List<Elseif_expressionContext> elseif_expression() {
			return getRuleContexts(Elseif_expressionContext.class);
		}
		public Elseif_expressionContext elseif_expression(int i) {
			return getRuleContext(Elseif_expressionContext.class,i);
		}
		public If_expressionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_if_expression; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterIf_expression(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitIf_expression(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitIf_expression(this);
			else return visitor.visitChildren(this);
		}
	}

	public final If_expressionContext if_expression() throws RecognitionException {
		If_expressionContext _localctx = new If_expressionContext(_ctx, getState());
		enterRule(_localctx, 300, RULE_if_expression);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1844);
			match(SLK_if);
			setState(1845);
			expression(0);
			setState(1846);
			match(SLK_then);
			setState(1847);
			expression(0);
			setState(1851);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==SLK_elseif) {
				{
				{
				setState(1848);
				elseif_expression();
				}
				}
				setState(1853);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(1854);
			match(SLK_else);
			setState(1855);
			expression(0);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Elseif_expressionContext extends ParserRuleContext {
		public TerminalNode SLK_elseif() { return getToken(VDMParser.SLK_elseif, 0); }
		public List<ExpressionContext> expression() {
			return getRuleContexts(ExpressionContext.class);
		}
		public ExpressionContext expression(int i) {
			return getRuleContext(ExpressionContext.class,i);
		}
		public TerminalNode SLK_then() { return getToken(VDMParser.SLK_then, 0); }
		public Elseif_expressionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_elseif_expression; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterElseif_expression(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitElseif_expression(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitElseif_expression(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Elseif_expressionContext elseif_expression() throws RecognitionException {
		Elseif_expressionContext _localctx = new Elseif_expressionContext(_ctx, getState());
		enterRule(_localctx, 302, RULE_elseif_expression);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1857);
			match(SLK_elseif);
			setState(1858);
			expression(0);
			setState(1859);
			match(SLK_then);
			setState(1860);
			expression(0);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Cases_expressionContext extends ParserRuleContext {
		public TerminalNode SLK_cases() { return getToken(VDMParser.SLK_cases, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public TerminalNode SEP_colon() { return getToken(VDMParser.SEP_colon, 0); }
		public Cases_expression_alternativesContext cases_expression_alternatives() {
			return getRuleContext(Cases_expression_alternativesContext.class,0);
		}
		public TerminalNode SLK_end() { return getToken(VDMParser.SLK_end, 0); }
		public TerminalNode SEP_comma() { return getToken(VDMParser.SEP_comma, 0); }
		public Others_expressionContext others_expression() {
			return getRuleContext(Others_expressionContext.class,0);
		}
		public Cases_expressionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_cases_expression; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterCases_expression(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitCases_expression(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitCases_expression(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Cases_expressionContext cases_expression() throws RecognitionException {
		Cases_expressionContext _localctx = new Cases_expressionContext(_ctx, getState());
		enterRule(_localctx, 304, RULE_cases_expression);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1862);
			match(SLK_cases);
			setState(1863);
			expression(0);
			setState(1864);
			match(SEP_colon);
			setState(1865);
			cases_expression_alternatives();
			setState(1868);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SEP_comma) {
				{
				setState(1866);
				match(SEP_comma);
				setState(1867);
				others_expression();
				}
			}

			setState(1870);
			match(SLK_end);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Cases_expression_alternativesContext extends ParserRuleContext {
		public List<Cases_expression_alternativeContext> cases_expression_alternative() {
			return getRuleContexts(Cases_expression_alternativeContext.class);
		}
		public Cases_expression_alternativeContext cases_expression_alternative(int i) {
			return getRuleContext(Cases_expression_alternativeContext.class,i);
		}
		public List<TerminalNode> SEP_comma() { return getTokens(VDMParser.SEP_comma); }
		public TerminalNode SEP_comma(int i) {
			return getToken(VDMParser.SEP_comma, i);
		}
		public Cases_expression_alternativesContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_cases_expression_alternatives; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterCases_expression_alternatives(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitCases_expression_alternatives(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitCases_expression_alternatives(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Cases_expression_alternativesContext cases_expression_alternatives() throws RecognitionException {
		Cases_expression_alternativesContext _localctx = new Cases_expression_alternativesContext(_ctx, getState());
		enterRule(_localctx, 306, RULE_cases_expression_alternatives);
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(1872);
			cases_expression_alternative();
			setState(1877);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,167,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					{
					{
					setState(1873);
					match(SEP_comma);
					setState(1874);
					cases_expression_alternative();
					}
					} 
				}
				setState(1879);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,167,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Cases_expression_alternativeContext extends ParserRuleContext {
		public Pattern_listContext pattern_list() {
			return getRuleContext(Pattern_listContext.class,0);
		}
		public TerminalNode SEP_pfcn() { return getToken(VDMParser.SEP_pfcn, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public Cases_expression_alternativeContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_cases_expression_alternative; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterCases_expression_alternative(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitCases_expression_alternative(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitCases_expression_alternative(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Cases_expression_alternativeContext cases_expression_alternative() throws RecognitionException {
		Cases_expression_alternativeContext _localctx = new Cases_expression_alternativeContext(_ctx, getState());
		enterRule(_localctx, 308, RULE_cases_expression_alternative);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1880);
			pattern_list();
			setState(1881);
			match(SEP_pfcn);
			setState(1882);
			expression(0);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Others_expressionContext extends ParserRuleContext {
		public TerminalNode SLK_others() { return getToken(VDMParser.SLK_others, 0); }
		public TerminalNode SEP_pfcn() { return getToken(VDMParser.SEP_pfcn, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public Others_expressionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_others_expression; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterOthers_expression(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitOthers_expression(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitOthers_expression(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Others_expressionContext others_expression() throws RecognitionException {
		Others_expressionContext _localctx = new Others_expressionContext(_ctx, getState());
		enterRule(_localctx, 310, RULE_others_expression);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1884);
			match(SLK_others);
			setState(1885);
			match(SEP_pfcn);
			setState(1886);
			expression(0);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Unary_expressionContext extends ParserRuleContext {
		public Unary_expressionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_unary_expression; }
	 
		public Unary_expressionContext() { }
		public void copyFrom(Unary_expressionContext ctx) {
			super.copyFrom(ctx);
		}
	}
	public static class RngExprContext extends Unary_expressionContext {
		public TerminalNode SLK_rng() { return getToken(VDMParser.SLK_rng, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public RngExprContext(Unary_expressionContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterRngExpr(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitRngExpr(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitRngExpr(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class DinterExprContext extends Unary_expressionContext {
		public TerminalNode SLK_dinter() { return getToken(VDMParser.SLK_dinter, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public DinterExprContext(Unary_expressionContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterDinterExpr(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitDinterExpr(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitDinterExpr(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class ElemsExprContext extends Unary_expressionContext {
		public TerminalNode SLK_elems() { return getToken(VDMParser.SLK_elems, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public ElemsExprContext(Unary_expressionContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterElemsExpr(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitElemsExpr(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitElemsExpr(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class DomExprContext extends Unary_expressionContext {
		public TerminalNode SLK_dom() { return getToken(VDMParser.SLK_dom, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public DomExprContext(Unary_expressionContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterDomExpr(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitDomExpr(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitDomExpr(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class MapInverseExprContext extends Unary_expressionContext {
		public TerminalNode SLK_inverse() { return getToken(VDMParser.SLK_inverse, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public MapInverseExprContext(Unary_expressionContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterMapInverseExpr(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitMapInverseExpr(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitMapInverseExpr(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class AbsoluteExprContext extends Unary_expressionContext {
		public TerminalNode SLK_abs() { return getToken(VDMParser.SLK_abs, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public AbsoluteExprContext(Unary_expressionContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterAbsoluteExpr(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitAbsoluteExpr(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitAbsoluteExpr(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class TlExprContext extends Unary_expressionContext {
		public TerminalNode SLK_tl() { return getToken(VDMParser.SLK_tl, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public TlExprContext(Unary_expressionContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterTlExpr(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitTlExpr(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitTlExpr(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class ReverseExprContext extends Unary_expressionContext {
		public TerminalNode SLK_reverse() { return getToken(VDMParser.SLK_reverse, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public ReverseExprContext(Unary_expressionContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterReverseExpr(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitReverseExpr(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitReverseExpr(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class LenExprContext extends Unary_expressionContext {
		public TerminalNode SLK_len() { return getToken(VDMParser.SLK_len, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public LenExprContext(Unary_expressionContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterLenExpr(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitLenExpr(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitLenExpr(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class MergeExprContext extends Unary_expressionContext {
		public TerminalNode SLK_merge() { return getToken(VDMParser.SLK_merge, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public MergeExprContext(Unary_expressionContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterMergeExpr(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitMergeExpr(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitMergeExpr(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class HdExprContext extends Unary_expressionContext {
		public TerminalNode SLK_hd() { return getToken(VDMParser.SLK_hd, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public HdExprContext(Unary_expressionContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterHdExpr(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitHdExpr(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitHdExpr(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class PowerExprContext extends Unary_expressionContext {
		public TerminalNode SLK_power() { return getToken(VDMParser.SLK_power, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public PowerExprContext(Unary_expressionContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterPowerExpr(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitPowerExpr(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitPowerExpr(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class DunionExprContext extends Unary_expressionContext {
		public TerminalNode SLK_dunion() { return getToken(VDMParser.SLK_dunion, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public DunionExprContext(Unary_expressionContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterDunionExpr(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitDunionExpr(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitDunionExpr(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class CardExprContext extends Unary_expressionContext {
		public TerminalNode SLK_card() { return getToken(VDMParser.SLK_card, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public CardExprContext(Unary_expressionContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterCardExpr(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitCardExpr(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitCardExpr(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class IndsExprContext extends Unary_expressionContext {
		public TerminalNode SLK_inds() { return getToken(VDMParser.SLK_inds, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public IndsExprContext(Unary_expressionContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterIndsExpr(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitIndsExpr(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitIndsExpr(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class UnaryPlusExprContext extends Unary_expressionContext {
		public TerminalNode O_PLUS() { return getToken(VDMParser.O_PLUS, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public UnaryPlusExprContext(Unary_expressionContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterUnaryPlusExpr(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitUnaryPlusExpr(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitUnaryPlusExpr(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class FloorExprContext extends Unary_expressionContext {
		public TerminalNode SLK_floor() { return getToken(VDMParser.SLK_floor, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public FloorExprContext(Unary_expressionContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterFloorExpr(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitFloorExpr(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitFloorExpr(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class NotExprContext extends Unary_expressionContext {
		public TerminalNode SLK_not() { return getToken(VDMParser.SLK_not, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public NotExprContext(Unary_expressionContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterNotExpr(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitNotExpr(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitNotExpr(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class ConcExprContext extends Unary_expressionContext {
		public TerminalNode SLK_conc() { return getToken(VDMParser.SLK_conc, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public ConcExprContext(Unary_expressionContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterConcExpr(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitConcExpr(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitConcExpr(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class UnaryMinusExprContext extends Unary_expressionContext {
		public TerminalNode O_MINUS() { return getToken(VDMParser.O_MINUS, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public UnaryMinusExprContext(Unary_expressionContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterUnaryMinusExpr(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitUnaryMinusExpr(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitUnaryMinusExpr(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Unary_expressionContext unary_expression() throws RecognitionException {
		Unary_expressionContext _localctx = new Unary_expressionContext(_ctx, getState());
		enterRule(_localctx, 312, RULE_unary_expression);
		try {
			setState(1928);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case O_PLUS:
				_localctx = new UnaryPlusExprContext(_localctx);
				enterOuterAlt(_localctx, 1);
				{
				setState(1888);
				match(O_PLUS);
				setState(1889);
				expression(0);
				}
				break;
			case O_MINUS:
				_localctx = new UnaryMinusExprContext(_localctx);
				enterOuterAlt(_localctx, 2);
				{
				setState(1890);
				match(O_MINUS);
				setState(1891);
				expression(0);
				}
				break;
			case SLK_abs:
				_localctx = new AbsoluteExprContext(_localctx);
				enterOuterAlt(_localctx, 3);
				{
				setState(1892);
				match(SLK_abs);
				setState(1893);
				expression(0);
				}
				break;
			case SLK_floor:
				_localctx = new FloorExprContext(_localctx);
				enterOuterAlt(_localctx, 4);
				{
				setState(1894);
				match(SLK_floor);
				setState(1895);
				expression(0);
				}
				break;
			case SLK_not:
				_localctx = new NotExprContext(_localctx);
				enterOuterAlt(_localctx, 5);
				{
				setState(1896);
				match(SLK_not);
				setState(1897);
				expression(0);
				}
				break;
			case SLK_card:
				_localctx = new CardExprContext(_localctx);
				enterOuterAlt(_localctx, 6);
				{
				setState(1898);
				match(SLK_card);
				setState(1899);
				expression(0);
				}
				break;
			case SLK_power:
				_localctx = new PowerExprContext(_localctx);
				enterOuterAlt(_localctx, 7);
				{
				setState(1900);
				match(SLK_power);
				setState(1901);
				expression(0);
				}
				break;
			case SLK_dunion:
				_localctx = new DunionExprContext(_localctx);
				enterOuterAlt(_localctx, 8);
				{
				setState(1902);
				match(SLK_dunion);
				setState(1903);
				expression(0);
				}
				break;
			case SLK_dinter:
				_localctx = new DinterExprContext(_localctx);
				enterOuterAlt(_localctx, 9);
				{
				setState(1904);
				match(SLK_dinter);
				setState(1905);
				expression(0);
				}
				break;
			case SLK_hd:
				_localctx = new HdExprContext(_localctx);
				enterOuterAlt(_localctx, 10);
				{
				setState(1906);
				match(SLK_hd);
				setState(1907);
				expression(0);
				}
				break;
			case SLK_tl:
				_localctx = new TlExprContext(_localctx);
				enterOuterAlt(_localctx, 11);
				{
				setState(1908);
				match(SLK_tl);
				setState(1909);
				expression(0);
				}
				break;
			case SLK_len:
				_localctx = new LenExprContext(_localctx);
				enterOuterAlt(_localctx, 12);
				{
				setState(1910);
				match(SLK_len);
				setState(1911);
				expression(0);
				}
				break;
			case SLK_elems:
				_localctx = new ElemsExprContext(_localctx);
				enterOuterAlt(_localctx, 13);
				{
				setState(1912);
				match(SLK_elems);
				setState(1913);
				expression(0);
				}
				break;
			case SLK_inds:
				_localctx = new IndsExprContext(_localctx);
				enterOuterAlt(_localctx, 14);
				{
				setState(1914);
				match(SLK_inds);
				setState(1915);
				expression(0);
				}
				break;
			case SLK_reverse:
				_localctx = new ReverseExprContext(_localctx);
				enterOuterAlt(_localctx, 15);
				{
				setState(1916);
				match(SLK_reverse);
				setState(1917);
				expression(0);
				}
				break;
			case SLK_conc:
				_localctx = new ConcExprContext(_localctx);
				enterOuterAlt(_localctx, 16);
				{
				setState(1918);
				match(SLK_conc);
				setState(1919);
				expression(0);
				}
				break;
			case SLK_dom:
				_localctx = new DomExprContext(_localctx);
				enterOuterAlt(_localctx, 17);
				{
				setState(1920);
				match(SLK_dom);
				setState(1921);
				expression(0);
				}
				break;
			case SLK_rng:
				_localctx = new RngExprContext(_localctx);
				enterOuterAlt(_localctx, 18);
				{
				setState(1922);
				match(SLK_rng);
				setState(1923);
				expression(0);
				}
				break;
			case SLK_merge:
				_localctx = new MergeExprContext(_localctx);
				enterOuterAlt(_localctx, 19);
				{
				setState(1924);
				match(SLK_merge);
				setState(1925);
				expression(0);
				}
				break;
			case SLK_inverse:
				_localctx = new MapInverseExprContext(_localctx);
				enterOuterAlt(_localctx, 20);
				{
				setState(1926);
				match(SLK_inverse);
				setState(1927);
				expression(0);
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Quantified_expressionContext extends ParserRuleContext {
		public All_expressionContext all_expression() {
			return getRuleContext(All_expressionContext.class,0);
		}
		public Exists_expressionContext exists_expression() {
			return getRuleContext(Exists_expressionContext.class,0);
		}
		public Exists_unique_expressionContext exists_unique_expression() {
			return getRuleContext(Exists_unique_expressionContext.class,0);
		}
		public Quantified_expressionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_quantified_expression; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterQuantified_expression(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitQuantified_expression(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitQuantified_expression(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Quantified_expressionContext quantified_expression() throws RecognitionException {
		Quantified_expressionContext _localctx = new Quantified_expressionContext(_ctx, getState());
		enterRule(_localctx, 314, RULE_quantified_expression);
		try {
			setState(1933);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case SLK_forall:
				enterOuterAlt(_localctx, 1);
				{
				setState(1930);
				all_expression();
				}
				break;
			case SLK_exists:
				enterOuterAlt(_localctx, 2);
				{
				setState(1931);
				exists_expression();
				}
				break;
			case SLK_exists1:
				enterOuterAlt(_localctx, 3);
				{
				setState(1932);
				exists_unique_expression();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class All_expressionContext extends ParserRuleContext {
		public TerminalNode SLK_forall() { return getToken(VDMParser.SLK_forall, 0); }
		public Bind_listContext bind_list() {
			return getRuleContext(Bind_listContext.class,0);
		}
		public TerminalNode SEP_amp() { return getToken(VDMParser.SEP_amp, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public All_expressionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_all_expression; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterAll_expression(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitAll_expression(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitAll_expression(this);
			else return visitor.visitChildren(this);
		}
	}

	public final All_expressionContext all_expression() throws RecognitionException {
		All_expressionContext _localctx = new All_expressionContext(_ctx, getState());
		enterRule(_localctx, 316, RULE_all_expression);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1935);
			match(SLK_forall);
			setState(1936);
			bind_list();
			setState(1937);
			match(SEP_amp);
			setState(1938);
			expression(0);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Exists_expressionContext extends ParserRuleContext {
		public TerminalNode SLK_exists() { return getToken(VDMParser.SLK_exists, 0); }
		public Bind_listContext bind_list() {
			return getRuleContext(Bind_listContext.class,0);
		}
		public TerminalNode SEP_amp() { return getToken(VDMParser.SEP_amp, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public Exists_expressionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_exists_expression; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterExists_expression(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitExists_expression(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitExists_expression(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Exists_expressionContext exists_expression() throws RecognitionException {
		Exists_expressionContext _localctx = new Exists_expressionContext(_ctx, getState());
		enterRule(_localctx, 318, RULE_exists_expression);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1940);
			match(SLK_exists);
			setState(1941);
			bind_list();
			setState(1942);
			match(SEP_amp);
			setState(1943);
			expression(0);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Exists_unique_expressionContext extends ParserRuleContext {
		public TerminalNode SLK_exists1() { return getToken(VDMParser.SLK_exists1, 0); }
		public BindContext bind() {
			return getRuleContext(BindContext.class,0);
		}
		public TerminalNode SEP_amp() { return getToken(VDMParser.SEP_amp, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public Exists_unique_expressionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_exists_unique_expression; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterExists_unique_expression(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitExists_unique_expression(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitExists_unique_expression(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Exists_unique_expressionContext exists_unique_expression() throws RecognitionException {
		Exists_unique_expressionContext _localctx = new Exists_unique_expressionContext(_ctx, getState());
		enterRule(_localctx, 320, RULE_exists_unique_expression);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1945);
			match(SLK_exists1);
			setState(1946);
			bind();
			setState(1947);
			match(SEP_amp);
			setState(1948);
			expression(0);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Iota_expressionContext extends ParserRuleContext {
		public TerminalNode SLK_iota() { return getToken(VDMParser.SLK_iota, 0); }
		public BindContext bind() {
			return getRuleContext(BindContext.class,0);
		}
		public TerminalNode SEP_amp() { return getToken(VDMParser.SEP_amp, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public Iota_expressionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_iota_expression; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterIota_expression(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitIota_expression(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitIota_expression(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Iota_expressionContext iota_expression() throws RecognitionException {
		Iota_expressionContext _localctx = new Iota_expressionContext(_ctx, getState());
		enterRule(_localctx, 322, RULE_iota_expression);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1950);
			match(SLK_iota);
			setState(1951);
			bind();
			setState(1952);
			match(SEP_amp);
			setState(1953);
			expression(0);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Set_enumerationContext extends ParserRuleContext {
		public TerminalNode BRACE_L() { return getToken(VDMParser.BRACE_L, 0); }
		public Expression_listContext expression_list() {
			return getRuleContext(Expression_listContext.class,0);
		}
		public TerminalNode BRACE_R() { return getToken(VDMParser.BRACE_R, 0); }
		public Set_enumerationContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_set_enumeration; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterSet_enumeration(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitSet_enumeration(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitSet_enumeration(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Set_enumerationContext set_enumeration() throws RecognitionException {
		Set_enumerationContext _localctx = new Set_enumerationContext(_ctx, getState());
		enterRule(_localctx, 324, RULE_set_enumeration);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1955);
			match(BRACE_L);
			setState(1956);
			expression_list();
			setState(1957);
			match(BRACE_R);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Set_comprehensionContext extends ParserRuleContext {
		public TerminalNode BRACE_L() { return getToken(VDMParser.BRACE_L, 0); }
		public List<ExpressionContext> expression() {
			return getRuleContexts(ExpressionContext.class);
		}
		public ExpressionContext expression(int i) {
			return getRuleContext(ExpressionContext.class,i);
		}
		public TerminalNode SEP_bar() { return getToken(VDMParser.SEP_bar, 0); }
		public Bind_listContext bind_list() {
			return getRuleContext(Bind_listContext.class,0);
		}
		public TerminalNode BRACE_R() { return getToken(VDMParser.BRACE_R, 0); }
		public TerminalNode SEP_amp() { return getToken(VDMParser.SEP_amp, 0); }
		public Set_comprehensionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_set_comprehension; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterSet_comprehension(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitSet_comprehension(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitSet_comprehension(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Set_comprehensionContext set_comprehension() throws RecognitionException {
		Set_comprehensionContext _localctx = new Set_comprehensionContext(_ctx, getState());
		enterRule(_localctx, 326, RULE_set_comprehension);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1959);
			match(BRACE_L);
			setState(1960);
			expression(0);
			setState(1961);
			match(SEP_bar);
			setState(1962);
			bind_list();
			setState(1965);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SEP_amp) {
				{
				setState(1963);
				match(SEP_amp);
				setState(1964);
				expression(0);
				}
			}

			setState(1967);
			match(BRACE_R);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Set_range_expressionContext extends ParserRuleContext {
		public TerminalNode BRACE_L() { return getToken(VDMParser.BRACE_L, 0); }
		public List<ExpressionContext> expression() {
			return getRuleContexts(ExpressionContext.class);
		}
		public ExpressionContext expression(int i) {
			return getRuleContext(ExpressionContext.class,i);
		}
		public List<TerminalNode> SEP_comma() { return getTokens(VDMParser.SEP_comma); }
		public TerminalNode SEP_comma(int i) {
			return getToken(VDMParser.SEP_comma, i);
		}
		public TerminalNode SEP_range() { return getToken(VDMParser.SEP_range, 0); }
		public TerminalNode BRACE_R() { return getToken(VDMParser.BRACE_R, 0); }
		public Set_range_expressionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_set_range_expression; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterSet_range_expression(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitSet_range_expression(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitSet_range_expression(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Set_range_expressionContext set_range_expression() throws RecognitionException {
		Set_range_expressionContext _localctx = new Set_range_expressionContext(_ctx, getState());
		enterRule(_localctx, 328, RULE_set_range_expression);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1969);
			match(BRACE_L);
			setState(1970);
			expression(0);
			setState(1971);
			match(SEP_comma);
			setState(1972);
			match(SEP_range);
			setState(1973);
			match(SEP_comma);
			setState(1974);
			expression(0);
			setState(1975);
			match(BRACE_R);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Sequence_enumerationContext extends ParserRuleContext {
		public TerminalNode BRACKET_L() { return getToken(VDMParser.BRACKET_L, 0); }
		public Expression_listContext expression_list() {
			return getRuleContext(Expression_listContext.class,0);
		}
		public TerminalNode BRACKET_R() { return getToken(VDMParser.BRACKET_R, 0); }
		public Sequence_enumerationContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_sequence_enumeration; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterSequence_enumeration(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitSequence_enumeration(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitSequence_enumeration(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Sequence_enumerationContext sequence_enumeration() throws RecognitionException {
		Sequence_enumerationContext _localctx = new Sequence_enumerationContext(_ctx, getState());
		enterRule(_localctx, 330, RULE_sequence_enumeration);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1977);
			match(BRACKET_L);
			setState(1978);
			expression_list();
			setState(1979);
			match(BRACKET_R);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Sequence_comprehensionContext extends ParserRuleContext {
		public TerminalNode BRACKET_L() { return getToken(VDMParser.BRACKET_L, 0); }
		public List<ExpressionContext> expression() {
			return getRuleContexts(ExpressionContext.class);
		}
		public ExpressionContext expression(int i) {
			return getRuleContext(ExpressionContext.class,i);
		}
		public TerminalNode SEP_bar() { return getToken(VDMParser.SEP_bar, 0); }
		public Bind_listContext bind_list() {
			return getRuleContext(Bind_listContext.class,0);
		}
		public TerminalNode BRACKET_R() { return getToken(VDMParser.BRACKET_R, 0); }
		public TerminalNode SEP_amp() { return getToken(VDMParser.SEP_amp, 0); }
		public Sequence_comprehensionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_sequence_comprehension; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterSequence_comprehension(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitSequence_comprehension(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitSequence_comprehension(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Sequence_comprehensionContext sequence_comprehension() throws RecognitionException {
		Sequence_comprehensionContext _localctx = new Sequence_comprehensionContext(_ctx, getState());
		enterRule(_localctx, 332, RULE_sequence_comprehension);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1981);
			match(BRACKET_L);
			setState(1982);
			expression(0);
			setState(1983);
			match(SEP_bar);
			setState(1984);
			bind_list();
			setState(1987);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SEP_amp) {
				{
				setState(1985);
				match(SEP_amp);
				setState(1986);
				expression(0);
				}
			}

			setState(1989);
			match(BRACKET_R);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class SubsequenceContext extends ParserRuleContext {
		public List<ExpressionContext> expression() {
			return getRuleContexts(ExpressionContext.class);
		}
		public ExpressionContext expression(int i) {
			return getRuleContext(ExpressionContext.class,i);
		}
		public TerminalNode PAREN_L() { return getToken(VDMParser.PAREN_L, 0); }
		public List<TerminalNode> SEP_comma() { return getTokens(VDMParser.SEP_comma); }
		public TerminalNode SEP_comma(int i) {
			return getToken(VDMParser.SEP_comma, i);
		}
		public TerminalNode SEP_range() { return getToken(VDMParser.SEP_range, 0); }
		public TerminalNode PAREN_R() { return getToken(VDMParser.PAREN_R, 0); }
		public SubsequenceContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_subsequence; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterSubsequence(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitSubsequence(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitSubsequence(this);
			else return visitor.visitChildren(this);
		}
	}

	public final SubsequenceContext subsequence() throws RecognitionException {
		SubsequenceContext _localctx = new SubsequenceContext(_ctx, getState());
		enterRule(_localctx, 334, RULE_subsequence);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(1991);
			expression(0);
			setState(1992);
			match(PAREN_L);
			setState(1993);
			expression(0);
			setState(1994);
			match(SEP_comma);
			setState(1995);
			match(SEP_range);
			setState(1996);
			match(SEP_comma);
			setState(1997);
			expression(0);
			setState(1998);
			match(PAREN_R);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Map_enumerationContext extends ParserRuleContext {
		public TerminalNode BRACE_L() { return getToken(VDMParser.BRACE_L, 0); }
		public List<MapletContext> maplet() {
			return getRuleContexts(MapletContext.class);
		}
		public MapletContext maplet(int i) {
			return getRuleContext(MapletContext.class,i);
		}
		public TerminalNode BRACE_R() { return getToken(VDMParser.BRACE_R, 0); }
		public TerminalNode SEP_comma() { return getToken(VDMParser.SEP_comma, 0); }
		public TerminalNode SEP_maplet() { return getToken(VDMParser.SEP_maplet, 0); }
		public Map_enumerationContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_map_enumeration; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterMap_enumeration(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitMap_enumeration(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitMap_enumeration(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Map_enumerationContext map_enumeration() throws RecognitionException {
		Map_enumerationContext _localctx = new Map_enumerationContext(_ctx, getState());
		enterRule(_localctx, 336, RULE_map_enumeration);
		int _la;
		try {
			setState(2011);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,173,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(2000);
				match(BRACE_L);
				setState(2001);
				maplet();
				setState(2004);
				_errHandler.sync(this);
				_la = _input.LA(1);
				if (_la==SEP_comma) {
					{
					setState(2002);
					match(SEP_comma);
					setState(2003);
					maplet();
					}
				}

				setState(2006);
				match(BRACE_R);
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(2008);
				match(BRACE_L);
				setState(2009);
				match(SEP_maplet);
				setState(2010);
				match(BRACE_R);
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class MapletContext extends ParserRuleContext {
		public List<ExpressionContext> expression() {
			return getRuleContexts(ExpressionContext.class);
		}
		public ExpressionContext expression(int i) {
			return getRuleContext(ExpressionContext.class,i);
		}
		public TerminalNode SEP_maplet() { return getToken(VDMParser.SEP_maplet, 0); }
		public MapletContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_maplet; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterMaplet(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitMaplet(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitMaplet(this);
			else return visitor.visitChildren(this);
		}
	}

	public final MapletContext maplet() throws RecognitionException {
		MapletContext _localctx = new MapletContext(_ctx, getState());
		enterRule(_localctx, 338, RULE_maplet);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2013);
			expression(0);
			setState(2014);
			match(SEP_maplet);
			setState(2015);
			expression(0);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Map_comprehensionContext extends ParserRuleContext {
		public TerminalNode BRACE_L() { return getToken(VDMParser.BRACE_L, 0); }
		public MapletContext maplet() {
			return getRuleContext(MapletContext.class,0);
		}
		public TerminalNode SEP_bar() { return getToken(VDMParser.SEP_bar, 0); }
		public Bind_listContext bind_list() {
			return getRuleContext(Bind_listContext.class,0);
		}
		public TerminalNode BRACE_R() { return getToken(VDMParser.BRACE_R, 0); }
		public TerminalNode SEP_amp() { return getToken(VDMParser.SEP_amp, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public Map_comprehensionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_map_comprehension; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterMap_comprehension(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitMap_comprehension(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitMap_comprehension(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Map_comprehensionContext map_comprehension() throws RecognitionException {
		Map_comprehensionContext _localctx = new Map_comprehensionContext(_ctx, getState());
		enterRule(_localctx, 340, RULE_map_comprehension);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2017);
			match(BRACE_L);
			setState(2018);
			maplet();
			setState(2019);
			match(SEP_bar);
			setState(2020);
			bind_list();
			setState(2023);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SEP_amp) {
				{
				setState(2021);
				match(SEP_amp);
				setState(2022);
				expression(0);
				}
			}

			setState(2025);
			match(BRACE_R);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Tuple_constructorContext extends ParserRuleContext {
		public TerminalNode SLK_mk() { return getToken(VDMParser.SLK_mk, 0); }
		public TerminalNode PAREN_L() { return getToken(VDMParser.PAREN_L, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public TerminalNode SEP_comma() { return getToken(VDMParser.SEP_comma, 0); }
		public Expression_listContext expression_list() {
			return getRuleContext(Expression_listContext.class,0);
		}
		public TerminalNode PAREN_R() { return getToken(VDMParser.PAREN_R, 0); }
		public Tuple_constructorContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_tuple_constructor; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterTuple_constructor(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitTuple_constructor(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitTuple_constructor(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Tuple_constructorContext tuple_constructor() throws RecognitionException {
		Tuple_constructorContext _localctx = new Tuple_constructorContext(_ctx, getState());
		enterRule(_localctx, 342, RULE_tuple_constructor);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2027);
			match(SLK_mk);
			setState(2028);
			match(PAREN_L);
			setState(2029);
			expression(0);
			setState(2030);
			match(SEP_comma);
			setState(2031);
			expression_list();
			setState(2032);
			match(PAREN_R);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Record_constructorContext extends ParserRuleContext {
		public Tight_record_nameContext tight_record_name() {
			return getRuleContext(Tight_record_nameContext.class,0);
		}
		public TerminalNode PAREN_L() { return getToken(VDMParser.PAREN_L, 0); }
		public TerminalNode PAREN_R() { return getToken(VDMParser.PAREN_R, 0); }
		public Expression_listContext expression_list() {
			return getRuleContext(Expression_listContext.class,0);
		}
		public Record_constructorContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_record_constructor; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterRecord_constructor(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitRecord_constructor(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitRecord_constructor(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Record_constructorContext record_constructor() throws RecognitionException {
		Record_constructorContext _localctx = new Record_constructorContext(_ctx, getState());
		enterRule(_localctx, 344, RULE_record_constructor);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2034);
			tight_record_name();
			setState(2035);
			match(PAREN_L);
			setState(2037);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,175,_ctx) ) {
			case 1:
				{
				setState(2036);
				expression_list();
				}
				break;
			}
			setState(2039);
			match(PAREN_R);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Tight_record_nameContext extends ParserRuleContext {
		public Token first;
		public Token second;
		public TerminalNode SLK_mk() { return getToken(VDMParser.SLK_mk, 0); }
		public List<TerminalNode> IDENTIFIER() { return getTokens(VDMParser.IDENTIFIER); }
		public TerminalNode IDENTIFIER(int i) {
			return getToken(VDMParser.IDENTIFIER, i);
		}
		public TerminalNode SEP_tick() { return getToken(VDMParser.SEP_tick, 0); }
		public Tight_record_nameContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_tight_record_name; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterTight_record_name(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitTight_record_name(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitTight_record_name(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Tight_record_nameContext tight_record_name() throws RecognitionException {
		Tight_record_nameContext _localctx = new Tight_record_nameContext(_ctx, getState());
		enterRule(_localctx, 346, RULE_tight_record_name);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2041);
			((Tight_record_nameContext)_localctx).first = match(SLK_mk);
			setState(2042);
			((Tight_record_nameContext)_localctx).second = match(IDENTIFIER);
			setState(2045);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,176,_ctx) ) {
			case 1:
				{
				setState(2043);
				match(SEP_tick);
				setState(2044);
				match(IDENTIFIER);
				}
				break;
			}
			setState(2047);
			if (!((((Tight_record_nameContext)_localctx).first!=null?((Tight_record_nameContext)_localctx).first.getTokenIndex():0)+1 == (((Tight_record_nameContext)_localctx).second!=null?((Tight_record_nameContext)_localctx).second.getTokenIndex():0))) throw new FailedPredicateException(this, "$first.index+1 == $second.index");
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Record_modifierContext extends ParserRuleContext {
		public TerminalNode SLK_mu() { return getToken(VDMParser.SLK_mu, 0); }
		public TerminalNode PAREN_L() { return getToken(VDMParser.PAREN_L, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public List<TerminalNode> SEP_comma() { return getTokens(VDMParser.SEP_comma); }
		public TerminalNode SEP_comma(int i) {
			return getToken(VDMParser.SEP_comma, i);
		}
		public List<Record_modificationContext> record_modification() {
			return getRuleContexts(Record_modificationContext.class);
		}
		public Record_modificationContext record_modification(int i) {
			return getRuleContext(Record_modificationContext.class,i);
		}
		public TerminalNode PAREN_R() { return getToken(VDMParser.PAREN_R, 0); }
		public Record_modifierContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_record_modifier; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterRecord_modifier(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitRecord_modifier(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitRecord_modifier(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Record_modifierContext record_modifier() throws RecognitionException {
		Record_modifierContext _localctx = new Record_modifierContext(_ctx, getState());
		enterRule(_localctx, 348, RULE_record_modifier);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2049);
			match(SLK_mu);
			setState(2050);
			match(PAREN_L);
			setState(2051);
			expression(0);
			setState(2052);
			match(SEP_comma);
			setState(2053);
			record_modification();
			setState(2058);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==SEP_comma) {
				{
				{
				setState(2054);
				match(SEP_comma);
				setState(2055);
				record_modification();
				}
				}
				setState(2060);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(2061);
			match(PAREN_R);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Record_modificationContext extends ParserRuleContext {
		public TerminalNode IDENTIFIER() { return getToken(VDMParser.IDENTIFIER, 0); }
		public TerminalNode SEP_maplet() { return getToken(VDMParser.SEP_maplet, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public Record_modificationContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_record_modification; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterRecord_modification(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitRecord_modification(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitRecord_modification(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Record_modificationContext record_modification() throws RecognitionException {
		Record_modificationContext _localctx = new Record_modificationContext(_ctx, getState());
		enterRule(_localctx, 350, RULE_record_modification);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2063);
			match(IDENTIFIER);
			setState(2064);
			match(SEP_maplet);
			setState(2065);
			expression(0);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ApplyContext extends ParserRuleContext {
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public TerminalNode PAREN_L() { return getToken(VDMParser.PAREN_L, 0); }
		public TerminalNode PAREN_R() { return getToken(VDMParser.PAREN_R, 0); }
		public Expression_listContext expression_list() {
			return getRuleContext(Expression_listContext.class,0);
		}
		public ApplyContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_apply; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterApply(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitApply(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitApply(this);
			else return visitor.visitChildren(this);
		}
	}

	public final ApplyContext apply() throws RecognitionException {
		ApplyContext _localctx = new ApplyContext(_ctx, getState());
		enterRule(_localctx, 352, RULE_apply);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2067);
			expression(0);
			setState(2068);
			match(PAREN_L);
			setState(2070);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,178,_ctx) ) {
			case 1:
				{
				setState(2069);
				expression_list();
				}
				break;
			}
			setState(2072);
			match(PAREN_R);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Field_selectContext extends ParserRuleContext {
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public TerminalNode SEP_dot() { return getToken(VDMParser.SEP_dot, 0); }
		public TerminalNode IDENTIFIER() { return getToken(VDMParser.IDENTIFIER, 0); }
		public Field_selectContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_field_select; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterField_select(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitField_select(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitField_select(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Field_selectContext field_select() throws RecognitionException {
		Field_selectContext _localctx = new Field_selectContext(_ctx, getState());
		enterRule(_localctx, 354, RULE_field_select);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2074);
			expression(0);
			setState(2075);
			match(SEP_dot);
			setState(2076);
			match(IDENTIFIER);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Tuple_selectContext extends ParserRuleContext {
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public TerminalNode SEP_tsel() { return getToken(VDMParser.SEP_tsel, 0); }
		public TerminalNode NUMERAL() { return getToken(VDMParser.NUMERAL, 0); }
		public Tuple_selectContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_tuple_select; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterTuple_select(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitTuple_select(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitTuple_select(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Tuple_selectContext tuple_select() throws RecognitionException {
		Tuple_selectContext _localctx = new Tuple_selectContext(_ctx, getState());
		enterRule(_localctx, 356, RULE_tuple_select);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2078);
			expression(0);
			setState(2079);
			match(SEP_tsel);
			setState(2080);
			match(NUMERAL);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Function_type_instantiationContext extends ParserRuleContext {
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public TerminalNode BRACE_L() { return getToken(VDMParser.BRACE_L, 0); }
		public List<TypeContext> type() {
			return getRuleContexts(TypeContext.class);
		}
		public TypeContext type(int i) {
			return getRuleContext(TypeContext.class,i);
		}
		public TerminalNode BRACE_R() { return getToken(VDMParser.BRACE_R, 0); }
		public List<TerminalNode> SEP_comma() { return getTokens(VDMParser.SEP_comma); }
		public TerminalNode SEP_comma(int i) {
			return getToken(VDMParser.SEP_comma, i);
		}
		public Function_type_instantiationContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_function_type_instantiation; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterFunction_type_instantiation(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitFunction_type_instantiation(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitFunction_type_instantiation(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Function_type_instantiationContext function_type_instantiation() throws RecognitionException {
		Function_type_instantiationContext _localctx = new Function_type_instantiationContext(_ctx, getState());
		enterRule(_localctx, 358, RULE_function_type_instantiation);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2082);
			expression(0);
			setState(2083);
			match(BRACE_L);
			setState(2084);
			type(0);
			setState(2089);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==SEP_comma) {
				{
				{
				setState(2085);
				match(SEP_comma);
				setState(2086);
				type(0);
				}
				}
				setState(2091);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(2092);
			match(BRACE_R);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Lambda_expressionContext extends ParserRuleContext {
		public TerminalNode SLK_lambda() { return getToken(VDMParser.SLK_lambda, 0); }
		public Type_bind_listContext type_bind_list() {
			return getRuleContext(Type_bind_listContext.class,0);
		}
		public TerminalNode SEP_amp() { return getToken(VDMParser.SEP_amp, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public Lambda_expressionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_lambda_expression; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterLambda_expression(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitLambda_expression(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitLambda_expression(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Lambda_expressionContext lambda_expression() throws RecognitionException {
		Lambda_expressionContext _localctx = new Lambda_expressionContext(_ctx, getState());
		enterRule(_localctx, 360, RULE_lambda_expression);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2094);
			match(SLK_lambda);
			setState(2095);
			type_bind_list();
			setState(2096);
			match(SEP_amp);
			setState(2097);
			expression(0);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Narrow_expressionContext extends ParserRuleContext {
		public TerminalNode SLK_narrow() { return getToken(VDMParser.SLK_narrow, 0); }
		public TerminalNode PAREN_L() { return getToken(VDMParser.PAREN_L, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public TerminalNode SEP_comma() { return getToken(VDMParser.SEP_comma, 0); }
		public TypeContext type() {
			return getRuleContext(TypeContext.class,0);
		}
		public TerminalNode PAREN_R() { return getToken(VDMParser.PAREN_R, 0); }
		public Narrow_expressionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_narrow_expression; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterNarrow_expression(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitNarrow_expression(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitNarrow_expression(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Narrow_expressionContext narrow_expression() throws RecognitionException {
		Narrow_expressionContext _localctx = new Narrow_expressionContext(_ctx, getState());
		enterRule(_localctx, 362, RULE_narrow_expression);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2099);
			match(SLK_narrow);
			setState(2100);
			match(PAREN_L);
			setState(2101);
			expression(0);
			setState(2102);
			match(SEP_comma);
			setState(2103);
			type(0);
			setState(2104);
			match(PAREN_R);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class New_expressionContext extends ParserRuleContext {
		public TerminalNode PPK_new() { return getToken(VDMParser.PPK_new, 0); }
		public NameContext name() {
			return getRuleContext(NameContext.class,0);
		}
		public TerminalNode PAREN_L() { return getToken(VDMParser.PAREN_L, 0); }
		public TerminalNode PAREN_R() { return getToken(VDMParser.PAREN_R, 0); }
		public Expression_listContext expression_list() {
			return getRuleContext(Expression_listContext.class,0);
		}
		public New_expressionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_new_expression; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterNew_expression(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitNew_expression(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitNew_expression(this);
			else return visitor.visitChildren(this);
		}
	}

	public final New_expressionContext new_expression() throws RecognitionException {
		New_expressionContext _localctx = new New_expressionContext(_ctx, getState());
		enterRule(_localctx, 364, RULE_new_expression);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2106);
			match(PPK_new);
			setState(2107);
			name();
			setState(2108);
			match(PAREN_L);
			setState(2110);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,180,_ctx) ) {
			case 1:
				{
				setState(2109);
				expression_list();
				}
				break;
			}
			setState(2112);
			match(PAREN_R);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Self_expressionContext extends ParserRuleContext {
		public TerminalNode PPK_self() { return getToken(VDMParser.PPK_self, 0); }
		public Self_expressionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_self_expression; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterSelf_expression(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitSelf_expression(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitSelf_expression(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Self_expressionContext self_expression() throws RecognitionException {
		Self_expressionContext _localctx = new Self_expressionContext(_ctx, getState());
		enterRule(_localctx, 366, RULE_self_expression);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2114);
			match(PPK_self);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Threadid_expressionContext extends ParserRuleContext {
		public TerminalNode RTK_threadid() { return getToken(VDMParser.RTK_threadid, 0); }
		public Threadid_expressionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_threadid_expression; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterThreadid_expression(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitThreadid_expression(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitThreadid_expression(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Threadid_expressionContext threadid_expression() throws RecognitionException {
		Threadid_expressionContext _localctx = new Threadid_expressionContext(_ctx, getState());
		enterRule(_localctx, 368, RULE_threadid_expression);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2116);
			match(RTK_threadid);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class General_is_expressionContext extends ParserRuleContext {
		public Is_expressionContext is_expression() {
			return getRuleContext(Is_expressionContext.class,0);
		}
		public Type_judgementContext type_judgement() {
			return getRuleContext(Type_judgementContext.class,0);
		}
		public General_is_expressionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_general_is_expression; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterGeneral_is_expression(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitGeneral_is_expression(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitGeneral_is_expression(this);
			else return visitor.visitChildren(this);
		}
	}

	public final General_is_expressionContext general_is_expression() throws RecognitionException {
		General_is_expressionContext _localctx = new General_is_expressionContext(_ctx, getState());
		enterRule(_localctx, 370, RULE_general_is_expression);
		try {
			setState(2120);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,181,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(2118);
				is_expression();
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(2119);
				type_judgement();
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Is_expressionContext extends ParserRuleContext {
		public TerminalNode SLK_istest() { return getToken(VDMParser.SLK_istest, 0); }
		public TerminalNode PAREN_L() { return getToken(VDMParser.PAREN_L, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public TerminalNode PAREN_R() { return getToken(VDMParser.PAREN_R, 0); }
		public NameContext name() {
			return getRuleContext(NameContext.class,0);
		}
		public Basic_typeContext basic_type() {
			return getRuleContext(Basic_typeContext.class,0);
		}
		public Is_expressionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_is_expression; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterIs_expression(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitIs_expression(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitIs_expression(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Is_expressionContext is_expression() throws RecognitionException {
		Is_expressionContext _localctx = new Is_expressionContext(_ctx, getState());
		enterRule(_localctx, 372, RULE_is_expression);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2122);
			match(SLK_istest);
			setState(2125);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case IDENTIFIER:
				{
				setState(2123);
				name();
				}
				break;
			case SLK_bool:
			case SLK_char:
			case SLK_int:
			case SLK_nat:
			case SLK_nat1:
			case SLK_rat:
			case SLK_real:
			case SLK_token:
				{
				setState(2124);
				basic_type();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
			setState(2127);
			match(PAREN_L);
			setState(2128);
			expression(0);
			setState(2129);
			match(PAREN_R);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Type_judgementContext extends ParserRuleContext {
		public TerminalNode SLK_istest() { return getToken(VDMParser.SLK_istest, 0); }
		public TerminalNode PAREN_L() { return getToken(VDMParser.PAREN_L, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public TerminalNode SEP_comma() { return getToken(VDMParser.SEP_comma, 0); }
		public TypeContext type() {
			return getRuleContext(TypeContext.class,0);
		}
		public TerminalNode PAREN_R() { return getToken(VDMParser.PAREN_R, 0); }
		public Type_judgementContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_type_judgement; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterType_judgement(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitType_judgement(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitType_judgement(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Type_judgementContext type_judgement() throws RecognitionException {
		Type_judgementContext _localctx = new Type_judgementContext(_ctx, getState());
		enterRule(_localctx, 374, RULE_type_judgement);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2131);
			match(SLK_istest);
			setState(2132);
			match(PAREN_L);
			setState(2133);
			expression(0);
			setState(2134);
			match(SEP_comma);
			setState(2135);
			type(0);
			setState(2136);
			match(PAREN_R);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Undefined_expressionContext extends ParserRuleContext {
		public TerminalNode SLK_undefined() { return getToken(VDMParser.SLK_undefined, 0); }
		public Undefined_expressionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_undefined_expression; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterUndefined_expression(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitUndefined_expression(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitUndefined_expression(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Undefined_expressionContext undefined_expression() throws RecognitionException {
		Undefined_expressionContext _localctx = new Undefined_expressionContext(_ctx, getState());
		enterRule(_localctx, 376, RULE_undefined_expression);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2138);
			match(SLK_undefined);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Precondition_expressionContext extends ParserRuleContext {
		public TerminalNode SLK_pre() { return getToken(VDMParser.SLK_pre, 0); }
		public TerminalNode SEP_underscore() { return getToken(VDMParser.SEP_underscore, 0); }
		public TerminalNode PAREN_L() { return getToken(VDMParser.PAREN_L, 0); }
		public Expression_listContext expression_list() {
			return getRuleContext(Expression_listContext.class,0);
		}
		public TerminalNode PAREN_R() { return getToken(VDMParser.PAREN_R, 0); }
		public Precondition_expressionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_precondition_expression; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterPrecondition_expression(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitPrecondition_expression(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitPrecondition_expression(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Precondition_expressionContext precondition_expression() throws RecognitionException {
		Precondition_expressionContext _localctx = new Precondition_expressionContext(_ctx, getState());
		enterRule(_localctx, 378, RULE_precondition_expression);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2140);
			match(SLK_pre);
			setState(2141);
			match(SEP_underscore);
			setState(2142);
			match(PAREN_L);
			setState(2143);
			expression_list();
			setState(2144);
			match(PAREN_R);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Isofbaseclass_expressionContext extends ParserRuleContext {
		public TerminalNode PPK_ibc() { return getToken(VDMParser.PPK_ibc, 0); }
		public TerminalNode SEP_underscore() { return getToken(VDMParser.SEP_underscore, 0); }
		public TerminalNode PAREN_L() { return getToken(VDMParser.PAREN_L, 0); }
		public NameContext name() {
			return getRuleContext(NameContext.class,0);
		}
		public TerminalNode SEP_comma() { return getToken(VDMParser.SEP_comma, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public TerminalNode PAREN_R() { return getToken(VDMParser.PAREN_R, 0); }
		public Isofbaseclass_expressionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_isofbaseclass_expression; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterIsofbaseclass_expression(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitIsofbaseclass_expression(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitIsofbaseclass_expression(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Isofbaseclass_expressionContext isofbaseclass_expression() throws RecognitionException {
		Isofbaseclass_expressionContext _localctx = new Isofbaseclass_expressionContext(_ctx, getState());
		enterRule(_localctx, 380, RULE_isofbaseclass_expression);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2146);
			match(PPK_ibc);
			setState(2147);
			match(SEP_underscore);
			setState(2148);
			match(PAREN_L);
			setState(2149);
			name();
			setState(2150);
			match(SEP_comma);
			setState(2151);
			expression(0);
			setState(2152);
			match(PAREN_R);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Isofclass_expressionContext extends ParserRuleContext {
		public TerminalNode PPK_ioc() { return getToken(VDMParser.PPK_ioc, 0); }
		public TerminalNode PAREN_L() { return getToken(VDMParser.PAREN_L, 0); }
		public NameContext name() {
			return getRuleContext(NameContext.class,0);
		}
		public TerminalNode SEP_comma() { return getToken(VDMParser.SEP_comma, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public TerminalNode PAREN_R() { return getToken(VDMParser.PAREN_R, 0); }
		public Isofclass_expressionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_isofclass_expression; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterIsofclass_expression(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitIsofclass_expression(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitIsofclass_expression(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Isofclass_expressionContext isofclass_expression() throws RecognitionException {
		Isofclass_expressionContext _localctx = new Isofclass_expressionContext(_ctx, getState());
		enterRule(_localctx, 382, RULE_isofclass_expression);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2154);
			match(PPK_ioc);
			setState(2155);
			match(PAREN_L);
			setState(2156);
			name();
			setState(2157);
			match(SEP_comma);
			setState(2158);
			expression(0);
			setState(2159);
			match(PAREN_R);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Samebaseclass_expressionContext extends ParserRuleContext {
		public TerminalNode PPK_sbc() { return getToken(VDMParser.PPK_sbc, 0); }
		public TerminalNode PAREN_L() { return getToken(VDMParser.PAREN_L, 0); }
		public NameContext name() {
			return getRuleContext(NameContext.class,0);
		}
		public TerminalNode SEP_comma() { return getToken(VDMParser.SEP_comma, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public TerminalNode PAREN_R() { return getToken(VDMParser.PAREN_R, 0); }
		public Samebaseclass_expressionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_samebaseclass_expression; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterSamebaseclass_expression(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitSamebaseclass_expression(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitSamebaseclass_expression(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Samebaseclass_expressionContext samebaseclass_expression() throws RecognitionException {
		Samebaseclass_expressionContext _localctx = new Samebaseclass_expressionContext(_ctx, getState());
		enterRule(_localctx, 384, RULE_samebaseclass_expression);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2161);
			match(PPK_sbc);
			setState(2162);
			match(PAREN_L);
			setState(2163);
			name();
			setState(2164);
			match(SEP_comma);
			setState(2165);
			expression(0);
			setState(2166);
			match(PAREN_R);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Sameclass_expressionContext extends ParserRuleContext {
		public TerminalNode PPK_sc() { return getToken(VDMParser.PPK_sc, 0); }
		public TerminalNode PAREN_L() { return getToken(VDMParser.PAREN_L, 0); }
		public NameContext name() {
			return getRuleContext(NameContext.class,0);
		}
		public TerminalNode SEP_comma() { return getToken(VDMParser.SEP_comma, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public TerminalNode PAREN_R() { return getToken(VDMParser.PAREN_R, 0); }
		public Sameclass_expressionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_sameclass_expression; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterSameclass_expression(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitSameclass_expression(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitSameclass_expression(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Sameclass_expressionContext sameclass_expression() throws RecognitionException {
		Sameclass_expressionContext _localctx = new Sameclass_expressionContext(_ctx, getState());
		enterRule(_localctx, 386, RULE_sameclass_expression);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2168);
			match(PPK_sc);
			setState(2169);
			match(PAREN_L);
			setState(2170);
			name();
			setState(2171);
			match(SEP_comma);
			setState(2172);
			expression(0);
			setState(2173);
			match(PAREN_R);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Act_expressionContext extends ParserRuleContext {
		public TerminalNode RTK_act() { return getToken(VDMParser.RTK_act, 0); }
		public TerminalNode PAREN_L() { return getToken(VDMParser.PAREN_L, 0); }
		public Name_listContext name_list() {
			return getRuleContext(Name_listContext.class,0);
		}
		public TerminalNode PAREN_R() { return getToken(VDMParser.PAREN_R, 0); }
		public Act_expressionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_act_expression; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterAct_expression(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitAct_expression(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitAct_expression(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Act_expressionContext act_expression() throws RecognitionException {
		Act_expressionContext _localctx = new Act_expressionContext(_ctx, getState());
		enterRule(_localctx, 388, RULE_act_expression);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2175);
			match(RTK_act);
			setState(2176);
			match(PAREN_L);
			setState(2177);
			name_list();
			setState(2178);
			match(PAREN_R);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Fin_expressionContext extends ParserRuleContext {
		public TerminalNode RTK_fin() { return getToken(VDMParser.RTK_fin, 0); }
		public TerminalNode PAREN_L() { return getToken(VDMParser.PAREN_L, 0); }
		public Name_listContext name_list() {
			return getRuleContext(Name_listContext.class,0);
		}
		public TerminalNode PAREN_R() { return getToken(VDMParser.PAREN_R, 0); }
		public Fin_expressionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_fin_expression; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterFin_expression(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitFin_expression(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitFin_expression(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Fin_expressionContext fin_expression() throws RecognitionException {
		Fin_expressionContext _localctx = new Fin_expressionContext(_ctx, getState());
		enterRule(_localctx, 390, RULE_fin_expression);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2180);
			match(RTK_fin);
			setState(2181);
			match(PAREN_L);
			setState(2182);
			name_list();
			setState(2183);
			match(PAREN_R);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Active_expressionContext extends ParserRuleContext {
		public TerminalNode RTK_active() { return getToken(VDMParser.RTK_active, 0); }
		public TerminalNode PAREN_L() { return getToken(VDMParser.PAREN_L, 0); }
		public Name_listContext name_list() {
			return getRuleContext(Name_listContext.class,0);
		}
		public TerminalNode PAREN_R() { return getToken(VDMParser.PAREN_R, 0); }
		public Active_expressionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_active_expression; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterActive_expression(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitActive_expression(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitActive_expression(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Active_expressionContext active_expression() throws RecognitionException {
		Active_expressionContext _localctx = new Active_expressionContext(_ctx, getState());
		enterRule(_localctx, 392, RULE_active_expression);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2185);
			match(RTK_active);
			setState(2186);
			match(PAREN_L);
			setState(2187);
			name_list();
			setState(2188);
			match(PAREN_R);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Req_expressionContext extends ParserRuleContext {
		public TerminalNode RTK_req() { return getToken(VDMParser.RTK_req, 0); }
		public TerminalNode PAREN_L() { return getToken(VDMParser.PAREN_L, 0); }
		public Name_listContext name_list() {
			return getRuleContext(Name_listContext.class,0);
		}
		public TerminalNode PAREN_R() { return getToken(VDMParser.PAREN_R, 0); }
		public Req_expressionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_req_expression; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterReq_expression(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitReq_expression(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitReq_expression(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Req_expressionContext req_expression() throws RecognitionException {
		Req_expressionContext _localctx = new Req_expressionContext(_ctx, getState());
		enterRule(_localctx, 394, RULE_req_expression);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2190);
			match(RTK_req);
			setState(2191);
			match(PAREN_L);
			setState(2192);
			name_list();
			setState(2193);
			match(PAREN_R);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Waiting_expressionContext extends ParserRuleContext {
		public TerminalNode RTK_waiting() { return getToken(VDMParser.RTK_waiting, 0); }
		public TerminalNode PAREN_L() { return getToken(VDMParser.PAREN_L, 0); }
		public Name_listContext name_list() {
			return getRuleContext(Name_listContext.class,0);
		}
		public TerminalNode PAREN_R() { return getToken(VDMParser.PAREN_R, 0); }
		public Waiting_expressionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_waiting_expression; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterWaiting_expression(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitWaiting_expression(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitWaiting_expression(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Waiting_expressionContext waiting_expression() throws RecognitionException {
		Waiting_expressionContext _localctx = new Waiting_expressionContext(_ctx, getState());
		enterRule(_localctx, 396, RULE_waiting_expression);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2195);
			match(RTK_waiting);
			setState(2196);
			match(PAREN_L);
			setState(2197);
			name_list();
			setState(2198);
			match(PAREN_R);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Time_expressionContext extends ParserRuleContext {
		public TerminalNode RTK_time() { return getToken(VDMParser.RTK_time, 0); }
		public Time_expressionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_time_expression; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterTime_expression(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitTime_expression(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitTime_expression(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Time_expressionContext time_expression() throws RecognitionException {
		Time_expressionContext _localctx = new Time_expressionContext(_ctx, getState());
		enterRule(_localctx, 398, RULE_time_expression);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2200);
			match(RTK_time);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Name_listContext extends ParserRuleContext {
		public List<NameContext> name() {
			return getRuleContexts(NameContext.class);
		}
		public NameContext name(int i) {
			return getRuleContext(NameContext.class,i);
		}
		public List<TerminalNode> SEP_comma() { return getTokens(VDMParser.SEP_comma); }
		public TerminalNode SEP_comma(int i) {
			return getToken(VDMParser.SEP_comma, i);
		}
		public Name_listContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_name_list; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterName_list(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitName_list(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitName_list(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Name_listContext name_list() throws RecognitionException {
		Name_listContext _localctx = new Name_listContext(_ctx, getState());
		enterRule(_localctx, 400, RULE_name_list);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2202);
			name();
			setState(2207);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==SEP_comma) {
				{
				{
				setState(2203);
				match(SEP_comma);
				setState(2204);
				name();
				}
				}
				setState(2209);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class NameContext extends ParserRuleContext {
		public List<TerminalNode> IDENTIFIER() { return getTokens(VDMParser.IDENTIFIER); }
		public TerminalNode IDENTIFIER(int i) {
			return getToken(VDMParser.IDENTIFIER, i);
		}
		public TerminalNode SEP_tick() { return getToken(VDMParser.SEP_tick, 0); }
		public NameContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_name; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterName(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitName(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitName(this);
			else return visitor.visitChildren(this);
		}
	}

	public final NameContext name() throws RecognitionException {
		NameContext _localctx = new NameContext(_ctx, getState());
		enterRule(_localctx, 402, RULE_name);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2210);
			match(IDENTIFIER);
			setState(2213);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,184,_ctx) ) {
			case 1:
				{
				setState(2211);
				match(SEP_tick);
				setState(2212);
				match(IDENTIFIER);
				}
				break;
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Old_nameContext extends ParserRuleContext {
		public TerminalNode IDENTIFIER() { return getToken(VDMParser.IDENTIFIER, 0); }
		public TerminalNode SEP_old() { return getToken(VDMParser.SEP_old, 0); }
		public Old_nameContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_old_name; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterOld_name(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitOld_name(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitOld_name(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Old_nameContext old_name() throws RecognitionException {
		Old_nameContext _localctx = new Old_nameContext(_ctx, getState());
		enterRule(_localctx, 404, RULE_old_name);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2215);
			match(IDENTIFIER);
			setState(2216);
			match(SEP_old);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Symbolic_literalContext extends ParserRuleContext {
		public TerminalNode NUMERIC_LITERAL() { return getToken(VDMParser.NUMERIC_LITERAL, 0); }
		public TerminalNode SLK_true() { return getToken(VDMParser.SLK_true, 0); }
		public TerminalNode SLK_false() { return getToken(VDMParser.SLK_false, 0); }
		public TerminalNode SLK_nil() { return getToken(VDMParser.SLK_nil, 0); }
		public TerminalNode CHARACTER_LITERAL() { return getToken(VDMParser.CHARACTER_LITERAL, 0); }
		public TerminalNode TEXT_LITERAL() { return getToken(VDMParser.TEXT_LITERAL, 0); }
		public TerminalNode QUOTE_LITERAL() { return getToken(VDMParser.QUOTE_LITERAL, 0); }
		public Symbolic_literalContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_symbolic_literal; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterSymbolic_literal(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitSymbolic_literal(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitSymbolic_literal(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Symbolic_literalContext symbolic_literal() throws RecognitionException {
		Symbolic_literalContext _localctx = new Symbolic_literalContext(_ctx, getState());
		enterRule(_localctx, 406, RULE_symbolic_literal);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2218);
			_la = _input.LA(1);
			if ( !(((((_la - 45)) & ~0x3f) == 0 && ((1L << (_la - 45)) & ((1L << (SLK_false - 45)) | (1L << (SLK_nil - 45)) | (1L << (SLK_true - 45)))) != 0) || ((((_la - 202)) & ~0x3f) == 0 && ((1L << (_la - 202)) & ((1L << (QUOTE_LITERAL - 202)) | (1L << (NUMERIC_LITERAL - 202)) | (1L << (CHARACTER_LITERAL - 202)) | (1L << (TEXT_LITERAL - 202)))) != 0)) ) {
			_errHandler.recoverInline(this);
			}
			else {
				if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
				_errHandler.reportMatch(this);
				consume();
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class State_designatorContext extends ParserRuleContext {
		public State_designatorContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_state_designator; }
	 
		public State_designatorContext() { }
		public void copyFrom(State_designatorContext ctx) {
			super.copyFrom(ctx);
		}
	}
	public static class NameDesignatorContext extends State_designatorContext {
		public NameContext name() {
			return getRuleContext(NameContext.class,0);
		}
		public NameDesignatorContext(State_designatorContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterNameDesignator(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitNameDesignator(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitNameDesignator(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class MapSeqDesignatorContext extends State_designatorContext {
		public State_designatorContext state_designator() {
			return getRuleContext(State_designatorContext.class,0);
		}
		public TerminalNode PAREN_L() { return getToken(VDMParser.PAREN_L, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public TerminalNode PAREN_R() { return getToken(VDMParser.PAREN_R, 0); }
		public MapSeqDesignatorContext(State_designatorContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterMapSeqDesignator(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitMapSeqDesignator(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitMapSeqDesignator(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class FieldReferenceDesignatorContext extends State_designatorContext {
		public State_designatorContext state_designator() {
			return getRuleContext(State_designatorContext.class,0);
		}
		public TerminalNode SEP_dot() { return getToken(VDMParser.SEP_dot, 0); }
		public TerminalNode IDENTIFIER() { return getToken(VDMParser.IDENTIFIER, 0); }
		public FieldReferenceDesignatorContext(State_designatorContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterFieldReferenceDesignator(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitFieldReferenceDesignator(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitFieldReferenceDesignator(this);
			else return visitor.visitChildren(this);
		}
	}

	public final State_designatorContext state_designator() throws RecognitionException {
		return state_designator(0);
	}

	private State_designatorContext state_designator(int _p) throws RecognitionException {
		ParserRuleContext _parentctx = _ctx;
		int _parentState = getState();
		State_designatorContext _localctx = new State_designatorContext(_ctx, _parentState);
		State_designatorContext _prevctx = _localctx;
		int _startState = 408;
		enterRecursionRule(_localctx, 408, RULE_state_designator, _p);
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			{
			_localctx = new NameDesignatorContext(_localctx);
			_ctx = _localctx;
			_prevctx = _localctx;

			setState(2221);
			name();
			}
			_ctx.stop = _input.LT(-1);
			setState(2233);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,186,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					if ( _parseListeners!=null ) triggerExitRuleEvent();
					_prevctx = _localctx;
					{
					setState(2231);
					_errHandler.sync(this);
					switch ( getInterpreter().adaptivePredict(_input,185,_ctx) ) {
					case 1:
						{
						_localctx = new FieldReferenceDesignatorContext(new State_designatorContext(_parentctx, _parentState));
						pushNewRecursionContext(_localctx, _startState, RULE_state_designator);
						setState(2223);
						if (!(precpred(_ctx, 3))) throw new FailedPredicateException(this, "precpred(_ctx, 3)");
						setState(2224);
						match(SEP_dot);
						setState(2225);
						match(IDENTIFIER);
						}
						break;
					case 2:
						{
						_localctx = new MapSeqDesignatorContext(new State_designatorContext(_parentctx, _parentState));
						pushNewRecursionContext(_localctx, _startState, RULE_state_designator);
						setState(2226);
						if (!(precpred(_ctx, 2))) throw new FailedPredicateException(this, "precpred(_ctx, 2)");
						setState(2227);
						match(PAREN_L);
						setState(2228);
						expression(0);
						setState(2229);
						match(PAREN_R);
						}
						break;
					}
					} 
				}
				setState(2235);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,186,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			unrollRecursionContexts(_parentctx);
		}
		return _localctx;
	}

	public static class Field_referenceContext extends ParserRuleContext {
		public State_designatorContext state_designator() {
			return getRuleContext(State_designatorContext.class,0);
		}
		public TerminalNode SEP_dot() { return getToken(VDMParser.SEP_dot, 0); }
		public TerminalNode IDENTIFIER() { return getToken(VDMParser.IDENTIFIER, 0); }
		public Field_referenceContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_field_reference; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterField_reference(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitField_reference(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitField_reference(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Field_referenceContext field_reference() throws RecognitionException {
		Field_referenceContext _localctx = new Field_referenceContext(_ctx, getState());
		enterRule(_localctx, 410, RULE_field_reference);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2236);
			state_designator(0);
			setState(2237);
			match(SEP_dot);
			setState(2238);
			match(IDENTIFIER);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Map_seq_referenceContext extends ParserRuleContext {
		public State_designatorContext state_designator() {
			return getRuleContext(State_designatorContext.class,0);
		}
		public TerminalNode PAREN_L() { return getToken(VDMParser.PAREN_L, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public TerminalNode PAREN_R() { return getToken(VDMParser.PAREN_R, 0); }
		public Map_seq_referenceContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_map_seq_reference; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterMap_seq_reference(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitMap_seq_reference(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitMap_seq_reference(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Map_seq_referenceContext map_seq_reference() throws RecognitionException {
		Map_seq_referenceContext _localctx = new Map_seq_referenceContext(_ctx, getState());
		enterRule(_localctx, 412, RULE_map_seq_reference);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2240);
			state_designator(0);
			setState(2241);
			match(PAREN_L);
			setState(2242);
			expression(0);
			setState(2243);
			match(PAREN_R);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class StatementContext extends ParserRuleContext {
		public Let_statementContext let_statement() {
			return getRuleContext(Let_statementContext.class,0);
		}
		public Let_be_statementContext let_be_statement() {
			return getRuleContext(Let_be_statementContext.class,0);
		}
		public Def_statementContext def_statement() {
			return getRuleContext(Def_statementContext.class,0);
		}
		public Block_statementContext block_statement() {
			return getRuleContext(Block_statementContext.class,0);
		}
		public General_assignment_statementContext general_assignment_statement() {
			return getRuleContext(General_assignment_statementContext.class,0);
		}
		public If_statementContext if_statement() {
			return getRuleContext(If_statementContext.class,0);
		}
		public Cases_statementContext cases_statement() {
			return getRuleContext(Cases_statementContext.class,0);
		}
		public Sequence_for_loopContext sequence_for_loop() {
			return getRuleContext(Sequence_for_loopContext.class,0);
		}
		public Set_for_loopContext set_for_loop() {
			return getRuleContext(Set_for_loopContext.class,0);
		}
		public Index_for_loopContext index_for_loop() {
			return getRuleContext(Index_for_loopContext.class,0);
		}
		public While_loopContext while_loop() {
			return getRuleContext(While_loopContext.class,0);
		}
		public Nondeterministic_statementContext nondeterministic_statement() {
			return getRuleContext(Nondeterministic_statementContext.class,0);
		}
		public Call_statementContext call_statement() {
			return getRuleContext(Call_statementContext.class,0);
		}
		public Specification_statementContext specification_statement() {
			return getRuleContext(Specification_statementContext.class,0);
		}
		public Start_statementContext start_statement() {
			return getRuleContext(Start_statementContext.class,0);
		}
		public Start_list_statementContext start_list_statement() {
			return getRuleContext(Start_list_statementContext.class,0);
		}
		public Stop_statementContext stop_statement() {
			return getRuleContext(Stop_statementContext.class,0);
		}
		public Stop_list_statementContext stop_list_statement() {
			return getRuleContext(Stop_list_statementContext.class,0);
		}
		public Duration_statementContext duration_statement() {
			return getRuleContext(Duration_statementContext.class,0);
		}
		public Cycles_statementContext cycles_statement() {
			return getRuleContext(Cycles_statementContext.class,0);
		}
		public Return_statementContext return_statement() {
			return getRuleContext(Return_statementContext.class,0);
		}
		public Always_statementContext always_statement() {
			return getRuleContext(Always_statementContext.class,0);
		}
		public Trap_statementContext trap_statement() {
			return getRuleContext(Trap_statementContext.class,0);
		}
		public Recursive_trap_statementContext recursive_trap_statement() {
			return getRuleContext(Recursive_trap_statementContext.class,0);
		}
		public Exit_statementContext exit_statement() {
			return getRuleContext(Exit_statementContext.class,0);
		}
		public Error_statementContext error_statement() {
			return getRuleContext(Error_statementContext.class,0);
		}
		public Identity_statementContext identity_statement() {
			return getRuleContext(Identity_statementContext.class,0);
		}
		public StatementContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_statement; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterStatement(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitStatement(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitStatement(this);
			else return visitor.visitChildren(this);
		}
	}

	public final StatementContext statement() throws RecognitionException {
		StatementContext _localctx = new StatementContext(_ctx, getState());
		enterRule(_localctx, 414, RULE_statement);
		try {
			setState(2272);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,187,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(2245);
				let_statement();
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(2246);
				let_be_statement();
				}
				break;
			case 3:
				enterOuterAlt(_localctx, 3);
				{
				setState(2247);
				def_statement();
				}
				break;
			case 4:
				enterOuterAlt(_localctx, 4);
				{
				setState(2248);
				block_statement();
				}
				break;
			case 5:
				enterOuterAlt(_localctx, 5);
				{
				setState(2249);
				general_assignment_statement();
				}
				break;
			case 6:
				enterOuterAlt(_localctx, 6);
				{
				setState(2250);
				if_statement();
				}
				break;
			case 7:
				enterOuterAlt(_localctx, 7);
				{
				setState(2251);
				cases_statement();
				}
				break;
			case 8:
				enterOuterAlt(_localctx, 8);
				{
				setState(2252);
				sequence_for_loop();
				}
				break;
			case 9:
				enterOuterAlt(_localctx, 9);
				{
				setState(2253);
				set_for_loop();
				}
				break;
			case 10:
				enterOuterAlt(_localctx, 10);
				{
				setState(2254);
				index_for_loop();
				}
				break;
			case 11:
				enterOuterAlt(_localctx, 11);
				{
				setState(2255);
				while_loop();
				}
				break;
			case 12:
				enterOuterAlt(_localctx, 12);
				{
				setState(2256);
				nondeterministic_statement();
				}
				break;
			case 13:
				enterOuterAlt(_localctx, 13);
				{
				setState(2257);
				call_statement();
				}
				break;
			case 14:
				enterOuterAlt(_localctx, 14);
				{
				setState(2258);
				specification_statement();
				}
				break;
			case 15:
				enterOuterAlt(_localctx, 15);
				{
				setState(2259);
				start_statement();
				}
				break;
			case 16:
				enterOuterAlt(_localctx, 16);
				{
				setState(2260);
				start_list_statement();
				}
				break;
			case 17:
				enterOuterAlt(_localctx, 17);
				{
				setState(2261);
				stop_statement();
				}
				break;
			case 18:
				enterOuterAlt(_localctx, 18);
				{
				setState(2262);
				stop_list_statement();
				}
				break;
			case 19:
				enterOuterAlt(_localctx, 19);
				{
				setState(2263);
				duration_statement();
				}
				break;
			case 20:
				enterOuterAlt(_localctx, 20);
				{
				setState(2264);
				cycles_statement();
				}
				break;
			case 21:
				enterOuterAlt(_localctx, 21);
				{
				setState(2265);
				return_statement();
				}
				break;
			case 22:
				enterOuterAlt(_localctx, 22);
				{
				setState(2266);
				always_statement();
				}
				break;
			case 23:
				enterOuterAlt(_localctx, 23);
				{
				setState(2267);
				trap_statement();
				}
				break;
			case 24:
				enterOuterAlt(_localctx, 24);
				{
				setState(2268);
				recursive_trap_statement();
				}
				break;
			case 25:
				enterOuterAlt(_localctx, 25);
				{
				setState(2269);
				exit_statement();
				}
				break;
			case 26:
				enterOuterAlt(_localctx, 26);
				{
				setState(2270);
				error_statement();
				}
				break;
			case 27:
				enterOuterAlt(_localctx, 27);
				{
				setState(2271);
				identity_statement();
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Let_statementContext extends ParserRuleContext {
		public TerminalNode SLK_let() { return getToken(VDMParser.SLK_let, 0); }
		public Local_definition_listContext local_definition_list() {
			return getRuleContext(Local_definition_listContext.class,0);
		}
		public TerminalNode SLK_in() { return getToken(VDMParser.SLK_in, 0); }
		public StatementContext statement() {
			return getRuleContext(StatementContext.class,0);
		}
		public Let_statementContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_let_statement; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterLet_statement(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitLet_statement(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitLet_statement(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Let_statementContext let_statement() throws RecognitionException {
		Let_statementContext _localctx = new Let_statementContext(_ctx, getState());
		enterRule(_localctx, 416, RULE_let_statement);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2274);
			match(SLK_let);
			setState(2275);
			local_definition_list();
			setState(2276);
			match(SLK_in);
			setState(2277);
			statement();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Local_definition_listContext extends ParserRuleContext {
		public List<Local_definitionContext> local_definition() {
			return getRuleContexts(Local_definitionContext.class);
		}
		public Local_definitionContext local_definition(int i) {
			return getRuleContext(Local_definitionContext.class,i);
		}
		public List<TerminalNode> SEP_comma() { return getTokens(VDMParser.SEP_comma); }
		public TerminalNode SEP_comma(int i) {
			return getToken(VDMParser.SEP_comma, i);
		}
		public Local_definition_listContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_local_definition_list; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterLocal_definition_list(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitLocal_definition_list(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitLocal_definition_list(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Local_definition_listContext local_definition_list() throws RecognitionException {
		Local_definition_listContext _localctx = new Local_definition_listContext(_ctx, getState());
		enterRule(_localctx, 418, RULE_local_definition_list);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2279);
			local_definition();
			setState(2284);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==SEP_comma) {
				{
				{
				setState(2280);
				match(SEP_comma);
				setState(2281);
				local_definition();
				}
				}
				setState(2286);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Local_definitionContext extends ParserRuleContext {
		public Value_definitionContext value_definition() {
			return getRuleContext(Value_definitionContext.class,0);
		}
		public Function_definitionContext function_definition() {
			return getRuleContext(Function_definitionContext.class,0);
		}
		public Local_definitionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_local_definition; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterLocal_definition(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitLocal_definition(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitLocal_definition(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Local_definitionContext local_definition() throws RecognitionException {
		Local_definitionContext _localctx = new Local_definitionContext(_ctx, getState());
		enterRule(_localctx, 420, RULE_local_definition);
		try {
			setState(2289);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,189,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(2287);
				value_definition();
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(2288);
				function_definition();
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Let_be_statementContext extends ParserRuleContext {
		public TerminalNode SLK_let() { return getToken(VDMParser.SLK_let, 0); }
		public Multiple_bindContext multiple_bind() {
			return getRuleContext(Multiple_bindContext.class,0);
		}
		public TerminalNode SLK_in() { return getToken(VDMParser.SLK_in, 0); }
		public StatementContext statement() {
			return getRuleContext(StatementContext.class,0);
		}
		public TerminalNode SLK_best() { return getToken(VDMParser.SLK_best, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public Let_be_statementContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_let_be_statement; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterLet_be_statement(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitLet_be_statement(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitLet_be_statement(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Let_be_statementContext let_be_statement() throws RecognitionException {
		Let_be_statementContext _localctx = new Let_be_statementContext(_ctx, getState());
		enterRule(_localctx, 422, RULE_let_be_statement);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2291);
			match(SLK_let);
			setState(2292);
			multiple_bind();
			setState(2295);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SLK_best) {
				{
				setState(2293);
				match(SLK_best);
				setState(2294);
				expression(0);
				}
			}

			setState(2297);
			match(SLK_in);
			setState(2298);
			statement();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Def_statementContext extends ParserRuleContext {
		public TerminalNode SLK_def() { return getToken(VDMParser.SLK_def, 0); }
		public Equals_definition_listContext equals_definition_list() {
			return getRuleContext(Equals_definition_listContext.class,0);
		}
		public TerminalNode SLK_in() { return getToken(VDMParser.SLK_in, 0); }
		public StatementContext statement() {
			return getRuleContext(StatementContext.class,0);
		}
		public TerminalNode SEP_scolon() { return getToken(VDMParser.SEP_scolon, 0); }
		public Def_statementContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_def_statement; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterDef_statement(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitDef_statement(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitDef_statement(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Def_statementContext def_statement() throws RecognitionException {
		Def_statementContext _localctx = new Def_statementContext(_ctx, getState());
		enterRule(_localctx, 424, RULE_def_statement);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2300);
			match(SLK_def);
			setState(2301);
			equals_definition_list();
			setState(2303);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SEP_scolon) {
				{
				setState(2302);
				match(SEP_scolon);
				}
			}

			setState(2305);
			match(SLK_in);
			setState(2306);
			statement();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Equals_definition_listContext extends ParserRuleContext {
		public List<Equals_definitionContext> equals_definition() {
			return getRuleContexts(Equals_definitionContext.class);
		}
		public Equals_definitionContext equals_definition(int i) {
			return getRuleContext(Equals_definitionContext.class,i);
		}
		public List<TerminalNode> SEP_scolon() { return getTokens(VDMParser.SEP_scolon); }
		public TerminalNode SEP_scolon(int i) {
			return getToken(VDMParser.SEP_scolon, i);
		}
		public Equals_definition_listContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_equals_definition_list; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterEquals_definition_list(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitEquals_definition_list(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitEquals_definition_list(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Equals_definition_listContext equals_definition_list() throws RecognitionException {
		Equals_definition_listContext _localctx = new Equals_definition_listContext(_ctx, getState());
		enterRule(_localctx, 426, RULE_equals_definition_list);
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(2308);
			equals_definition();
			setState(2313);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,192,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					{
					{
					setState(2309);
					match(SEP_scolon);
					setState(2310);
					equals_definition();
					}
					} 
				}
				setState(2315);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,192,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Equals_definitionContext extends ParserRuleContext {
		public Pattern_bindContext pattern_bind() {
			return getRuleContext(Pattern_bindContext.class,0);
		}
		public TerminalNode O_EQUAL() { return getToken(VDMParser.O_EQUAL, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public Equals_definitionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_equals_definition; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterEquals_definition(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitEquals_definition(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitEquals_definition(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Equals_definitionContext equals_definition() throws RecognitionException {
		Equals_definitionContext _localctx = new Equals_definitionContext(_ctx, getState());
		enterRule(_localctx, 428, RULE_equals_definition);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2316);
			pattern_bind();
			setState(2317);
			match(O_EQUAL);
			setState(2318);
			expression(0);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Block_statementContext extends ParserRuleContext {
		public TerminalNode PAREN_L() { return getToken(VDMParser.PAREN_L, 0); }
		public List<StatementContext> statement() {
			return getRuleContexts(StatementContext.class);
		}
		public StatementContext statement(int i) {
			return getRuleContext(StatementContext.class,i);
		}
		public TerminalNode PAREN_R() { return getToken(VDMParser.PAREN_R, 0); }
		public List<Dcl_statementContext> dcl_statement() {
			return getRuleContexts(Dcl_statementContext.class);
		}
		public Dcl_statementContext dcl_statement(int i) {
			return getRuleContext(Dcl_statementContext.class,i);
		}
		public List<TerminalNode> SEP_scolon() { return getTokens(VDMParser.SEP_scolon); }
		public TerminalNode SEP_scolon(int i) {
			return getToken(VDMParser.SEP_scolon, i);
		}
		public Block_statementContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_block_statement; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterBlock_statement(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitBlock_statement(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitBlock_statement(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Block_statementContext block_statement() throws RecognitionException {
		Block_statementContext _localctx = new Block_statementContext(_ctx, getState());
		enterRule(_localctx, 430, RULE_block_statement);
		int _la;
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(2320);
			match(PAREN_L);
			setState(2324);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==SLK_dcl) {
				{
				{
				setState(2321);
				dcl_statement();
				}
				}
				setState(2326);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(2327);
			statement();
			setState(2332);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,194,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					{
					{
					setState(2328);
					match(SEP_scolon);
					setState(2329);
					statement();
					}
					} 
				}
				setState(2334);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,194,_ctx);
			}
			setState(2336);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SEP_scolon) {
				{
				setState(2335);
				match(SEP_scolon);
				}
			}

			setState(2338);
			match(PAREN_R);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Dcl_statementContext extends ParserRuleContext {
		public TerminalNode SLK_dcl() { return getToken(VDMParser.SLK_dcl, 0); }
		public List<Assignment_definitionContext> assignment_definition() {
			return getRuleContexts(Assignment_definitionContext.class);
		}
		public Assignment_definitionContext assignment_definition(int i) {
			return getRuleContext(Assignment_definitionContext.class,i);
		}
		public TerminalNode SEP_scolon() { return getToken(VDMParser.SEP_scolon, 0); }
		public List<TerminalNode> SEP_comma() { return getTokens(VDMParser.SEP_comma); }
		public TerminalNode SEP_comma(int i) {
			return getToken(VDMParser.SEP_comma, i);
		}
		public Dcl_statementContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_dcl_statement; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterDcl_statement(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitDcl_statement(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitDcl_statement(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Dcl_statementContext dcl_statement() throws RecognitionException {
		Dcl_statementContext _localctx = new Dcl_statementContext(_ctx, getState());
		enterRule(_localctx, 432, RULE_dcl_statement);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2340);
			match(SLK_dcl);
			setState(2341);
			assignment_definition();
			setState(2346);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==SEP_comma) {
				{
				{
				setState(2342);
				match(SEP_comma);
				setState(2343);
				assignment_definition();
				}
				}
				setState(2348);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(2349);
			match(SEP_scolon);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Assignment_definitionContext extends ParserRuleContext {
		public TerminalNode IDENTIFIER() { return getToken(VDMParser.IDENTIFIER, 0); }
		public TerminalNode SEP_colon() { return getToken(VDMParser.SEP_colon, 0); }
		public TypeContext type() {
			return getRuleContext(TypeContext.class,0);
		}
		public TerminalNode SEP_assign() { return getToken(VDMParser.SEP_assign, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public Assignment_definitionContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_assignment_definition; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterAssignment_definition(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitAssignment_definition(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitAssignment_definition(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Assignment_definitionContext assignment_definition() throws RecognitionException {
		Assignment_definitionContext _localctx = new Assignment_definitionContext(_ctx, getState());
		enterRule(_localctx, 434, RULE_assignment_definition);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2351);
			match(IDENTIFIER);
			setState(2352);
			match(SEP_colon);
			setState(2353);
			type(0);
			setState(2356);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SEP_assign) {
				{
				setState(2354);
				match(SEP_assign);
				setState(2355);
				expression(0);
				}
			}

			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class General_assignment_statementContext extends ParserRuleContext {
		public Assignment_statementContext assignment_statement() {
			return getRuleContext(Assignment_statementContext.class,0);
		}
		public Multiple_assign_statementContext multiple_assign_statement() {
			return getRuleContext(Multiple_assign_statementContext.class,0);
		}
		public General_assignment_statementContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_general_assignment_statement; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterGeneral_assignment_statement(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitGeneral_assignment_statement(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitGeneral_assignment_statement(this);
			else return visitor.visitChildren(this);
		}
	}

	public final General_assignment_statementContext general_assignment_statement() throws RecognitionException {
		General_assignment_statementContext _localctx = new General_assignment_statementContext(_ctx, getState());
		enterRule(_localctx, 436, RULE_general_assignment_statement);
		try {
			setState(2360);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case IDENTIFIER:
				enterOuterAlt(_localctx, 1);
				{
				setState(2358);
				assignment_statement();
				}
				break;
			case SLK_atomic:
				enterOuterAlt(_localctx, 2);
				{
				setState(2359);
				multiple_assign_statement();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Assignment_statementContext extends ParserRuleContext {
		public State_designatorContext state_designator() {
			return getRuleContext(State_designatorContext.class,0);
		}
		public TerminalNode SEP_assign() { return getToken(VDMParser.SEP_assign, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public Assignment_statementContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_assignment_statement; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterAssignment_statement(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitAssignment_statement(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitAssignment_statement(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Assignment_statementContext assignment_statement() throws RecognitionException {
		Assignment_statementContext _localctx = new Assignment_statementContext(_ctx, getState());
		enterRule(_localctx, 438, RULE_assignment_statement);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2362);
			state_designator(0);
			setState(2363);
			match(SEP_assign);
			setState(2364);
			expression(0);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Multiple_assign_statementContext extends ParserRuleContext {
		public TerminalNode SLK_atomic() { return getToken(VDMParser.SLK_atomic, 0); }
		public TerminalNode PAREN_L() { return getToken(VDMParser.PAREN_L, 0); }
		public List<Assignment_statementContext> assignment_statement() {
			return getRuleContexts(Assignment_statementContext.class);
		}
		public Assignment_statementContext assignment_statement(int i) {
			return getRuleContext(Assignment_statementContext.class,i);
		}
		public List<TerminalNode> SEP_scolon() { return getTokens(VDMParser.SEP_scolon); }
		public TerminalNode SEP_scolon(int i) {
			return getToken(VDMParser.SEP_scolon, i);
		}
		public TerminalNode PAREN_R() { return getToken(VDMParser.PAREN_R, 0); }
		public Multiple_assign_statementContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_multiple_assign_statement; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterMultiple_assign_statement(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitMultiple_assign_statement(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitMultiple_assign_statement(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Multiple_assign_statementContext multiple_assign_statement() throws RecognitionException {
		Multiple_assign_statementContext _localctx = new Multiple_assign_statementContext(_ctx, getState());
		enterRule(_localctx, 440, RULE_multiple_assign_statement);
		int _la;
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(2366);
			match(SLK_atomic);
			setState(2367);
			match(PAREN_L);
			setState(2368);
			assignment_statement();
			setState(2369);
			match(SEP_scolon);
			setState(2370);
			assignment_statement();
			setState(2375);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,199,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					{
					{
					setState(2371);
					match(SEP_scolon);
					setState(2372);
					assignment_statement();
					}
					} 
				}
				setState(2377);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,199,_ctx);
			}
			setState(2379);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SEP_scolon) {
				{
				setState(2378);
				match(SEP_scolon);
				}
			}

			setState(2381);
			match(PAREN_R);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class If_statementContext extends ParserRuleContext {
		public TerminalNode SLK_if() { return getToken(VDMParser.SLK_if, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public TerminalNode SLK_then() { return getToken(VDMParser.SLK_then, 0); }
		public List<StatementContext> statement() {
			return getRuleContexts(StatementContext.class);
		}
		public StatementContext statement(int i) {
			return getRuleContext(StatementContext.class,i);
		}
		public TerminalNode SLK_else() { return getToken(VDMParser.SLK_else, 0); }
		public List<Elseif_statementContext> elseif_statement() {
			return getRuleContexts(Elseif_statementContext.class);
		}
		public Elseif_statementContext elseif_statement(int i) {
			return getRuleContext(Elseif_statementContext.class,i);
		}
		public If_statementContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_if_statement; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterIf_statement(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitIf_statement(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitIf_statement(this);
			else return visitor.visitChildren(this);
		}
	}

	public final If_statementContext if_statement() throws RecognitionException {
		If_statementContext _localctx = new If_statementContext(_ctx, getState());
		enterRule(_localctx, 442, RULE_if_statement);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2383);
			match(SLK_if);
			setState(2384);
			expression(0);
			setState(2385);
			match(SLK_then);
			setState(2386);
			statement();
			setState(2390);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==SLK_elseif) {
				{
				{
				setState(2387);
				elseif_statement();
				}
				}
				setState(2392);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(2393);
			match(SLK_else);
			setState(2394);
			statement();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Elseif_statementContext extends ParserRuleContext {
		public TerminalNode SLK_elseif() { return getToken(VDMParser.SLK_elseif, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public TerminalNode SLK_then() { return getToken(VDMParser.SLK_then, 0); }
		public StatementContext statement() {
			return getRuleContext(StatementContext.class,0);
		}
		public Elseif_statementContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_elseif_statement; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterElseif_statement(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitElseif_statement(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitElseif_statement(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Elseif_statementContext elseif_statement() throws RecognitionException {
		Elseif_statementContext _localctx = new Elseif_statementContext(_ctx, getState());
		enterRule(_localctx, 444, RULE_elseif_statement);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2396);
			match(SLK_elseif);
			setState(2397);
			expression(0);
			setState(2398);
			match(SLK_then);
			setState(2399);
			statement();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Cases_statementContext extends ParserRuleContext {
		public TerminalNode SLK_cases() { return getToken(VDMParser.SLK_cases, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public TerminalNode SEP_colon() { return getToken(VDMParser.SEP_colon, 0); }
		public Cases_statement_alternativesContext cases_statement_alternatives() {
			return getRuleContext(Cases_statement_alternativesContext.class,0);
		}
		public TerminalNode SLK_end() { return getToken(VDMParser.SLK_end, 0); }
		public TerminalNode SEP_comma() { return getToken(VDMParser.SEP_comma, 0); }
		public Others_statementContext others_statement() {
			return getRuleContext(Others_statementContext.class,0);
		}
		public Cases_statementContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_cases_statement; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterCases_statement(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitCases_statement(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitCases_statement(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Cases_statementContext cases_statement() throws RecognitionException {
		Cases_statementContext _localctx = new Cases_statementContext(_ctx, getState());
		enterRule(_localctx, 446, RULE_cases_statement);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2401);
			match(SLK_cases);
			setState(2402);
			expression(0);
			setState(2403);
			match(SEP_colon);
			setState(2404);
			cases_statement_alternatives();
			setState(2407);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SEP_comma) {
				{
				setState(2405);
				match(SEP_comma);
				setState(2406);
				others_statement();
				}
			}

			setState(2409);
			match(SLK_end);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Cases_statement_alternativesContext extends ParserRuleContext {
		public List<Cases_statement_alternativeContext> cases_statement_alternative() {
			return getRuleContexts(Cases_statement_alternativeContext.class);
		}
		public Cases_statement_alternativeContext cases_statement_alternative(int i) {
			return getRuleContext(Cases_statement_alternativeContext.class,i);
		}
		public List<TerminalNode> SEP_comma() { return getTokens(VDMParser.SEP_comma); }
		public TerminalNode SEP_comma(int i) {
			return getToken(VDMParser.SEP_comma, i);
		}
		public Cases_statement_alternativesContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_cases_statement_alternatives; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterCases_statement_alternatives(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitCases_statement_alternatives(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitCases_statement_alternatives(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Cases_statement_alternativesContext cases_statement_alternatives() throws RecognitionException {
		Cases_statement_alternativesContext _localctx = new Cases_statement_alternativesContext(_ctx, getState());
		enterRule(_localctx, 448, RULE_cases_statement_alternatives);
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(2411);
			cases_statement_alternative();
			setState(2416);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,203,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					{
					{
					setState(2412);
					match(SEP_comma);
					setState(2413);
					cases_statement_alternative();
					}
					} 
				}
				setState(2418);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,203,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Cases_statement_alternativeContext extends ParserRuleContext {
		public Pattern_listContext pattern_list() {
			return getRuleContext(Pattern_listContext.class,0);
		}
		public TerminalNode SEP_pfcn() { return getToken(VDMParser.SEP_pfcn, 0); }
		public StatementContext statement() {
			return getRuleContext(StatementContext.class,0);
		}
		public Cases_statement_alternativeContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_cases_statement_alternative; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterCases_statement_alternative(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitCases_statement_alternative(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitCases_statement_alternative(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Cases_statement_alternativeContext cases_statement_alternative() throws RecognitionException {
		Cases_statement_alternativeContext _localctx = new Cases_statement_alternativeContext(_ctx, getState());
		enterRule(_localctx, 450, RULE_cases_statement_alternative);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2419);
			pattern_list();
			setState(2420);
			match(SEP_pfcn);
			setState(2421);
			statement();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Others_statementContext extends ParserRuleContext {
		public TerminalNode SLK_others() { return getToken(VDMParser.SLK_others, 0); }
		public TerminalNode SEP_pfcn() { return getToken(VDMParser.SEP_pfcn, 0); }
		public StatementContext statement() {
			return getRuleContext(StatementContext.class,0);
		}
		public Others_statementContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_others_statement; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterOthers_statement(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitOthers_statement(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitOthers_statement(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Others_statementContext others_statement() throws RecognitionException {
		Others_statementContext _localctx = new Others_statementContext(_ctx, getState());
		enterRule(_localctx, 452, RULE_others_statement);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2423);
			match(SLK_others);
			setState(2424);
			match(SEP_pfcn);
			setState(2425);
			statement();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Sequence_for_loopContext extends ParserRuleContext {
		public TerminalNode SLK_for() { return getToken(VDMParser.SLK_for, 0); }
		public Pattern_bindContext pattern_bind() {
			return getRuleContext(Pattern_bindContext.class,0);
		}
		public TerminalNode SLK_in() { return getToken(VDMParser.SLK_in, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public TerminalNode SLK_do() { return getToken(VDMParser.SLK_do, 0); }
		public StatementContext statement() {
			return getRuleContext(StatementContext.class,0);
		}
		public Sequence_for_loopContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_sequence_for_loop; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterSequence_for_loop(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitSequence_for_loop(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitSequence_for_loop(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Sequence_for_loopContext sequence_for_loop() throws RecognitionException {
		Sequence_for_loopContext _localctx = new Sequence_for_loopContext(_ctx, getState());
		enterRule(_localctx, 454, RULE_sequence_for_loop);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2427);
			match(SLK_for);
			setState(2428);
			pattern_bind();
			setState(2429);
			match(SLK_in);
			setState(2430);
			expression(0);
			setState(2431);
			match(SLK_do);
			setState(2432);
			statement();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Set_for_loopContext extends ParserRuleContext {
		public TerminalNode SLK_for() { return getToken(VDMParser.SLK_for, 0); }
		public TerminalNode SLK_all() { return getToken(VDMParser.SLK_all, 0); }
		public PatternContext pattern() {
			return getRuleContext(PatternContext.class,0);
		}
		public TerminalNode SLK_inset() { return getToken(VDMParser.SLK_inset, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public TerminalNode SLK_do() { return getToken(VDMParser.SLK_do, 0); }
		public StatementContext statement() {
			return getRuleContext(StatementContext.class,0);
		}
		public Set_for_loopContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_set_for_loop; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterSet_for_loop(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitSet_for_loop(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitSet_for_loop(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Set_for_loopContext set_for_loop() throws RecognitionException {
		Set_for_loopContext _localctx = new Set_for_loopContext(_ctx, getState());
		enterRule(_localctx, 456, RULE_set_for_loop);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2434);
			match(SLK_for);
			setState(2435);
			match(SLK_all);
			setState(2436);
			pattern(0);
			setState(2437);
			match(SLK_inset);
			setState(2438);
			expression(0);
			setState(2439);
			match(SLK_do);
			setState(2440);
			statement();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Index_for_loopContext extends ParserRuleContext {
		public TerminalNode SLK_for() { return getToken(VDMParser.SLK_for, 0); }
		public TerminalNode IDENTIFIER() { return getToken(VDMParser.IDENTIFIER, 0); }
		public TerminalNode O_EQUAL() { return getToken(VDMParser.O_EQUAL, 0); }
		public List<ExpressionContext> expression() {
			return getRuleContexts(ExpressionContext.class);
		}
		public ExpressionContext expression(int i) {
			return getRuleContext(ExpressionContext.class,i);
		}
		public TerminalNode SLK_to() { return getToken(VDMParser.SLK_to, 0); }
		public TerminalNode SLK_do() { return getToken(VDMParser.SLK_do, 0); }
		public StatementContext statement() {
			return getRuleContext(StatementContext.class,0);
		}
		public TerminalNode SLK_by() { return getToken(VDMParser.SLK_by, 0); }
		public Index_for_loopContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_index_for_loop; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterIndex_for_loop(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitIndex_for_loop(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitIndex_for_loop(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Index_for_loopContext index_for_loop() throws RecognitionException {
		Index_for_loopContext _localctx = new Index_for_loopContext(_ctx, getState());
		enterRule(_localctx, 458, RULE_index_for_loop);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2442);
			match(SLK_for);
			setState(2443);
			match(IDENTIFIER);
			setState(2444);
			match(O_EQUAL);
			setState(2445);
			expression(0);
			setState(2446);
			match(SLK_to);
			setState(2447);
			expression(0);
			setState(2450);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==SLK_by) {
				{
				setState(2448);
				match(SLK_by);
				setState(2449);
				expression(0);
				}
			}

			setState(2452);
			match(SLK_do);
			setState(2453);
			statement();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class While_loopContext extends ParserRuleContext {
		public TerminalNode SLK_while() { return getToken(VDMParser.SLK_while, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public TerminalNode SLK_do() { return getToken(VDMParser.SLK_do, 0); }
		public StatementContext statement() {
			return getRuleContext(StatementContext.class,0);
		}
		public While_loopContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_while_loop; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterWhile_loop(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitWhile_loop(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitWhile_loop(this);
			else return visitor.visitChildren(this);
		}
	}

	public final While_loopContext while_loop() throws RecognitionException {
		While_loopContext _localctx = new While_loopContext(_ctx, getState());
		enterRule(_localctx, 460, RULE_while_loop);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2455);
			match(SLK_while);
			setState(2456);
			expression(0);
			setState(2457);
			match(SLK_do);
			setState(2458);
			statement();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Nondeterministic_statementContext extends ParserRuleContext {
		public TerminalNode SEP_parallel() { return getToken(VDMParser.SEP_parallel, 0); }
		public TerminalNode PAREN_L() { return getToken(VDMParser.PAREN_L, 0); }
		public List<StatementContext> statement() {
			return getRuleContexts(StatementContext.class);
		}
		public StatementContext statement(int i) {
			return getRuleContext(StatementContext.class,i);
		}
		public TerminalNode PAREN_R() { return getToken(VDMParser.PAREN_R, 0); }
		public List<TerminalNode> SEP_comma() { return getTokens(VDMParser.SEP_comma); }
		public TerminalNode SEP_comma(int i) {
			return getToken(VDMParser.SEP_comma, i);
		}
		public Nondeterministic_statementContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_nondeterministic_statement; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterNondeterministic_statement(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitNondeterministic_statement(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitNondeterministic_statement(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Nondeterministic_statementContext nondeterministic_statement() throws RecognitionException {
		Nondeterministic_statementContext _localctx = new Nondeterministic_statementContext(_ctx, getState());
		enterRule(_localctx, 462, RULE_nondeterministic_statement);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2460);
			match(SEP_parallel);
			setState(2461);
			match(PAREN_L);
			setState(2462);
			statement();
			setState(2467);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==SEP_comma) {
				{
				{
				setState(2463);
				match(SEP_comma);
				setState(2464);
				statement();
				}
				}
				setState(2469);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(2470);
			match(PAREN_R);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Call_statementContext extends ParserRuleContext {
		public NameContext name() {
			return getRuleContext(NameContext.class,0);
		}
		public TerminalNode PAREN_L() { return getToken(VDMParser.PAREN_L, 0); }
		public TerminalNode PAREN_R() { return getToken(VDMParser.PAREN_R, 0); }
		public Expression_listContext expression_list() {
			return getRuleContext(Expression_listContext.class,0);
		}
		public Call_statementContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_call_statement; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterCall_statement(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitCall_statement(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitCall_statement(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Call_statementContext call_statement() throws RecognitionException {
		Call_statementContext _localctx = new Call_statementContext(_ctx, getState());
		enterRule(_localctx, 464, RULE_call_statement);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2472);
			name();
			setState(2473);
			match(PAREN_L);
			setState(2475);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,206,_ctx) ) {
			case 1:
				{
				setState(2474);
				expression_list();
				}
				break;
			}
			setState(2477);
			match(PAREN_R);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Return_statementContext extends ParserRuleContext {
		public TerminalNode SLK_return() { return getToken(VDMParser.SLK_return, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public Return_statementContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_return_statement; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterReturn_statement(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitReturn_statement(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitReturn_statement(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Return_statementContext return_statement() throws RecognitionException {
		Return_statementContext _localctx = new Return_statementContext(_ctx, getState());
		enterRule(_localctx, 466, RULE_return_statement);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2479);
			match(SLK_return);
			setState(2481);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,207,_ctx) ) {
			case 1:
				{
				setState(2480);
				expression(0);
				}
				break;
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Pp_call_statementContext extends ParserRuleContext {
		public Call_statementContext call_statement() {
			return getRuleContext(Call_statementContext.class,0);
		}
		public Object_designatorContext object_designator() {
			return getRuleContext(Object_designatorContext.class,0);
		}
		public TerminalNode SEP_dot() { return getToken(VDMParser.SEP_dot, 0); }
		public Pp_call_statementContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_pp_call_statement; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterPp_call_statement(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitPp_call_statement(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitPp_call_statement(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Pp_call_statementContext pp_call_statement() throws RecognitionException {
		Pp_call_statementContext _localctx = new Pp_call_statementContext(_ctx, getState());
		enterRule(_localctx, 468, RULE_pp_call_statement);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2486);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,208,_ctx) ) {
			case 1:
				{
				setState(2483);
				object_designator(0);
				setState(2484);
				match(SEP_dot);
				}
				break;
			}
			setState(2488);
			call_statement();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Object_designatorContext extends ParserRuleContext {
		public Object_designatorContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_object_designator; }
	 
		public Object_designatorContext() { }
		public void copyFrom(Object_designatorContext ctx) {
			super.copyFrom(ctx);
		}
	}
	public static class ObjNewExprDesignatorContext extends Object_designatorContext {
		public New_expressionContext new_expression() {
			return getRuleContext(New_expressionContext.class,0);
		}
		public ObjNewExprDesignatorContext(Object_designatorContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterObjNewExprDesignator(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitObjNewExprDesignator(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitObjNewExprDesignator(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class ObjApplyDesignatorContext extends Object_designatorContext {
		public Object_designatorContext object_designator() {
			return getRuleContext(Object_designatorContext.class,0);
		}
		public TerminalNode PAREN_L() { return getToken(VDMParser.PAREN_L, 0); }
		public TerminalNode PAREN_R() { return getToken(VDMParser.PAREN_R, 0); }
		public Expression_listContext expression_list() {
			return getRuleContext(Expression_listContext.class,0);
		}
		public ObjApplyDesignatorContext(Object_designatorContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterObjApplyDesignator(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitObjApplyDesignator(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitObjApplyDesignator(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class ObjFieldRefDesignatorContext extends Object_designatorContext {
		public Object_designatorContext object_designator() {
			return getRuleContext(Object_designatorContext.class,0);
		}
		public TerminalNode SEP_dot() { return getToken(VDMParser.SEP_dot, 0); }
		public TerminalNode IDENTIFIER() { return getToken(VDMParser.IDENTIFIER, 0); }
		public ObjFieldRefDesignatorContext(Object_designatorContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterObjFieldRefDesignator(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitObjFieldRefDesignator(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitObjFieldRefDesignator(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class ObjSelfExprDesignatorContext extends Object_designatorContext {
		public Self_expressionContext self_expression() {
			return getRuleContext(Self_expressionContext.class,0);
		}
		public ObjSelfExprDesignatorContext(Object_designatorContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterObjSelfExprDesignator(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitObjSelfExprDesignator(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitObjSelfExprDesignator(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class ObjNameDesignatorContext extends Object_designatorContext {
		public NameContext name() {
			return getRuleContext(NameContext.class,0);
		}
		public ObjNameDesignatorContext(Object_designatorContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterObjNameDesignator(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitObjNameDesignator(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitObjNameDesignator(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Object_designatorContext object_designator() throws RecognitionException {
		return object_designator(0);
	}

	private Object_designatorContext object_designator(int _p) throws RecognitionException {
		ParserRuleContext _parentctx = _ctx;
		int _parentState = getState();
		Object_designatorContext _localctx = new Object_designatorContext(_ctx, _parentState);
		Object_designatorContext _prevctx = _localctx;
		int _startState = 470;
		enterRecursionRule(_localctx, 470, RULE_object_designator, _p);
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(2494);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case PPK_self:
				{
				_localctx = new ObjSelfExprDesignatorContext(_localctx);
				_ctx = _localctx;
				_prevctx = _localctx;

				setState(2491);
				self_expression();
				}
				break;
			case PPK_new:
				{
				_localctx = new ObjNewExprDesignatorContext(_localctx);
				_ctx = _localctx;
				_prevctx = _localctx;
				setState(2492);
				new_expression();
				}
				break;
			case IDENTIFIER:
				{
				_localctx = new ObjNameDesignatorContext(_localctx);
				_ctx = _localctx;
				_prevctx = _localctx;
				setState(2493);
				name();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
			_ctx.stop = _input.LT(-1);
			setState(2507);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,212,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					if ( _parseListeners!=null ) triggerExitRuleEvent();
					_prevctx = _localctx;
					{
					setState(2505);
					_errHandler.sync(this);
					switch ( getInterpreter().adaptivePredict(_input,211,_ctx) ) {
					case 1:
						{
						_localctx = new ObjApplyDesignatorContext(new Object_designatorContext(_parentctx, _parentState));
						pushNewRecursionContext(_localctx, _startState, RULE_object_designator);
						setState(2496);
						if (!(precpred(_ctx, 5))) throw new FailedPredicateException(this, "precpred(_ctx, 5)");
						setState(2497);
						match(PAREN_L);
						setState(2499);
						_errHandler.sync(this);
						switch ( getInterpreter().adaptivePredict(_input,210,_ctx) ) {
						case 1:
							{
							setState(2498);
							expression_list();
							}
							break;
						}
						setState(2501);
						match(PAREN_R);
						}
						break;
					case 2:
						{
						_localctx = new ObjFieldRefDesignatorContext(new Object_designatorContext(_parentctx, _parentState));
						pushNewRecursionContext(_localctx, _startState, RULE_object_designator);
						setState(2502);
						if (!(precpred(_ctx, 4))) throw new FailedPredicateException(this, "precpred(_ctx, 4)");
						setState(2503);
						match(SEP_dot);
						setState(2504);
						match(IDENTIFIER);
						}
						break;
					}
					} 
				}
				setState(2509);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,212,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			unrollRecursionContexts(_parentctx);
		}
		return _localctx;
	}

	public static class Object_field_referenceContext extends ParserRuleContext {
		public Object_designatorContext object_designator() {
			return getRuleContext(Object_designatorContext.class,0);
		}
		public TerminalNode SEP_dot() { return getToken(VDMParser.SEP_dot, 0); }
		public TerminalNode IDENTIFIER() { return getToken(VDMParser.IDENTIFIER, 0); }
		public Object_field_referenceContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_object_field_reference; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterObject_field_reference(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitObject_field_reference(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitObject_field_reference(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Object_field_referenceContext object_field_reference() throws RecognitionException {
		Object_field_referenceContext _localctx = new Object_field_referenceContext(_ctx, getState());
		enterRule(_localctx, 472, RULE_object_field_reference);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2510);
			object_designator(0);
			setState(2511);
			match(SEP_dot);
			setState(2512);
			match(IDENTIFIER);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Object_applyContext extends ParserRuleContext {
		public Object_designatorContext object_designator() {
			return getRuleContext(Object_designatorContext.class,0);
		}
		public TerminalNode PAREN_L() { return getToken(VDMParser.PAREN_L, 0); }
		public TerminalNode PAREN_R() { return getToken(VDMParser.PAREN_R, 0); }
		public Expression_listContext expression_list() {
			return getRuleContext(Expression_listContext.class,0);
		}
		public Object_applyContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_object_apply; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterObject_apply(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitObject_apply(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitObject_apply(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Object_applyContext object_apply() throws RecognitionException {
		Object_applyContext _localctx = new Object_applyContext(_ctx, getState());
		enterRule(_localctx, 474, RULE_object_apply);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2514);
			object_designator(0);
			setState(2515);
			match(PAREN_L);
			setState(2517);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,213,_ctx) ) {
			case 1:
				{
				setState(2516);
				expression_list();
				}
				break;
			}
			setState(2519);
			match(PAREN_R);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Specification_statementContext extends ParserRuleContext {
		public TerminalNode BRACKET_L() { return getToken(VDMParser.BRACKET_L, 0); }
		public Implicit_operation_bodyContext implicit_operation_body() {
			return getRuleContext(Implicit_operation_bodyContext.class,0);
		}
		public TerminalNode BRACE_R() { return getToken(VDMParser.BRACE_R, 0); }
		public Specification_statementContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_specification_statement; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterSpecification_statement(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitSpecification_statement(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitSpecification_statement(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Specification_statementContext specification_statement() throws RecognitionException {
		Specification_statementContext _localctx = new Specification_statementContext(_ctx, getState());
		enterRule(_localctx, 476, RULE_specification_statement);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2521);
			match(BRACKET_L);
			setState(2522);
			implicit_operation_body();
			setState(2523);
			match(BRACE_R);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Start_statementContext extends ParserRuleContext {
		public TerminalNode RTK_start() { return getToken(VDMParser.RTK_start, 0); }
		public TerminalNode PAREN_L() { return getToken(VDMParser.PAREN_L, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public TerminalNode PAREN_R() { return getToken(VDMParser.PAREN_R, 0); }
		public Start_statementContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_start_statement; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterStart_statement(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitStart_statement(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitStart_statement(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Start_statementContext start_statement() throws RecognitionException {
		Start_statementContext _localctx = new Start_statementContext(_ctx, getState());
		enterRule(_localctx, 478, RULE_start_statement);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2525);
			match(RTK_start);
			setState(2526);
			match(PAREN_L);
			setState(2527);
			expression(0);
			setState(2528);
			match(PAREN_R);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Start_list_statementContext extends ParserRuleContext {
		public TerminalNode RTK_startlist() { return getToken(VDMParser.RTK_startlist, 0); }
		public TerminalNode PAREN_L() { return getToken(VDMParser.PAREN_L, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public TerminalNode PAREN_R() { return getToken(VDMParser.PAREN_R, 0); }
		public Start_list_statementContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_start_list_statement; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterStart_list_statement(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitStart_list_statement(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitStart_list_statement(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Start_list_statementContext start_list_statement() throws RecognitionException {
		Start_list_statementContext _localctx = new Start_list_statementContext(_ctx, getState());
		enterRule(_localctx, 480, RULE_start_list_statement);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2530);
			match(RTK_startlist);
			setState(2531);
			match(PAREN_L);
			setState(2532);
			expression(0);
			setState(2533);
			match(PAREN_R);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Stop_statementContext extends ParserRuleContext {
		public TerminalNode RTK_stop() { return getToken(VDMParser.RTK_stop, 0); }
		public TerminalNode PAREN_L() { return getToken(VDMParser.PAREN_L, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public TerminalNode PAREN_R() { return getToken(VDMParser.PAREN_R, 0); }
		public Stop_statementContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_stop_statement; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterStop_statement(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitStop_statement(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitStop_statement(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Stop_statementContext stop_statement() throws RecognitionException {
		Stop_statementContext _localctx = new Stop_statementContext(_ctx, getState());
		enterRule(_localctx, 482, RULE_stop_statement);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2535);
			match(RTK_stop);
			setState(2536);
			match(PAREN_L);
			setState(2537);
			expression(0);
			setState(2538);
			match(PAREN_R);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Stop_list_statementContext extends ParserRuleContext {
		public TerminalNode RTK_stoplist() { return getToken(VDMParser.RTK_stoplist, 0); }
		public TerminalNode PAREN_L() { return getToken(VDMParser.PAREN_L, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public TerminalNode PAREN_R() { return getToken(VDMParser.PAREN_R, 0); }
		public Stop_list_statementContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_stop_list_statement; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterStop_list_statement(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitStop_list_statement(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitStop_list_statement(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Stop_list_statementContext stop_list_statement() throws RecognitionException {
		Stop_list_statementContext _localctx = new Stop_list_statementContext(_ctx, getState());
		enterRule(_localctx, 484, RULE_stop_list_statement);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2540);
			match(RTK_stoplist);
			setState(2541);
			match(PAREN_L);
			setState(2542);
			expression(0);
			setState(2543);
			match(PAREN_R);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Duration_statementContext extends ParserRuleContext {
		public TerminalNode RTK_duration() { return getToken(VDMParser.RTK_duration, 0); }
		public TerminalNode PAREN_L() { return getToken(VDMParser.PAREN_L, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public TerminalNode PAREN_R() { return getToken(VDMParser.PAREN_R, 0); }
		public StatementContext statement() {
			return getRuleContext(StatementContext.class,0);
		}
		public Duration_statementContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_duration_statement; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterDuration_statement(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitDuration_statement(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitDuration_statement(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Duration_statementContext duration_statement() throws RecognitionException {
		Duration_statementContext _localctx = new Duration_statementContext(_ctx, getState());
		enterRule(_localctx, 486, RULE_duration_statement);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2545);
			match(RTK_duration);
			setState(2546);
			match(PAREN_L);
			setState(2547);
			expression(0);
			setState(2548);
			match(PAREN_R);
			setState(2549);
			statement();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Cycles_statementContext extends ParserRuleContext {
		public TerminalNode RTK_cycles() { return getToken(VDMParser.RTK_cycles, 0); }
		public TerminalNode PAREN_L() { return getToken(VDMParser.PAREN_L, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public TerminalNode PAREN_R() { return getToken(VDMParser.PAREN_R, 0); }
		public StatementContext statement() {
			return getRuleContext(StatementContext.class,0);
		}
		public Cycles_statementContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_cycles_statement; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterCycles_statement(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitCycles_statement(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitCycles_statement(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Cycles_statementContext cycles_statement() throws RecognitionException {
		Cycles_statementContext _localctx = new Cycles_statementContext(_ctx, getState());
		enterRule(_localctx, 488, RULE_cycles_statement);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2551);
			match(RTK_cycles);
			setState(2552);
			match(PAREN_L);
			setState(2553);
			expression(0);
			setState(2554);
			match(PAREN_R);
			setState(2555);
			statement();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Always_statementContext extends ParserRuleContext {
		public TerminalNode SLK_always() { return getToken(VDMParser.SLK_always, 0); }
		public List<StatementContext> statement() {
			return getRuleContexts(StatementContext.class);
		}
		public StatementContext statement(int i) {
			return getRuleContext(StatementContext.class,i);
		}
		public TerminalNode SLK_in() { return getToken(VDMParser.SLK_in, 0); }
		public Always_statementContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_always_statement; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterAlways_statement(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitAlways_statement(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitAlways_statement(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Always_statementContext always_statement() throws RecognitionException {
		Always_statementContext _localctx = new Always_statementContext(_ctx, getState());
		enterRule(_localctx, 490, RULE_always_statement);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2557);
			match(SLK_always);
			setState(2558);
			statement();
			setState(2559);
			match(SLK_in);
			setState(2560);
			statement();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Trap_statementContext extends ParserRuleContext {
		public TerminalNode SLK_trap() { return getToken(VDMParser.SLK_trap, 0); }
		public Pattern_bindContext pattern_bind() {
			return getRuleContext(Pattern_bindContext.class,0);
		}
		public TerminalNode SLK_with() { return getToken(VDMParser.SLK_with, 0); }
		public List<StatementContext> statement() {
			return getRuleContexts(StatementContext.class);
		}
		public StatementContext statement(int i) {
			return getRuleContext(StatementContext.class,i);
		}
		public TerminalNode SLK_in() { return getToken(VDMParser.SLK_in, 0); }
		public Trap_statementContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_trap_statement; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterTrap_statement(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitTrap_statement(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitTrap_statement(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Trap_statementContext trap_statement() throws RecognitionException {
		Trap_statementContext _localctx = new Trap_statementContext(_ctx, getState());
		enterRule(_localctx, 492, RULE_trap_statement);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2562);
			match(SLK_trap);
			setState(2563);
			pattern_bind();
			setState(2564);
			match(SLK_with);
			setState(2565);
			statement();
			setState(2566);
			match(SLK_in);
			setState(2567);
			statement();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Recursive_trap_statementContext extends ParserRuleContext {
		public TerminalNode SLK_tixe() { return getToken(VDMParser.SLK_tixe, 0); }
		public TrapsContext traps() {
			return getRuleContext(TrapsContext.class,0);
		}
		public TerminalNode SLK_in() { return getToken(VDMParser.SLK_in, 0); }
		public StatementContext statement() {
			return getRuleContext(StatementContext.class,0);
		}
		public Recursive_trap_statementContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_recursive_trap_statement; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterRecursive_trap_statement(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitRecursive_trap_statement(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitRecursive_trap_statement(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Recursive_trap_statementContext recursive_trap_statement() throws RecognitionException {
		Recursive_trap_statementContext _localctx = new Recursive_trap_statementContext(_ctx, getState());
		enterRule(_localctx, 494, RULE_recursive_trap_statement);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2569);
			match(SLK_tixe);
			setState(2570);
			traps();
			setState(2571);
			match(SLK_in);
			setState(2572);
			statement();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class TrapsContext extends ParserRuleContext {
		public TerminalNode BRACE_L() { return getToken(VDMParser.BRACE_L, 0); }
		public List<Pattern_bindContext> pattern_bind() {
			return getRuleContexts(Pattern_bindContext.class);
		}
		public Pattern_bindContext pattern_bind(int i) {
			return getRuleContext(Pattern_bindContext.class,i);
		}
		public List<TerminalNode> SEP_maplet() { return getTokens(VDMParser.SEP_maplet); }
		public TerminalNode SEP_maplet(int i) {
			return getToken(VDMParser.SEP_maplet, i);
		}
		public List<StatementContext> statement() {
			return getRuleContexts(StatementContext.class);
		}
		public StatementContext statement(int i) {
			return getRuleContext(StatementContext.class,i);
		}
		public TerminalNode BRACE_R() { return getToken(VDMParser.BRACE_R, 0); }
		public List<TerminalNode> SEP_comma() { return getTokens(VDMParser.SEP_comma); }
		public TerminalNode SEP_comma(int i) {
			return getToken(VDMParser.SEP_comma, i);
		}
		public TrapsContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_traps; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterTraps(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitTraps(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitTraps(this);
			else return visitor.visitChildren(this);
		}
	}

	public final TrapsContext traps() throws RecognitionException {
		TrapsContext _localctx = new TrapsContext(_ctx, getState());
		enterRule(_localctx, 496, RULE_traps);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2574);
			match(BRACE_L);
			setState(2575);
			pattern_bind();
			setState(2576);
			match(SEP_maplet);
			setState(2577);
			statement();
			setState(2585);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==SEP_comma) {
				{
				{
				setState(2578);
				match(SEP_comma);
				setState(2579);
				pattern_bind();
				setState(2580);
				match(SEP_maplet);
				setState(2581);
				statement();
				}
				}
				setState(2587);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(2588);
			match(BRACE_R);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Exit_statementContext extends ParserRuleContext {
		public TerminalNode SLK_exit() { return getToken(VDMParser.SLK_exit, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public Exit_statementContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_exit_statement; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterExit_statement(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitExit_statement(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitExit_statement(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Exit_statementContext exit_statement() throws RecognitionException {
		Exit_statementContext _localctx = new Exit_statementContext(_ctx, getState());
		enterRule(_localctx, 498, RULE_exit_statement);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2590);
			match(SLK_exit);
			setState(2592);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,215,_ctx) ) {
			case 1:
				{
				setState(2591);
				expression(0);
				}
				break;
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Error_statementContext extends ParserRuleContext {
		public TerminalNode SLK_error() { return getToken(VDMParser.SLK_error, 0); }
		public Error_statementContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_error_statement; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterError_statement(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitError_statement(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitError_statement(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Error_statementContext error_statement() throws RecognitionException {
		Error_statementContext _localctx = new Error_statementContext(_ctx, getState());
		enterRule(_localctx, 500, RULE_error_statement);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2594);
			match(SLK_error);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Identity_statementContext extends ParserRuleContext {
		public TerminalNode SLK_skip() { return getToken(VDMParser.SLK_skip, 0); }
		public Identity_statementContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_identity_statement; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterIdentity_statement(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitIdentity_statement(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitIdentity_statement(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Identity_statementContext identity_statement() throws RecognitionException {
		Identity_statementContext _localctx = new Identity_statementContext(_ctx, getState());
		enterRule(_localctx, 502, RULE_identity_statement);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2596);
			match(SLK_skip);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class PatternContext extends ParserRuleContext {
		public PatternContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_pattern; }
	 
		public PatternContext() { }
		public void copyFrom(PatternContext ctx) {
			super.copyFrom(ctx);
		}
	}
	public static class SetUnionPatternContext extends PatternContext {
		public List<PatternContext> pattern() {
			return getRuleContexts(PatternContext.class);
		}
		public PatternContext pattern(int i) {
			return getRuleContext(PatternContext.class,i);
		}
		public TerminalNode SLK_union() { return getToken(VDMParser.SLK_union, 0); }
		public SetUnionPatternContext(PatternContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterSetUnionPattern(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitSetUnionPattern(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitSetUnionPattern(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class TupplePatternContext extends PatternContext {
		public Tupple_patternContext tupple_pattern() {
			return getRuleContext(Tupple_patternContext.class,0);
		}
		public TupplePatternContext(PatternContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterTupplePattern(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitTupplePattern(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitTupplePattern(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class SeqConcPatternContext extends PatternContext {
		public List<PatternContext> pattern() {
			return getRuleContexts(PatternContext.class);
		}
		public PatternContext pattern(int i) {
			return getRuleContext(PatternContext.class,i);
		}
		public TerminalNode O_CONCAT() { return getToken(VDMParser.O_CONCAT, 0); }
		public SeqConcPatternContext(PatternContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterSeqConcPattern(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitSeqConcPattern(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitSeqConcPattern(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class MapUnionPatternContext extends PatternContext {
		public List<PatternContext> pattern() {
			return getRuleContexts(PatternContext.class);
		}
		public PatternContext pattern(int i) {
			return getRuleContext(PatternContext.class,i);
		}
		public TerminalNode SLK_munion() { return getToken(VDMParser.SLK_munion, 0); }
		public MapUnionPatternContext(PatternContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterMapUnionPattern(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitMapUnionPattern(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitMapUnionPattern(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class RecordPatternContext extends PatternContext {
		public Record_patternContext record_pattern() {
			return getRuleContext(Record_patternContext.class,0);
		}
		public RecordPatternContext(PatternContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterRecordPattern(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitRecordPattern(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitRecordPattern(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class SetEnumPatternContext extends PatternContext {
		public Set_enum_patternContext set_enum_pattern() {
			return getRuleContext(Set_enum_patternContext.class,0);
		}
		public SetEnumPatternContext(PatternContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterSetEnumPattern(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitSetEnumPattern(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitSetEnumPattern(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class MatchValuePatternContext extends PatternContext {
		public Match_valueContext match_value() {
			return getRuleContext(Match_valueContext.class,0);
		}
		public MatchValuePatternContext(PatternContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterMatchValuePattern(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitMatchValuePattern(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitMatchValuePattern(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class MapEnumPatternContext extends PatternContext {
		public Map_enum_patternContext map_enum_pattern() {
			return getRuleContext(Map_enum_patternContext.class,0);
		}
		public MapEnumPatternContext(PatternContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterMapEnumPattern(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitMapEnumPattern(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitMapEnumPattern(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class IdPatternContext extends PatternContext {
		public Pattern_identifierContext pattern_identifier() {
			return getRuleContext(Pattern_identifierContext.class,0);
		}
		public IdPatternContext(PatternContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterIdPattern(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitIdPattern(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitIdPattern(this);
			else return visitor.visitChildren(this);
		}
	}
	public static class SeqEnumPatternContext extends PatternContext {
		public Seq_enum_patternContext seq_enum_pattern() {
			return getRuleContext(Seq_enum_patternContext.class,0);
		}
		public SeqEnumPatternContext(PatternContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterSeqEnumPattern(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitSeqEnumPattern(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitSeqEnumPattern(this);
			else return visitor.visitChildren(this);
		}
	}

	public final PatternContext pattern() throws RecognitionException {
		return pattern(0);
	}

	private PatternContext pattern(int _p) throws RecognitionException {
		ParserRuleContext _parentctx = _ctx;
		int _parentState = getState();
		PatternContext _localctx = new PatternContext(_ctx, _parentState);
		PatternContext _prevctx = _localctx;
		int _startState = 504;
		enterRecursionRule(_localctx, 504, RULE_pattern, _p);
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(2606);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,216,_ctx) ) {
			case 1:
				{
				_localctx = new IdPatternContext(_localctx);
				_ctx = _localctx;
				_prevctx = _localctx;

				setState(2599);
				pattern_identifier();
				}
				break;
			case 2:
				{
				_localctx = new MatchValuePatternContext(_localctx);
				_ctx = _localctx;
				_prevctx = _localctx;
				setState(2600);
				match_value();
				}
				break;
			case 3:
				{
				_localctx = new SetEnumPatternContext(_localctx);
				_ctx = _localctx;
				_prevctx = _localctx;
				setState(2601);
				set_enum_pattern();
				}
				break;
			case 4:
				{
				_localctx = new SeqEnumPatternContext(_localctx);
				_ctx = _localctx;
				_prevctx = _localctx;
				setState(2602);
				seq_enum_pattern();
				}
				break;
			case 5:
				{
				_localctx = new MapEnumPatternContext(_localctx);
				_ctx = _localctx;
				_prevctx = _localctx;
				setState(2603);
				map_enum_pattern();
				}
				break;
			case 6:
				{
				_localctx = new TupplePatternContext(_localctx);
				_ctx = _localctx;
				_prevctx = _localctx;
				setState(2604);
				tupple_pattern();
				}
				break;
			case 7:
				{
				_localctx = new RecordPatternContext(_localctx);
				_ctx = _localctx;
				_prevctx = _localctx;
				setState(2605);
				record_pattern();
				}
				break;
			}
			_ctx.stop = _input.LT(-1);
			setState(2619);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,218,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					if ( _parseListeners!=null ) triggerExitRuleEvent();
					_prevctx = _localctx;
					{
					setState(2617);
					_errHandler.sync(this);
					switch ( getInterpreter().adaptivePredict(_input,217,_ctx) ) {
					case 1:
						{
						_localctx = new SetUnionPatternContext(new PatternContext(_parentctx, _parentState));
						pushNewRecursionContext(_localctx, _startState, RULE_pattern);
						setState(2608);
						if (!(precpred(_ctx, 7))) throw new FailedPredicateException(this, "precpred(_ctx, 7)");
						setState(2609);
						match(SLK_union);
						setState(2610);
						pattern(8);
						}
						break;
					case 2:
						{
						_localctx = new SeqConcPatternContext(new PatternContext(_parentctx, _parentState));
						pushNewRecursionContext(_localctx, _startState, RULE_pattern);
						setState(2611);
						if (!(precpred(_ctx, 5))) throw new FailedPredicateException(this, "precpred(_ctx, 5)");
						setState(2612);
						match(O_CONCAT);
						setState(2613);
						pattern(6);
						}
						break;
					case 3:
						{
						_localctx = new MapUnionPatternContext(new PatternContext(_parentctx, _parentState));
						pushNewRecursionContext(_localctx, _startState, RULE_pattern);
						setState(2614);
						if (!(precpred(_ctx, 3))) throw new FailedPredicateException(this, "precpred(_ctx, 3)");
						setState(2615);
						match(SLK_munion);
						setState(2616);
						pattern(4);
						}
						break;
					}
					} 
				}
				setState(2621);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,218,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			unrollRecursionContexts(_parentctx);
		}
		return _localctx;
	}

	public static class Pattern_identifierContext extends ParserRuleContext {
		public TerminalNode IDENTIFIER() { return getToken(VDMParser.IDENTIFIER, 0); }
		public TerminalNode O_MINUS() { return getToken(VDMParser.O_MINUS, 0); }
		public Pattern_identifierContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_pattern_identifier; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterPattern_identifier(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitPattern_identifier(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitPattern_identifier(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Pattern_identifierContext pattern_identifier() throws RecognitionException {
		Pattern_identifierContext _localctx = new Pattern_identifierContext(_ctx, getState());
		enterRule(_localctx, 506, RULE_pattern_identifier);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2622);
			_la = _input.LA(1);
			if ( !(_la==O_MINUS || _la==IDENTIFIER) ) {
			_errHandler.recoverInline(this);
			}
			else {
				if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
				_errHandler.reportMatch(this);
				consume();
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Match_valueContext extends ParserRuleContext {
		public TerminalNode PAREN_L() { return getToken(VDMParser.PAREN_L, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public TerminalNode PAREN_R() { return getToken(VDMParser.PAREN_R, 0); }
		public Symbolic_literalContext symbolic_literal() {
			return getRuleContext(Symbolic_literalContext.class,0);
		}
		public Match_valueContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_match_value; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterMatch_value(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitMatch_value(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitMatch_value(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Match_valueContext match_value() throws RecognitionException {
		Match_valueContext _localctx = new Match_valueContext(_ctx, getState());
		enterRule(_localctx, 508, RULE_match_value);
		try {
			setState(2629);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case PAREN_L:
				enterOuterAlt(_localctx, 1);
				{
				setState(2624);
				match(PAREN_L);
				setState(2625);
				expression(0);
				setState(2626);
				match(PAREN_R);
				}
				break;
			case SLK_false:
			case SLK_nil:
			case SLK_true:
			case QUOTE_LITERAL:
			case NUMERIC_LITERAL:
			case CHARACTER_LITERAL:
			case TEXT_LITERAL:
				enterOuterAlt(_localctx, 2);
				{
				setState(2628);
				symbolic_literal();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Set_enum_patternContext extends ParserRuleContext {
		public TerminalNode BRACE_L() { return getToken(VDMParser.BRACE_L, 0); }
		public TerminalNode BRACE_R() { return getToken(VDMParser.BRACE_R, 0); }
		public Pattern_listContext pattern_list() {
			return getRuleContext(Pattern_listContext.class,0);
		}
		public Set_enum_patternContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_set_enum_pattern; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterSet_enum_pattern(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitSet_enum_pattern(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitSet_enum_pattern(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Set_enum_patternContext set_enum_pattern() throws RecognitionException {
		Set_enum_patternContext _localctx = new Set_enum_patternContext(_ctx, getState());
		enterRule(_localctx, 510, RULE_set_enum_pattern);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2631);
			match(BRACE_L);
			setState(2633);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (((((_la - 45)) & ~0x3f) == 0 && ((1L << (_la - 45)) & ((1L << (SLK_false - 45)) | (1L << (SLK_mk - 45)) | (1L << (SLK_nil - 45)) | (1L << (SLK_true - 45)))) != 0) || ((((_la - 172)) & ~0x3f) == 0 && ((1L << (_la - 172)) & ((1L << (O_MINUS - 172)) | (1L << (PAREN_L - 172)) | (1L << (BRACKET_L - 172)) | (1L << (BRACE_L - 172)) | (1L << (QUOTE_LITERAL - 172)) | (1L << (NUMERIC_LITERAL - 172)) | (1L << (CHARACTER_LITERAL - 172)) | (1L << (TEXT_LITERAL - 172)) | (1L << (IDENTIFIER - 172)))) != 0)) {
				{
				setState(2632);
				pattern_list();
				}
			}

			setState(2635);
			match(BRACE_R);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Set_union_patternContext extends ParserRuleContext {
		public List<PatternContext> pattern() {
			return getRuleContexts(PatternContext.class);
		}
		public PatternContext pattern(int i) {
			return getRuleContext(PatternContext.class,i);
		}
		public TerminalNode SLK_union() { return getToken(VDMParser.SLK_union, 0); }
		public Set_union_patternContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_set_union_pattern; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterSet_union_pattern(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitSet_union_pattern(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitSet_union_pattern(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Set_union_patternContext set_union_pattern() throws RecognitionException {
		Set_union_patternContext _localctx = new Set_union_patternContext(_ctx, getState());
		enterRule(_localctx, 512, RULE_set_union_pattern);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2637);
			pattern(0);
			setState(2638);
			match(SLK_union);
			setState(2639);
			pattern(0);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Seq_enum_patternContext extends ParserRuleContext {
		public TerminalNode BRACKET_L() { return getToken(VDMParser.BRACKET_L, 0); }
		public TerminalNode BRACKET_R() { return getToken(VDMParser.BRACKET_R, 0); }
		public Pattern_listContext pattern_list() {
			return getRuleContext(Pattern_listContext.class,0);
		}
		public Seq_enum_patternContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_seq_enum_pattern; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterSeq_enum_pattern(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitSeq_enum_pattern(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitSeq_enum_pattern(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Seq_enum_patternContext seq_enum_pattern() throws RecognitionException {
		Seq_enum_patternContext _localctx = new Seq_enum_patternContext(_ctx, getState());
		enterRule(_localctx, 514, RULE_seq_enum_pattern);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2641);
			match(BRACKET_L);
			setState(2643);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (((((_la - 45)) & ~0x3f) == 0 && ((1L << (_la - 45)) & ((1L << (SLK_false - 45)) | (1L << (SLK_mk - 45)) | (1L << (SLK_nil - 45)) | (1L << (SLK_true - 45)))) != 0) || ((((_la - 172)) & ~0x3f) == 0 && ((1L << (_la - 172)) & ((1L << (O_MINUS - 172)) | (1L << (PAREN_L - 172)) | (1L << (BRACKET_L - 172)) | (1L << (BRACE_L - 172)) | (1L << (QUOTE_LITERAL - 172)) | (1L << (NUMERIC_LITERAL - 172)) | (1L << (CHARACTER_LITERAL - 172)) | (1L << (TEXT_LITERAL - 172)) | (1L << (IDENTIFIER - 172)))) != 0)) {
				{
				setState(2642);
				pattern_list();
				}
			}

			setState(2645);
			match(BRACKET_R);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Seq_conc_patternContext extends ParserRuleContext {
		public List<PatternContext> pattern() {
			return getRuleContexts(PatternContext.class);
		}
		public PatternContext pattern(int i) {
			return getRuleContext(PatternContext.class,i);
		}
		public TerminalNode O_CONCAT() { return getToken(VDMParser.O_CONCAT, 0); }
		public Seq_conc_patternContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_seq_conc_pattern; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterSeq_conc_pattern(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitSeq_conc_pattern(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitSeq_conc_pattern(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Seq_conc_patternContext seq_conc_pattern() throws RecognitionException {
		Seq_conc_patternContext _localctx = new Seq_conc_patternContext(_ctx, getState());
		enterRule(_localctx, 516, RULE_seq_conc_pattern);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2647);
			pattern(0);
			setState(2648);
			match(O_CONCAT);
			setState(2649);
			pattern(0);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Map_enum_patternContext extends ParserRuleContext {
		public TerminalNode BRACE_L() { return getToken(VDMParser.BRACE_L, 0); }
		public Maplet_pattern_listContext maplet_pattern_list() {
			return getRuleContext(Maplet_pattern_listContext.class,0);
		}
		public TerminalNode BRACE_R() { return getToken(VDMParser.BRACE_R, 0); }
		public TerminalNode SEP_maplet() { return getToken(VDMParser.SEP_maplet, 0); }
		public Map_enum_patternContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_map_enum_pattern; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterMap_enum_pattern(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitMap_enum_pattern(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitMap_enum_pattern(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Map_enum_patternContext map_enum_pattern() throws RecognitionException {
		Map_enum_patternContext _localctx = new Map_enum_patternContext(_ctx, getState());
		enterRule(_localctx, 518, RULE_map_enum_pattern);
		try {
			setState(2658);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,222,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(2651);
				match(BRACE_L);
				setState(2652);
				maplet_pattern_list();
				setState(2653);
				match(BRACE_R);
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(2655);
				match(BRACE_L);
				setState(2656);
				match(SEP_maplet);
				setState(2657);
				match(BRACE_R);
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Maplet_pattern_listContext extends ParserRuleContext {
		public List<Maplet_patternContext> maplet_pattern() {
			return getRuleContexts(Maplet_patternContext.class);
		}
		public Maplet_patternContext maplet_pattern(int i) {
			return getRuleContext(Maplet_patternContext.class,i);
		}
		public List<TerminalNode> SEP_comma() { return getTokens(VDMParser.SEP_comma); }
		public TerminalNode SEP_comma(int i) {
			return getToken(VDMParser.SEP_comma, i);
		}
		public Maplet_pattern_listContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_maplet_pattern_list; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterMaplet_pattern_list(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitMaplet_pattern_list(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitMaplet_pattern_list(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Maplet_pattern_listContext maplet_pattern_list() throws RecognitionException {
		Maplet_pattern_listContext _localctx = new Maplet_pattern_listContext(_ctx, getState());
		enterRule(_localctx, 520, RULE_maplet_pattern_list);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2660);
			maplet_pattern();
			setState(2665);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==SEP_comma) {
				{
				{
				setState(2661);
				match(SEP_comma);
				setState(2662);
				maplet_pattern();
				}
				}
				setState(2667);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Maplet_patternContext extends ParserRuleContext {
		public List<PatternContext> pattern() {
			return getRuleContexts(PatternContext.class);
		}
		public PatternContext pattern(int i) {
			return getRuleContext(PatternContext.class,i);
		}
		public TerminalNode SEP_maplet() { return getToken(VDMParser.SEP_maplet, 0); }
		public Maplet_patternContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_maplet_pattern; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterMaplet_pattern(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitMaplet_pattern(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitMaplet_pattern(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Maplet_patternContext maplet_pattern() throws RecognitionException {
		Maplet_patternContext _localctx = new Maplet_patternContext(_ctx, getState());
		enterRule(_localctx, 522, RULE_maplet_pattern);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2668);
			pattern(0);
			setState(2669);
			match(SEP_maplet);
			setState(2670);
			pattern(0);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Map_union_patternContext extends ParserRuleContext {
		public List<PatternContext> pattern() {
			return getRuleContexts(PatternContext.class);
		}
		public PatternContext pattern(int i) {
			return getRuleContext(PatternContext.class,i);
		}
		public TerminalNode SLK_munion() { return getToken(VDMParser.SLK_munion, 0); }
		public Map_union_patternContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_map_union_pattern; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterMap_union_pattern(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitMap_union_pattern(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitMap_union_pattern(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Map_union_patternContext map_union_pattern() throws RecognitionException {
		Map_union_patternContext _localctx = new Map_union_patternContext(_ctx, getState());
		enterRule(_localctx, 524, RULE_map_union_pattern);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2672);
			pattern(0);
			setState(2673);
			match(SLK_munion);
			setState(2674);
			pattern(0);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Tupple_patternContext extends ParserRuleContext {
		public TerminalNode SLK_mk() { return getToken(VDMParser.SLK_mk, 0); }
		public TerminalNode PAREN_L() { return getToken(VDMParser.PAREN_L, 0); }
		public PatternContext pattern() {
			return getRuleContext(PatternContext.class,0);
		}
		public TerminalNode SEP_comma() { return getToken(VDMParser.SEP_comma, 0); }
		public Pattern_listContext pattern_list() {
			return getRuleContext(Pattern_listContext.class,0);
		}
		public TerminalNode PAREN_R() { return getToken(VDMParser.PAREN_R, 0); }
		public Tupple_patternContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_tupple_pattern; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterTupple_pattern(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitTupple_pattern(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitTupple_pattern(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Tupple_patternContext tupple_pattern() throws RecognitionException {
		Tupple_patternContext _localctx = new Tupple_patternContext(_ctx, getState());
		enterRule(_localctx, 526, RULE_tupple_pattern);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2676);
			match(SLK_mk);
			setState(2677);
			match(PAREN_L);
			setState(2678);
			pattern(0);
			setState(2679);
			match(SEP_comma);
			setState(2680);
			pattern_list();
			setState(2681);
			match(PAREN_R);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Record_patternContext extends ParserRuleContext {
		public Tight_record_nameContext tight_record_name() {
			return getRuleContext(Tight_record_nameContext.class,0);
		}
		public TerminalNode PAREN_L() { return getToken(VDMParser.PAREN_L, 0); }
		public Pattern_listContext pattern_list() {
			return getRuleContext(Pattern_listContext.class,0);
		}
		public TerminalNode PAREN_R() { return getToken(VDMParser.PAREN_R, 0); }
		public Record_patternContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_record_pattern; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterRecord_pattern(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitRecord_pattern(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitRecord_pattern(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Record_patternContext record_pattern() throws RecognitionException {
		Record_patternContext _localctx = new Record_patternContext(_ctx, getState());
		enterRule(_localctx, 528, RULE_record_pattern);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2683);
			tight_record_name();
			setState(2684);
			match(PAREN_L);
			setState(2685);
			pattern_list();
			setState(2686);
			match(PAREN_R);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Pp_object_patternContext extends ParserRuleContext {
		public TerminalNode PPK_obj() { return getToken(VDMParser.PPK_obj, 0); }
		public TerminalNode IDENTIFIER() { return getToken(VDMParser.IDENTIFIER, 0); }
		public TerminalNode PAREN_L() { return getToken(VDMParser.PAREN_L, 0); }
		public Field_pattern_listContext field_pattern_list() {
			return getRuleContext(Field_pattern_listContext.class,0);
		}
		public TerminalNode PAREN_R() { return getToken(VDMParser.PAREN_R, 0); }
		public Pp_object_patternContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_pp_object_pattern; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterPp_object_pattern(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitPp_object_pattern(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitPp_object_pattern(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Pp_object_patternContext pp_object_pattern() throws RecognitionException {
		Pp_object_patternContext _localctx = new Pp_object_patternContext(_ctx, getState());
		enterRule(_localctx, 530, RULE_pp_object_pattern);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2688);
			match(PPK_obj);
			setState(2689);
			match(IDENTIFIER);
			setState(2690);
			match(PAREN_L);
			setState(2691);
			field_pattern_list();
			setState(2692);
			match(PAREN_R);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Field_pattern_listContext extends ParserRuleContext {
		public List<Field_patternContext> field_pattern() {
			return getRuleContexts(Field_patternContext.class);
		}
		public Field_patternContext field_pattern(int i) {
			return getRuleContext(Field_patternContext.class,i);
		}
		public List<TerminalNode> SEP_comma() { return getTokens(VDMParser.SEP_comma); }
		public TerminalNode SEP_comma(int i) {
			return getToken(VDMParser.SEP_comma, i);
		}
		public Field_pattern_listContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_field_pattern_list; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterField_pattern_list(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitField_pattern_list(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitField_pattern_list(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Field_pattern_listContext field_pattern_list() throws RecognitionException {
		Field_pattern_listContext _localctx = new Field_pattern_listContext(_ctx, getState());
		enterRule(_localctx, 532, RULE_field_pattern_list);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2694);
			field_pattern();
			setState(2699);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==SEP_comma) {
				{
				{
				setState(2695);
				match(SEP_comma);
				setState(2696);
				field_pattern();
				}
				}
				setState(2701);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Field_patternContext extends ParserRuleContext {
		public TerminalNode IDENTIFIER() { return getToken(VDMParser.IDENTIFIER, 0); }
		public TerminalNode SEP_maplet() { return getToken(VDMParser.SEP_maplet, 0); }
		public PatternContext pattern() {
			return getRuleContext(PatternContext.class,0);
		}
		public Field_patternContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_field_pattern; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterField_pattern(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitField_pattern(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitField_pattern(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Field_patternContext field_pattern() throws RecognitionException {
		Field_patternContext _localctx = new Field_patternContext(_ctx, getState());
		enterRule(_localctx, 534, RULE_field_pattern);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2702);
			match(IDENTIFIER);
			setState(2703);
			match(SEP_maplet);
			setState(2704);
			pattern(0);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Pattern_listContext extends ParserRuleContext {
		public List<PatternContext> pattern() {
			return getRuleContexts(PatternContext.class);
		}
		public PatternContext pattern(int i) {
			return getRuleContext(PatternContext.class,i);
		}
		public List<TerminalNode> SEP_comma() { return getTokens(VDMParser.SEP_comma); }
		public TerminalNode SEP_comma(int i) {
			return getToken(VDMParser.SEP_comma, i);
		}
		public Pattern_listContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_pattern_list; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterPattern_list(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitPattern_list(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitPattern_list(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Pattern_listContext pattern_list() throws RecognitionException {
		Pattern_listContext _localctx = new Pattern_listContext(_ctx, getState());
		enterRule(_localctx, 536, RULE_pattern_list);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2706);
			pattern(0);
			setState(2711);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==SEP_comma) {
				{
				{
				setState(2707);
				match(SEP_comma);
				setState(2708);
				pattern(0);
				}
				}
				setState(2713);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Pattern_bindContext extends ParserRuleContext {
		public PatternContext pattern() {
			return getRuleContext(PatternContext.class,0);
		}
		public BindContext bind() {
			return getRuleContext(BindContext.class,0);
		}
		public Pattern_bindContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_pattern_bind; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterPattern_bind(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitPattern_bind(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitPattern_bind(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Pattern_bindContext pattern_bind() throws RecognitionException {
		Pattern_bindContext _localctx = new Pattern_bindContext(_ctx, getState());
		enterRule(_localctx, 538, RULE_pattern_bind);
		try {
			setState(2716);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,226,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(2714);
				pattern(0);
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(2715);
				bind();
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class BindContext extends ParserRuleContext {
		public Set_bindContext set_bind() {
			return getRuleContext(Set_bindContext.class,0);
		}
		public Seq_bindContext seq_bind() {
			return getRuleContext(Seq_bindContext.class,0);
		}
		public Type_bindContext type_bind() {
			return getRuleContext(Type_bindContext.class,0);
		}
		public BindContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_bind; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterBind(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitBind(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitBind(this);
			else return visitor.visitChildren(this);
		}
	}

	public final BindContext bind() throws RecognitionException {
		BindContext _localctx = new BindContext(_ctx, getState());
		enterRule(_localctx, 540, RULE_bind);
		try {
			setState(2721);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,227,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(2718);
				set_bind();
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(2719);
				seq_bind();
				}
				break;
			case 3:
				enterOuterAlt(_localctx, 3);
				{
				setState(2720);
				type_bind();
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Set_bindContext extends ParserRuleContext {
		public PatternContext pattern() {
			return getRuleContext(PatternContext.class,0);
		}
		public TerminalNode SLK_inset() { return getToken(VDMParser.SLK_inset, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public Set_bindContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_set_bind; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterSet_bind(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitSet_bind(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitSet_bind(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Set_bindContext set_bind() throws RecognitionException {
		Set_bindContext _localctx = new Set_bindContext(_ctx, getState());
		enterRule(_localctx, 542, RULE_set_bind);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2723);
			pattern(0);
			setState(2724);
			match(SLK_inset);
			setState(2725);
			expression(0);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Seq_bindContext extends ParserRuleContext {
		public PatternContext pattern() {
			return getRuleContext(PatternContext.class,0);
		}
		public TerminalNode SLK_inseq() { return getToken(VDMParser.SLK_inseq, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public Seq_bindContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_seq_bind; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterSeq_bind(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitSeq_bind(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitSeq_bind(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Seq_bindContext seq_bind() throws RecognitionException {
		Seq_bindContext _localctx = new Seq_bindContext(_ctx, getState());
		enterRule(_localctx, 544, RULE_seq_bind);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2727);
			pattern(0);
			setState(2728);
			match(SLK_inseq);
			setState(2729);
			expression(0);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Type_bindContext extends ParserRuleContext {
		public PatternContext pattern() {
			return getRuleContext(PatternContext.class,0);
		}
		public TerminalNode SEP_colon() { return getToken(VDMParser.SEP_colon, 0); }
		public TypeContext type() {
			return getRuleContext(TypeContext.class,0);
		}
		public Type_bindContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_type_bind; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterType_bind(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitType_bind(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitType_bind(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Type_bindContext type_bind() throws RecognitionException {
		Type_bindContext _localctx = new Type_bindContext(_ctx, getState());
		enterRule(_localctx, 546, RULE_type_bind);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2731);
			pattern(0);
			setState(2732);
			match(SEP_colon);
			setState(2733);
			type(0);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Bind_listContext extends ParserRuleContext {
		public List<Multiple_bindContext> multiple_bind() {
			return getRuleContexts(Multiple_bindContext.class);
		}
		public Multiple_bindContext multiple_bind(int i) {
			return getRuleContext(Multiple_bindContext.class,i);
		}
		public List<TerminalNode> SEP_comma() { return getTokens(VDMParser.SEP_comma); }
		public TerminalNode SEP_comma(int i) {
			return getToken(VDMParser.SEP_comma, i);
		}
		public Bind_listContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_bind_list; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterBind_list(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitBind_list(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitBind_list(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Bind_listContext bind_list() throws RecognitionException {
		Bind_listContext _localctx = new Bind_listContext(_ctx, getState());
		enterRule(_localctx, 548, RULE_bind_list);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2735);
			multiple_bind();
			setState(2740);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==SEP_comma) {
				{
				{
				setState(2736);
				match(SEP_comma);
				setState(2737);
				multiple_bind();
				}
				}
				setState(2742);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Multiple_bindContext extends ParserRuleContext {
		public Multiple_set_bindContext multiple_set_bind() {
			return getRuleContext(Multiple_set_bindContext.class,0);
		}
		public Multiple_seq_bindContext multiple_seq_bind() {
			return getRuleContext(Multiple_seq_bindContext.class,0);
		}
		public Multiple_type_bindContext multiple_type_bind() {
			return getRuleContext(Multiple_type_bindContext.class,0);
		}
		public Multiple_bindContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_multiple_bind; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterMultiple_bind(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitMultiple_bind(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitMultiple_bind(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Multiple_bindContext multiple_bind() throws RecognitionException {
		Multiple_bindContext _localctx = new Multiple_bindContext(_ctx, getState());
		enterRule(_localctx, 550, RULE_multiple_bind);
		try {
			setState(2746);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,229,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(2743);
				multiple_set_bind();
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(2744);
				multiple_seq_bind();
				}
				break;
			case 3:
				enterOuterAlt(_localctx, 3);
				{
				setState(2745);
				multiple_type_bind();
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Multiple_set_bindContext extends ParserRuleContext {
		public Pattern_listContext pattern_list() {
			return getRuleContext(Pattern_listContext.class,0);
		}
		public TerminalNode SLK_inset() { return getToken(VDMParser.SLK_inset, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public Multiple_set_bindContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_multiple_set_bind; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterMultiple_set_bind(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitMultiple_set_bind(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitMultiple_set_bind(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Multiple_set_bindContext multiple_set_bind() throws RecognitionException {
		Multiple_set_bindContext _localctx = new Multiple_set_bindContext(_ctx, getState());
		enterRule(_localctx, 552, RULE_multiple_set_bind);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2748);
			pattern_list();
			setState(2749);
			match(SLK_inset);
			setState(2750);
			expression(0);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Multiple_seq_bindContext extends ParserRuleContext {
		public Pattern_listContext pattern_list() {
			return getRuleContext(Pattern_listContext.class,0);
		}
		public TerminalNode SLK_inseq() { return getToken(VDMParser.SLK_inseq, 0); }
		public ExpressionContext expression() {
			return getRuleContext(ExpressionContext.class,0);
		}
		public Multiple_seq_bindContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_multiple_seq_bind; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterMultiple_seq_bind(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitMultiple_seq_bind(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitMultiple_seq_bind(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Multiple_seq_bindContext multiple_seq_bind() throws RecognitionException {
		Multiple_seq_bindContext _localctx = new Multiple_seq_bindContext(_ctx, getState());
		enterRule(_localctx, 554, RULE_multiple_seq_bind);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2752);
			pattern_list();
			setState(2753);
			match(SLK_inseq);
			setState(2754);
			expression(0);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Multiple_type_bindContext extends ParserRuleContext {
		public Pattern_listContext pattern_list() {
			return getRuleContext(Pattern_listContext.class,0);
		}
		public TerminalNode SEP_colon() { return getToken(VDMParser.SEP_colon, 0); }
		public TypeContext type() {
			return getRuleContext(TypeContext.class,0);
		}
		public Multiple_type_bindContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_multiple_type_bind; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterMultiple_type_bind(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitMultiple_type_bind(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitMultiple_type_bind(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Multiple_type_bindContext multiple_type_bind() throws RecognitionException {
		Multiple_type_bindContext _localctx = new Multiple_type_bindContext(_ctx, getState());
		enterRule(_localctx, 556, RULE_multiple_type_bind);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2756);
			pattern_list();
			setState(2757);
			match(SEP_colon);
			setState(2758);
			type(0);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Type_bind_listContext extends ParserRuleContext {
		public List<Type_bindContext> type_bind() {
			return getRuleContexts(Type_bindContext.class);
		}
		public Type_bindContext type_bind(int i) {
			return getRuleContext(Type_bindContext.class,i);
		}
		public List<TerminalNode> SEP_comma() { return getTokens(VDMParser.SEP_comma); }
		public TerminalNode SEP_comma(int i) {
			return getToken(VDMParser.SEP_comma, i);
		}
		public Type_bind_listContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_type_bind_list; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).enterType_bind_list(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof VDMListener ) ((VDMListener)listener).exitType_bind_list(this);
		}
		@Override
		public <T> T accept(ParseTreeVisitor<? extends T> visitor) {
			if ( visitor instanceof VDMVisitor ) return ((VDMVisitor<? extends T>)visitor).visitType_bind_list(this);
			else return visitor.visitChildren(this);
		}
	}

	public final Type_bind_listContext type_bind_list() throws RecognitionException {
		Type_bind_listContext _localctx = new Type_bind_listContext(_ctx, getState());
		enterRule(_localctx, 558, RULE_type_bind_list);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(2760);
			type_bind();
			setState(2765);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==SEP_comma) {
				{
				{
				setState(2761);
				match(SEP_comma);
				setState(2762);
				type_bind();
				}
				}
				setState(2767);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public boolean sempred(RuleContext _localctx, int ruleIndex, int predIndex) {
		switch (ruleIndex) {
		case 44:
			return type_sempred((TypeContext)_localctx, predIndex);
		case 145:
			return expression_sempred((ExpressionContext)_localctx, predIndex);
		case 173:
			return tight_record_name_sempred((Tight_record_nameContext)_localctx, predIndex);
		case 204:
			return state_designator_sempred((State_designatorContext)_localctx, predIndex);
		case 235:
			return object_designator_sempred((Object_designatorContext)_localctx, predIndex);
		case 252:
			return pattern_sempred((PatternContext)_localctx, predIndex);
		}
		return true;
	}
	private boolean type_sempred(TypeContext _localctx, int predIndex) {
		switch (predIndex) {
		case 0:
			return precpred(_ctx, 2);
		case 1:
			return precpred(_ctx, 1);
		case 2:
			return precpred(_ctx, 8);
		case 3:
			return precpred(_ctx, 7);
		}
		return true;
	}
	private boolean expression_sempred(ExpressionContext _localctx, int predIndex) {
		switch (predIndex) {
		case 4:
			return !isVDMSL();
		case 5:
			return isVDMRT();
		case 6:
			return !isVDMSL();
		case 7:
			return !isVDMSL();
		case 8:
			return !isVDMSL();
		case 9:
			return !isVDMSL();
		case 10:
			return isVDMRT();
		case 11:
			return isVDMRT();
		case 12:
			return isVDMRT();
		case 13:
			return isVDMRT();
		case 14:
			return isVDMRT();
		case 15:
			return isVDMRT();
		case 16:
			return !isVDMSL();
		case 17:
			return precpred(_ctx, 41);
		case 18:
			return precpred(_ctx, 40);
		case 19:
			return precpred(_ctx, 39);
		case 20:
			return precpred(_ctx, 38);
		case 21:
			return precpred(_ctx, 37);
		case 22:
			return precpred(_ctx, 36);
		case 23:
			return precpred(_ctx, 35);
		case 24:
			return precpred(_ctx, 34);
		case 25:
			return precpred(_ctx, 33);
		case 26:
			return precpred(_ctx, 32);
		case 27:
			return precpred(_ctx, 31);
		case 28:
			return precpred(_ctx, 30);
		case 29:
			return precpred(_ctx, 29);
		case 30:
			return precpred(_ctx, 28);
		case 31:
			return precpred(_ctx, 27);
		case 32:
			return precpred(_ctx, 26);
		case 33:
			return precpred(_ctx, 25);
		case 34:
			return precpred(_ctx, 24);
		case 35:
			return precpred(_ctx, 23);
		case 36:
			return precpred(_ctx, 22);
		case 37:
			return precpred(_ctx, 21);
		case 38:
			return precpred(_ctx, 20);
		case 39:
			return precpred(_ctx, 19);
		case 40:
			return precpred(_ctx, 18);
		case 41:
			return precpred(_ctx, 17);
		case 42:
			return precpred(_ctx, 16);
		case 43:
			return precpred(_ctx, 15);
		case 44:
			return precpred(_ctx, 14);
		case 45:
			return precpred(_ctx, 13);
		case 46:
			return precpred(_ctx, 12);
		case 47:
			return precpred(_ctx, 11);
		case 48:
			return precpred(_ctx, 10);
		case 49:
			return precpred(_ctx, 9);
		case 50:
			return precpred(_ctx, 8);
		case 51:
			return precpred(_ctx, 7);
		case 52:
			return precpred(_ctx, 6);
		case 53:
			return precpred(_ctx, 5);
		case 54:
			return precpred(_ctx, 4);
		}
		return true;
	}
	private boolean tight_record_name_sempred(Tight_record_nameContext _localctx, int predIndex) {
		switch (predIndex) {
		case 55:
			return (((Tight_record_nameContext)_localctx).first!=null?((Tight_record_nameContext)_localctx).first.getTokenIndex():0)+1 == (((Tight_record_nameContext)_localctx).second!=null?((Tight_record_nameContext)_localctx).second.getTokenIndex():0);
		}
		return true;
	}
	private boolean state_designator_sempred(State_designatorContext _localctx, int predIndex) {
		switch (predIndex) {
		case 56:
			return precpred(_ctx, 3);
		case 57:
			return precpred(_ctx, 2);
		}
		return true;
	}
	private boolean object_designator_sempred(Object_designatorContext _localctx, int predIndex) {
		switch (predIndex) {
		case 58:
			return precpred(_ctx, 5);
		case 59:
			return precpred(_ctx, 4);
		}
		return true;
	}
	private boolean pattern_sempred(PatternContext _localctx, int predIndex) {
		switch (predIndex) {
		case 60:
			return precpred(_ctx, 7);
		case 61:
			return precpred(_ctx, 5);
		case 62:
			return precpred(_ctx, 3);
		}
		return true;
	}

	private static final int _serializedATNSegments = 2;
	private static final String _serializedATNSegment0 =
		"\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\3\u00d8\u0ad3\4\2\t"+
		"\2\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b\t\b\4\t\t\t\4\n\t\n\4\13"+
		"\t\13\4\f\t\f\4\r\t\r\4\16\t\16\4\17\t\17\4\20\t\20\4\21\t\21\4\22\t\22"+
		"\4\23\t\23\4\24\t\24\4\25\t\25\4\26\t\26\4\27\t\27\4\30\t\30\4\31\t\31"+
		"\4\32\t\32\4\33\t\33\4\34\t\34\4\35\t\35\4\36\t\36\4\37\t\37\4 \t \4!"+
		"\t!\4\"\t\"\4#\t#\4$\t$\4%\t%\4&\t&\4\'\t\'\4(\t(\4)\t)\4*\t*\4+\t+\4"+
		",\t,\4-\t-\4.\t.\4/\t/\4\60\t\60\4\61\t\61\4\62\t\62\4\63\t\63\4\64\t"+
		"\64\4\65\t\65\4\66\t\66\4\67\t\67\48\t8\49\t9\4:\t:\4;\t;\4<\t<\4=\t="+
		"\4>\t>\4?\t?\4@\t@\4A\tA\4B\tB\4C\tC\4D\tD\4E\tE\4F\tF\4G\tG\4H\tH\4I"+
		"\tI\4J\tJ\4K\tK\4L\tL\4M\tM\4N\tN\4O\tO\4P\tP\4Q\tQ\4R\tR\4S\tS\4T\tT"+
		"\4U\tU\4V\tV\4W\tW\4X\tX\4Y\tY\4Z\tZ\4[\t[\4\\\t\\\4]\t]\4^\t^\4_\t_\4"+
		"`\t`\4a\ta\4b\tb\4c\tc\4d\td\4e\te\4f\tf\4g\tg\4h\th\4i\ti\4j\tj\4k\t"+
		"k\4l\tl\4m\tm\4n\tn\4o\to\4p\tp\4q\tq\4r\tr\4s\ts\4t\tt\4u\tu\4v\tv\4"+
		"w\tw\4x\tx\4y\ty\4z\tz\4{\t{\4|\t|\4}\t}\4~\t~\4\177\t\177\4\u0080\t\u0080"+
		"\4\u0081\t\u0081\4\u0082\t\u0082\4\u0083\t\u0083\4\u0084\t\u0084\4\u0085"+
		"\t\u0085\4\u0086\t\u0086\4\u0087\t\u0087\4\u0088\t\u0088\4\u0089\t\u0089"+
		"\4\u008a\t\u008a\4\u008b\t\u008b\4\u008c\t\u008c\4\u008d\t\u008d\4\u008e"+
		"\t\u008e\4\u008f\t\u008f\4\u0090\t\u0090\4\u0091\t\u0091\4\u0092\t\u0092"+
		"\4\u0093\t\u0093\4\u0094\t\u0094\4\u0095\t\u0095\4\u0096\t\u0096\4\u0097"+
		"\t\u0097\4\u0098\t\u0098\4\u0099\t\u0099\4\u009a\t\u009a\4\u009b\t\u009b"+
		"\4\u009c\t\u009c\4\u009d\t\u009d\4\u009e\t\u009e\4\u009f\t\u009f\4\u00a0"+
		"\t\u00a0\4\u00a1\t\u00a1\4\u00a2\t\u00a2\4\u00a3\t\u00a3\4\u00a4\t\u00a4"+
		"\4\u00a5\t\u00a5\4\u00a6\t\u00a6\4\u00a7\t\u00a7\4\u00a8\t\u00a8\4\u00a9"+
		"\t\u00a9\4\u00aa\t\u00aa\4\u00ab\t\u00ab\4\u00ac\t\u00ac\4\u00ad\t\u00ad"+
		"\4\u00ae\t\u00ae\4\u00af\t\u00af\4\u00b0\t\u00b0\4\u00b1\t\u00b1\4\u00b2"+
		"\t\u00b2\4\u00b3\t\u00b3\4\u00b4\t\u00b4\4\u00b5\t\u00b5\4\u00b6\t\u00b6"+
		"\4\u00b7\t\u00b7\4\u00b8\t\u00b8\4\u00b9\t\u00b9\4\u00ba\t\u00ba\4\u00bb"+
		"\t\u00bb\4\u00bc\t\u00bc\4\u00bd\t\u00bd\4\u00be\t\u00be\4\u00bf\t\u00bf"+
		"\4\u00c0\t\u00c0\4\u00c1\t\u00c1\4\u00c2\t\u00c2\4\u00c3\t\u00c3\4\u00c4"+
		"\t\u00c4\4\u00c5\t\u00c5\4\u00c6\t\u00c6\4\u00c7\t\u00c7\4\u00c8\t\u00c8"+
		"\4\u00c9\t\u00c9\4\u00ca\t\u00ca\4\u00cb\t\u00cb\4\u00cc\t\u00cc\4\u00cd"+
		"\t\u00cd\4\u00ce\t\u00ce\4\u00cf\t\u00cf\4\u00d0\t\u00d0\4\u00d1\t\u00d1"+
		"\4\u00d2\t\u00d2\4\u00d3\t\u00d3\4\u00d4\t\u00d4\4\u00d5\t\u00d5\4\u00d6"+
		"\t\u00d6\4\u00d7\t\u00d7\4\u00d8\t\u00d8\4\u00d9\t\u00d9\4\u00da\t\u00da"+
		"\4\u00db\t\u00db\4\u00dc\t\u00dc\4\u00dd\t\u00dd\4\u00de\t\u00de\4\u00df"+
		"\t\u00df\4\u00e0\t\u00e0\4\u00e1\t\u00e1\4\u00e2\t\u00e2\4\u00e3\t\u00e3"+
		"\4\u00e4\t\u00e4\4\u00e5\t\u00e5\4\u00e6\t\u00e6\4\u00e7\t\u00e7\4\u00e8"+
		"\t\u00e8\4\u00e9\t\u00e9\4\u00ea\t\u00ea\4\u00eb\t\u00eb\4\u00ec\t\u00ec"+
		"\4\u00ed\t\u00ed\4\u00ee\t\u00ee\4\u00ef\t\u00ef\4\u00f0\t\u00f0\4\u00f1"+
		"\t\u00f1\4\u00f2\t\u00f2\4\u00f3\t\u00f3\4\u00f4\t\u00f4\4\u00f5\t\u00f5"+
		"\4\u00f6\t\u00f6\4\u00f7\t\u00f7\4\u00f8\t\u00f8\4\u00f9\t\u00f9\4\u00fa"+
		"\t\u00fa\4\u00fb\t\u00fb\4\u00fc\t\u00fc\4\u00fd\t\u00fd\4\u00fe\t\u00fe"+
		"\4\u00ff\t\u00ff\4\u0100\t\u0100\4\u0101\t\u0101\4\u0102\t\u0102\4\u0103"+
		"\t\u0103\4\u0104\t\u0104\4\u0105\t\u0105\4\u0106\t\u0106\4\u0107\t\u0107"+
		"\4\u0108\t\u0108\4\u0109\t\u0109\4\u010a\t\u010a\4\u010b\t\u010b\4\u010c"+
		"\t\u010c\4\u010d\t\u010d\4\u010e\t\u010e\4\u010f\t\u010f\4\u0110\t\u0110"+
		"\4\u0111\t\u0111\4\u0112\t\u0112\4\u0113\t\u0113\4\u0114\t\u0114\4\u0115"+
		"\t\u0115\4\u0116\t\u0116\4\u0117\t\u0117\4\u0118\t\u0118\4\u0119\t\u0119"+
		"\3\2\6\2\u0234\n\2\r\2\16\2\u0235\3\2\6\2\u0239\n\2\r\2\16\2\u023a\5\2"+
		"\u023d\n\2\3\3\3\3\3\3\3\3\5\3\u0243\n\3\3\3\3\3\3\3\3\4\5\4\u0249\n\4"+
		"\3\4\3\4\3\5\3\5\3\5\3\5\7\5\u0251\n\5\f\5\16\5\u0254\13\5\3\6\3\6\3\6"+
		"\3\6\3\7\3\7\6\7\u025c\n\7\r\7\16\7\u025d\5\7\u0260\n\7\3\b\3\b\3\b\3"+
		"\b\5\b\u0266\n\b\3\t\3\t\3\t\3\t\7\t\u026c\n\t\f\t\16\t\u026f\13\t\3\t"+
		"\5\t\u0272\n\t\3\n\3\n\3\n\5\n\u0277\n\n\3\n\3\n\3\n\5\n\u027c\n\n\5\n"+
		"\u027e\n\n\3\13\3\13\3\13\3\13\7\13\u0284\n\13\f\13\16\13\u0287\13\13"+
		"\3\13\5\13\u028a\n\13\3\f\3\f\3\f\5\f\u028f\n\f\3\f\3\f\5\f\u0293\n\f"+
		"\3\r\3\r\3\r\3\r\7\r\u0299\n\r\f\r\16\r\u029c\13\r\3\r\5\r\u029f\n\r\3"+
		"\16\3\16\5\16\u02a3\n\16\3\16\3\16\5\16\u02a7\n\16\3\16\3\16\5\16\u02ab"+
		"\n\16\3\17\3\17\3\17\3\17\7\17\u02b1\n\17\f\17\16\17\u02b4\13\17\3\17"+
		"\5\17\u02b7\n\17\3\20\3\20\3\20\5\20\u02bc\n\20\3\20\3\20\5\20\u02c0\n"+
		"\20\3\21\3\21\3\21\3\22\3\22\6\22\u02c7\n\22\r\22\16\22\u02c8\5\22\u02cb"+
		"\n\22\3\23\3\23\3\23\3\23\5\23\u02d1\n\23\3\24\3\24\3\24\3\24\7\24\u02d7"+
		"\n\24\f\24\16\24\u02da\13\24\3\24\5\24\u02dd\n\24\3\25\5\25\u02e0\n\25"+
		"\3\25\3\25\3\26\3\26\3\26\3\26\7\26\u02e8\n\26\f\26\16\26\u02eb\13\26"+
		"\3\26\5\26\u02ee\n\26\3\27\3\27\3\27\3\27\3\30\3\30\3\30\3\30\7\30\u02f8"+
		"\n\30\f\30\16\30\u02fb\13\30\3\30\5\30\u02fe\n\30\3\31\3\31\5\31\u0302"+
		"\n\31\3\31\3\31\3\31\3\32\3\32\3\32\3\32\7\32\u030b\n\32\f\32\16\32\u030e"+
		"\13\32\3\32\3\32\3\33\3\33\3\33\3\33\3\34\3\34\6\34\u0318\n\34\r\34\16"+
		"\34\u0319\3\35\3\35\6\35\u031e\n\35\r\35\16\35\u031f\3\36\3\36\3\36\5"+
		"\36\u0325\n\36\3\36\3\36\3\36\3\37\3\37\6\37\u032c\n\37\r\37\16\37\u032d"+
		"\3 \3 \3 \5 \u0333\n \3 \5 \u0336\n \3 \3 \3 \3!\3!\3!\3!\7!\u033f\n!"+
		"\f!\16!\u0342\13!\3\"\3\"\6\"\u0346\n\"\r\"\16\"\u0347\3#\3#\3#\5#\u034d"+
		"\n#\3$\3$\3$\3$\3$\3$\5$\u0355\n$\3%\3%\3%\3%\3%\3%\5%\u035d\n%\3&\3&"+
		"\3&\3\'\5\'\u0363\n\'\3\'\5\'\u0366\n\'\5\'\u0368\n\'\3\'\5\'\u036b\n"+
		"\'\3\'\5\'\u036e\n\'\5\'\u0370\n\'\3\'\5\'\u0373\n\'\3(\3(\3)\3)\3)\5"+
		")\u037a\n)\3*\3*\3*\7*\u037f\n*\f*\16*\u0382\13*\3+\3+\3+\3,\3,\3,\3,"+
		"\3,\3,\3,\3,\6,\u038f\n,\r,\16,\u0390\3,\3,\3,\3,\6,\u0397\n,\r,\16,\u0398"+
		"\5,\u039b\n,\3-\5-\u039e\n-\3-\5-\u03a1\n-\3-\5-\u03a4\n-\3.\3.\3.\3."+
		"\3.\3.\3.\3.\3.\3.\3.\3.\5.\u03b2\n.\3.\3.\3.\3.\3.\3.\3.\3.\3.\6.\u03bd"+
		"\n.\r.\16.\u03be\3.\3.\3.\6.\u03c4\n.\r.\16.\u03c5\7.\u03c8\n.\f.\16."+
		"\u03cb\13.\3/\3/\3/\3/\3/\3\60\3\60\3\60\3\60\3\61\3\61\3\62\3\62\3\63"+
		"\3\63\3\63\3\63\6\63\u03de\n\63\r\63\16\63\u03df\3\63\3\63\3\64\3\64\3"+
		"\64\3\64\5\64\u03e8\n\64\3\64\5\64\u03eb\n\64\3\65\3\65\3\65\6\65\u03f0"+
		"\n\65\r\65\16\65\u03f1\3\66\3\66\3\66\6\66\u03f7\n\66\r\66\16\66\u03f8"+
		"\3\67\3\67\3\67\3\67\38\38\58\u0401\n8\39\39\39\3:\3:\3:\3;\3;\5;\u040b"+
		"\n;\3<\3<\3<\3=\3=\3=\3>\3>\5>\u0415\n>\3?\3?\3?\3?\3?\3@\3@\3@\3@\3@"+
		"\3A\3A\5A\u0423\nA\3B\3B\3B\3B\3C\3C\3C\3C\3D\3D\3D\5D\u0430\nD\3E\3E"+
		"\3F\3F\3G\3G\3G\3H\3H\3H\3H\3H\3I\3I\3I\3I\3I\3J\3J\3J\3J\3K\3K\3K\3K"+
		"\6K\u044b\nK\rK\16K\u044c\3K\5K\u0450\nK\3K\5K\u0453\nK\3K\3K\3K\3L\3"+
		"L\3L\3M\3M\3M\3M\7M\u045f\nM\fM\16M\u0462\13M\3M\5M\u0465\nM\5M\u0467"+
		"\nM\3N\3N\3N\3N\7N\u046d\nN\fN\16N\u0470\13N\3N\5N\u0473\nN\5N\u0475\n"+
		"N\3O\5O\u0478\nO\3O\3O\3P\3P\3P\5P\u047f\nP\3P\3P\3P\3Q\3Q\3Q\3R\3R\3"+
		"R\3S\5S\u048b\nS\3S\3S\3T\3T\3T\5T\u0492\nT\3U\3U\5U\u0496\nU\3U\3U\3"+
		"U\3U\6U\u049c\nU\rU\16U\u049d\3U\3U\3U\5U\u04a3\nU\3U\5U\u04a6\nU\3U\5"+
		"U\u04a9\nU\3V\3V\3V\3W\3W\3W\3X\3X\3X\3Y\3Y\5Y\u04b6\nY\3Y\3Y\3Y\5Y\u04bb"+
		"\nY\3Y\3Y\3Z\3Z\5Z\u04c1\nZ\3Z\3Z\3Z\5Z\u04c6\nZ\3Z\5Z\u04c9\nZ\3Z\5Z"+
		"\u04cc\nZ\3[\3[\3[\3[\7[\u04d2\n[\f[\16[\u04d5\13[\3[\3[\3\\\3\\\3\\\3"+
		"\\\3]\3]\3]\3]\3]\3]\3]\3]\7]\u04e5\n]\f]\16]\u04e8\13]\3^\3^\3^\7^\u04ed"+
		"\n^\f^\16^\u04f0\13^\3_\3_\3_\3_\3`\3`\5`\u04f8\n`\3`\3`\3a\3a\5a\u04fe"+
		"\na\3b\3b\5b\u0502\nb\3c\3c\3c\3d\5d\u0508\nd\3d\3d\3e\3e\3e\3f\3f\3f"+
		"\5f\u0512\nf\3f\3f\3g\3g\3g\3h\3h\3h\3h\5h\u051d\nh\3h\3h\3i\3i\3i\5i"+
		"\u0524\ni\3j\3j\3j\3j\3j\3j\3j\3j\5j\u052e\nj\3j\5j\u0531\nj\3k\3k\3k"+
		"\5k\u0536\nk\3k\3k\3l\5l\u053b\nl\3l\5l\u053e\nl\3l\3l\5l\u0542\nl\3m"+
		"\3m\3m\5m\u0547\nm\3m\3m\3m\5m\u054c\nm\3m\5m\u054f\nm\3m\5m\u0552\nm"+
		"\3m\5m\u0555\nm\3n\3n\3n\3n\3o\3o\5o\u055d\no\3p\3p\6p\u0561\np\rp\16"+
		"p\u0562\3q\3q\3q\3q\5q\u0569\nq\3r\3r\3s\3s\6s\u056f\ns\rs\16s\u0570\3"+
		"t\3t\3t\3t\3t\3t\3u\3u\3u\3u\3u\7u\u057e\nu\fu\16u\u0581\13u\5u\u0583"+
		"\nu\3v\3v\5v\u0587\nv\3w\5w\u058a\nw\3w\5w\u058d\nw\3w\5w\u0590\nw\3w"+
		"\5w\u0593\nw\5w\u0595\nw\3w\3w\3x\3x\3x\3y\3y\5y\u059e\ny\3z\3z\3{\3{"+
		"\3{\3{\3{\3{\5{\u05a8\n{\3|\3|\3|\3|\3|\3|\5|\u05b0\n|\3}\3}\5}\u05b4"+
		"\n}\3~\3~\5~\u05b8\n~\3\177\3\177\5\177\u05bc\n\177\3\u0080\3\u0080\3"+
		"\u0080\3\u0080\3\u0080\3\u0080\3\u0080\3\u0080\3\u0080\3\u0080\3\u0080"+
		"\3\u0080\3\u0080\3\u0080\3\u0081\3\u0081\3\u0081\3\u0081\3\u0081\3\u0081"+
		"\3\u0081\3\u0081\3\u0081\3\u0081\3\u0081\3\u0081\3\u0081\3\u0081\3\u0082"+
		"\3\u0082\3\u0083\3\u0083\7\u0083\u05de\n\u0083\f\u0083\16\u0083\u05e1"+
		"\13\u0083\3\u0084\3\u0084\3\u0084\7\u0084\u05e6\n\u0084\f\u0084\16\u0084"+
		"\u05e9\13\u0084\3\u0085\3\u0085\3\u0085\7\u0085\u05ee\n\u0085\f\u0085"+
		"\16\u0085\u05f1\13\u0085\3\u0085\3\u0085\3\u0085\3\u0086\3\u0086\3\u0086"+
		"\7\u0086\u05f9\n\u0086\f\u0086\16\u0086\u05fc\13\u0086\3\u0087\3\u0087"+
		"\3\u0087\7\u0087\u0601\n\u0087\f\u0087\16\u0087\u0604\13\u0087\3\u0088"+
		"\3\u0088\5\u0088\u0608\n\u0088\3\u0089\3\u0089\5\u0089\u060c\n\u0089\3"+
		"\u008a\3\u008a\3\u008a\3\u008a\3\u008a\3\u008b\3\u008b\3\u008b\3\u008b"+
		"\5\u008b\u0617\n\u008b\3\u008b\3\u008b\3\u008b\3\u008c\3\u008c\3\u008c"+
		"\3\u008c\3\u008c\3\u008c\3\u008c\3\u008c\5\u008c\u0624\n\u008c\3\u008c"+
		"\5\u008c\u0627\n\u008c\3\u008d\3\u008d\3\u008d\5\u008d\u062c\n\u008d\3"+
		"\u008e\3\u008e\3\u008f\3\u008f\3\u008f\3\u008f\3\u008f\3\u008f\3\u008f"+
		"\7\u008f\u0637\n\u008f\f\u008f\16\u008f\u063a\13\u008f\3\u008f\3\u008f"+
		"\3\u0090\3\u0090\3\u0090\3\u0090\3\u0091\3\u0091\3\u0091\3\u0091\3\u0091"+
		"\3\u0091\3\u0092\3\u0092\3\u0092\7\u0092\u064b\n\u0092\f\u0092\16\u0092"+
		"\u064e\13\u0092\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093"+
		"\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093"+
		"\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093"+
		"\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093"+
		"\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093"+
		"\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093"+
		"\3\u0093\3\u0093\5\u0093\u0686\n\u0093\3\u0093\3\u0093\3\u0093\3\u0093"+
		"\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093"+
		"\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\5\u0093\u069a\n\u0093\3\u0093"+
		"\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\7\u0093\u06a2\n\u0093\f\u0093"+
		"\16\u0093\u06a5\13\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093"+
		"\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093"+
		"\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093"+
		"\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093"+
		"\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093"+
		"\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093"+
		"\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093"+
		"\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093"+
		"\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093"+
		"\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093"+
		"\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093"+
		"\3\u0093\3\u0093\3\u0093\3\u0093\3\u0093\7\u0093\u070c\n\u0093\f\u0093"+
		"\16\u0093\u070f\13\u0093\3\u0094\3\u0094\3\u0094\3\u0094\3\u0095\3\u0095"+
		"\3\u0095\3\u0095\3\u0095\3\u0096\3\u0096\3\u0096\3\u0096\5\u0096\u071e"+
		"\n\u0096\3\u0096\3\u0096\3\u0096\3\u0097\3\u0097\3\u0097\3\u0097\3\u0097"+
		"\3\u0097\3\u0097\3\u0097\3\u0097\7\u0097\u072c\n\u0097\f\u0097\16\u0097"+
		"\u072f\13\u0097\3\u0097\5\u0097\u0732\n\u0097\3\u0097\3\u0097\3\u0097"+
		"\3\u0098\3\u0098\3\u0098\3\u0098\3\u0098\7\u0098\u073c\n\u0098\f\u0098"+
		"\16\u0098\u073f\13\u0098\3\u0098\3\u0098\3\u0098\3\u0099\3\u0099\3\u0099"+
		"\3\u0099\3\u0099\3\u009a\3\u009a\3\u009a\3\u009a\3\u009a\3\u009a\5\u009a"+
		"\u074f\n\u009a\3\u009a\3\u009a\3\u009b\3\u009b\3\u009b\7\u009b\u0756\n"+
		"\u009b\f\u009b\16\u009b\u0759\13\u009b\3\u009c\3\u009c\3\u009c\3\u009c"+
		"\3\u009d\3\u009d\3\u009d\3\u009d\3\u009e\3\u009e\3\u009e\3\u009e\3\u009e"+
		"\3\u009e\3\u009e\3\u009e\3\u009e\3\u009e\3\u009e\3\u009e\3\u009e\3\u009e"+
		"\3\u009e\3\u009e\3\u009e\3\u009e\3\u009e\3\u009e\3\u009e\3\u009e\3\u009e"+
		"\3\u009e\3\u009e\3\u009e\3\u009e\3\u009e\3\u009e\3\u009e\3\u009e\3\u009e"+
		"\3\u009e\3\u009e\3\u009e\3\u009e\3\u009e\3\u009e\3\u009e\3\u009e\5\u009e"+
		"\u078b\n\u009e\3\u009f\3\u009f\3\u009f\5\u009f\u0790\n\u009f\3\u00a0\3"+
		"\u00a0\3\u00a0\3\u00a0\3\u00a0\3\u00a1\3\u00a1\3\u00a1\3\u00a1\3\u00a1"+
		"\3\u00a2\3\u00a2\3\u00a2\3\u00a2\3\u00a2\3\u00a3\3\u00a3\3\u00a3\3\u00a3"+
		"\3\u00a3\3\u00a4\3\u00a4\3\u00a4\3\u00a4\3\u00a5\3\u00a5\3\u00a5\3\u00a5"+
		"\3\u00a5\3\u00a5\5\u00a5\u07b0\n\u00a5\3\u00a5\3\u00a5\3\u00a6\3\u00a6"+
		"\3\u00a6\3\u00a6\3\u00a6\3\u00a6\3\u00a6\3\u00a6\3\u00a7\3\u00a7\3\u00a7"+
		"\3\u00a7\3\u00a8\3\u00a8\3\u00a8\3\u00a8\3\u00a8\3\u00a8\5\u00a8\u07c6"+
		"\n\u00a8\3\u00a8\3\u00a8\3\u00a9\3\u00a9\3\u00a9\3\u00a9\3\u00a9\3\u00a9"+
		"\3\u00a9\3\u00a9\3\u00a9\3\u00aa\3\u00aa\3\u00aa\3\u00aa\5\u00aa\u07d7"+
		"\n\u00aa\3\u00aa\3\u00aa\3\u00aa\3\u00aa\3\u00aa\5\u00aa\u07de\n\u00aa"+
		"\3\u00ab\3\u00ab\3\u00ab\3\u00ab\3\u00ac\3\u00ac\3\u00ac\3\u00ac\3\u00ac"+
		"\3\u00ac\5\u00ac\u07ea\n\u00ac\3\u00ac\3\u00ac\3\u00ad\3\u00ad\3\u00ad"+
		"\3\u00ad\3\u00ad\3\u00ad\3\u00ad\3\u00ae\3\u00ae\3\u00ae\5\u00ae\u07f8"+
		"\n\u00ae\3\u00ae\3\u00ae\3\u00af\3\u00af\3\u00af\3\u00af\5\u00af\u0800"+
		"\n\u00af\3\u00af\3\u00af\3\u00b0\3\u00b0\3\u00b0\3\u00b0\3\u00b0\3\u00b0"+
		"\3\u00b0\7\u00b0\u080b\n\u00b0\f\u00b0\16\u00b0\u080e\13\u00b0\3\u00b0"+
		"\3\u00b0\3\u00b1\3\u00b1\3\u00b1\3\u00b1\3\u00b2\3\u00b2\3\u00b2\5\u00b2"+
		"\u0819\n\u00b2\3\u00b2\3\u00b2\3\u00b3\3\u00b3\3\u00b3\3\u00b3\3\u00b4"+
		"\3\u00b4\3\u00b4\3\u00b4\3\u00b5\3\u00b5\3\u00b5\3\u00b5\3\u00b5\7\u00b5"+
		"\u082a\n\u00b5\f\u00b5\16\u00b5\u082d\13\u00b5\3\u00b5\3\u00b5\3\u00b6"+
		"\3\u00b6\3\u00b6\3\u00b6\3\u00b6\3\u00b7\3\u00b7\3\u00b7\3\u00b7\3\u00b7"+
		"\3\u00b7\3\u00b7\3\u00b8\3\u00b8\3\u00b8\3\u00b8\5\u00b8\u0841\n\u00b8"+
		"\3\u00b8\3\u00b8\3\u00b9\3\u00b9\3\u00ba\3\u00ba\3\u00bb\3\u00bb\5\u00bb"+
		"\u084b\n\u00bb\3\u00bc\3\u00bc\3\u00bc\5\u00bc\u0850\n\u00bc\3\u00bc\3"+
		"\u00bc\3\u00bc\3\u00bc\3\u00bd\3\u00bd\3\u00bd\3\u00bd\3\u00bd\3\u00bd"+
		"\3\u00bd\3\u00be\3\u00be\3\u00bf\3\u00bf\3\u00bf\3\u00bf\3\u00bf\3\u00bf"+
		"\3\u00c0\3\u00c0\3\u00c0\3\u00c0\3\u00c0\3\u00c0\3\u00c0\3\u00c0\3\u00c1"+
		"\3\u00c1\3\u00c1\3\u00c1\3\u00c1\3\u00c1\3\u00c1\3\u00c2\3\u00c2\3\u00c2"+
		"\3\u00c2\3\u00c2\3\u00c2\3\u00c2\3\u00c3\3\u00c3\3\u00c3\3\u00c3\3\u00c3"+
		"\3\u00c3\3\u00c3\3\u00c4\3\u00c4\3\u00c4\3\u00c4\3\u00c4\3\u00c5\3\u00c5"+
		"\3\u00c5\3\u00c5\3\u00c5\3\u00c6\3\u00c6\3\u00c6\3\u00c6\3\u00c6\3\u00c7"+
		"\3\u00c7\3\u00c7\3\u00c7\3\u00c7\3\u00c8\3\u00c8\3\u00c8\3\u00c8\3\u00c8"+
		"\3\u00c9\3\u00c9\3\u00ca\3\u00ca\3\u00ca\7\u00ca\u08a0\n\u00ca\f\u00ca"+
		"\16\u00ca\u08a3\13\u00ca\3\u00cb\3\u00cb\3\u00cb\5\u00cb\u08a8\n\u00cb"+
		"\3\u00cc\3\u00cc\3\u00cc\3\u00cd\3\u00cd\3\u00ce\3\u00ce\3\u00ce\3\u00ce"+
		"\3\u00ce\3\u00ce\3\u00ce\3\u00ce\3\u00ce\3\u00ce\3\u00ce\7\u00ce\u08ba"+
		"\n\u00ce\f\u00ce\16\u00ce\u08bd\13\u00ce\3\u00cf\3\u00cf\3\u00cf\3\u00cf"+
		"\3\u00d0\3\u00d0\3\u00d0\3\u00d0\3\u00d0\3\u00d1\3\u00d1\3\u00d1\3\u00d1"+
		"\3\u00d1\3\u00d1\3\u00d1\3\u00d1\3\u00d1\3\u00d1\3\u00d1\3\u00d1\3\u00d1"+
		"\3\u00d1\3\u00d1\3\u00d1\3\u00d1\3\u00d1\3\u00d1\3\u00d1\3\u00d1\3\u00d1"+
		"\3\u00d1\3\u00d1\3\u00d1\3\u00d1\3\u00d1\5\u00d1\u08e3\n\u00d1\3\u00d2"+
		"\3\u00d2\3\u00d2\3\u00d2\3\u00d2\3\u00d3\3\u00d3\3\u00d3\7\u00d3\u08ed"+
		"\n\u00d3\f\u00d3\16\u00d3\u08f0\13\u00d3\3\u00d4\3\u00d4\5\u00d4\u08f4"+
		"\n\u00d4\3\u00d5\3\u00d5\3\u00d5\3\u00d5\5\u00d5\u08fa\n\u00d5\3\u00d5"+
		"\3\u00d5\3\u00d5\3\u00d6\3\u00d6\3\u00d6\5\u00d6\u0902\n\u00d6\3\u00d6"+
		"\3\u00d6\3\u00d6\3\u00d7\3\u00d7\3\u00d7\7\u00d7\u090a\n\u00d7\f\u00d7"+
		"\16\u00d7\u090d\13\u00d7\3\u00d8\3\u00d8\3\u00d8\3\u00d8\3\u00d9\3\u00d9"+
		"\7\u00d9\u0915\n\u00d9\f\u00d9\16\u00d9\u0918\13\u00d9\3\u00d9\3\u00d9"+
		"\3\u00d9\7\u00d9\u091d\n\u00d9\f\u00d9\16\u00d9\u0920\13\u00d9\3\u00d9"+
		"\5\u00d9\u0923\n\u00d9\3\u00d9\3\u00d9\3\u00da\3\u00da\3\u00da\3\u00da"+
		"\7\u00da\u092b\n\u00da\f\u00da\16\u00da\u092e\13\u00da\3\u00da\3\u00da"+
		"\3\u00db\3\u00db\3\u00db\3\u00db\3\u00db\5\u00db\u0937\n\u00db\3\u00dc"+
		"\3\u00dc\5\u00dc\u093b\n\u00dc\3\u00dd\3\u00dd\3\u00dd\3\u00dd\3\u00de"+
		"\3\u00de\3\u00de\3\u00de\3\u00de\3\u00de\3\u00de\7\u00de\u0948\n\u00de"+
		"\f\u00de\16\u00de\u094b\13\u00de\3\u00de\5\u00de\u094e\n\u00de\3\u00de"+
		"\3\u00de\3\u00df\3\u00df\3\u00df\3\u00df\3\u00df\7\u00df\u0957\n\u00df"+
		"\f\u00df\16\u00df\u095a\13\u00df\3\u00df\3\u00df\3\u00df\3\u00e0\3\u00e0"+
		"\3\u00e0\3\u00e0\3\u00e0\3\u00e1\3\u00e1\3\u00e1\3\u00e1\3\u00e1\3\u00e1"+
		"\5\u00e1\u096a\n\u00e1\3\u00e1\3\u00e1\3\u00e2\3\u00e2\3\u00e2\7\u00e2"+
		"\u0971\n\u00e2\f\u00e2\16\u00e2\u0974\13\u00e2\3\u00e3\3\u00e3\3\u00e3"+
		"\3\u00e3\3\u00e4\3\u00e4\3\u00e4\3\u00e4\3\u00e5\3\u00e5\3\u00e5\3\u00e5"+
		"\3\u00e5\3\u00e5\3\u00e5\3\u00e6\3\u00e6\3\u00e6\3\u00e6\3\u00e6\3\u00e6"+
		"\3\u00e6\3\u00e6\3\u00e7\3\u00e7\3\u00e7\3\u00e7\3\u00e7\3\u00e7\3\u00e7"+
		"\3\u00e7\5\u00e7\u0995\n\u00e7\3\u00e7\3\u00e7\3\u00e7\3\u00e8\3\u00e8"+
		"\3\u00e8\3\u00e8\3\u00e8\3\u00e9\3\u00e9\3\u00e9\3\u00e9\3\u00e9\7\u00e9"+
		"\u09a4\n\u00e9\f\u00e9\16\u00e9\u09a7\13\u00e9\3\u00e9\3\u00e9\3\u00ea"+
		"\3\u00ea\3\u00ea\5\u00ea\u09ae\n\u00ea\3\u00ea\3\u00ea\3\u00eb\3\u00eb"+
		"\5\u00eb\u09b4\n\u00eb\3\u00ec\3\u00ec\3\u00ec\5\u00ec\u09b9\n\u00ec\3"+
		"\u00ec\3\u00ec\3\u00ed\3\u00ed\3\u00ed\3\u00ed\5\u00ed\u09c1\n\u00ed\3"+
		"\u00ed\3\u00ed\3\u00ed\5\u00ed\u09c6\n\u00ed\3\u00ed\3\u00ed\3\u00ed\3"+
		"\u00ed\7\u00ed\u09cc\n\u00ed\f\u00ed\16\u00ed\u09cf\13\u00ed\3\u00ee\3"+
		"\u00ee\3\u00ee\3\u00ee\3\u00ef\3\u00ef\3\u00ef\5\u00ef\u09d8\n\u00ef\3"+
		"\u00ef\3\u00ef\3\u00f0\3\u00f0\3\u00f0\3\u00f0\3\u00f1\3\u00f1\3\u00f1"+
		"\3\u00f1\3\u00f1\3\u00f2\3\u00f2\3\u00f2\3\u00f2\3\u00f2\3\u00f3\3\u00f3"+
		"\3\u00f3\3\u00f3\3\u00f3\3\u00f4\3\u00f4\3\u00f4\3\u00f4\3\u00f4\3\u00f5"+
		"\3\u00f5\3\u00f5\3\u00f5\3\u00f5\3\u00f5\3\u00f6\3\u00f6\3\u00f6\3\u00f6"+
		"\3\u00f6\3\u00f6\3\u00f7\3\u00f7\3\u00f7\3\u00f7\3\u00f7\3\u00f8\3\u00f8"+
		"\3\u00f8\3\u00f8\3\u00f8\3\u00f8\3\u00f8\3\u00f9\3\u00f9\3\u00f9\3\u00f9"+
		"\3\u00f9\3\u00fa\3\u00fa\3\u00fa\3\u00fa\3\u00fa\3\u00fa\3\u00fa\3\u00fa"+
		"\3\u00fa\7\u00fa\u0a1a\n\u00fa\f\u00fa\16\u00fa\u0a1d\13\u00fa\3\u00fa"+
		"\3\u00fa\3\u00fb\3\u00fb\5\u00fb\u0a23\n\u00fb\3\u00fc\3\u00fc\3\u00fd"+
		"\3\u00fd\3\u00fe\3\u00fe\3\u00fe\3\u00fe\3\u00fe\3\u00fe\3\u00fe\3\u00fe"+
		"\5\u00fe\u0a31\n\u00fe\3\u00fe\3\u00fe\3\u00fe\3\u00fe\3\u00fe\3\u00fe"+
		"\3\u00fe\3\u00fe\3\u00fe\7\u00fe\u0a3c\n\u00fe\f\u00fe\16\u00fe\u0a3f"+
		"\13\u00fe\3\u00ff\3\u00ff\3\u0100\3\u0100\3\u0100\3\u0100\3\u0100\5\u0100"+
		"\u0a48\n\u0100\3\u0101\3\u0101\5\u0101\u0a4c\n\u0101\3\u0101\3\u0101\3"+
		"\u0102\3\u0102\3\u0102\3\u0102\3\u0103\3\u0103\5\u0103\u0a56\n\u0103\3"+
		"\u0103\3\u0103\3\u0104\3\u0104\3\u0104\3\u0104\3\u0105\3\u0105\3\u0105"+
		"\3\u0105\3\u0105\3\u0105\3\u0105\5\u0105\u0a65\n\u0105\3\u0106\3\u0106"+
		"\3\u0106\7\u0106\u0a6a\n\u0106\f\u0106\16\u0106\u0a6d\13\u0106\3\u0107"+
		"\3\u0107\3\u0107\3\u0107\3\u0108\3\u0108\3\u0108\3\u0108\3\u0109\3\u0109"+
		"\3\u0109\3\u0109\3\u0109\3\u0109\3\u0109\3\u010a\3\u010a\3\u010a\3\u010a"+
		"\3\u010a\3\u010b\3\u010b\3\u010b\3\u010b\3\u010b\3\u010b\3\u010c\3\u010c"+
		"\3\u010c\7\u010c\u0a8c\n\u010c\f\u010c\16\u010c\u0a8f\13\u010c\3\u010d"+
		"\3\u010d\3\u010d\3\u010d\3\u010e\3\u010e\3\u010e\7\u010e\u0a98\n\u010e"+
		"\f\u010e\16\u010e\u0a9b\13\u010e\3\u010f\3\u010f\5\u010f\u0a9f\n\u010f"+
		"\3\u0110\3\u0110\3\u0110\5\u0110\u0aa4\n\u0110\3\u0111\3\u0111\3\u0111"+
		"\3\u0111\3\u0112\3\u0112\3\u0112\3\u0112\3\u0113\3\u0113\3\u0113\3\u0113"+
		"\3\u0114\3\u0114\3\u0114\7\u0114\u0ab5\n\u0114\f\u0114\16\u0114\u0ab8"+
		"\13\u0114\3\u0115\3\u0115\3\u0115\5\u0115\u0abd\n\u0115\3\u0116\3\u0116"+
		"\3\u0116\3\u0116\3\u0117\3\u0117\3\u0117\3\u0117\3\u0118\3\u0118\3\u0118"+
		"\3\u0118\3\u0119\3\u0119\3\u0119\7\u0119\u0ace\n\u0119\f\u0119\16\u0119"+
		"\u0ad1\13\u0119\3\u0119\2\7Z\u0124\u019a\u01d8\u01fa\u011a\2\4\6\b\n\f"+
		"\16\20\22\24\26\30\32\34\36 \"$&(*,.\60\62\64\668:<>@BDFHJLNPRTVXZ\\^"+
		"`bdfhjlnprtvxz|~\u0080\u0082\u0084\u0086\u0088\u008a\u008c\u008e\u0090"+
		"\u0092\u0094\u0096\u0098\u009a\u009c\u009e\u00a0\u00a2\u00a4\u00a6\u00a8"+
		"\u00aa\u00ac\u00ae\u00b0\u00b2\u00b4\u00b6\u00b8\u00ba\u00bc\u00be\u00c0"+
		"\u00c2\u00c4\u00c6\u00c8\u00ca\u00cc\u00ce\u00d0\u00d2\u00d4\u00d6\u00d8"+
		"\u00da\u00dc\u00de\u00e0\u00e2\u00e4\u00e6\u00e8\u00ea\u00ec\u00ee\u00f0"+
		"\u00f2\u00f4\u00f6\u00f8\u00fa\u00fc\u00fe\u0100\u0102\u0104\u0106\u0108"+
		"\u010a\u010c\u010e\u0110\u0112\u0114\u0116\u0118\u011a\u011c\u011e\u0120"+
		"\u0122\u0124\u0126\u0128\u012a\u012c\u012e\u0130\u0132\u0134\u0136\u0138"+
		"\u013a\u013c\u013e\u0140\u0142\u0144\u0146\u0148\u014a\u014c\u014e\u0150"+
		"\u0152\u0154\u0156\u0158\u015a\u015c\u015e\u0160\u0162\u0164\u0166\u0168"+
		"\u016a\u016c\u016e\u0170\u0172\u0174\u0176\u0178\u017a\u017c\u017e\u0180"+
		"\u0182\u0184\u0186\u0188\u018a\u018c\u018e\u0190\u0192\u0194\u0196\u0198"+
		"\u019a\u019c\u019e\u01a0\u01a2\u01a4\u01a6\u01a8\u01aa\u01ac\u01ae\u01b0"+
		"\u01b2\u01b4\u01b6\u01b8\u01ba\u01bc\u01be\u01c0\u01c2\u01c4\u01c6\u01c8"+
		"\u01ca\u01cc\u01ce\u01d0\u01d2\u01d4\u01d6\u01d8\u01da\u01dc\u01de\u01e0"+
		"\u01e2\u01e4\u01e6\u01e8\u01ea\u01ec\u01ee\u01f0\u01f2\u01f4\u01f6\u01f8"+
		"\u01fa\u01fc\u01fe\u0200\u0202\u0204\u0206\u0208\u020a\u020c\u020e\u0210"+
		"\u0212\u0214\u0216\u0218\u021a\u021c\u021e\u0220\u0222\u0224\u0226\u0228"+
		"\u022a\u022c\u022e\u0230\2\b\3\2\u0080\u0082\3\2\u00ba\u00bb\t\2\23\23"+
		"\27\27::MN[[]]kk\4\2\\\\uu\7\2//OOnn\u00cc\u00cc\u00ce\u00d0\4\2\u00ae"+
		"\u00ae\u00d1\u00d1\2\u0b45\2\u023c\3\2\2\2\4\u023e\3\2\2\2\6\u0248\3\2"+
		"\2\2\b\u024c\3\2\2\2\n\u0255\3\2\2\2\f\u025f\3\2\2\2\16\u0265\3\2\2\2"+
		"\20\u0267\3\2\2\2\22\u027d\3\2\2\2\24\u027f\3\2\2\2\26\u028b\3\2\2\2\30"+
		"\u0294\3\2\2\2\32\u02a0\3\2\2\2\34\u02ac\3\2\2\2\36\u02b8\3\2\2\2 \u02c1"+
		"\3\2\2\2\"\u02ca\3\2\2\2$\u02d0\3\2\2\2&\u02d2\3\2\2\2(\u02df\3\2\2\2"+
		"*\u02e3\3\2\2\2,\u02ef\3\2\2\2.\u02f3\3\2\2\2\60\u02ff\3\2\2\2\62\u0306"+
		"\3\2\2\2\64\u0311\3\2\2\2\66\u0315\3\2\2\28\u031d\3\2\2\2:\u0321\3\2\2"+
		"\2<\u0329\3\2\2\2>\u032f\3\2\2\2@\u033a\3\2\2\2B\u0343\3\2\2\2D\u034c"+
		"\3\2\2\2F\u0354\3\2\2\2H\u035c\3\2\2\2J\u035e\3\2\2\2L\u0372\3\2\2\2N"+
		"\u0374\3\2\2\2P\u0376\3\2\2\2R\u037b\3\2\2\2T\u0383\3\2\2\2V\u039a\3\2"+
		"\2\2X\u039d\3\2\2\2Z\u03b1\3\2\2\2\\\u03cc\3\2\2\2^\u03d1\3\2\2\2`\u03d5"+
		"\3\2\2\2b\u03d7\3\2\2\2d\u03d9\3\2\2\2f\u03ea\3\2\2\2h\u03ec\3\2\2\2j"+
		"\u03f3\3\2\2\2l\u03fa\3\2\2\2n\u0400\3\2\2\2p\u0402\3\2\2\2r\u0405\3\2"+
		"\2\2t\u040a\3\2\2\2v\u040c\3\2\2\2x\u040f\3\2\2\2z\u0414\3\2\2\2|\u0416"+
		"\3\2\2\2~\u041b\3\2\2\2\u0080\u0422\3\2\2\2\u0082\u0424\3\2\2\2\u0084"+
		"\u0428\3\2\2\2\u0086\u042f\3\2\2\2\u0088\u0431\3\2\2\2\u008a\u0433\3\2"+
		"\2\2\u008c\u0435\3\2\2\2\u008e\u0438\3\2\2\2\u0090\u043d\3\2\2\2\u0092"+
		"\u0442\3\2\2\2\u0094\u0446\3\2\2\2\u0096\u0457\3\2\2\2\u0098\u045a\3\2"+
		"\2\2\u009a\u0468\3\2\2\2\u009c\u0477\3\2\2\2\u009e\u047b\3\2\2\2\u00a0"+
		"\u0483\3\2\2\2\u00a2\u0486\3\2\2\2\u00a4\u048a\3\2\2\2\u00a6\u0491\3\2"+
		"\2\2\u00a8\u0493\3\2\2\2\u00aa\u04aa\3\2\2\2\u00ac\u04ad\3\2\2\2\u00ae"+
		"\u04b0\3\2\2\2\u00b0\u04b3\3\2\2\2\u00b2\u04be\3\2\2\2\u00b4\u04cd\3\2"+
		"\2\2\u00b6\u04d8\3\2\2\2\u00b8\u04dc\3\2\2\2\u00ba\u04e9\3\2\2\2\u00bc"+
		"\u04f1\3\2\2\2\u00be\u04f5\3\2\2\2\u00c0\u04fd\3\2\2\2\u00c2\u0501\3\2"+
		"\2\2\u00c4\u0503\3\2\2\2\u00c6\u0507\3\2\2\2\u00c8\u050b\3\2\2\2\u00ca"+
		"\u0511\3\2\2\2\u00cc\u0515\3\2\2\2\u00ce\u051c\3\2\2\2\u00d0\u0523\3\2"+
		"\2\2\u00d2\u0525\3\2\2\2\u00d4\u0532\3\2\2\2\u00d6\u053a\3\2\2\2\u00d8"+
		"\u0543\3\2\2\2\u00da\u0556\3\2\2\2\u00dc\u055c\3\2\2\2\u00de\u055e\3\2"+
		"\2\2\u00e0\u0564\3\2\2\2\u00e2\u056a\3\2\2\2\u00e4\u056c\3\2\2\2\u00e6"+
		"\u0572\3\2\2\2\u00e8\u0578\3\2\2\2\u00ea\u0586\3\2\2\2\u00ec\u0594\3\2"+
		"\2\2\u00ee\u0598\3\2\2\2\u00f0\u059b\3\2\2\2\u00f2\u059f\3\2\2\2\u00f4"+
		"\u05a7\3\2\2\2\u00f6\u05af\3\2\2\2\u00f8\u05b1\3\2\2\2\u00fa\u05b7\3\2"+
		"\2\2\u00fc\u05bb\3\2\2\2\u00fe\u05bd\3\2\2\2\u0100\u05cb\3\2\2\2\u0102"+
		"\u05d9\3\2\2\2\u0104\u05db\3\2\2\2\u0106\u05e2\3\2\2\2\u0108\u05ea\3\2"+
		"\2\2\u010a\u05f5\3\2\2\2\u010c\u05fd\3\2\2\2\u010e\u0607\3\2\2\2\u0110"+
		"\u060b\3\2\2\2\u0112\u060d\3\2\2\2\u0114\u0612\3\2\2\2\u0116\u061b\3\2"+
		"\2\2\u0118\u062b\3\2\2\2\u011a\u062d\3\2\2\2\u011c\u062f\3\2\2\2\u011e"+
		"\u063d\3\2\2\2\u0120\u0641\3\2\2\2\u0122\u0647\3\2\2\2\u0124\u0685\3\2"+
		"\2\2\u0126\u0710\3\2\2\2\u0128\u0714\3\2\2\2\u012a\u0719\3\2\2\2\u012c"+
		"\u0722\3\2\2\2\u012e\u0736\3\2\2\2\u0130\u0743\3\2\2\2\u0132\u0748\3\2"+
		"\2\2\u0134\u0752\3\2\2\2\u0136\u075a\3\2\2\2\u0138\u075e\3\2\2\2\u013a"+
		"\u078a\3\2\2\2\u013c\u078f\3\2\2\2\u013e\u0791\3\2\2\2\u0140\u0796\3\2"+
		"\2\2\u0142\u079b\3\2\2\2\u0144\u07a0\3\2\2\2\u0146\u07a5\3\2\2\2\u0148"+
		"\u07a9\3\2\2\2\u014a\u07b3\3\2\2\2\u014c\u07bb\3\2\2\2\u014e\u07bf\3\2"+
		"\2\2\u0150\u07c9\3\2\2\2\u0152\u07dd\3\2\2\2\u0154\u07df\3\2\2\2\u0156"+
		"\u07e3\3\2\2\2\u0158\u07ed\3\2\2\2\u015a\u07f4\3\2\2\2\u015c\u07fb\3\2"+
		"\2\2\u015e\u0803\3\2\2\2\u0160\u0811\3\2\2\2\u0162\u0815\3\2\2\2\u0164"+
		"\u081c\3\2\2\2\u0166\u0820\3\2\2\2\u0168\u0824\3\2\2\2\u016a\u0830\3\2"+
		"\2\2\u016c\u0835\3\2\2\2\u016e\u083c\3\2\2\2\u0170\u0844\3\2\2\2\u0172"+
		"\u0846\3\2\2\2\u0174\u084a\3\2\2\2\u0176\u084c\3\2\2\2\u0178\u0855\3\2"+
		"\2\2\u017a\u085c\3\2\2\2\u017c\u085e\3\2\2\2\u017e\u0864\3\2\2\2\u0180"+
		"\u086c\3\2\2\2\u0182\u0873\3\2\2\2\u0184\u087a\3\2\2\2\u0186\u0881\3\2"+
		"\2\2\u0188\u0886\3\2\2\2\u018a\u088b\3\2\2\2\u018c\u0890\3\2\2\2\u018e"+
		"\u0895\3\2\2\2\u0190\u089a\3\2\2\2\u0192\u089c\3\2\2\2\u0194\u08a4\3\2"+
		"\2\2\u0196\u08a9\3\2\2\2\u0198\u08ac\3\2\2\2\u019a\u08ae\3\2\2\2\u019c"+
		"\u08be\3\2\2\2\u019e\u08c2\3\2\2\2\u01a0\u08e2\3\2\2\2\u01a2\u08e4\3\2"+
		"\2\2\u01a4\u08e9\3\2\2\2\u01a6\u08f3\3\2\2\2\u01a8\u08f5\3\2\2\2\u01aa"+
		"\u08fe\3\2\2\2\u01ac\u0906\3\2\2\2\u01ae\u090e\3\2\2\2\u01b0\u0912\3\2"+
		"\2\2\u01b2\u0926\3\2\2\2\u01b4\u0931\3\2\2\2\u01b6\u093a\3\2\2\2\u01b8"+
		"\u093c\3\2\2\2\u01ba\u0940\3\2\2\2\u01bc\u0951\3\2\2\2\u01be\u095e\3\2"+
		"\2\2\u01c0\u0963\3\2\2\2\u01c2\u096d\3\2\2\2\u01c4\u0975\3\2\2\2\u01c6"+
		"\u0979\3\2\2\2\u01c8\u097d\3\2\2\2\u01ca\u0984\3\2\2\2\u01cc\u098c\3\2"+
		"\2\2\u01ce\u0999\3\2\2\2\u01d0\u099e\3\2\2\2\u01d2\u09aa\3\2\2\2\u01d4"+
		"\u09b1\3\2\2\2\u01d6\u09b8\3\2\2\2\u01d8\u09c0\3\2\2\2\u01da\u09d0\3\2"+
		"\2\2\u01dc\u09d4\3\2\2\2\u01de\u09db\3\2\2\2\u01e0\u09df\3\2\2\2\u01e2"+
		"\u09e4\3\2\2\2\u01e4\u09e9\3\2\2\2\u01e6\u09ee\3\2\2\2\u01e8\u09f3\3\2"+
		"\2\2\u01ea\u09f9\3\2\2\2\u01ec\u09ff\3\2\2\2\u01ee\u0a04\3\2\2\2\u01f0"+
		"\u0a0b\3\2\2\2\u01f2\u0a10\3\2\2\2\u01f4\u0a20\3\2\2\2\u01f6\u0a24\3\2"+
		"\2\2\u01f8\u0a26\3\2\2\2\u01fa\u0a30\3\2\2\2\u01fc\u0a40\3\2\2\2\u01fe"+
		"\u0a47\3\2\2\2\u0200\u0a49\3\2\2\2\u0202\u0a4f\3\2\2\2\u0204\u0a53\3\2"+
		"\2\2\u0206\u0a59\3\2\2\2\u0208\u0a64\3\2\2\2\u020a\u0a66\3\2\2\2\u020c"+
		"\u0a6e\3\2\2\2\u020e\u0a72\3\2\2\2\u0210\u0a76\3\2\2\2\u0212\u0a7d\3\2"+
		"\2\2\u0214\u0a82\3\2\2\2\u0216\u0a88\3\2\2\2\u0218\u0a90\3\2\2\2\u021a"+
		"\u0a94\3\2\2\2\u021c\u0a9e\3\2\2\2\u021e\u0aa3\3\2\2\2\u0220\u0aa5\3\2"+
		"\2\2\u0222\u0aa9\3\2\2\2\u0224\u0aad\3\2\2\2\u0226\u0ab1\3\2\2\2\u0228"+
		"\u0abc\3\2\2\2\u022a\u0abe\3\2\2\2\u022c\u0ac2\3\2\2\2\u022e\u0ac6\3\2"+
		"\2\2\u0230\u0aca\3\2\2\2\u0232\u0234\5\4\3\2\u0233\u0232\3\2\2\2\u0234"+
		"\u0235\3\2\2\2\u0235\u0233\3\2\2\2\u0235\u0236\3\2\2\2\u0236\u023d\3\2"+
		"\2\2\u0237\u0239\5H%\2\u0238\u0237\3\2\2\2\u0239\u023a\3\2\2\2\u023a\u0238"+
		"\3\2\2\2\u023a\u023b\3\2\2\2\u023b\u023d\3\2\2\2\u023c\u0233\3\2\2\2\u023c"+
		"\u0238\3\2\2\2\u023d\3\3\2\2\2\u023e\u023f\7H\2\2\u023f\u0240\7\u00d1"+
		"\2\2\u0240\u0242\5\6\4\2\u0241\u0243\5\66\34\2\u0242\u0241\3\2\2\2\u0242"+
		"\u0243\3\2\2\2\u0243\u0244\3\2\2\2\u0244\u0245\7&\2\2\u0245\u0246\7\u00d1"+
		"\2\2\u0246\5\3\2\2\2\u0247\u0249\5\b\5\2\u0248\u0247\3\2\2\2\u0248\u0249"+
		"\3\2\2\2\u0249\u024a\3\2\2\2\u024a\u024b\5 \21\2\u024b\7\3\2\2\2\u024c"+
		"\u024d\7<\2\2\u024d\u0252\5\n\6\2\u024e\u024f\7\u00bc\2\2\u024f\u0251"+
		"\5\n\6\2\u0250\u024e\3\2\2\2\u0251\u0254\3\2\2\2\u0252\u0250\3\2\2\2\u0252"+
		"\u0253\3\2\2\2\u0253\t\3\2\2\2\u0254\u0252\3\2\2\2\u0255\u0256\7\63\2"+
		"\2\u0256\u0257\7\u00d1\2\2\u0257\u0258\5\f\7\2\u0258\13\3\2\2\2\u0259"+
		"\u0260\7\16\2\2\u025a\u025c\5\16\b\2\u025b\u025a\3\2\2\2\u025c\u025d\3"+
		"\2\2\2\u025d\u025b\3\2\2\2\u025d\u025e\3\2\2\2\u025e\u0260\3\2\2\2\u025f"+
		"\u0259\3\2\2\2\u025f\u025b\3\2\2\2\u0260\r\3\2\2\2\u0261\u0266\5\20\t"+
		"\2\u0262\u0266\5\24\13\2\u0263\u0266\5\30\r\2\u0264\u0266\5\34\17\2\u0265"+
		"\u0261\3\2\2\2\u0265\u0262\3\2\2\2\u0265\u0263\3\2\2\2\u0265\u0264\3\2"+
		"\2\2\u0266\17\3\2\2\2\u0267\u0268\7o\2\2\u0268\u026d\5\22\n\2\u0269\u026a"+
		"\7\u00bf\2\2\u026a\u026c\5\22\n\2\u026b\u0269\3\2\2\2\u026c\u026f\3\2"+
		"\2\2\u026d\u026b\3\2\2\2\u026d\u026e\3\2\2\2\u026e\u0271\3\2\2\2\u026f"+
		"\u026d\3\2\2\2\u0270\u0272\7\u00bf\2\2\u0271\u0270\3\2\2\2\u0271\u0272"+
		"\3\2\2\2\u0272\21\3\2\2\2\u0273\u0276\5\u0194\u00cb\2\u0274\u0275\7_\2"+
		"\2\u0275\u0277\5\u0194\u00cb\2\u0276\u0274\3\2\2\2\u0276\u0277\3\2\2\2"+
		"\u0277\u027e\3\2\2\2\u0278\u027b\5T+\2\u0279\u027a\7_\2\2\u027a\u027c"+
		"\5\u0194\u00cb\2\u027b\u0279\3\2\2\2\u027b\u027c\3\2\2\2\u027c\u027e\3"+
		"\2\2\2\u027d\u0273\3\2\2\2\u027d\u0278\3\2\2\2\u027e\23\3\2\2\2\u027f"+
		"\u0280\7r\2\2\u0280\u0285\5\26\f\2\u0281\u0282\7\u00bf\2\2\u0282\u0284"+
		"\5\26\f\2\u0283\u0281\3\2\2\2\u0284\u0287\3\2\2\2\u0285\u0283\3\2\2\2"+
		"\u0285\u0286\3\2\2\2\u0286\u0289\3\2\2\2\u0287\u0285\3\2\2\2\u0288\u028a"+
		"\7\u00bf\2\2\u0289\u0288\3\2\2\2\u0289\u028a\3\2\2\2\u028a\25\3\2\2\2"+
		"\u028b\u028e\5\u0194\u00cb\2\u028c\u028d\7\u00be\2\2\u028d\u028f\5Z.\2"+
		"\u028e\u028c\3\2\2\2\u028e\u028f\3\2\2\2\u028f\u0292\3\2\2\2\u0290\u0291"+
		"\7_\2\2\u0291\u0293\5\u0194\u00cb\2\u0292\u0290\3\2\2\2\u0292\u0293\3"+
		"\2\2\2\u0293\27\3\2\2\2\u0294\u0295\7\64\2\2\u0295\u029a\5\32\16\2\u0296"+
		"\u0297\7\u00bf\2\2\u0297\u0299\5\32\16\2\u0298\u0296\3\2\2\2\u0299\u029c"+
		"\3\2\2\2\u029a\u0298\3\2\2\2\u029a\u029b\3\2\2\2\u029b\u029e\3\2\2\2\u029c"+
		"\u029a\3\2\2\2\u029d\u029f\7\u00bf\2\2\u029e\u029d\3\2\2\2\u029e\u029f"+
		"\3\2\2\2\u029f\31\3\2\2\2\u02a0\u02a6\5\u0194\u00cb\2\u02a1\u02a3\5\u00b4"+
		"[\2\u02a2\u02a1\3\2\2\2\u02a2\u02a3\3\2\2\2\u02a3\u02a4\3\2\2\2\u02a4"+
		"\u02a5\7\u00be\2\2\u02a5\u02a7\5\u0080A\2\u02a6\u02a2\3\2\2\2\u02a6\u02a7"+
		"\3\2\2\2\u02a7\u02aa\3\2\2\2\u02a8\u02a9\7_\2\2\u02a9\u02ab\5\u0194\u00cb"+
		"\2\u02aa\u02a8\3\2\2\2\u02aa\u02ab\3\2\2\2\u02ab\33\3\2\2\2\u02ac\u02ad"+
		"\7R\2\2\u02ad\u02b2\5\36\20\2\u02ae\u02af\7\u00bf\2\2\u02af\u02b1\5\36"+
		"\20\2\u02b0\u02ae\3\2\2\2\u02b1\u02b4\3\2\2\2\u02b2\u02b0\3\2\2\2\u02b2"+
		"\u02b3\3\2\2\2\u02b3\u02b6\3\2\2\2\u02b4\u02b2\3\2\2\2\u02b5\u02b7\7\u00bf"+
		"\2\2\u02b6\u02b5\3\2\2\2\u02b6\u02b7\3\2\2\2\u02b7\35\3\2\2\2\u02b8\u02bb"+
		"\5\u0194\u00cb\2\u02b9\u02ba\7\u00be\2\2\u02ba\u02bc\5\u00dan\2\u02bb"+
		"\u02b9\3\2\2\2\u02bb\u02bc\3\2\2\2\u02bc\u02bf\3\2\2\2\u02bd\u02be\7_"+
		"\2\2\u02be\u02c0\5\u0194\u00cb\2\u02bf\u02bd\3\2\2\2\u02bf\u02c0\3\2\2"+
		"\2\u02c0\37\3\2\2\2\u02c1\u02c2\7-\2\2\u02c2\u02c3\5\"\22\2\u02c3!\3\2"+
		"\2\2\u02c4\u02cb\7\16\2\2\u02c5\u02c7\5$\23\2\u02c6\u02c5\3\2\2\2\u02c7"+
		"\u02c8\3\2\2\2\u02c8\u02c6\3\2\2\2\u02c8\u02c9\3\2\2\2\u02c9\u02cb\3\2"+
		"\2\2\u02ca\u02c4\3\2\2\2\u02ca\u02c6\3\2\2\2\u02cb#\3\2\2\2\u02cc\u02d1"+
		"\5&\24\2\u02cd\u02d1\5*\26\2\u02ce\u02d1\5.\30\2\u02cf\u02d1\5\62\32\2"+
		"\u02d0\u02cc\3\2\2\2\u02d0\u02cd\3\2\2\2\u02d0\u02ce\3\2\2\2\u02d0\u02cf"+
		"\3\2\2\2\u02d1%\3\2\2\2\u02d2\u02d3\7o\2\2\u02d3\u02d8\5(\25\2\u02d4\u02d5"+
		"\7\u00bf\2\2\u02d5\u02d7\5(\25\2\u02d6\u02d4\3\2\2\2\u02d7\u02da\3\2\2"+
		"\2\u02d8\u02d6\3\2\2\2\u02d8\u02d9\3\2\2\2\u02d9\u02dc\3\2\2\2\u02da\u02d8"+
		"\3\2\2\2\u02db\u02dd\7\u00bf\2\2\u02dc\u02db\3\2\2\2\u02dc\u02dd\3\2\2"+
		"\2\u02dd\'\3\2\2\2\u02de\u02e0\7e\2\2\u02df\u02de\3\2\2\2\u02df\u02e0"+
		"\3\2\2\2\u02e0\u02e1\3\2\2\2\u02e1\u02e2\5\u0194\u00cb\2\u02e2)\3\2\2"+
		"\2\u02e3\u02e4\7r\2\2\u02e4\u02e9\5,\27\2\u02e5\u02e6\7\u00bf\2\2\u02e6"+
		"\u02e8\5,\27\2\u02e7\u02e5\3\2\2\2\u02e8\u02eb\3\2\2\2\u02e9\u02e7\3\2"+
		"\2\2\u02e9\u02ea\3\2\2\2\u02ea\u02ed\3\2\2\2\u02eb\u02e9\3\2\2\2\u02ec"+
		"\u02ee\7\u00bf\2\2\u02ed\u02ec\3\2\2\2\u02ed\u02ee\3\2\2\2\u02ee+\3\2"+
		"\2\2\u02ef\u02f0\5\u0192\u00ca\2\u02f0\u02f1\7\u00be\2\2\u02f1\u02f2\5"+
		"Z.\2\u02f2-\3\2\2\2\u02f3\u02f4\7\64\2\2\u02f4\u02f9\5\60\31\2\u02f5\u02f6"+
		"\7\u00bf\2\2\u02f6\u02f8\5\60\31\2\u02f7\u02f5\3\2\2\2\u02f8\u02fb\3\2"+
		"\2\2\u02f9\u02f7\3\2\2\2\u02f9\u02fa\3\2\2\2\u02fa\u02fd\3\2\2\2\u02fb"+
		"\u02f9\3\2\2\2\u02fc\u02fe\7\u00bf\2\2\u02fd\u02fc\3\2\2\2\u02fd\u02fe"+
		"\3\2\2\2\u02fe/\3\2\2\2\u02ff\u0301\5\u0192\u00ca\2\u0300\u0302\5\u00b4"+
		"[\2\u0301\u0300\3\2\2\2\u0301\u0302\3\2\2\2\u0302\u0303\3\2\2\2\u0303"+
		"\u0304\7\u00be\2\2\u0304\u0305\5\u0080A\2\u0305\61\3\2\2\2\u0306\u0307"+
		"\7R\2\2\u0307\u030c\5\64\33\2\u0308\u0309\7\u00bf\2\2\u0309\u030b\5\64"+
		"\33\2\u030a\u0308\3\2\2\2\u030b\u030e\3\2\2\2\u030c\u030a\3\2\2\2\u030c"+
		"\u030d\3\2\2\2\u030d\u030f\3\2\2\2\u030e\u030c\3\2\2\2\u030f\u0310\7\u00bf"+
		"\2\2\u0310\63\3\2\2\2\u0311\u0312\5\u0192\u00ca\2\u0312\u0313\7\u00be"+
		"\2\2\u0313\u0314\5\u00dan\2\u0314\65\3\2\2\2\u0315\u0317\7\35\2\2\u0316"+
		"\u0318\5H%\2\u0317\u0316\3\2\2\2\u0318\u0319\3\2\2\2\u0319\u0317\3\2\2"+
		"\2\u0319\u031a\3\2\2\2\u031a\67\3\2\2\2\u031b\u031e\5> \2\u031c\u031e"+
		"\5:\36\2\u031d\u031b\3\2\2\2\u031d\u031c\3\2\2\2\u031e\u031f\3\2\2\2\u031f"+
		"\u031d\3\2\2\2\u031f\u0320\3\2\2\2\u03209\3\2\2\2\u0321\u0322\7\u0099"+
		"\2\2\u0322\u0324\7\u00d1\2\2\u0323\u0325\5<\37\2\u0324\u0323\3\2\2\2\u0324"+
		"\u0325\3\2\2\2\u0325\u0326\3\2\2\2\u0326\u0327\7&\2\2\u0327\u0328\7\u00d1"+
		"\2\2\u0328;\3\2\2\2\u0329\u032b\7\35\2\2\u032a\u032c\5D#\2\u032b\u032a"+
		"\3\2\2\2\u032c\u032d\3\2\2\2\u032d\u032b\3\2\2\2\u032d\u032e\3\2\2\2\u032e"+
		"=\3\2\2\2\u032f\u0330\7}\2\2\u0330\u0332\7\u00d1\2\2\u0331\u0333\5@!\2"+
		"\u0332\u0331\3\2\2\2\u0332\u0333\3\2\2\2\u0333\u0335\3\2\2\2\u0334\u0336"+
		"\5B\"\2\u0335\u0334\3\2\2\2\u0335\u0336\3\2\2\2\u0336\u0337\3\2\2\2\u0337"+
		"\u0338\7&\2\2\u0338\u0339\7\u00d1\2\2\u0339?\3\2\2\2\u033a\u033b\7x\2"+
		"\2\u033b\u0340\7\u00d1\2\2\u033c\u033d\7\u00bc\2\2\u033d\u033f\7\u00d1"+
		"\2\2\u033e\u033c\3\2\2\2\u033f\u0342\3\2\2\2\u0340\u033e\3\2\2\2\u0340"+
		"\u0341\3\2\2\2\u0341A\3\2\2\2\u0342\u0340\3\2\2\2\u0343\u0345\7\35\2\2"+
		"\u0344\u0346\5F$\2\u0345\u0344\3\2\2\2\u0346\u0347\3\2\2\2\u0347\u0345"+
		"\3\2\2\2\u0347\u0348\3\2\2\2\u0348C\3\2\2\2\u0349\u034d\5F$\2\u034a\u034d"+
		"\5\u00f0y\2\u034b\u034d\5\u00f8}\2\u034c\u0349\3\2\2\2\u034c\u034a\3\2"+
		"\2\2\u034c\u034b\3\2\2\2\u034dE\3\2\2\2\u034e\u0355\5J&\2\u034f\u0355"+
		"\5\u009aN\2\u0350\u0355\5\u00a2R\2\u0351\u0355\5\u00c8e\2\u0352\u0355"+
		"\5\u0104\u0083\2\u0353\u0355\5\u00e8u\2\u0354\u034e\3\2\2\2\u0354\u034f"+
		"\3\2\2\2\u0354\u0350\3\2\2\2\u0354\u0351\3\2\2\2\u0354\u0352\3\2\2\2\u0354"+
		"\u0353\3\2\2\2\u0355G\3\2\2\2\u0356\u035d\5P)\2\u0357\u035d\5\u0094K\2"+
		"\u0358\u035d\5\u0098M\2\u0359\u035d\5\u00a0Q\2\u035a\u035d\5\u00c4c\2"+
		"\u035b\u035d\5\u0104\u0083\2\u035c\u0356\3\2\2\2\u035c\u0357\3\2\2\2\u035c"+
		"\u0358\3\2\2\2\u035c\u0359\3\2\2\2\u035c\u035a\3\2\2\2\u035c\u035b\3\2"+
		"\2\2\u035dI\3\2\2\2\u035e\u035f\7o\2\2\u035f\u0360\5L\'\2\u0360K\3\2\2"+
		"\2\u0361\u0363\7\u0086\2\2\u0362\u0361\3\2\2\2\u0362\u0363\3\2\2\2\u0363"+
		"\u0368\3\2\2\2\u0364\u0366\5N(\2\u0365\u0364\3\2\2\2\u0365\u0366\3\2\2"+
		"\2\u0366\u0368\3\2\2\2\u0367\u0362\3\2\2\2\u0367\u0365\3\2\2\2\u0368\u0373"+
		"\3\2\2\2\u0369\u036b\5N(\2\u036a\u0369\3\2\2\2\u036a\u036b\3\2\2\2\u036b"+
		"\u0370\3\2\2\2\u036c\u036e\7\u0086\2\2\u036d\u036c\3\2\2\2\u036d\u036e"+
		"\3\2\2\2\u036e\u0370\3\2\2\2\u036f\u036a\3\2\2\2\u036f\u036d\3\2\2\2\u0370"+
		"\u0371\3\2\2\2\u0371\u0373\5T+\2\u0372\u0367\3\2\2\2\u0372\u036f\3\2\2"+
		"\2\u0373M\3\2\2\2\u0374\u0375\t\2\2\2\u0375O\3\2\2\2\u0376\u0377\7o\2"+
		"\2\u0377\u0379\5R*\2\u0378\u037a\7\u00bf\2\2\u0379\u0378\3\2\2\2\u0379"+
		"\u037a\3\2\2\2\u037aQ\3\2\2\2\u037b\u0380\5T+\2\u037c\u037d\7\u00bf\2"+
		"\2\u037d\u037f\5T+\2\u037e\u037c\3\2\2\2\u037f\u0382\3\2\2\2\u0380\u037e"+
		"\3\2\2\2\u0380\u0381\3\2\2\2\u0381S\3\2\2\2\u0382\u0380\3\2\2\2\u0383"+
		"\u0384\7\u00d1\2\2\u0384\u0385\5V,\2\u0385U\3\2\2\2\u0386\u0387\7\u00b0"+
		"\2\2\u0387\u0388\5Z.\2\u0388\u0389\5X-\2\u0389\u039b\3\2\2\2\u038a\u038b"+
		"\7\u00b0\2\2\u038b\u039b\5Z.\2\u038c\u038e\7\u00b5\2\2\u038d\u038f\5f"+
		"\64\2\u038e\u038d\3\2\2\2\u038f\u0390\3\2\2\2\u0390\u038e\3\2\2\2\u0390"+
		"\u0391\3\2\2\2\u0391\u0392\3\2\2\2\u0392\u0393\5X-\2\u0393\u039b\3\2\2"+
		"\2\u0394\u0396\7\u00b5\2\2\u0395\u0397\5f\64\2\u0396\u0395\3\2\2\2\u0397"+
		"\u0398\3\2\2\2\u0398\u0396\3\2\2\2\u0398\u0399\3\2\2\2\u0399\u039b\3\2"+
		"\2\2\u039a\u0386\3\2\2\2\u039a\u038a\3\2\2\2\u039a\u038c\3\2\2\2\u039a"+
		"\u0394\3\2\2\2\u039bW\3\2\2\2\u039c\u039e\5\u008cG\2\u039d\u039c\3\2\2"+
		"\2\u039d\u039e\3\2\2\2\u039e\u03a0\3\2\2\2\u039f\u03a1\5\u008eH\2\u03a0"+
		"\u039f\3\2\2\2\u03a0\u03a1\3\2\2\2\u03a1\u03a3\3\2\2\2\u03a2\u03a4\5\u0090"+
		"I\2\u03a3\u03a2\3\2\2\2\u03a3\u03a4\3\2\2\2\u03a4Y\3\2\2\2\u03a5\u03a6"+
		"\b.\1\2\u03a6\u03b2\5^\60\2\u03a7\u03b2\5\u0088E\2\u03a8\u03b2\5\u008a"+
		"F\2\u03a9\u03b2\5t;\2\u03aa\u03b2\5n8\2\u03ab\u03b2\5z>\2\u03ac\u03b2"+
		"\5d\63\2\u03ad\u03b2\5`\61\2\u03ae\u03b2\5b\62\2\u03af\u03b2\5l\67\2\u03b0"+
		"\u03b2\5\\/\2\u03b1\u03a5\3\2\2\2\u03b1\u03a7\3\2\2\2\u03b1\u03a8\3\2"+
		"\2\2\u03b1\u03a9\3\2\2\2\u03b1\u03aa\3\2\2\2\u03b1\u03ab\3\2\2\2\u03b1"+
		"\u03ac\3\2\2\2\u03b1\u03ad\3\2\2\2\u03b1\u03ae\3\2\2\2\u03b1\u03af\3\2"+
		"\2\2\u03b1\u03b0\3\2\2\2\u03b2\u03c9\3\2\2\2\u03b3\u03b4\f\4\2\2\u03b4"+
		"\u03b5\7\u00ba\2\2\u03b5\u03c8\5Z.\4\u03b6\u03b7\f\3\2\2\u03b7\u03b8\7"+
		"\u00bb\2\2\u03b8\u03c8\5Z.\3\u03b9\u03bc\f\n\2\2\u03ba\u03bb\7\u00ac\2"+
		"\2\u03bb\u03bd\5Z.\2\u03bc\u03ba\3\2\2\2\u03bd\u03be\3\2\2\2\u03be\u03bc"+
		"\3\2\2\2\u03be\u03bf\3\2\2\2\u03bf\u03c8\3\2\2\2\u03c0\u03c3\f\t\2\2\u03c1"+
		"\u03c2\7\u00c0\2\2\u03c2\u03c4\5Z.\2\u03c3\u03c1\3\2\2\2\u03c4\u03c5\3"+
		"\2\2\2\u03c5\u03c3\3\2\2\2\u03c5\u03c6\3\2\2\2\u03c6\u03c8\3\2\2\2\u03c7"+
		"\u03b3\3\2\2\2\u03c7\u03b6\3\2\2\2\u03c7\u03b9\3\2\2\2\u03c7\u03c0\3\2"+
		"\2\2\u03c8\u03cb\3\2\2\2\u03c9\u03c7\3\2\2\2\u03c9\u03ca\3\2\2\2\u03ca"+
		"[\3\2\2\2\u03cb\u03c9\3\2\2\2\u03cc\u03cd\7\u00c6\2\2\u03cd\u03ce\7\u00c7"+
		"\2\2\u03ce\u03cf\t\3\2\2\u03cf\u03d0\5Z.\2\u03d0]\3\2\2\2\u03d1\u03d2"+
		"\7\u00c6\2\2\u03d2\u03d3\5Z.\2\u03d3\u03d4\7\u00c7\2\2\u03d4_\3\2\2\2"+
		"\u03d5\u03d6\t\4\2\2\u03d6a\3\2\2\2\u03d7\u03d8\7\u00cc\2\2\u03d8c\3\2"+
		"\2\2\u03d9\u03da\7\30\2\2\u03da\u03db\7\u00d1\2\2\u03db\u03dd\7Q\2\2\u03dc"+
		"\u03de\5f\64\2\u03dd\u03dc\3\2\2\2\u03de\u03df\3\2\2\2\u03df\u03dd\3\2"+
		"\2\2\u03df\u03e0\3\2\2\2\u03e0\u03e1\3\2\2\2\u03e1\u03e2\7&\2\2\u03e2"+
		"e\3\2\2\2\u03e3\u03eb\5Z.\2\u03e4\u03e5\7\u00d1\2\2\u03e5\u03e7\7\u00be"+
		"\2\2\u03e6\u03e8\7\u00ae\2\2\u03e7\u03e6\3\2\2\2\u03e7\u03e8\3\2\2\2\u03e8"+
		"\u03e9\3\2\2\2\u03e9\u03eb\5Z.\2\u03ea\u03e3\3\2\2\2\u03ea\u03e4\3\2\2"+
		"\2\u03ebg\3\2\2\2\u03ec\u03ef\5Z.\2\u03ed\u03ee\7\u00c0\2\2\u03ee\u03f0"+
		"\5Z.\2\u03ef\u03ed\3\2\2\2\u03f0\u03f1\3\2\2\2\u03f1\u03ef\3\2\2\2\u03f1"+
		"\u03f2\3\2\2\2\u03f2i\3\2\2\2\u03f3\u03f6\5Z.\2\u03f4\u03f5\7\u00ac\2"+
		"\2\u03f5\u03f7\5Z.\2\u03f6\u03f4\3\2\2\2\u03f7\u03f8\3\2\2\2\u03f8\u03f6"+
		"\3\2\2\2\u03f8\u03f9\3\2\2\2\u03f9k\3\2\2\2\u03fa\u03fb\7\u00c8\2\2\u03fb"+
		"\u03fc\5Z.\2\u03fc\u03fd\7\u00c9\2\2\u03fdm\3\2\2\2\u03fe\u0401\5p9\2"+
		"\u03ff\u0401\5r:\2\u0400\u03fe\3\2\2\2\u0400\u03ff\3\2\2\2\u0401o\3\2"+
		"\2\2\u0402\u0403\7\t\2\2\u0403\u0404\5Z.\2\u0404q\3\2\2\2\u0405\u0406"+
		"\7\b\2\2\u0406\u0407\5Z.\2\u0407s\3\2\2\2\u0408\u040b\5v<\2\u0409\u040b"+
		"\5x=\2\u040a\u0408\3\2\2\2\u040a\u0409\3\2\2\2\u040bu\3\2\2\2\u040c\u040d"+
		"\7\13\2\2\u040d\u040e\5Z.\2\u040ew\3\2\2\2\u040f\u0410\7\n\2\2\u0410\u0411"+
		"\5Z.\2\u0411y\3\2\2\2\u0412\u0415\5|?\2\u0413\u0415\5~@\2\u0414\u0412"+
		"\3\2\2\2\u0414\u0413\3\2\2\2\u0415{\3\2\2\2\u0416\u0417\7D\2\2\u0417\u0418"+
		"\5Z.\2\u0418\u0419\7j\2\2\u0419\u041a\5Z.\2\u041a}\3\2\2\2\u041b\u041c"+
		"\79\2\2\u041c\u041d\5Z.\2\u041d\u041e\7j\2\2\u041e\u041f\5Z.\2\u041f\177"+
		"\3\2\2\2\u0420\u0423\5\u0082B\2\u0421\u0423\5\u0084C\2\u0422\u0420\3\2"+
		"\2\2\u0422\u0421\3\2\2\2\u0423\u0081\3\2\2\2\u0424\u0425\5\u0086D\2\u0425"+
		"\u0426\7\u00ba\2\2\u0426\u0427\5Z.\2\u0427\u0083\3\2\2\2\u0428\u0429\5"+
		"\u0086D\2\u0429\u042a\7\u00bb\2\2\u042a\u042b\5Z.\2\u042b\u0085\3\2\2"+
		"\2\u042c\u042d\7\u00c6\2\2\u042d\u0430\7\u00c7\2\2\u042e\u0430\5Z.\2\u042f"+
		"\u042c\3\2\2\2\u042f\u042e\3\2\2\2\u0430\u0087\3\2\2\2\u0431\u0432\5\u0194"+
		"\u00cb\2\u0432\u0089\3\2\2\2\u0433\u0434\7\u00cd\2\2\u0434\u008b\3\2\2"+
		"\2\u0435\u0436\7>\2\2\u0436\u0437\5\u0092J\2\u0437\u008d\3\2\2\2\u0438"+
		"\u0439\7\'\2\2\u0439\u043a\5\u01fa\u00fe\2\u043a\u043b\7\u00b0\2\2\u043b"+
		"\u043c\5\u0092J\2\u043c\u008f\3\2\2\2\u043d\u043e\7T\2\2\u043e\u043f\5"+
		"\u01fa\u00fe\2\u043f\u0440\7\u00a8\2\2\u0440\u0441\5\u0092J\2\u0441\u0091"+
		"\3\2\2\2\u0442\u0443\5\u01fa\u00fe\2\u0443\u0444\7\u00b8\2\2\u0444\u0445"+
		"\5\u0124\u0093\2\u0445\u0093\3\2\2\2\u0446\u0447\7d\2\2\u0447\u0448\7"+
		"\u00d1\2\2\u0448\u044a\7Q\2\2\u0449\u044b\5f\64\2\u044a\u0449\3\2\2\2"+
		"\u044b\u044c\3\2\2\2\u044c\u044a\3\2\2\2\u044c\u044d\3\2\2\2\u044d\u044f"+
		"\3\2\2\2\u044e\u0450\5\u008cG\2\u044f\u044e\3\2\2\2\u044f\u0450\3\2\2"+
		"\2\u0450\u0452\3\2\2\2\u0451\u0453\5\u0096L\2\u0452\u0451\3\2\2\2\u0452"+
		"\u0453\3\2\2\2\u0453\u0454\3\2\2\2\u0454\u0455\7&\2\2\u0455\u0456\7\u00bf"+
		"\2\2\u0456\u0095\3\2\2\2\u0457\u0458\7=\2\2\u0458\u0459\5\u0092J\2\u0459"+
		"\u0097\3\2\2\2\u045a\u0466\7r\2\2\u045b\u0460\5\u009eP\2\u045c\u045d\7"+
		"\u00bf\2\2\u045d\u045f\5\u009eP\2\u045e\u045c\3\2\2\2\u045f\u0462\3\2"+
		"\2\2\u0460\u045e\3\2\2\2\u0460\u0461\3\2\2\2\u0461\u0464\3\2\2\2\u0462"+
		"\u0460\3\2\2\2\u0463\u0465\7\u00bf\2\2\u0464\u0463\3\2\2\2\u0464\u0465"+
		"\3\2\2\2\u0465\u0467\3\2\2\2\u0466\u045b\3\2\2\2\u0466\u0467\3\2\2\2\u0467"+
		"\u0099\3\2\2\2\u0468\u0474\7r\2\2\u0469\u046e\5\u009cO\2\u046a\u046b\7"+
		"\u00bf\2\2\u046b\u046d\5\u009cO\2\u046c\u046a\3\2\2\2\u046d\u0470\3\2"+
		"\2\2\u046e\u046c\3\2\2\2\u046e\u046f\3\2\2\2\u046f\u0472\3\2\2\2\u0470"+
		"\u046e\3\2\2\2\u0471\u0473\7\u00bf\2\2\u0472\u0471\3\2\2\2\u0472\u0473"+
		"\3\2\2\2\u0473\u0475\3\2\2\2\u0474\u0469\3\2\2\2\u0474\u0475\3\2\2\2\u0475"+
		"\u009b\3\2\2\2\u0476\u0478\5N(\2\u0477\u0476\3\2\2\2\u0477\u0478\3\2\2"+
		"\2\u0478\u0479\3\2\2\2\u0479\u047a\5\u009eP\2\u047a\u009d\3\2\2\2\u047b"+
		"\u047e\5\u01fa\u00fe\2\u047c\u047d\7\u00be\2\2\u047d\u047f\5Z.\2\u047e"+
		"\u047c\3\2\2\2\u047e\u047f\3\2\2\2\u047f\u0480\3\2\2\2\u0480\u0481\7\u00b0"+
		"\2\2\u0481\u0482\5\u0124\u0093\2\u0482\u009f\3\2\2\2\u0483\u0484\7\64"+
		"\2\2\u0484\u0485\5\u00a6T\2\u0485\u00a1\3\2\2\2\u0486\u0487\7\64\2\2\u0487"+
		"\u0488\5\u00a4S\2\u0488\u00a3\3\2\2\2\u0489\u048b\5N(\2\u048a\u0489\3"+
		"\2\2\2\u048a\u048b\3\2\2\2\u048b\u048c\3\2\2\2\u048c\u048d\5\u00a6T\2"+
		"\u048d\u00a5\3\2\2\2\u048e\u0492\5\u00a8U\2\u048f\u0492\5\u00b0Y\2\u0490"+
		"\u0492\5\u00b2Z\2\u0491\u048e\3\2\2\2\u0491\u048f\3\2\2\2\u0491\u0490"+
		"\3\2\2\2\u0492\u00a7\3\2\2\2\u0493\u0495\7\u00d1\2\2\u0494\u0496\5\u00b4"+
		"[\2\u0495\u0494\3\2\2\2\u0495\u0496\3\2\2\2\u0496\u0497\3\2\2\2\u0497"+
		"\u0498\7\u00be\2\2\u0498\u0499\5\u0080A\2\u0499\u049b\7\u00d1\2\2\u049a"+
		"\u049c\5\u00be`\2\u049b\u049a\3\2\2\2\u049c\u049d\3\2\2\2\u049d\u049b"+
		"\3\2\2\2\u049d\u049e\3\2\2\2\u049e\u049f\3\2\2\2\u049f\u04a0\7\u00b8\2"+
		"\2\u04a0\u04a2\5\u00c0a\2\u04a1\u04a3\5\u00aaV\2\u04a2\u04a1\3\2\2\2\u04a2"+
		"\u04a3\3\2\2\2\u04a3\u04a5\3\2\2\2\u04a4\u04a6\5\u00acW\2\u04a5\u04a4"+
		"\3\2\2\2\u04a5\u04a6\3\2\2\2\u04a6\u04a8\3\2\2\2\u04a7\u04a9\5\u00aeX"+
		"\2\u04a8\u04a7\3\2\2\2\u04a8\u04a9\3\2\2\2\u04a9\u00a9\3\2\2\2\u04aa\u04ab"+
		"\7X\2\2\u04ab\u04ac\5\u0124\u0093\2\u04ac\u00ab\3\2\2\2\u04ad\u04ae\7"+
		"V\2\2\u04ae\u04af\5\u0124\u0093\2\u04af\u00ad\3\2\2\2\u04b0\u04b1\7E\2"+
		"\2\u04b1\u04b2\5\u00c2b\2\u04b2\u00af\3\2\2\2\u04b3\u04b5\7\u00d1\2\2"+
		"\u04b4\u04b6\5\u00b4[\2\u04b5\u04b4\3\2\2\2\u04b5\u04b6\3\2\2\2\u04b6"+
		"\u04b7\3\2\2\2\u04b7\u04b8\5\u00b6\\\2\u04b8\u04ba\5\u00ba^\2\u04b9\u04bb"+
		"\5\u00aaV\2\u04ba\u04b9\3\2\2\2\u04ba\u04bb\3\2\2\2\u04bb\u04bc\3\2\2"+
		"\2\u04bc\u04bd\5\u00acW\2\u04bd\u00b1\3\2\2\2\u04be\u04c0\7\u00d1\2\2"+
		"\u04bf\u04c1\5\u00b4[\2\u04c0\u04bf\3\2\2\2\u04c0\u04c1\3\2\2\2\u04c1"+
		"\u04c2\3\2\2\2\u04c2\u04c3\5\u00b6\\\2\u04c3\u04c5\5\u00ba^\2\u04c4\u04c6"+
		"\5\u00aaV\2\u04c5\u04c4\3\2\2\2\u04c5\u04c6\3\2\2\2\u04c6\u04c8\3\2\2"+
		"\2\u04c7\u04c9\5\u00acW\2\u04c8\u04c7\3\2\2\2\u04c8\u04c9\3\2\2\2\u04c9"+
		"\u04cb\3\2\2\2\u04ca\u04cc\5\u00aeX\2\u04cb\u04ca\3\2\2\2\u04cb\u04cc"+
		"\3\2\2\2\u04cc\u00b3\3\2\2\2\u04cd\u04ce\7\u00c8\2\2\u04ce\u04d3\7\u00cd"+
		"\2\2\u04cf\u04d0\7\u00bc\2\2\u04d0\u04d2\7\u00cd\2\2\u04d1\u04cf\3\2\2"+
		"\2\u04d2\u04d5\3\2\2\2\u04d3\u04d1\3\2\2\2\u04d3\u04d4\3\2\2\2\u04d4\u04d6"+
		"\3\2\2\2\u04d5\u04d3\3\2\2\2\u04d6\u04d7\7\u00c9\2\2\u04d7\u00b5\3\2\2"+
		"\2\u04d8\u04d9\7\u00c6\2\2\u04d9\u04da\5\u00b8]\2\u04da\u04db\7\u00c7"+
		"\2\2\u04db\u00b7\3\2\2\2\u04dc\u04dd\5\u021a\u010e\2\u04dd\u04de\7\u00be"+
		"\2\2\u04de\u04e6\5Z.\2\u04df\u04e0\7\u00bc\2\2\u04e0\u04e1\5\u021a\u010e"+
		"\2\u04e1\u04e2\7\u00be\2\2\u04e2\u04e3\5Z.\2\u04e3\u04e5\3\2\2\2\u04e4"+
		"\u04df\3\2\2\2\u04e5\u04e8\3\2\2\2\u04e6\u04e4\3\2\2\2\u04e6\u04e7\3\2"+
		"\2\2\u04e7\u00b9\3\2\2\2\u04e8\u04e6\3\2\2\2\u04e9\u04ee\5\u00bc_\2\u04ea"+
		"\u04eb\7\u00bc\2\2\u04eb\u04ed\5\u00bc_\2\u04ec\u04ea\3\2\2\2\u04ed\u04f0"+
		"\3\2\2\2\u04ee\u04ec\3\2\2\2\u04ee\u04ef\3\2\2\2\u04ef\u00bb\3\2\2\2\u04f0"+
		"\u04ee\3\2\2\2\u04f1\u04f2\7\u00d1\2\2\u04f2\u04f3\7\u00be\2\2\u04f3\u04f4"+
		"\5Z.\2\u04f4\u00bd\3\2\2\2\u04f5\u04f7\7\u00c6\2\2\u04f6\u04f8\5\u021a"+
		"\u010e\2\u04f7\u04f6\3\2\2\2\u04f7\u04f8\3\2\2\2\u04f8\u04f9\3\2\2\2\u04f9"+
		"\u04fa\7\u00c7\2\2\u04fa\u00bf\3\2\2\2\u04fb\u04fe\5\u0124\u0093\2\u04fc"+
		"\u04fe\7\3\2\2\u04fd\u04fb\3\2\2\2\u04fd\u04fc\3\2\2\2\u04fe\u00c1\3\2"+
		"\2\2\u04ff\u0502\5\u0124\u0093\2\u0500\u0502\7\3\2\2\u0501\u04ff\3\2\2"+
		"\2\u0501\u0500\3\2\2\2\u0502\u00c3\3\2\2\2\u0503\u0504\7R\2\2\u0504\u0505"+
		"\5\u00c6d\2\u0505\u00c5\3\2\2\2\u0506\u0508\7Y\2\2\u0507\u0506\3\2\2\2"+
		"\u0507\u0508\3\2\2\2\u0508\u0509\3\2\2\2\u0509\u050a\5\u00d0i\2\u050a"+
		"\u00c7\3\2\2\2\u050b\u050c\7R\2\2\u050c\u050d\5\u00caf\2\u050d\u00c9\3"+
		"\2\2\2\u050e\u0512\7Y\2\2\u050f\u0512\5N(\2\u0510\u0512\7\u0086\2\2\u0511"+
		"\u050e\3\2\2\2\u0511\u050f\3\2\2\2\u0511\u0510\3\2\2\2\u0511\u0512\3\2"+
		"\2\2\u0512\u0513\3\2\2\2\u0513\u0514\5\u00d0i\2\u0514\u00cb\3\2\2\2\u0515"+
		"\u0516\7R\2\2\u0516\u0517\5\u00ceh\2\u0517\u00cd\3\2\2\2\u0518\u051d\7"+
		"Y\2\2\u0519\u051d\7\u008d\2\2\u051a\u051d\5N(\2\u051b\u051d\7\u0086\2"+
		"\2\u051c\u0518\3\2\2\2\u051c\u0519\3\2\2\2\u051c\u051a\3\2\2\2\u051c\u051b"+
		"\3\2\2\2\u051c\u051d\3\2\2\2\u051d\u051e\3\2\2\2\u051e\u051f\5\u00d0i"+
		"\2\u051f\u00cf\3\2\2\2\u0520\u0524\5\u00d2j\2\u0521\u0524\5\u00d4k\2\u0522"+
		"\u0524\5\u00d8m\2\u0523\u0520\3\2\2\2\u0523\u0521\3\2\2\2\u0523\u0522"+
		"\3\2\2\2\u0524\u00d1\3\2\2\2\u0525\u0526\7\u00d1\2\2\u0526\u0527\7\u00be"+
		"\2\2\u0527\u0528\5\u00dan\2\u0528\u0529\7\u00d1\2\2\u0529\u052a\5\u00be"+
		"`\2\u052a\u052b\7\u00b8\2\2\u052b\u052d\5\u00dco\2\u052c\u052e\5\u00aa"+
		"V\2\u052d\u052c\3\2\2\2\u052d\u052e\3\2\2\2\u052e\u0530\3\2\2\2\u052f"+
		"\u0531\5\u00acW\2\u0530\u052f\3\2\2\2\u0530\u0531\3\2\2\2\u0531\u00d3"+
		"\3\2\2\2\u0532\u0533\7\u00d1\2\2\u0533\u0535\5\u00b6\\\2\u0534\u0536\5"+
		"\u00ba^\2\u0535\u0534\3\2\2\2\u0535\u0536\3\2\2\2\u0536\u0537\3\2\2\2"+
		"\u0537\u0538\5\u00d6l\2\u0538\u00d5\3\2\2\2\u0539\u053b\5\u00dep\2\u053a"+
		"\u0539\3\2\2\2\u053a\u053b\3\2\2\2\u053b\u053d\3\2\2\2\u053c\u053e\5\u00aa"+
		"V\2\u053d\u053c\3\2\2\2\u053d\u053e\3\2\2\2\u053e\u053f\3\2\2\2\u053f"+
		"\u0541\5\u00acW\2\u0540\u0542\5\u00e4s\2\u0541\u0540\3\2\2\2\u0541\u0542"+
		"\3\2\2\2\u0542\u00d7\3\2\2\2\u0543\u0544\7\u00d1\2\2\u0544\u0546\5\u00b6"+
		"\\\2\u0545\u0547\5\u00ba^\2\u0546\u0545\3\2\2\2\u0546\u0547\3\2\2\2\u0547"+
		"\u0548\3\2\2\2\u0548\u0549\7\u00b8\2\2\u0549\u054b\5\u00dco\2\u054a\u054c"+
		"\5\u00dep\2\u054b\u054a\3\2\2\2\u054b\u054c\3\2\2\2\u054c\u054e\3\2\2"+
		"\2\u054d\u054f\5\u00aaV\2\u054e\u054d\3\2\2\2\u054e\u054f\3\2\2\2\u054f"+
		"\u0551\3\2\2\2\u0550\u0552\5\u00acW\2\u0551\u0550\3\2\2\2\u0551\u0552"+
		"\3\2\2\2\u0552\u0554\3\2\2\2\u0553\u0555\5\u00e4s\2\u0554\u0553\3\2\2"+
		"\2\u0554\u0555\3\2\2\2\u0555\u00d9\3\2\2\2\u0556\u0557\5\u0086D\2\u0557"+
		"\u0558\7\u00b3\2\2\u0558\u0559\5\u0086D\2\u0559\u00db\3\2\2\2\u055a\u055d"+
		"\5\u01a0\u00d1\2\u055b\u055d\7\3\2\2\u055c\u055a\3\2\2\2\u055c\u055b\3"+
		"\2\2\2\u055d\u00dd\3\2\2\2\u055e\u0560\7.\2\2\u055f\u0561\5\u00e0q\2\u0560"+
		"\u055f\3\2\2\2\u0561\u0562\3\2\2\2\u0562\u0560\3\2\2\2\u0562\u0563\3\2"+
		"\2\2\u0563\u00df\3\2\2\2\u0564\u0565\5\u00e2r\2\u0565\u0568\5\u0192\u00ca"+
		"\2\u0566\u0567\7\u00be\2\2\u0567\u0569\5Z.\2\u0568\u0566\3\2\2\2\u0568"+
		"\u0569\3\2\2\2\u0569\u00e1\3\2\2\2\u056a\u056b\t\5\2\2\u056b\u00e3\3\2"+
		"\2\2\u056c\u056e\7)\2\2\u056d\u056f\5\u00e6t\2\u056e\u056d\3\2\2\2\u056f"+
		"\u0570\3\2\2\2\u0570\u056e\3\2\2\2\u0570\u0571\3\2\2\2\u0571\u00e5\3\2"+
		"\2\2\u0572\u0573\7\u00d1\2\2\u0573\u0574\7\u00be\2\2\u0574\u0575\5\u0124"+
		"\u0093\2\u0575\u0576\7\u00ba\2\2\u0576\u0577\5\u0124\u0093\2\u0577\u00e7"+
		"\3\2\2\2\u0578\u0579\7z\2\2\u0579\u0582\7\u0087\2\2\u057a\u057f\5\u00ea"+
		"v\2\u057b\u057c\7\u00bf\2\2\u057c\u057e\5\u00eav\2\u057d\u057b\3\2\2\2"+
		"\u057e\u0581\3\2\2\2\u057f\u057d\3\2\2\2\u057f\u0580\3\2\2\2\u0580\u0583"+
		"\3\2\2\2\u0581\u057f\3\2\2\2\u0582\u057a\3\2\2\2\u0582\u0583\3\2\2\2\u0583"+
		"\u00e9\3\2\2\2\u0584\u0587\5\u00ecw\2\u0585\u0587\5\u00eex\2\u0586\u0584"+
		"\3\2\2\2\u0586\u0585\3\2\2\2\u0587\u00eb\3\2\2\2\u0588\u058a\5N(\2\u0589"+
		"\u0588\3\2\2\2\u0589\u058a\3\2\2\2\u058a\u058c\3\2\2\2\u058b\u058d\7\u0086"+
		"\2\2\u058c\u058b\3\2\2\2\u058c\u058d\3\2\2\2\u058d\u0595\3\2\2\2\u058e"+
		"\u0590\7\u0086\2\2\u058f\u058e\3\2\2\2\u058f\u0590\3\2\2\2\u0590\u0592"+
		"\3\2\2\2\u0591\u0593\5N(\2\u0592\u0591\3\2\2\2\u0592\u0593\3\2\2\2\u0593"+
		"\u0595\3\2\2\2\u0594\u0589\3\2\2\2\u0594\u058f\3\2\2\2\u0595\u0596\3\2"+
		"\2\2\u0596\u0597\5\u01b4\u00db\2\u0597\u00ed\3\2\2\2\u0598\u0599\7>\2"+
		"\2\u0599\u059a\5\u0124\u0093\2\u059a\u00ef\3\2\2\2\u059b\u059d\7\u0098"+
		"\2\2\u059c\u059e\5\u00f2z\2\u059d\u059c\3\2\2\2\u059d\u059e\3\2\2\2\u059e"+
		"\u00f1\3\2\2\2\u059f\u05a0\5\u00f4{\2\u05a0\u00f3\3\2\2\2\u05a1\u05a2"+
		"\7\u0091\2\2\u05a2\u05a3\5\u0194\u00cb\2\u05a3\u05a4\7\u00a1\2\2\u05a4"+
		"\u05a5\5\u0124\u0093\2\u05a5\u05a8\3\2\2\2\u05a6\u05a8\5\u00f6|\2\u05a7"+
		"\u05a1\3\2\2\2\u05a7\u05a6\3\2\2\2\u05a8\u00f5\3\2\2\2\u05a9\u05aa\7\u0092"+
		"\2\2\u05aa\u05ab\7\u00c6\2\2\u05ab\u05b0\7\16\2\2\u05ac\u05ad\5\u0192"+
		"\u00ca\2\u05ad\u05ae\7\u00c7\2\2\u05ae\u05b0\3\2\2\2\u05af\u05a9\3\2\2"+
		"\2\u05af\u05ac\3\2\2\2\u05b0\u00f7\3\2\2\2\u05b1\u05b3\7\u009c\2\2\u05b2"+
		"\u05b4\5\u00fa~\2\u05b3\u05b2\3\2\2\2\u05b3\u05b4\3\2\2\2\u05b4\u00f9"+
		"\3\2\2\2\u05b5\u05b8\5\u00fc\177\2\u05b6\u05b8\5\u0102\u0082\2\u05b7\u05b5"+
		"\3\2\2\2\u05b7\u05b6\3\2\2\2\u05b8\u00fb\3\2\2\2\u05b9\u05bc\5\u00fe\u0080"+
		"\2\u05ba\u05bc\5\u0100\u0081\2\u05bb\u05b9\3\2\2\2\u05bb\u05ba\3\2\2\2"+
		"\u05bc\u00fd\3\2\2\2\u05bd\u05be\7\u0090\2\2\u05be\u05bf\7\u00c6\2\2\u05bf"+
		"\u05c0\5\u0124\u0093\2\u05c0\u05c1\7\u00bc\2\2\u05c1\u05c2\5\u0124\u0093"+
		"\2\u05c2\u05c3\7\u00bc\2\2\u05c3\u05c4\5\u0124\u0093\2\u05c4\u05c5\7\u00bc"+
		"\2\2\u05c5\u05c6\5\u0124\u0093\2\u05c6\u05c7\7\u00c7\2\2\u05c7\u05c8\7"+
		"\u00c6\2\2\u05c8\u05c9\5\u0194\u00cb\2\u05c9\u05ca\7\u00c7\2\2\u05ca\u00ff"+
		"\3\2\2\2\u05cb\u05cc\7\u0093\2\2\u05cc\u05cd\7\u00c6\2\2\u05cd\u05ce\5"+
		"\u0124\u0093\2\u05ce\u05cf\7\u00bc\2\2\u05cf\u05d0\5\u0124\u0093\2\u05d0"+
		"\u05d1\7\u00bc\2\2\u05d1\u05d2\5\u0124\u0093\2\u05d2\u05d3\7\u00bc\2\2"+
		"\u05d3\u05d4\5\u0124\u0093\2\u05d4\u05d5\7\u00c7\2\2\u05d5\u05d6\7\u00c6"+
		"\2\2\u05d6\u05d7\5\u0194\u00cb\2\u05d7\u05d8\7\u00c7\2\2\u05d8\u0101\3"+
		"\2\2\2\u05d9\u05da\5\u01a0\u00d1\2\u05da\u0103\3\2\2\2\u05db\u05df\7l"+
		"\2\2\u05dc\u05de\5\u0106\u0084\2\u05dd\u05dc\3\2\2\2\u05de\u05e1\3\2\2"+
		"\2\u05df\u05dd\3\2\2\2\u05df\u05e0\3\2\2\2\u05e0\u0105\3\2\2\2\u05e1\u05df"+
		"\3\2\2\2\u05e2\u05e7\5\u0108\u0085\2\u05e3\u05e4\7\u00bf\2\2\u05e4\u05e6"+
		"\5\u0108\u0085\2\u05e5\u05e3\3\2\2\2\u05e6\u05e9\3\2\2\2\u05e7\u05e5\3"+
		"\2\2\2\u05e7\u05e8\3\2\2\2\u05e8\u0107\3\2\2\2\u05e9\u05e7\3\2\2\2\u05ea"+
		"\u05ef\7\u00d1\2\2\u05eb\u05ec\7\u00aa\2\2\u05ec\u05ee\7\u00d1\2\2\u05ed"+
		"\u05eb\3\2\2\2\u05ee\u05f1\3\2\2\2\u05ef\u05ed\3\2\2\2\u05ef\u05f0\3\2"+
		"\2\2\u05f0\u05f2\3\2\2\2\u05f1\u05ef\3\2\2\2\u05f2\u05f3\7\u00be\2\2\u05f3"+
		"\u05f4\5\u010a\u0086\2\u05f4\u0109\3\2\2\2\u05f5\u05fa\5\u010c\u0087\2"+
		"\u05f6\u05f7\7\u00bf\2\2\u05f7\u05f9\5\u010c\u0087\2\u05f8\u05f6\3\2\2"+
		"\2\u05f9\u05fc\3\2\2\2\u05fa\u05f8\3\2\2\2\u05fa\u05fb\3\2\2\2\u05fb\u010b"+
		"\3\2\2\2\u05fc\u05fa\3\2\2\2\u05fd\u0602\5\u010e\u0088\2\u05fe\u05ff\7"+
		"\u00c0\2\2\u05ff\u0601\5\u010e\u0088\2\u0600\u05fe\3\2\2\2\u0601\u0604"+
		"\3\2\2\2\u0602\u0600\3\2\2\2\u0602\u0603\3\2\2\2\u0603\u010d\3\2\2\2\u0604"+
		"\u0602\3\2\2\2\u0605\u0608\5\u0110\u0089\2\u0606\u0608\5\u0116\u008c\2"+
		"\u0607\u0605\3\2\2\2\u0607\u0606\3\2\2\2\u0608\u010f\3\2\2\2\u0609\u060c"+
		"\5\u0112\u008a\2\u060a\u060c\5\u0114\u008b\2\u060b\u0609\3\2\2\2\u060b"+
		"\u060a\3\2\2\2\u060c\u0111\3\2\2\2\u060d\u060e\7C\2\2\u060e\u060f\5\u01a4"+
		"\u00d3\2\u060f\u0610\7\67\2\2\u0610\u0611\5\u010e\u0088\2\u0611\u0113"+
		"\3\2\2\2\u0612\u0613\7C\2\2\u0613\u0616\5\u0228\u0115\2\u0614\u0615\7"+
		"\4\2\2\u0615\u0617\5\u0124\u0093\2\u0616\u0614\3\2\2\2\u0616\u0617\3\2"+
		"\2\2\u0617\u0618\3\2\2\2\u0618\u0619\7\67\2\2\u0619\u061a\5\u010e\u0088"+
		"\2\u061a\u0115\3\2\2\2\u061b\u0626\5\u0118\u008d\2\u061c\u0627\7\u00ac"+
		"\2\2\u061d\u0627\7\u00ad\2\2\u061e\u0627\7\u00c1\2\2\u061f\u0620\7\u00ca"+
		"\2\2\u0620\u0623\7\u00ce\2\2\u0621\u0622\7\u00bc\2\2\u0622\u0624\7\u00ce"+
		"\2\2\u0623\u0621\3\2\2\2\u0623\u0624\3\2\2\2\u0624\u0625\3\2\2\2\u0625"+
		"\u0627\7\u00cb\2\2\u0626\u061c\3\2\2\2\u0626\u061d\3\2\2\2\u0626\u061e"+
		"\3\2\2\2\u0626\u061f\3\2\2\2\u0626\u0627\3\2\2\2\u0627\u0117\3\2\2\2\u0628"+
		"\u062c\5\u011a\u008e\2\u0629\u062c\5\u011c\u008f\2\u062a\u062c\5\u011e"+
		"\u0090\2\u062b\u0628\3\2\2\2\u062b\u0629\3\2\2\2\u062b\u062a\3\2\2\2\u062c"+
		"\u0119\3\2\2\2\u062d\u062e\5\u01d2\u00ea\2\u062e\u011b\3\2\2\2\u062f\u0630"+
		"\7\u00b2\2\2\u0630\u0631\7\u00c6\2\2\u0631\u0632\5\u010e\u0088\2\u0632"+
		"\u0633\7\u00bc\2\2\u0633\u0638\5\u010e\u0088\2\u0634\u0635\7\u00bc\2\2"+
		"\u0635\u0637\5\u010e\u0088\2\u0636\u0634\3\2\2\2\u0637\u063a\3\2\2\2\u0638"+
		"\u0636\3\2\2\2\u0638\u0639\3\2\2\2\u0639\u063b\3\2\2\2\u063a\u0638\3\2"+
		"\2\2\u063b\u063c\7\u00c7\2\2\u063c\u011d\3\2\2\2\u063d\u063e\7\u00c6\2"+
		"\2\u063e\u063f\5\u010a\u0086\2\u063f\u0640\7\u00c7\2\2\u0640\u011f\3\2"+
		"\2\2\u0641\u0642\7\u00b1\2\2\u0642\u0643\7\u00d1\2\2\u0643\u0644\7\u00c6"+
		"\2\2\u0644\u0645\7\u00c7\2\2\u0645\u0646\7\u00d5\2\2\u0646\u0121\3\2\2"+
		"\2\u0647\u064c\5\u0124\u0093\2\u0648\u0649\7\u00bc\2\2\u0649\u064b\5\u0124"+
		"\u0093\2\u064a\u0648\3\2\2\2\u064b\u064e\3\2\2\2\u064c\u064a\3\2\2\2\u064c"+
		"\u064d\3\2\2\2\u064d\u0123\3\2\2\2\u064e\u064c\3\2\2\2\u064f\u0650\b\u0093"+
		"\1\2\u0650\u0686\5\u0126\u0094\2\u0651\u0686\5\u0128\u0095\2\u0652\u0686"+
		"\5\u012a\u0096\2\u0653\u0686\5\u012c\u0097\2\u0654\u0686\5\u012e\u0098"+
		"\2\u0655\u0686\5\u0132\u009a\2\u0656\u0686\5\u013a\u009e\2\u0657\u0686"+
		"\5\u013c\u009f\2\u0658\u0686\5\u0144\u00a3\2\u0659\u0686\5\u0146\u00a4"+
		"\2\u065a\u0686\5\u0148\u00a5\2\u065b\u0686\5\u014a\u00a6\2\u065c\u0686"+
		"\5\u014c\u00a7\2\u065d\u0686\5\u014e\u00a8\2\u065e\u0686\5\u0152\u00aa"+
		"\2\u065f\u0686\5\u0156\u00ac\2\u0660\u0686\5\u015e\u00b0\2\u0661\u0686"+
		"\5\u016a\u00b6\2\u0662\u0686\5\u016c\u00b7\2\u0663\u0686\5\u0174\u00bb"+
		"\2\u0664\u0686\5\u017a\u00be\2\u0665\u0686\5\u017c\u00bf\2\u0666\u0667"+
		"\6\u0093\6\2\u0667\u0686\5\u0170\u00b9\2\u0668\u0669\6\u0093\7\2\u0669"+
		"\u0686\5\u0172\u00ba\2\u066a\u066b\6\u0093\b\2\u066b\u0686\5\u017e\u00c0"+
		"\2\u066c\u066d\6\u0093\t\2\u066d\u0686\5\u0180\u00c1\2\u066e\u066f\6\u0093"+
		"\n\2\u066f\u0686\5\u0182\u00c2\2\u0670\u0671\6\u0093\13\2\u0671\u0686"+
		"\5\u0184\u00c3\2\u0672\u0673\6\u0093\f\2\u0673\u0686\5\u0186\u00c4\2\u0674"+
		"\u0675\6\u0093\r\2\u0675\u0686\5\u0188\u00c5\2\u0676\u0677\6\u0093\16"+
		"\2\u0677\u0686\5\u018a\u00c6\2\u0678\u0679\6\u0093\17\2\u0679\u0686\5"+
		"\u018c\u00c7\2\u067a\u067b\6\u0093\20\2\u067b\u0686\5\u018e\u00c8\2\u067c"+
		"\u067d\6\u0093\21\2\u067d\u0686\5\u0190\u00c9\2\u067e\u0686\5\u0196\u00cc"+
		"\2\u067f\u0686\5\u0194\u00cb\2\u0680\u0686\5\u0198\u00cd\2\u0681\u0686"+
		"\5\u0158\u00ad\2\u0682\u0686\5\u015a\u00ae\2\u0683\u0684\6\u0093\22\2"+
		"\u0684\u0686\5\u016e\u00b8\2\u0685\u064f\3\2\2\2\u0685\u0651\3\2\2\2\u0685"+
		"\u0652\3\2\2\2\u0685\u0653\3\2\2\2\u0685\u0654\3\2\2\2\u0685\u0655\3\2"+
		"\2\2\u0685\u0656\3\2\2\2\u0685\u0657\3\2\2\2\u0685\u0658\3\2\2\2\u0685"+
		"\u0659\3\2\2\2\u0685\u065a\3\2\2\2\u0685\u065b\3\2\2\2\u0685\u065c\3\2"+
		"\2\2\u0685\u065d\3\2\2\2\u0685\u065e\3\2\2\2\u0685\u065f\3\2\2\2\u0685"+
		"\u0660\3\2\2\2\u0685\u0661\3\2\2\2\u0685\u0662\3\2\2\2\u0685\u0663\3\2"+
		"\2\2\u0685\u0664\3\2\2\2\u0685\u0665\3\2\2\2\u0685\u0666\3\2\2\2\u0685"+
		"\u0668\3\2\2\2\u0685\u066a\3\2\2\2\u0685\u066c\3\2\2\2\u0685\u066e\3\2"+
		"\2\2\u0685\u0670\3\2\2\2\u0685\u0672\3\2\2\2\u0685\u0674\3\2\2\2\u0685"+
		"\u0676\3\2\2\2\u0685\u0678\3\2\2\2\u0685\u067a\3\2\2\2\u0685\u067c\3\2"+
		"\2\2\u0685\u067e\3\2\2\2\u0685\u067f\3\2\2\2\u0685\u0680\3\2\2\2\u0685"+
		"\u0681\3\2\2\2\u0685\u0682\3\2\2\2\u0685\u0683\3\2\2\2\u0686\u070d\3\2"+
		"\2\2\u0687\u0688\f+\2\2\u0688\u0689\7\u00a2\2\2\u0689\u070c\5\u0124\u0093"+
		"+\u068a\u068b\f*\2\2\u068b\u068c\7\31\2\2\u068c\u070c\5\u0124\u0093*\u068d"+
		"\u068e\f)\2\2\u068e\u068f\7\u00c6\2\2\u068f\u0690\5\u0124\u0093\2\u0690"+
		"\u0691\7\u00bc\2\2\u0691\u0692\7\u00b6\2\2\u0692\u0693\7\u00bc\2\2\u0693"+
		"\u0694\5\u0124\u0093\2\u0694\u0695\7\u00c7\2\2\u0695\u070c\3\2\2\2\u0696"+
		"\u0697\f(\2\2\u0697\u0699\7\u00c6\2\2\u0698\u069a\5\u0122\u0092\2\u0699"+
		"\u0698\3\2\2\2\u0699\u069a\3\2\2\2\u069a\u069b\3\2\2\2\u069b\u070c\7\u00c7"+
		"\2\2\u069c\u069d\f\'\2\2\u069d\u069e\7\u00ca\2\2\u069e\u06a3\5Z.\2\u069f"+
		"\u06a0\7\u00bc\2\2\u06a0\u06a2\5Z.\2\u06a1\u069f\3\2\2\2\u06a2\u06a5\3"+
		"\2\2\2\u06a3\u06a1\3\2\2\2\u06a3\u06a4\3\2\2\2\u06a4\u06a6\3\2\2\2\u06a5"+
		"\u06a3\3\2\2\2\u06a6\u06a7\7\u00cb\2\2\u06a7\u070c\3\2\2\2\u06a8\u06a9"+
		"\f&\2\2\u06a9\u06aa\7\u00bd\2\2\u06aa\u070c\7\u00d1\2\2\u06ab\u06ac\f"+
		"%\2\2\u06ac\u06ad\7\u00b9\2\2\u06ad\u070c\7\u00d2\2\2\u06ae\u06af\f$\2"+
		"\2\u06af\u06b0\7\u00a5\2\2\u06b0\u070c\5\u0124\u0093\2\u06b1\u06b2\f#"+
		"\2\2\u06b2\u06b3\7\u00a6\2\2\u06b3\u070c\5\u0124\u0093\2\u06b4\u06b5\f"+
		"\"\2\2\u06b5\u06b6\7\u00a3\2\2\u06b6\u070c\5\u0124\u0093\2\u06b7\u06b8"+
		"\f!\2\2\u06b8\u06b9\7\u00a4\2\2\u06b9\u070c\5\u0124\u0093\2\u06ba\u06bb"+
		"\f \2\2\u06bb\u06bc\7K\2\2\u06bc\u070c\5\u0124\u0093\2\u06bd\u06be\f\37"+
		"\2\2\u06be\u06bf\7\u00a7\2\2\u06bf\u070c\5\u0124\u0093\2\u06c0\u06c1\f"+
		"\36\2\2\u06c1\u06c2\7\37\2\2\u06c2\u070c\5\u0124\u0093\2\u06c3\u06c4\f"+
		"\35\2\2\u06c4\u06c5\7G\2\2\u06c5\u070c\5\u0124\u0093\2\u06c6\u06c7\f\34"+
		"\2\2\u06c7\u06c8\7^\2\2\u06c8\u070c\5\u0124\u0093\2\u06c9\u06ca\f\33\2"+
		"\2\u06ca\u06cb\7\u00aa\2\2\u06cb\u070c\5\u0124\u0093\2\u06cc\u06cd\f\32"+
		"\2\2\u06cd\u06ce\7\u00ac\2\2\u06ce\u070c\5\u0124\u0093\2\u06cf\u06d0\f"+
		"\31\2\2\u06d0\u06d1\7\u00ae\2\2\u06d1\u070c\5\u0124\u0093\2\u06d2\u06d3"+
		"\f\30\2\2\u06d3\u06d4\7\u00ad\2\2\u06d4\u070c\5\u0124\u0093\2\u06d5\u06d6"+
		"\f\27\2\2\u06d6\u06d7\7\u00ab\2\2\u06d7\u070c\5\u0124\u0093\2\u06d8\u06d9"+
		"\f\26\2\2\u06d9\u06da\7q\2\2\u06da\u070c\5\u0124\u0093\2\u06db\u06dc\f"+
		"\25\2\2\u06dc\u06dd\7;\2\2\u06dd\u070c\5\u0124\u0093\2\u06de\u06df\f\24"+
		"\2\2\u06df\u06e0\7\u00af\2\2\u06e0\u070c\5\u0124\u0093\2\u06e1\u06e2\f"+
		"\23\2\2\u06e2\u06e3\7\u00a0\2\2\u06e3\u070c\5\u0124\u0093\2\u06e4\u06e5"+
		"\f\22\2\2\u06e5\u06e6\7\u009f\2\2\u06e6\u070c\5\u0124\u0093\2\u06e7\u06e8"+
		"\f\21\2\2\u06e8\u06e9\7\u00a9\2\2\u06e9\u070c\5\u0124\u0093\2\u06ea\u06eb"+
		"\f\20\2\2\u06eb\u06ec\7\u00a8\2\2\u06ec\u070c\5\u0124\u0093\2\u06ed\u06ee"+
		"\f\17\2\2\u06ee\u06ef\7\u009e\2\2\u06ef\u070c\5\u0124\u0093\2\u06f0\u06f1"+
		"\f\16\2\2\u06f1\u06f2\7\u00b0\2\2\u06f2\u070c\5\u0124\u0093\2\u06f3\u06f4"+
		"\f\r\2\2\u06f4\u06f5\7\5\2\2\u06f5\u070c\5\u0124\u0093\2\u06f6\u06f7\f"+
		"\f\2\2\u06f7\u06f8\7\6\2\2\u06f8\u070c\5\u0124\u0093\2\u06f9\u06fa\f\13"+
		"\2\2\u06fa\u06fb\7Z\2\2\u06fb\u070c\5\u0124\u0093\2\u06fc\u06fd\f\n\2"+
		"\2\u06fd\u06fe\7f\2\2\u06fe\u070c\5\u0124\u0093\2\u06ff\u0700\f\t\2\2"+
		"\u0700\u0701\7\20\2\2\u0701\u070c\5\u0124\u0093\2\u0702\u0703\f\b\2\2"+
		"\u0703\u0704\7S\2\2\u0704\u070c\5\u0124\u0093\2\u0705\u0706\f\7\2\2\u0706"+
		"\u0707\7\u00a1\2\2\u0707\u070c\5\u0124\u0093\2\u0708\u0709\f\6\2\2\u0709"+
		"\u070a\7\u009d\2\2\u070a\u070c\5\u0124\u0093\2\u070b\u0687\3\2\2\2\u070b"+
		"\u068a\3\2\2\2\u070b\u068d\3\2\2\2\u070b\u0696\3\2\2\2\u070b\u069c\3\2"+
		"\2\2\u070b\u06a8\3\2\2\2\u070b\u06ab\3\2\2\2\u070b\u06ae\3\2\2\2\u070b"+
		"\u06b1\3\2\2\2\u070b\u06b4\3\2\2\2\u070b\u06b7\3\2\2\2\u070b\u06ba\3\2"+
		"\2\2\u070b\u06bd\3\2\2\2\u070b\u06c0\3\2\2\2\u070b\u06c3\3\2\2\2\u070b"+
		"\u06c6\3\2\2\2\u070b\u06c9\3\2\2\2\u070b\u06cc\3\2\2\2\u070b\u06cf\3\2"+
		"\2\2\u070b\u06d2\3\2\2\2\u070b\u06d5\3\2\2\2\u070b\u06d8\3\2\2\2\u070b"+
		"\u06db\3\2\2\2\u070b\u06de\3\2\2\2\u070b\u06e1\3\2\2\2\u070b\u06e4\3\2"+
		"\2\2\u070b\u06e7\3\2\2\2\u070b\u06ea\3\2\2\2\u070b\u06ed\3\2\2\2\u070b"+
		"\u06f0\3\2\2\2\u070b\u06f3\3\2\2\2\u070b\u06f6\3\2\2\2\u070b\u06f9\3\2"+
		"\2\2\u070b\u06fc\3\2\2\2\u070b\u06ff\3\2\2\2\u070b\u0702\3\2\2\2\u070b"+
		"\u0705\3\2\2\2\u070b\u0708\3\2\2\2\u070c\u070f\3\2\2\2\u070d\u070b\3\2"+
		"\2\2\u070d\u070e\3\2\2\2\u070e\u0125\3\2\2\2\u070f\u070d\3\2\2\2\u0710"+
		"\u0711\7\u00c6\2\2\u0711\u0712\5\u0124\u0093\2\u0712\u0713\7\u00c7\2\2"+
		"\u0713\u0127\3\2\2\2\u0714\u0715\7C\2\2\u0715\u0716\5\u01a4\u00d3\2\u0716"+
		"\u0717\7\67\2\2\u0717\u0718\5\u0124\u0093\2\u0718\u0129\3\2\2\2\u0719"+
		"\u071a\7C\2\2\u071a\u071d\5\u0228\u0115\2\u071b\u071c\7\4\2\2\u071c\u071e"+
		"\5\u0124\u0093\2\u071d\u071b\3\2\2\2\u071d\u071e\3\2\2\2\u071e\u071f\3"+
		"\2\2\2\u071f\u0720\7\67\2\2\u0720\u0721\5\u0124\u0093\2\u0721\u012b\3"+
		"\2\2\2\u0722\u0723\7\34\2\2\u0723\u0724\5\u021c\u010f\2\u0724\u0725\7"+
		"\u00b0\2\2\u0725\u072d\5\u0124\u0093\2\u0726\u0727\7\u00bf\2\2\u0727\u0728"+
		"\5\u021c\u010f\2\u0728\u0729\7\u00b0\2\2\u0729\u072a\5\u0124\u0093\2\u072a"+
		"\u072c\3\2\2\2\u072b\u0726\3\2\2\2\u072c\u072f\3\2\2\2\u072d\u072b\3\2"+
		"\2\2\u072d\u072e\3\2\2\2\u072e\u0731\3\2\2\2\u072f\u072d\3\2\2\2\u0730"+
		"\u0732\7\u00bf\2\2\u0731\u0730\3\2\2\2\u0731\u0732\3\2\2\2\u0732\u0733"+
		"\3\2\2\2\u0733\u0734\7\67\2\2\u0734\u0735\5\u0124\u0093\2\u0735\u012d"+
		"\3\2\2\2\u0736\u0737\7\66\2\2\u0737\u0738\5\u0124\u0093\2\u0738\u0739"+
		"\7g\2\2\u0739\u073d\5\u0124\u0093\2\u073a\u073c\5\u0130\u0099\2\u073b"+
		"\u073a\3\2\2\2\u073c\u073f\3\2\2\2\u073d\u073b\3\2\2\2\u073d\u073e\3\2"+
		"\2\2\u073e\u0740\3\2\2\2\u073f\u073d\3\2\2\2\u0740\u0741\7$\2\2\u0741"+
		"\u0742\5\u0124\u0093\2\u0742\u012f\3\2\2\2\u0743\u0744\7%\2\2\u0744\u0745"+
		"\5\u0124\u0093\2\u0745\u0746\7g\2\2\u0746\u0747\5\u0124\u0093\2\u0747"+
		"\u0131\3\2\2\2\u0748\u0749\7\26\2\2\u0749\u074a\5\u0124\u0093\2\u074a"+
		"\u074b\7\u00be\2\2\u074b\u074e\5\u0134\u009b\2\u074c\u074d\7\u00bc\2\2"+
		"\u074d\u074f\5\u0138\u009d\2\u074e\u074c\3\2\2\2\u074e\u074f\3\2\2\2\u074f"+
		"\u0750\3\2\2\2\u0750\u0751\7&\2\2\u0751\u0133\3\2\2\2\u0752\u0757\5\u0136"+
		"\u009c\2\u0753\u0754\7\u00bc\2\2\u0754\u0756\5\u0136\u009c\2\u0755\u0753"+
		"\3\2\2\2\u0756\u0759\3\2\2\2\u0757\u0755\3\2\2\2\u0757\u0758\3\2\2\2\u0758"+
		"\u0135\3\2\2\2\u0759\u0757\3\2\2\2\u075a\u075b\5\u021a\u010e\2\u075b\u075c"+
		"\7\u00ba\2\2\u075c\u075d\5\u0124\u0093\2\u075d\u0137\3\2\2\2\u075e\u075f"+
		"\7U\2\2\u075f\u0760\7\u00ba\2\2\u0760\u0761\5\u0124\u0093\2\u0761\u0139"+
		"\3\2\2\2\u0762\u0763\7\u00ad\2\2\u0763\u078b\5\u0124\u0093\2\u0764\u0765"+
		"\7\u00ae\2\2\u0765\u078b\5\u0124\u0093\2\u0766\u0767\7\r\2\2\u0767\u078b"+
		"\5\u0124\u0093\2\u0768\u0769\7\60\2\2\u0769\u078b\5\u0124\u0093\2\u076a"+
		"\u076b\7P\2\2\u076b\u078b\5\u0124\u0093\2\u076c\u076d\7\25\2\2\u076d\u078b"+
		"\5\u0124\u0093\2\u076e\u076f\7W\2\2\u076f\u078b\5\u0124\u0093\2\u0770"+
		"\u0771\7\"\2\2\u0771\u078b\5\u0124\u0093\2\u0772\u0773\7\36\2\2\u0773"+
		"\u078b\5\u0124\u0093\2\u0774\u0775\7\65\2\2\u0775\u078b\5\u0124\u0093"+
		"\2\u0776\u0777\7i\2\2\u0777\u078b\5\u0124\u0093\2\u0778\u0779\7B\2\2\u0779"+
		"\u078b\5\u0124\u0093\2\u077a\u077b\7#\2\2\u077b\u078b\5\u0124\u0093\2"+
		"\u077c\u077d\78\2\2\u077d\u078b\5\u0124\u0093\2\u077e\u077f\7a\2\2\u077f"+
		"\u078b\5\u0124\u0093\2\u0780\u0781\7\32\2\2\u0781\u078b\5\u0124\u0093"+
		"\2\u0782\u0783\7!\2\2\u0783\u078b\5\u0124\u0093\2\u0784\u0785\7b\2\2\u0785"+
		"\u078b\5\u0124\u0093\2\u0786\u0787\7F\2\2\u0787\u078b\5\u0124\u0093\2"+
		"\u0788\u0789\7?\2\2\u0789\u078b\5\u0124\u0093\2\u078a\u0762\3\2\2\2\u078a"+
		"\u0764\3\2\2\2\u078a\u0766\3\2\2\2\u078a\u0768\3\2\2\2\u078a\u076a\3\2"+
		"\2\2\u078a\u076c\3\2\2\2\u078a\u076e\3\2\2\2\u078a\u0770\3\2\2\2\u078a"+
		"\u0772\3\2\2\2\u078a\u0774\3\2\2\2\u078a\u0776\3\2\2\2\u078a\u0778\3\2"+
		"\2\2\u078a\u077a\3\2\2\2\u078a\u077c\3\2\2\2\u078a\u077e\3\2\2\2\u078a"+
		"\u0780\3\2\2\2\u078a\u0782\3\2\2\2\u078a\u0784\3\2\2\2\u078a\u0786\3\2"+
		"\2\2\u078a\u0788\3\2\2\2\u078b\u013b\3\2\2\2\u078c\u0790\5\u013e\u00a0"+
		"\2\u078d\u0790\5\u0140\u00a1\2\u078e\u0790\5\u0142\u00a2\2\u078f\u078c"+
		"\3\2\2\2\u078f\u078d\3\2\2\2\u078f\u078e\3\2\2\2\u0790\u013d\3\2\2\2\u0791"+
		"\u0792\7\62\2\2\u0792\u0793\5\u0226\u0114\2\u0793\u0794\7\u00c2\2\2\u0794"+
		"\u0795\5\u0124\u0093\2\u0795\u013f\3\2\2\2\u0796\u0797\7*\2\2\u0797\u0798"+
		"\5\u0226\u0114\2\u0798\u0799\7\u00c2\2\2\u0799\u079a\5\u0124\u0093\2\u079a"+
		"\u0141\3\2\2\2\u079b\u079c\7+\2\2\u079c\u079d\5\u021e\u0110\2\u079d\u079e"+
		"\7\u00c2\2\2\u079e\u079f\5\u0124\u0093\2\u079f\u0143\3\2\2\2\u07a0\u07a1"+
		"\7@\2\2\u07a1\u07a2\5\u021e\u0110\2\u07a2\u07a3\7\u00c2\2\2\u07a3\u07a4"+
		"\5\u0124\u0093\2\u07a4\u0145\3\2\2\2\u07a5\u07a6\7\u00ca\2\2\u07a6\u07a7"+
		"\5\u0122\u0092\2\u07a7\u07a8\7\u00cb\2\2\u07a8\u0147\3\2\2\2\u07a9\u07aa"+
		"\7\u00ca\2\2\u07aa\u07ab\5\u0124\u0093\2\u07ab\u07ac\7\u00c0\2\2\u07ac"+
		"\u07af\5\u0226\u0114\2\u07ad\u07ae\7\u00c2\2\2\u07ae\u07b0\5\u0124\u0093"+
		"\2\u07af\u07ad\3\2\2\2\u07af\u07b0\3\2\2\2\u07b0\u07b1\3\2\2\2\u07b1\u07b2"+
		"\7\u00cb\2\2\u07b2\u0149\3\2\2\2\u07b3\u07b4\7\u00ca\2\2\u07b4\u07b5\5"+
		"\u0124\u0093\2\u07b5\u07b6\7\u00bc\2\2\u07b6\u07b7\7\u00b6\2\2\u07b7\u07b8"+
		"\7\u00bc\2\2\u07b8\u07b9\5\u0124\u0093\2\u07b9\u07ba\7\u00cb\2\2\u07ba"+
		"\u014b\3\2\2\2\u07bb\u07bc\7\u00c8\2\2\u07bc\u07bd\5\u0122\u0092\2\u07bd"+
		"\u07be\7\u00c9\2\2\u07be\u014d\3\2\2\2\u07bf\u07c0\7\u00c8\2\2\u07c0\u07c1"+
		"\5\u0124\u0093\2\u07c1\u07c2\7\u00c0\2\2\u07c2\u07c5\5\u0226\u0114\2\u07c3"+
		"\u07c4\7\u00c2\2\2\u07c4\u07c6\5\u0124\u0093\2\u07c5\u07c3\3\2\2\2\u07c5"+
		"\u07c6\3\2\2\2\u07c6\u07c7\3\2\2\2\u07c7\u07c8\7\u00c9\2\2\u07c8\u014f"+
		"\3\2\2\2\u07c9\u07ca\5\u0124\u0093\2\u07ca\u07cb\7\u00c6\2\2\u07cb\u07cc"+
		"\5\u0124\u0093\2\u07cc\u07cd\7\u00bc\2\2\u07cd\u07ce\7\u00b6\2\2\u07ce"+
		"\u07cf\7\u00bc\2\2\u07cf\u07d0\5\u0124\u0093\2\u07d0\u07d1\7\u00c7\2\2"+
		"\u07d1\u0151\3\2\2\2\u07d2\u07d3\7\u00ca\2\2\u07d3\u07d6\5\u0154\u00ab"+
		"\2\u07d4\u07d5\7\u00bc\2\2\u07d5\u07d7\5\u0154\u00ab\2\u07d6\u07d4\3\2"+
		"\2\2\u07d6\u07d7\3\2\2\2\u07d7\u07d8\3\2\2\2\u07d8\u07d9\7\u00cb\2\2\u07d9"+
		"\u07de\3\2\2\2\u07da\u07db\7\u00ca\2\2\u07db\u07dc\7\u00b7\2\2\u07dc\u07de"+
		"\7\u00cb\2\2\u07dd\u07d2\3\2\2\2\u07dd\u07da\3\2\2\2\u07de\u0153\3\2\2"+
		"\2\u07df\u07e0\5\u0124\u0093\2\u07e0\u07e1\7\u00b7\2\2\u07e1\u07e2\5\u0124"+
		"\u0093\2\u07e2\u0155\3\2\2\2\u07e3\u07e4\7\u00ca\2\2\u07e4\u07e5\5\u0154"+
		"\u00ab\2\u07e5\u07e6\7\u00c0\2\2\u07e6\u07e9\5\u0226\u0114\2\u07e7\u07e8"+
		"\7\u00c2\2\2\u07e8\u07ea\5\u0124\u0093\2\u07e9\u07e7\3\2\2\2\u07e9\u07ea"+
		"\3\2\2\2\u07ea\u07eb\3\2\2\2\u07eb\u07ec\7\u00cb\2\2\u07ec\u0157\3\2\2"+
		"\2\u07ed\u07ee\7I\2\2\u07ee\u07ef\7\u00c6\2\2\u07ef\u07f0\5\u0124\u0093"+
		"\2\u07f0\u07f1\7\u00bc\2\2\u07f1\u07f2\5\u0122\u0092\2\u07f2\u07f3\7\u00c7"+
		"\2\2\u07f3\u0159\3\2\2\2\u07f4\u07f5\5\u015c\u00af\2\u07f5\u07f7\7\u00c6"+
		"\2\2\u07f6\u07f8\5\u0122\u0092\2\u07f7\u07f6\3\2\2\2\u07f7\u07f8\3\2\2"+
		"\2\u07f8\u07f9\3\2\2\2\u07f9\u07fa\7\u00c7\2\2\u07fa\u015b\3\2\2\2\u07fb"+
		"\u07fc\7I\2\2\u07fc\u07ff\7\u00d1\2\2\u07fd\u07fe\7\u00c3\2\2\u07fe\u0800"+
		"\7\u00d1\2\2\u07ff\u07fd\3\2\2\2\u07ff\u0800\3\2\2\2\u0800\u0801\3\2\2"+
		"\2\u0801\u0802\6\u00af9\3\u0802\u015d\3\2\2\2\u0803\u0804\7J\2\2\u0804"+
		"\u0805\7\u00c6\2\2\u0805\u0806\5\u0124\u0093\2\u0806\u0807\7\u00bc\2\2"+
		"\u0807\u080c\5\u0160\u00b1\2\u0808\u0809\7\u00bc\2\2\u0809\u080b\5\u0160"+
		"\u00b1\2\u080a\u0808\3\2\2\2\u080b\u080e\3\2\2\2\u080c\u080a\3\2\2\2\u080c"+
		"\u080d\3\2\2\2\u080d\u080f\3\2\2\2\u080e\u080c\3\2\2\2\u080f\u0810\7\u00c7"+
		"\2\2\u0810\u015f\3\2\2\2\u0811\u0812\7\u00d1\2\2\u0812\u0813\7\u00b7\2"+
		"\2\u0813\u0814\5\u0124\u0093\2\u0814\u0161\3\2\2\2\u0815\u0816\5\u0124"+
		"\u0093\2\u0816\u0818\7\u00c6\2\2\u0817\u0819\5\u0122\u0092\2\u0818\u0817"+
		"\3\2\2\2\u0818\u0819\3\2\2\2\u0819\u081a\3\2\2\2\u081a\u081b\7\u00c7\2"+
		"\2\u081b\u0163\3\2\2\2\u081c\u081d\5\u0124\u0093\2\u081d\u081e\7\u00bd"+
		"\2\2\u081e\u081f\7\u00d1\2\2\u081f\u0165\3\2\2\2\u0820\u0821\5\u0124\u0093"+
		"\2\u0821\u0822\7\u00b9\2\2\u0822\u0823\7\u00d2\2\2\u0823\u0167\3\2\2\2"+
		"\u0824\u0825\5\u0124\u0093\2\u0825\u0826\7\u00ca\2\2\u0826\u082b\5Z.\2"+
		"\u0827\u0828\7\u00bc\2\2\u0828\u082a\5Z.\2\u0829\u0827\3\2\2\2\u082a\u082d"+
		"\3\2\2\2\u082b\u0829\3\2\2\2\u082b\u082c\3\2\2\2\u082c\u082e\3\2\2\2\u082d"+
		"\u082b\3\2\2\2\u082e\u082f\7\u00cb\2\2\u082f\u0169\3\2\2\2\u0830\u0831"+
		"\7A\2\2\u0831\u0832\5\u0230\u0119\2\u0832\u0833\7\u00c2\2\2\u0833\u0834"+
		"\5\u0124\u0093\2\u0834\u016b\3\2\2\2\u0835\u0836\7L\2\2\u0836\u0837\7"+
		"\u00c6\2\2\u0837\u0838\5\u0124\u0093\2\u0838\u0839\7\u00bc\2\2\u0839\u083a"+
		"\5Z.\2\u083a\u083b\7\u00c7\2\2\u083b\u016d\3\2\2\2\u083c\u083d\7~\2\2"+
		"\u083d\u083e\5\u0194\u00cb\2\u083e\u0840\7\u00c6\2\2\u083f\u0841\5\u0122"+
		"\u0092\2\u0840\u083f\3\2\2\2\u0840\u0841\3\2\2\2\u0841\u0842\3\2\2\2\u0842"+
		"\u0843\7\u00c7\2\2\u0843\u016f\3\2\2\2\u0844\u0845\7\u0085\2\2\u0845\u0171"+
		"\3\2\2\2\u0846\u0847\7\u009b\2\2\u0847\u0173\3\2\2\2\u0848\u084b\5\u0176"+
		"\u00bc\2\u0849\u084b\5\u0178\u00bd\2\u084a\u0848\3\2\2\2\u084a\u0849\3"+
		"\2\2\2\u084b\u0175\3\2\2\2\u084c\u084f\7\f\2\2\u084d\u0850\5\u0194\u00cb"+
		"\2\u084e\u0850\5`\61\2\u084f\u084d\3\2\2\2\u084f\u084e\3\2\2\2\u0850\u0851"+
		"\3\2\2\2\u0851\u0852\7\u00c6\2\2\u0852\u0853\5\u0124\u0093\2\u0853\u0854"+
		"\7\u00c7\2\2\u0854\u0177\3\2\2\2\u0855\u0856\7\f\2\2\u0856\u0857\7\u00c6"+
		"\2\2\u0857\u0858\5\u0124\u0093\2\u0858\u0859\7\u00bc\2\2\u0859\u085a\5"+
		"Z.\2\u085a\u085b\7\u00c7\2\2\u085b\u0179\3\2\2\2\u085c\u085d\7p\2\2\u085d"+
		"\u017b\3\2\2\2\u085e\u085f\7X\2\2\u085f\u0860\7\u00c5\2\2\u0860\u0861"+
		"\7\u00c6\2\2\u0861\u0862\5\u0122\u0092\2\u0862\u0863\7\u00c7\2\2\u0863"+
		"\u017d\3\2\2\2\u0864\u0865\7{\2\2\u0865\u0866\7\u00c5\2\2\u0866\u0867"+
		"\7\u00c6\2\2\u0867\u0868\5\u0194\u00cb\2\u0868\u0869\7\u00bc\2\2\u0869"+
		"\u086a\5\u0124\u0093\2\u086a\u086b\7\u00c7\2\2\u086b\u017f\3\2\2\2\u086c"+
		"\u086d\7|\2\2\u086d\u086e\7\u00c6\2\2\u086e\u086f\5\u0194\u00cb\2\u086f"+
		"\u0870\7\u00bc\2\2\u0870\u0871\5\u0124\u0093\2\u0871\u0872\7\u00c7\2\2"+
		"\u0872\u0181\3\2\2\2\u0873\u0874\7\u0083\2\2\u0874\u0875\7\u00c6\2\2\u0875"+
		"\u0876\5\u0194\u00cb\2\u0876\u0877\7\u00bc\2\2\u0877\u0878\5\u0124\u0093"+
		"\2\u0878\u0879\7\u00c7\2\2\u0879\u0183\3\2\2\2\u087a\u087b\7\u0084\2\2"+
		"\u087b\u087c\7\u00c6\2\2\u087c\u087d\5\u0194\u00cb\2\u087d\u087e\7\u00bc"+
		"\2\2\u087e\u087f\5\u0124\u0093\2\u087f\u0880\7\u00c7\2\2\u0880\u0185\3"+
		"\2\2\2\u0881\u0882\7\u0089\2\2\u0882\u0883\7\u00c6\2\2\u0883\u0884\5\u0192"+
		"\u00ca\2\u0884\u0885\7\u00c7\2\2\u0885\u0187\3\2\2\2\u0886\u0887\7\u008a"+
		"\2\2\u0887\u0888\7\u00c6\2\2\u0888\u0889\5\u0192\u00ca\2\u0889\u088a\7"+
		"\u00c7\2\2\u088a\u0189\3\2\2\2\u088b\u088c\7\u0088\2\2\u088c\u088d\7\u00c6"+
		"\2\2\u088d\u088e\5\u0192\u00ca\2\u088e\u088f\7\u00c7\2\2\u088f\u018b\3"+
		"\2\2\2\u0890\u0891\7\u008b\2\2\u0891\u0892\7\u00c6\2\2\u0892\u0893\5\u0192"+
		"\u00ca\2\u0893\u0894\7\u00c7\2\2\u0894\u018d\3\2\2\2\u0895\u0896\7\u008c"+
		"\2\2\u0896\u0897\7\u00c6\2\2\u0897\u0898\5\u0192\u00ca\2\u0898\u0899\7"+
		"\u00c7\2\2\u0899\u018f\3\2\2\2\u089a\u089b\7\u009a\2\2\u089b\u0191\3\2"+
		"\2\2\u089c\u08a1\5\u0194\u00cb\2\u089d\u089e\7\u00bc\2\2\u089e\u08a0\5"+
		"\u0194\u00cb\2\u089f\u089d\3\2\2\2\u08a0\u08a3\3\2\2\2\u08a1\u089f\3\2"+
		"\2\2\u08a1\u08a2\3\2\2\2\u08a2\u0193\3\2\2\2\u08a3\u08a1\3\2\2\2\u08a4"+
		"\u08a7\7\u00d1\2\2\u08a5\u08a6\7\u00c3\2\2\u08a6\u08a8\7\u00d1\2\2\u08a7"+
		"\u08a5\3\2\2\2\u08a7\u08a8\3\2\2\2\u08a8\u0195\3\2\2\2\u08a9\u08aa\7\u00d1"+
		"\2\2\u08aa\u08ab\7\u00c4\2\2\u08ab\u0197\3\2\2\2\u08ac\u08ad\t\6\2\2\u08ad"+
		"\u0199\3\2\2\2\u08ae\u08af\b\u00ce\1\2\u08af\u08b0\5\u0194\u00cb\2\u08b0"+
		"\u08bb\3\2\2\2\u08b1\u08b2\f\5\2\2\u08b2\u08b3\7\u00bd\2\2\u08b3\u08ba"+
		"\7\u00d1\2\2\u08b4\u08b5\f\4\2\2\u08b5\u08b6\7\u00c6\2\2\u08b6\u08b7\5"+
		"\u0124\u0093\2\u08b7\u08b8\7\u00c7\2\2\u08b8\u08ba\3\2\2\2\u08b9\u08b1"+
		"\3\2\2\2\u08b9\u08b4\3\2\2\2\u08ba\u08bd\3\2\2\2\u08bb\u08b9\3\2\2\2\u08bb"+
		"\u08bc\3\2\2\2\u08bc\u019b\3\2\2\2\u08bd\u08bb\3\2\2\2\u08be\u08bf\5\u019a"+
		"\u00ce\2\u08bf\u08c0\7\u00bd\2\2\u08c0\u08c1\7\u00d1\2\2\u08c1\u019d\3"+
		"\2\2\2\u08c2\u08c3\5\u019a\u00ce\2\u08c3\u08c4\7\u00c6\2\2\u08c4\u08c5"+
		"\5\u0124\u0093\2\u08c5\u08c6\7\u00c7\2\2\u08c6\u019f\3\2\2\2\u08c7\u08e3"+
		"\5\u01a2\u00d2\2\u08c8\u08e3\5\u01a8\u00d5\2\u08c9\u08e3\5\u01aa\u00d6"+
		"\2\u08ca\u08e3\5\u01b0\u00d9\2\u08cb\u08e3\5\u01b6\u00dc\2\u08cc\u08e3"+
		"\5\u01bc\u00df\2\u08cd\u08e3\5\u01c0\u00e1\2\u08ce\u08e3\5\u01c8\u00e5"+
		"\2\u08cf\u08e3\5\u01ca\u00e6\2\u08d0\u08e3\5\u01cc\u00e7\2\u08d1\u08e3"+
		"\5\u01ce\u00e8\2\u08d2\u08e3\5\u01d0\u00e9\2\u08d3\u08e3\5\u01d2\u00ea"+
		"\2\u08d4\u08e3\5\u01de\u00f0\2\u08d5\u08e3\5\u01e0\u00f1\2\u08d6\u08e3"+
		"\5\u01e2\u00f2\2\u08d7\u08e3\5\u01e4\u00f3\2\u08d8\u08e3\5\u01e6\u00f4"+
		"\2\u08d9\u08e3\5\u01e8\u00f5\2\u08da\u08e3\5\u01ea\u00f6\2\u08db\u08e3"+
		"\5\u01d4\u00eb\2\u08dc\u08e3\5\u01ec\u00f7\2\u08dd\u08e3\5\u01ee\u00f8"+
		"\2\u08de\u08e3\5\u01f0\u00f9\2\u08df\u08e3\5\u01f4\u00fb\2\u08e0\u08e3"+
		"\5\u01f6\u00fc\2\u08e1\u08e3\5\u01f8\u00fd\2\u08e2\u08c7\3\2\2\2\u08e2"+
		"\u08c8\3\2\2\2\u08e2\u08c9\3\2\2\2\u08e2\u08ca\3\2\2\2\u08e2\u08cb\3\2"+
		"\2\2\u08e2\u08cc\3\2\2\2\u08e2\u08cd\3\2\2\2\u08e2\u08ce\3\2\2\2\u08e2"+
		"\u08cf\3\2\2\2\u08e2\u08d0\3\2\2\2\u08e2\u08d1\3\2\2\2\u08e2\u08d2\3\2"+
		"\2\2\u08e2\u08d3\3\2\2\2\u08e2\u08d4\3\2\2\2\u08e2\u08d5\3\2\2\2\u08e2"+
		"\u08d6\3\2\2\2\u08e2\u08d7\3\2\2\2\u08e2\u08d8\3\2\2\2\u08e2\u08d9\3\2"+
		"\2\2\u08e2\u08da\3\2\2\2\u08e2\u08db\3\2\2\2\u08e2\u08dc\3\2\2\2\u08e2"+
		"\u08dd\3\2\2\2\u08e2\u08de\3\2\2\2\u08e2\u08df\3\2\2\2\u08e2\u08e0\3\2"+
		"\2\2\u08e2\u08e1\3\2\2\2\u08e3\u01a1\3\2\2\2\u08e4\u08e5\7C\2\2\u08e5"+
		"\u08e6\5\u01a4\u00d3\2\u08e6\u08e7\7\67\2\2\u08e7\u08e8\5\u01a0\u00d1"+
		"\2\u08e8\u01a3\3\2\2\2\u08e9\u08ee\5\u01a6\u00d4\2\u08ea\u08eb\7\u00bc"+
		"\2\2\u08eb\u08ed\5\u01a6\u00d4\2\u08ec\u08ea\3\2\2\2\u08ed\u08f0\3\2\2"+
		"\2\u08ee\u08ec\3\2\2\2\u08ee\u08ef\3\2\2\2\u08ef\u01a5\3\2\2\2\u08f0\u08ee"+
		"\3\2\2\2\u08f1\u08f4\5\u009eP\2\u08f2\u08f4\5\u00a6T\2\u08f3\u08f1\3\2"+
		"\2\2\u08f3\u08f2\3\2\2\2\u08f4\u01a7\3\2\2\2\u08f5\u08f6\7C\2\2\u08f6"+
		"\u08f9\5\u0228\u0115\2\u08f7\u08f8\7\4\2\2\u08f8\u08fa\5\u0124\u0093\2"+
		"\u08f9\u08f7\3\2\2\2\u08f9\u08fa\3\2\2\2\u08fa\u08fb\3\2\2\2\u08fb\u08fc"+
		"\7\67\2\2\u08fc\u08fd\5\u01a0\u00d1\2\u08fd\u01a9\3\2\2\2\u08fe\u08ff"+
		"\7\34\2\2\u08ff\u0901\5\u01ac\u00d7\2\u0900\u0902\7\u00bf\2\2\u0901\u0900"+
		"\3\2\2\2\u0901\u0902\3\2\2\2\u0902\u0903\3\2\2\2\u0903\u0904\7\67\2\2"+
		"\u0904\u0905\5\u01a0\u00d1\2\u0905\u01ab\3\2\2\2\u0906\u090b\5\u01ae\u00d8"+
		"\2\u0907\u0908\7\u00bf\2\2\u0908\u090a\5\u01ae\u00d8\2\u0909\u0907\3\2"+
		"\2\2\u090a\u090d\3\2\2\2\u090b\u0909\3\2\2\2\u090b\u090c\3\2\2\2\u090c"+
		"\u01ad\3\2\2\2\u090d\u090b\3\2\2\2\u090e\u090f\5\u021c\u010f\2\u090f\u0910"+
		"\7\u00b0\2\2\u0910\u0911\5\u0124\u0093\2\u0911\u01af\3\2\2\2\u0912\u0916"+
		"\7\u00c6\2\2\u0913\u0915\5\u01b2\u00da\2\u0914\u0913\3\2\2\2\u0915\u0918"+
		"\3\2\2\2\u0916\u0914\3\2\2\2\u0916\u0917\3\2\2\2\u0917\u0919\3\2\2\2\u0918"+
		"\u0916\3\2\2\2\u0919\u091e\5\u01a0\u00d1\2\u091a\u091b\7\u00bf\2\2\u091b"+
		"\u091d\5\u01a0\u00d1\2\u091c\u091a\3\2\2\2\u091d\u0920\3\2\2\2\u091e\u091c"+
		"\3\2\2\2\u091e\u091f\3\2\2\2\u091f\u0922\3\2\2\2\u0920\u091e\3\2\2\2\u0921"+
		"\u0923\7\u00bf\2\2\u0922\u0921\3\2\2\2\u0922\u0923\3\2\2\2\u0923\u0924"+
		"\3\2\2\2\u0924\u0925\7\u00c7\2\2\u0925\u01b1\3\2\2\2\u0926\u0927\7\33"+
		"\2\2\u0927\u092c\5\u01b4\u00db\2\u0928\u0929\7\u00bc\2\2\u0929\u092b\5"+
		"\u01b4\u00db\2\u092a\u0928\3\2\2\2\u092b\u092e\3\2\2\2\u092c\u092a\3\2"+
		"\2\2\u092c\u092d\3\2\2\2\u092d\u092f\3\2\2\2\u092e\u092c\3\2\2\2\u092f"+
		"\u0930\7\u00bf\2\2\u0930\u01b3\3\2\2\2\u0931\u0932\7\u00d1\2\2\u0932\u0933"+
		"\7\u00be\2\2\u0933\u0936\5Z.\2\u0934\u0935\7\u00b4\2\2\u0935\u0937\5\u0124"+
		"\u0093\2\u0936\u0934\3\2\2\2\u0936\u0937\3\2\2\2\u0937\u01b5\3\2\2\2\u0938"+
		"\u093b\5\u01b8\u00dd\2\u0939\u093b\5\u01ba\u00de\2\u093a\u0938\3\2\2\2"+
		"\u093a\u0939\3\2\2\2\u093b\u01b7\3\2\2\2\u093c\u093d\5\u019a\u00ce\2\u093d"+
		"\u093e\7\u00b4\2\2\u093e\u093f\5\u0124\u0093\2\u093f\u01b9\3\2\2\2\u0940"+
		"\u0941\7\22\2\2\u0941\u0942\7\u00c6\2\2\u0942\u0943\5\u01b8\u00dd\2\u0943"+
		"\u0944\7\u00bf\2\2\u0944\u0949\5\u01b8\u00dd\2\u0945\u0946\7\u00bf\2\2"+
		"\u0946\u0948\5\u01b8\u00dd\2\u0947\u0945\3\2\2\2\u0948\u094b\3\2\2\2\u0949"+
		"\u0947\3\2\2\2\u0949\u094a\3\2\2\2\u094a\u094d\3\2\2\2\u094b\u0949\3\2"+
		"\2\2\u094c\u094e\7\u00bf\2\2\u094d\u094c\3\2\2\2\u094d\u094e\3\2\2\2\u094e"+
		"\u094f\3\2\2\2\u094f\u0950\7\u00c7\2\2\u0950\u01bb\3\2\2\2\u0951\u0952"+
		"\7\66\2\2\u0952\u0953\5\u0124\u0093\2\u0953\u0954\7g\2\2\u0954\u0958\5"+
		"\u01a0\u00d1\2\u0955\u0957\5\u01be\u00e0\2\u0956\u0955\3\2\2\2\u0957\u095a"+
		"\3\2\2\2\u0958\u0956\3\2\2\2\u0958\u0959\3\2\2\2\u0959\u095b\3\2\2\2\u095a"+
		"\u0958\3\2\2\2\u095b\u095c\7$\2\2\u095c\u095d\5\u01a0\u00d1\2\u095d\u01bd"+
		"\3\2\2\2\u095e\u095f\7%\2\2\u095f\u0960\5\u0124\u0093\2\u0960\u0961\7"+
		"g\2\2\u0961\u0962\5\u01a0\u00d1\2\u0962\u01bf\3\2\2\2\u0963\u0964\7\26"+
		"\2\2\u0964\u0965\5\u0124\u0093\2\u0965\u0966\7\u00be\2\2\u0966\u0969\5"+
		"\u01c2\u00e2\2\u0967\u0968\7\u00bc\2\2\u0968\u096a\5\u01c6\u00e4\2\u0969"+
		"\u0967\3\2\2\2\u0969\u096a\3\2\2\2\u096a\u096b\3\2\2\2\u096b\u096c\7&"+
		"\2\2\u096c\u01c1\3\2\2\2\u096d\u0972\5\u01c4\u00e3\2\u096e\u096f\7\u00bc"+
		"\2\2\u096f\u0971\5\u01c4\u00e3\2\u0970\u096e\3\2\2\2\u0971\u0974\3\2\2"+
		"\2\u0972\u0970\3\2\2\2\u0972\u0973\3\2\2\2\u0973\u01c3\3\2\2\2\u0974\u0972"+
		"\3\2\2\2\u0975\u0976\5\u021a\u010e\2\u0976\u0977\7\u00ba\2\2\u0977\u0978"+
		"\5\u01a0\u00d1\2\u0978\u01c5\3\2\2\2\u0979\u097a\7U\2\2\u097a\u097b\7"+
		"\u00ba\2\2\u097b\u097c\5\u01a0\u00d1\2\u097c\u01c7\3\2\2\2\u097d\u097e"+
		"\7\61\2\2\u097e\u097f\5\u021c\u010f\2\u097f\u0980\7\67\2\2\u0980\u0981"+
		"\5\u0124\u0093\2\u0981\u0982\7 \2\2\u0982\u0983\5\u01a0\u00d1\2\u0983"+
		"\u01c9\3\2\2\2\u0984\u0985\7\61\2\2\u0985\u0986\7\16\2\2\u0986\u0987\5"+
		"\u01fa\u00fe\2\u0987\u0988\7\6\2\2\u0988\u0989\5\u0124\u0093\2\u0989\u098a"+
		"\7 \2\2\u098a\u098b\5\u01a0\u00d1\2\u098b\u01cb\3\2\2\2\u098c\u098d\7"+
		"\61\2\2\u098d\u098e\7\u00d1\2\2\u098e\u098f\7\u00b0\2\2\u098f\u0990\5"+
		"\u0124\u0093\2\u0990\u0991\7j\2\2\u0991\u0994\5\u0124\u0093\2\u0992\u0993"+
		"\7\24\2\2\u0993\u0995\5\u0124\u0093\2\u0994\u0992\3\2\2\2\u0994\u0995"+
		"\3\2\2\2\u0995\u0996\3\2\2\2\u0996\u0997\7 \2\2\u0997\u0998\5\u01a0\u00d1"+
		"\2\u0998\u01cd\3\2\2\2\u0999\u099a\7t\2\2\u099a\u099b\5\u0124\u0093\2"+
		"\u099b\u099c\7 \2\2\u099c\u099d\5\u01a0\u00d1\2\u099d\u01cf\3\2\2\2\u099e"+
		"\u099f\7\u00b2\2\2\u099f\u09a0\7\u00c6\2\2\u09a0\u09a5\5\u01a0\u00d1\2"+
		"\u09a1\u09a2\7\u00bc\2\2\u09a2\u09a4\5\u01a0\u00d1\2\u09a3\u09a1\3\2\2"+
		"\2\u09a4\u09a7\3\2\2\2\u09a5\u09a3\3\2\2\2\u09a5\u09a6\3\2\2\2\u09a6\u09a8"+
		"\3\2\2\2\u09a7\u09a5\3\2\2\2\u09a8\u09a9\7\u00c7\2\2\u09a9\u01d1\3\2\2"+
		"\2\u09aa\u09ab\5\u0194\u00cb\2\u09ab\u09ad\7\u00c6\2\2\u09ac\u09ae\5\u0122"+
		"\u0092\2\u09ad\u09ac\3\2\2\2\u09ad\u09ae\3\2\2\2\u09ae\u09af\3\2\2\2\u09af"+
		"\u09b0\7\u00c7\2\2\u09b0\u01d3\3\2\2\2\u09b1\u09b3\7`\2\2\u09b2\u09b4"+
		"\5\u0124\u0093\2\u09b3\u09b2\3\2\2\2\u09b3\u09b4\3\2\2\2\u09b4\u01d5\3"+
		"\2\2\2\u09b5\u09b6\5\u01d8\u00ed\2\u09b6\u09b7\7\u00bd\2\2\u09b7\u09b9"+
		"\3\2\2\2\u09b8\u09b5\3\2\2\2\u09b8\u09b9\3\2\2\2\u09b9\u09ba\3\2\2\2\u09ba"+
		"\u09bb\5\u01d2\u00ea\2\u09bb\u01d7\3\2\2\2\u09bc\u09bd\b\u00ed\1\2\u09bd"+
		"\u09c1\5\u0170\u00b9\2\u09be\u09c1\5\u016e\u00b8\2\u09bf\u09c1\5\u0194"+
		"\u00cb\2\u09c0\u09bc\3\2\2\2\u09c0\u09be\3\2\2\2\u09c0\u09bf\3\2\2\2\u09c1"+
		"\u09cd\3\2\2\2\u09c2\u09c3\f\7\2\2\u09c3\u09c5\7\u00c6\2\2\u09c4\u09c6"+
		"\5\u0122\u0092\2\u09c5\u09c4\3\2\2\2\u09c5\u09c6\3\2\2\2\u09c6\u09c7\3"+
		"\2\2\2\u09c7\u09cc\7\u00c7\2\2\u09c8\u09c9\f\6\2\2\u09c9\u09ca\7\u00bd"+
		"\2\2\u09ca\u09cc\7\u00d1\2\2\u09cb\u09c2\3\2\2\2\u09cb\u09c8\3\2\2\2\u09cc"+
		"\u09cf\3\2\2\2\u09cd\u09cb\3\2\2\2\u09cd\u09ce\3\2\2\2\u09ce\u01d9\3\2"+
		"\2\2\u09cf\u09cd\3\2\2\2\u09d0\u09d1\5\u01d8\u00ed\2\u09d1\u09d2\7\u00bd"+
		"\2\2\u09d2\u09d3\7\u00d1\2\2\u09d3\u01db\3\2\2\2\u09d4\u09d5\5\u01d8\u00ed"+
		"\2\u09d5\u09d7\7\u00c6\2\2\u09d6\u09d8\5\u0122\u0092\2\u09d7\u09d6\3\2"+
		"\2\2\u09d7\u09d8\3\2\2\2\u09d8\u09d9\3\2\2\2\u09d9\u09da\7\u00c7\2\2";
	private static final String _serializedATNSegment1 =
		"\u09da\u01dd\3\2\2\2\u09db\u09dc\7\u00c8\2\2\u09dc\u09dd\5\u00d6l\2\u09dd"+
		"\u09de\7\u00cb\2\2\u09de\u01df\3\2\2\2\u09df\u09e0\7\u0094\2\2\u09e0\u09e1"+
		"\7\u00c6\2\2\u09e1\u09e2\5\u0124\u0093\2\u09e2\u09e3\7\u00c7\2\2\u09e3"+
		"\u01e1\3\2\2\2\u09e4\u09e5\7\u0095\2\2\u09e5\u09e6\7\u00c6\2\2\u09e6\u09e7"+
		"\5\u0124\u0093\2\u09e7\u09e8\7\u00c7\2\2\u09e8\u01e3\3\2\2\2\u09e9\u09ea"+
		"\7\u0096\2\2\u09ea\u09eb\7\u00c6\2\2\u09eb\u09ec\5\u0124\u0093\2\u09ec"+
		"\u09ed\7\u00c7\2\2\u09ed\u01e5\3\2\2\2\u09ee\u09ef\7\u0097\2\2\u09ef\u09f0"+
		"\7\u00c6\2\2\u09f0\u09f1\5\u0124\u0093\2\u09f1\u09f2\7\u00c7\2\2\u09f2"+
		"\u01e7\3\2\2\2\u09f3\u09f4\7\u008f\2\2\u09f4\u09f5\7\u00c6\2\2\u09f5\u09f6"+
		"\5\u0124\u0093\2\u09f6\u09f7\7\u00c7\2\2\u09f7\u09f8\5\u01a0\u00d1\2\u09f8"+
		"\u01e9\3\2\2\2\u09f9\u09fa\7\u008e\2\2\u09fa\u09fb\7\u00c6\2\2\u09fb\u09fc"+
		"\5\u0124\u0093\2\u09fc\u09fd\7\u00c7\2\2\u09fd\u09fe\5\u01a0\u00d1\2\u09fe"+
		"\u01eb\3\2\2\2\u09ff\u0a00\7\17\2\2\u0a00\u0a01\5\u01a0\u00d1\2\u0a01"+
		"\u0a02\7\67\2\2\u0a02\u0a03\5\u01a0\u00d1\2\u0a03\u01ed\3\2\2\2\u0a04"+
		"\u0a05\7m\2\2\u0a05\u0a06\5\u021c\u010f\2\u0a06\u0a07\7s\2\2\u0a07\u0a08"+
		"\5\u01a0\u00d1\2\u0a08\u0a09\7\67\2\2\u0a09\u0a0a\5\u01a0\u00d1\2\u0a0a"+
		"\u01ef\3\2\2\2\u0a0b\u0a0c\7h\2\2\u0a0c\u0a0d\5\u01f2\u00fa\2\u0a0d\u0a0e"+
		"\7\67\2\2\u0a0e\u0a0f\5\u01a0\u00d1\2\u0a0f\u01f1\3\2\2\2\u0a10\u0a11"+
		"\7\u00ca\2\2\u0a11\u0a12\5\u021c\u010f\2\u0a12\u0a13\7\u00b7\2\2\u0a13"+
		"\u0a1b\5\u01a0\u00d1\2\u0a14\u0a15\7\u00bc\2\2\u0a15\u0a16\5\u021c\u010f"+
		"\2\u0a16\u0a17\7\u00b7\2\2\u0a17\u0a18\5\u01a0\u00d1\2\u0a18\u0a1a\3\2"+
		"\2\2\u0a19\u0a14\3\2\2\2\u0a1a\u0a1d\3\2\2\2\u0a1b\u0a19\3\2\2\2\u0a1b"+
		"\u0a1c\3\2\2\2\u0a1c\u0a1e\3\2\2\2\u0a1d\u0a1b\3\2\2\2\u0a1e\u0a1f\7\u00cb"+
		"\2\2\u0a1f\u01f3\3\2\2\2\u0a20\u0a22\7,\2\2\u0a21\u0a23\5\u0124\u0093"+
		"\2\u0a22\u0a21\3\2\2\2\u0a22\u0a23\3\2\2\2\u0a23\u01f5\3\2\2\2\u0a24\u0a25"+
		"\7(\2\2\u0a25\u01f7\3\2\2\2\u0a26\u0a27\7c\2\2\u0a27\u01f9\3\2\2\2\u0a28"+
		"\u0a29\b\u00fe\1\2\u0a29\u0a31\5\u01fc\u00ff\2\u0a2a\u0a31\5\u01fe\u0100"+
		"\2\u0a2b\u0a31\5\u0200\u0101\2\u0a2c\u0a31\5\u0204\u0103\2\u0a2d\u0a31"+
		"\5\u0208\u0105\2\u0a2e\u0a31\5\u0210\u0109\2\u0a2f\u0a31\5\u0212\u010a"+
		"\2\u0a30\u0a28\3\2\2\2\u0a30\u0a2a\3\2\2\2\u0a30\u0a2b\3\2\2\2\u0a30\u0a2c"+
		"\3\2\2\2\u0a30\u0a2d\3\2\2\2\u0a30\u0a2e\3\2\2\2\u0a30\u0a2f\3\2\2\2\u0a31"+
		"\u0a3d\3\2\2\2\u0a32\u0a33\f\t\2\2\u0a33\u0a34\7q\2\2\u0a34\u0a3c\5\u01fa"+
		"\u00fe\n\u0a35\u0a36\f\7\2\2\u0a36\u0a37\7\u00af\2\2\u0a37\u0a3c\5\u01fa"+
		"\u00fe\b\u0a38\u0a39\f\5\2\2\u0a39\u0a3a\7K\2\2\u0a3a\u0a3c\5\u01fa\u00fe"+
		"\6\u0a3b\u0a32\3\2\2\2\u0a3b\u0a35\3\2\2\2\u0a3b\u0a38\3\2\2\2\u0a3c\u0a3f"+
		"\3\2\2\2\u0a3d\u0a3b\3\2\2\2\u0a3d\u0a3e\3\2\2\2\u0a3e\u01fb\3\2\2\2\u0a3f"+
		"\u0a3d\3\2\2\2\u0a40\u0a41\t\7\2\2\u0a41\u01fd\3\2\2\2\u0a42\u0a43\7\u00c6"+
		"\2\2\u0a43\u0a44\5\u0124\u0093\2\u0a44\u0a45\7\u00c7\2\2\u0a45\u0a48\3"+
		"\2\2\2\u0a46\u0a48\5\u0198\u00cd\2\u0a47\u0a42\3\2\2\2\u0a47\u0a46\3\2"+
		"\2\2\u0a48\u01ff\3\2\2\2\u0a49\u0a4b\7\u00ca\2\2\u0a4a\u0a4c\5\u021a\u010e"+
		"\2\u0a4b\u0a4a\3\2\2\2\u0a4b\u0a4c\3\2\2\2\u0a4c\u0a4d\3\2\2\2\u0a4d\u0a4e"+
		"\7\u00cb\2\2\u0a4e\u0201\3\2\2\2\u0a4f\u0a50\5\u01fa\u00fe\2\u0a50\u0a51"+
		"\7q\2\2\u0a51\u0a52\5\u01fa\u00fe\2\u0a52\u0203\3\2\2\2\u0a53\u0a55\7"+
		"\u00c8\2\2\u0a54\u0a56\5\u021a\u010e\2\u0a55\u0a54\3\2\2\2\u0a55\u0a56"+
		"\3\2\2\2\u0a56\u0a57\3\2\2\2\u0a57\u0a58\7\u00c9\2\2\u0a58\u0205\3\2\2"+
		"\2\u0a59\u0a5a\5\u01fa\u00fe\2\u0a5a\u0a5b\7\u00af\2\2\u0a5b\u0a5c\5\u01fa"+
		"\u00fe\2\u0a5c\u0207\3\2\2\2\u0a5d\u0a5e\7\u00ca\2\2\u0a5e\u0a5f\5\u020a"+
		"\u0106\2\u0a5f\u0a60\7\u00cb\2\2\u0a60\u0a65\3\2\2\2\u0a61\u0a62\7\u00ca"+
		"\2\2\u0a62\u0a63\7\u00b7\2\2\u0a63\u0a65\7\u00cb\2\2\u0a64\u0a5d\3\2\2"+
		"\2\u0a64\u0a61\3\2\2\2\u0a65\u0209\3\2\2\2\u0a66\u0a6b\5\u020c\u0107\2"+
		"\u0a67\u0a68\7\u00bc\2\2\u0a68\u0a6a\5\u020c\u0107\2\u0a69\u0a67\3\2\2"+
		"\2\u0a6a\u0a6d\3\2\2\2\u0a6b\u0a69\3\2\2\2\u0a6b\u0a6c\3\2\2\2\u0a6c\u020b"+
		"\3\2\2\2\u0a6d\u0a6b\3\2\2\2\u0a6e\u0a6f\5\u01fa\u00fe\2\u0a6f\u0a70\7"+
		"\u00b7\2\2\u0a70\u0a71\5\u01fa\u00fe\2\u0a71\u020d\3\2\2\2\u0a72\u0a73"+
		"\5\u01fa\u00fe\2\u0a73\u0a74\7K\2\2\u0a74\u0a75\5\u01fa\u00fe\2\u0a75"+
		"\u020f\3\2\2\2\u0a76\u0a77\7I\2\2\u0a77\u0a78\7\u00c6\2\2\u0a78\u0a79"+
		"\5\u01fa\u00fe\2\u0a79\u0a7a\7\u00bc\2\2\u0a7a\u0a7b\5\u021a\u010e\2\u0a7b"+
		"\u0a7c\7\u00c7\2\2\u0a7c\u0211\3\2\2\2\u0a7d\u0a7e\5\u015c\u00af\2\u0a7e"+
		"\u0a7f\7\u00c6\2\2\u0a7f\u0a80\5\u021a\u010e\2\u0a80\u0a81\7\u00c7\2\2"+
		"\u0a81\u0213\3\2\2\2\u0a82\u0a83\7\177\2\2\u0a83\u0a84\7\u00d1\2\2\u0a84"+
		"\u0a85\7\u00c6\2\2\u0a85\u0a86\5\u0216\u010c\2\u0a86\u0a87\7\u00c7\2\2"+
		"\u0a87\u0215\3\2\2\2\u0a88\u0a8d\5\u0218\u010d\2\u0a89\u0a8a\7\u00bc\2"+
		"\2\u0a8a\u0a8c\5\u0218\u010d\2\u0a8b\u0a89\3\2\2\2\u0a8c\u0a8f\3\2\2\2"+
		"\u0a8d\u0a8b\3\2\2\2\u0a8d\u0a8e\3\2\2\2\u0a8e\u0217\3\2\2\2\u0a8f\u0a8d"+
		"\3\2\2\2\u0a90\u0a91\7\u00d1\2\2\u0a91\u0a92\7\u00b7\2\2\u0a92\u0a93\5"+
		"\u01fa\u00fe\2\u0a93\u0219\3\2\2\2\u0a94\u0a99\5\u01fa\u00fe\2\u0a95\u0a96"+
		"\7\u00bc\2\2\u0a96\u0a98\5\u01fa\u00fe\2\u0a97\u0a95\3\2\2\2\u0a98\u0a9b"+
		"\3\2\2\2\u0a99\u0a97\3\2\2\2\u0a99\u0a9a\3\2\2\2\u0a9a\u021b\3\2\2\2\u0a9b"+
		"\u0a99\3\2\2\2\u0a9c\u0a9f\5\u01fa\u00fe\2\u0a9d\u0a9f\5\u021e\u0110\2"+
		"\u0a9e\u0a9c\3\2\2\2\u0a9e\u0a9d\3\2\2\2\u0a9f\u021d\3\2\2\2\u0aa0\u0aa4"+
		"\5\u0220\u0111\2\u0aa1\u0aa4\5\u0222\u0112\2\u0aa2\u0aa4\5\u0224\u0113"+
		"\2\u0aa3\u0aa0\3\2\2\2\u0aa3\u0aa1\3\2\2\2\u0aa3\u0aa2\3\2\2\2\u0aa4\u021f"+
		"\3\2\2\2\u0aa5\u0aa6\5\u01fa\u00fe\2\u0aa6\u0aa7\7\6\2\2\u0aa7\u0aa8\5"+
		"\u0124\u0093\2\u0aa8\u0221\3\2\2\2\u0aa9\u0aaa\5\u01fa\u00fe\2\u0aaa\u0aab"+
		"\7\7\2\2\u0aab\u0aac\5\u0124\u0093\2\u0aac\u0223\3\2\2\2\u0aad\u0aae\5"+
		"\u01fa\u00fe\2\u0aae\u0aaf\7\u00be\2\2\u0aaf\u0ab0\5Z.\2\u0ab0\u0225\3"+
		"\2\2\2\u0ab1\u0ab6\5\u0228\u0115\2\u0ab2\u0ab3\7\u00bc\2\2\u0ab3\u0ab5"+
		"\5\u0228\u0115\2\u0ab4\u0ab2\3\2\2\2\u0ab5\u0ab8\3\2\2\2\u0ab6\u0ab4\3"+
		"\2\2\2\u0ab6\u0ab7\3\2\2\2\u0ab7\u0227\3\2\2\2\u0ab8\u0ab6\3\2\2\2\u0ab9"+
		"\u0abd\5\u022a\u0116\2\u0aba\u0abd\5\u022c\u0117\2\u0abb\u0abd\5\u022e"+
		"\u0118\2\u0abc\u0ab9\3\2\2\2\u0abc\u0aba\3\2\2\2\u0abc\u0abb\3\2\2\2\u0abd"+
		"\u0229\3\2\2\2\u0abe\u0abf\5\u021a\u010e\2\u0abf\u0ac0\7\6\2\2\u0ac0\u0ac1"+
		"\5\u0124\u0093\2\u0ac1\u022b\3\2\2\2\u0ac2\u0ac3\5\u021a\u010e\2\u0ac3"+
		"\u0ac4\7\7\2\2\u0ac4\u0ac5\5\u0124\u0093\2\u0ac5\u022d\3\2\2\2\u0ac6\u0ac7"+
		"\5\u021a\u010e\2\u0ac7\u0ac8\7\u00be\2\2\u0ac8\u0ac9\5Z.\2\u0ac9\u022f"+
		"\3\2\2\2\u0aca\u0acf\5\u0224\u0113\2\u0acb\u0acc\7\u00bc\2\2\u0acc\u0ace"+
		"\5\u0224\u0113\2\u0acd\u0acb\3\2\2\2\u0ace\u0ad1\3\2\2\2\u0acf\u0acd\3"+
		"\2\2\2\u0acf\u0ad0\3\2\2\2\u0ad0\u0231\3\2\2\2\u0ad1\u0acf\3\2\2\2\u00e9"+
		"\u0235\u023a\u023c\u0242\u0248\u0252\u025d\u025f\u0265\u026d\u0271\u0276"+
		"\u027b\u027d\u0285\u0289\u028e\u0292\u029a\u029e\u02a2\u02a6\u02aa\u02b2"+
		"\u02b6\u02bb\u02bf\u02c8\u02ca\u02d0\u02d8\u02dc\u02df\u02e9\u02ed\u02f9"+
		"\u02fd\u0301\u030c\u0319\u031d\u031f\u0324\u032d\u0332\u0335\u0340\u0347"+
		"\u034c\u0354\u035c\u0362\u0365\u0367\u036a\u036d\u036f\u0372\u0379\u0380"+
		"\u0390\u0398\u039a\u039d\u03a0\u03a3\u03b1\u03be\u03c5\u03c7\u03c9\u03df"+
		"\u03e7\u03ea\u03f1\u03f8\u0400\u040a\u0414\u0422\u042f\u044c\u044f\u0452"+
		"\u0460\u0464\u0466\u046e\u0472\u0474\u0477\u047e\u048a\u0491\u0495\u049d"+
		"\u04a2\u04a5\u04a8\u04b5\u04ba\u04c0\u04c5\u04c8\u04cb\u04d3\u04e6\u04ee"+
		"\u04f7\u04fd\u0501\u0507\u0511\u051c\u0523\u052d\u0530\u0535\u053a\u053d"+
		"\u0541\u0546\u054b\u054e\u0551\u0554\u055c\u0562\u0568\u0570\u057f\u0582"+
		"\u0586\u0589\u058c\u058f\u0592\u0594\u059d\u05a7\u05af\u05b3\u05b7\u05bb"+
		"\u05df\u05e7\u05ef\u05fa\u0602\u0607\u060b\u0616\u0623\u0626\u062b\u0638"+
		"\u064c\u0685\u0699\u06a3\u070b\u070d\u071d\u072d\u0731\u073d\u074e\u0757"+
		"\u078a\u078f\u07af\u07c5\u07d6\u07dd\u07e9\u07f7\u07ff\u080c\u0818\u082b"+
		"\u0840\u084a\u084f\u08a1\u08a7\u08b9\u08bb\u08e2\u08ee\u08f3\u08f9\u0901"+
		"\u090b\u0916\u091e\u0922\u092c\u0936\u093a\u0949\u094d\u0958\u0969\u0972"+
		"\u0994\u09a5\u09ad\u09b3\u09b8\u09c0\u09c5\u09cb\u09cd\u09d7\u0a1b\u0a22"+
		"\u0a30\u0a3b\u0a3d\u0a47\u0a4b\u0a55\u0a64\u0a6b\u0a8d\u0a99\u0a9e\u0aa3"+
		"\u0ab6\u0abc\u0acf";
	public static final String _serializedATN = Utils.join(
		new String[] {
			_serializedATNSegment0,
			_serializedATNSegment1
		},
		""
	);
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}