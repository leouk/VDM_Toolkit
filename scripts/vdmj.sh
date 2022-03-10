#!/bin/bash
#####################################################################################
# Execute VDMJ jar with various options
#####################################################################################

# Change these to flip VDMJ version
MVERSION="4.4.5-SNAPSHOT"
PVERSION="4.4.5-SNAPSHOT-P"

# Preferred VDMJ options
VDMJ_OPTS="-strict"

# The Maven repository directory containing VDMJ jars
MAVENREPO=~/.m2/repository/com/fujitsu

# Location of the vdmj.properties file, if any. Override with -D.
PROPDIR="$HOME/lib"

# Details for 64-bit Java
JAVA64="/usr/bin/java"
VM_OPTS="-Xmx3000m -Xss1m -Djava.rmi.server.hostname=localhost -Dcom.sun.management.jmxremote -Dmax.errors=1000"

function help()
{
    echo "Usage: $0 [--help|-?] [-P] [-A] <VM and VDMJ options>"
    echo "-P use high precision VDMJ"
    echo "-A use annotation libraries and options"
    echo "Default VM options are $JAVA64 $VM_OPTS"
    exit 0
}

function check()
{
    if [ ! -r "$1" ]
    then
	echo "Cannot read $1"
	exit 1
    fi
}

# Just warn if a later version is available in Maven
LATEST=$(ls $MAVENREPO/vdmj | grep "^[0-9].[0-9].[0-9]" | tail -1)

if [ "$MVERSION" != "$LATEST" ]
then
    echo "WARNING: Latest VDMJ version is $LATEST, not $MVERSION"
fi


# Chosen version defaults to "master"
VERSION=$MVERSION

if [ $# -eq 0 ]
then help
fi

# Process non-VDMJ options
while [ $# -gt 0 ]
do
    case "$1" in
	--help|-\?)
	    help
	    ;;
	-A)
	    ANNOTATIONS_VERSION=$VERSION
	    ;;
	-P)
	    VERSION=$PVERSION
	    ;;
	-D*|-X*)
	    VM_OPTS="$VM_OPTS $1"
	    ;;
	*)
	    VDMJ_OPTS="$VDMJ_OPTS $1"
    esac
    shift
done

# MAVENREPO/vdmlib/${VERSION}/vdmlib-${VERSION}.jar
# Locate the jars
VDMJ_JAR=$MAVENREPO/vdmj/${VERSION}/vdmj-${VERSION}.jar
STDLIB_JAR=$MAVENREPO/stdlib/${VERSION}/stdlib-${VERSION}.jar
PLUGINS_JAR=$MAVENREPO/cmd-plugins/${VERSION}/cmd-plugins-${VERSION}.jar
ISAPLUGIN_JAR=$MAVENREPO/vdm2isa/${VERSION}/vdm2isa-${VERSION}.jar
check "$VDMJ_JAR"
check "$STDLIB_JAR"
check "$PLUGINS_JAR"
check "$ISAPLUGIN_JAR"
CLASSPATH="$VDMJ_JAR:$PLUGINS_JAR:$STDLIB_JAR:$ISAPLUGIN_JAR:$PROPDIR"
#VDMJ_OPTS="-path $STDLIB_JAR $VDMJ_OPTS"
MAIN="com.fujitsu.vdmj.VDMJ"

#always keep them on for now 
#if [ $ANNOTATIONS_VERSION ]
#then
    ANNOTATIONS_JAR=$MAVENREPO/annotations/${VERSION}/annotations-${VERSION}.jar
    #check "$ANNOTATIONS_JAR"
    ANNOTATIONS2_JAR=$MAVENREPO/annotations2/${VERSION}/annotations2-${VERSION}.jar
    #check "$ANNOTATIONS2_JAR"
    VDM_TOOLKIT_ANNOTATIONS_JAR=$MAVENREPO/annotations3/${VERSION}/VDMToolkit_Annotations-${VERSION}.jar
    #check "$ANNOTATIONS3_JAR"
    VDMJ_OPTS="$VDMJ_OPTS -annotations"
    VM_OPTS="$VM_OPTS -Dannotations.debug"
    CLASSPATH="$CLASSPATH:$ANNOTATIONS_JAR:$ANNOTATIONS2_JAR:$VDM_TOOLKIT_ANNOTATIONS_JAR"
#fi

# The dialect is based on $0, so hard-link this file as vdmsl, vdmpp and vdmrt.
#DIALECT=$(basename $0)
DIALECT=vdmsl

# Keep rlwrap output in a separate folder
export RLWRAP_HOME=~/.vdmj

# Execute the JVM... and echo for Windows users help
#echo "$JAVA64 $VM_OPTS -cp $CLASSPATH $MAIN -$DIALECT $VDMJ_OPTS $@"
exec rlwrap "$JAVA64" $VM_OPTS -cp $CLASSPATH $MAIN -$DIALECT $VDMJ_OPTS "$@"
