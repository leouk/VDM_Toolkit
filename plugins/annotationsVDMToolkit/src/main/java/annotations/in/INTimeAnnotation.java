/*******************************************************************************
 *	Author: Leo Freitas
 ******************************************************************************/
 
package annotations.in;

import java.util.Map;
import java.util.TreeMap;

import com.fujitsu.vdmj.in.annotations.INAnnotation;
import com.fujitsu.vdmj.in.expressions.INExpression;
import com.fujitsu.vdmj.in.expressions.INExpressionList;
import com.fujitsu.vdmj.in.expressions.INStringLiteralExpression;
import com.fujitsu.vdmj.in.statements.INStatement;
import com.fujitsu.vdmj.messages.Console;
import com.fujitsu.vdmj.runtime.Context;
import com.fujitsu.vdmj.tc.lex.TCIdentifierToken;
import com.fujitsu.vdmj.values.Value;
import com.fujitsu.vdmj.values.ValueFactory;

public class INTimeAnnotation extends INAnnotation
{
    private final static Map<String, Long> timeTotal = new TreeMap<String, Long>();
    
    private long checkPoint;
    private String currentTimeKey;
    
	public INTimeAnnotation(TCIdentifierToken name, INExpressionList args)
	{
		super(name, args);
		checkPoint = 0;
		currentTimeKey = "";//null;
	}
	
	@Override
	public void inBefore(INStatement stmt, Context ctxt)
	{
		start_clock();
	}
	
	@Override
	public void inBefore(INExpression exp, Context ctxt)
	{
		start_clock();
	}

	@Override
	public void inAfter(INStatement stmt, Value rv, Context ctxt)
	{
		doTime(ctxt);
	}
	
	@Override
	public void inAfter(INExpression exp, Value rv, Context ctxt)
	{
		doTime(ctxt);
	}	
	
	private void start_clock()
	{
	    // don't consider the overhead time to get the totals
	    INStringLiteralExpression fmt = (INStringLiteralExpression)args.get(0);
	    int endIndex = fmt.value.value.indexOf('(');
	    if (endIndex == -1) 
	    {
	        endIndex = fmt.value.value.length();
	    } 
	    currentTimeKey = fmt.value.value.substring(0, endIndex);
	    //Console.out.println("currentTimeKey = " + currentTimeKey);
	    if (!timeTotal.containsKey(currentTimeKey))
	    {
	        timeTotal.put(currentTimeKey, Long.valueOf(0));
	    }
	    
	    // check point time
	    checkPoint = System.currentTimeMillis();
	}
	
	private void doTime(Context ctxt)
	{
	    // get current time and save it for future totals
	    assert currentTimeKey != null /*&& timeTotal.containsKey(currentTimeKey)*/ : "Invalid or unknown current time key";
		final long currentTime = System.currentTimeMillis() - checkPoint;
		final Long mappedTimeLong = timeTotal.get(currentTimeKey);
		final long mappedTime = mappedTimeLong == null ? 0 : mappedTimeLong.longValue();
        long elapsedTime = mappedTime+currentTime;
        if (!currentTimeKey.equals("TIME_SUMMARY"))
        {	
        	timeTotal.put(currentTimeKey, Long.valueOf(elapsedTime)); 
        }
        
        // if JUST_SUMMARY exists, don't output
        if (!timeTotal.containsKey("JUST_SUMMARY"))
        {
        	// setup the user-given params + time param
			Object[] values = new Value[args.size()];
			values[0] = ValueFactory.mkInt(currentTime);		

			for (int p=1; p < args.size(); p++)
			{
				values[p] = args.get(p).eval(ctxt);
			}
		
			// build the output string including the time param at values[0]
			INStringLiteralExpression fmt = (INStringLiteralExpression)args.get(0);
			Console.out.printf("[%1s]\t\t " + fmt.value.value, values);
		}		
		
		//reset the time summary per call to it.
		if (currentTimeKey.equals("TIME_SUMMARY"))
        {
		    Console.out.println("\n---------------------------------------------------");
		    Console.out.println("Runtime summary per time key");
		    Console.out.println("---------------------------------------------------");
		    elapsedTime = elapsedTime == 0 ? 1 : elapsedTime;
		    for(String k : timeTotal.keySet())
		    {
		    	final long specificTime = timeTotal.get(k);
		    	final double percentTime = ((double)specificTime * 100 / (double)elapsedTime); 
		        Console.out.printf("[%1s%%][%2s] %3s\n", percentTime, specificTime, k);
		    }
		    Console.out.println("---------------------------------------------------\n");
		    Console.out.printf("[%1s] %2s\n", elapsedTime, currentTimeKey);
		    Console.out.println("---------------------------------------------------\n");
		    timeTotal.clear();
		}
		//} catch(NullPointerException e)
		//{
		//	Console.out.printf("NPE on currentTimeKey=%1s, currentTime=%2s, mappedTime=%3s\n",
		//		currentTimeKey, currentTime, timeTotal.get(currentTimeKey));
		//	e.printStackTrace();
		//}
	}
}
