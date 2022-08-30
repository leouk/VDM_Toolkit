#!/bin/bash
# Copy jars and set symlinks to Maven

if [ $# -ne 2 ]
then
    echo "setlinks.sh <VDM VSCode version> <VDMJ suite version>"
    exit 1
fi

cd $HOME/.vscode
VERSION=$1
SUITE=$2
# The Maven repository directory containing VDMJ and VDM_Toolkit jars
VDMJMAVENREPO=~/.m2/repository/dk/au/ece/vdmj
VDMTOOLKITMAVENREPO=~/.m2/repository/vdmtoolkit


if [ ! -e extensions/overturetool.vdm-vscode-$VERSION ]
then
    echo "Cannot find extensions/overturetool.vdm-vscode-$VERSION"
    exit 1
fi

RESOURCES=extensions/overturetool.vdm-vscode-$VERSION/resources

for DIR in jars/vdmj jars/vdmj_hp jars/plugins
do
	#Deleting only, to avoid including jars twice and confusing VSCode ? Will mean unsetlikns won't directly work
    #if [ ! -e $RESOURCES/$DIR/saved ]
    #then
	#mkdir $RESOURCES/$DIR/saved
	#mv $RESOURCES/$DIR/vdmj*.jar $RESOURCES/$DIR/lsp*.jar $RESOURCES/$DIR/annotations*.jar $RESOURCES/$DIR/saved
	#echo "Saved $DIR"
    #else
	echo "Jars already saved, cleaning $DIR..."
	rm $RESOURCES/$DIR/vdmj*.jar 
	rm $RESOURCES/$DIR/lsp*.jar 
	rm $RESOURCES/$DIR/annotations*.jar 
	rm $RESOURCES/$DIR/libs/stdlib*.jar 
	rm $RESOURCES/$DIR/vdm2isa*.jar 
	rm $RESOURCES/$DIR/libs/vdmlib*.jar 
    #fi
done

ln -sf $VDMJMAVENREPO/annotations/$SUITE-SNAPSHOT/annotations-$SUITE-SNAPSHOT.jar $RESOURCES/jars/vdmj
ln -sf $VDMJMAVENREPO/annotations2/$SUITE-SNAPSHOT/annotations2-$SUITE-SNAPSHOT.jar $RESOURCES/jars/vdmj
ln -sf $VDMJMAVENREPO/vdmj/$SUITE-SNAPSHOT/vdmj-$SUITE-SNAPSHOT.jar $RESOURCES/jars/vdmj
ln -sf $VDMJMAVENREPO/lsp/$SUITE-SNAPSHOT/lsp-$SUITE-SNAPSHOT.jar $RESOURCES/jars/vdmj
ln -sf $VDMJMAVENREPO/stdlib/$SUITE-SNAPSHOT/stdlib-$SUITE-SNAPSHOT.jar $RESOURCES/jars/vdmj/libs

ln -sf $VDMTOOLKITMAVENREPO/vdmtoolkit/annotationsVDMToolkit/$SUITE-SNAPSHOT/annotationsVDMToolkit-$SUITE-SNAPSHOT.jar $RESOURCES/jars/vdmj
ln -sf $VDMTOOLKITMAVENREPO/vdmtoolkit/vdm2isa/$SUITE-SNAPSHOT/vdm2isa-$SUITE-SNAPSHOT.jar $RESOURCES/jars/plugins
ln -sf $VDMTOOLKITMAVENREPO/vdmtoolkit/vdmlib/$SUITE-SNAPSHOT/vdmlib-$SUITE-SNAPSHOT.jar $RESOURCES/jars/vdmj/libs
echo "Created jar links"

ln -sf $VDMJMAVENREPO/annotations/$SUITE-P-SNAPSHOT/annotations-$SUITE-P-SNAPSHOT.jar $RESOURCES/jars/vdmj_hp
ln -sf $VDMJMAVENREPO/annotations2/$SUITE-P-SNAPSHOT/annotations2-$SUITE-P-SNAPSHOT.jar $RESOURCES/jars/vdmj_hp
ln -sf $VDMJMAVENREPO/vdmj/$SUITE-P-SNAPSHOT/vdmj-$SUITE-P-SNAPSHOT.jar $RESOURCES/jars/vdmj_hp
ln -sf $VDMJMAVENREPO/lsp/$SUITE-P-SNAPSHOT/lsp-$SUITE-P-SNAPSHOT.jar $RESOURCES/jars/vdmj_hp
ln -sf $VDMJMAVENREPO/stdlib/$SUITE-P-SNAPSHOT/stdlib-$SUITE-P-SNAPSHOT.jar $RESOURCES/jars/vdmj_hp/libs

ln -sf $VDMTOOLKITMAVENREPO/vdmtoolkit/vdmlib/$SUITE-SNAPSHOT/vdmlib-$SUITE-P-SNAPSHOT.jar $RESOURCES/jars/vdmj_hp/libs
echo "Created high precision links"

echo "Done"
