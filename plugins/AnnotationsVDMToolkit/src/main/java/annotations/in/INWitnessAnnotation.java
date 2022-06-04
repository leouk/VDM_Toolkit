package annotations.in;

import com.fujitsu.vdmj.in.annotations.INAnnotation;
import com.fujitsu.vdmj.in.definitions.INValueDefinition;
import com.fujitsu.vdmj.in.expressions.INExpressionList;
import com.fujitsu.vdmj.in.statements.INStatement;
import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.runtime.Context;
import com.fujitsu.vdmj.runtime.ContextException;
import com.fujitsu.vdmj.runtime.Interpreter;
import com.fujitsu.vdmj.tc.lex.TCIdentifierToken;
import com.fujitsu.vdmj.values.CPUValue;
import com.fujitsu.vdmj.values.NameValuePairList;
import com.fujitsu.vdmj.values.Value;

public class INWitnessAnnotation extends INAnnotation
{
	private static final long serialVersionUID = 1L;
	private static NameValuePairList tagValues = null;
	private final INValueDefinition myDefinition;

	public INWitnessAnnotation(TCIdentifierToken name, INExpressionList args, INValueDefinition myDefinition)
	{
		super(name, args);
		this.myDefinition = myDefinition;
	}
	
	public static void doInit()
	{
		tagValues  = new NameValuePairList();
		Context root = Interpreter.getInstance().getInitialContext();
		Context ctxt = new Context(LexLocation.ANY, "Witness context", root);
		ctxt.setThreadState(CPUValue.vCPU);
		boolean retry = false;
		int retries = 3;
		
		do
		{
			for (INAnnotation a: getInstances(INWitnessAnnotation.class))
			{
				try
				{
					INWitnessAnnotation witness = (INWitnessAnnotation)a;
					assert witness.myDefinition != null;
					NameValuePairList nvpl = witness.myDefinition.getNamedValues(ctxt);
					ctxt.putList(nvpl);
					tagValues.addAll(nvpl);
				}
				catch (ContextException e)
				{
					if (e.number == 4034)	// Name not in scope
					{
						retry = true;
					}
					else
					{
						throw e;
					}
				}
			}
		}
		while (retry && --retries > 0);
	}
	
	@Override
	protected void doInit(Context ctxt)
	{
		Context local = new Context(LexLocation.ANY, "Witness context", ctxt);
		ctxt.setThreadState(CPUValue.vCPU);
		ctxt.putList(tagValues);
		
		// Evaluate things using "local" context
		Value result = args.get(1).eval(local);
		System.out.println(this + " = " + result);
	}
	
	@Override
	public void inBefore(INStatement stmt, Context ctxt)
	{
	}
}

// import com.fujitsu.vdmj.in.annotations.INAnnotation;
// import com.fujitsu.vdmj.in.expressions.INExpressionList;
// import com.fujitsu.vdmj.runtime.Context;
// import com.fujitsu.vdmj.tc.lex.TCIdentifierToken;
// import com.fujitsu.vdmj.values.Value;

// import com.fujitsu.vdmj.runtime.ContextException;
// import com.fujitsu.vdmj.runtime.ExceptionHandler;
// import com.fujitsu.vdmj.values.BooleanValue;
// import com.fujitsu.vdmj.in.expressions.INMkTypeExpression;

// public class INWitnessAnnotation extends INAnnotation
// {
// 	public INWitnessAnnotation(TCIdentifierToken name, INExpressionList args)
// 	{
// 		super(name, args);
// 	}
	
// 	@Override
// 	protected void doInit(Context ctxt){
// 		try{
// 			//If argument is a mk type expression, dealing with type definition
// 			if(args.get(0) instanceof INMkTypeExpression){
// 				//Evaluate it; then what? 
// 				Value v = args.get(0).eval(ctxt);				
// 			}
// 			//Else, dealing with function/operation
// 			else{
// 				//Evaluate the first arg
// 				Value v1 = args.get(0).eval(ctxt);
				
// 				//If value is a boolean value, then dealing with implicit functions postc call
// 				if(v1 instanceof BooleanValue){
// 					//Cast to boolean value
// 					BooleanValue vB1 = (BooleanValue) v1;
					
// 					//If it evaulates to false, then postc not met
// 					if(vB1.value == false){		
// 						String msg = this + " is a bad witness. Postcondition not met.";
// 						ExceptionHandler.abort(name.getLocation(), 6222, msg, ctxt);	
// 					}					
// 				}
				
// 				//If there's a second arg
// 				if(args.size() == 2){
// 					//Evaluate the second arg
// 					Value v2 = args.get(1).eval(ctxt);
					
// 					//If value is a boolean value, then dealing with implicit functions prec call
// 					if(v2 instanceof BooleanValue){
// 						//Cast to boolean value
// 						BooleanValue vB2 = (BooleanValue) v2;
						
// 						//If it evaulates to false, then prec not met
// 						if(vB2.value == false){		
// 							String msg = this + " is a bad witness. Precondition not met.";
// 							ExceptionHandler.abort(name.getLocation(), 6223, msg, ctxt);	
// 						}
// 					}
// 					//Else, dealing with explicit function with two arguments
// 					else{
// 						//Compare the evaluated value to the user provided value
// 						if(!v1.equals(v2)){							
// 							String msg = this + " is a bad witness. It evaluates but to a different value than provided.\nActual: " + v1 + " Expected: " + v2;
// 							ExceptionHandler.abort(name.getLocation(), 6224, msg, ctxt);	
// 						}
// 					}				
// 				}
// 			}			
// 			//If reaches here, then no "bad witness exception" thrown, therefore is a good witness
// 			System.out.println(this + " is a good witness");			
// 		}catch(ContextException e){
// 			System.out.println(this + " is a bad witness.");
// 			ExceptionHandler.handle(e);			
// 		}			
// 	}
// }
