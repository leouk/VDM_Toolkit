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

if [ ! -e extensions/jonaskrask.vdm-vscode-$VERSION ]
then
    echo "Cannot find extensions/jonaskrask.vdm-vscode-$VERSION"
    exit 1
fi

RESOURCES=extensions/jonaskrask.vdm-vscode-$VERSION/resources

for DIR in jars jars_highPrecision
do
    if [ ! -e $RESOURCES/$DIR/saved ]
    then
	mkdir $RESOURCES/$DIR/saved
	mv $RESOURCES/$DIR/vdmj*.jar $RESOURCES/$DIR/lsp*.jar $RESOURCES/$DIR/annotations*.jar $RESOURCES/$DIR/saved
	echo "Saved $DIR"
    else
	echo "Jars already saved, cleaning $DIR..."
	rm $RESOURCES/$DIR/vdmj*.jar $RESOURCES/$DIR/lsp*.jar $RESOURCES/$DIR/annotations*.jar
    fi
done

ln -sf $HOME/.m2/repository/com/fujitsu/annotations/$SUITE-SNAPSHOT/annotations-$SUITE-SNAPSHOT.jar $RESOURCES/jars
ln -sf $HOME/.m2/repository/com/fujitsu/vdmj/$SUITE-SNAPSHOT/vdmj-$SUITE-SNAPSHOT.jar $RESOURCES/jars
ln -sf $HOME/.m2/repository/com/fujitsu/lsp/$SUITE-SNAPSHOT/lsp-$SUITE-SNAPSHOT.jar $RESOURCES/jars
echo "Created jar links"

ln -sf $HOME/.m2/repository/com/fujitsu/annotations/$SUITE-P-SNAPSHOT/annotations-$SUITE-P-SNAPSHOT.jar $RESOURCES/jars_highPrecision
ln -sf $HOME/.m2/repository/com/fujitsu/vdmj/$SUITE-P-SNAPSHOT/vdmj-$SUITE-P-SNAPSHOT.jar $RESOURCES/jars_highPrecision
ln -sf $HOME/.m2/repository/com/fujitsu/lsp/$SUITE-P-SNAPSHOT/lsp-$SUITE-P-SNAPSHOT.jar $RESOURCES/jars_highPrecision
echo "Created high precision links"

echo "Done"
