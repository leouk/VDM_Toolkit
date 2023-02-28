package vdmantlr;

import java.io.File;
import java.io.IOException;
import java.util.Collections;
import java.util.List;
import java.util.Vector;

import org.antlr.v4.runtime.BaseErrorListener;
import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.DiagnosticErrorListener;
import org.antlr.v4.runtime.ParserRuleContext;
import org.antlr.v4.runtime.RecognitionException;
import org.antlr.v4.runtime.Recognizer;
import org.antlr.v4.runtime.atn.ParserATNSimulator;
import org.antlr.v4.runtime.atn.PredictionMode;
import org.antlr.v4.runtime.tree.ParseTree;
import org.antlr.v4.runtime.tree.ParseTreeProperty;
import org.antlr.v4.runtime.tree.ParseTreeWalker;
import org.antlr.v4.runtime.tree.TerminalNode;

import com.fujitsu.vdmj.ast.ASTNode;
import com.fujitsu.vdmj.ast.expressions.ASTBooleanLiteralExpression;
import com.fujitsu.vdmj.ast.expressions.ASTCharLiteralExpression;
import com.fujitsu.vdmj.ast.expressions.ASTExpression;
import com.fujitsu.vdmj.ast.expressions.ASTIntegerLiteralExpression;
import com.fujitsu.vdmj.ast.expressions.ASTNilExpression;
import com.fujitsu.vdmj.ast.expressions.ASTQuoteLiteralExpression;
import com.fujitsu.vdmj.ast.expressions.ASTRealLiteralExpression;
import com.fujitsu.vdmj.ast.expressions.ASTStringLiteralExpression;
import com.fujitsu.vdmj.ast.lex.LexBooleanToken;
import com.fujitsu.vdmj.ast.lex.LexCharacterToken;
import com.fujitsu.vdmj.ast.lex.LexIdentifierToken;
import com.fujitsu.vdmj.ast.lex.LexIntegerToken;
import com.fujitsu.vdmj.ast.lex.LexKeywordToken;
import com.fujitsu.vdmj.ast.lex.LexNameToken;
import com.fujitsu.vdmj.ast.lex.LexQuoteToken;
import com.fujitsu.vdmj.ast.lex.LexRealToken;
import com.fujitsu.vdmj.ast.lex.LexStringToken;
import com.fujitsu.vdmj.ast.modules.ASTModuleList;
import com.fujitsu.vdmj.ast.patterns.ASTBind;
import com.fujitsu.vdmj.ast.patterns.ASTBooleanPattern;
import com.fujitsu.vdmj.ast.patterns.ASTCharacterPattern;
import com.fujitsu.vdmj.ast.patterns.ASTExpressionPattern;
import com.fujitsu.vdmj.ast.patterns.ASTIdentifierPattern;
import com.fujitsu.vdmj.ast.patterns.ASTIgnorePattern;
import com.fujitsu.vdmj.ast.patterns.ASTIntegerPattern;
import com.fujitsu.vdmj.ast.patterns.ASTMapPattern;
import com.fujitsu.vdmj.ast.patterns.ASTMapUnionPattern;
import com.fujitsu.vdmj.ast.patterns.ASTMapletPattern;
import com.fujitsu.vdmj.ast.patterns.ASTMapletPatternList;
import com.fujitsu.vdmj.ast.patterns.ASTMultipleBind;
import com.fujitsu.vdmj.ast.patterns.ASTMultipleBindList;
import com.fujitsu.vdmj.ast.patterns.ASTMultipleSeqBind;
import com.fujitsu.vdmj.ast.patterns.ASTMultipleSetBind;
import com.fujitsu.vdmj.ast.patterns.ASTMultipleTypeBind;
import com.fujitsu.vdmj.ast.patterns.ASTNamePatternPairList;
import com.fujitsu.vdmj.ast.patterns.ASTNilPattern;
import com.fujitsu.vdmj.ast.patterns.ASTObjectPattern;
import com.fujitsu.vdmj.ast.patterns.ASTPattern;
import com.fujitsu.vdmj.ast.patterns.ASTPatternList;
import com.fujitsu.vdmj.ast.patterns.ASTQuotePattern;
import com.fujitsu.vdmj.ast.patterns.ASTRealPattern;
import com.fujitsu.vdmj.ast.patterns.ASTRecordPattern;
import com.fujitsu.vdmj.ast.patterns.ASTSeqBind;
import com.fujitsu.vdmj.ast.patterns.ASTSetBind;
import com.fujitsu.vdmj.ast.patterns.ASTSetPattern;
import com.fujitsu.vdmj.ast.patterns.ASTStringPattern;
import com.fujitsu.vdmj.ast.patterns.ASTTuplePattern;
import com.fujitsu.vdmj.ast.patterns.ASTTypeBind;
import com.fujitsu.vdmj.ast.patterns.ASTTypeBindList;
import com.fujitsu.vdmj.ast.types.ASTType;
import com.fujitsu.vdmj.lex.LexLocation;

