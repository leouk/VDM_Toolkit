--- for V2

program 
int i, j;

-- missing multiple ids...

program 
int i;
int j; 
bool b;
	j := b;
	i := b + 1; 
	if 42 then 
		i := true
	else
		j := i;
	fi
end;

a) doesn't interpret the assignment, because of the tab? [lexis of WS]
b) or because of body production? [effect of "|" in a production]
c) why the error on the if-then-else? [dangling ";" on else branch. maybe allow it?] 

--- for V3

program 
// comment: add list of variables
int i, j;
bool b;
	// white space (tab, nl) is lexed as ignore
	j := b;
	i := b + 1; 
	if 42 then 
		i := true
	else
		// dangling semicolon not allowed for single statement
		j := i
	fi
end

a) why the error after the fi? [sees mismatch token exception because of no ensuing stmts] 
b) what about while? [add while above to see diff error: NoViableAltException] 
	;
	while x < 10 do
		x := x + 1
	od
c) why diff errors? [one is a missing 'end' after 'fi'; other a missing 'od'!]
d) fix grammar

--- for V4

program 
// comment: add list of variables
int i, j;
bool b;
	// white space (tab, nl) is lexed as ignore
	j := b;
	i := b + 1; 
	if 42 then 
		i := true
	else
		// dangling semicolon not allowed for single statement
		j := i
	fi;
	while x < 10 do
		x := x + 1
	od
end

--- for V5

a) forgot to have more than one statement at if-the-else!

--- for V6

a) added blocks
b) identified missing parenthesised expressions 
c) identified annoying dangling ";" changing meaning of Stmts
d) identified if-then is not allowed (e.g., always need else)

--- for V7

a) added AST constructs


