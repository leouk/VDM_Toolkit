package uk.ac.ncl.vdm2dafny.tr.dafny.statements;

import java.util.List;
import java.util.stream.Collectors;

import com.fujitsu.vdmj.tc.statements.TCAssignmentStatement;
import com.fujitsu.vdmj.tc.statements.TCAtomicStatement;
import com.fujitsu.vdmj.tc.statements.TCBlockStatement;
import com.fujitsu.vdmj.tc.statements.TCCallStatement;
import com.fujitsu.vdmj.tc.statements.TCDefStatement;
import com.fujitsu.vdmj.tc.statements.TCElseIfStatement;
import com.fujitsu.vdmj.tc.statements.TCErrorStatement;
import com.fujitsu.vdmj.tc.statements.TCForAllStatement;
import com.fujitsu.vdmj.tc.statements.TCForIndexStatement;
import com.fujitsu.vdmj.tc.statements.TCIfStatement;
import com.fujitsu.vdmj.tc.statements.TCLetBeStStatement;
import com.fujitsu.vdmj.tc.statements.TCLetDefStatement;
import com.fujitsu.vdmj.tc.statements.TCReturnStatement;
import com.fujitsu.vdmj.tc.statements.TCSkipStatement;
import com.fujitsu.vdmj.tc.statements.TCStatement;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import uk.ac.ncl.plugins.commands.DafnyTranslateCommand;
import uk.ac.ncl.vdm2dafny.messages.DafnyErrorMessage;
import uk.ac.ncl.vdm2dafny.tr.dafny.AbstractDafnyNode;
import uk.ac.ncl.vdm2dafny.tr.dafny.DafnyVDMComment;

public abstract class DafnyStatement extends AbstractDafnyNode {
    public abstract TCStatement getVDM();

    public static DafnyStatement of(TCStatement vdm, FlatEnvironment env) {
        if (vdm instanceof TCAssignmentStatement) {
            return new DafnyAssignStatement((TCAssignmentStatement)vdm, env);
        }
        else if (vdm instanceof TCBlockStatement) {
            return new DafnyBlockStatement((TCBlockStatement)vdm, env);
        }
        else if (vdm instanceof TCCallStatement) {
            if (DafnySpecialCallStatement.is((TCCallStatement)vdm))
                return new DafnySpecialCallStatement((TCCallStatement)vdm, env);
            return new DafnyCallStatement((TCCallStatement)vdm, env);
        }
        else if (vdm instanceof TCDefStatement) {
            return new DafnyDefineStatement((TCDefStatement)vdm, env);
        }
        else if (vdm instanceof TCLetDefStatement) {
            return new DafnyLetStatement((TCLetDefStatement)vdm, env);
        }
        else if (vdm instanceof TCForAllStatement) {
            return new DafnyForallStatement((TCForAllStatement)vdm, env);
        }
        else if (vdm instanceof TCForIndexStatement) {
            return new DafnyForIdxStatement((TCForIndexStatement)vdm, env);
        }
        else if (vdm instanceof TCSkipStatement) {
            return new DafnyIdentityStatement((TCSkipStatement)vdm);
        }
        else if (vdm instanceof TCReturnStatement) {
            return new DafnyReturnStatement((TCReturnStatement)vdm, env);
        }
        else if (vdm instanceof TCIfStatement) {
            return new DafnyIfStatement((TCIfStatement)vdm, env);
        }
        else if (vdm instanceof TCElseIfStatement) {
            return new DafnyElseIfStatement((TCElseIfStatement)vdm, env);
        }
        else if (vdm instanceof TCErrorStatement) {
            return new DafnyErrorStatement((TCErrorStatement)vdm, env);
        }
        else if (vdm instanceof TCLetBeStStatement) {
            return new DafnyLetBeStatement((TCLetBeStStatement)vdm, env);
        }
        else if (vdm instanceof TCAtomicStatement) {
            return new DafnyAtomicStatement((TCAtomicStatement)vdm, env);
        }
        else {
            DafnyTranslateCommand.report(DafnyErrorMessage.DAFNY_UNKNOWN_STATEMENT, vdm.location, vdm.getClass().getSimpleName());
            DafnyTranslateCommand.report(DafnyErrorMessage.PLUGIN_NYI_2P, vdm.location, vdm.getClass().getSimpleName(), "statements");
            return null;
        }
    }

    public List<DafnyVDMComment> getComments() {
        return getVDM().comments.stream().map(comment -> new DafnyVDMComment(comment)).collect(Collectors.toList());
    }
}
