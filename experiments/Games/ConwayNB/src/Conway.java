import java.awt.Graphics;
import java.math.BigInteger;

import javax.swing.JFrame;

import com.fujitsu.vdmj.RemoteControl;
import com.fujitsu.vdmj.RemoteInterpreter;
import com.fujitsu.vdmj.values.RecordValue;

/**
 * Animation for the Game of Life VDM-SL model
 * @author Nick Battle
 */
public class Conway implements RemoteControl
{
	private final static int CELL = 10;		// Cell size in pixels
	private final static int SIZE = 500;	// Display size in pixels
	private final static String GAME = "GOSPER_GLIDER_GUN";
	private final static int PAUSE = 200;
	
	@Override
	public void run(RemoteInterpreter interpreter) throws Exception
	{
		Grid g = new Grid();
		ValueSet result = interpreter.valueExecute(GAME).recordValue(null).fieldmap.get("pop").setValue(null);
		g.setData(result);
		g.setVisible(true);
		
		for (int i=0; i < 20; i++)
		{
			Thread.sleep(PAUSE);
			result = interpreter.valueExecute("generation(" + result +")").setValue(null);
			g.setData(result);
			g.repaint();
		}
		
		g.dispose();
	}
	
	@SuppressWarnings("serial")
	private static class Grid extends JFrame
	{
		private ValueSet data;
		
		public Grid()
		{
			this.setSize(SIZE, SIZE);
			this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		}
		
		public void setData(ValueSet data)
		{
			this.data = data;
		}
		
		@Override
		public void paint(Graphics g)
		{
			g.clearRect(0, 0, SIZE, SIZE);
			g.translate(SIZE/2, SIZE/2);
			
			try
			{
				for (Value point: data)
				{
					RecordValue record = point.recordValue(null);
					Object xval = record.fieldmap.get("x").intValue(null);
					Object yval = record.fieldmap.get("y").intValue(null);
					
					int x = 0;
					int y = 0;
					
					if (xval instanceof BigInteger)
					{
						x = ((BigInteger)xval).intValue();
						y = ((BigInteger)yval).intValue();
					}
					else
					{
						x = ((Long)xval).intValue();
						y = ((Long)yval).intValue();
					}
					
					g.fillRect(x*CELL, -y*CELL, CELL-1, CELL-1);
				}
			}
			catch (ValueException e)
			{
				e.printStackTrace();
			}
		}
	}
}
