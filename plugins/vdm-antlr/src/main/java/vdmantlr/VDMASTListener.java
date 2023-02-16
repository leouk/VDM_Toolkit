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
        CharStream input = CharStreams.fromFileName("./exprScenario/setEnum.expr"); 
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
}

