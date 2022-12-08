package plugins;

import java.util.List;

import com.fujitsu.vdmj.in.modules.INModule;
import com.fujitsu.vdmj.in.modules.INModuleList;
import com.fujitsu.vdmj.mapper.ClassMapper;
import com.fujitsu.vdmj.runtime.ModuleInterpreter;
import com.fujitsu.vdmj.tc.types.TCType;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.types.TRType;

import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.tc.modules.TCModule;
import com.fujitsu.vdmj.tc.modules.TCModuleList;

/**
 * Need to create an artificial interpreter to gain access to parseExpression.
 */
public class IsaInterpreter extends ModuleInterpreter {
    
    @SuppressWarnings("unchecked")
    private static <T extends List<?>> T filterCheckedModules(T checkedModules)
    {
        assert checkedModules instanceof TCModuleList;
        TCModuleList result = new TCModuleList();
        for(TCModule m : (TCModuleList)checkedModules)
        {
            if (m.name.getName().equals(IsaToken.VDMTOOLKIT.toString())) continue;
            result.add(m);
        }
        return (T)result;
    }

    @SuppressWarnings("unchecked")
    private static <T extends List<?>> T filterExecutableModules(T executableModules)
    {
        assert executableModules instanceof INModuleList;
        INModuleList result = new INModuleList();
        for(INModule m : (INModuleList)executableModules)
        {
            if (m.name.getName().equals(IsaToken.VDMTOOLKIT.toString())) continue;
            result.add(m);
        }
        return (T)result;
    }

    public IsaInterpreter(ModuleInterpreter interpreter) throws Exception
    {
        super(filterExecutableModules(interpreter.getModules()), filterCheckedModules(interpreter.getTC()));
    }

    /**
     * Given a VDM input string within a given module (i.e. to pick up the right context),
     * parses and type checks the expression returning its TC AST pair.  
     * @param vdmInput
     * @param module
     * @return
     * @throws Exception
     */
    @Deprecated
    public Pair<TCExpression, TCType> typeCheck(String vdmInput, String module) throws Exception
    {
        // avoid RESULT as a name because type checker doesn't like / allow them. 
        //TODO properly handle this! 
        TCExpression expr = this.parseExpression(vdmInput.replaceAll("RESULT", "result"), module);
        TCType type = this.typeCheck(expr);
        return new Pair<TCExpression, TCType>(expr, type);
    }

    /**
     * Given a typechecked TC pair, returns its corresponding Isabelle translation TR pair
     * @param tcexpr
     * @return
     * @throws Exception
     */
    @Deprecated
    public Pair<TRExpression, TRType> map2isa(Pair<TCExpression, TCType> tcexpr) throws Exception
    {
        TRExpression expr = ClassMapper.getInstance(TRNode.MAPPINGS).init().convert(tcexpr.key);
        TRType type = ClassMapper.getInstance(TRNode.MAPPINGS).init().convert(tcexpr.value);
        return new Pair<TRExpression, TRType>(expr, type);
    }

    public TRExpression map2isa(TCExpression tcexpr) throws Exception
    {
        return ClassMapper.getInstance(TRNode.MAPPINGS).init().convert(tcexpr);
    }

    // @Override
    // public ProofObligationList getProofObligations() throws Exception
    // {
    //     ProofObligationList result; 

    //     return result;
    // }
}
