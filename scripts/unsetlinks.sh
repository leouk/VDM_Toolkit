#!/bin/bash
# Copy standard jars back into resources

if [ $# -ne 1 ]
then
    echo "unsetlinks.sh <VDM VSCode version>"
    exit 1
fi

cd $HOME/.vscode
VERSION=$1

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
	echo "Cannot find $RESOURCES/$DIR/saved"
    else
	rm $RESOURCES/$DIR/*.jar
	cp $RESOURCES/$DIR/saved/*.jar $RESOURCES/$DIR
	echo "Restored $DIR"
    fi
done

echo "Done"
