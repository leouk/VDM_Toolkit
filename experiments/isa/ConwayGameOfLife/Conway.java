
import java.awt.Graphics;

import javax.swing.JFrame;

import org.overture.interpreter.debug.RemoteControl;
import org.overture.interpreter.debug.RemoteInterpreter;
import org.overture.interpreter.runtime.ValueException;
import org.overture.interpreter.values.RecordValue;
import org.overture.interpreter.values.Value;
import org.overture.interpreter.values.ValueSet;

/**
 * Animation for the Game of Life VDM-SL model
 * @author Nick Battle
 *
 * Build with "javac -cp Overture-2.3.6.jar Conway.java", and move class files to lib.
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
		ValueSet result = interpreter.valueExecute(GAME).setValue(null);
		g.setData(result);
		g.setVisible(true);
		
		while (true)
		{
			Thread.sleep(PAUSE);
			result = interpreter.valueExecute("generation(" + result +")").setValue(null);
			g.setData(result);
			g.repaint();
		}
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
					int x = (int) record.fieldmap.get("x").intValue(null);
					int y = (int) record.fieldmap.get("y").intValue(null);
					
					g.fillRect(x*CELL, y*CELL, CELL-1, CELL-1);
				}
			}
			catch (ValueException e)
			{
				e.printStackTrace();
			}
		}
	}
}
