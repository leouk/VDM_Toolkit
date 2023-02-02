 /**
 * ANTLR4 parsing rules for the VDM-SL language
 * @author Leo Freitas
 * @date 2023.01.27
 * @copyright Copyright 2019-2022 Leo Freitas 
 * @thanks Paolo Masci for suggesting an VDM-SL ANTLR grammar
 *
 * This software calls the following third-party software, which is subject to the
 * terms and conditions of its licensor, as applicable:
 *
 * ANTLR (ANother Tool for Language Recognition)
 * BSD 3-Clause
 * https://github.com/antlr/antlr4/blob/master/LICENSE.txt
 *
 * Disclaimers
 *
 * No Warranty: THE SUBJECT SOFTWARE IS PROVIDED "AS IS" WITHOUT ANY
 * WARRANTY OF ANY KIND, EITHER EXPRESSED, IMPLIED, OR STATUTORY,
 * INCLUDING, BUT NOT LIMITED TO, ANY WARRANTY THAT THE SUBJECT SOFTWARE
 * WILL CONFORM TO SPECIFICATIONS, ANY IMPLIED WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, OR FREEDOM FROM
 * INFRINGEMENT, ANY WARRANTY THAT THE SUBJECT SOFTWARE WILL BE ERROR
 * FREE, OR ANY WARRANTY THAT DOCUMENTATION, IF PROVIDED, WILL CONFORM TO
 * THE SUBJECT SOFTWARE. THIS AGREEMENT DOES NOT, IN ANY MANNER,
 * CONSTITUTE AN ENDORSEMENT BY GOVERNMENT AGENCY OR ANY PRIOR RECIPIENT
 * OF ANY RESULTS, RESULTING DESIGNS, HARDWARE, SOFTWARE PRODUCTS OR ANY
 * OTHER APPLICATIONS RESULTING FROM USE OF THE SUBJECT SOFTWARE.
 * FURTHER, GOVERNMENT AGENCY DISCLAIMS ALL WARRANTIES AND LIABILITIES
 * REGARDING THIRD-PARTY SOFTWARE, IF PRESENT IN THE ORIGINAL SOFTWARE,
 * AND DISTRIBUTES IT "AS IS."
 *
 * Waiver and Indemnity: RECIPIENT AGREES TO WAIVE ANY AND ALL CLAIMS
 * AGAINST THE UNITED STATES GOVERNMENT, ITS CONTRACTORS AND
 * SUBCONTRACTORS, AS WELL AS ANY PRIOR RECIPIENT.  IF RECIPIENT'S USE OF
 * THE SUBJECT SOFTWARE RESULTS IN ANY LIABILITIES, DEMANDS, DAMAGES,
 * EXPENSES OR LOSSES ARISING FROM SUCH USE, INCLUDING ANY DAMAGES FROM
 * PRODUCTS BASED ON, OR RESULTING FROM, RECIPIENT'S USE OF THE SUBJECT
 * SOFTWARE, RECIPIENT SHALL INDEMNIFY AND HOLD HARMLESS THE UNITED
 * STATES GOVERNMENT, ITS CONTRACTORS AND SUBCONTRACTORS, AS WELL AS ANY
 * PRIOR RECIPIENT, TO THE EXTENT PERMITTED BY LAW.  RECIPIENT'S SOLE
 * REMEDY FOR ANY SUCH MATTER SHALL BE THE IMMEDIATE, UNILATERAL
 * TERMINATION OF THIS AGREEMENT.
 */
 
grammar VDM;
import VDMLex;
// options 
// {
//     tokenVocab = VDMLex;
// }

//------------------------
// Parser Rules (ATTN: in antlr, all parser rules start with a small letter)
//
// To test it: 
// * download antlr4 tools: pip3 install antlr4-tools
// * switch to java 11 if necessary (ANTLR *must* compile to Java 11)
// * run parser on grammar: antlr4 VdmSLParser.g4
// * run visualisation    : antlr4-parse VdmSLParser.g4 sl_document -gui
// * type the program of interest followed by Control-D
// * you get the GUI for the current grammar.
//------------------------

//------------------------
// * switch to java11
// * Generate parser : antlr4 VDM.g4 VDMLex.g4 -listener -visitor -o ./output
//                     antlr4-pare VDM.g4 sl_document -gui GIVE_OUTPUT CTRL+D
// * Play with parser: grun VDM -tree / -gui

//------------------------
// A.1 VDM-SL document
//------------------------
sl_document 
    : module+ 
    | sl_definition_block+
    ;

//------------------------
// A.1.1 Module, imports and exports 
//------------------------
module
    : SLK_module IDENTIFIER sl_interface module_body? SLK_end IDENTIFIER
    ;

sl_interface
    : import_definition_list export_definition;

import_definition_list 
    : SLK_imports import_definition (',' import_definition)*
    ;

import_definition
    : SLK_from IDENTIFIER import_module_signature
    ; 

import_module_signature
    : SLK_all 
    | import_signature+
    ;  

import_signature
    : import_types_signature
    | import_values_signature 
    | import_functions_signature
    | import_operations_signature 
    ;

import_types_signature
    : SLK_types type_import (';' type_import)* ';'?
    ;

type_import
    : name (SLK_renamed name)?
    | type_definition (SLK_renamed name)?
    ;

import_values_signature
    : SLK_values value_import (';' value_import)* ';'?
    ;

value_import 
    : name (':' type)? (SLK_renamed name)?
    ;

import_functions_signature
    : SLK_functions function_import (';' function_import)* ';'?
    ;

function_import     
    : name (type_variable_list? ':' function_type)? (SLK_renamed name)?
    ;

import_operations_signature 
    : SLK_operations operation_import (';' operation_import)* ';'?
    ;

operation_import 
    : name (':' operation_type)? (SLK_renamed name)?
    ;

export_definition 
    : SLK_exports export_module_signature
    ;

export_module_signature 
    : SLK_all
    | export_signature+
    ;

export_signature 
    : export_types_signature 
    | export_values_signature 
    | export_functions_signature 
    | export_operations_signature 
    ;

