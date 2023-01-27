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
 
lexer grammar VdmSLLexer;

//------------------------
// Lexer Rules
// NOTES:
//  - in antlr, all lexer rules and constants start with a Capital letter
//  -  ANTLR resolves lexical ambiguities by matching the input string to the rule specified first in the grammar
//     An example common ambiguity in programming languages is that between keywords and identifier rules.
//     Keyword begin (followed by a nonletter) is also an identifier, at least lexically, so the lexer can match b-e-g-i-n to either rule.
//     Because of this, it is important to place all keywords before the identifiers
//------------------------
	
//------------------------
// Keywords (case sensitive); added all for simplicity
//------------------------
SL_KEYWORD:
	  'abs' 
	| 'and' 
	| 'as' 
	| 'be' 
	| 'bool' 
	| 'by' 
	| 'card' 
	| 'cases' 
	| 'char' 
	| 'comp' 
	| 'compose' 
	| 'conc' 
	| 'dcl' 
	| 'def' 
	| 'definitions' 
	| 'dinter' 
	| 'div' 
	| 'do'
	| 'dom' 
	| 'dunion' 
	| 'elems' 
	| 'else' 
	| 'elseif' 
	| 'end' 
	| 'eq' 
	| 'error' 
	| 'errs' 
	| 'exists' 
	| 'exists1' 
	| 'exit' 
	| 'exports' 
	| 'ext' 
	| 'false' 
	| 'floor'
	| 'for' 
	| 'forall' 
	| 'from' 
	| 'functions' 
	| 'hd' 
	| 'if' 
	| 'in' 
	| 'inds' 
	| 'inmap' 
	| 'int' 
	| 'inter'
	| 'imports' 
	| 'init' 
	| 'inv' 
	| 'inverse' 
	| 'iota' 
	| 'is'
	| 'lambda' 
	| 'len' 
	| 'let'
	| 'map' 
	| 'measure' 
	| 'merge' 
	| 'mod' 
	| 'module' 
	| 'mu' 
	| 'munion' 
	| 'nat' 
	| 'nat1' 
	| 'nil' 
	| 'not' 
	| 'of' 
	| 'operations' 
	| 'or' 
	| 'ord' 
	| 'others' 
	| 'post' 
	| 'power' 
	| 'pre' 
	| 'pure' 
	| 'rat' 
	| 'rd' 
	| 'real' 
	| 'rem' 
	| 'renamed' 
	| 'return' 
	| 'reverse' 
	| 'rng'
	| 'seq' 
	| 'seq1'
	| 'set' 
	| 'set1' 
	| 'skip' 
	| 'specified' 
	| 'st' 
	| 'state' 
	| 'subset' 
	| 'then' 
	| 'tixe'
	| 'tl' 
	| 'to' 
	| 'token' 
	| 'traces' 
	| 'trap' 
	| 'true' 
	| 'types' 
	| 'undefined' 
	| 'union' 
	| 'variables' 
	| 'values'
	| 'while' 
	| 'wr' 
	| 'yet' 
	| 'RESULT' ;

PP_KEYWORD:
	  'class'
	| 'instance' 
	| 'isofbaseclass' 
	| 'isofclass' 
	| 'new' 
	| 'private' 
	| 'protected' 
	| 'psubset'
	| 'public' 
	| 'responsibility' 
	| 'samebaseclass' 
	| 'sameclass' 
	| 'self' 
	| 'struct' 
	| 'subclass' 
	| 'uselib' 
	| 'with' ;

RT_KEYWORD:
	  '#act' 
	| '#active' 
	| '#fin' 
	| '#req' 
	| '#waiting' 
	| 'all' 
	| 'always' 
	| 'async' 
	| 'atomic' 
	| 'cycles' 
	| 'dlmodule' 
	| 'duration' 
	| 'mutex' 
	| 'per' 
	| 'periodic' 
	| 'sporadic' 
	| 'start' 
	| 'startlist' 
	| 'stop' 
	| 'stoplist'
	| 'sync'
	| 'system' 
	| 'thread' 
	| 'threadid' 
	| 'time';