import vdmantlr.generated.VDMBaseListener;
//import vdmantlr.generated.VDMLex; which one?
import vdmantlr.generated.VDMLexer;
import vdmantlr.generated.VDMParser;

public class VDMASTListener extends VDMBaseListener {
    
    public static final String EXPR_TEST = "./exprScenario/setEnum.expr";
    public static final String PAT_TEST = "./patternScenario/example.pat";
    public static final String TEST = PAT_TEST;

    public static void main(String[] argv) throws IOException
    {
        VDMASTListener listener = new VDMASTListener(TEST);
        ParseTree t = listener.parser.pattern_list();//parser.expression();
        ParseTreeWalker.DEFAULT.walk(listener, t);
        System.out.println("\ntree="+t.toStringTree(listener.parser)+"\n");
        ASTPatternList n = listener.getListNode((VDMParser.Pattern_listContext)t, ASTPatternList.class);
        System.out.println("VDM=" + n.toString()+"\n");
    }

    public static enum SymbolicLiteralType { PATTERN, EXPRESSION }

    public static class VDMErrorListener extends BaseErrorListener 
    {   
        @Override
        public void syntaxError(Recognizer<?, ?> recognizer, 
            Object offendingSymbol, int line, int charPositionInLine, String msg, RecognitionException e)
        {
            List<String> stack = ((VDMParser)recognizer).getRuleInvocationStack(); 
            Collections.reverse(stack);
            System.err.println("rule stack: "+stack);
            System.err.println("line "+line+":"+charPositionInLine+" at "+offendingSymbol+": "+msg);
            underlineError(recognizer, (org.antlr.v4.runtime.Token)offendingSymbol, line, charPositionInLine);
        } 

        protected void underlineError(Recognizer<?, ?> recognizer, org.antlr.v4.runtime.Token offendingToken, 
            int line, int charPositionInLine) 
        {
            CommonTokenStream tokens = (CommonTokenStream)recognizer.getInputStream();
            String input = tokens.getTokenSource().getInputStream().toString(); 
            String[] lines = input.split("\n");
            String errorLine = lines[line - 1];
            System.err.println(errorLine);
            for (int i=0; i<charPositionInLine; i++) 
                System.err.print(" "); 
            int start = offendingToken.getStartIndex();
            int stop = offendingToken.getStopIndex();
            if ( start>=0 && stop>=0 ) {
                for (int i=start; i<=stop; i++) 
                    System.err.print("^"); 
            }
            System.err.println(); 
        }
    }
        
    
    //See ANTLR4 discussion on options Chapter 7. Choosing listeners with parse tree properties (i.e. to avoid visitor aggregation?)
    private final ParseTreeProperty<ASTNode> nodes;
    private final ParseTreeProperty<Vector<? extends ASTNode>> lists;
    private final VDMParser parser;
    protected ASTModuleList astModuleList;
    private final File currentFile;
    private String currentModule;
    private SymbolicLiteralType littype; 

    public VDMASTListener(String fileName) throws IOException
    {
        super();
        littype = null;
        currentModule = "DEFAULT";
        if (fileName == null || fileName.isEmpty())
            throw new IllegalArgumentException("Invalid file name " + fileName);
        currentFile = new File(fileName);
        if (!currentFile.exists())
            throw new IllegalArgumentException("File name does not exist: " + fileName);
        CharStream input = CharStreams.fromFileName(fileName); 
        //ANTLRInputStream input = new ANTLRInputStream(System.in); 
        // or read stdin SimpleLexer lexer = new SimpleLexer(input);
        VDMLexer lexer = new VDMLexer(input);
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        parser = new VDMParser(tokens);

        // if we want full ambiguity/diagnostic information
        parser.removeErrorListeners(); // remove ConsoleErrorListener 
        parser.addErrorListener(new DiagnosticErrorListener());
        parser.getInterpreter().setPredictionMode(PredictionMode.LL_EXACT_AMBIG_DETECTION);
        // might as well add some extra information of our own 
        parser.addErrorListener(new VDMErrorListener());
        
        parser.setTrace(true);
        //ParserATNSimulator.debug = true;
        nodes = new ParseTreeProperty<ASTNode>();
        lists = new ParseTreeProperty<Vector<? extends ASTNode>>();
        astModuleList = null;
    }