export_types_signature 
    : SLK_types type_export (';' type_export)* ';'?
    ;

type_export 
    : SLK_struct? name;

export_values_signature
    : SLK_values value_signature (';' value_signature)* ';'?
    ;

value_signature 
    : name_list ':' type
    ;

export_functions_signature 
    : SLK_functions function_signature (';' function_signature)* ';'?
    ;

function_signature
    : name_list type_variable_list? ':' function_type
    ;

export_operations_signature 
    : SLK_operations operation_signature (';' operation_signature)* ';';

operation_signature 
    : name_list ':' operation_type
    ;

module_body 
    : SLK_definitions sl_definition_block+
    ;

//------------------------
// A.2 VDM++ and VDM-RT document //TODO 
//------------------------

rt_document
    : (pp_class | system)+
    ;

//------------------------
// A.3 System 
//------------------------

system 
    : RTK_system IDENTIFIER rt_class_body? SLK_end IDENTIFIER
    ;

rt_class_body 
    : SLK_definitions rt_definition_block+
    ;

//------------------------
// A.3.1 Classes  
//------------------------

pp_class
    : PPK_class IDENTIFIER inheritance_clause? class_body? SLK_end IDENTIFIER
    ;

inheritance_clause 
    : SLK_is PPK_subclass SLK_of IDENTIFIER (',' IDENTIFIER)*
    ;

class_body 
    : SLK_definitions pp_definition_block+
    ;

//------------------------
// A.4 Definitions 
//------------------------

//TODO
rt_definition_block 
    : pp_definition_block 
    | synchronization_definitions
    | thread_definitions 
    ;

//TODO    
pp_definition_block 
    : pp_type_definitions
    //| state_definition 
    | pp_value_definitions 
    | pp_function_definitions
    | pp_operation_definitions
    | traces_definitions
    | instance_variable_definitions 
    ;

sl_definition_block
    : sl_type_definitions
    | state_definition 
    | sl_value_definitions 
    | sl_function_definitions
    | sl_operation_definitions
    | traces_definitions
    ;

//------------------------
// A.4.1 Type definitions  
//------------------------

//@NB will stop completing PP + RT for now. 
pp_type_definitions 
    : SLK_types access_type_definition
    ;

access_type_definition
    : (PPK_static? | access?) | (access? | PPK_static?) type_definition
    ;

access 
    : PPK_public | PPK_private | PPK_protected
    ;

sl_type_definitions 
    : SLK_types type_definition 
    ;

//@NB here added extra production to make parser faster; otherwise you will get
//    a look ahead on the identifier until the '=' or '::' to disambiguate. 
type_definition 
    : IDENTIFIER invariant_type_definition 
    ;

invariant_type_definition
    : '=' type type_specification
    | SEP_rec field+ type_specification
    ;

//@LF will this generate empty production and potential conflict? 
type_specification 
    : invariant? eq_clause? ord_clause?
    ;

// ANTLR4 allows left-recursive productions, so long as they have uniquely named 
// productions within the same rule. Thus, we cannot have union_type production 
// separately, but defined here directly.  
//
//@TODO This generates entry/exit for both entryQuoteType and entryQuote_type (!)
//      might want to remove the singleton productions? 
type 
    : bracketed_type    #BracketedType  
    | basic_type        #BasicType
    | quote_type        #QuoteType
    | composite_type    #CompositeType
    // | union_type        #UnionType
    | type (SEP_bar type)+ #UnionType
    // | product_type      #ProductType
    | type (O_TIMES type)+ #ProductType
    | optional_type     #OptionalType
    | set_type          #SetType
    | seq_type          #SeqType
    | map_type          #MapType
    // | function_type     #FunctionType
    | void_function_type #VoidFunctionType
    |<assoc=right> type SEP_pfcn type #PartialFunctionType
    |<assoc=right> type SEP_tfcn type #PartialFunctionType
    | type_name         #TypeName
    | type_variable     #TypeVariable
    ;

void_function_type
    :<assoc=right> '(' ')' (SEP_pfcn | SEP_tfcn) type
    ;

bracketed_type 
    : '(' type ')'
    ;

basic_type 
    : SLK_bool | SLK_nat | SLK_nat1 | SLK_int | SLK_rat | SLK_real | SLK_char | SLK_token
    ;

quote_type 
    : QUOTE_LITERAL
    ;

composite_type
    : SLK_compose IDENTIFIER SLK_of field+ SLK_end
    ;

//@NB here I am making the rule more efficient again without change to meaning 
field 
    : type 
    | (IDENTIFIER ':' '-'?) type
    ;

union_type 
    : type (SEP_bar type)+ 
    ;

product_type 
    : type (O_TIMES type)+ 
    ;

optional_type 
    : '[' type ']'
    ;

set_type 
    : set0_type | set1_type
    ;

set0_type
    : SLK_set SLK_of type
    ; 

set1_type
    : SLK_set1 SLK_of type
    ; 

seq_type 
    : seq0_type | seq1_type
    ;

seq0_type
    : SLK_seq SLK_of type
    ; 

seq1_type
    : SLK_seq1 SLK_of type
    ; 

map_type
    : general_map_type 
    | injective_map_type
    ;

general_map_type 
    : SLK_map type SLK_to type
    ;

injective_map_type 
    : SLK_inmap type SLK_to type
    ;

function_type 
    : partial_function_type
    | total_function_type 
    ;

partial_function_type 
    :<assoc=right> discretionary_type SEP_pfcn type 
    ;

total_function_type 
    :<assoc=right> discretionary_type SEP_tfcn type
    ;

discretionary_type 
    : '(' ')'   #VoidType
    | type      #FunctionType
    ;

type_name
    : name 
    ;

type_variable 
    : TYPE_VARIABLE_IDENTIFIER
    ;

invariant 
    : SLK_inv invariant_initial_function 
    ;

eq_clause
    : SLK_eq pattern O_EQUAL invariant_initial_function
    ;

ord_clause
    : SLK_ord pattern O_LT invariant_initial_function
    ;

//@NB refactored this one given equivalence
invariant_initial_function 
    : pattern SEP_def expression
    ;

