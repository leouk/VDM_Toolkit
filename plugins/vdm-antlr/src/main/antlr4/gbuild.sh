#!/bin/bash

# delete previous builds
echo 'Removing out generated grammars'
rm -R ./.antlr/output

	# alias antlr4='java -Xmx500M -cp /usr/local/lib/antlr4-4.11.1-complete.jar:$CLASSPATH org.antlr.v4.Tool' 
	# alias grun='java -Xmx500M -cp /usr/local/lib/antlr4-4.11.1-complete.jar:$CLASSPATH org.antlr.v4.gui.TestRig'

# set java11
echo 'Setup Java 11'
OLD_JAVA_HOME=$JAVA_HOME
export JAVA_HOME=$(/usr/libexec/java_home -v11)

# presumes ANTLR is somewhere sensible 
#TODO generalise to find in Maven Repo or download or etc. 

ANTLR4=/usr/local/lib/antlr4-4.11.1-complete.jar
VDMJ=~/.m2/repository/dk/au/ece/vdmj/vdmj/4.5.0-SNAPSHOT/vdmj-4.5.0-SNAPSHOT.jar
CP="$ANTLR4:$VDMJ:$CLASSPATH"

# call ANTLR to generate parser
# antlr4 VDM.g4 VDMLex.g4 -listener -visitor -Xlog -atn -o ./.antlr/output
echo 'Calling ANTLR4 parser generator' #' with CP ' $CP
# -package vdmantlr
java -Xmx500M -cp $CP org.antlr.v4.Tool VDM.g4 VDMLex.g4 -listener -visitor -atn -o ./.antlr/output

# compile generated files
#echo 'Compiling generarted parser'
#javac ./.antlr/output/*.java

#source gtest.sh "$@"
#TODO allow starting in inner rules beyond sl_document?
#TODO grun has to be on the same directory as VDM.class from VDM.g4->VDM.java generated above, hence the "../$@" :-(
#grun VDM sl_document -tree -gui "$@"
# echo 'Calling ANTLR grun test rig'
# cd output

# START_PRODUCTION=sl_document
# if [[ "$#" -gt 1 ]]; then
#     START_PRODUCTION=$1
# fi
# echo 'Parsing from ' $START_PRODUCTION ' for file ' "${@:2}"
# java -Xmx500M -cp /usr/local/lib/antlr4-4.11.1-complete.jar:$CLASSPATH org.antlr.v4.gui.TestRig VDM $START_PRODUCTION -tree -gui ../"${@:2}"

# echo 'Restoring default java version'
# cd ..
# export JAVA_HOME=$OLD_JAVA_HOME

#echo 'Done'