#!/bin/bash
# Copy jars and set symlinks to Maven

if [ $# -ne 3 ]
then
    echo "setlinks.sh <VDM VSCode version> <VDMJ VDMJSUITE version> <VDM Toolkit VDMJSUITE version>"
    exit 1
fi

cd $HOME/.vscode
VERSION=$1
VDMJSUITE=$2
VDMTKSUITE=$3
echo "Set links for VDM VSCode $VERSION, VDMJ $VDMJSUITE, VDMToolkit $VDMTKSUITE"

if [ ! -e extensions/overturetool.vdm-vscode-$VERSION ]
then
    echo "Cannot find extensions/overturetool.vdm-vscode-$VERSION"
    exit 1
fi

RESOURCES="$HOME/.vscode/extensions/overturetool.vdm-vscode-$VERSION/resources"
# GROUPID="com/fujitsu"
GROUPID="dk/au/ece/vdmj"
VDMTOOLKIT="vdmtoolkit"
SNAPSHOT="-SNAPSHOT"
# SNAPSHOT=""

for DIR in jars/vdmj jars/vdmj_hp jars/plugins
do
    rm $RESOURCES/$DIR/vdmj*.jar
    rm $RESOURCES/$DIR/lsp*.jar
    rm $RESOURCES/$DIR/annotations*.jar
    rm $RESOURCES/$DIR/annotations2*.jar
	rm $RESOURCES/$DIR/vdm2isa*.jar 
    rm $RESOURCES/$DIR/libs/stdlib*.jar
	rm $RESOURCES/$DIR/libs/vdmlib*.jar 
    echo "Cleaned $RESOURCES/$DIR"
done

ln -sf $HOME/.m2/repository/$GROUPID/annotations/$VDMJSUITE-SNAPSHOT/annotations-$VDMJSUITE-SNAPSHOT.jar $RESOURCES/jars/vdmj 	#$RESOURCES/jars/vdmj/annotations-$VDMJSUITE-SNAPSHOT.jar
echo "Created annotations from $HOME/.m2/repository/$GROUPID/annotations/$VDMJSUITE-SNAPSHOT/annotations-$VDMJSUITE-SNAPSHOT.jar to $RESOURCES/jars/vdmj/annotations-$VDMJSUITE-SNAPSHOT.jar"
ln -sf $HOME/.m2/repository/$GROUPID/annotations2/$VDMJSUITE-SNAPSHOT/annotations2-$VDMJSUITE-SNAPSHOT.jar $RESOURCES/jars/vdmj # $RESOURCES/jars/vdmj/annotations2-$VDMJSUITE-SNAPSHOT.jar
ln -sf $HOME/.m2/repository/$GROUPID/vdmj/$VDMJSUITE-SNAPSHOT/vdmj-$VDMJSUITE-SNAPSHOT.jar $RESOURCES/jars/vdmj 				#$RESOURCES/jars/vdmj/vdmj-$VDMJSUITE-SNAPSHOT.jar
ln -sf $HOME/.m2/repository/$GROUPID/lsp/$VDMJSUITE-SNAPSHOT/lsp-$VDMJSUITE-SNAPSHOT.jar $RESOURCES/jars/vdmj 					#$RESOURCES/jars/vdmj/lsp-$VDMJSUITE-SNAPSHOT.jar
ln -sf $HOME/.m2/repository/$GROUPID/stdlib/$VDMJSUITE-SNAPSHOT/stdlib-$VDMJSUITE-SNAPSHOT.jar $RESOURCES/jars/vdmj/libs 		#$RESOURCES/jars/vdmj/libs/stdlib-$VDMJSUITE-SNAPSHOT.jar
echo "Created jars/vdmj links"

ln -sf $HOME/.m2/repository/$GROUPID/annotations/$VDMJSUITE-P-SNAPSHOT/annotations-$VDMJSUITE-P-SNAPSHOT.jar $RESOURCES/jars/vdmj_hp
ln -sf $HOME/.m2/repository/$GROUPID/annotations2/$VDMJSUITE-P-SNAPSHOT/annotations2-$VDMJSUITE-P-SNAPSHOT.jar $RESOURCES/jars/vdmj_hp
ln -sf $HOME/.m2/repository/$GROUPID/vdmj/$VDMJSUITE-P-SNAPSHOT/vdmj-$VDMJSUITE-P-SNAPSHOT.jar $RESOURCES/jars/vdmj_hp
ln -sf $HOME/.m2/repository/$GROUPID/lsp/$VDMJSUITE-P-SNAPSHOT/lsp-$VDMJSUITE-P-SNAPSHOT.jar $RESOURCES/jars/vdmj_hp
ln -sf $HOME/.m2/repository/$GROUPID/stdlib/$VDMJSUITE-P-SNAPSHOT/stdlib-$VDMJSUITE-P-SNAPSHOT.jar $RESOURCES/jars/vdmj_hp/libs
echo "Created jars/vdmj_hp links"

ln -sf $HOME/.m2/repository/$VDMTOOLKIT/annotationsVDMToolkit/$VDMTKSUITE-SNAPSHOT/annotationsVDMToolkit-$VDMTKSUITE-SNAPSHOT.jar $RESOURCES/jars/vdmj
ln -sf $HOME/.m2/repository/$VDMTOOLKIT/vdm2isa/$VDMTKSUITE-SNAPSHOT/vdm2isa-$VDMTKSUITE-SNAPSHOT.jar $RESOURCES/jars/plugins
ln -sf $HOME/.m2/repository/$VDMTOOLKIT/vdm2isa-lsp/$VDMTKSUITE-SNAPSHOT/vdm2isa-lsp-$VDMTKSUITE-SNAPSHOT.jar $RESOURCES/jars/plugins
ln -sf $HOME/.m2/repository/$VDMTOOLKIT/vdmlib/$VDMTKSUITE-SNAPSHOT/vdmlib-$VDMTKSUITE-SNAPSHOT.jar $RESOURCES/jars/vdmj/libs
echo "Created jars/vdmtoolkit links"

ln -sf $HOME/.m2/repository/$VDMTOOLKIT/vdmlib/$VDMTKSUITE-SNAPSHOT/vdmlib-$VDMTKSUITE-P-SNAPSHOT.jar $RESOURCES/jars/vdmj_hp/libs
echo "Created high precision vdmtoolkit vdmlib links"

echo "Done"