//------------------------
// A.4.2 VDM-SL state definition
//------------------------

state_definition 
    : SLK_state IDENTIFIER SLK_of field+ invariant? initialisation? SLK_end ';'
    ;

initialisation 
    : SLK_init invariant_initial_function
    ;

//------------------------
// A.4.3 Value definitions
//------------------------

sl_value_definitions 
    : SLK_values value_definition
    ;

//@NB will stop completing PP + RT for now. 
pp_value_definitions 
    : SLK_values access_value_definition
    ;

access_value_definition
    : access? value_definition
    ;

value_definition 
    : pattern (':' type) '=' expression
    ;

//------------------------
// A.4.4 Function Definitions  
//------------------------

sl_function_definitions 
    : SLK_functions function_definition 
    ;

pp_function_definitions 
    : SLK_functions access_function_definition
    ;

access_function_definition 
    : access? function_definition
    ;

function_definition 
    : explicit_function_definition 
    | implicit_function_definition 
    | extended_explicit_function_definition
    ;

explicit_function_definition 
    : IDENTIFIER type_variable_list? ':' 
      function_type
      IDENTIFIER parameters+ 
      SEP_def function_body 
      pre_expression?
      post_expression?
      //@TODO should we have different productions for when measures are aorund? 
      measure_definition?
    ;

pre_expression 
    : SLK_pre expression
    ;

post_expression 
    : SLK_post expression
    ;

measure_definition 
    : SLK_measure measure_body
    ;

implicit_function_definition 
    : IDENTIFIER type_variable_list? 
      parameter_types
      identifier_type_pair_list 
      pre_expression?
      post_expression
    ;

extended_explicit_function_definition 
    : IDENTIFIER type_variable_list? 
      parameter_types 
      identifier_type_pair_list 
      pre_expression? 
      post_expression?
      measure_definition?
    ; 

//TODO should these comma separated lists be parameterised?
type_variable_list 
    : '[' TYPE_VARIABLE_IDENTIFIER (',' TYPE_VARIABLE_IDENTIFIER)* ']'
    ;

parameter_types 
    : '(' pattern_type_pair_list ')'
    ;

pattern_type_pair_list
    : pattern_list ':' type (',' pattern_list ':' type)*
    ;

identifier_type_pair_list
    : identifier_type_pair (',' identifier_type_pair)*
    ;

identifier_type_pair 
    : IDENTIFIER ':' type 
    ;

// parameters_list 
//     : parameters+ 
//     ;

parameters
    : '(' pattern_list? ')'
    ;

function_body 
    : expression 
    //TODO PPK_isr;
    | SLK_inys
    ;

measure_body
    : expression 
    | SLK_inys
    ;

//------------------------
// A.4.5 Operation Definitions  
//------------------------

sl_operation_definitions 
    : SLK_operations sl_access_operation_definition
    ;

sl_access_operation_definition
    : SLK_pure? operation_definition
    ;

pp_operation_definitions
    : SLK_operations pp_access_operation_definition
    ;

//@NB what happens if you reuse the same access muiltiple times like pure pure? 
//    was confused with the access_operation_definition rule given its multiple (kinds) but single 
//    use of access modifiers. (e.g. pure pure is bad, but public pure is okay)?  
pp_access_operation_definition 
    : (SLK_pure | access | PPK_static)? operation_definition
    ;

rt_operation_definitions
    : SLK_operations rt_access_operation_definition
    ;

rt_access_operation_definition 
    : (SLK_pure | RTK_async | access | PPK_static)? operation_definition
    ;

operation_definition 
    : explicit_operation_definition
    | implicit_operation_definition
    | extended_explicit_operation_definition
    ;

explicit_operation_definition 
    : IDENTIFIER ':' operation_type 
      IDENTIFIER parameters
      SEP_def operation_body
      pre_expression?
      post_expression?
    ;

implicit_operation_definition 
    : IDENTIFIER parameter_types
      identifier_type_pair_list?
      //@NB this is only needed beyond operations in RT's specification statement right? 
      implicit_operation_body
    ; 

implicit_operation_body 
    : externals?
      pre_expression?
      post_expression
      exceptions?
    ;

extended_explicit_operation_definition 
    : IDENTIFIER parameter_types
      identifier_type_pair_list?
      SEP_def operation_body 
      externals? 
      pre_expression?
      post_expression?
      exceptions?
    ;

operation_type
    : discretionary_type SEP_optype discretionary_type
    ;

operation_body 
    : statement 
    | SLK_inys
    //TODO | PPK_isr
    ;

externals 
    : SLK_ext var_information+
    ;

var_information
    : vdmmode name_list (':' type)?
    ;

// 'mode' is an ANTLR reserved word 
vdmmode
    : SLK_rd | SLK_wr
    ;
    
exceptions 
    : SLK_errs error+
    ;

error 
    //@NB arguably here the "token" is not the one for partial function but actually a different kind of '->'?
    : IDENTIFIER ':' expression /*SEP_pfcn*/'->' expression 
    ;

//------------------------
// A.4.6 Instance Variable Definitions  
//------------------------

instance_variable_definitions
    : PPK_instance PPK_variables 
      (instance_variable_definition (';' instance_variable_definition)*)?
    ;

instance_variable_definition
    : access_assignment_definition 
    | invariant_definition
    ;

access_assignment_definition
    : ((access? PPK_static?) | (PPK_static? access?))
      assignment_definition
    ;

invariant_definition
    : SLK_inv expression
    ;

//------------------------
// A.4.7 Synchronisation Definitions  
//------------------------

synchronization_definitions
    : RTK_sync synchronization?
    ;

//@NB why the rule here if defined by another one but never used elsewhere?
synchronization
    : permission_predicates
    ;

permission_predicates
    : RTK_per name '=>' expression
    | mutex_predicate
    ;

mutex_predicate
    : RTK_mutex '(' SLK_all | name_list ')'
    ; 

//------------------------
// A.4.8.Thread Definitions  
//------------------------

thread_definitions 
    : RTK_thread thread_definition?
    ;

thread_definition
    : periodic_thread_definition
    | procedural_thread_definition
    ;