KEYWORD:
	  SL_KEYWORD 
	| PP_KEYWORD
	| RT_KEYWORD;

EXPONENT: ('E' | 'e') ('+' | '-')? NUMERAL; 
DECIMAL_LITERAL: NUMERAL ('.' NUMERAL)? (EXPONENT)?;
HEXADECIMAL_LITERAL: ('0x' | '0X') HEXADECIMAL_DIGIT+;

NUMERIC_LITERAL: 
	  DECIMAL_LITERAL 
	| HEXADECIMAL_LITERAL;

//@NB these are already keywords? 
// BOOLEAN_LITERAL: 
// 	  'true'
// 	| 'false';
//
// NIL_LITERAL: 'nil';

CHARACTER_LITERAL: '\'' (CHARACTER | ESC) '\'';

//@LF Paolo what's '.' here? 
//@NB why have the duplicate \" given it's already in escape sequence? 
TEXT_LITERAL: '"' (CHARACTER | ESC | .)*? '"';

QUOTE_LITERAL: '<' IDENTIFIER '>';

SYMBOLIC_LITERAL:
	  NUMERIC_LITERAL
	//| BOOLEAN_LITERAL
	//| NIL_LITERAL 
	| CHARACTER_LITERAL 
	| TEXT_LITERAL
	| QUOTE_LITERAL;

//@LF Paolo prefers to lex operators separaterly, as ANTLR rules for
//    operator precedence are tricky! 
O_IFF: '<=>';
O_IMPLIES: '=>' ;
O_NOT: 'not';
O_AND: 'and';
O_OR: 'or';
O_NOT_EQUAL: '<>';
O_LT: '<' ;
O_GT: '>' ;
O_EQUAL: '=';
O_COMMA: ',';
O_SUCH_THAT: '|';
O_COLON: ':';
O_SEMICOLON: ';';
O_DIV: '/';
O_TIMES: '*';
O_PLUS: '+';
O_MINUS: '-';
O_EXP: '**';

PAREN_L: '(';
PAREN_R: ')';
BRACKET_L: '[';
BRACKET_R: ']';
BRACE_L: '{';
BRACE_R: '}';

IDENTIFIER: INITIAL_LETTER FOLLOWING_LETTER*;

//------------------------
// Fragments necessary for the lexer that we choose not to tokenize individually
//------------------------
fragment IDCHAR
	: LETTER
	| DIGIT
	| '_'
	;

fragment LETTER: [a-zA-Z];
fragment DIGIT: [0-9];
fragment NZDIGIT: [1-9];
fragment INITIAL_LETTER: LETTER | DIGIT; //@NB help :-)
fragment FOLLOWING_LETTER: LETTER | DIGIT | '_'; 
fragment CHARACTER: LETTER | DIGIT | '_';//@NB how best to complete this list? 

fragment NUMERAL: DIGIT+;
fragment OCTAL_DIGIT: [0-7];
fragment HEXADECIMAL_DIGIT: DIGIT | [a-fA-F];
fragment ESC: 
	'\\' [rntfea"\\] // \r \n \t etc; //@NB: no \b?...
	| '\\x' HEXADECIMAL_DIGIT HEXADECIMAL_DIGIT
	| '\\u' HEXADECIMAL_DIGIT HEXADECIMAL_DIGIT HEXADECIMAL_DIGIT HEXADECIMAL_DIGIT
	| '\\c' LETTER //@NB where to get the complete list? 
	| '\\' OCTAL_DIGIT OCTAL_DIGIT OCTAL_DIGIT
	| '\\"'  // \" escape double quote
	| '\\\'' // \' escape quote
	; 

//------------------------
// Whitespace and comments
//------------------------
SPACE: [ ]+ -> channel(1);
TAB: [\t]+ -> channel(2);
CR: [\r\n\u000C]+ -> channel(3);
SINGLE_LINE_COMMENT: '--' ~[\r\n]* -> channel(4);
MULTIPLE_LINE_COMMENT: '/*' CHARACTER '*/' -> channel(4);
UnrecognizedChar: .;