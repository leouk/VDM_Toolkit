#!/bin/bash

#
# Rebuild and installs VDMJ with new jars
#

# Assuming:
# 0. symbolic link vdmj_build into /usr/local/bin first
# 1. cd $VDMJ_HOME

function latest()
{
    ls -t $1 | head -1
}

HERE=$(pwd)
VERSION=4.4.3-SNAPSHOT
VDMJ_TARGET=/usr/local/lib

# You must make sure you are at VDMJ_HOME first (e.g. top-level VDMJ repo directory)
mvn clean install
ln -snf $(latest "${HERE}/Annotations/target/annotations-${VERSION}-??????.jar") ${VDMJ_TARGET}/annotations-${VERSION}.jar
ln -snf $(latest "${HERE}/Annotations2/target/annotations2-${VERSION}-??????.jar") ${VDMJ_TARGET}/annotations2-${VERSION}.jar
ln -snf $(latest "${HERE}/cmd-plugins/target/cmd-plugins-${VERSION}-??????.jar") ${VDMJ_TARGET}/cmd-plugins-${VERSION}.jar
ln -snf $(latest "${HERE}/vdmj/target/vdmj-${VERSION}-??????.jar") ${VDMJ_TARGET}/vdmj-${VERSION}.jar

vdmj -v

exit 0