periodic_thread_definition
    : periodic_obligation
    | sporadic_obligation
    ;

//@NB no separators between expressions? From examples there seems to be a comma? Grammar is wrong?
periodic_obligation
    : RTK_periodic '(' expression ',' expression ',' expression ',' expression ')' '(' name ')'
    ;

sporadic_obligation
    : RTK_sporadic '(' expression ',' expression ',' expression ',' expression ')' '(' name ')'
    ;

procedural_thread_definition
    : statement
    ;

//------------------------
// A.4.9.Traces Definitions  
//------------------------

traces_definitions 
    : SLK_traces named_trace_list*
    ;

named_trace_list 
    : named_trace (';' named_trace)*
    ;

named_trace 
    : IDENTIFIER ('/' IDENTIFIER)* ':' trace_definition_list
    ;

trace_definition_list 
    : trace_definition_term (';' trace_definition_term)*
    ;

trace_definition_term 
    : trace_definition ('|' trace_definition)*
    ;

trace_definition 
    : trace_binding_definition
    | trace_repeat_definition
    ;

trace_binding_definition
    : trace_let_def_binding
    | trace_let_best_binding
    ;

//TODO make this parameterised? 
trace_let_def_binding
    : SLK_let local_definition_list 
      SLK_in trace_definition 
    ;

trace_let_best_binding
    : SLK_let multiple_bind (SLK_best expression)? 
      SLK_in trace_definition 
    ;

trace_repeat_definition
    : trace_core_definition TRACE_REPEAT_PATTERN?;

trace_core_definition 
    : trace_apply_expression
    | trace_concurrent_expression
    | trace_bracketed_expression
    ;

trace_apply_expression 
    : call_statement
    ;

trace_concurrent_expression
    : SEP_parallel '(' trace_definition 
      ',' trace_definition 
      (',' trace_definition)* ')'
    ;

trace_bracketed_expression
    : '(' trace_definition_list ')'
    ;

//------------------------
// A.4.10 Annotation definitions
//------------------------

//TODO this is not quite right: no separation between --@ID etc. 
annotations 
    : SEP_ann IDENTIFIER '(' . ')' CR
    ;

//------------------------
// A.5 Expressions
//------------------------

expression_list 
    : expression (',' expression)*
    ;

// We must eliminate left-recursion, so have to have the whole tree in one place with labelled attributes :-( for now. 
expression 
    : bracketed_expression      #BracketedExpr
    | let_expression            #LetExpr
    | let_be_expression         #LetBestExpr
    | def_expression            #DefExpr
    | if_expression             #IfExpr
    | cases_expression          #CasesExpr
    | unary_expression          #UnaryExpr
//    | binary_expression         #BinaryExpr
    | expression O_EXP       expression #IterateExpr                               //@NB matches both 4**3 (exponentiation) and f**2 (relational iteration)?
    | expression O_TIMES     expression #ArithmeticMultiplicationExpr    
    | expression O_DIV       expression #ArithmeticDivideExpr    
    | expression SLK_div     expression #ArithmeticIntegerDivisionExpr    
    | expression SLK_rem     expression #ArithmeticReminderExpr    
    | expression SLK_mod     expression #ArithmeticModuloExpr    
    | expression O_PLUS      expression #ArithmeticPlusExpr
    | expression O_MINUS     expression #ArithmeticMinusExpr    
  
    | expression O_LEQ       expression #RelationalLessThanEqualExpr              //@LF allow for eager match on <= before for speed?    
    | expression O_LT        expression #RelationalLessThanExpr    
    | expression O_GEQ       expression #RelationalGreaterThanEqualExpr           //@LF allow for eager match on >= before for speed?    
    | expression O_GT        expression #RelationalGreaterThanExpr  
    | expression O_EQUAL     expression #RelationalEqualExpr    
    | expression O_NEQ       expression #RelationalNotEqualExpr

    | expression SLK_and     expression #LogicalAndExpr
    | expression SLK_or      expression #LogicalOrExpr
    | expression O_IMPLIES   expression #LogicalImpliesExpr
    | expression O_IFF       expression #LogicalIffExpr

    | expression SLK_ninset  expression #SetNotMemberExpr
    | expression SLK_inset   expression #SetMemberExpr
    | expression SLK_subset  expression #SetSubsetExpr
    | expression SLK_psubset expression #SetPSubsetExpr
    | expression O_DIFF      expression #SetDiffExpr                          
    | expression SLK_union   expression #SetUnionExpr
    | expression SLK_inter   expression #SetInterExpr

    | expression SLK_ninseq  expression #SeqNotMemberExpr
    | expression SLK_inseq   expression #SeqMemberExpr
    | expression O_CONCAT    expression #SeqConcatExpr
    | expression O_OVERRIDE  expression #MapSeqOverrideExpr

    | expression SLK_merge   expression #MapMergeExpr
    | expression O_NDRES     expression #MapDomFilterExpr
    | expression O_DRES      expression #MapDomRestricExpr
    | expression O_NRRES     expression #MapRngFilterExpr
    | expression O_RRES      expression #MapRngRestrictExpr
    | expression SLK_comp    expression #MapCompositionExpr

    | quantified_expression     #QuantifiedExpr
    | iota_expression           #IotaExpr
    | set_enumeration           #SetEnumExpr
    | set_comprehension         #SetCompExpr
    | set_range_expression      #SetRangeExpr
    | sequence_enumeration      #SeqEnumExpr
    | sequence_comprehension    #SeqCompExpr
//    | subsequence               #SubSeqExpr
    | expression '(' expression SEP_comma SEP_range SEP_comma expression ')' #SubSeqExpr

    | map_enumeration               #MapEnumExpr
    | map_comprehension             #MapCompExpr
    | tuple_constructor             #TupleMkExpr
    | record_constructor            #RecordMkExpr
    | record_modifier               #RecordMuExpr
//    | apply                         #ApplyExpr
    | expression '(' expression_list? ')' #ApplyExpr
//    | field_select                  #FieldSelExpr
    | expression SEP_dot IDENTIFIER     #FieldSelExpr