    protected void throwMessage(int number, String message, LexLocation location) throws com.fujitsu.vdmj.syntax.ParserException, com.fujitsu.vdmj.lex.LexException
    {
        //from MESSAGES: 1000-1999 = Lexing errors
        if (number >= 1000 && number < 2000)
            throw new com.fujitsu.vdmj.lex.LexException(number, message, location);
        else
            //TODO figure out token depth from ANTLR somehow
            throw new com.fujitsu.vdmj.syntax.ParserException(number, message, location, 1);//reader.getTokensRead());
    }

    /**
     * Transforms an ANTLR parser rule context (for each parsing production) into a VDMJ LexLocation.
     * It uses the context start and stop token information. @TODO Perhaps add to lexing contexts as well? 
     * @param ctx parsing context requiring LexLocation information
     * @return VDMJ-equivalent LexLocation from given contex
     */
    //See ANTLR4 Section 3.2; 2loc below is not quite right.
    //CommonToken: [@5,8:10='451',<4>,1:8] 
    //[@TokenIndex(0), StartPos(0):EndPos(inclusive)='TEXT',<TYPE>,StartLine(1):StartChar(0)]
    protected LexLocation token2loc(ParserRuleContext ctx)
    {
        return new LexLocation(currentFile, currentModule, 
            ctx.getStart().getLine(), ctx.getStart().getCharPositionInLine(),
            ctx.getStop().getLine(), ctx.getStop().getCharPositionInLine()+1);
    }

    protected LexLocation token2loc(TerminalNode terminal)
    {
        int line = terminal.getSymbol().getLine();
        return new LexLocation(currentFile, currentModule, line, 
            terminal.getSymbol().getStartIndex(), line, terminal.getSymbol().getStopIndex());
    }

	/**
	 * Convert an identifier into a name. A name is an identifier that has
	 * a module name qualifier, so this method uses the current module to
	 * convert the identifier passed in.
	 *
	 * @param id The identifier to convert
	 * @return The corresponding name.
	 */
    //com.fujitsu.vdmj.syntax.SyntaxReader.idToName
    protected LexNameToken id2lexname(LexIdentifierToken id)
	{
		return new LexNameToken(currentModule, id);
	}

    protected LexIntegerToken str2int(LexLocation location, String s, int base
    )
    {
        LexIntegerToken result;
        try
        {
            long l = Long.parseLong(s, base);
            result = new LexIntegerToken(l, location);
        }
        catch (NumberFormatException e)
        {
            //throwMessage(1014, "Cannot convert [" + s + "] in base " + base, location);
            throw e;
        }
        return result;
    }

    protected LexRealToken str2real(LexLocation location, String s)
    {
        LexRealToken result;
        try
        {
            double d = Double.parseDouble(s);
            result = new LexRealToken(d, location);
        }
        catch (NumberFormatException e)
        {
            throw new UnsupportedOperationException();
        }
        return result;
    }

    private void checkResult(ParserRuleContext ctx, Object result, Class<?> resultExpectedClass)
    {
        assert resultExpectedClass != null;
        if (result == null)
            throw new UnsupportedOperationException("No node for " + ctx != null ? ctx.getClass().getSimpleName() : "null ctx(!?)");
        if (!resultExpectedClass.isAssignableFrom(result.getClass()))
            throw new UnsupportedOperationException("Expected " + resultExpectedClass.getSimpleName() + " but found " + result.getClass().getSimpleName());
    }

    @SuppressWarnings("unchecked")
    protected <T extends ASTNode> T getNode(ParserRuleContext ctx, Class<T> resultExpectedClass)
    {
        ASTNode result = nodes.get(ctx);
        checkResult(ctx, result, resultExpectedClass);
        return (T)result;
    }

