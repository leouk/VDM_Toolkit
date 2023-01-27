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
 
grammar VdmSLParser;
import VdmSLLexer;

//------------------------
// Parser Rules (ATTN: in antlr, all parser rules start with a small letter)
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
    : SLK_module IDENTIFIER interface module_body? SLK_end IDENTIFIER
    ;

interface
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
    : (class | system)+
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

class 
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
    : ESC
    //   pp_type_definitions
    // | state_definition 
    // | value_definitions 
    // | function_definitions
    // | operation_definitions
    // | traces_definitions
    // | instance_variable_definitions 
    ;

sl_definition_block
    : type_definitions
    | state_definition 
    | value_definitions 
    | function_definitions
    | operation_definitions
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
    : (PPK_static? | access?) | (access? | PPK_static?) type_definitions
    ;

access 
    : PPK_public | PPK_private | PPK_protected
    ;

type_definitions 
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

type 
    : bracketed_type 
    | basic_type 
    | quote_type 
    | composite_type
    | union_type 
    | product_type
    | optional_type 
    | set_type
    | seq_type
    | map_type
    | function_type 
    | type_name 
    | type_variable
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
    : '(' ')'
    | type
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
    : SLK_ord pattern SEP_lt invariant_initial_function
    ;

//@NB refactored this one given equivalence
invariant_initial_function 
    : pattern SEP_equal SEP_equal expression
    ;

//------------------------
// A.4.1 VDM-SL state definition
//------------------------

state_definition 


//------------------------
// A.4.1 Type definitions  
//------------------------

name_list: name (',' name)*;

name: IDENTIFIER;
//------------------------
// Module 
//------------------------
