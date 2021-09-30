grammar CSC3004BaseV7;

// adds tree grammar walking capabilities to it; use STMTS as an invisible tree-grammar token
options {output=AST;}

// artificial tokens used for AST construction: "->" rules below determine how the AST is to be constructed from the concrete syntax
tokens { PROG; DECLS; STMTS; }

program	: 'program' body 'end'				-> ^(PROG body);

// doesn't make sense to have an empty program; rule it out: at least some variables with at least one statement
// here the program input fails because we take only var+ OR stmts but not both... remove the |
body 	: var+ stmts;
 	
// multiple ids per scalar type?
var	: scalarType (ID (',' ID)*) ';' 		-> ^(DECLS scalarType ID ID*);	

stmts	: stmt (';'^ stmts)?				;//-> ^(STMTS[';'] stmt stmts?); ???

scalarType
	: 'int' | 'bool';
	
scalarValue
	: INT | BOOL;
	
stmt	: assign | ifstmt | whilest | block ;

block   : 'begin' body? 'end'				-> ^('begin' body?);

ifstmt	: 'if' relExpr 'then' stmts 'else' stmts 'fi'	-> ^('if' stmts stmts);

whilest	: 'while' relExpr 'do' stmts 'od'		-> ^('while' relExpr stmts);

assign	: ID ':=' arithExpr				-> ^(':=' ID arithExpr);


// expressions in LL parsers *must* be given by predecende order rather 
// than by each case/type of expression.
expr	:  relExpr;

relExpr	: arithExpr (RELOP^ arithExpr)?;		//-> ^(RELOP arithExpr arithExpr?);

arithExpr
	: atom (ARITHOP^ atom)*;


atom	: ID | scalarValue ; // | '(' expr ')';


INT :	'0'..'9'+
    ;

BOOL	: 'true' | 'false'	
	;

RELOP	: '=' | '<' | '>' | '!='
	;
	
ARITHOP	: '+' | '-'
	;

ID  :	('a'..'z'|'A'..'Z'|'_') ('a'..'z'|'A'..'Z'|'0'..'9'|'_')*
    ;

COMMENT
    :   '//' ~('\n'|'\r')* '\r'? '\n' {$channel=HIDDEN;}
    |   '/*' ( options {greedy=false;} : . )* '*/' {$channel=HIDDEN;}
    ;

WS  :   ( ' '
        | '\t'
        | '\r'
        | '\n'
        ) {$channel=HIDDEN;}
    ;


