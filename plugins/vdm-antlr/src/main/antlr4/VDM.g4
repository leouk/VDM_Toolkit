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

// See vscode-antlr4 documentation at https://github.com/mike-lischke/vscode-antlr4/tree/master/doc 
// $antlr-format on

// Particularly useful documentation for debugging and (amazingly) sentence generation (!) is at
// https://github.com/mike-lischke/vscode-antlr4/blob/master/doc/grammar-debugging.md
// https://github.com/mike-lischke/vscode-antlr4/blob/master/doc/sentence-generation.md

//parser 
grammar VDM;
import VDMLex;
// options 
// {
//     tokenVocab = VDMLex;
// }

@parser::members
{
    // We can gate productions with the corresponding dialect given via semantic predicates on PP and RT productions
    // See ANTLR4 book Section 11.1 Recognizing Multiple Language Dialect
    //public static com.fujitsu.vdmj.lex.Dialect dialect = com.fujitsu.vdmj.lex.Dialect.VDM_SL;

    public static boolean isVDMSL()
    {
        return true;//dialect == com.fujitsu.vdmj.lex.Dialect.VDM_SL;
    }

    public static boolean isVDMPP()
    {
        return true;//dialect == com.fujitsu.vdmj.lex.Dialect.VDM_PP;
    }

    public static boolean isVDMRT()
    {
        return true;//dialect == com.fujitsu.vdmj.lex.Dialect.VDM_RT;
    }

    java.util.Set<String> tldTypeNames = new java.util.HashSet<String>();
    
    protected boolean isTLDTypeName() 
    { 
        System.out.println("Testing " + getCurrentToken().getText() + " ; " + tldTypeNames.toString());
        return tldTypeNames.contains(getCurrentToken().getText()); 
    } 

    protected void addTLDTypeName(String typeName)
    {
        tldTypeNames.add(typeName);
    }
}

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
//
// Listeners and visitors:
// * Visitors useful for result value, and for selective walk
// * Listeners useful for total walk, possibly with ParseTreeProperty results
// * Walk/visit route can be clearer with explicit rule names (#NAME) per production
// * This means we will reduce the number of productions in favour of Named ones 
// * This also means less rule names means shorted walk/stack, hence faster?
// * productions where inner productions are all named are "skipped" to avoid the last point above
//------------------------

//--- Playing with the grammar:
// * switch to java11
// * generate output to separate directory as you will want to "clear" it
// * compile the output, possibly also the ATN dot files
// * go to the inner directory, then debug grammar with grun
//
//--- Concretely:
// * Generate parser to './output' directory with visitors and ATNs with log file too 
//   antlr4 VDM.g4 VDMLex.g4 -listener -visitor -Xlog -atn -o ./output
// * Compile java code: 
//   javac ./output/*.java
// * Play with parser, which you must run from './output', can start at any parser rule
//   cd ./output
//   grun VDM sl_document -tree -gui VDM-TEST-FILE.vdmsl
//
//--- ANTLR4 tools 
// * Alternatively, if antlr4-tools is installed (e.g. pip3 install antlr4-tools)
// * to figure out how antlr4-parse works, call 'pip3 show antlr4-tools' to see how things work
// * Generate and play with parser: antlr4-parse VDM.g4 sl_document -gui GIVE_OUTPUT CTRL+D
//

//--- Building + testing scripts:
// * Build and tests from PRODUCTION_NAME the given FILE_NAME
//   ./gbuild.sh [PRODUCTION_NAME] [FILE_NAMES]
// * Examples: tests list of expressions from exprs versus test sl_document from TestV2IExprs.vdmsl 
//   ./gbuild.sh expression_list exprs 
//   ./gbuild.sh TestV2IExprs.vdmsl 
//
// * Test rig only; assumes build is on ./ouput and FILE_NAMES are relative to ../ 
//   ./gtest.sh [PRODUCTION_NAME] [FILE_NAMES]
//
// * If PRODUCTION_NAME is ommitted, then sl_document is the start production
// * If FILE_NAMES are ommitted, then you can type it directly on STDIN finishing by EOF (e.g. Ctrl+D on Linux/Mac or Ctrl+Z on Windows)

//------------------------
// A.1 VDM-SL document
//------------------------
//TODO add {isVDMSL/PP/RT()}? semantic predicates 
sl_document 
    : module+               #SLModules 
    | sl_definition_block+  #SLFlatModule
    ;

//------------------------
// A.1.1 Module, imports and exports 
//------------------------
module
    : SLK_module modName=IDENTIFIER sl_interface module_body? SLK_end endName=IDENTIFIER
    ;

sl_interface
    : import_definition_list? export_definition;

import_definition_list 
    : SLK_imports import_definition (SEP_comma import_definition)*
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
    : SLK_types type_import (SEP_scolon type_import)* SEP_scolon?
    ;

type_import
    : tname=name (SLK_renamed renamed=name)?            #NamedImport
    | tdef=type_definition (SLK_renamed renamed=name)?  #TypeDefinitionImport
    ;

import_values_signature
    : SLK_values value_import (SEP_scolon value_import)* SEP_scolon?
    ;

value_import 
    : vname=name (SEP_colon type)? (SLK_renamed renamed=name)?
    ;

import_functions_signature
    : SLK_functions function_import (SEP_scolon function_import)* SEP_scolon?
    ;

function_import     
    : fname=name (type_variable_list? SEP_colon function_type)? (SLK_renamed renamed=name)?
    ;

import_operations_signature 
    : SLK_operations operation_import (SEP_scolon operation_import)* SEP_scolon?
    ;

operation_import 
    : oname=name (SEP_colon operation_type)? (SLK_renamed renamed=name)?
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
    : SLK_types type_export (SEP_scolon type_export)* SEP_scolon?
    ;

