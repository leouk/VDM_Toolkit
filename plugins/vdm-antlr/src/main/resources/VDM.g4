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
   // | synchronisation_definitions
   // | thread_definitions 
    ;

//TODO    
pp_definition_block 
    : pp_type_definitions
    //| state_definition 
    | pp_value_definitions 
    | pp_function_definitions
    | pp_operation_definitions
    | traces_definitions
    // | instance_variable_definitions 
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
    | '::' field+ type_specification
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
    | type ('|' type)+ #UnionType
    // | product_type      #ProductType
    | type ('*' type)+ #ProductType
    | optional_type     #OptionalType
    | set_type          #SetType
    | seq_type          #SeqType
    | map_type          #MapType
    // | function_type     #FunctionType
    |<assoc=right> void_function_type #VoidFunctionType
    |<assoc=right> type SEP_pfcn type #PartialFunctionType
    |<assoc=right> type SEP_tfcn type #PartialFunctionType
    | type_name         #TypeName
    | type_variable     #TypeVariable
    ;

void_function_type
    : '(' ')' (SEP_pfcn | SEP_tfcn) type
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
    : type ('|' type)+ 
    ;

product_type 
    : type ('*' type)+ 
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
    : discretionary_type SEP_pfcn type 
    ;

total_function_type 
    : discretionary_type SEP_tfcn type
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
    : SLK_eq pattern SEP_equal invariant_initial_function
    ;

ord_clause
    : SLK_ord pattern O_LT invariant_initial_function
    ;

//@NB refactored this one given equivalence
invariant_initial_function 
    : pattern SEP_equal SEP_equal expression
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
      '==' function_body 
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
      '==' operation_body
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
      '==' operation_body 
      externals? 
      pre_expression?
      post_expression?
      exceptions?
    ;

operation_type
    : discretionary_type '==>' discretionary_type
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
    : IDENTIFIER ':' expression SEP_pfcn expression 
    ;

//------------------------
// A.4.6 Instance Variable Definitions  
//------------------------

//TODO

//------------------------
// A.4.7 Synchronisation Definitions  
//------------------------

//TODO

//------------------------
// A.4.8.Thread Definitions  
//------------------------

//TODO

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

local_definition_list
    : local_definition (',' local_definition)*
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
// A.4.1 Type definitions  
//------------------------

//------------------------
// A.4.1 Type definitions  
//------------------------

name_list: name (',' name)*;

name: IDENTIFIER;
//------------------------
// Module 
//------------------------
pattern : 'pat';
expression : 'exp';
pattern_list : 'patlist';
multiple_bind: 'mb';
statement: 'stmt';
call_statement: 'cstmt';
local_definition: 'letdef';