//    | tuple_select                  #TupleSelExpr
    | expression SEP_tsel NUMERAL   #TupleSelExpr
    | function_type_instantiation   #FunctionTypeInstExpr
    | lambda_expression             #LambdaExpr
    | narrow_expression             #NarrowExpr
    //TODO
    //| new_expression
    //| self_expression
    //| threadid_expression
    | general_is_expression         #GeneralIsExpr
    | undefined_expression          #UndefinedExpr
    | precondition_expression       #PreconditionExpr
    // //| isofbaseclass_expression
    // //| isofclass_expression
    // //| samebaseclass_expression
    // //| sameclass_expression
    // //| act_expression
    // //| fin_expression
    // //| active_expression
    // //| req_expression
    // //| waiting_expression
    // //| time_expression
    | name                          #NameExpr
    | old_name                      #OldNameExpr
    | SYMBOLIC_LITERAL              #SymbolicLitExpr
    ;

// expression 
//     : bracketed_expression      #BracketedExpr
//     | let_expression            #LetExpr
//     | let_be_expression         #LetBestExpr
//     | def_expression            #DefExpr
//     | if_expression             #IfExpr
//     | cases_expression          #CasesExpr
//     | unary_expression          #UnaryExpr
//     | binary_expression         #BinaryExpr
//     | quantified_expression     #QuantifiedExpr
//     | iota_expression           #IotaExpr
//     | set_enumeration           #SetEnumExpr
//     | set_comprehension         #SetCompExpr
//     | set_range_expression      #SetRangeExpr
//     | sequence_enumeration      #SeqEnumExpr
//     | sequence_comprehension    #SeqCompExpr
//     | subsequence               #SubSeqExpr
//     // | map_enumeration
//     // | map_comprehension
//     // | tuple_constructor
//     // | record_constructor
//     // | record_modifier
//     // | apply
//     // | field_select
//     // | tuple_select
//     // | function_type_instantiation
//     // | lambda_expression
//     // | narrow_expression
//     // //TODO
//     // //| new_expression
//     // //| self_expression
//     // //| threadid_expression
//     // | general_is_expression
//     // | undefined_expression
//     // | precondition_expression
//     // //| isofbaseclass_expression
//     // //| isofclass_expression
//     // //| samebaseclass_expression
//     // //| sameclass_expression
//     // //| act_expression
//     // //| fin_expression
//     // //| active_expression
//     // //| req_expression
//     // //| waiting_expression
//     // //| time_expression
//     // | name
//     // | old_name
//     // | symbolic_literal 
//     ;

//------------------------
// A.5.1 Bracketed Expression  
//------------------------

bracketed_expression
    : '(' expression ')'
    ;

//------------------------
// A.5.2 Local Binding Expressions  
//------------------------

let_expression 
    : SLK_let local_definition_list 
      SLK_in expression 
    ;

let_be_expression
    : SLK_let multiple_bind (SLK_best expression)? 
      SLK_in expression 
    ;

def_expression 
    : SLK_def pattern_bind '=' expression 
      (';' pattern_bind '=' expression)* ';'?
      SLK_in expression
    ;

//------------------------
// A.5.3 Conditional Expressions  
//------------------------

if_expression
    : SLK_if expression SLK_then expression 
      elseif_expression*
      SLK_else expression
    ;

elseif_expression 
    : SLK_elseif expression SLK_then expression
    ;

cases_expression
    : SLK_cases expression ':'
      cases_expression_alternatives
      (',' others_expression)? SLK_end
    ;

cases_expression_alternatives
    : cases_expression_alternative (',' cases_expression_alternative)*
    ;

cases_expression_alternative
    //@NB arguably here the "token" is not the one for partial function but actually a different kind of '->'?
    : pattern_list /*SEP_pfcn*/'->' expression 
    ;

others_expression
    : SLK_others /*SEP_pfcn*/'->' expression
    ;    

//------------------------
// A.5.4 Unary Expressions  
//------------------------

// Have the unary expression product with identifying rules for ease of listener/visitor traversals
// Unary appearing before binary makes them bind tigher (stronger) than binary, which is desirable. 
unary_expression 
    : O_PLUS       expression  #UnaryPlusExpr
    | O_MINUS      expression  #UnaryMinusExpr
    | SLK_abs      expression  #AbsoluteExpr
    | SLK_floor    expression  #FloorExpr
    | SLK_not      expression  #NotExpr
    | SLK_card     expression  #CardExpr
    | SLK_power    expression  #PowerExpr
    | SLK_dunion   expression  #DunionExpr
    | SLK_dinter   expression  #DinterExpr
    | SLK_hd       expression  #HdExpr
    | SLK_tl       expression  #TlExpr
    | SLK_len      expression  #LenExpr
    | SLK_elems    expression  #ElemsExpr
    | SLK_inds     expression  #IndsExpr
    | SLK_reverse  expression  #ReverseExpr
    | SLK_conc     expression  #ConcExpr
    | SLK_dom      expression  #DomExpr
    | SLK_rng      expression  #RngExpr
    | SLK_merge    expression  #MergeExpr
    | SLK_inverse  expression  #MapInverseExpr
    ;
    
/* 
unary_expression 
    : prefix_expression 
    //@NB why the need for map_inverse and not just have it as another kind of binary operator? 
    | map_inverse
    ;

prefix_expression 
    : unary_operator expression
    ;

//TODO have this a lex rule? 
unary_operator
    : O_PLUS
    | O_MINUS
    | SLK_abs
    | SLK_floor
    | SLK_not 
    | SLK_card
    | SLK_power
    | SLK_dunion
    | SLK_dinter 
    | SLK_hd
    | SLK_tl
    | SLK_len
    | SLK_elems
    | SLK_inds
    | SLK_reverse
    | SLK_conc
    | SLK_dom
    | SLK_rng
    | SLK_merge
    ;

map_inverse 
    : SLK_inverse expression;
*/

//------------------------
// A.5.5 Binary Expressions  
//------------------------

// Binary expressions will entail left-recursive rules, which require explicit labelling.
// Their order determine their binding power. I rearranged the VDM list of binary operators according to expected binding powers.
// See ANTLR4 Definitive guide section 5.4.
//@NB is this the right binding power order? 

