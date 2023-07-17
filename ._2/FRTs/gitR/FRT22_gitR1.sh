#!/bin/sh
#  gitR Launcher (Prod Copy)

        FRT_Scr=FRT22_gitR1_p2.05.sh

        FRT_Dir=$( realpath "$0" ); FRT_Dir=$( dirname "${FRT_Dir}" )
        FRT1_Main1=$FRT_Dir/$FRT_Scr

      "$FRT1_Main1" "$@"

