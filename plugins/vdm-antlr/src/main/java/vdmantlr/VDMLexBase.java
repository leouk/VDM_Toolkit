package vdmantlr;

import org.antlr.v4.runtime.CharStream;

public abstract class VDMLexBase extends VDMLex
{
    public VDMLexBase(CharStream input) {
    	super(input);
    }

    //@NB could this method be static public in LexTokenReader?
    //@LF or just do it directly with the explicitly named Unicode syntax categories?
    public boolean startOfName()
    {
        char c = (char)_input.LA(-1);
		if (c < 0x0100)
		{
			return Character.isLetter(c) || c == '$';
		}
		else
		{
			switch (Character.getType(c))
			{
				case Character.CONTROL:
				case Character.LINE_SEPARATOR:
				case Character.PARAGRAPH_SEPARATOR:
				case Character.SPACE_SEPARATOR:
				case Character.SURROGATE:
				case Character.UNASSIGNED:
				case Character.DECIMAL_DIGIT_NUMBER:
				case Character.CONNECTOR_PUNCTUATION:
					return false;

				default:
					return true;
			}
		}
	}

    public boolean Check2()
    {
        return Character.isJavaIdentifierStart(Character.toCodePoint((char)_input.LA(-2), (char)_input.LA(-1)));
    }

    public boolean Check3()
    {
        return Character.isJavaIdentifierPart(_input.LA(-1));
    }

    public boolean Check4()
    {
        return Character.isJavaIdentifierPart(Character.toCodePoint((char)_input.LA(-2), (char)_input.LA(-1)));
    }
}