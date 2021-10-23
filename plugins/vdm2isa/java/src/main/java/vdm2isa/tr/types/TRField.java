package vdm2isa.tr.types;

import com.fujitsu.vdmj.tc.lex.TCNameToken;

import vdm2isa.lex.IsaToken;

public class TRField extends TRType {
    
    protected final TCNameToken tagname;
    protected final TRType type;
    protected final boolean equalityAbstraction; 
    
    public TRField(TCNameToken tagname, TRType type, boolean equalityAbstraction)
    {
        super(tagname.getLocation());
        this.tagname = tagname;
        this.type = type;
        this.equalityAbstraction = equalityAbstraction;
    }

    @Override
    public String invTranslate(String varName) {
        String fieldName = varName == null ? varName : 
            IsaToken.parenthesise(tagname.toString() + " " + varName);
        return IsaToken.parenthesise(type.invTranslate(fieldName));
     }

    @Override
    public IsaToken isaToken() {
        return IsaToken.EOF;
    }

    @Override
    public String translate() {
        return this.tagname.toString() + " " + IsaToken.TYPEOF.toString() + " " + 
            "\"" + this.type.translate() + "\"";
    }

    public TCNameToken getTagName() 
    {
        return this.tagname;
    }

    public boolean equalityAbstraction()
    {
        return this.equalityAbstraction;
    }
}
