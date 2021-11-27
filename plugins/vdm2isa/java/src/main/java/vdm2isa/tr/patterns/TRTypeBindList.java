package vdm2isa.tr.patterns;

import java.util.Arrays;

import com.fujitsu.vdmj.tc.patterns.TCTypeBind;
import com.fujitsu.vdmj.tc.patterns.TCTypeBindList;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRMappedList;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.types.TRType;
import vdm2isa.tr.types.TRTypeList;

public class TRTypeBindList extends TRMappedList<TCTypeBind, TRMultipleTypeBind> {
    
    private static final long serialVersionUID = 1L;

	protected TRTypeBindList() 
	{
		super();
	}  

	public TRTypeBindList(TRTypeBindList from)
	{
		this();
		addAll(from);
	}

	public TRTypeBindList(TCTypeBindList list) throws Exception
	{
		super(list);
	}

	@Override
	public void setup()
	{
		super.setup();
		setSemanticSeparator(" ");
		setFormattingSeparator(" ");
		setInvTranslateSeparator(getFormattingSeparator() + IsaToken.AND.toString() + getFormattingSeparator());
	}

	public TRTypeList getTypeList()
	{
		TRTypeList result = TRTypeList.newTypeList((TRType[])null);
		for(TRMultipleTypeBind t : this)
		{
			result.add((TRType)t.getRHS());	
		}
		return result;
	}

	public static String translate(TRMultipleTypeBind... args)
	{
		TRTypeBindList result = new TRTypeBindList();
		result.addAll(Arrays.asList(args));
		TRNode.setup(result);
		return result.translate();	
	}
}
