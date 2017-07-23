#! /bin/sh

M=`ibus engine`
if [ ${M} = "xkb:us::eng" ] ; then
    ibus engine mozc-jp
else
    ibus engine xkb:us::eng
fi
