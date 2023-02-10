grammar Test ;

//import VDMLex ;

expr_list
    : expr (',' expr)*
    ;
    
expr 
    : '(' expr ')'
    | expr '.#' NUMERAL 
    | expr '.' name
    | 'mk_' '(' expr ',' expr_list ')'
    |<assoc=right> expr '**' expr
    | expr ('*' | '/') expr
    | expr ('+' | '-') expr
    | SYMBOLIC_LITERAL
    | name
    ;

name
    : IDENTIFIER ('`' IDENTIFIER)?
    ;

NUMERAL
    : DIGIT+
    ;

BOOL_LIT
    : 'true' | 'false';

IDENTIFIER 
    : LETTER (LETTER | DIGIT | '_')*
    ; 

SYMBOLIC_LITERAL
    : NUMERAL 
    | BOOL_LIT
    ;

fragment LETTER: [a-zA-Z];
fragment DIGIT: [0-9];

SPACE: [ ]+ -> channel(1);
TAB: [\t]+ -> channel(2);
CR: [\n\r]+ -> channel(3);
