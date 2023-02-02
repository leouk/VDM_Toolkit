#!/bin/bash

# delete previous builds
rm -R output

	# alias antlr4='java -Xmx500M -cp /usr/local/lib/antlr4-4.11.1-complete.jar:$CLASSPATH org.antlr.v4.Tool' 
	# alias grun='java -Xmx500M -cp /usr/local/lib/antlr4-4.11.1-complete.jar:$CLASSPATH org.antlr.v4.gui.TestRig'

# set java11
OLD_JAVA_HOME=$JAVA_HOME
export JAVA_HOME=$(/usr/libexec/java_home -v11)

# presumes ANTLR is somewhere sensible 
#TODO generalise to find in Maven Repo or download or etc. 

# call ANTLR to generate parser
# antlr4 VDM.g4 VDMLex.g4 -listener -visitor -Xlog -atn -o ./output
java -Xmx500M -cp /usr/local/lib/antlr4-4.11.1-complete.jar:$CLASSPATH org.antlr.v4.Tool VDM.g4 VDMLex.g4 -listener -visitor -Xlog -atn -o ./output

# compile output files
javac ./output/*.java

#TODO allow starting in inner rules beyond sl_document?
#TODO grun has to be on the same directory as VDM.class from VDM.g4->VDM.java generated above, hence the "../$@" :-(
#grun VDM sl_document -tree -gui "$@"
cd output
java -Xmx500M -cp /usr/local/lib/antlr4-4.11.1-complete.jar:$CLASSPATH org.antlr.v4.gui.TestRig VDM sl_document -tree -gui ../"$@"