// binary_expression
//     : expression O_EXP       expression //#IterateExpr                               //@NB matches both 4**3 (exponentiation) and f**2 (relational iteration)?//
//     | expression O_TIMES     expression //#ArithmeticMultiplicationExpr    
//     | expression O_DIV       expression //#ArithmeticDivideExpr    
//     | expression SLK_div     expression //#ArithmeticIntegerDivisionExpr    
//     | expression SLK_rem     expression //#ArithmeticReminderExpr    
//     | expression SLK_mod     expression //#ArithmeticModuloExpr    
//     | expression O_PLUS      expression //#ArithmeticPlusExpr
//     | expression O_MINUS     expression //#ArithmeticMinusExpr    
//   //
//     | expression O_LEQ       expression //#RelationalLessThanEqualExpr              //@LF allow for eager match on <= before for speed?    
//     | expression O_LT        expression //#RelationalLessThanExpr    
//     | expression O_GEQ       expression //#RelationalGreaterThanEqualExpr           //@LF allow for eager match on >= before for speed?    
//     | expression O_GT        expression //#RelationalGreaterThanExpr  
//     | expression O_EQUAL     expression //#RelationalEqualExpr    
//     | expression O_NEQ       expression //#RelationalNotEqualExpr
// //
//     | expression SLK_and     expression //#LogicalAndExpr
//     | expression SLK_or      expression //#LogicalOrExpr
//     | expression O_IMPLIES   expression //#LogicalImpliesExpr
//     | expression O_IFF       expression //#LogicalIffExpr
// //
//     | expression SLK_ninset  expression //#SetNotMemberExpr
//     | expression SLK_inset   expression //#SetMemberExpr
//     | expression SLK_subset  expression //#SetSubsetExpr
//     | expression SLK_psubset expression //#SetPSubsetExpr
//     | expression O_DIFF      expression //#SetDiffExpr                          
//     | expression SLK_union   expression //#SetUnionExpr
//     | expression SLK_inter   expression //#SetInterExpr
// //
//     | expression SLK_ninseq  expression //#SeqNotMemberExpr
//     | expression SLK_inseq   expression //#SeqMemberExpr
//     | expression O_CONCAT    expression //#SeqConcatExpr
//     | expression O_OVERRIDE  expression //#MapSeqOverrideExpr
// //
//     | expression SLK_merge   expression //#MapMergeExpr
//     | expression O_NDRES     expression //#MapDomFilterExpr
//     | expression O_DRES      expression //#MapDomRestricExpr
//     | expression O_NRRES     expression //#MapRngFilterExpr
//     | expression O_RRES      expression //#MapRngRestrictExpr
//     | expression SLK_comp    expression //#MapCompositionExpr
//     ;

//------------------------
// A.5.6 Quantified Expressions  
//------------------------

quantified_expression 
    : all_expression 
    | exists_expression 
    | exists_unique_expression 
    ;

all_expression
    : SLK_forall bind_list SEP_amp expression
    ;

exists_expression
    : SLK_exists bind_list SEP_amp expression
    ;

exists_unique_expression
    : SLK_exists1 bind SEP_amp expression
    ;

//------------------------
// A.5.7 Iota Expressions  
//------------------------

iota_expression 
    : SLK_iota bind SEP_amp expression
    ;

//------------------------
// A.5.8 Set Expressions  
//------------------------

set_enumeration 
    : BRACE_L expression_list BRACE_R
    ;

set_comprehension
    : BRACE_L expression SEP_bar bind_list (SEP_amp expression)? BRACE_R 
    ;

set_range_expression
    : BRACE_L expression SEP_comma SEP_range SEP_comma expression BRACE_R
    ;

//------------------------
// A.5.9 Seq Expressions  
//------------------------

sequence_enumeration 
    : BRACKET_L expression_list BRACKET_R
    ;

sequence_comprehension
    : BRACKET_L expression SEP_bar bind_list (SEP_amp expression)? BRACKET_R 
    ;

subsequence
    : expression '(' expression SEP_comma SEP_range SEP_comma expression ')'
    ;

//------------------------
// A.5.10 Map Expressions  
//------------------------

map_enumeration 
    : BRACE_L maplet (',' maplet) BRACE_R
    | BRACE_L SEP_maplet BRACE_R
    ;

maplet
    : expression SEP_maplet expression
    ;

map_comprehension
    : BRACE_L maplet SEP_bar bind_list (SEP_amp expression)? BRACE_R
    ;

//------------------------
// A.5.11 Tuple Constructor Expressions  
//------------------------

tuple_constructor
    : SLK_mk '(' expression ',' expression_list ')'
    ;

//------------------------
// A.5.12 Record Expressions  
//------------------------

//TODO how to enforce no delimiter between SLK_mk and name? 
record_constructor
    : SLK_mk name '(' expression_list? ')'
    ;

record_modifier
    : SLK_mu '(' expression ',' record_modification (',' record_modification)* ')'
    ;

record_modification
    : IDENTIFIER SEP_maplet expression
    ;

//------------------------
// A.5.13 Apply Expressions  
//------------------------

apply 
    : expression '(' expression_list? ')'
    ;

field_select 
    : expression '.' IDENTIFIER
    ;

tuple_select 
    : expression SEP_tsel NUMERAL
    ;

function_type_instantiation 
    : name BRACE_L type (',' type)* BRACE_R
    ;

//------------------------
// A.5.14 Lambda Expressions  
//------------------------

lambda_expression 
    : SLK_lambda type_bind_list SEP_amp expression 
    ;

//------------------------
// A.5.15 Narrow Expressions  
//------------------------

narrow_expression
    : SLK_narrow '(' expression ',' type ')'
    ;

//------------------------
// A.5.16 New Expressions  
//------------------------

new_expression
    : PPK_new name '(' expression_list? ')'
    ;

//------------------------
// A.5.17 Self Expressions  
//------------------------

self_expression
    : PPK_self
    ;

//------------------------
// A.5.18 Threadid Expressions  
//------------------------