type_export 
    : SLK_struct? name;

export_values_signature
    : SLK_values value_signature (SEP_scolon value_signature)* SEP_scolon?
    ;

value_signature 
    : name_list SEP_colon type
    ;

export_functions_signature 
    : SLK_functions function_signature (SEP_scolon function_signature)* SEP_scolon?
    ;

function_signature
    : name_list type_variable_list? SEP_colon function_type
    ;

export_operations_signature 
    : SLK_operations operation_signature (SEP_scolon operation_signature)* SEP_scolon;

operation_signature 
    : name_list SEP_colon operation_type
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
    : PPK_isc IDENTIFIER (SEP_comma IDENTIFIER)*
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

//TODO avoid sych layering or if there, add named prodcutions for simplicity?
sl_definition_block
    : sl_type_definitions       #TypeDefinitions
    | state_definition          #StateDefinition
    | sl_value_definitions      #ValueDefinitions
    | sl_function_definitions   #FunctionDefinitions
    | sl_operation_definitions  #OperationDefinitions
    | traces_definitions        #TracesDefinitions
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
    : SLK_types type_definition_list SEP_scolon?
    ;

type_definition_list
    : type_definition (SEP_scolon type_definition)*
    ;

//@NB here added extra production to make parser faster; otherwise you will get
//    a look ahead on the IDENTIFIER until the O_EQUAL or '::' to disambiguate. 
type_definition 
    : id=IDENTIFIER { addTLDTypeName($id.text); } 
      invariant_type_definition 
    ;
    //TODO This is also okay, but the above seemed better? 
    // : IDENTIFIER O_EQUAL type type_specification    #NamedType
    // | IDENTIFIER SEP_rec field+ type_specification  #RecordType 
    // ;

invariant_type_definition
    : O_EQUAL type type_specification    #NamedType
    | SEP_rec field+ type_specification  #RecordType
    ;

//@LF will this generate empty production and potential conflict? 
type_specification 
    : type_invariant? eq_clause? ord_clause?
    ;

// ANTLR4 allows left-recursive productions, so long as they have uniquely named 
// productions within the same rule. Thus, we cannot have union_type production 
// separately, but defined here directly.  
//
//@TODO This generates entry/exit for both entryQuoteType and entryQuote_type (!)
//      might want to remove the singleton productions? 
// C.8.5 Seq/Set type operators are higher precedence? 
type     
    :<assoc=right> params=type (SEP_pfcn | SEP_tfcn) ret=type #FunctionType
    |<assoc=right> PAREN_L PAREN_R (SEP_pfcn | SEP_tfcn) type #VoidFunctionType
    | type (SEP_bar type)+ #UnionType
    | type (O_TIMES type)+ #ProductType
    |<assoc=right> SLK_map dom=type SLK_to rng=type   #MapType
    |<assoc=right> SLK_inmap dom=type SLK_to rng=type #InmapType
    | SLK_seqof type    #SeqOfType
    | SLK_seq1of type   #Seq1OfType
    | SLK_setof type    #SetOfType
    | SLK_set1of type   #Set1OfType
    | bracketed_type    #BracketedType
    | optional_type     #OptionalType
    | composite_type    #CompositeType
    | basic_type        #BasicType
    | quote_type        #QuoteType
    | type_variable     #TypeVariable
    | type_name         #TypeName
    | SEP_qm            #WildcardType  
    ;

bracketed_type 
    : PAREN_L type PAREN_R
    ;

basic_type 
    : SLK_bool | SLK_nat | SLK_nat1 | SLK_int | SLK_rat | SLK_real | SLK_char | SLK_token
    ;

quote_type 
    : O_LT IDENTIFIER O_GT
    ;

composite_type
    : SLK_compose IDENTIFIER SLK_of field+ SLK_end
    ;

//@NB here I am making the rule more efficient again without change to meaning 
field 
    : type 
    | (IDENTIFIER SEP_colon O_MINUS?) type
    ;

union_type 
    : type (SEP_bar type)+ 
    ;

product_type 
    : type (O_TIMES type)+ 
    ;

optional_type 
    : BRACKET_L type BRACKET_R
    ;

set_type 
    : set0_type | set1_type
    ;

set0_type
    : SLK_setof type
    ; 

set1_type
    : SLK_set1of type
    ; 

seq_type 
    : seq0_type | seq1_type
    ;

seq0_type
    : SLK_seqof type
    ; 

seq1_type
    : SLK_seq1of type
    ; 

map_type
    : general_map_type 
    | injective_map_type
    ;

// C.8.4 Map type operators are right associative 
general_map_type 
    :<assoc=right> SLK_map dom=type SLK_to rng=type
    ;

// C.8.4 Map type operators are right associative 
injective_map_type 
    :<assoc=right> SLK_inmap dom=type SLK_to rng=type
    ;

//@LRM these are used in other places, yet cannot be directly on the type production rule :-(
function_type 
    :<assoc=right> discretionary_type SEP_pfcn type #PartialFunctionType
    |<assoc=right> discretionary_type SEP_tfcn type #TotalFunctionType
    ;

discretionary_type 
    : PAREN_L PAREN_R   #VoidType
    | type              #FunctionParametersType
    ;

type_name
    : //{isTLDTypeName()}? Don't add this here because of declaration before use?  
      name 
    ;

type_variable 
    : '@' IDENTIFIER
    ;

// Do not reuse pattern SEP_def as this will create context sensitive productions!
type_invariant 
    : SLK_inv pattern SEP_def expression 
    ;

eq_clause
    : SLK_eq lhs=pattern O_EQUAL rhs=pattern SEP_def expression
    ;

ord_clause
    : SLK_ord lhs=pattern O_LT rhs=pattern SEP_def expression
    ;

