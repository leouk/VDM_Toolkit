#!/bin/bash

#
# Set VDMJ environment variables and installs VDMJ with new jars
#

if [ $# -ne 2 ]
then
    echo "vdmj_env.sh <VDMJ GitHub HOME> <VDMJ suite version X.Y.Z>"
    exit 1
fi

VDMJ_HOME=$1
VDMJ_VERSION=$2-SNAPSHOT
VDMJ_TARGET=/usr/local/lib

if [ ! -e $VDMJ_HOME ]
then
	# should be where the VDMJ git root is
    echo "Cannot find VDMJ HOME $VDMJ_HOME"
    exit 1
fi

if [ -z "$VDMJ_VERSION" ]
then
	# should be VDMJ_VERSION=X.Y.Z-SNAPSHOT
    echo "Variable VDMJ_VERSION not set; should be X.Y.Z"
    exit 1
fi

if [ ! -e $VDMJ_TARGET ]
then
    echo "Setting VDMJ linking target to /usr/local/lib"
    VDMJ_TARGET=/usr/local/lib
fi



exit 0

