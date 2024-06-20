package uk.ac.ncl.vdm2dafny.tr.dafny.definitions;

import java.util.stream.Collectors;

import com.fujitsu.vdmj.tc.types.TCBooleanType;
import com.fujitsu.vdmj.tc.types.TCCharacterType;
import com.fujitsu.vdmj.tc.types.TCFunctionType;
import com.fujitsu.vdmj.tc.types.TCInMapType;
import com.fujitsu.vdmj.tc.types.TCIntegerType;
import com.fujitsu.vdmj.tc.types.TCMapType;
import com.fujitsu.vdmj.tc.types.TCNamedType;
import com.fujitsu.vdmj.tc.types.TCNaturalOneType;
import com.fujitsu.vdmj.tc.types.TCNaturalType;
import com.fujitsu.vdmj.tc.types.TCOptionalType;
import com.fujitsu.vdmj.tc.types.TCParameterType;
import com.fujitsu.vdmj.tc.types.TCProductType;
import com.fujitsu.vdmj.tc.types.TCQuoteType;
import com.fujitsu.vdmj.tc.types.TCRationalType;
import com.fujitsu.vdmj.tc.types.TCRealType;
import com.fujitsu.vdmj.tc.types.TCRecordType;
import com.fujitsu.vdmj.tc.types.TCSeq1Type;
import com.fujitsu.vdmj.tc.types.TCSeqType;
import com.fujitsu.vdmj.tc.types.TCSet1Type;
import com.fujitsu.vdmj.tc.types.TCSetType;
import com.fujitsu.vdmj.tc.types.TCTokenType;
import com.fujitsu.vdmj.tc.types.TCType;
import com.fujitsu.vdmj.tc.types.TCVoidType;

import uk.ac.ncl.plugins.commands.DafnyTranslateCommand;
import uk.ac.ncl.vdm2dafny.lex.DafnyToken;
import uk.ac.ncl.vdm2dafny.messages.DafnyErrorMessage;

public class DafnyTypeNames {
    private static DafnyTypeNames INSTANCE;

    private DafnyTypeNames() {}

    public static DafnyTypeNames instance() {
        if (INSTANCE == null) {
            INSTANCE = new DafnyTypeNames();
        }
        return INSTANCE;
    }

    public String getTypeName(TCType type) {
        
        switch (getTypeToken(type)){
            case NAT:   return DafnyToken.NAT.getName();
            case NAT1:  return DafnyToken.NAT1.getName();
            case CHAR:  return DafnyToken.CHAR.getName();
            case INT:   return DafnyToken.INT.getName();
            case REAL:  return DafnyToken.REAL.getName();
            case RAT:   return DafnyToken.RAT.getName();
            case BOOL:  return DafnyToken.BOOL.getName();
            case RECORD:return DafnyIdentifiers.instance().transform(((TCRecordType)type).name);
            case OPTIONAL:return getOptionalType((TCOptionalType)type);
            case ALIAS: return DafnyIdentifiers.instance().transform(((TCNamedType)type).typename);
            case SEQ :  return getSeq(type);
            case SET:   return getSet(type);
            case SEQ1:  return getSeq1(type);
            case SET1:   return getSet1(type);
            case MAP:   return getMap(type);
            case INMAP:   return getInMap(type);
            case PARAMETER_TYPE:   return getParameterisedType(type);
            case PRODUCT:   return getProductType(type);
            case VDMQUOTE: return getQuoteType(type);
            case FUN: return getFunctionType(type);
            case VOID: return "()";
            case TOKEN_TYPE: return DafnyToken.STRING.getName();
            default:    return DafnyToken.UNDEFINED.getName();
        }
    }

    private String getOptionalType(TCType type) {
        assert type instanceof TCOptionalType;
        String option = getTypeName(((TCOptionalType)type).type);
        DafnyTranslateCommand.report(DafnyErrorMessage.DAFNY_OPTIONAL_TYPE_1P, type.location, ((TCOptionalType)type).type.toString());
        return "vdm.Optional<" + option + ">";
    }
    
