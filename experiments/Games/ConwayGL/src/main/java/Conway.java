
import java.awt.Graphics;

import javax.swing.JFrame;

import com.fujitsu.vdmj.RemoteControl;
import com.fujitsu.vdmj.RemoteInterpreter;
import com.fujitsu.vdmj.runtime.ValueException;
import com.fujitsu.vdmj.values.RecordValue;
import com.fujitsu.vdmj.values.Value;
import com.fujitsu.vdmj.values.ValueSet;

/**
 * Animation for the Game of Life VDM-SL model
 * @author Leo Freitas (revamped from Nick Battle's version for OVerture) .
 *
 * Build with "javac -cp vdmj4.4.4-SNAPSHOT.jar Conway.java", and move class files to lib.
 */
public class Conway implements RemoteControl
{
	private final static int CELL = 10;		// Cell size in pixels
	private final static int SIZE = 500;	// Display size in pixels
	private final static String GAME = "GOSPER_GLIDER_GUN";
	private final static int PAUSE = 200;
	
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

	public void run(RemoteInterpreter interpreter) throws Exception {
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
}