//------------------------
// A.4.2 VDM-SL state definition
//------------------------

state_definition 
    : SLK_state IDENTIFIER SLK_of field+ type_invariant? initialisation? SLK_end SEP_scolon
    ;

initialisation 
    : SLK_init pattern SEP_def expression 
    ;

//------------------------
// A.4.3 Value definitions
//------------------------

sl_value_definitions 
    : SLK_values 
        (value_definition 
            (SEP_scolon value_definition)* 
        SEP_scolon? )?
    ;

//@NB will stop completing PP + RT for now. 
pp_value_definitions 
    : SLK_values (access_value_definition (SEP_scolon access_value_definition)* SEP_scolon? )?
    ;

access_value_definition
    : access? value_definition
    ; 

value_definition 
    : pattern 
        (SEP_colon type)? 
        O_EQUAL 
      expression
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
    : IDENTIFIER type_variable_list? SEP_colon 
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

type_variable_list 
    : BRACKET_L type_variable (SEP_comma type_variable)* BRACKET_R
    ;

parameter_types 
    : PAREN_L pattern_type_pair_list PAREN_R
    ;

pattern_type_pair_list
    : pattern_list SEP_colon type (SEP_comma pattern_list SEP_colon type)*
    ;

identifier_type_pair_list
    : identifier_type_pair (SEP_comma identifier_type_pair)*
    ;

identifier_type_pair 
    : IDENTIFIER SEP_colon type 
    ;

// parameters_list 
//     : parameters+ 
//     ;

parameters
    : PAREN_L pattern_list? PAREN_R
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
    : IDENTIFIER SEP_colon operation_type 
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
    : params=discretionary_type SEP_optype rtype=discretionary_type
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
    : vdmmode name_list (SEP_colon type)?
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
    : IDENTIFIER SEP_colon expression /*SEP_pfcn*/'->' expression 
    ;

//------------------------
// A.4.6 Instance Variable Definitions  
//------------------------

instance_variable_definitions
    : PPK_instance PPK_variables 
      (instance_variable_definition (SEP_scolon instance_variable_definition)*)?
    ;

instance_variable_definition
    : access_assignment_definition 
    | instance_variable_invariant_definition
    ;

access_assignment_definition
    : ((access? PPK_static?) | (PPK_static? access?))
      assignment_definition
    ;

instance_variable_invariant_definition
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
    : RTK_mutex PAREN_L SLK_all | name_list PAREN_R
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
    : RTK_periodic PAREN_L expression SEP_comma expression SEP_comma expression SEP_comma expression PAREN_R PAREN_L name PAREN_R
    ;

sporadic_obligation
    : RTK_sporadic PAREN_L expression SEP_comma expression SEP_comma expression SEP_comma expression PAREN_R PAREN_L name PAREN_R
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
    : named_trace (SEP_scolon named_trace)*
    ;

named_trace 
    : IDENTIFIER ('/' IDENTIFIER)* SEP_colon trace_definition_list
    ;

trace_definition_list 
    : trace_definition_term (SEP_scolon trace_definition_term)*
    ;

trace_definition_term 
    : trace_definition (SEP_bar trace_definition)*
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
    : trace_core_definition (O_TIMES | O_PLUS | SEP_qm | '{' NUMERIC_LITERAL (',' NUMERIC_LITERAL)? '}')?;

trace_core_definition 
    : trace_apply_expression
    | trace_concurrent_expression
    | trace_bracketed_expression
    ;

trace_apply_expression 
    : call_statement
    ;

trace_concurrent_expression
    : SEP_parallel PAREN_L trace_definition 
      SEP_comma trace_definition 
      (SEP_comma trace_definition)* PAREN_R
    ;

trace_bracketed_expression
    : PAREN_L trace_definition_list PAREN_R
    ;

//------------------------
// A.4.10 Annotation definitions
//------------------------

//TODO this is not quite right: no separation between --@ID etc. 
annotations 
    : SEP_ann IDENTIFIER PAREN_L PAREN_R CR
    ;

//------------------------
// A.5 Expressions
//------------------------

expression_list 
    : expression (SEP_comma expression)*
    ;

// We must eliminate left-recursion, so have to have the whole tree in one place with labelled attributes. 
// See ANTLR4 reference guide section 5.2 on left recursion elimination.
// 
// Left recursion use (implicitly defined) semantic predicates to induce a priority grammar 
// (e.g. precedence defined according to order of definition of productions). This works well for 
// left recursion where all (or most) productions participate (e.g. ^, *, /, +, -, ID expressions). 
// 
// ANTLR4 identifies productions with left recursion first; they get highest priority according to their
// placement in the grammar (i.e. earlier production has higher precedence). All other (non-left recursive)
// productions are considered primary and can be declared *in any order*. To really identify what priority
// rules will have, have a look at VDM.java private ExpressionContext expression(int _p) method.
//
// Here, name will win to "expression SEP_tsel expression"! So, either we need a semantic predicate in name 
// or a grammar rearrangemnts for left-recursive expressions that are lower priority than name.    
//
// VDM language manual appendix C talks about ``relative precedences of the operators within families is 
// determined by considering type information, and this is used to resolve ambiguity.'' Yet, the grammar of
// appendix A does not separate the expression tree in such families. Here, we will have to in order to avoid
// the hidden left-recursion induced by rules like tuple selector, etc. 
//
// In VDMJ, expressions (in the hand-made parser) are dealt with by 
// com.fujitsu.vdmj.syntax.ExpressionReader#readExpression, which cascades the appendix C grammar as we do
// below in ANTLR4's EBNF format. From the manual we have that families' precedences are as follows:
//      ``combinators > applicators > evaluators > relations > connectives > constructors``
//
// That means, we build the expression grammar from primary (non recursive) production upwards through the family
// ordering, starting with combinators all to way to constructors. Within recursive productions, the earlier declaration
// has higher priority (precedence), hence we follow that order 
//
// In ANTLR(3)4 hidden left recursion removal (see the ALL(*) technical report appendix C), one cascades the left
// recursion through operators, with lower precedence families at the top, all the way down to primary (non-left
// recursive operators). The semantic-predicate gated productions (e.g. {isVDMRT())? won't appear in parser?    

