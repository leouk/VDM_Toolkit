#!/bin/bash
while true 
do 
   ps -ef | grep lsp.LSPServer | grep -v grep 
done