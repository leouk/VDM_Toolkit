 /**
 * ANTLR4 lexer rules for the VDM-SL language
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
 
lexer grammar VDMLex;

// options 
// {
//     superClass = VDMLexBase;
// }

//------------------------
// Lexer Rules
// NOTES:
//  - in antlr, all lexer rules and constants start with a Capital letter
//  -  ANTLR resolves lexical ambiguities by matching the input string to the rule specified first in the grammar
//     An example common ambiguity in programming languages is that between keywords and identifier rules.
//     Keyword begin (followed by a nonletter) is also an identifier, at least lexically, so the lexer can match b-e-g-i-n to either rule.
//     Because of this, it is important to place all keywords before the identifiers
//------------------------

// This has to appear first, otherwise lexer gets confused between keywords (SLK_true), identifiers (true) and symbolic literal (true)!
SYMBOLIC_LITERAL
    : NUMERIC_LITERAL
	| BOOLEAN_LITERAL
	| NIL_LITERAL 
	| CHARACTER_LITERAL 
	| TEXT_LITERAL
	| QUOTE_LITERAL
    ;

NUMERIC_LITERAL
    : DECIMAL_LITERAL 
	| HEXADECIMAL_LITERAL
    ;

fragment BOOLEAN_LITERAL
    : SLK_true
 	| SLK_false
    ;

fragment NIL_LITERAL
    : SLK_nil
    ;

fragment CHARACTER_LITERAL
    : '\'' (NameChar | ESC) '\''
    ;

fragment TEXT_LITERAL
    : '"' (NameChar | ESC | .)*? '"'
    ;

QUOTE_LITERAL
    : '<' IDENTIFIER '>'
    ;

fragment DECIMAL_LITERAL
    : NUMERAL ('.' NUMERAL)? (EXPONENT)?
    ;

fragment EXPONENT          
    : ('E' | 'e') ('+' | '-')? NUMERAL
    ;

fragment HEXADECIMAL_LITERAL
    : ('0x' | '0X') HEXADECIMAL_DIGIT+
    ;

TYPE_VARIABLE_IDENTIFIER
    : '@' IDENTIFIER
    ;

//------------------------
// Keywords (case sensitive); add PP/RT?
//------------------------
SLK_inys       : SLK_is SLK_not SLK_yet SLK_specified;
SLK_best       : SLK_be SLK_st;
SLK_ninset     : SLK_not SLK_in SLK_set;
SLK_ninseq     : SLK_not SLK_in SLK_seq;
SLK_inset      : SLK_in SLK_set;
SLK_inseq      : SLK_in SLK_seq;
SLK_abs        : 'abs';
SLK_all		   : 'all';
SLK_always     : 'always';
SLK_and        : 'and';
SLK_as         : 'as';
SLK_atomic     : 'atomic';
SLK_be         : 'be';
SLK_bool       : 'bool';
SLK_by         : 'by'; 
SLK_card       : 'card';
SLK_cases      : 'cases';
SLK_char       : 'char';
SLK_compose    : 'compose';
SLK_comp       : 'comp';
SLK_conc       : 'conc';
SLK_dcl        : 'dcl';
SLK_def        : 'def';
SLK_definitions: 'definitions';
SLK_dinter     :'dinter';
SLK_div        : 'div';
SLK_do         : 'do';
SLK_dom        : 'dom';
SLK_dunion     : 'dunion';
SLK_elems      : 'elems';
SLK_else       : 'else';
SLK_elseif     : 'elseif';
SLK_end        : 'end';
SLK_eq         : 'eq';
SLK_error 	   : 'error';
SLK_errs 	   : 'errs' ;
SLK_exists 	   : 'exists' ;
SLK_exists1    : 'exists1' ;
SLK_exit 	   : 'exit' ;
SLK_exports    : 'exports' ;
SLK_ext 	   : 'ext' ;
SLK_false	   : 'false' ;
SLK_floor	   : 'floor';
SLK_for 	   : 'for' ;
SLK_forall 	   : 'forall' ;
SLK_from       : 'from' ;
SLK_functions  : 'functions'; 
SLK_hd         : 'hd' ;
SLK_if         : 'if' ;
SLK_in         : 'in' ;
SLK_inds       : 'inds' ;
SLK_inmap      : 'inmap' ;
SLK_int        : 'int' ;
SLK_inter	   : 'inter';
SLK_imports    : 'imports' ;
SLK_init       : 'init' ;
SLK_inv        : 'inv' ;
SLK_inverse    : 'inverse' ;
SLK_iota       : 'iota' ;
SLK_is	       : 'is';
SLK_lambda     : 'lambda' ;
SLK_len        : 'len' ;
SLK_let 	   : 'let';
SLK_map        : 'map' ;
SLK_measure    : 'measure' ;
SLK_merge      : 'merge' ;
SLK_mod        : 'mod' ;
SLK_module     : 'module' ;
SLK_mk         : 'mk_';
SLK_mu         : 'mu' ;
SLK_munion     : 'munion' ;
SLK_narrow     : 'narrow_';
SLK_nat        : 'nat' ;
SLK_nat1       : 'nat1' ;
SLK_nil        : 'nil' ;
SLK_not        : 'not' ;
SLK_of         : 'of' ;
SLK_operations : 'operations'; 
SLK_or         : 'or' ;
SLK_ord        : 'ord' ;
SLK_others     : 'others' ;
SLK_post       : 'post' ;
SLK_power      : 'power' ;
SLK_pre        : 'pre' ;
SLK_pure       : 'pure' ;
SLK_psubset    : 'psubset';
SLK_rat        : 'rat' ;
SLK_rd         : 'rd' ;
SLK_real       : 'real' ;
SLK_rem        : 'rem' ;
SLK_renamed    : 'renamed' ;
SLK_return     : 'return' ;
SLK_reverse    : 'reverse' ;
SLK_rng	       : 'rng';
SLK_seq        : 'seq' ;
SLK_seq1	   : 'seq1';
SLK_set        : 'set' ;
SLK_set1       : 'set1' ;
SLK_skip       : 'skip' ;
SLK_specified  : 'specified'; 
SLK_st         : 'st' ;
SLK_state      : 'state' ;
SLK_struct	   : 'struct';
SLK_subset     : 'subset' ;
SLK_then       : 'then' ;
SLK_tixe	   : 'tixe';
SLK_tl         : 'tl' ;
SLK_to         : 'to' ;
SLK_token      : 'token' ;
SLK_traces     : 'traces' ;
SLK_trap       : 'trap' ;
SLK_true       : 'true' ;
SLK_types      : 'types' ;
SLK_undefined  : 'undefined'; 
SLK_union      : 'union' ;
SLK_values     : 'values';
SLK_with       : 'with';
SLK_while      : 'while' ;
SLK_wr         : 'wr' ;
SLK_yet        : 'yet' ;
SLK_RESULT     : 'RESULT';

PPK_isr        : SLK_is PPK_subclass PPK_responsibility;
PPK_access     : 'access';
PPK_instance   : 'instance';
PPK_ibc        : 'isofbaseclass';
PPK_ioc        : 'isofclass';
PPK_class	   : 'class';
PPK_new        : 'new';
PPK_obj        : 'obj_';
PPK_private    : 'private';
PPK_protected  : 'protected';
PPK_public     : 'public';
PPK_sbc        : 'samebaseclass';
PPK_sc         : 'sameclass';
PPK_self       : 'self';
PPK_static     : 'static';
PPK_subclass   : 'subclass';
PPK_responsibility: 'responsibility';
PPK_variables  : 'variables';

RTK_active     : '#active';
RTK_act        : '#act';
RTK_fin        : '#fin';
RTK_req        : '#req';
RTK_waiting    : '#waiting';
RTK_async      : 'async';
RTK_cycles     : 'cycles';
RTK_duration   : 'duration';
RTK_periodic   : 'periodic';
RTK_per        : 'per';
RTK_mutex      : 'mutex';
RTK_sporadic   : 'sporadic';
RTK_start      : 'start';
RTK_startlist  : 'startlist';
RTK_stop       : 'stop';
RTK_stoplist   : 'stoplist';
RTK_sync       : 'sync';
RTK_system     : 'system';
RTK_time       : 'time';
RTK_threadid   : 'threadid';
RTK_thread     : 'thread';

// Unused keywords
//RTK_uselib : 'uselib';
//RTK_keyword: 'dlmodule';

//@LF Paolo prefers to lex operators separaterly, as ANTLR rules for
//    operator precedence are tricky! 
O_IFF     : '<=>';
O_NEQ     : '<>';
O_LEQ     : '<=';//O_LT O_EQUAL; //@LF would allow white space between '<' and '='?
O_GEQ     : '>=';//O_GT O_EQUAL;
O_IMPLIES : '=>';
O_EXP     : '**';
O_NDRES   : '<-:';
O_DRES    : '<:';
O_NRRES   : ':->';
O_RRES    : ':>';
O_OVERRIDE: '++';
O_LT      : '<' ;
O_GT      : '>' ;
O_DIV     : '/';
O_DIFF    : '\\';
O_TIMES   : '*';
O_PLUS    : '+';
O_MINUS   : '-';
O_CONCAT  : '^';
O_EQUAL   : '=';

//TODO multiple comment line annotations
SEP_ann   : '--@';
//@LF don't use SEP_bar SEP_bar as would allow white space! 
SEP_parallel: '||';
SEP_optype: '==>';
SEP_assign: ':=';
SEP_rec   : '::';
SEP_range : '...';
SEP_maplet: '|->';
SEP_def   : '==';
SEP_tsel  : '.#';
SEP_pfcn  : '->';
SEP_tfcn  : '+>';
SEP_comma : ',';
SEP_dot   : '.';
SEP_colon : ':';
SEP_scolon: ';';
SEP_bar   : '|';
SEP_qm    : '?';
SEP_amp   : '&';
SEP_tick  : '`';
SEP_old   : '~';
SEP_underscore: UNDERSCORE;

PAREN_L   : '(';
PAREN_R   : ')';
BRACKET_L : '[';
BRACKET_R : ']';
BRACE_L   : '{';
BRACE_R   : '}';

// TRACE_REPEAT_PATTERN
//     : O_TIMES | O_PLUS | SEP_qm | '{' NUMERIC_LITERAL (',' NUMERIC_LITERAL)? '}'
//     ;

// Identifier *must* be after keywords, otherwise gets confused whether 'true' is SLK_true or IDENTIFIER! Same for other keywords of course! 
IDENTIFIER 
    : NameStartChar NameChar*
    ;

//------------------------
// Fragments necessary for the lexer that we choose not to tokenize individually
//------------------------
NUMERAL
    : DIGIT+
    ;

//@LF This didn;t work :-(. Caused almost everything to be an identifier :-(
//TODO try using sentence generation 
//TODO see grammars-v4/sql grammars ids? 
// fragment NameChar 
//     : NameStartChar
//     | [\p{Nd}]  // Unicode Decimal Digit Number: [0..9]
//     | '\u005F'  // Unicode underscore          : [_]
//     | '\u0027'  // Uhicode apostrophe          : [']
//     | ~[\p{Cc}\p{Zl}\p{Zp}\p{Zs}\p{Cs}\p{Cn}]
//     ;

// fragment NameStartChar 
//     : [\p{Ll}]  // Unicode Lowercase Letter : [a..z] and others
//     | [\p{Lm}]  // Unicode Modifier Letter  :
//     | [\p{Lo}]  // Unicode Other Letter     :
//     | [\p{Lt}]  // Unicode Titlecase Letter :
//     | [\p{Lu}]  // Unicode Uppercase Letter : [A..Z] and others
//     | '\u0024'  // Unicode dollar sign      : [$]
//     //| ~InvalidStartChar
//     | ~[\p{Cc}\p{Zl}\p{Zp}\p{Zs}\p{Cs}\p{Cn}\p{Nd}\p{Pc}]
//     ;

// fragment InvalidStartChar
//     : [\p{Cc}]  // Unicode Control
//     | [\p{Zl}]  // Unicode Line separator
//     | [\p{Zp}]  // Unicode Paragraph separator 
//     | [\p{Zs}]  // Unicode Space separator
//     | [\p{Cs}]  // Unicode Surrogate
//     | [\p{Cn}]  // Unicode Unassigned
//     | [\p{Nd}]  // Unicode Decimal Digit Number
//     | [\p{Pc}]  // Unicode Connector Punctuation
//     ;

fragment NameChar
   : NameStartChar
   | '0'..'9'
   | UNDERSCORE
   | '\u00B7'
   | '\u0300'..'\u036F'
   | '\u203F'..'\u2040'
   //@LF see gramars-v4/java/java9/Java9Lexer.g4 line 487 on super class Check predicates! 
   ;
   
fragment NameStartChar
   : 'A'..'Z' 
   | 'a'..'z'
   | '\u00C0'..'\u00D6'
   | '\u00D8'..'\u00F6'
   | '\u00F8'..'\u02FF'
   | '\u0370'..'\u037D'
   | '\u037F'..'\u1FFF'
   | '\u200C'..'\u200D'
   | '\u2070'..'\u218F'
   | '\u2C00'..'\u2FEF'
   | '\u3001'..'\uD7FF'
   | '\uF900'..'\uFDCF'
   | '\uFDF0'..'\uFFFD'
   ;

fragment IDCHAR
	: LETTER
	| DIGIT
	| UNDERSCORE
	;

fragment UNDERSCORE: '_';

fragment LETTER: [a-zA-Z];
fragment DIGIT: [0-9];
fragment NZDIGIT: [1-9];

fragment OCTAL_DIGIT: [0-7];
fragment HEXADECIMAL_DIGIT: DIGIT | [a-fA-F];
fragment ESC: 
    // No \b escape character for VDM
 	  '\\' [rntfea"\\] // \r \n \t etc; 
	| '\\x' HEXADECIMAL_DIGIT HEXADECIMAL_DIGIT
	| '\\u' HEXADECIMAL_DIGIT HEXADECIMAL_DIGIT HEXADECIMAL_DIGIT HEXADECIMAL_DIGIT
	| '\\c' LETTER  
	| '\\' OCTAL_DIGIT OCTAL_DIGIT OCTAL_DIGIT
	| '\\"'  // \" escape double quote
	| '\\\'' // \' escape quote
	; 

fragment NL
    : [\r\n\u000C]
    ;

fragment NNL
    : ~[\r\n\u000C]
    ;

//------------------------
// Whitespace and comments
//------------------------
SPACE: [ ]+ -> channel(1);
TAB: [\t]+ -> channel(2);
CR: NL+ -> channel(3);
SINGLE_LINE_COMMENT: '--' NNL* -> channel(4);
MULTIPLE_LINE_COMMENT: '/*' .*? '*/' -> channel(5);
UnrecognizedChar: .;

//TODO add lexing mode or type for --@ annotations?

//TODO add VDMLexBase check rule for inv_/pre_/post_/eq_/min_/max_/init_/is_/mk_/obj_?