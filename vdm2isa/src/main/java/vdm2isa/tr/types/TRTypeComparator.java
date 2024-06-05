package vdm2isa.tr.types;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.mapper.ClassMapper;
import com.fujitsu.vdmj.mapper.Mappable;
import com.fujitsu.vdmj.tc.types.TCType;
import com.fujitsu.vdmj.tc.types.TCTypeList;
import com.fujitsu.vdmj.typechecker.TypeComparator;

import plugins.commands.IsabelleCommand;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.MappableNode;
import vdm2isa.tr.TRNode;

public class TRTypeComparator {
    
    public static final boolean compatible(TRType to, TRType from)
    {
        return TRTypeComparator.compatible(to, from, false);
    }

    public static final boolean compatible(TRType to, TRType from, boolean paramOnly)
    {
        return TypeComparator.compatible(to.getVDMType(), from.getVDMType(), paramOnly);
    }

    public static final boolean compatible(TRTypeList to, TRTypeList from)
    {
        return TypeComparator.compatible(to.getVDMTypeList(), from.getVDMTypeList());
    }

    public static final boolean isSubType(TRType to, TRType from)
    {
        return TRTypeComparator.isSubType(to, from, false);
    }

    public static final boolean isSubType(TRType to, TRType from, boolean invignore)
    {
        return TypeComparator.isSubType(to.getVDMType(), from.getVDMType(), invignore);
    }

    //TODO checkComposeTypes....?

    @SuppressWarnings("unchecked")
    private static final <FROM extends Mappable, TO extends MappableNode> TO classMap(LexLocation location, FROM from)
    {
        TO result;
        ClassMapper mapper = ClassMapper.getInstance(TRNode.MAPPINGS);
        try 
        {
            result = (TO)mapper.convert(from);
        }
        catch (Exception e)
        {
            result = null;
            IsabelleCommand.report(IsaErrorMessage.PLUGIN_MISSING_MAPPING_ERROR_3P, location, 
                from.getClass().getSimpleName(), 
                "TypeComparator",
                e.toString());
        }
        return result;
    }

    public static final TRType intersect(TRType t1, TRType t2)
    {
        TCType t = TypeComparator.intersect(t1.getVDMType(), t2.getVDMType());
        return t != null ? classMap(t1.getLocation(), t) : null;
    }

    public static final TRType narrowest(TRType t1, TRType t2)
    {
        TCType t = TypeComparator.narrowest(t1.getVDMType(), t2.getVDMType());
        return classMap(t1.getLocation(), t);
    }

    public static final TRTypeList narrowest(TRTypeList t1, TRTypeList t2)
    {
        TCTypeList tlist = TypeComparator.narrowest(t1.getVDMTypeList(), t2.getVDMTypeList());
        return classMap(t1.getLocation(), tlist);
    }

}
