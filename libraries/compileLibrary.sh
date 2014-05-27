#!/usr/bin/bash -x
processingCore=/usr/share/processing/core/library/core.jar;
gifAniCore=$(pwd)/gifAnimation/library/gifAnimation.jar;

cd $1
javac -d class -cp $processingCore:$gifAniCore src/*.java
cd class
jar cf ../library/$1.jar $1