expression
//------------------------
// C.1 The family of combinators
//------------------------
    :<assoc=right> iter=expression O_EXP power=expression   #IterateExpr                       //38 combinator(1)
    |<assoc=right> lhs=expression SLK_comp rhs=expression   #MapCompositionExpr                //39 combinator(2)
//------------------------
// C.2 The family of applicators
//------------------------
    | call=expression PAREN_L 
        low=expression 
        SEP_comma SEP_range SEP_comma 
        high=expression 
        PAREN_R                                             #SubSeqExpr                       //40 applicator(1)
    | expression PAREN_L expression_list? PAREN_R           #ApplyExpr                        //41 applicator(2)
    | expression /* name */ 
        BRACE_L 
        type_list 
        BRACE_R                                             #FunctionTypeInstExpr             //42 applicator(3)
    | expression SEP_dot IDENTIFIER                         #FieldSelExpr       
//C.2 is missing tuple selector!
    | expression SEP_tsel NUMERAL                           #TupleSelExpr                     //43 applicator(4)
//------------------------
// C.3 The family of evaluators
//------------------------
    | O_PLUS       expression  #UnaryPlusExpr
    | O_MINUS      expression  #UnaryMinusExpr
    | SLK_abs      expression  #AbsoluteExpr
    | SLK_floor    expression  #FloorExpr
    | SLK_card     expression  #CardinalityExpr
    | SLK_power    expression  #PowerSetExpr
    | SLK_dunion   expression  #SetDunionExpr
    | SLK_dinter   expression  #SetDinterExpr
    | SLK_dom      expression  #MapDomExpr
    | SLK_rng      expression  #MapRngExpr
    | SLK_merge    expression  #MapMergeExpr
    | SLK_hd       expression  #SeqHdExpr
    | SLK_tl       expression  #SeqTlExpr
    | SLK_len      expression  #SeqLenExpr
    | SLK_elems    expression  #SeqElemsExpr
    | SLK_inds     expression  #SeqIndsExpr
    | SLK_reverse  expression  #SeqReverseExpr
    | SLK_conc     expression  #SeqDistConcExpr
    |              lhs=expression O_NRRES     rhs=expression      #MapRngFilterExpr                 //44 evaluators(1)    
    |              lhs=expression O_RRES      rhs=expression      #MapRngRestrictExpr               //45 evaluators(2)   
    |<assoc=right> lhs=expression O_NDRES     rhs=expression      #MapDomFilterExpr                 //46 evaluators(3)   
    |<assoc=right> lhs=expression O_DRES      rhs=expression      #MapDomRestrictExpr               //47 evaluators(4)   
    | SLK_inverse  expression  #MapInverseExpr 
    |              lhs=expression SLK_div     rhs=expression      #ArithmeticIntegerDivisionExpr    //50 evaluators(7)     
    |              lhs=expression SLK_mod     rhs=expression      #ArithmeticModuloExpr             //51 evaluators(8)     
    |              lhs=expression SLK_rem     rhs=expression      #ArithmeticReminderExpr           //52 evaluators(9)     
    |              lhs=expression O_DIV       rhs=expression      #ArithmeticDivideExpr             //53 evaluators(10)     
    |              lhs=expression O_TIMES     rhs=expression      #ArithmeticMultiplicationExpr     //54 evaluators(11)     
    |              lhs=expression SLK_inter   rhs=expression      #SetInterExpr                     //59 evaluators(16)   
    |              lhs=expression O_PLUS      rhs=expression      #ArithmeticPlusExpr               //56 evaluators(13)
    |              lhs=expression O_MINUS     rhs=expression      #ArithmeticMinusExpr              //55 evaluators(12)     
    |              lhs=expression SLK_munion  rhs=expression      #MapUnionExpr                     //48 evaluators(5)   
    |              lhs=expression O_OVERRIDE  rhs=expression      #MapOverrideExpr                  //49 evaluators(6)   
    |              lhs=expression SLK_union   rhs=expression      #SetUnionExpr                     //58 evaluators(15)   
    |              lhs=expression O_DIFF      rhs=expression      #SetDiffExpr                      //57 evaluators(14)      
    |              lhs=expression O_CONCAT    rhs=expression      #SeqConcatExpr                    //60 evaluators(17)
//------------------------
// C.4 The family of relations
//------------------------
    |              lhs=expression O_GEQ       rhs=expression      #RelationalGreaterThanEqualExpr   //61 relations(1)   
    |              lhs=expression O_LEQ       rhs=expression      #RelationalLessThanEqualExpr      //62 relations(2)
    |              lhs=expression O_GT        rhs=expression      #RelationalGreaterThanExpr        //63 relations(3)
    |              lhs=expression O_LT        rhs=expression      #RelationalLessThanExpr           //64 relations(4)
    |<assoc=right> lhs=expression O_NEQ       rhs=expression      #RelationalNotEqualExpr           //65 relations(5)
    |<assoc=right> lhs=expression O_EQUAL     rhs=expression      #RelationalEqualExpr              //66 relations(6)
    |              lhs=expression SLK_ninset  rhs=expression      #SetNotMemberExpr                 //67 relations(7)
    |              lhs=expression SLK_inset   rhs=expression      #SetMemberExpr                    //68 relations(8)
    |              lhs=expression SLK_psubset rhs=expression      #SetPSubsetExpr                   //69 relations(9)
    |              lhs=expression SLK_subset  rhs=expression      #SetSubsetExpr                    //70 relations(10)
