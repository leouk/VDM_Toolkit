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
    echo "Cleaned $DIR"
done

ln -sf $HOME/.m2/repository/$GROUPID/annotations/$SUITE$SNAPSHOT/annotations-$SUITE$SNAPSHOT.jar $RESOURCES/jars/vdmj/annotations-$SUITE$SNAPSHOT.jar
echo "Created annotations from $HOME/.m2/repository/$GROUPID/annotations/$SUITE$SNAPSHOT/annotations-$SUITE$SNAPSHOT.jar to $RESOURCES/jars/vdmj/annotations-$SUITE$SNAPSHOT.jar"
ln -sf $HOME/.m2/repository/$GROUPID/annotations2/$SUITE$SNAPSHOT/annotations2-$SUITE$SNAPSHOT.jar $RESOURCES/jars/vdmj/annotations2-$SUITE$SNAPSHOT.jar
ln -sf $HOME/.m2/repository/$GROUPID/vdmj/$SUITE$SNAPSHOT/vdmj-$SUITE$SNAPSHOT.jar $RESOURCES/jars/vdmj/vdmj-$SUITE$SNAPSHOT.jar
ln -sf $HOME/.m2/repository/$GROUPID/lsp/$SUITE$SNAPSHOT/lsp-$SUITE$SNAPSHOT.jar $RESOURCES/jars/vdmj/lsp-$SUITE$SNAPSHOT.jar
ln -sf $HOME/.m2/repository/$GROUPID/stdlib/$SUITE$SNAPSHOT/stdlib-$SUITE$SNAPSHOT.jar $RESOURCES/jars/vdmj/libs/stdlib-$SUITE$SNAPSHOT.jar
echo "Created jars/vdmj links"

ln -sf $HOME/.m2/repository/$GROUPID/annotations/$SUITE-P$SNAPSHOT/annotations-$SUITE-P$SNAPSHOT.jar $RESOURCES/jars/vdmj_hp
ln -sf $HOME/.m2/repository/$GROUPID/annotations2/$SUITE-P$SNAPSHOT/annotations2-$SUITE-P$SNAPSHOT.jar $RESOURCES/jars/vdmj_hp
ln -sf $HOME/.m2/repository/$GROUPID/vdmj/$SUITE-P$SNAPSHOT/vdmj-$SUITE-P$SNAPSHOT.jar $RESOURCES/jars/vdmj_hp
ln -sf $HOME/.m2/repository/$GROUPID/lsp/$SUITE-P$SNAPSHOT/lsp-$SUITE-P$SNAPSHOT.jar $RESOURCES/jars/vdmj_hp
ln -sf $HOME/.m2/repository/$GROUPID/stdlib/$SUITE-P$SNAPSHOT/stdlib-$SUITE-P$SNAPSHOT.jar $RESOURCES/jars/vdmj_hp/libs
echo "Created jars/vdmj_hp links"

ln -sf $HOME/.m2/repository/$VDMTOOLKIT/annotationsVDMToolkit/$SUITE-SNAPSHOT/annotationsVDMToolkit-$SUITE$SNAPSHOT.jar $RESOURCES/jars/vdmj
ln -sf $HOME/.m2/repository/$VDMTOOLKIT/vdm2isa/$SUITE$SNAPSHOT/vdm2isa-$SUITE$SNAPSHOT.jar $RESOURCES/jars/plugins
ln -sf $HOME/.m2/repository/$VDMTOOLKIT/vdmlib/$SUITE$SNAPSHOT/vdmlib-$SUITE$SNAPSHOT.jar $RESOURCES/jars/vdmj/libs
echo "Created jars/vdmtoolkit links"

ln -sf $HOME/.m2/repository/$VDMTOOLKIT/vdmlib/$SUITE$SNAPSHOT/vdmlib-$SUITE-P$SNAPSHOT.jar $RESOURCES/jars/vdmj_hp/libs
echo "Created high precision vdmtoolkit vdmlib links"

echo "Done"
