// adds tree grammar walking capabilities to it
grammar CSC3004BaseV5;

program	: 'program' body 'end';

// doesn't make sense to have an empty program; rule it out: at least some variables with at least one statement
// here the program input fails because we take only var+ OR stmts but not both... remove the |
body 	: var+ stmts;
 	
// multiple ids per scalar type?
var	: scalarType (ID (',' ID)*) ';' ;	

stmts	: stmt (';' stmts)?;

scalarType
	: 'int' | 'bool';
	
scalarValue
	: INT | BOOL;
	
stmt	: assign | ifstmt | whilest;

ifstmt	: 'if' relExpr 'then' stmts 'else' stmts 'fi';

whilest	: 'while' relExpr 'do' stmts 'od';

assign	: ID ':=' arithExpr;


// expressions in LL parsers *must* be given by predecende order rather 
// than by each case/type of expression.
expr	:  relExpr;

relExpr	: arithExpr ( RELOP arithExpr )?;

arithExpr
	: atom ( ARITHOP atom )*;


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


