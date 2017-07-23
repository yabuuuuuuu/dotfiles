#!/bin/sh
 
MARKDOWN_SRC='Markdown_1.0.1'
UNZIP=`which unzip`
WGET=`which wget`
PATCH=`which patch`
 
$WGET "http://daringfireball.net/projects/downloads/$MARKDOWN_SRC.zip"
$UNZIP "$MARKDOWN_SRC.zip"
 
cd $MARKDOWN_SRC
 
$WGET "http://www.sera.desuyo.net/komono/Markdown_1.0.2b8-extra.patch"
$PATCH -p0 < Markdown_1.0.2b8-extra.patch
