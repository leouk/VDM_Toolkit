# Complex productions

## `expression`

We must eliminate left-recursion, so have to have the whole tree in one place with labelled attributes. 
See ANTLR4 reference guide section 5.2 on left recursion elimination.

Left recursion use (implicitly defined) semantic predicates to induce a priority grammar 
(e.g. precedence defined according to order of definition of productions). This works well for 
left recursion where all (or most) productions participate (e.g. ^, *, /, +, -, ID expressions). 

ANTLR4 identifies productions with left recursion first; they get highest priority according to their
placement in the grammar (i.e. earlier production has higher precedence). All other (non-left recursive)
productions are considered primary and can be declared *in any order*. To really identify what priority
rules will have, have a look at VDM.java private ExpressionContext expression(int _p) method.

Here, name will win to "expression SEP_tsel expression"! So, either we need a semantic predicate in name 
or a grammar rearrangemnts for left-recursive expressions that are lower priority than name.    

VDM language manual appendix C talks about ``relative precedences of the operators within families is 
determined by considering type information, and this is used to resolve ambiguity.'' Yet, the grammar of
appendix A does not separate the expression tree in such families. Here, we will have to in order to avoid
the hidden left-recursion induced by rules like tuple selector, etc. 

In VDMJ, expressions (in the hand-made parser) are dealt with by 
com.fujitsu.vdmj.syntax.ExpressionReader#readExpression, which cascades the appendix C grammar as we do
below in ANTLR4's EBNF format. From the manual we have that families' precedences are as follows:
     ``combinators > applicators > evaluators > relations > connectives > constructors``

That means, we build the expression grammar from primary (non recursive) production upwards through the family
ordering, starting with combinators all to way to constructors. Within recursive productions, the earlier declaration
has higher priority (precedence), hence we follow that order 

In ANTLR(3)4 hidden left recursion removal (see the ALL(*) technical report appendix C), one cascades the left
recursion through operators, with lower precedence families at the top, all the way down to primary (non-left
recursive operators). The semantic-predicate gated productions (e.g. {isVDMRT())? won't appear in parser?  