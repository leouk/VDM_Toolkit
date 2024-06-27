package uk.ac.ncl.vdm2dafny.tr.dafny.definitions;

import java.util.Optional;

import com.fujitsu.vdmj.ast.lex.LexNameToken;
import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.tc.types.TCType;

import uk.ac.ncl.plugins.commands.DafnyTranslateCommand;
import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;
import uk.ac.ncl.vdm2dafny.messages.DafnyWarningMessage;
import uk.ac.ncl.vdm2dafny.tr.dafny.env.DafnyEnvironment;

public abstract class DafnyAbstractType extends DafnyTypeDefinition {
    private TCNameToken name;
    private TCType type;
    private Optional<DafnyDefinition> invariant;
    private Optional<DafnyDefinition> ord;
    private Optional<DafnyDefinition> eq;

    public DafnyAbstractType(TCType type, String name, DafnyDefinition inv, DafnyDefinition ord, DafnyDefinition eq) {
        this.type = type;
        this.name       = new TCNameToken(new LexNameToken(DafnyEnvironment.instance().getModule(), name, LexLocation.ANY));
        this.invariant  = inv != null ? Optional.of(inv) : Optional.empty();
        this.ord        = ord != null ? Optional.of(ord) : Optional.empty();
        this.eq         = eq  != null ? Optional.of(eq) : Optional.empty();
    }

    public TCType getVDM() {
        return type;
    }


    @Override
    public boolean hasInv() {
        return invariant.isPresent();
    }

    @Override
    public boolean hasOrd() {
        return ord.isPresent();
    }

    @Override
    public boolean hasEq() {
        return eq.isPresent();
    }

    @Override
    public String getName() {
        return DafnyIdentifiers.instance().transform(name);
    }

    @Override
    public String getVar() {
        return "var" + getName();
    }

    @Override
    public String getImplName() {
        return "Impl" + getName() + "'";
    }

    @Override
    public String getInvBody() {
        if (hasInv())
            return invariant.get().translate();
        
        return "";
    }

    @Override
    public String getOrdBody() {
        if (hasOrd())
            return ord.get().translate();
        
        return "";
    }

    @Override
    public String getMaxBody() {
        assert hasOrd();
        return DafnyTemplates.TYPES.render("defaultMax", Pair.of("type", getImplName()));
    }

    @Override
    public String getMinBody() {        
        assert hasOrd();
        return DafnyTemplates.TYPES.render("defaultMin", Pair.of("type", getImplName()));
    }

    @Override
    public String getEqBody() {
        if (hasEq())
            return eq.get().translate();
        
        return "";
    }

    @Override
    public boolean hasMax() {
        return hasOrd();
    }

    @Override
    public boolean hasMin() {
        return hasOrd();
    }

    protected void findPossibleProblems() {
        if (hasInv()) {
            DafnyTranslateCommand.warning(DafnyWarningMessage.DAFNY_NEEDS_WITNESS_1P, getVDM().location, getName());
        }
    }
}
