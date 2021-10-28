package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.definitions.TRDefinitionList;

public class TRLetDefExpression extends TRVDMLocalDefinitionListExpression {

    private static final long serialVersionUID = 1L;
    private final TRDefinitionList localDefs;
    private final TRExpression expression;

    public TRLetDefExpression(LexLocation location, TRDefinitionList localDefs, TRExpression expression)
    {
        super(location);
        this.localDefs = localDefs;
        //TODO add this to IsaToken? see the reporting library 
        this.localDefs.separator = IsaToken.COMMA.toString() + this.tabs;
        this.localDefs.setLocal(true);
        this.expression = expression;
        System.out.println(toString());
    }

    @Override
    public String toString()
    {
        return "LetDef (" + localDefs.size() + ")[" + localDefs.get(0).getClass().getName() + "]\n" +
            localDefs.toString();
    }

    @Override
    public IsaToken isaToken() {
       return IsaToken.LET;
    }

    /*
    @Override
    public String translate() {
        StringBuilder sb = new StringBuilder();
        sb.append(isaToken().toString());
        sb.append(" ");
        sb.append(localDefs.translate());
        sb.append("\n\t");
        sb.append(IsaToken.IN.toString());
        sb.append("\n\t\t");
        sb.append(IsaToken.parenthesise(expression.translate()));
        return IsaToken.parenthesise(sb.toString());
    }*/

    public String translate() {
        StringBuilder sb = new StringBuilder();
        // let x: T1 = v1, y: T2 = v2 in exp(x, y)
        // =
        // (let x = v1; y = v2 in (x::VDMNat) (y::VDMNat1) in 
        //      exp(x, y)
        // )
        sb.append("\n\t");
        sb.append(isaToken().toString());
        sb.append(" ");
        sb.append(localDefs.translate());
        sb.append("\n\t");
        sb.append(IsaToken.IN.toString());
        sb.append("\n\t\t");
        sb.append(IsaToken.LPAREN.toString());
        sb.append(IsaToken.IF.toString());
        sb.append(" ");
        sb.append(localDefs.invTranslate());
        sb.append(" ");
        sb.append(IsaToken.THEN.toString());
        sb.append("\n\t\t\t");
        sb.append(expression.translate());        
        sb.append("\n\t\t ");
        sb.append(IsaToken.ELSE.toString());
        sb.append("\n\t\t\t");
        sb.append(IsaToken.UNDEFINED.toString());
        sb.append("\n\t\t"); 
        sb.append(IsaToken.RPAREN.toString());
        sb.append("\n\t");
        return IsaToken.parenthesise(sb.toString());
    }
}
