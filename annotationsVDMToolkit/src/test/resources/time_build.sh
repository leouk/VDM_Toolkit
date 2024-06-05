#!/bin/bash
#
# Rebuild and installs VDMJ with new jars
#

function latest()
{
    ls -t $1 | head -1
}

HERE=$(pwd)
VERSION=4.4.4-SNAPSHOT
VDMJ_TARGET=/usr/local/lib

mvn clean install
ln -snf $(latest "${HERE}/target/annotations3-${VERSION}-??????.jar") ${VDMJ_TARGET}/annotations3-${VERSION}.jar

echo "Play with time - inner calls"
vdmj -i -e "f(3,4)" MinimalTime.vdmsl
echo "Play with time - just time summary"
vdmj -i -e "g(3,4)" MinimalTime.vdmsl