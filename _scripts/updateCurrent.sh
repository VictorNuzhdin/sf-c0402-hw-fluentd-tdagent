#!/bin/bash

DEST=current
SRC=tests
PREFIX=test
VERSION_ARG=''


##--STEP0: Setting local variable from script Versiion Argument (set default version if arg is not set)
if [[ $1 == "" ]]
then
  VERSION_ARG=00
fi
if [[ $1 != "" ]]
then
  VERSION_ARG=$1
fi

clear
#echo $VERSION_ARG
#exit


echo "--STEP1: Checking CURRENT Directory and verion.."
tail -n 1 $DEST/README.md
ls $DEST
echo

echo "--STEP2: Clear CURRENT Directory.."
rm -rf $DEST/*
#echo

echo "--STEP3: Copying LAST code version to CURRENT directory.."
#       example: tests/test10/* -> current/
cp -r $SRC/$PREFIX$VERSION_ARG/* $DEST/
echo

echo "--STEP4: Checking CURRENT code version from README.."
tail -n 1 current/README.md
ls $DEST

echo
echo