    @SuppressWarnings("unchecked")
    protected <T extends Vector<? extends ASTNode>> T getListNode(ParserRuleContext ctx, Class<T> resultExpectedClass)
    {
        Vector<? extends ASTNode> result = lists.get(ctx);
        checkResult(ctx, result, resultExpectedClass);
        return (T)result;
    }

    protected void putNode(ParserRuleContext ctx, ASTNode node)
    {
        checkResult(ctx, node, node == null ? ASTNode.class : node.getClass());
        nodes.put(ctx, node);
    }

    protected void putListNode(ParserRuleContext ctx, Vector<? extends ASTNode> node)
    {
        checkResult(ctx, node, node == null ? Vector.class : node.getClass());
        lists.put(ctx, node);
    }

    /**
     * Transforms the given terminal node id (e.g. ctx.IDENTIFIER()) for the given context, which will
     * be the location source information. 
     * @param id
     * @param ctx
     * @param old
     * @return
     */
    //Could have a ParserRuleContext and have
    protected LexIdentifierToken id2lexid(TerminalNode id, ParserRuleContext ctx, boolean old)
    {
        //TerminalNode id = getToken(VDMParser.IDENTIFIER, 0);? but might not be general
        return new LexIdentifierToken(id.getText(), old, token2loc(ctx));
    }


    //ASTModule
	@Override 
    public void enterSl_document(VDMParser.Sl_documentContext ctx) 
    {
        astModuleList = new ASTModuleList();
    }

    @Override
    public void exitModule(VDMParser.ModuleContext ctx)
    {
        assert ctx.modName != null && ctx.endName != null;
        if (!ctx.modName.getText().equals(ctx.endName.getText()))
		{
			//throwMessage(2049, "Expecting 'end " + ctx.modName.getText() + "'");
		}
        putNode(ctx, null);
    }

    @Override
    public void enterSet_enumeration(VDMParser.Set_enumerationContext ctx)
    {
        System.out.println("Enter set_enum: " + ctx.getText());
    }

    @Override
    public void exitSet_enumeration(VDMParser.Set_enumerationContext ctx)
    {
        System.out.println("Exit set_enum: " + ctx.getText());
    }

    @Override
    public void enterSetEnumExpr(VDMParser.SetEnumExprContext ctx)
    {
        System.out.println("Enter #SetEnumExpr: " + ctx.getText());
    }

    @Override
    public void exitSetEnumExpr(VDMParser.SetEnumExprContext ctx)
    {
        System.out.println("Exit #SetEnumExpr: " + ctx.getText());
    }

    @Override
    public void enterExpression_list(VDMParser.Expression_listContext ctx)
    {
        System.out.println("Enter expression_list: " + ctx.getText());
    }

    @Override
    public void exitExpression_list(VDMParser.Expression_listContext ctx)
    {
        System.out.println("Exit expression_list: " + ctx.getText());
    }

    @Override
    public void enterArithmeticPlusExpr(VDMParser.ArithmeticPlusExprContext ctx)
    {
        System.out.println("Enter #ArithmeticPlusExpr: " + ctx.getText());
    }

    @Override
    public void exitArithmeticPlusExpr(VDMParser.ArithmeticPlusExprContext ctx)
    {
        System.out.println("Exit #ArithmeticPlusExpr: " + ctx.getText());
    }

    @Override
    public void enterArithmeticMultiplicationExpr(VDMParser.ArithmeticMultiplicationExprContext ctx)
    {
        System.out.println("Enter #ArithmeticMultiplicationExpr: " + ctx.getText());
    }

    @Override
    public void exitArithmeticMultiplicationExpr(VDMParser.ArithmeticMultiplicationExprContext ctx)
    {
        System.out.println("Exit #ArithmeticMultiplicationExpr: " + ctx.getText());
    }

    @Override
    public void enterSymbolicLitExpr(VDMParser.SymbolicLitExprContext ctx)
    {
        this.littype = SymbolicLiteralType.EXPRESSION;
    }

    @Override
    public void exitSymbolicLitExpr(VDMParser.SymbolicLitExprContext ctx)
    {
        if (!SymbolicLiteralType.EXPRESSION.equals(littype))
            throw new UnsupportedOperationException("Expected symbolic literal expression but found " + String.valueOf(littype));
        this.littype = null; 
        ASTExpression node = getNode(ctx.symbolic_literal(), ASTExpression.class);
        nodes.removeFrom(ctx.symbolic_literal());
        putNode(ctx, node);
    }

//------------------------
// A.8 Patterns and Bindings
//------------------------

//------------------------
// A.8.1 Patterns + Literals
//------------------------

