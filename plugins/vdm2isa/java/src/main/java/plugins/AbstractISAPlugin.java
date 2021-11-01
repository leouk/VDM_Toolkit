package plugins;

import java.util.Arrays;
import java.util.List;
import java.util.Vector;

import javax.swing.text.AbstractDocument;

import com.fujitsu.vdmj.Release;
import com.fujitsu.vdmj.Settings;
import com.fujitsu.vdmj.commands.CommandPlugin;
import com.fujitsu.vdmj.config.Properties;
import com.fujitsu.vdmj.lex.Dialect;
import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.messages.ConsoleWriter;
import com.fujitsu.vdmj.messages.InternalException;
import com.fujitsu.vdmj.messages.VDMWarning;
import com.fujitsu.vdmj.runtime.Interpreter;

import vdm2isa.messages.VDM2IsaError;
import vdm2isa.messages.VDM2IsaWarning;

public abstract class AbstractISAPlugin extends CommandPlugin {

    private final static List<VDM2IsaError> errors = new Vector<VDM2IsaError>();
    private final static List<VDM2IsaWarning> warnings = new Vector<VDM2IsaWarning>();

    // list of VDM warning numbers to raise as errors
    private final static List<Integer> vdmWarningOfInterest = Arrays.asList(5000, 5006, 5007, 5008, 5009, 5010, 5011,
            5012, 5013, 5016, 5017, 5018, 5019, 5020, 5021, 5031, 5032, 5033, 5037);

    // assuming max translation errors equals max type errors for now
    public static int maxErrors;
    public static String isaVersion;
    public static int errs;

    public AbstractISAPlugin(Interpreter interpreter) {
        super(interpreter);
    }

    public static void checkVDMSettings()
    {
        if (Settings.dialect != Dialect.VDM_SL)
        {
            Vdm2isaPlugin.report(11111, "Only VDMSL supports Isabelle translation", LexLocation.ANY);
            errs++;
        }
        if (Settings.release != Release.VDM_10)
        {
            // This refers to stuff like TCNameToken filtering important names out for CLASSIC say.
            // For now, it only affects TRExplicitFunctionDefinition, but this might get wider. 
            Vdm2isaPlugin.warning(11111, "Isabelle translation is optimal for VDM_10. You might encounter problems with CLASSIC release.", LexLocation.ANY);	
        }
    }

    public static void report(int number, String problem, LexLocation location) {
        VDM2IsaError error = new VDM2IsaError(number, problem, location);
        if (!errors.contains(error)) {
            errors.add(error);

            if (errors.size() >= AbstractISAPlugin.maxErrors - 1) {
                errors.add(new VDM2IsaError(10, "Too many translation errors", location));
                throw new InternalException(10, "Too many translation errors");
            }
        }
    }

    public static void reportAsError(VDMWarning w) {
        if (AbstractISAPlugin.vdmWarningOfInterest.contains(w.number)) {
            report(11111 + w.number, w.message, w.location);
        }
    }

    public static void warning(int number, String problem, LexLocation location) {
        VDM2IsaWarning warning = new VDM2IsaWarning(number, problem, location);

        if (!warnings.contains(warning)) {
            warnings.add(warning);
        }
    }

    public static void clearErrors() {
        AbstractISAPlugin.errs = 0;
        AbstractISAPlugin.errors.clear();
        AbstractISAPlugin.warnings.clear();
    }

    public static int getErrorCount() {
        return AbstractISAPlugin.errors.size();
    }

    public static int getWarningCount() {
        return AbstractISAPlugin.warnings.size();
    }

    public static List<VDM2IsaError> getErrors() {
        return AbstractISAPlugin.errors;
    }

    public static List<VDM2IsaWarning> getWarnings() {
        return AbstractISAPlugin.warnings;
    }

    public static void printErrors(ConsoleWriter out) {
        for (VDM2IsaError e : AbstractISAPlugin.errors) {
            out.println(e.toString());
        }
    }

    public static void printWarnings(ConsoleWriter out) {
        for (VDM2IsaWarning w : AbstractISAPlugin.warnings) {
            out.println(w.toString());
        }
    }

    public static String plural(int n, String s, String pl) {
        return n + " " + (n != 1 ? s + pl : s);
    }

    protected static void reset() {
        // reset internal tables in case of restranslation
        AbstractISAPlugin.clearErrors();
    }

    public static void setupProperties() {
        AbstractISAPlugin.errs = 0;
        AbstractISAPlugin.maxErrors = Properties.tc_max_errors;
        AbstractISAPlugin.isaVersion = "Isabelle2021: February 2021";
    }
}