threadid_expression
    : RTK_threadid
    ;

//------------------------
// A.5.19 Is Expressions  
//------------------------

general_is_expression 
    : is_expression 
    | type_judgement
    ;

//TODO no space between SLK_is and name/type
is_expression 
    : SLK_is SEP_underscore (name | basic_type) '(' expression ')'
    ;

type_judgement
    : SLK_is SEP_underscore '(' expression ',' type ')'
    ;

//------------------------
// A.5.20 Undefined Expressions  
//------------------------

undefined_expression
    : SLK_undefined
    ;

//------------------------
// A.5.21 Precondition Expressions  
//------------------------

precondition_expression 
    : SLK_pre SEP_underscore '(' expression_list ')'
    ;

//------------------------
// A.5.22 Base class membership Expressions  
//------------------------

isofbaseclass_expression
    : PPK_ibc SEP_underscore '(' name ',' expression ')'
    ;

//------------------------
// A.5.23 Class membership Expressions  
//------------------------

isofclass_expression
    : PPK_ioc '(' name ',' expression ')'
    ;

//------------------------
// A.5.24 Same base class membership Expressions  
//------------------------

samebaseclass_expression
    : PPK_sbc '(' name ',' expression ')'
    ;

//------------------------
// A.5.25 Same class membership Expressions  
//------------------------

sameclass_expression
    : PPK_sc '(' name ',' expression ')'
    ;

//------------------------
// A.5.26 History Expressions  
//------------------------

act_expression
    : RTK_act '(' name_list ')'
    ;

fin_expression
    : RTK_fin '(' name_list ')'
    ;
    
active_expression
    : RTK_active '(' name_list ')'
    ;
    
req_expression
    : RTK_req '(' name_list ')'
    ;
    
waiting_expression
    : RTK_waiting '(' name_list ')'
    ;

//------------------------
// A.5.27 Time Expressions  
//------------------------

time_expression
    : RTK_time
    ;

//------------------------
// A.5.28 Names  
//------------------------

name_list
    : name (',' name)*
    ;

name
    : IDENTIFIER (SEP_tick IDENTIFIER)?
    ;

old_name
    : IDENTIFIER SEP_old
    ;

//------------------------
// A.6 State Designators  
//------------------------

//@NB these are kind of expression names no? 

// Left-recursion requires inlining + labelling; order gives priority/precedence
state_designator
    : state_designator '.' IDENTIFIER      #FieldReferenceDesignator
    | state_designator '(' expression ')'  #MapSeqDesignator
    | name                                 #NameDesignator
    //: name
    //| field_reference               
    //| map_seq_reference
    ;

field_reference
    : state_designator '.' IDENTIFIER
    ;

map_seq_reference
    : state_designator '(' expression ')'
    ;

//------------------------
// A.7 Statements  
//------------------------

statement 
    : let_statement
    | let_be_statement
    | def_statement
    | block_statement
    | general_assignment_statement
    | if_statement
    | cases_statement
    | sequence_for_loop
    | set_for_loop
    | index_for_loop
    | while_loop
    | nondeterministic_statement
    | call_statement
    | specification_statement
    | start_statement
    | start_list_statement
    | stop_statement
    | stop_list_statement
    | duration_statement
    | cycles_statement
    | return_statement
    | always_statement
    | trap_statement
    | recursive_trap_statement
    | exit_statement
    | error_statement
    | identity_statement
    ;

//------------------------
// A.7.1 Local bindings statements  
//------------------------

let_statement 
    : SLK_let local_definition_list 
      SLK_in statement 
    ;

local_definition_list
    : local_definition (',' local_definition)*
    ;

local_definition 
    : value_definition
    | function_definition
    ;

let_be_statement
    : SLK_let multiple_bind (SLK_best expression)? 
      SLK_in statement 
    ;

def_statement 
    : SLK_def equals_definition_list ';'?
      SLK_in statement
    ;

equals_definition_list 
    : equals_definition (';' equals_definition)*
    ;

equals_definition 
    : pattern_bind '=' expression
    ;

//------------------------
// A.7.2 Block and Assignment Statements  
//------------------------

block_statement 
    : '(' dcl_statement*
      statement (';' statement)* ';'? ')'
      ;

dcl_statement 
    : SLK_dcl assignment_definition 
      (',' assignment_definition)* ';'
    ;

assignment_definition 
    : IDENTIFIER ':' type (SEP_assign expression)?
    ;

general_assignment_statement
    : assignment_statement
    | multiple_assign_statement
    ;

assignment_statement
    : state_designator SEP_assign expression
    ;

//@NB VDMJ tolerates dangling ';' as in atomic(x := nil; y := {};) [last semi shouldn't be allowed according to grammar? ]
multiple_assign_statement
    : SLK_atomic '(' assignment_statement ';' 
      assignment_statement 
      (';' assignment_statement)* 
      ';'? ')'
    ;

//------------------------
// A.7.3 Conditional Statements  
//------------------------

if_statement
    : SLK_if expression SLK_then statement 
      elseif_statement*
      SLK_else statement
    ;

elseif_statement 
    : SLK_elseif expression SLK_then statement
    ;

cases_statement
    : SLK_cases expression ':'
      cases_statement_alternatives
      (',' others_statement)? SLK_end
    ;

cases_statement_alternatives
    : cases_statement_alternative (',' cases_statement_alternative)*
    ;

cases_statement_alternative
    //@NB arguably here the "token" is not the one for partial function but actually a different kind of '->'?
    : pattern_list /*SEP_pfcn*/'->' statement 
    ;

others_statement
    : SLK_others /*SEP_pfcn*/'->' statement
    ;    

//------------------------
// A.7.4 Loop statements
//------------------------

sequence_for_loop
    : SLK_for pattern_bind SLK_in
      expression SLK_do statement
    ;

set_for_loop
    : SLK_for SLK_all pattern SLK_inset expression
      SLK_do statement
    ;

index_for_loop
    : SLK_for IDENTIFIER '=' expression SLK_to expression
      (SLK_by expression)?
      SLK_do statement
    ;