    @Override 
    public void exitPattern_list(VDMParser.Pattern_listContext ctx)
    {
        // empty pattern list (empty set/q etc) is non-null 
        ASTPatternList result = new ASTPatternList();
        for(VDMParser.PatternContext p : ctx.pattern())
        {
            result.add(getNode(p, ASTPattern.class));
        }
        //TODO has to be Mappable? Instead of ASTNode?!
        putListNode(ctx, result);
    }

    @Override
    public void exitBracketedExprPattern(VDMParser.BracketedExprPatternContext ctx)
    {
        putNode(ctx, new ASTExpressionPattern(getNode(ctx.expression(), ASTExpression.class)));
    }

    public static enum NumericLiteralType { INT10, INT16, REAL }

    private final NumericLiteralType figureOutNumericLiteralType(String s)
    {
        //TODO these to me sounds like lexing rules that could have more info? 
        NumericLiteralType result; 
        if (s.startsWith("0x") || s.startsWith("0X"))
            result = NumericLiteralType.INT16;
        else if (s.indexOf(".") != -1 || 
                 s.indexOf("e") != -1 ||
                 s.indexOf("E") != -1)
            result = NumericLiteralType.REAL;
        else 
            result = NumericLiteralType.INT10;
        return result;
    }
    @Override 
    public void exitNumericLiteral(VDMParser.NumericLiteralContext ctx)
    {
        LexLocation location = token2loc(ctx);
        if (littype == null)
            throw new UnsupportedOperationException("Invalid literal type");
        String p = ctx.NUMERIC_LITERAL().getText();
        NumericLiteralType nlittype = figureOutNumericLiteralType(p);
        ASTNode node = null;
        switch (littype)
        {
            case PATTERN:
                switch (nlittype)
                {
                    case INT10:
                        node = new ASTIntegerPattern(str2int(location, p, 10));
                        break;
                    case INT16:
                        node = new ASTIntegerPattern(str2int(location, p.substring(2), 16));
                        break;
                    case REAL:
                        node = new ASTRealPattern(str2real(location, p));
                        break;
                }
                break;
            case EXPRESSION:
                switch (nlittype)
                {
                    case INT10:
                        node = new ASTIntegerLiteralExpression(str2int(location, p, 10));
                        break;
                    case INT16:
                        node = new ASTIntegerLiteralExpression(str2int(location, p.substring(2), 16));
                        break;
                    case REAL:
                        node = new ASTRealLiteralExpression(str2real(location, p));
                        break;
                }
                break;
        }
        if (node == null) throw new UnsupportedOperationException("Invalid littype?");
        putNode(ctx, node);
    }

    @Override 
    public void exitCharacterLiteral(VDMParser.CharacterLiteralContext ctx)
    {
        LexLocation location = token2loc(ctx);
        if (littype == null)
            throw new UnsupportedOperationException("Invalid literal type");
        String p = ctx.CHARACTER_LITERAL().getText();
        ASTNode node = null;
        switch (littype)
        {
            case PATTERN:
                // p = 'C' (e.g. p(0/2)=', p(1)=C )
                node = new ASTCharacterPattern(new LexCharacterToken(p.charAt(1), location)); 
                break;
            case EXPRESSION:
                node = new ASTCharLiteralExpression(new LexCharacterToken(p.charAt(1), location));
                break;
        }
        putNode(ctx, node);
    }

    @Override
    public void exitStringLiteral(VDMParser.StringLiteralContext ctx)
    {
        LexLocation location = token2loc(ctx);
        if (littype == null)
            throw new UnsupportedOperationException("Invalid literal type");
        String p = ctx.TEXT_LITERAL().getText();
        ASTNode node = null;
        switch (littype)
        {
            case PATTERN:
                node = new ASTStringPattern(new LexStringToken(p, location)); 
                break;
            case EXPRESSION:
                node = new ASTStringLiteralExpression(new LexStringToken(p, location));
                break;
        }
        putNode(ctx, node);
    }

    @Override
    public void exitQuoteLiteral(VDMParser.QuoteLiteralContext ctx)
    {
        LexLocation location = token2loc(ctx);
        if (littype == null)
            throw new UnsupportedOperationException("Invalid literal type");
        String p = ctx.QUOTE_LITERAL().getText();
        ASTNode node = null;
        switch (littype)
        {
            case PATTERN:
                node = new ASTQuotePattern(new LexQuoteToken(p.substring(1, p.length()-1), location)); 
                break;
            case EXPRESSION:
                node = new ASTQuoteLiteralExpression(new LexQuoteToken(p.substring(1, p.length()-1), location));
                break;
        }
        putNode(ctx, node);
    }

