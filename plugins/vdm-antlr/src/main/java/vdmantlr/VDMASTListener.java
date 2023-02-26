package vdmantlr;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Vector;

import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonToken;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.ParserRuleContext;
import org.antlr.v4.runtime.misc.Interval;
import org.antlr.v4.runtime.tree.ParseTree;
import org.antlr.v4.runtime.tree.ParseTreeProperty;
import org.antlr.v4.runtime.tree.ParseTreeWalker;
import org.antlr.v4.runtime.tree.TerminalNode;

import com.fujitsu.vdmj.ast.ASTNode;
import com.fujitsu.vdmj.ast.lex.LexBooleanToken;
import com.fujitsu.vdmj.ast.lex.LexCharacterToken;
import com.fujitsu.vdmj.ast.lex.LexIdentifierToken;
import com.fujitsu.vdmj.ast.lex.LexIntegerToken;
import com.fujitsu.vdmj.ast.lex.LexKeywordToken;
import com.fujitsu.vdmj.ast.lex.LexCharacterToken;
import com.fujitsu.vdmj.ast.lex.LexNameToken;
import com.fujitsu.vdmj.ast.lex.LexQuoteToken;
import com.fujitsu.vdmj.ast.lex.LexRealToken;
import com.fujitsu.vdmj.ast.lex.LexStringToken;
import com.fujitsu.vdmj.ast.lex.LexToken;
import com.fujitsu.vdmj.ast.modules.ASTModuleList;
import com.fujitsu.vdmj.ast.patterns.ASTBooleanPattern;
import com.fujitsu.vdmj.ast.patterns.ASTCharacterPattern;
import com.fujitsu.vdmj.ast.patterns.ASTConcatenationPattern;
import com.fujitsu.vdmj.ast.patterns.ASTIdentifierPattern;
import com.fujitsu.vdmj.ast.patterns.ASTIgnorePattern;
import com.fujitsu.vdmj.ast.patterns.ASTIntegerPattern;
import com.fujitsu.vdmj.ast.patterns.ASTMapPattern;
import com.fujitsu.vdmj.ast.patterns.ASTMapUnionPattern;
import com.fujitsu.vdmj.ast.patterns.ASTMapletPatternList;
import com.fujitsu.vdmj.ast.patterns.ASTNamePatternPairList;
import com.fujitsu.vdmj.ast.patterns.ASTNilPattern;
import com.fujitsu.vdmj.ast.patterns.ASTObjectPattern;
import com.fujitsu.vdmj.ast.patterns.ASTPattern;
import com.fujitsu.vdmj.ast.patterns.ASTPatternList;
import com.fujitsu.vdmj.ast.patterns.ASTQuotePattern;
import com.fujitsu.vdmj.ast.patterns.ASTRealPattern;
import com.fujitsu.vdmj.ast.patterns.ASTRecordPattern;
import com.fujitsu.vdmj.ast.patterns.ASTSeqPattern;
import com.fujitsu.vdmj.ast.patterns.ASTSetPattern;
import com.fujitsu.vdmj.ast.patterns.ASTStringPattern;
import com.fujitsu.vdmj.ast.patterns.ASTTuplePattern;
import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.mapper.Mappable;
import com.fujitsu.vdmj.mapper.MappedObject;

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
        System.out.println("n="+t.toStringTree());
    }

    public static enum SymbolicLiteralType { PATTERN, EXPRESSION }
    
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
        nodes = new ParseTreeProperty<ASTNode>();
        lists = new ParseTreeProperty<Vector<? extends ASTNode>>();
        astModuleList = null;
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
            ctx.getStop().getLine(), ctx.getStop().getCharPositionInLine());
    }

    protected LexLocation token2loc(TerminalNode terminal)
    {
        int line = terminal.getSymbol().getLine();
        Interval i = terminal.getSourceInterval();
        return new LexLocation(currentFile, currentModule, line, i.a, line, i.b);
        // return new LexLocation(currentFile, currentModule, terminal.getSymbol().getLine(), terminal.getSymbol().getCharPositionInLine(), )
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
            throw new UnsupportedOperationException();
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

    @SuppressWarnings("unchecked")
    protected <T extends ASTNode> T getNode(ParserRuleContext ctx, Class<T> cls)
    {
        ASTNode result = nodes.get(ctx);
        if (result == null)
            throw new UnsupportedOperationException("No node for " + ctx.getClass().getSimpleName());
        if (!cls.isAssignableFrom(result.getClass()))
            throw new UnsupportedOperationException();
        return (T)result;
    }

    @SuppressWarnings("unchecked")
    protected <T extends Vector<? extends ASTNode>> T getListNode(ParserRuleContext ctx, Class<T> cls)
    {
        Vector<? extends ASTNode> result = lists.get(ctx);
        if (!cls.isAssignableFrom(result.getClass()))
            throw new UnsupportedOperationException();
        return (T)result;
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
        nodes.put(ctx, null);
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
        System.out.println("Enter #SymbolicLitExpr: " + ctx.getText());
    }

    @Override
    public void exitSymbolicLitExpr(VDMParser.SymbolicLitExprContext ctx)
    {
        System.out.println("Exit #SymbolicLitExpr: " + ctx.getText());
    }

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
        lists.put(ctx, result);
    }

    @Override 
    public void exitNumericLiteral(VDMParser.NumericLiteralContext ctx)
    {
        LexLocation location = token2loc(ctx);
        if (littype == null)
            throw new UnsupportedOperationException();
        //TODO these to me sounds like lexing rules that could have more info? 
        switch (littype)
        {
            case PATTERN:
                ASTPattern pattern; 
                String p = ctx.NUMERIC_LITERAL().getText();
                // if a hex decimal
                if (p.startsWith("0x") || p.startsWith("0X"))
                {
                    pattern = new ASTIntegerPattern(str2int(location, p.substring(2), 16));
                }
                // if proper real
                else if (p.indexOf(".") != -1 || 
                         p.indexOf("e") != -1 ||
                         p.indexOf("E") != -1)
                {
                    pattern = new ASTRealPattern(str2real(location, p));
                }
                else
                {   
                    pattern = new ASTIntegerPattern(str2int(location, p, 10));
                }
                nodes.put(ctx, pattern);
                break;
            case EXPRESSION:
                break;
        }
    }

    @Override 
    public void exitCharacterLiteral(VDMParser.CharacterLiteralContext ctx)
    {
        LexLocation location = token2loc(ctx);
        if (littype == null)
            throw new UnsupportedOperationException();
        //TODO these to me sounds like lexing rules that could have more info? 
        switch (littype)
        {
            case PATTERN:
                String p = ctx.CHARACTER_LITERAL().getText();
                // p = 'C' (e.g. p(0/2)=', p(1)=C )
                ASTPattern pattern = new ASTCharacterPattern(new LexCharacterToken(p.charAt(1), location)); 
                nodes.put(ctx, pattern);
                break;
            case EXPRESSION:
                break;
        }
    }

    @Override
    public void exitStringLiteral(VDMParser.StringLiteralContext ctx)
    {
        LexLocation location = token2loc(ctx);
        if (littype == null)
            throw new UnsupportedOperationException();
        //TODO these to me sounds like lexing rules that could have more info? 
        switch (littype)
        {
            case PATTERN:
                String p = ctx.TEXT_LITERAL().getText();
                ASTPattern pattern = new ASTStringPattern(new LexStringToken(p, location)); 
                nodes.put(ctx, pattern);
                break;
            case EXPRESSION:
                break;
        }        
    }

    @Override
    public void exitQuoteLiteral(VDMParser.QuoteLiteralContext ctx)
    {
        LexLocation location = token2loc(ctx);
        if (littype == null)
            throw new UnsupportedOperationException();
        //TODO these to me sounds like lexing rules that could have more info? 
        switch (littype)
        {
            case PATTERN:
                String p = ctx.QUOTE_LITERAL().getText();
                ASTPattern pattern = new ASTQuotePattern(new LexQuoteToken(p.substring(1, p.length()-1), location)); 
                nodes.put(ctx, pattern);
                break;
            case EXPRESSION:
                break;
        }        
    }

    @Override 
    public void exitBooleanLiteral(VDMParser.BooleanLiteralContext ctx)
    {
        LexLocation location = token2loc(ctx);
        if (littype == null)
            throw new UnsupportedOperationException();
        //TODO these to me sounds like lexing rules that could have more info? 
        switch (littype)
        {
            case PATTERN:
                ASTPattern pattern = new ASTBooleanPattern(new LexBooleanToken(ctx.SLK_true() != null, location)); 
                nodes.put(ctx, pattern);
                break;
            case EXPRESSION:
                break;
        }
    }

    @Override 
    public void exitNilLiteral(VDMParser.NilLiteralContext ctx)
    {
        LexLocation location = token2loc(ctx);
        if (littype == null)
            throw new UnsupportedOperationException();
        //TODO these to me sounds like lexing rules that could have more info? 
        switch (littype)
        {
            case PATTERN:
                ASTPattern pattern = new ASTNilPattern(new LexKeywordToken(com.fujitsu.vdmj.lex.Token.NIL, location)); 
                nodes.put(ctx, pattern);
                break;
            case EXPRESSION:
                break;
        }
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
            throw new UnsupportedOperationException();
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
        nodes.removeFrom(ctx.symbolic_literal()); 
        nodes.put(ctx, node);
        //TODO should such removals also be present in other sub-trees? 
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
        nodes.put(ctx, new ASTSetPattern(token2loc(ctx), list));
    }

    @Override 
    public void exitSetUnionPattern(VDMParser.SetUnionPatternContext ctx)
    {
        ASTPattern p1 = getNode(ctx.pattern(0), ASTPattern.class);
        ASTPattern p2 = getNode(ctx.pattern(1), ASTPattern.class);
        nodes.put(ctx, new ASTMapUnionPattern(p1, token2loc(ctx.SLK_union()), p2));
    }

    @Override 
    public void exitSeqEnumPattern(VDMParser.SeqEnumPatternContext ctx)
    {
        ParserRuleContext plist = ctx.pattern_list();
        ASTPatternList list;
        // empty sets have no matching pattern_list context
        if (plist == null)
            list = new ASTPatternList();
        else 
            list = getListNode(plist, ASTPatternList.class);
        nodes.put(ctx, new ASTSetPattern(token2loc(ctx), list));
    }

    @Override 
    public void exitSeqConcatPattern(VDMParser.SeqConcatPatternContext ctx)
    {
        ASTPattern p1 = getNode(ctx.pattern(0), ASTPattern.class);
        ASTPattern p2 = getNode(ctx.pattern(1), ASTPattern.class);
        nodes.put(ctx, new ASTMapUnionPattern(p1, token2loc(ctx.O_CONCAT()), p2));
    }

    @Override 
    public void exitEmptyMapPattern(VDMParser.EmptyMapPatternContext ctx)
    {
        nodes.put(ctx, new ASTMapPattern(token2loc(ctx), new ASTMapletPatternList()));
    }

    @Override 
    public void exitMapEnumPattern(VDMParser.MapEnumPatternContext ctx)
    {
        nodes.put(ctx, new ASTMapPattern(token2loc(ctx), getListNode(ctx.maplet_pattern_list(), ASTMapletPatternList.class)));
    }

    @Override 
    public void exitMapMunionPattern(VDMParser.MapMunionPatternContext ctx)
    {
        ASTPattern p1 = getNode(ctx.pattern(0), ASTPattern.class);
        ASTPattern p2 = getNode(ctx.pattern(1), ASTPattern.class);
        nodes.put(ctx, new ASTMapUnionPattern(p1, token2loc(ctx.SLK_munion()), p2));
    }

    @Override 
    public void exitTupplePattern(VDMParser.TupplePatternContext ctx)
    {
        //ASTPattern p = getNode(ctx.pattern(), ASTPattern.class);
        //LRM: no need for "pattern , pattern_list"
        ASTPatternList list = getListNode(ctx.pattern_list(), ASTPatternList.class);
        if (list == null || list.isEmpty())
            throw new UnsupportedOperationException("invalid tuple");
        nodes.put(ctx, new ASTTuplePattern(token2loc(ctx), list));
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
        nodes.put(ctx, new ASTObjectPattern(token2loc(ctx), classname, list));
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
        nodes.put(ctx, typename);
    }

    @Override
    public void exitRecordPattern(VDMParser.RecordPatternContext ctx)
    {
        //ASTPatternList list = (ASTPatternList)lists.get(ctx.pattern_list());
        ASTPatternList list = (ASTPatternList)getListNode(ctx.pattern_list(), ASTPatternList.class);
        LexNameToken typename = getNode(ctx.tight_record_name(), LexNameToken.class);
        nodes.put(ctx, new ASTRecordPattern(typename, list));
    }

    @Override
    public void exitIgnorePattern(VDMParser.IgnorePatternContext ctx)
    {
        // Interval i = ctx.getSourceInterval();
        // System.out.println(i);
        nodes.put(ctx, new ASTIgnorePattern(token2loc(ctx)));
    }

    @Override
    public void exitIdPattern(VDMParser.IdPatternContext ctx)
    {
        nodes.put(ctx, new ASTIdentifierPattern(id2lexname(id2lexid(ctx.IDENTIFIER(), ctx, false))));
    }
}

