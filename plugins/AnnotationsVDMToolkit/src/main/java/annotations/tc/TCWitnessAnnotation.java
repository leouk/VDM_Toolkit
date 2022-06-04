package annotations.tc;

import com.fujitsu.vdmj.tc.annotations.TCAnnotation;
import com.fujitsu.vdmj.tc.definitions.TCDefinition;
import com.fujitsu.vdmj.tc.definitions.TCDefinitionList;
import com.fujitsu.vdmj.tc.definitions.TCValueDefinition;
import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.tc.expressions.TCExpressionList;
import com.fujitsu.vdmj.tc.expressions.TCVariableExpression;
import com.fujitsu.vdmj.tc.lex.TCIdentifierToken;
import com.fujitsu.vdmj.tc.patterns.TCIdentifierPattern;
import com.fujitsu.vdmj.typechecker.Environment;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;
import com.fujitsu.vdmj.typechecker.NameScope;

import com.fujitsu.vdmj.tc.annotations.TCAnnotation;
import com.fujitsu.vdmj.tc.definitions.TCClassDefinition;
import com.fujitsu.vdmj.tc.definitions.TCDefinition;
import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.tc.expressions.TCExpressionList;
import com.fujitsu.vdmj.tc.lex.TCIdentifierToken;
import com.fujitsu.vdmj.tc.modules.TCModule;
import com.fujitsu.vdmj.tc.statements.TCStatement;
import com.fujitsu.vdmj.typechecker.Environment;
import com.fujitsu.vdmj.typechecker.NameScope;

import com.fujitsu.vdmj.tc.types.TCType;
import com.fujitsu.vdmj.tc.expressions.TCApplyExpression;
import com.fujitsu.vdmj.tc.definitions.TCImplicitFunctionDefinition;
import com.fujitsu.vdmj.tc.definitions.TCImplicitOperationDefinition;

public class TCWitnessAnnotation extends TCAnnotation
{
	private static final long serialVersionUID = 1L;
	private static TCDefinitionList tagDefinitions = null;
	private TCValueDefinition myDefinition = null;

	public TCWitnessAnnotation(TCIdentifierToken name, TCExpressionList args)
	{
		super(name, args);
	}
	
	public static void doInit()
	{
		tagDefinitions = new TCDefinitionList();
		
		for (TCAnnotation a : getInstances(TCWitnessAnnotation.class))
		{
			TCWitnessAnnotation witness = (TCWitnessAnnotation)a;
			
			if (witness.args.get(0) instanceof TCVariableExpression &&
				witness.args.get(1) instanceof TCExpression)
			{
				tagDefinitions.add(witness.createDefinition());
			}
		}
	}
	
	private TCValueDefinition createDefinition()
	{
		TCVariableExpression tag = (TCVariableExpression)args.get(0);
		myDefinition  = new TCValueDefinition(NameScope.LOCAL, null,
				null, new TCIdentifierPattern(tag.name), null, args.get(1));
		
		return myDefinition;
	}

	@Override
	protected void doInit(Environment globals)
	{
		Environment local = new FlatEnvironment(tagDefinitions, globals);
		tagDefinitions.typeCheck(local, NameScope.LOCAL);
	}

