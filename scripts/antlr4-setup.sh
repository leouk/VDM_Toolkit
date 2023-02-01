#!/bin/bash
##########################
##### ANTLR setup #####
##########################

# These require Java11 to work. so before calling them call java11 first! 

export CLASSPATH=.:/usr/local/lib/antlr4-4.11.1-complete.jar:$CLASSPATH
alias antlr4='java -Xmx500M -cp /usr/local/lib/antlr4-4.11.1-complete.jar:$CLASSPATH org.antlr.v4.Tool' 
alias grun='java -Xmx500M -cp /usr/local/lib/antlr4-4.11.1-complete.jar:$CLASSPATH org.antlr.v4.gui.TestRig'
