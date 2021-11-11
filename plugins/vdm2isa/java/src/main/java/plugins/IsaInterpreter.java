package plugins;

import com.fujitsu.vdmj.mapper.ClassMapper;
import com.fujitsu.vdmj.pog.ProofObligation;
import com.fujitsu.vdmj.runtime.ModuleInterpreter;
import com.fujitsu.vdmj.tc.types.TCType;

import vdm2isa.tr.TRNode;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.types.TRType;

import com.fujitsu.vdmj.tc.expressions.TCExpression;

/**
 * Need to create an artificial interpreter to gain access to parseExpression.
 */
public class IsaInterpreter extends ModuleInterpreter {
    
    public IsaInterpreter(ModuleInterpreter interpreter) throws Exception
    {
        //interpreter.getIN()?
        super(interpreter.getModules(), interpreter.getTC());
    }

    /**
     * Given a VDM input string within a given module (i.e. to pick up the right context),
     * parses and type checks the expression returning its TC AST pair.  
     * @param vdmInput
     * @param module
     * @return
     * @throws Exception
     */
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
}
