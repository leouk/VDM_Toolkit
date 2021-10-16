#!/bin/bash

#
# Rebuild and installs VDMJ with new jars
#

# Assuming:
# 0. symbolic link vdmj_build into /usr/local/bin first
# 1. $VDMJ_HOME and $VDMJ_VERSION is set

if [ ! -e $VDMJ_HOME ]
then
	# should be where the VDMJ git root is
    echo "Cannot find VDMJ HOME $VDMJ_HOME"
    exit 1
fi

if [ -z "$VDMJ_VERSION" ]
then
	# should be VDMJ_VERSION=X.Y.Z-SNAPSHOT
    echo "Variable VDMJ_VERSION not set; should be X.Y.Z-SNAPSHOT"
    exit 1
fi

if [ ! -e $VDMJ_TARGET ]
then
    echo "Setting VDMJ linking target to /usr/local/lib"
    exit 1
fi

echo "Pull latest version of VDMJ from $VDMJ_HOME"
cd $VDMJ_HOME
git pull

echo "Building VDMJ $VDMJ_VERSION from $VDMJ_HOME"

function latest()
{
    ls -t $1 | head -1
}

HERE=$(pwd)
VERSION=$VDMJ_VERSION
VDMJ_TARGET=/usr/local/lib

# You must make sure you are at VDMJ_HOME first (e.g. top-level VDMJ repo directory)
mvn clean install

#echo "Linking VDMJ $VDMJ_VERSION to $VDMJ_TARGET"
#ln -snf $(latest "${HERE}/Annotations/target/annotations-${VERSION}-??????.jar") ${VDMJ_TARGET}/annotations-${VERSION}.jar
#ln -snf $(latest "${HERE}/Annotations2/target/annotations2-${VERSION}-??????.jar") ${VDMJ_TARGET}/annotations2-${VERSION}.jar
#ln -snf $(latest "${HERE}/cmd-plugins/target/cmd-plugins-${VERSION}-??????.jar") ${VDMJ_TARGET}/cmd-plugins-${VERSION}.jar
#ln -snf $(latest "${HERE}/vdmj/target/vdmj-${VERSION}-??????.jar") ${VDMJ_TARGET}/vdmj-${VERSION}.jar

echo "Pull latest version of VDM Toolkit from $VDMJTK_HOME"

cd $VDMJTK_HOME 
git pull

#@TODO make these into POM packaging files?
cd $VDMJTK_HOME/annotations/Annotations3
mvn clean install

cd $VDMJTK_HOME/annotations/witness
mvn clean install

cd $VDMJTK_HOME/plugins/vdm2isa/java
mvn clean install

vdmj -v

exit 0

