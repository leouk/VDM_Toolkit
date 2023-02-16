package vdmantlr;

import java.io.IOException;

import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTree;
import org.antlr.v4.runtime.tree.ParseTreeProperty;
import org.antlr.v4.runtime.tree.ParseTreeWalker;

import com.fujitsu.vdmj.ast.ASTNode;
import com.fujitsu.vdmj.ast.modules.ASTModuleList;

import vdmantlr.generated.VDMBaseListener;
//import vdmantlr.generated.VDMLex; which one?
import vdmantlr.generated.VDMLexer;
import vdmantlr.generated.VDMParser;

public class VDMASTListener extends VDMBaseListener {
    
    public static void main(String[] argv) throws IOException
    {
        CharStream input = CharStreams.fromFileName("/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm-antlr/src/test/resources/exprScenario/setEnum.expr"); 
        //ANTLRInputStream input = new ANTLRInputStream(System.in); 
        // or read stdin SimpleLexer lexer = new SimpleLexer(input);
        VDMLexer lexer = new VDMLexer(input);
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        VDMParser parser = new VDMParser(tokens);
        ParseTree t = parser.expression();
        ParseTreeWalker.DEFAULT.walk(new VDMASTListener(), t);
    }

    private final ParseTreeProperty<ASTNode> nodes = new ParseTreeProperty<ASTNode>();
    
	protected ASTModuleList astModuleList = null;

    //ASTModule
	@Override 
    public void enterSl_document(VDMParser.Sl_documentContext ctx) 
    {
        astModuleList = new ASTModuleList();
        ctx.getChildCount();
        ctx.module(0);
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
}
