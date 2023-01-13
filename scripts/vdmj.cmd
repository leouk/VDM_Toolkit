::!/bin/bash
::####################################################################################
:: Execute VDMJ jar with various options
::
:: Version adapted from https://github.com/leouk/VDM_Toolkit/blob/main/scripts/vdmj.sh for windows
::####################################################################################

 @echo off
setlocal  EnableDelayedExpansion
:: Change these to flip VDMJ version
set MVERSION="4.5.0-SNAPSHOT"
set PVERSION="4.5.0-P-SNAPSHOT"

:: Preferred VDMJ options
set VDMJ_OPTS="-strict"

echo %VDM_HOME%
echo %JAVA_HOME%

:: The Maven repository directory containing VDMJ and VDM_Toolkit jars
set VDMJMAVENREPO=%VDM_HOME%\vdmj
set VDMTOOLKITMAVENREPO=%VDM_HOME%\VDM_Toolkit\plugins


:: Location of the vdmj.properties file, if any. Override with -D.
set PROPDIR=""

:: Details for 64-bit Java
set JAVA64=%JAVA_HOME%\java
set VM_OPTS="-Xmx3000m -Xss1m -Djava.rmi.server.hostname=localhost -Dcom.sun.management.jmxremote -Dmax.errors=1000"


: Just warn if a later version is available in Maven
FOR /F "tokens=*" %%f IN ('dir %VDMJMAVENREPO%\vdmj\target /A:-D /B') DO (
    set LATEST=%%f
)

 IF "%MVERSION%" NEQ "%LATEST%" (
   echo "WARNING: Latest VDMJ version is %LATEST%, not %MVERSION%"
 )


: Just warn if a later version is available in Maven
FOR /F "tokens=*" %%f IN ('dir %VDMTOOLKITMAVENREPO%\vdm2isa\target /A:-D /B') DO (
    set LATEST=%%f
)

 IF "%MVERSION%" NEQ "%LATEST%" (
   echo "WARNING: Latest VDM TOOLKIT version is %LATEST%, not %MVERSION%"
 )

: Chosen version defaults to "master"
set VERSION="target"

set argCount =0
for %%x in (%*) do Set /A argCount+=1

if %argCount% EQU 0 (
    call :help
) 

for %%x in (%*) do (
   set "arg=%%~x"
   IF "%arg%" == "--help"  (
        call :help
   ) ELSE IF "%arg%" == "-\?" (
        call :help
   ) ELSE IF "%arg%" == "-A" (
        set ANNOTATIONS_VERSION=%VERSION%
   ) ELSE IF "%arg%" == "-P" (
        set VERSION=%PVERSION%
   ) ELSE IF "%arg%" == "-D*" (
        set VM_OPTS="%VM_OPTS% %arg%"
   ) ELSE IF "%arg%" == "-X*" (
        set VM_OPTS="%VM_OPTS% %arg%"
   ) ELSE IF "%arg%" == "*" (
        set VDMJ_OPTS="%VDMJ_OPTS% %arg%"
   )
)

: Locate the jars; append VDMToolkit jars accordingly, but with MVERSION (not -P)!
set VDMJ_JAR=%VDMJMAVENREPO%\vdmj\%VERSION%\vdmj-%VERSION%.jar
set STDLIB_JAR=%VDMJMAVENREPO%\stdlib\%VERSION%\stdlib-%VERSION%.jar
set PLUGINS_JAR=%VDMJMAVENREPO%\cmd-plugins\%VERSION%\cmd-plugins-%VERSION%.jar
set VDMTOOLKIT_LIB_JAR=%VDMTOOLKITMAVENREPO%\vdmlib\%MVERSION%\vdmlib-%MVERSION%.jar
set VDMTOOLKIT_PLUGIN_JAR=%VDMTOOLKITMAVENREPO%\vdm2isa\%MVERSION%\vdm2isa-%MVERSION%.jar
call :check "%VDMJ_JAR%"
call :check "%STDLIB_JAR%"
call :check "%PLUGINS_JAR%"
call :check "%VDMTOOLKIT_LIB_JAR%"
call :check "%VDMTOOLKIT_PLUGIN_JAR%"
set CLASSPATH="%VDMJ_JAR%:%PLUGINS_JAR%:%VDMTOOLKIT_PLUGIN_JAR%:%STDLIB_JAR%:%VDMTOOLKIT_LIB_JAR%:%PROPDIR%"

set MAIN="com.fujitsu.vdmj.VDMJ"

echo "%CLASSPATH%"


: always keep them on for now 
: if [ $ANNOTATIONS_VERSION ]
: then
    set ANNOTATIONS_JAR=%VDMJMAVENREPO%\annotations\%VERSION%\annotations-%VERSION%.jar
    call :check "%ANNOTATIONS_JAR%"
    : Remove Annotations2 to allow for right "Witness" to be picked
    : ANNOTATIONS2_JAR=$VDMJMAVENREPO/annotations2/${VERSION}/annotations2-${VERSION}.jar
    : check "$ANNOTATIONS2_JAR"
    set ANNOTATIONS_VDM_TOOLKIT_JAR=%VDMTOOLKITMAVENREPO%\annotationsVDMToolkit\%MVERSION%\annotationsVDMToolkit-%MVERSION%.jar
    call :check "%ANNOTATIONS_VDM_TOOLKIT_JAR%"
    set VDMJ_OPTS="%VDMJ_OPTS% -annotations"
    set VM_OPTS="%VM_OPTS% -Dannotations.debug -Dvdmj.parser.merge_comments=true"
    set CLASSPATH="%CLASSPATH%:%ANNOTATIONS_JAR%:%ANNOTATIONS2_JAR%:%ANNOTATIONS_VDM_TOOLKIT_JAR%"
: fi

: The dialect for vdm2isa is always VDMSL for now; is based on $0, so hard-link this file as vdmsl, vdmpp and vdmrt.
: DIALECT=$(basename $0)
set DIALECT=vdmsl

: Check whether RLWRAP exists calling without it if not
: if which rlwrap >/dev/null 2>&1
: then
: 	: Keep rlwrap output in a separate folder
: 	export RLWRAP_HOME=~/.vdmj
: 	exec rlwrap "$JAVA64" $VM_OPTS -cp $CLASSPATH $MAIN -$DIALECT $VDMJ_OPTS "$@"
: else
: 	exec "$JAVA64" $VM_OPTS -cp $CLASSPATH $MAIN -$DIALECT $VDMJ_OPTS "$@"
: fi

echo "%CLASSPATH%"
echo "%*"

 "%JAVA64%" %VM_OPTS% -cp %CLASSPATH% %MAIN% -%DIALECT% %VDMJ_OPTS% "%*"

exit
: echo cmd


:help
    echo "Usage: $0 [--help|-?] [-P] [-A] <VM and VDMJ options>"
    echo "-P use high precision VDMJ"
    echo "-A use annotation libraries and options"
    echo "Default VM options are %JAVA64% %VM_OPTS%"
    exit /B 0

:check
    if NOT exist %~1 (
        echo "Cannot read %~1"
        exit /B 1
    )
