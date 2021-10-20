package vdm2isa.tr.types;

import com.fujitsu.vdmj.tc.lex.TCNameToken;

import vdm2isa.lex.IsaToken;

public class TRRecordType extends TRInvariantType
{
	private static final long serialVersionUID = 1L;

    private final TCNameToken name;
    private final TRFieldList fields;
    private final boolean composed; 

    public TRRecordType(TCNameToken name, TRFieldList fields, boolean composed)
    {
        super(name.getLocation());
        this.name = name;
        //@todo collect field's abstraction to see how to compare equals
        this.fields = fields;
        this.composed = composed;
    }

    @Override
    public String invTranslate(String varName) {
        StringBuilder sb = new StringBuilder();
        sb.append(IsaToken.LPAREN.toString());
        //sb.append(IsaToken.INV.toString());
        //sb.append(name.toString());
        sb.append(fields.invTranslate(varName));
        sb.append(IsaToken.RPAREN.toString());
        return sb.toString();
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.RECORD;
    }

    @Override
    public String translate() {
        return isaToken().toString() + " " + name.toString() + " = \n" +
            fields.translate(); 
    }
}