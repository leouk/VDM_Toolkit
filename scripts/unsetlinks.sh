#!/bin/bash
# Copy standard jars back into resources

if [ $# -ne 1 ]
then
    echo "unsetlinks.sh <VDM VSCode version>"
    exit 1
fi

cd $HOME/.vscode
VERSION=$1

if [ ! -e extensions/overturetool.vdm-vscode-$VERSION ]
then
    echo "Cannot find extensions/overturetool.vdm-vscode-$VERSION"
    exit 1
fi

RESOURCES=extensions/overturetool.vdm-vscode-$VERSION/resources

for DIR in jars 
do
    if [ ! -e $RESOURCES/$DIR/saved ]
    then
	echo "Cannot find $RESOURCES/$DIR/saved"
    else
	rm $RESOURCES/$DIR/vdmj*.jar $RESOURCES/$DIR/lsp*.jar $RESOURCES/$DIR/annotations*.jar
	cp $RESOURCES/$DIR/saved/*.jar $RESOURCES/$DIR
	echo "Restored $DIR"
    fi
done

echo "Done"
