/*******************************************************************************
 *
 *	Copyright (c) 2016 Aarhus University.
 *
 *	Author: Nick Battle and Kenneth Lausdahl
 *
 *	This file is part of VDMJ.
 *
 *	VDMJ is free software: you can redistribute it and/or modify
 *	it under the terms of the GNU General Public License as published by
 *	the Free Software Foundation, either version 3 of the License, or
 *	(at your option) any later version.
 *
 *	VDMJ is distributed in the hope that it will be useful,
 *	but WITHOUT ANY WARRANTY; without even the implied warranty of
 *	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *	GNU General Public License for more details.
 *
 *	You should have received a copy of the GNU General Public License
 *	along with VDMJ.  If not, see <http://www.gnu.org/licenses/>.
 *	SPDX-License-Identifier: GPL-3.0-or-later
 *
 ******************************************************************************/

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.Serializable;

import com.fujitsu.vdmj.ast.expressions.ASTExpression;
import com.fujitsu.vdmj.in.INNode;
import com.fujitsu.vdmj.in.expressions.INExpression;
import com.fujitsu.vdmj.lex.Dialect;
import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.lex.LexTokenReader;
import com.fujitsu.vdmj.mapper.ClassMapper;
import com.fujitsu.vdmj.runtime.Context;
import com.fujitsu.vdmj.runtime.Interpreter;
import com.fujitsu.vdmj.runtime.VDMFunction;
import com.fujitsu.vdmj.syntax.ExpressionReader;
import com.fujitsu.vdmj.tc.TCNode;
import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.values.BooleanValue;
import com.fujitsu.vdmj.values.CPUValue;
import com.fujitsu.vdmj.values.NilValue;
import com.fujitsu.vdmj.values.SeqValue;
import com.fujitsu.vdmj.values.TupleValue;
import com.fujitsu.vdmj.values.Value;
import com.fujitsu.vdmj.values.ValueList;


import util.CsvParser2;
import util.CsvResult;
import util.CsvValueBuilder;

/**
 * Basic CSV file support for VDM with default to string conversions
 * 
 * @author AJB
 */
public class CSV2 implements Serializable
{
	private static final long serialVersionUID = 1L;
	private static String lastError = "";

	public static File getFile(Value fval)
	{
		String path = IO.stringOf(fval).replace('/', File.separatorChar);
		return new File(path).getAbsoluteFile();
	}

	public static String getLine(File file, long index) throws IOException
	{
		BufferedReader bufRdr = new BufferedReader(new FileReader(file));
		String line = null;
		int lineIndex = 0;

		if (index < 1)
		{
			bufRdr.close();
			throw new IOException("CSV line index before first entry");
		}

		try
		{
			while ((line = bufRdr.readLine()) != null)
			{
				lineIndex++;
				if (lineIndex == index)
				{
					break;
				}

			}
		}
		finally
		{
			bufRdr.close();
		}

		if (line == null)
		{
			throw new IOException("CSV no data read. Empty line.");
		}

		return line;
	}

	public static Value createValue(String module, String method, String value)
			throws Exception
	{
		LexTokenReader ltr = new LexTokenReader(value, Dialect.VDM_PP);
		ExpressionReader reader = new ExpressionReader(ltr);
		reader.setCurrentModule(module);
		ASTExpression exp = reader.readExpression();
		TCExpression tcexp = ClassMapper.getInstance(TCNode.MAPPINGS).convert(exp);
		Interpreter ip = Interpreter.getInstance();
		ip.typeCheck(tcexp);
		INExpression inexp = ClassMapper.getInstance(INNode.MAPPINGS).convert(tcexp);
		Context ctxt = new Context(LexLocation.ANY, method, null);
		ctxt.setThreadState(CPUValue.vCPU);
		
		return inexp.eval(ctxt);
	}

	/**
	 * Read a CSV live as a seq of ? in VDM
	 * 
	 * @param fval
	 *            name of the file to read from
	 * @param indexVal
	 *            the line index
	 * @return true + seq of ? or false and nil
	 */
	@VDMFunction
	public static Value freadval(Value fval, Value indexVal)
	{
		ValueList result = new ValueList();

		try
		{
			File file = CSV2.getFile(fval);
			long index = indexVal.intValue(null);
			SeqValue lineCells = new SeqValue();

			boolean success = false;
			try
			{
				//Using CsvParser2 to add quotes
				CsvParser2 parser = new CsvParser2(new CsvValueBuilder()
				{
					@Override
					public Value createValue(String value)
							throws Exception
					{
						return CSV2.createValue("CSV2", "freadval", value);
					}
				});
				
				CsvResult res = parser.parseValues(CSV2.getLine(file, index));
				
				if(!res.dataOk())
				{
					lastError = res.getErrorMsg();
					success = false;
				}
				else
				{
					lineCells.values.addAll(res.getValues());
					success = true;
				}
			}
			catch (Exception e)
			{
				success = false;
				lastError = e.getMessage();
				// OK
			}

			result.add(new BooleanValue(success));
			result.add(lineCells);
		}
		catch (Exception e)
		{
			lastError = e.toString();
			result = new ValueList();
			result.add(new BooleanValue(false));
			result.add(new NilValue());
		}

		return new TupleValue(result);
	}

}
