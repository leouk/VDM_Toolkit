#!/bin/sh
echo $1
java -Xmx2048m -jar "/Users/nljsf/Local/tools/Overture-2.0.0/vdmj-3.0.1.jar" -vdmsl -r vdm10 ./WhyMTest.vdmsl ./WhyM.vdmsl ./WhyMIds.vdmsl ./WhyMUtil.vdmsl ./lib/IO.vdmsl ./lib/VDMUtil.vdmsl