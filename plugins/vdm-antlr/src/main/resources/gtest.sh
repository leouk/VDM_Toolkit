#!/bin/bash

# set java11
echo 'Setup Java 11'
OLD_JAVA_HOME=$JAVA_HOME
export JAVA_HOME=$(/usr/libexec/java_home -v11)

#TODO allow starting in inner rules beyond sl_document?
#TODO grun has to be on the same directory as VDM.class from VDM.g4->VDM.java generated above, hence the "../$@" :-(
#grun VDM sl_document -tree -gui "$@"
echo 'Calling ANTLR grun test rig'
cd output

START_PRODUCTION=sl_document
if [[ "$#" -gt 1 ]]; then
    START_PRODUCTION=$1
    # gets the second arguments onwards
    FILES=../"${@:2}"   
else 
    # gets all arguments
    FILES=../"${@}"
fi
echo 'Parsing from ' $START_PRODUCTION ' for file ' $FILES
java -Xmx500M -cp /usr/local/lib/antlr4-4.11.1-complete.jar:$CLASSPATH org.antlr.v4.gui.TestRig VDM $START_PRODUCTION -tree -gui $FILES

echo 'Restoring default java version'
cd ..
export JAVA_HOME=$OLD_JAVA_HOME

echo 'Done'