    @Override 
    public void exitBooleanLiteral(VDMParser.BooleanLiteralContext ctx)
    {
        LexLocation location = token2loc(ctx);
        if (littype == null)
            throw new UnsupportedOperationException("Invalid literal type");
        ASTNode node = null;
        switch (littype)
        {
            case PATTERN:
                node = new ASTBooleanPattern(new LexBooleanToken(ctx.SLK_true() != null, location));
                break;
            case EXPRESSION:
                node = new ASTBooleanLiteralExpression(new LexBooleanToken(ctx.SLK_true() != null, location));
                break;
        }
        putNode(ctx, node);
    }

    @Override 
    public void exitNilLiteral(VDMParser.NilLiteralContext ctx)
    {
        LexLocation location = token2loc(ctx);
        if (littype == null)
            throw new UnsupportedOperationException("Invalid literal type");
        ASTNode node = null;
        switch (littype)
        {
            case PATTERN:
                node = new ASTNilPattern(new LexKeywordToken(com.fujitsu.vdmj.lex.Token.NIL, location));
                break;
            case EXPRESSION:
                node = new ASTNilExpression(location);
                break;
        }
        putNode(ctx, node);
    }

    @Override 
    public void enterSymbolicLiteralPattern(VDMParser.SymbolicLiteralPatternContext ctx)
    {
        this.littype = SymbolicLiteralType.PATTERN;
    }

    @Override 
    public void exitSymbolicLiteralPattern(VDMParser.SymbolicLiteralPatternContext ctx)
    {
        if (!SymbolicLiteralType.PATTERN.equals(littype))
            throw new UnsupportedOperationException("Expected symbolic literal pattern but found " + String.valueOf(littype));
        this.littype = null; 
        // how to know what kind of pattern came through? 
        // ctx.symbolic_literal?
        ASTPattern node = getNode(ctx.symbolic_literal(), ASTPattern.class);
        if (!(node instanceof ASTIntegerPattern || 
              node instanceof ASTRealPattern ||
              node instanceof ASTCharacterPattern ||
              node instanceof ASTStringPattern ||
              node instanceof ASTQuotePattern ||
              node instanceof ASTBooleanPattern ||
              node instanceof ASTNilPattern))
        {
            throw new UnsupportedOperationException("Unknown pattern node " + node.getClass().getSimpleName());
        }
        //TODO should such removals also be present in other sub-trees? 
        nodes.removeFrom(ctx.symbolic_literal()); 
        putNode(ctx, node);
    }    
    
    @Override 
    public void exitSetEnumPattern(VDMParser.SetEnumPatternContext ctx)
    {
        ParserRuleContext plist = ctx.pattern_list();
        ASTPatternList list;
        // empty sets have no matching pattern_list context
        if (plist == null)
            list = new ASTPatternList();
        else 
            list = getListNode(plist, ASTPatternList.class);
        putNode(ctx, new ASTSetPattern(token2loc(ctx), list));
    }

    @Override 
    public void exitSetUnionPattern(VDMParser.SetUnionPatternContext ctx)
    {
        ASTPattern p1 = getNode(ctx.pattern(0), ASTPattern.class);
        ASTPattern p2 = getNode(ctx.pattern(1), ASTPattern.class);
        putNode(ctx, new ASTMapUnionPattern(p1, token2loc(ctx.SLK_union()), p2));
    }

    @Override 
    public void exitSeqEnumPattern(VDMParser.SeqEnumPatternContext ctx)
    {
        ParserRuleContext plist = ctx.pattern_list();
        ASTPatternList list;
        // empty seqs have no matching pattern_list context
        if (plist == null)
            list = new ASTPatternList();
        else 
            list = getListNode(plist, ASTPatternList.class);
        putNode(ctx, new ASTSetPattern(token2loc(ctx), list));
    }