//------------------------
// C.5 The family of logical connectives
//------------------------
    | SLK_not      expression  #NotExpr
    |              lhs=expression SLK_and     rhs=expression      #LogicalAndExpr                   //71 connectives(1)  
    |              lhs=expression SLK_or      rhs=expression      #LogicalOrExpr                    //72 connectives(2)
    |<assoc=right> lhs=expression O_IMPLIES   rhs=expression      #LogicalImpliesExpr               //73 connectives(3)
    |              lhs=expression O_IFF       rhs=expression      #LogicalIffExpr                   //74 connectives(4)
// //------------------------
// // C.6 The family of constructors
// //------------------------
//     | SLK_mk PAREN_L 
//         expression SEP_comma expression_list 
//       PAREN_R                                               #TupleMkExpr                      //75 primary
//     | tight_record_name 
//         PAREN_L expression_list? PAREN_R                    #RecordMkExpr                     //76 primary
// //------------------------
// // C.0 The family of primary expressions
// //------------------------
//     | PAREN_L expression PAREN_R                            #BracketedExpr                     //1  primary
//     | SLK_let local_definition_list 
//       SLK_in expression                                     #LetExpr                           //2  primary
//     | SLK_let multiple_bind (SLK_best stexpr=expression)? 
//       SLK_in inexpr=expression                              #LetBestExpr                       //3  primary 
//     | SLK_def equals_definition_list SEP_scolon?
//       SLK_in expression                                     #DefExpr                           //4  primary
//     | if_expression                                         #IfExpr                            //5  primary
//     | cases_expression                                      #CasesExpr                         //6  primary
//     //| unary_expression                                      #UnaryExpr                         //7  primary
//     | quantified_expression                                 #QuantifiedExpr                    //8  primary
//     | iota_expression                                       #IotaExpr                          //9  primary
//     | set_enumeration                                       #SetEnumExpr                       //10 primary
//     | set_comprehension                                     #SetCompExpr                       //11 primary
//     | set_range_expression                                  #SetRangeExpr                      //12 primary
//     | sequence_enumeration                                  #SeqEnumExpr                       //13 primary
//     | sequence_comprehension                                #SeqCompExpr                       //14 primary
//     | map_enumeration                                       #MapEnumExpr                       //15 primary
//     | map_comprehension                                     #MapCompExpr                       //16 primary
//     | record_modifier                                       #RecordMuExpr                      //17 primary
//     | lambda_expression                                     #LambdaExpr                        //18 primary
//     | narrow_expression                                     #NarrowExpr                        //19 primary
//     | general_is_expression                                 #GeneralIsExpr                     //20 primary
//     | undefined_expression                                  #UndefinedExpr                     //21 primary
//     | precondition_expression                               #PreconditionExpr                  //22 primary
//     | {!isVDMSL()}? self_expression                         #PPSelfExpr                        //24 primary
//     | {isVDMRT()}?  threadid_expression                     #PPThreadIdExpr                    //25 primary
//     | {!isVDMSL()}? isofbaseclass_expression                #PPIsOfBaseClassExpr               //26 primary
//     | {!isVDMSL()}? isofclass_expression                    #PPIsOfClassExpr                   //27 primary
//     | {!isVDMSL()}? samebaseclass_expression                #PPSameBaseClassExpr               //28 primary
//     | {!isVDMSL()}? sameclass_expression                    #PPSameClassExpr                   //29 primary
//     | {isVDMRT()}?  act_expression                          #RTActExpr                         //30 primary
//     | {isVDMRT()}?  fin_expression                          #RTFinExpr                         //31 primary
//     | {isVDMRT()}?  active_expression                       #RTActiveExpr                      //32 primary
//     | {isVDMRT()}?  req_expression                          #RTReqExpr                         //33 primary
//     | {isVDMRT()}?  waiting_expression                      #RTWaitingExpr                     //34 primary
//     | {isVDMRT()}?  time_expression                         #RTTimeExpr                        //35 primary
//     | {!isVDMSL()}? new_expression                          #PPNewExpr                        //77 primary
//     | old_name                                              #OldNameExpr                       //36 primary
//     | name                                                  #NameExpr                          //37 primary
//     | symbolic_literal                                      #SymbolicLitExpr                   //23 primary
//------------------------
// C.6 The family of constructors
//------------------------
//These are also primary given their leading tokens
    | tuple_constructor                                     #TupleMkExpr                      //75 primary
    | record_constructor                                    #RecordMkExpr                     //76 primary
