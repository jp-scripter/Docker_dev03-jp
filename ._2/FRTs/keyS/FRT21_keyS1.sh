#!/bin/sh
#  keyS Launcher (Prod Copy)

        FRT_Scr=FRT21_keyS1_p2.01.sh

        FRT_Dir=$( realpath "$0" ); FRT_Dir=$( dirname "${FRT_Dir}" )
        FRT1_Main1=$FRT_Dir/$FRT_Scr

      "$FRT1_Main1" "$@"