//@NB while loops would benefit from something like a @LoopInvariant annotation
while_loop
    : SLK_while expression SLK_do statement
    ;

//------------------------
// A.7.5 Nondeterministic statement
//------------------------

nondeterministic_statement
    : SEP_parallel '(' statement (',' statement)* ')'
    ;

//------------------------
// A.7.6 Call and Return statements
//------------------------

call_statement 
    : name '(' expression_list? ')'
    ;

return_statement
    : SLK_return expression?
    ;

// PP + RT only 
pp_call_statement
    : (object_designator '.')?
      call_statement
    ;

// left recursive rules embedded and rearrange for precedence
//@NB are there prececedence rules for these?
object_designator
    : 
    // object_apply                              #ObjApplyDesignator
      object_designator '(' expression_list? ')' #ObjApplyDesignator
    //| object_field_reference                   #ObjFieldRefDesignator
    | object_designator '.' IDENTIFIER           #ObjFieldRefDesignator
    | self_expression                            #ObjSelfExprDesignator
    | new_expression                             #ObjNewExprDesignator
    | name                                       #ObjNameDesignator
    ;

object_field_reference
    : object_designator '.' IDENTIFIER
    ;

object_apply
    : object_designator '(' expression_list? ')'
    ;

//------------------------
// A.7.7 Specification statement
//------------------------

specification_statement 
    : BRACKET_L implicit_operation_body BRACE_R
    ;

//------------------------
// A.7.8 Start and start list statements
//------------------------

start_statement 
    : RTK_start '(' expression ')'
    ;

start_list_statement 
    : RTK_startlist '(' expression ')'
    ;


//------------------------
// A.7.9 Stop and stop list statements
//------------------------

stop_statement 
    : RTK_stop '(' expression ')'
    ;

stop_list_statement 
    : RTK_stoplist '(' expression ')'
    ;

//------------------------
// A.7.10 Duration and Cycles list statements
//------------------------

duration_statement 
    : RTK_duration '(' expression ')'
      statement
    ;

cycles_statement
    : RTK_cycles '(' expression ')'
      statement
    ;

//------------------------
// A.7.11 Exception handling statements
//------------------------

always_statement
    : SLK_always statement SLK_in statement
    ;

trap_statement
    : SLK_trap pattern_bind SLK_with statement
      SLK_in statement
    ;

recursive_trap_statement
    : SLK_tixe traps SLK_in statement
    ;

traps
    : BRACE_L pattern_bind SEP_maplet statement
      (',' pattern_bind SEP_maplet statement)* BRACE_R
    ;

exit_statement
    : SLK_exit expression?
    ;

//------------------------
// A.7.12 Error statement
//------------------------

error_statement
    : SLK_error
    ;

//------------------------
// A.7.13 Skip statement
//------------------------

identity_statement
    : SLK_skip
    ;

//------------------------
// A.7.9 Stop and stop list statement
//------------------------

//------------------------
// A.8 Patterns and Bindings
//------------------------

//------------------------
// A.8.1 Patterns
//------------------------

pattern
    : pattern_identifier            #IdPattern
    | match_value                   #MatchValuePattern
    | set_enum_pattern              #SetEnumPattern
    //| set_union_pattern           #SetUnionPattern
    | pattern SLK_union pattern     #SetUnionPattern
    | seq_enum_pattern              #SeqEnumPattern
    //| seq_conc_pattern            #SeqConcPattern
    | pattern O_CONCAT pattern      #SeqConcPattern
    | map_enum_pattern              #MapEnumPattern
    //| map_union_pattern           #MapUnionPattern
    | pattern SLK_munion pattern    #MapUnionPattern
    | tupple_pattern                #TupplePattern
    //object_pattern PP/RT only     #ObjectPattern //PP only
    | record_pattern                #RecordPattern
    ;

pattern_identifier 
    : IDENTIFIER | '-'
    ;

match_value
    : '(' expression ')'
    | SYMBOLIC_LITERAL
    ;

set_enum_pattern
    : BRACE_L pattern_list? BRACE_R
    ;

set_union_pattern 
    : pattern SLK_union pattern
    ;

seq_enum_pattern 
    : BRACKET_L pattern_list? BRACKET_R
    ;

seq_conc_pattern
    : pattern O_CONCAT pattern
    ;

map_enum_pattern 
    : BRACE_L maplet_pattern_list BRACE_R
    | BRACE_L SEP_maplet BRACE_R
    ;

maplet_pattern_list 
    : maplet_pattern (',' maplet_pattern)*
    ;

maplet_pattern
    : pattern SEP_maplet pattern
    ;

map_union_pattern 
    : pattern SLK_munion pattern
    ;

tupple_pattern 
    : SLK_mk '(' pattern ',' pattern_list ')'
    ;

//TODO no space between SLK_mk and name!
record_pattern 
    : SLK_mk name '(' pattern_list ')'
    ;

pp_object_pattern 
    : PPK_obj IDENTIFIER '(' field_pattern_list ')'
    ;

field_pattern_list 
    : field_pattern (',' field_pattern)*
    ;

field_pattern
    : IDENTIFIER SEP_maplet pattern 
    ;

pattern_list 
    : pattern (',' pattern)*
    ;

//------------------------
// A.8.2 Bindings
//------------------------

//@LF why doesn't this get left-recursive problems on pattern + set_bind (pattern on both sides)?
pattern_bind 
    : pattern 
    | bind
    ;

bind 
    : set_bind
    | seq_bind
    | type_bind
    ;

set_bind
    : pattern SLK_inset expression
    ;

seq_bind
    : pattern SLK_inseq expression
    ;

type_bind
    : pattern ':' type
    ;

bind_list
    : multiple_bind (',' multiple_bind)*
    ;

multiple_bind
    : multiple_set_bind
    | multiple_seq_bind
    | multiple_type_bind
    ;

multiple_set_bind
    : pattern_list SLK_inset expression
    ;

multiple_seq_bind
    : pattern_list SLK_inseq expression
    ;

multiple_type_bind
    : pattern_list ':' type
    ;

type_bind_list
    : type_bind (',' type_bind)
    ;