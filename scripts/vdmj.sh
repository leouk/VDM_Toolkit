#!/bin/bash

# * Calls latest VDMJ build (see vdmj_build.sh) with corresponding annotations and parameters
# * Presumes rlwrap (i.e. indexed commands within VDMJ protmpt) is installed (i.e. brew install rlwrap) 

if [ -z "$VDMJ_VERSION" ]
then
	# should be VDMJ_VERSION=X.Y.Z-SNAPSHOT
    echo "Variable VDMJ_VERSION not set; should be X.Y.Z-SNAPSHOT"
    exit 1
fi

BASE=`dirname $0`
VERSION=$VDMJ_VERSION
NAME=vdmj
CMDS=cmd-plugins

JAR=/usr/local/lib/${NAME}-${VERSION}.jar
PLUGINS=/usr/local/lib/${CMDS}-${VERSION}.jar
#VDM2ISA=/usr/local/lib/v2c-0.0.1-SNAPSHOT.jar
VDM2ISA=/usr/local/lib/vdm2isa-0.0.1-SNAPSHOT.jar
ANNOTATIONS=/usr/local/lib/annotations-${VERSION}.jar:/usr/local/lib/annotations2-${VERSION}.jar:/usr/local/lib/witness-1.0.0.jar:/usr/local/lib/annotations3-${VERSION}.jar

export CLASSPATH="$CLASSPATH:${ANNOTATIONS}"

if [ ! -f ${JAR} ]; then
    echo -e "Executable jar: \n\n${JAR}\n\ndoes not exist.  It must be in /usr/local/lib."
    exit -1;
fi

#java -cp ${ANNOTATIONS} -jar -Dmax.errors=1000 ${JAR} $@
rlwrap java -cp ${ANNOTATIONS}:${JAR}:${PLUGINS}:${VDM2ISA} -Dmax.errors=1000 com.fujitsu.vdmj.VDMJ -vdmsl -strict -annotations $@