    @Override 
    public void exitSeqConcatPattern(VDMParser.SeqConcatPatternContext ctx)
    {
        ASTPattern lhs = getNode(/*ctx.pattern(0)*/ctx.lhs, ASTPattern.class);
        ASTPattern rhs = getNode(/*ctx.pattern(1)*/ctx.rhs, ASTPattern.class);
        putNode(ctx, new ASTMapUnionPattern(lhs, token2loc(ctx.O_CONCAT()), rhs));
    }

    @Override 
    public void exitEmptyMapPattern(VDMParser.EmptyMapPatternContext ctx)
    {
        putNode(ctx, new ASTMapPattern(token2loc(ctx), new ASTMapletPatternList()));
    }

    @Override 
    public void exitMaplet_pattern(VDMParser.Maplet_patternContext ctx)
    {
        ASTPattern from = getNode(ctx.from, ASTPattern.class);
        ASTPattern to = getNode(ctx.to, ASTPattern.class);
        putNode(ctx, new ASTMapletPattern(from, to));
    }

    @Override
    public void exitMaplet_pattern_list(VDMParser.Maplet_pattern_listContext ctx)
    {
        // empty pattern list (empty map) is non-null 
        ASTMapletPatternList result = new ASTMapletPatternList();
        for(VDMParser.Maplet_patternContext p : ctx.maplet_pattern())
        {
            result.add(getNode(p, ASTMapletPattern.class));
        }
        putListNode(ctx, result);        
    }

    @Override 
    public void exitMapEnumPattern(VDMParser.MapEnumPatternContext ctx)
    {
        putNode(ctx, new ASTMapPattern(token2loc(ctx), getListNode(ctx.maplet_pattern_list(), ASTMapletPatternList.class)));
    }

    @Override 
    public void exitMapMunionPattern(VDMParser.MapMunionPatternContext ctx)
    {
        ASTPattern lhs = getNode(ctx.lhs, ASTPattern.class);
        ASTPattern rhs = getNode(ctx.rhs, ASTPattern.class);
        putNode(ctx, new ASTMapUnionPattern(lhs, token2loc(ctx.SLK_munion()), rhs));
    }

    @Override 
    public void exitTupplePattern(VDMParser.TupplePatternContext ctx)
    {
        //ASTPattern p = getNode(ctx.pattern(), ASTPattern.class);
        //LRM: no need for "pattern , pattern_list"
        ASTPatternList list = getListNode(ctx.pattern_list(), ASTPatternList.class);
        if (list.isEmpty())
            throw new UnsupportedOperationException("Tupple must have >1 arguments");
        putNode(ctx, new ASTTuplePattern(token2loc(ctx), list));
    }

    @Override
    public void exitTight_pp_obj_name(VDMParser.Tight_pp_obj_nameContext ctx)
    {
        throw new UnsupportedOperationException("Not yet implemented!");
    }
    
    @Override
    public void exitPPObjectPattern(VDMParser.PPObjectPatternContext ctx)
    {
        //@NB needs to be implement ASTNamePatternPairList Mappable 
        ASTNamePatternPairList list = null;//(ASTNamePatternPairList)lists.get(ctx.field_pattern_list());
        LexNameToken classname = getNode(ctx.tight_pp_obj_name(), LexNameToken.class);
        putNode(ctx, new ASTObjectPattern(token2loc(ctx), classname, list));
    }

    @Override
    public void exitTight_record_name(VDMParser.Tight_record_nameContext ctx)
    {
        LexNameToken typename;
        // check on ctx.second token type instead of != null?
        // mk_A`R(...)
        if (ctx.QUALIFIED_NAME() != null)
        {
            String qualifiedName = ctx.QUALIFIED_NAME().getText();
            int backtick = qualifiedName.indexOf('`');
            assert backtick >= 0;
            String mod = qualifiedName.substring(3, backtick);
            String name = qualifiedName.substring(backtick + 1);
            typename = new LexNameToken(mod, name, token2loc(ctx));
        }
        // mk_R(...)
        else 
        {
            assert ctx.IDENTIFIER() != null; //TODO or do recognition failure?
            typename = id2lexname(id2lexid(ctx.IDENTIFIER(), ctx, false));
        }
        putNode(ctx, typename);
    }

    @Override
    public void exitRecordPattern(VDMParser.RecordPatternContext ctx)
    {
        //ASTPatternList list = (ASTPatternList)lists.get(ctx.pattern_list());
        ASTPatternList list = (ASTPatternList)getListNode(ctx.pattern_list(), ASTPatternList.class);
        LexNameToken typename = getNode(ctx.tight_record_name(), LexNameToken.class);
        putNode(ctx, new ASTRecordPattern(typename, list));
    }

