package annotations;

import com.fujitsu.vdmj.VDMJ;

public class TestVDMJ {
    
    public static void main(String[] args)
    {
		VDMJ.main(new String[] {"-vdmsl", "-strict", "-annotations", "-i", 
            "/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/annotations/src/test/resources/MinimalTheorem.vdmsl"
        //   ,"/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/annotations/src/test/resources/MinimalTime.vdmsl"
        //   ,"/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/annotations/src/test/resources/Witness.vdmsl"
        });  
    }
}