//------------------------
// C.0 The family of primary expressions
//------------------------
    | bracketed_expression                                  #BracketedExpr                     //1  primary
    | let_expression                                        #LetExpr                           //2  primary
    | let_be_expression                                     #LetBestExpr                       //3  primary 
    | def_expression                                        #DefExpr                           //4  primary
    | if_expression                                         #IfExpr                            //5  primary
    | cases_expression                                      #CasesExpr                         //6  primary
    | quantified_expression                                 #QuantifiedExpr                    //8  primary
    | iota_expression                                       #IotaExpr                          //9  primary
    | set_enumeration                                       #SetEnumExpr                       //10 primary
    | set_comprehension                                     #SetCompExpr                       //11 primary
    | set_range_expression                                  #SetRangeExpr                      //12 primary
    | sequence_enumeration                                  #SeqEnumExpr                       //13 primary
    | sequence_comprehension                                #SeqCompExpr                       //14 primary
    | map_enumeration                                       #MapEnumExpr                       //15 primary
    | map_comprehension                                     #MapCompExpr                       //16 primary
    | record_modifier                                       #RecordMuExpr                      //17 primary
    | lambda_expression                                     #LambdaExpr                        //18 primary
    | narrow_expression                                     #NarrowExpr                        //19 primary
    | general_is_expression                                 #GeneralIsExpr                     //20 primary
    | undefined_expression                                  #UndefinedExpr                     //21 primary
    | precondition_expression                               #PreconditionExpr                  //22 primary
    | {!isVDMSL()}? self_expression                         #PPSelfExpr                        //24 primary
    | {isVDMRT()}?  threadid_expression                     #PPThreadIdExpr                    //25 primary
    | {!isVDMSL()}? isofbaseclass_expression                #PPIsOfBaseClassExpr               //26 primary
    | {!isVDMSL()}? isofclass_expression                    #PPIsOfClassExpr                   //27 primary
    | {!isVDMSL()}? samebaseclass_expression                #PPSameBaseClassExpr               //28 primary
    | {!isVDMSL()}? sameclass_expression                    #PPSameClassExpr                   //29 primary
    | {isVDMRT()}?  act_expression                          #RTActExpr                         //30 primary
    | {isVDMRT()}?  fin_expression                          #RTFinExpr                         //31 primary
    | {isVDMRT()}?  active_expression                       #RTActiveExpr                      //32 primary
    | {isVDMRT()}?  req_expression                          #RTReqExpr                         //33 primary
    | {isVDMRT()}?  waiting_expression                      #RTWaitingExpr                     //34 primary
    | {isVDMRT()}?  time_expression                         #RTTimeExpr                        //35 primary
    | {!isVDMSL()}? new_expression                          #PPNewExpr                        //77 primary
    | old_name                                              #OldNameExpr                       //36 primary
    | variable                                              #VariableExpr                      //37 primary
    | symbolic_literal                                      #SymbolicLitExpr                   //23 primary
    ;  

//------------------------
// A.5.1 Bracketed Expression  
//------------------------

variable 
    : {!isTLDTypeName()}? name
    ;

//@LRM bracketed_expression could be reused within pattern and expression?  
bracketed_expression
    : PAREN_L expression PAREN_R
    ;

//------------------------
// A.5.2 Local Binding Expressions  
//------------------------

let_expression 
    : SLK_let local_definition_list 
      SLK_in expression 
    ;

let_be_expression
    : SLK_let multiple_bind (SLK_best stexpr=expression)? 
      SLK_in inexpr=expression 
    ;

def_expression 
    : SLK_def equals_definition_list SEP_scolon?
      SLK_in expression
    ;

//------------------------
// A.5.3 Conditional Expressions  
//------------------------

if_expression
    : SLK_if testExpr=expression SLK_then thenExpr=expression 
      elseif_expression*
      SLK_else elseExpr=expression
    ;

elseif_expression 
    : SLK_elseif expression SLK_then expression
    ;

cases_expression
    : SLK_cases expression SEP_colon
      cases_expression_alternatives
      (SEP_comma others_expression)? SLK_end
    ;

cases_expression_alternatives
    : cases_expression_alternative (SEP_comma cases_expression_alternative)*
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
//@LRM remove unary expression and put the others in place?
//@LRM cannot have 
// unary_expression 
//     : O_PLUS       expression  #UnaryPlusExpr
//     | O_MINUS      expression  #UnaryMinusExpr
//     | SLK_abs      expression  #AbsoluteExpr
//     | SLK_floor    expression  #FloorExpr
//     | SLK_not      expression  #NotExpr
//     | SLK_card     expression  #CardinalityExpr
//     | SLK_power    expression  #PowerSetExpr
//     | SLK_dunion   expression  #SetDunionExpr
//     | SLK_dinter   expression  #SetDinterExpr
//     | SLK_hd       expression  #SeqHdExpr
//     | SLK_tl       expression  #SeqTlExpr
//     | SLK_len      expression  #SeqLenExpr
//     | SLK_elems    expression  #SeqElemsExpr
//     | SLK_inds     expression  #SeqIndsExpr
//     | SLK_reverse  expression  #SeqReverseExpr
//     | SLK_conc     expression  #SeqDistConcExpr
//     | SLK_dom      expression  #MapDomExpr
//     | SLK_rng      expression  #MapRngExpr
//     | SLK_merge    expression  #MapMergeExpr
//     | SLK_inverse  expression  #MapInverseExpr 
//     ;

//------------------------
// A.5.6 Quantified Expressions  
//------------------------

//@LRM remove this and put others in place?
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
    : BRACE_L expression_list? BRACE_R
    ;

set_comprehension
    : BRACE_L first=expression SEP_bar bind_list (SEP_amp filter=expression)? BRACE_R 
    ;

set_range_expression
    : BRACE_L low=expression SEP_comma SEP_range SEP_comma high=expression BRACE_R
    ;

//------------------------
// A.5.9 Seq Expressions  
//------------------------

sequence_enumeration 
    : BRACKET_L expression_list? BRACKET_R
    ;

sequence_comprehension
    : BRACKET_L first=expression SEP_bar bind (SEP_amp filter=expression)? BRACKET_R 
    ;

subsequence
    : call=expression/*_combinators */ PAREN_L low=expression SEP_comma SEP_range SEP_comma high=expression PAREN_R
    ;

//------------------------
// A.5.10 Map Expressions  
//------------------------

map_enumeration 
    : BRACE_L maplet_list BRACE_R
    | BRACE_L SEP_maplet BRACE_R
    ;

maplet_list
    : maplet (SEP_comma maplet)?
    ;

maplet
    : dom=expression SEP_maplet rng=expression
    ;