    @Override
    public void exitIgnorePattern(VDMParser.IgnorePatternContext ctx)
    {
        // Interval i = ctx.getSourceInterval();
        // System.out.println(i);
        putNode(ctx, new ASTIgnorePattern(token2loc(ctx)));
    }

    @Override
    public void exitIdPattern(VDMParser.IdPatternContext ctx)
    {
        putNode(ctx, new ASTIdentifierPattern(id2lexname(id2lexid(ctx.IDENTIFIER(), ctx, false))));
    }

//------------------------
// A.8.2 Bindings
//------------------------

    @Override 
    public void exitPattern_bind(VDMParser.Pattern_bindContext ctx)
    {
        //@NB readPatternOrBind is complicated (i.e. backtracks on error? is ambigous in the grammar?)
        //@NB LRM says pattern then bind; VDMJ prioritises bind. Following that here
        if (ctx.bind() != null)
        {
            ASTBind bind = getNode(ctx.bind(), ASTBind.class);
            nodes.removeFrom(ctx.bind());
            putNode(ctx, bind);
        }
        else if (ctx.pattern() != null)
        {
            ASTPattern pattern = getNode(ctx.bind(), ASTPattern.class);
            nodes.removeFrom(ctx.pattern());
            putNode(ctx, pattern);
        }
        else 
            // recognition exception might be null? 
            throw ctx.exception != null ? ctx.exception : new UnsupportedOperationException();
    }

    @Override
    public void exitSet_bind(VDMParser.Set_bindContext ctx)
    {
        ASTPattern p = getNode(ctx.pattern(), ASTPattern.class);
        ASTExpression expr = getNode(ctx.expression(), ASTExpression.class);
        putNode(ctx, new ASTSetBind(p, expr));
    }

    @Override
    public void exitSeq_bind(VDMParser.Seq_bindContext ctx)
    {
        ASTPattern p = getNode(ctx.pattern(), ASTPattern.class);
        ASTExpression expr = getNode(ctx.expression(), ASTExpression.class);
        putNode(ctx, new ASTSeqBind(p, expr));
    }

    @Override
    public void exitType_bind(VDMParser.Type_bindContext ctx)
    {
        ASTPattern p = getNode(ctx.pattern(), ASTPattern.class);
        ASTType type= getNode(ctx.type(), ASTType.class);
        putNode(ctx, new ASTTypeBind(p, type));
    }

    @Override 
    public void exitBind_list(VDMParser.Bind_listContext ctx)
    {
        // empty bind list (empty multiple bind list) is non-null 
        ASTMultipleBindList result = new ASTMultipleBindList();
        for(VDMParser.Multiple_bindContext mb : ctx.multiple_bind())
        {
            result.add(getNode(mb, ASTMultipleBind.class));
        }
        putListNode(ctx, result);
    }

    @Override
    public void exitMultiple_set_bind(VDMParser.Multiple_set_bindContext ctx)
    {
        ASTPatternList list = getListNode(ctx.pattern_list(), ASTPatternList.class);
        ASTExpression expr = getNode(ctx.expression(), ASTExpression.class);
        putNode(ctx, new ASTMultipleSetBind(list, expr));
    }

    @Override
    public void exitMultiple_seq_bind(VDMParser.Multiple_seq_bindContext ctx)
    {
        ASTPatternList list = getListNode(ctx.pattern_list(), ASTPatternList.class);
        ASTExpression expr = getNode(ctx.expression(), ASTExpression.class);
        putNode(ctx, new ASTMultipleSeqBind(list, expr));
    }

    @Override
    public void exitMultiple_type_bind(VDMParser.Multiple_type_bindContext ctx)
    {
        ASTPatternList list = getListNode(ctx.pattern_list(), ASTPatternList.class);
        ASTType type = getNode(ctx.type(), ASTType.class);
        putNode(ctx, new ASTMultipleTypeBind(list, type));
    }

    @Override 
    public void exitType_bind_list(VDMParser.Type_bind_listContext ctx)
    {
        // empty bind list (empty type bind list) is non-null 
        ASTTypeBindList result = new ASTTypeBindList();
        for(VDMParser.Type_bindContext tb : ctx.type_bind())
        {
            result.add(getNode(tb, ASTTypeBind.class));
        }
        putListNode(ctx, result);
    }
}

