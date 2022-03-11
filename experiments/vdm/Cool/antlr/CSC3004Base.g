grammar CSC3004Base;

// select rule on syntax diagram to show the syntactic conflict
// conflicts: program; declaratio; vars; body (see side panel)
program	: declaration+;

// missing program ... end.
declaration
	: vars | body;

vars	: var*;
var	: ID ':' scalarType ';' ;	

body	: stmts*
	;

stmts	: stmt (';' stmts);

scalarType
	: 'int' | 'bool';
	
scalarValue
	: INT | BOOL;
	
stmt	: assign | ifstmt | whilest;

assign	: ID ':=' arithExpr;


// missinng 'fi'  / 'od' 
ifstmt	: 'if' relExpr 'then' stmt 'else' stmt;

whilest	:   'while' relExpr 'do' body;

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


