#!/bin/bash
#
# Rebuild and installs VDMJ with new jars
#

function latest()
{
    ls -t $1 | head -1
}

HERE=$(pwd)
VERSION=4.4.0-SNAPSHOT
VDMJ_TARGET=/usr/local/lib

mvn clean install
ln -snf $(latest "${HERE}/target/annotations3-${VERSION}-??????.jar") ${VDMJ_TARGET}/annotations3-${VERSION}.jar

vdmj -i MinimalTime.vdmsl

