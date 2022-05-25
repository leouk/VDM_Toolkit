#!/bin/bash

filepath=$VDMJTK_HOME/scripts/vdmj.sh
filepath_build=$VDMJTK_HOME/scripts/vdmj_build.sh

sudo rm -f /usr/local/bin/vdmj 
sudo rm -f /usr/local/bin/vdmj_build
sudo ln -s $filepath /usr/local/bin/vdmj 
sudo ln -s $filepath_build /usr/local/bin/vdmj_build
