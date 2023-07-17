#!/bin/sh
#   RSS Info (Prod Copy)

#       RSS_Scr=RSS22-Info_v0.7.80923.sh
#       RSS_Scr=RSS22-Info_p0.08.81014.sh
#       RSS_Scr=RSS22_Info_p0.08.sh
        RSS_Scr=RSS23_Info_p0.09.sh

        RSS_Dir=$( realpath "$0" ); RSS_Dir=$( dirname "${RSS_Dir}" )
        RSS22_Info=$RSS_Dir/$RSS_Scr

      "$RSS22_Info" "$@"

