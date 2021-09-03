#!/bin/sh

if [ -z "$1" ]
then
	echo "Missing argument" 1>&2
	exit 1
fi

NEW=$1
VAR=`echo $NEW | sed "s/^\([^.]*\).*/\1/"`
OLD=`grep -o "^$VAR := .*$" -- early-plugins.mk | sed 's/.* \([a-zA-Z0-9.-]*$\)$/\1/'`

echo Variable: $VAR
echo Old version: $OLD
echo New version: $NEW

sed "s/\(^$VAR :=.*\) [a-zA-Z0-9.-]*$/\1 $NEW/" -- early-plugins.mk > early-plugins.1.tmp
sed "/^$VAR-DROPPED := .*\\\\$/ { : again; /\\\\$/ { N; b again }; s/$/ $OLD/ }" -- early-plugins.1.tmp > early-plugins.2.tmp

rm early-plugins.1.tmp
mv early-plugins.2.tmp early-plugins.mk
wget https://erlang.org/download/$NEW.README -O release-notes/$NEW.README.txt

git add early-plugins.mk release-notes/$NEW.README.txt
git diff --cached
echo Press Enter to commit and push, Ctrl+C to abort, Ctrl+Z to pause
read

git commit -m "$NEW"
git push upstream master
