#!/bin/sh
#  RSS File Lister (Prod Copy)

#       RSS_Scr=RSS21-FileList_v1.5.80923.sh
#       RSS_Scr=RSS21-FileList_v1.5.81005.sh
#       RSS_Scr=RSS21-FileList_v1.5.90401.sh
#       RSS_Scr=RSS21-FileList_v1.6.10707.sh
#       RSS_Scr=RSS21-FileList_v1.7.10826.sh
#       RSS_Scr=RSS21-FileList_v1.7.10923.sh
        RSS_Scr=RSS21_FileList_p1.07.sh

#       RSS_Dir=$( dirname  "$0" )
        RSS_Dir=$( realpath "$0" ); RSS_Dir=$( dirname "${RSS_Dir}" )
        RSS21_FileList=$RSS_Dir/$RSS_Scr

      "$RSS21_FileList" "$@"