map_comprehension
    : BRACE_L first=maplet SEP_bar bind_list (SEP_amp filter=expression)? BRACE_R
    ;

//------------------------
// A.5.11 Tuple Constructor Expressions  
//------------------------

tuple_constructor
    : SLK_mk PAREN_L expression SEP_comma expression_list PAREN_R
    ;

//------------------------
// A.5.12 Record Expressions  
//------------------------

record_constructor
    : tight_record_name PAREN_L expression_list? PAREN_R
    ;

// Nothing between tokens; make name lexer-explicit in that case for easier semantic predicate?
// parser productions might have side effects, therefore, they can appear in actions but not in semantics predicates!
// record_name 
// 	: first=SLK_mk name {$name.IDENTIFIER(0).index > 0 ? System.out.println("Okay") : System.out.println("Not okay);}
//     //{$first.index + 1 == $name.IDENTIFIER(0).index}?
// 	;

// Nothing between tokens
tight_record_name
    : RECORD_IDENTIFIER (SEP_tick IDENTIFIER)?
    //| RECORD_IDENTIFIER
    ;

record_modifier
    : SLK_mu PAREN_L expression SEP_comma record_modification_list PAREN_R
    ;

record_modification_list 
    : record_modification (SEP_comma record_modification)*
    ;

record_modification
    : IDENTIFIER SEP_maplet expression
    ;

//------------------------
// A.5.13 Apply Expressions  
//------------------------

apply 
    : expression/*_combinators */ PAREN_L expression_list? PAREN_R
    ;

field_select 
    : expression/*_combinators*/ SEP_dot IDENTIFIER
    ;

tuple_select 
    : expression SEP_tsel NUMERAL
    ;

//@NB function type inst allows expression and not just name ? 
function_type_instantiation 
    : expression/*_combinators*/ /* name */ BRACE_L type_list BRACE_R
    ;

type_list 
    : type (SEP_comma type)*
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
    : SLK_narrow PAREN_L expression SEP_comma type PAREN_R
    ;

//------------------------
// A.5.16 New Expressions  
//------------------------

new_expression
    : PPK_new name PAREN_L expression_list? PAREN_R
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

is_expression 
    : SLK_istest (name | basic_type) 
      PAREN_L expression PAREN_R
    ;

// tight_is_test
//     : first=SLK_istest second=IDENTIFIER (SEP_tick IDENTIFIER)? 
//     | first=SLK_istest second=basic_type
//     ;

type_judgement
    : SLK_istest PAREN_L expression SEP_comma type PAREN_R
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
    : SLK_pre SEP_underscore PAREN_L expression_list PAREN_R
    ;

//------------------------
// A.5.22 Base class membership Expressions  
//------------------------

isofbaseclass_expression
    : PPK_ibc SEP_underscore PAREN_L name SEP_comma expression PAREN_R
    ;

//------------------------
// A.5.23 Class membership Expressions  
//------------------------

isofclass_expression
    : PPK_ioc PAREN_L name SEP_comma expression PAREN_R
    ;

//------------------------
// A.5.24 Same base class membership Expressions  
//------------------------

samebaseclass_expression
    : PPK_sbc PAREN_L name SEP_comma expression PAREN_R
    ;

//------------------------
// A.5.25 Same class membership Expressions  
//------------------------

sameclass_expression
    : PPK_sc PAREN_L name SEP_comma expression PAREN_R
    ;

//------------------------
// A.5.26 History Expressions  
//------------------------

act_expression
    : RTK_act PAREN_L name_list PAREN_R
    ;

fin_expression
    : RTK_fin PAREN_L name_list PAREN_R
    ;
    
active_expression
    : RTK_active PAREN_L name_list PAREN_R
    ;
    
req_expression
    : RTK_req PAREN_L name_list PAREN_R
    ;
    
waiting_expression
    : RTK_waiting PAREN_L name_list PAREN_R
    ;

//------------------------
// A.5.27 Time Expressions  
//------------------------

time_expression
    : RTK_time
    ;

//------------------------
// A.6 State Designators  
//------------------------

// Left-recursion requires inlining + labelling; order gives priority/precedence
state_designator
    : state_designator SEP_dot IDENTIFIER           #FieldReferenceDesignator
    | state_designator PAREN_L expression PAREN_R   #MapSeqReferenceDesignator
    | name                                          #NameDesignator
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
    : local_definition (SEP_comma local_definition)*
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
    : SLK_def equals_definition_list SEP_scolon?
      SLK_in statement
    ;

equals_definition_list 
    : equals_definition (SEP_scolon equals_definition)*
    ;

equals_definition 
    : pattern_bind O_EQUAL expression
    ;

//------------------------
// A.7.2 Block and Assignment Statements  
//------------------------

block_statement 
    : PAREN_L dcl_statement*
      statement (SEP_scolon statement)* SEP_scolon? PAREN_R
      ;

dcl_statement 
    : SLK_dcl assignment_definition 
      (SEP_comma assignment_definition)* SEP_scolon
    ;

assignment_definition 
    : IDENTIFIER SEP_colon type (SEP_assign expression)?
    ;

general_assignment_statement
    : assignment_statement
    | multiple_assign_statement
    ;

assignment_statement
    : state_designator SEP_assign expression
    ;

//@NB VDMJ tolerates dangling SEP_scolon as in atomic(x := nil; y := {};) [last semi shouldn't be allowed according to grammar? ]
multiple_assign_statement
    : SLK_atomic PAREN_L assignment_statement SEP_scolon 
      assignment_statement 
      (SEP_scolon assignment_statement)* 
      SEP_scolon? PAREN_R
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
    : SLK_cases expression SEP_colon
      cases_statement_alternatives
      (SEP_comma others_statement)? SLK_end
    ;

