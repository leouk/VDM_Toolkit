package vdmantlr;

import org.antlr.v4.runtime.tree.ParseTreeProperty;

import com.fujitsu.vdmj.ast.ASTNode;
import com.fujitsu.vdmj.ast.modules.ASTModuleList;

import vdmantlr.generated.VDMBaseListener;
import vdmantlr.generated.VDMParser;

public class VDMASTListener extends VDMBaseListener {
    
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
    public void enterModule(VDMParser.ModuleContext ctx)
    {
        ctx.IDENTIFIER();
        nodes.put(ctx, null);
    }
}
