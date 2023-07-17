#!/bin/sh
#  FRTools Launch Script on rm212p-w10p

    FRT_Dir=$( realpath "$0" ); FRT_Dir=$( dirname ${FRT_Dir} )

#   aCmd="${FRT_Dir}/FRT10_frt_u1.01\`20404.sh"
#   aCmd="${FRT_Dir}/FRT10_frt_u1.02\`20405-1739.sh"
#   aCmd="${FRT_Dir}/FRT10_frt_u1.03.sh"
#   aCmd="${FRT_Dir}/FRT10_frt_p1.04.sh"
#   aCmd="${FRT_Dir}/FRT10_frt_p1.06.sh"
#   aCmd="${FRT_Dir}/FRT10_Main0_p1.06.sh"
#   aCmd="${FRT_Dir}/FRT10_Main0_u1.07.sh"
#   aCmd="${FRT_Dir}/FRT10_Main0_p1.08.sh"
    aCmd="${FRT_Dir}/FRT10_Main0_p1.09.sh"   #.(30716.01 RAM)

 "${aCmd}" "$@"

