#!/bin/sh
#  RSS Dir Lister (Prod Copy)

#  RSS_Scr=RSS22-DirList_v1.2.81007.sh
#  RSS_Scr=RSS22-DirList_v1.2.90315.sh
#  RSS_Scr=RSS22_DirList_p1.03.sh
   RSS_Scr=RSS22_DirList_p1.04.sh

#  RSS_Dir=$( dirname  "$0" )
   RSS_Dir=$( realpath "$0" ); RSS_Dir=$( dirname "${RSS_Dir}" )

 "$RSS_Dir/$RSS_Scr" "$@"

