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
import org.antlr.v4.runtime.tree.ParseTree;
import org.antlr.v4.runtime.tree.ParseTreeProperty;
import org.antlr.v4.runtime.tree.ParseTreeWalker;

import com.fujitsu.vdmj.ast.ASTNode;
import com.fujitsu.vdmj.ast.lex.LexIdentifierToken;
import com.fujitsu.vdmj.ast.lex.LexNameToken;
import com.fujitsu.vdmj.ast.modules.ASTModuleList;
import com.fujitsu.vdmj.ast.patterns.ASTIdentifierPattern;
import com.fujitsu.vdmj.ast.patterns.ASTPattern;
import com.fujitsu.vdmj.ast.patterns.ASTPatternList;
import com.fujitsu.vdmj.ast.patterns.ASTSetPattern;
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
        ParseTree t = listener.parser.pattern();//parser.expression();
        ParseTreeWalker.DEFAULT.walk(listener, t);
        System.out.println("n="+t.toStringTree());
    }
    
    //See ANTLR4 discussion on options Chapter 7. Choosing listeners with parse tree properties (i.e. to avoid visitor aggregation?)
    private final ParseTreeProperty<ASTNode> nodes;
    private final ParseTreeProperty<Vector<? extends ASTNode>> lists;
    private final VDMParser parser;
    protected ASTModuleList astModuleList;
    private final File currentFile;
    private String currentModule;

    public VDMASTListener(String fileName) throws IOException
    {
        super();
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
    protected LexLocation token2loc(ParserRuleContext ctx)
    {
        return new LexLocation(currentFile, currentModule, 
            ctx.getStart().getLine(), ctx.getStart().getCharPositionInLine(),
            ctx.getStop().getLine(), ctx.getStop().getCharPositionInLine());
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
    protected LexNameToken idToName(LexIdentifierToken id)
	{
		LexNameToken name = new LexNameToken(currentModule, id);
		return name;
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
        ASTPatternList result = new ASTPatternList();
        for(VDMParser.PatternContext c : ctx.pattern())
        {
            ASTNode n = nodes.get(c);
            if (n != null && n instanceof ASTPattern)
                result.add((ASTPattern)n);
            else 
                System.out.println("Invalid pattern " + String.valueOf(n));
        }
        //TODO has to be Mappable? Instead of ASTNode?!
        //nodes.put(ctx, result);
        lists.put(ctx, result);
    }
    
    @Override 
    public void exitSetEnumPattern(VDMParser.SetEnumPatternContext ctx)
    {
        ASTPatternList list = (ASTPatternList)lists.get(ctx.pattern_list());
        ASTSetPattern result = new ASTSetPattern(token2loc(ctx), list);
        nodes.put(ctx, result);
    }

    @Override
    public void enterIdPattern(VDMParser.IdPatternContext ctx)
    {
        LexIdentifierToken id = new LexIdentifierToken(ctx.IDENTIFIER().getText(), false, token2loc(ctx));
        nodes.put(ctx, new ASTIdentifierPattern(idToName(id)));
    }
}

