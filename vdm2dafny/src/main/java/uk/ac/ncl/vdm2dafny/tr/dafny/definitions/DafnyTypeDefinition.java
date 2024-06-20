package uk.ac.ncl.vdm2dafny.tr.dafny.definitions;

import java.util.List;

import com.fujitsu.vdmj.tc.definitions.TCDefinition;
import com.fujitsu.vdmj.tc.definitions.TCTypeDefinition;
import com.fujitsu.vdmj.tc.types.TCBooleanType;
import com.fujitsu.vdmj.tc.types.TCCharacterType;
import com.fujitsu.vdmj.tc.types.TCInMapType;
import com.fujitsu.vdmj.tc.types.TCIntegerType;
import com.fujitsu.vdmj.tc.types.TCMapType;
import com.fujitsu.vdmj.tc.types.TCNamedType;
import com.fujitsu.vdmj.tc.types.TCNaturalOneType;
import com.fujitsu.vdmj.tc.types.TCNaturalType;
import com.fujitsu.vdmj.tc.types.TCRationalType;
import com.fujitsu.vdmj.tc.types.TCRealType;
import com.fujitsu.vdmj.tc.types.TCRecordType;
import com.fujitsu.vdmj.tc.types.TCSeq1Type;
import com.fujitsu.vdmj.tc.types.TCSeqType;
import com.fujitsu.vdmj.tc.types.TCSet1Type;
import com.fujitsu.vdmj.tc.types.TCSetType;
import com.fujitsu.vdmj.tc.types.TCType;
import com.fujitsu.vdmj.tc.types.TCUnionType;

import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;
import uk.ac.ncl.vdm2dafny.tr.dafny.AbstractDafnyNode;

public abstract class DafnyTypeDefinition extends AbstractDafnyNode {
    // Implicit command declarations
    public abstract boolean hasInv();
    public abstract boolean hasOrd();
    public abstract boolean hasMax();
    public abstract boolean hasMin();
    public abstract boolean hasEq();

    // Required information
    public abstract String getName();
    public abstract String getVar();
    public abstract String getImplName();
    
    // Invariants
    public abstract String getInvBody();
    public abstract String getOrdBody();
    public abstract String getMaxBody();
    public abstract String getMinBody();
    public abstract String getEqBody();
    
    // Get values
    public abstract DafnyDefinition getInv();
    public abstract DafnyDefinition getOrd();
    public abstract DafnyDefinition getEq();


    public String getInvCall() {
        return DafnyTemplates.EXPRESSIONS.render("call", Pair.of("function", "inv_" + getName()), Pair.of("params", List.of(getVar())));
    }

    public boolean hasImplicitFunctions() {
        return hasInv() || hasOrd() || hasMax() || hasMin() || hasEq();
    }

    public static DafnyTypeDefinition parseType(TCDefinition def) {
        assert def.isTypeDefinition();

        TCTypeDefinition tdef = (TCTypeDefinition)def;
        if (tdef.type.isUnion(tdef.location)) {
            // return null;
            TCNamedType namedType = (TCNamedType)tdef.type;
            if (namedType.type instanceof TCUnionType) {
                return DafnyUnion.of((TCNamedType)tdef.type);
            }
        }
        else if (tdef.type instanceof TCRecordType) {
            return DafnyRecord.of((TCRecordType)tdef.type);
        }
        // else if tdef.type.isProduct(tdef.location) {
        //     return TRProduct.of((TCProductType)tdef.type);
        // }
        else if (tdef.type instanceof TCNamedType && ((TCNamedType)tdef.type).type instanceof TCRecordType && ((TCRecordType)((TCNamedType)tdef.type).type).composed) {
            // This is a composed type!
            return DafnyComposition.of((TCNamedType)tdef.type);
        }
        // Any alias is handled here, this includes product types.
        return DafnyAlias.of((TCNamedType)tdef.type);
        
    }

    public static final boolean isLiteral(TCType type) {
        return  type instanceof TCBooleanType
            ||  type instanceof TCCharacterType
            ||  type instanceof TCIntegerType
            ||  type instanceof TCNaturalType
            ||  type instanceof TCNaturalOneType
            ||  type instanceof TCRealType
            ||  type instanceof TCRationalType;
    }
    
    public static final boolean isCollection(TCType type) {
        return  type instanceof TCSet1Type
            ||  type instanceof TCSetType
            ||  type instanceof TCSeq1Type
            ||  type instanceof TCSeqType
            ||  type instanceof TCMapType
            ||  type instanceof TCInMapType;
    }
}