    private String getFunctionType(TCType type) {
        assert type instanceof TCFunctionType;
        String params = ((TCFunctionType)type).parameters.stream()
            .map(pt -> getTypeName(pt))
            .collect(Collectors.joining(", "));

        return "((" + params + ") -> " + getTypeName(((TCFunctionType)type).result) + ")";
    }

    private String getQuoteType(TCType type) {
        assert type instanceof TCQuoteType;
        return DafnyIdentifiers.instance().transform(((TCQuoteType)type).value);
    }
    private String getSet(TCType type) {
        assert type instanceof TCSetType;
        return DafnyToken.SET.render(getTypeName(((TCSetType)type).setof));
    }

    private String getSet1(TCType type) {
        assert type instanceof TCSet1Type;
        return DafnyToken.SET1.render(getTypeName(((TCSet1Type)type).setof));
    }    

    private String getSeq(TCType type) {
        assert type instanceof TCSeqType;
        return DafnyToken.SEQ.render(getTypeName(((TCSeqType)type).seqof));
    }
   
    private String getSeq1(TCType type) {
        assert type instanceof TCSeq1Type;
        return DafnyToken.SEQ1.render(getTypeName(((TCSeq1Type)type).seqof));
    }
    
    private String getMap(TCType type) {
        assert type instanceof TCMapType;
        return DafnyToken.MAP.render(
            getTypeName(((TCMapType)type).from),
            getTypeName(((TCMapType)type).to)
        );
        
    }

    private String getInMap(TCType type) {
        return DafnyToken.INMAP.render(
            getTypeName(((TCInMapType)type).from),
            getTypeName(((TCInMapType)type).to)
        );
    }    

    private String getParameterisedType(TCType type) {
        assert type instanceof TCParameterType;
        return DafnyToken.PARAMETER_TYPE.render(DafnyIdentifiers.instance().transform(((TCParameterType)type).name));
    }

    private String getProductType(TCType type) {
        assert type instanceof TCProductType;
        return "(" + ((TCProductType)type).types.stream().map(t -> getTypeName(t)).collect(Collectors.joining(", ")) + ")";
    }


    public DafnyToken getTypeToken(TCType type) {
        return  type instanceof TCNaturalType    ? DafnyToken.NAT :
                type instanceof TCNaturalOneType ? DafnyToken.NAT1 :
                type instanceof TCCharacterType  ? DafnyToken.CHAR :
                type instanceof TCIntegerType    ? DafnyToken.INT :
                type instanceof TCRealType       ? DafnyToken.REAL :
                type instanceof TCRationalType   ? DafnyToken.RAT :
                type instanceof TCBooleanType    ? DafnyToken.BOOL :
                type instanceof TCRecordType     ? DafnyToken.RECORD :
                type instanceof TCOptionalType   ? DafnyToken.OPTIONAL :
                type instanceof TCNamedType      ? DafnyToken.ALIAS :
                type instanceof TCSeqType       ? DafnyToken.SEQ :
                type instanceof TCSetType       ? DafnyToken.SET :
                type instanceof TCSeq1Type      ? DafnyToken.SEQ1 :
                type instanceof TCSet1Type      ? DafnyToken.SET1 :
                type instanceof TCMapType       ? DafnyToken.MAP :
                type instanceof TCInMapType     ? DafnyToken.INMAP :
                type instanceof TCNamedType     ? DafnyToken.ALIAS :
                type instanceof TCParameterType ? DafnyToken.PARAMETER_TYPE :
                type instanceof TCProductType   ? DafnyToken.PRODUCT :
                type instanceof TCQuoteType     ? DafnyToken.VDMQUOTE :
                type instanceof TCFunctionType  ? DafnyToken.FUN :
                type instanceof TCVoidType      ? DafnyToken.VOID :
                type instanceof TCTokenType      ? DafnyToken.TOKEN_TYPE :
                DafnyToken.UNDEFINED;
    }
}