cases_statement_alternatives
    : cases_statement_alternative (SEP_comma cases_statement_alternative)*
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
    : SLK_for IDENTIFIER O_EQUAL expression SLK_to expression
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
    : SEP_parallel PAREN_L statement (SEP_comma statement)* PAREN_R
    ;

//------------------------
// A.7.6 Call and Return statements
//------------------------

call_statement 
    : name PAREN_L expression_list? PAREN_R
    ;

return_statement
    : SLK_return expression?
    ;

// PP + RT only 
pp_call_statement
    : (object_designator SEP_dot)?
      call_statement
    ;

// left recursive rules embedded and rearrange for precedence
//@NB are there prececedence rules for these?
object_designator
    : 
    // object_apply                              #ObjApplyDesignator
      object_designator PAREN_L expression_list? PAREN_R #ObjApplyDesignator
    //| object_field_reference                   #ObjFieldRefDesignator
    | object_designator SEP_dot IDENTIFIER           #ObjFieldRefDesignator
    | self_expression                            #ObjSelfExprDesignator
    | new_expression                             #ObjNewExprDesignator
    | name                                       #ObjNameDesignator
    ;

object_field_reference
    : object_designator SEP_dot IDENTIFIER
    ;

object_apply
    : object_designator PAREN_L expression_list? PAREN_R
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
    : RTK_start PAREN_L expression PAREN_R
    ;

start_list_statement 
    : RTK_startlist PAREN_L expression PAREN_R
    ;


//------------------------
// A.7.9 Stop and stop list statements
//------------------------

stop_statement 
    : RTK_stop PAREN_L expression PAREN_R
    ;

stop_list_statement 
    : RTK_stoplist PAREN_L expression PAREN_R
    ;

//------------------------
// A.7.10 Duration and Cycles list statements
//------------------------

duration_statement 
    : RTK_duration PAREN_L expression PAREN_R
      statement
    ;

cycles_statement
    : RTK_cycles PAREN_L expression PAREN_R
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
      (SEP_comma pattern_bind SEP_maplet statement)* BRACE_R
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
    : PAREN_L expression PAREN_R            #BracketedExprPattern
    | BRACE_L pattern_list? BRACE_R         #SetEnumPattern
    | pattern SLK_union pattern             #SetUnionPattern
    | BRACKET_L pattern_list? BRACKET_R     #SeqEnumPattern 
    | lhs=pattern O_CONCAT rhs=pattern      #SeqConcatPattern
    | BRACE_L maplet_pattern_list BRACE_R   #MapEnumPattern
    | BRACE_L SEP_maplet BRACE_R            #EmptyMapPattern
    | lhs=pattern SLK_munion rhs=pattern    #MapMunionPattern
    | SLK_mk PAREN_L  pattern_list PAREN_R  #TupplePattern
    | {!isVDMSL()}? OBJECT_IDENTIFIER PAREN_L field_pattern_list PAREN_R #PPObjectPattern
    | tight_record_name PAREN_L pattern_list PAREN_R #RecordPattern
    | symbolic_literal                      #SymbolicLiteralPattern
    | O_MINUS                               #IgnorePattern
    | IDENTIFIER                            #IdPattern
    ;

maplet_pattern_list 
    : maplet_pattern (SEP_comma maplet_pattern)* 
    ;

maplet_pattern
    : from=pattern SEP_maplet to=pattern
    ;

field_pattern_list 
    : field_pattern (SEP_comma field_pattern)*
    ;

field_pattern
    : IDENTIFIER SEP_maplet pattern 
    ;

pattern_list 
    : pattern (SEP_comma pattern)*
    ;

//------------------------
// A.8.2 Bindings
//------------------------

//@NB VDMJ seems to prioritise bind over pattern? LRM says different
//    will flip here
pattern_bind 
    : bind
    | pattern 
    ;

bind 
    : pattern SLK_inset expression #SetBind
    | pattern SLK_inseq expression #SeqBind
    | type_bind                    #TypeBind
    ;

// set_bind
//     : pattern SLK_inset expression
//     ;

// seq_bind
//     : pattern SLK_inseq expression
//     ;

type_bind
    : pattern SEP_colon type
    ;

bind_list
    : multiple_bind (SEP_comma multiple_bind)*
    ;

multiple_bind
    : pattern_list SLK_inset expression #MultipleSetBind
    | pattern_list SLK_inseq expression #MultipleSeqBind
    | pattern_list SEP_colon type       #MultipleTypeBind
    ;

// multiple_set_bind
//     : pattern_list SLK_inset expression
//     ;

// multiple_seq_bind
//     : pattern_list SLK_inseq expression
//     ;

// multiple_type_bind
//     : pattern_list SEP_colon type
//     ;

type_bind_list
    : type_bind (SEP_comma type_bind)*
    ;


//------------------------
// A.5.28 Names  
//------------------------

name_list
    : name (SEP_comma name)*
    ;

//@NB name is both a LexNameToken and a ASTVariableExpression? 
//@doc never implement the exiName(ctx) directly?! 
name
    : mod=IDENTIFIER SEP_tick n=IDENTIFIER  #QualifiedName
    | IDENTIFIER                            #IdName
    ;

// qualified_name
//     : IDENTIFIER SEP_tick IDENTIFIER
//     ;

old_name
    : IDENTIFIER SEP_old
    ;

symbolic_literal
    : NUMERIC_LITERAL           #NumericLiteral
	| (SLK_true|SLK_false)      #BooleanLiteral
	| SLK_nil                   #NilLiteral 
	| CHARACTER_LITERAL         #CharacterLiteral
	| TEXT_LITERAL              #StringLiteral
	| O_LT IDENTIFIER O_GT      #QuoteLiteral
    ;