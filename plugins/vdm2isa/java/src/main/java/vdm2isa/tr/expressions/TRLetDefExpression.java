package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.definitions.TRDefinitionList;

public class TRLetDefExpression extends TRExpression {

    private static final long serialVersionUID = 1L;
    private final TRDefinitionList localDefs;
    private final TRExpression expression;

    public TRLetDefExpression(LexLocation location, TRDefinitionList localDefs, TRExpression expression)
    {
        super(location);
        this.localDefs = localDefs;
        System.out.println("LetDef expression with " + localDefs.size() + " = " + localDefs.get(0).getClass().getName());
        this.localDefs.separator = IsaToken.COMMA.toString() + "\n\t\t";
        this.expression = expression;
    }

    @Override
    public IsaToken isaToken() {
       return IsaToken.LET;
    }

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
    }

}