	@Override
	public void tcBefore(TCDefinition def, Environment env, NameScope scope)
	{
		Environment local = new FlatEnvironment(tagDefinitions, env);
		
		args.get(0).typeCheck(local, null, scope, null);
		args.get(1).typeCheck(local, null, scope, null);
	}
}

	// //TCAfter to ensure the types have been resolved rather than TCBefore
	// @Override
	// public void tcAfter(TCDefinition def, TCType type, Environment env, NameScope scope)
	// {
	// 	checkArgs(def, type, env, scope);
	// }
	
	// //Method to check the number of arguments provided and the type of those arguments
	// private void checkArgs(TCDefinition def, TCType type, Environment env, NameScope scope)
	// {		
	// 	//If annotation is on a type definition
	// 	if(def.isTypeDefinition()){			
	// 		//Check there's only one argument
	// 		if(args.size() != 1) {
	// 			name.report(6021, "@Witness on a type definition should only have one argument");
	// 		}
	// 		//If so, type check it
	// 		else
	// 		{	
	// 			args.get(0).typeCheck(env,null,scope,type);
	// 		}
	// 	}
				
	// 	//If annotation is on an implicit function
	// 	else if (def instanceof TCImplicitFunctionDefinition){			
	// 		//Cast to the more specific type
	// 		TCImplicitFunctionDefinition imDef = (TCImplicitFunctionDefinition) def;
		
	// 		//If no precondition exists for this function
	// 		if(imDef.predef == null){
	// 			//Since no precondition, just one argument is expected
	// 			if(args.size() != 1) {
	// 				name.report(6022, "@Witness on an implicit function without a precondition should only have one argument, a post condition call.");
	// 			}
	// 			else{
	// 				//Correct number of arguments, check that the first argument is an apply expression
	// 				if(args.get(0) instanceof TCApplyExpression){
	// 					//Cast to the more specific expression type
	// 					TCApplyExpression funcPostArg = (TCApplyExpression) args.get(0);
						
	// 					//Get the expected name (def) and the actual name (arg)
	// 					String imDefPostName = imDef.postdef.name.toString();
	// 					String funcPostArgName = funcPostArg.root.toString();
						
	// 					//Compare the names
	// 					if(!imDefPostName.equals(funcPostArgName)){
	// 						name.report(6024, "@Witness has incorrect function post condition call");
	// 						name.detail2("Actual: " , funcPostArgName , "Expected: ", imDefPostName);
	// 					}
	// 					//Else, correct post func name, check its arguments
	// 					else{
	// 						args.get(0).typeCheck(env,null,scope,null); // Just checks scope
	// 					}
	// 				}
	// 				//Else, first argument not an apply expression, 
	// 				else {
	// 					name.report(6022, "@Witness on an implicit function without a precondition should have one argument, a post condition call.");
	// 				}
	// 			}
	// 		}
	// 		//Else, precondition exists for this function
	// 		else{
	// 			//Since precondition exists, two arguments are expected
	// 			if(args.size() != 2) {
	// 				name.report(6023, "@Witness on an implicit function with a precondition should have two arguments, a post condition call followed by a pre condition call.");
	// 			}
	// 			else{
	// 				//Correct number of arguments, check that both arguments are apply expressions
	// 				if(args.get(0) instanceof TCApplyExpression && args.get(1) instanceof TCApplyExpression){
	// 					//Cast to the more specific expression type
	// 					TCApplyExpression funcPostArg = (TCApplyExpression) args.get(0);
	// 					TCApplyExpression funcPreArg = (TCApplyExpression) args.get(1);
						
	// 					//Get the expected names (def) and the actual names (arg)
	// 					String imDefPostName = imDef.postdef.name.toString();
	// 					String funcPostArgName = funcPostArg.root.toString();
	// 					String imDefPreName = imDef.predef.name.toString();
	// 					String funcPreArgName = funcPreArg.root.toString();
						
	// 					//Compare the post names
	// 					if(!imDefPostName.equals(funcPostArgName)){
	// 						name.report(6024, "@Witness has incorrect function post condition call");
	// 						name.detail2("Actual: " , funcPostArgName , "Expected: ", imDefPostName);
	// 					}
	// 					//Compare the pre names
	// 					else if(!imDefPreName.equals(funcPreArgName)){
	// 						name.report(6025, "@Witness has incorrect function pre condition call");
	// 						name.detail2("Actual: " , funcPreArgName , "Expected: ", imDefPreName);
	// 					}
	// 					//Else, correct names, check their arguments
	// 					else{
	// 						args.get(0).typeCheck(env,null,scope,null); // Just checks scope
	// 						args.get(1).typeCheck(env,null,scope,null); // Just checks scope
							
	// 						//Check that arguments in both pre and post match (excludes the last argument of post since is output and doesn't exist in pre)
	// 						int i = 0;
	// 						for(TCExpression arg : funcPreArg.args){
	// 							if(!funcPostArg.args.get(i).equals(arg)){
	// 								name.report(6026, "@Witness post and pre calls have different arguments passed");
	// 								name.detail2("Post Argument (" + i + "): " , funcPostArg.args.get(i), "Corresponding Pre Argument: ", arg);
	// 							}
	// 						i++;
	// 						}								
	// 					}
	// 				}
	// 				else {
	// 					name.report(6023, "@Witness on an implicit function with a precondition should have two arguments, a post condition call followed by a pre condition call.");
	// 				}
	// 			}
	// 		}
	// 	}			
			
	// 	//If annotation is on an implicit operation
	// 	else if(def instanceof TCImplicitOperationDefinition){
			
	// 		//Cast to the more specific type
	// 		TCImplicitOperationDefinition imDef = (TCImplicitOperationDefinition) def;
		
	// 		//If no precondition exists for this operation
	// 		if(imDef.predef == null){
	// 			//Since no precondition, just one argument is expected
	// 			if(args.size() != 1) {
	// 				name.report(6022, "@Witness on an implicit operation without a precondition should only have one argument, a post condition call.");
	// 			}
	// 			else{
	// 				//Correct number of arguments, check that the first argument is an apply expression
	// 				if(args.get(0) instanceof TCApplyExpression){
	// 					//Cast to the more specific expression type
	// 					TCApplyExpression operPostArg = (TCApplyExpression) args.get(0);
						
	// 					//Get the expected name (def) and the actual name (arg)
	// 					String imDefPostName = imDef.postdef.name.toString();
	// 					String operPostArgName = operPostArg.root.toString();
						
	// 					//Compare the names
	// 					if(!imDefPostName.equals(operPostArgName)){
	// 						name.report(6024, "@Witness has incorrect operation post condition call");
	// 						name.detail2("Actual: " , operPostArgName , "Expected: ", imDefPostName);
	// 					}
	// 					//Else, correct post oper name, check its arguments
	// 					else{
	// 						args.get(0).typeCheck(env,null,scope,null); // Just checks scope
	// 					}
	// 				}
	// 				else {
	// 					name.report(6022, "@Witness on an implicit operation without a precondition should have one argument, a post condition call.");
	// 				}
	// 			}
	// 		}
	// 		//Else, precondition exists for this operation
	// 		else{
	// 			//Since precondition exists, two arguments are expected
	// 			if(args.size() != 2) {
	// 				name.report(6023, "@Witness on an implicit operation with a precondition should have two arguments, a post condition call followed by a pre condition call.");
	// 			}
	// 			else{
	// 				//Correct number of arguments, check that both arguments are apply expressions
	// 				if(args.get(0) instanceof TCApplyExpression && args.get(1) instanceof TCApplyExpression){
	// 					//Cast to the more specific expression type
	// 					TCApplyExpression operPostArg = (TCApplyExpression) args.get(0);
	// 					TCApplyExpression operPreArg = (TCApplyExpression) args.get(1);
						
	// 					//Get the expected names (def) and the actual names (arg)
	// 					String imDefPostName = imDef.postdef.name.toString();
	// 					String operPostArgName = operPostArg.root.toString();
	// 					String imDefPreName = imDef.predef.name.toString();
	// 					String operPreArgName = operPreArg.root.toString();
						
	// 					//Compare the post names
	// 					if(!imDefPostName.equals(operPostArgName)){
	// 						name.report(6024, "@Witness has incorrect operation post condition call");
	// 						name.detail2("Actual: " , operPostArgName , "Expected: ", imDefPostName);
	// 					}
	// 					//Compare the pre names
	// 					else if(!imDefPreName.equals(operPreArgName)){
	// 						name.report(6025, "@Witness has incorrect operation pre condition call");
	// 						name.detail2("Actual: " , operPreArgName , "Expected: ", imDefPreName);
	// 					}
	// 					//Else, correct names, check their arguments
	// 					else{
	// 						args.get(0).typeCheck(env,null,scope,null); // Just checks scope
	// 						args.get(1).typeCheck(env,null,scope,null); // Just checks scope
							
	// 						//Check that arguments in both pre and post match
	// 						//If result is null, can do so as in the function section (all but last arg in post)
	// 						if(imDef.result == null){
	// 							for(int i=0; i<operPreArg.args.size(); i++){
	// 								System.out.println("Post Argument (" + i + "): "  + operPostArg.args.get(i) + " Corresponding Pre Argument: " + operPreArg.args.get(i));
	// 								if(!operPostArg.args.get(i).equals(operPreArg.args.get(i))){
	// 									name.report(6026, "@Witness post and pre calls have different arguments passed");
	// 									name.detail2("Post Argument (" + i + "): " , operPostArg.args.get(i), " Corresponding Pre Argument: ", operPreArg.args.get(i));
	// 								}
	// 							}
	// 						}
	// 						//Else works differently, due to the state objects needed with operations
	// 						else{
	// 							//Check all but last in Pre with corresponding post
	// 							for(int i=0; i<operPreArg.args.size()-1; i++){
	// 								System.out.println("Post Argument (" + i + "): "  + operPostArg.args.get(i) + " Corresponding Pre Argument: " + operPreArg.args.get(i));
	// 								if(!operPostArg.args.get(i).equals(operPreArg.args.get(i))){
	// 									name.report(6026, "@Witness post and pre calls have different arguments passed");
	// 									name.detail2("Post Argument (" + i + "): " , operPostArg.args.get(i), "Corresponding Pre Argument: ", operPreArg.args.get(i));
	// 								}
	// 							}
	// 							//Now check last argument in pre with corresponding post (one index prior to that of post)
	// 							//This is needed due to the state variables passed with pre and post conditions for operations
	// 							int i = operPreArg.args.size()-1;
	// 							System.out.println("Post Argument (" + (i+1) + "): "  + operPostArg.args.get(i+1) + " Corresponding Pre Argument: " + operPreArg.args.get(i));
	// 								if(!operPostArg.args.get(i+1).equals(operPreArg.args.get(i))){
	// 									name.report(6026, "@Witness post and pre calls have different arguments passed");
	// 									name.detail2("Post Argument (" + (i+1) + "): " , operPostArg.args.get(i+1), "Corresponding Pre Argument(" + i + "): ", operPreArg.args.get(i));
	// 								}
	// 						}
	// 					}
	// 				}
	// 				else {
	// 					name.report(6023, "@Witness on an implicit operation with a precondition should have two arguments, a post condition call followed by a pre condition call.");
	// 				}
	// 			}
	// 		}
	// 	}
	// }
		


