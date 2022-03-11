tree grammar CSC3004WalkerBaseV7;

options {
	tokenVocab=CSC3004BaseV7;
	ASTLabelType=CommonTree;
	output=AST;
//	backtrack=true ; ???
//	rewrite=true; // works either in rewrite or normal mode
}

program	: ^(PROG body);

body	:	