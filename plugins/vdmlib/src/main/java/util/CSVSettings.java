package util;

import com.fujitsu.vdmj.runtime.Context;
import com.fujitsu.vdmj.runtime.ValueException;
import com.fujitsu.vdmj.values.SeqValue;
import com.fujitsu.vdmj.values.ValueList;

public final class CSVSettings {
    public final boolean skipBlankLines;
    public final String lineCommentStr;

    public static final CSVSettings DEFAULT = new CSVSettings(false, null);
    private static final int CSVSETTINGS_SKIPBLANKS_IDX = 0; 
    private static final int CSVSETTINGS_COMMENTSTR_IDX = 1;

    protected CSVSettings(boolean skip, String cmtStr)
    {
        this.skipBlankLines = skip;
        this.lineCommentStr = cmtStr;
    }

    public CSVSettings(ValueList settings, Context ctxt) throws ValueException
    {
        if (settings.size() < CSVSETTINGS_COMMENTSTR_IDX)
            throw new ValueException(4999, "Invalid CSV settings - too few parameters given", ctxt);
        this.skipBlankLines = settings.get(CSVSETTINGS_SKIPBLANKS_IDX).boolValue(null);
        this.lineCommentStr = ValueFactoryHelper.deref(settings.get(CSVSETTINGS_COMMENTSTR_IDX)) instanceof SeqValue ? settings.get(CSVSETTINGS_COMMENTSTR_IDX).stringValue(ctxt) : null;
    }
}
