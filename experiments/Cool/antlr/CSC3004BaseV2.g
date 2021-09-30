grammar CSC3004BaseV2;

program	: 'program' body 'end';

// doesn't make sense to have an empty program; rule it out: at least some variables with at least one statement
body 	: var+ | stmts;

// multiple ids? wasn't it with a ':'?
var	: scalarType ID ';' ;	

stmts	: stmt (';' stmts);

scalarType
	: 'int' | 'bool';
	
scalarValue
	: INT | BOOL;
	
stmt	: assign | ifstmt | whilest;

ifstmt	: 'if' relExpr 'then' stmt 'else' stmt 'fi';

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

WS  :   ( ' '
        | '\t'
        | '\r'
        | '\n'
        ) {$channel=HIDDEN;}
    ;


