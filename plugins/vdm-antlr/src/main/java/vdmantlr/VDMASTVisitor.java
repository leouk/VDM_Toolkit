package vdmantlr;

import java.io.IOException;

import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTree;
import org.antlr.v4.runtime.tree.ParseTreeWalker;
import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CharStreams;

import com.fujitsu.vdmj.ast.ASTNode;

import vdmantlr.generated.VDMBaseVisitor;
import vdmantlr.generated.VDMLexer;
import vdmantlr.generated.VDMParser;

public class VDMASTVisitor extends VDMBaseVisitor<ASTNode> {
    
    public static final String EXPR_TEST = "./exprScenario/setEnum.expr";
    public static final String PAT_TEST = "./patternScenario/example.pat";
    public static final String TEST = PAT_TEST;

    /**
     * @param argv
     * @throws IOException
     */
    public static void main(String[] argv) throws IOException
    {
        CharStream input = CharStreams.fromFileName(TEST); 
        //ANTLRInputStream input = new ANTLRInputStream(System.in); 
        // or read stdin SimpleLexer lexer = new SimpleLexer(input);
        VDMLexer lexer = new VDMLexer(input);
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        VDMParser parser = new VDMParser(tokens);
        ParseTree t = parser.pattern();//parser.expression();
        //ParseTreeWalker.DEFAULT.walk(new VDMASTListener(), t);
        VDMBaseVisitor<ASTNode> v = new VDMBaseVisitor<ASTNode>();
        ASTNode n = v.visit(t);
        System.out.println("n="+n.toString());
    }

    @Override 
    public ASTNode visitPattern_identifier(VDMParser.Pattern_identifierContext ctx) 
    { 
        ctx.IDENTIFIER()
        return visitChildren(ctx); 
    }

    
}
