#!/bin/bash
#*\
##=========+====================+================================================+
##RD         Main0              | FormR Tools
##RFILE    +====================+=======+===============+======+=================+
##FD   FRT10_Main0.sh           |   9479|  4/29/22 14:48|   136| v1.05.20429.1448
##FD   FRT10_Main0.sh           |  28713|  5/03/22 13:12|   536| p1.06-20503-1312
##FD   FRT10_Main0.sh           |  29813|  5/03/22 14:53|   558| p1.06-20503-1453
##FD   FRT10_Main0.sh           |  32740|  5/04/22 19:24|   967| p1.06-20504-1924
##FD   FRT10_Main0.sh           |  22585|  5/08/22 16:17|   810| p1.06-20508-1617
##FD   FRT10_Main0.sh           |  22845|  5/09/22 07:04|   813| p1.06-20509-0704
##FD   FRT10_Main0.sh           |  23513|  5/15/22 13:04|   825| p1.06-20515-1304
##FD   FRT10_Main0.sh           |  24121|  6/01/22 08:30|   830| u1.07-20601-0830
##FD   FRT10_Main0.sh           |  24278|  6/01/22 11:15|   830| u1.07-20601-1115
##FD   FRT10_Main0.sh           |  24934|  6/01/22 18:29|   838| u1.07-20601-1829
##FD   FRT10_Main0.sh           |  19714|  6/20/22 10:50|   316| u1.08-20620-1050
##FD   FRT10_Main0.sh           |  21741|  6/20/22 21:54|   351| u1.08-20620-2154
##FD   FRT10_Main0.sh           |  22602| 10/27/22 10:59|   358| u1.08-21027-1059
##FD   FRT10_Main0.sh           |  22912| 11/03/22 15:15|   361| p1.08-21103-1515
##FD   FRT10_Main0.sh           |  23981| 11/19/22 19:22|   385| p1.08-21119.1922
##FD   FRT10_Main0.sh           |  24904| 11/20/22 13:55|   392| p1.08-21120.1355
##FD   FRT10_Main0.sh           |  28576| 11/22/22 09:38|   462| p1.08-21122.0938
##FD   FRT10_Main0.sh           |  30525| 11/27/22 19:40|   483| p1.08-21127.1940
##FD   FRT10_Main0.sh           |  32372| 11/28/22 08:15|   513| p1.08-21128.0815
##FD   FRT10_Main0.sh           |  33564| 11/29/22 21:07|   519| p1.08-21129.2107
##FD   FRT10_Main0.sh           |  33368| 11/30/22 11:39|   522| p1.08-21130.1139
##FD   FRT10_Main0.sh           |  37882|  7/16/23 11:12|   577| p1.09-30716.1122
##DESC     .--------------------+-------+---------------+------+-----------------+
#            Use the commands in this script to manage FormR app resources.
#
#
##LIC      .--------------------+----------------------------------------------+
#            Copyright (c) 2022 8020Data-FormR * Released under
#            MIT License: http://www.opensource.org/licenses/mit-license.php
##FNCS     .--------------------+----------------------------------------------+
#            sayMsg             | ["sp"] {aMsg} ({bDebug}: 1)echo  2)echo then quit, 3) echo with no indent) ["sp"]
#            Help               | {aCmd} != "", echo {aCmd} error
#            docR               |                                                                           # .(21128.02.1)
#            dokR               |                                                                           # .(30716.01.1)
#            appR               |
#            gitR               |
#            keyS               |
#            proX               |
#                               |
##CHGS     .--------------------+----------------------------------------------+
# .(01001.01 10/01/20 RAM 10:00p| Created
# .(10706.09 10/01/20 RAM 10:00p| Windows returns an extra blank line)
# .(20416.03  4/16/22 RAM  3:30p| Get aVer and lost main2Fns
# .(20420.05  4/20/22 RAM  5:15p| Update FRT10_Main0_p1.06.sh changes
# .(20420.07  4/20/22 RAM  6:08p| Add Version command
# .(20429.02  4/29/22 RAM  2:48p| Add Keys command
# .(20429.03  4/29/22 RAM  2:48p| Add Git command
# .(20429.04  4/29/22 RAM  3:45p| Make Version Date permenant ${aVdt}
# .(20429.09  4/29/22 RAM  7:30p| aArgsNs have been converted to lowercase in getOpts
# .(20501.01  5/01/22 RAM 11:30a| Enable JPT12_Main2Fns_p1.05.sh in sub-scripts
# .(20502.06  5/02/22 RAM 12:00p| Major overhaul of JPT12_Main2Fns_p1.06.sh
# .(20508.01  5/08/22 RAM  2:50p| Put App Commands into separate script
# .(20601.01  6/01/22 RAM  8:30a| Add App List Styles and Rename Styles
# .(20601.02  6/01/22 RAM 10:15p| Never sayMsg() if bQuiet = 1
# .(20620.02  6/20/22 RAM 10:45a| Run Proxy in FRT24_Proxy1_u1.06.sh
# .(20620.05  6/20/22 RAM  6:15a| Move setting bDoit=0, bQuiet=0, bDebug=0
# .(20620.04  6/20/22 RAM  5:45p| Reworked sayMsg sp functionality
# .(21027.04 10/27/22 RAM 10:59a| Update gitr with sparse and clone
# .(21031.01 10/31/22 RAM  7:45a| Allow version _d1.09
# .(21107.02 11/07/22 RAM 12:45a| Add RSS Commands
# .(21113.05 11/13/22 RAM  5:30p| Display Version and Source in Begin
# .(21119.01 11/19/22 RAM  7:22p| Capitalize Help Menu
# .(21120.02 11/20/22 RAM  1:55p| Fix aOSv and aLstSp
# .(21120.03 11/20/22 RAM  2:55p| Set System Path for FRTools in DOS, GFW and Linux
# .(21121.03 11/21/22 RAM  4:00p| Allow for .bashrc or profile
# .(21122.01 11/22/22 RAM  9:15a| Add exit code if paths are the same
# .(21126.01 11/26/22 RAM  2:00p| Check SYSTEM path if set path was successful
# .(21126.08 11/26/22 RAM  6:11p| Add -user option to 'frt set path'
# .(21126.09 11/26/22 RAM  7:20p| Modify System/Shell names for PATH
# .(21127.07 11/27/22 RAM  7:40p| Surpress Info Path Add msg if FRT setPath
# .(21128.02 11/28/22 RAM  8:00p| Add docR Commands
# .(21129.07 11/29/22 RAM  8:50p| Fix set path not found in wrong shell
# .(21121.03 11/30/22 RAM  9:45a| Select .profile over .bashrc
# .(21121.07 11/30/22 RAM 11:45a| Change Help FRT Rir to FRT Dir
# .(21121.03 12/03/22 RAM  3:05p| Use another method to select .profile over .bashrc
# .(21203.05 12/03/22 RAM  5:45p| Deal with setPath None Found confusion
# .(21203.06 12/03/22 RAM  6:20p| Copy Uppercase bin commands in Linux
# .(21121.03 12/03/22 RAM  6:50p| Reverse method to select .profile over .bashrc
# .(30716.01  7/16/23 RAM 11:12a| Add dokr script

##PRGM     +====================+===============================================+
##ID 69.600. Main0              |
##SRCE     +====================+===============================================+
#*/
#========================================================================================================== #  ===============================  #

     aVdt="Jul 16, 2023 12:02p"; aVtitle="formR Tools"                                                      # .(21113.05.8 RAM Add aVtitle for Version in Begin)
     aVer="$( echo $0 | awk '{  match( $0, /_[dpstuv][0-9]+\.[0-9]+/ ); print substr( $0, RSTART+1, RLENGTH-1) }' )"  # .(21031.01.1 RAM Add [d...).(20416.03.8 "_p2.02", or _d1.09)

     LIB="FRT"; LIB_LOG=${LIB}_LOG; LIB_USER=${LIB}_USER; Lib=${LIB}                                        # .(80923.01.1)

#    aFns="$( dirname "${BASH_SOURCE}"         )/FRT12_Main2Fns_p1.06.sh";     if [ ! -f "${aFns}" ]; then  ##.(21113.05.9 RAM Use FRT12_Main2Fns_p1.06_v21027.sh)
     aFns="$( dirname "${BASH_SOURCE}" )/../JPTs/JPT12_Main2Fns_p1.07.sh";     if [ ! -f "${aFns}" ]; then  # .(21113.05.9 RAM Use JPT12_Main2Fns_p1.07.sh)
     echo -e "\n ** FRT10[ 99]  JPT Fns script, '.${aFns#*._2}', NOT FOUND\n"; exit; fi; #fi
     source "${aFns}";

# +------- +------------------ +----------------------------------------------------------- # ------------+ ------------------- # --------------+

     bDoit=0                                                                                                # .(20501.01.2 RAM !Important in Sub script).(20620.05.1 RAM Move to here)
     bQuiet=1                                                                                               # .(20501.01.3 RAM).(20601.02.2 bQuiet by default)
     bDebug=0                                                                                               # .(20501.01.4 RAM)
     bSpace=0;                                                                                              # .(20620.04.8 RAM A space hasn't been displayed, print one next; was 1)

     Begin "$@"                                                                                             # .(21113.05.18)

     setOS;                                                                                                 # .(20620.04.8 RAM A space hasn't been displayed, print one next; was 1)
     aLstSp="echo "; if [ "${aOSv/w}" != "${aOSv}" ]; then aLstSp=""; fi                                    # .(10706.09.1 RAM Windows returns an extra blank line).(21113.06.1 RAM Reverse).(21120.02.1)
#    echo "  - FRT10[113]  aOSv: ${aOSv}, ${aOS}, aLstSp: '${aLstSp}'"; ${aLstSp}; # exit

#    -- --- ---------------  =  ------------------------------------------------------  #

#    aOSv=gfw1 | w10p | w08s
#    aOSv=rh62 | rh70 | uv14 | ub16

#    sayMsg    "FRT10[120]  aServer: '${aServer}', aOSv: ${aOSv}, aOS: '${aOS}', bDebug: '${bDebug}'" 1
#    sayMsg    "FRT10[121]  $\1: '$1', $\2: '$2', $\3: '$3', $\4: '$4', bQuiet: '${bQuiet}', bDebug: '${bDebug}'" 2

#====== =================================================================================================== #  ===========

# ------------------------------------------------------------------------------------
#
#       HELP Command
#
#====== =================================================================================================== #  ===========

function Help( ) {

     if [ "${aCmd}" != "Help" ] && [ "help" != "$1" ]; then return; fi
     if [ "$1" != "help" ]; then sayMsg " ** Invalid Command: '$1'" 3 "sp"; aCmd="Help"; fi

#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

     echo ""
#    echo "  FormR Tools ${aVer}   ($( date "+%b %-d %Y %H:%M" ))"                      ##.(20429.04.2)
     echo "  Useful FRTools  (${aVer})               (${aVdt})"                         # .(20429.04.2 RAM).(21031.03.1 RAM)
     echo "  ------------------------------------  ---------------------------------"
     echo "     FRT [Help]"                                                             # .(20620.01.1 RAM)
     echo ""                                                                            #
     echo "     FRT Path Set [-doit] [-user]        Enable formR Tools to run anywhere" # .(21120.03.1 RAM Added).(21126.08.1 RAM Added -user)
     echo "     FRT Path Set [-doit] [-user]        Enable formR Tools to run anywhere" # .(21120.03.1 RAM Added).(21126.08.1 RAM Added -user)
     echo ""                                                                            #
#    echo "     FRT keyS [ Host ] [ Help ]          Manage SSH Key files"
     echo "     FRT keyS [ Help ]                   Manage SSH Key files"
   # echo "         keyS List [ SSH Hosts ]"                                            # .(20429.02.1 RAM Beg Add)
#  # echo "         keyS Make SSH Key  {KeyOwner}  {Host} {HostUser} {Resource}"
#  # echo "         keyS Delete SSH Key {KNo} [Authorized_Keys]"
#  # echo "         keyS Copy SSH Key  {KNo}"
     echo "         keyS List SSH Hosts Keys"
#  # echo "         keyS Set  SSH Host {KNo}       {Host} {HostUser} {Resource}"
#  # echo "         keyS Test SSH Host {HostAliasName}"                                 # .(20429.02.1 End)
     echo ""
     echo "     FRT gitR [ help ]                   Manage Git Local and Remote Repos"  # .(20429.03.1 RAM Beg Add)
     echo "         gitR Init"                                                          # .(20429.03.1 RAM End)
     echo "         gitR Clone"                                                         # .(21027.04.1 RAM Add)
     echo "         gitR Pull"                                                          # .(21119.01.1 RAM Add)
     echo ""
     echo "     FRT dokR [ help ]                   Manage Docker Containers"           # .(30716.01.2 RAM Beg Add)
     echo "         dokR [ but | build ]"                                               # .(30716.01.3)
     echo "         dokR [ psa | ps -a ]"                                               # .(30716.01.4)
     echo "         dokR [ im  | images ]"                                              # .(30716.01.5)
     echo ""                                                                            # .(30716.01.6)
   # echo "     FRT proX [ Help ]                   Manage Proxy files on server"
   # echo "         proX [ List | Restart ]"
   # echo "         proX Log"
   # echo "         proX Config"
   # echo ""
   # echo "     FRT appR [ Help ]                   Manage FormR Apps"
#  # echo "         appR Set Domain {Domain}"                                           # .(20407.03.1 RAM Add)
#  # echo "         appR Set Homepage {Homepage}"                                       # .(20407.01.1 RAM Add).(20410.03.1 RAM)
#  # echo "         appR Set Port {port}"                                               # .(20407.02.1 RAM Add)
#  # echo "         appR Set Title {AppTitle}"                                          # .(20409.03.1 RAM Add)
#  # echo "         appR Set SSH_Host {SSH_LoginAlias}"                                 # .(20411.03.1 RAM Add)
   # echo "         appR List [ Files | Styles ]"
#  # echo "         appR List Files"                                                    # .(20410.02.1 RAM Add)
#  # echo "         appR List Styles"                                                   # .(20601.01.3 RAM Add)
#  # echo "         appR Rename Styles"                                                 # .(20601.01.4 RAM Add)
#  # echo "         appR Save Files"                                                    # .(20415.01.1 RAM Add)
#  # echo "         appR Save Backup"                                                   # .(204xx.xx.x RAM Add)
#  # echo "         appR Doc"                                                           # .(20415.02.1 RAM Add)
#  # echo ""
   # echo "         appR [ Help | Start | Build | Deploy ]"
#  # echo "         appR Build"
#  # echo "         appR Run Prod"
#  # echo "         appR Deploy"                                                        # .(20411.08.1 RAM Add)
   # echo ""
   # echo "         SSH [ {SSH_Loginalias} ]"                                           # .(20412.02.1 RAM Add)
   # echo ""
     echo "     FRT DOC [ Help ]"                                                       # .(21128.02.2 RAM Add)
     echo "         DOC [ Start | Note | Code ]"                                        # .(21128.02.3 RAM Add)
     echo ""
     echo "         JPT {Cmd}"                                                          # .(21107.02.1)
     echo "         JPT RSS {Cmd}"                                                      # .(21107.02.2)
     echo "             RSS Dir (RDir)"                                                 # .(21107.02.3)
     echo "             RSS DirList (DirList)"                                          # .(21107.02.4)
     echo ""
     echo "  Notes: Only 3 lowercase letters are needed for each command, separated by spaces"
     echo "         One or more command options follow. Help for the command is dispayed if no options are given"
     echo "         The options, debug, doit and quietly, can follow anywhere after the command"
     ${aLstSp}                                                                                              # .(10706.09.3)
     exit

     } # eof Help
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#========================================================================================================== #  ===============================  #

     setArgs "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" "$9"

     getOpts "bdqgl" 0
     setCmds         0  # dBug: JPFns[262] and in JPFns.getCmd[270, 285]

  if [ "1" == "0" ]; then
     echo   "--- FRT10[218]  $\1: '$1', $\2: '$2', $\3: '$3', $\4: '$4',  bQuiet: '${bQuiet}', bDebug: '${bDebug}'"; echo ""

     echo   "--- FRT10[220]  Hello Robin          -- bSpace: '${bSpace}', bQuiet: '${bQuiet}', bDebug: '${bDebug}'"
     sayMsg     "FRT10[221]  Hello Robin"
     sayMsg     "FRT10[222]  Hello Robin" 1
#    sayMsg     "FRT10[223]  Hello Robin" 2

     echo   "--- FRT10[225]  sp Hello Robin       -- bSpace: '${bSpace}', bQuiet: '${bQuiet}', bDebug: '${bDebug}'"
     sayMsg  sp "FRT10[226]  sp Hello Robin"
     sayMsg  sp "FRT10[227]  sp Hello Robin" 1
#    sayMsg  sp "FRT10[228]  sp Hello Robin" 2

     echo   "--- FRT10[230]  Hello Robin sp       -- bSpace: '${bSpace}', bQuiet: '${bQuiet}', bDebug: '${bDebug}'"
     sayMsg     "FRT10[231]  Hello Robin sp" sp
     sayMsg     "FRT10[232]  Hello Robin sp" sp 1
#    sayMsg     "FRT10[233]  Hello Robin sp" sp 2

     echo   "--- FRT10[235]  sp Hello Robin sp    -- bSpace: '${bSpace}', bQuiet: '${bQuiet}', bDebug: '${bDebug}'"
     sayMsg  sp "FRT10[236]  sp Hello Robin sp" sp
     sayMsg  sp "FRT10[237]  sp Hello Robin sp" sp 1
     sayMsg  sp "FRT10[238]  sp Hello Robin sp" sp 2

     exit
     fi

     sayMsg sp "FRT10[243]  \$1: '$1', \$2: '$2', \$3: '$3', \$4: '$4', \$5: '$5', \$6: '$6', \$7: '$8'";
     sayMsg    "FRT10[244]  aCmd:  '${aCmd}', aCmd1: '${aCmd1}', aCmd2: '${aCmd2}', aCmd3: '${aCmd3}', aCmd0: '${aCmd0}', bDoit: '$bDoit', bDebug: '$bDebug', bQuiet: '$bQuiet' " -1  # .(20601.02.3 RAM Was bQuiet: '$c' ??)
#    sayMsg    "FRT10[245]  aCmd:  '${aCmd}', aCmd1: '${aCmd1}', aCmd2: '${aCmd2}', aCmd3: '${aCmd3}', aCmd0: '${aCmd0}'" -1

#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#    Help

#    getCmd    "he"             "Help"
     getCmd1   "doc"     ""     "DOC"     1                                                                 # .(21128.02.1)
     getCmd1   "proxy"   ""     "proX"                                                                      # .(20620.03.1 RAM).(20620.10.1 RAM was Proxy)(20622.2.5 RAM Beg Use getCmd1)
     getCmd1   "dokr"    ""     "dokR"  # 1                                                                 # .(30716.01.7)
     getCmd1   "gitr"    ""     "gitR"  # 1                                                                 # .(20620.10.2 RAM was GitR)
     getCmd1   "keys"    ""     "keyS"  1                                                                   # .(20620.10.3 RAM was Keys)
     getCmd1   "appr"    "run"  "appR"                                                                      # .(20508.01.1 RAM)(20620.10.4 RAM was App)(20622.2.5 RAM End)
#    getCmd    "run"     "ap"   "appR"                                                                      # .(20508.01.2 RAM)(20620.10.5 RAM was App)
     getCmd1   "jpt"     ""     "JPT"   1                                                                   # .(21107.02.5)
     getCmd1   "rss"     ""     "JPT RSS"      1                                                            # .(21107.02.6)
     getCmd1   "rdir"    ""     "JPT RDir"     1                                                            # .(21107.02.7)
     getCmd1   "dirlist" ""     "JPT DirList"  1                                                            # .(21107.02.8)
     getCmd1   "dir"     ""     "JPT RDir"     1                                                            # .(21119.05.7)
     getCmd1   "set"     "var"  "Set Var"                                                                   # .(21120.03.2)
     getCmd1   "set"     "path" "Set Var"                                                                   # .(21120.03.2)
     getCmd1   "setpath" ""     "Set Var"   1                                                               # .(21120.03.3)

#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

     sayMsg    "FRT10[270]  aArg1: '$aArg1', aArg2: '$aArg2', aArg3: '$aArg3', aArg4: '$aArg4', aArg5: '$aArg5', aArg6: '$aArg6', aArg7: '$aArg7', aArg8: '$aArg8', aArg9: '$aArg9'"
     sayMsg sp "FRT10[271]  aCmd:  '${aCmd}', aCmd1: '${aCmd1}', aCmd2: '${aCmd2}', aCmd3: '${aCmd3}', aCmd0: '${aCmd0}', bDoit: '${bDoit}', bDebug: '${bDebug}', bQuiet: '${bQuiet}" -12

     Help ${aCmd0}

     sayMsg    "FRT10[275]  aCmd:  '${aCmd}', aArg1: '${aArg1}', aArg2: '${aArg2}', aArg3: '${aArg3}', aArg4: '${aArg4}', bDoit: '${bDoit}', bGlobal: '${bGlobal}'" sp -1

#====== =================================================================================================== #  ===========

# ------------------------------------------------------------------------------------                      # .(21107.02.9 Beg RAM Added)
#
#       JPT Commands
#
#====== =================================================================================================== #

#      sayMsg "FRT10[285]  JPT Commands (${aArg1:0:3}) aCmd: '${aCmd}', \$@: '$@'" 1

     if [ "${aCmd:0:3}" == "JPT" ]; then

#       sayMsg "FRT10[289]  jpt: '${aArg1}' '${aArg2}' '${aArg3}' '${aArg4}', bDoit: '${bDoit}', bDebug: '${bDebug}', bQuiet: '${bQuiet}'" -1

#       aArgs="$( echo "$@" | tr '[:upper:]' '[:lower:]' )"                                                 #

        if [ "${aCmd}" ==  "JPT" ];         then aSubCmd=""; fi
#       if [ "${aCmd}" ==  "JPT RSS1" ];    then aSubCmd="rss"; fi                                          ##.(21119.05.1 RAM)
        if [ "${aCmd}" ==  "JPT RSS"  ];    then aSubCmd=""; fi                                             # .(21119.05.1 RAM)
        if [ "${aCmd}" ==  "JPT RDir" ];    then aSubCmd="rss rdir"; fi
        if [ "${aCmd}" ==  "JPT DirList" ]; then aSubCmd="rss dirlist"; fi
        if [ "${aCmd}" ==  "JPT RSS"  ] && [ "$#" == "1" ]; then aSubCmd="rss"; fi                          # .(21119.05.2)
#       if [ "$@" == "rss"            ];    then aSubCmd="rss"; fi                                          # .(21119.05.2)

        shift;
#       sayMsg     "FRT10[302]  JPT: JPT00_Main0.sh \"$@\"" 2
#       echo   "  - FRT10[303]  JPT: JPT00_Main0.sh   ${aSubCmd} \"$@\""; exit

        "$( dirname $0 )/../JPTs/JPT00_Main0.sh"  ${aSubCmd}  "$@"

        ${aLstSp}
        exit
     fi # eoc JPT Commands
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- # .(21107.02.9 End)

#====== =================================================================================================== #  ===========

# ------------------------------------------------------------------------------------
#
#       GITR Commands
#
#====== =================================================================================================== #

#       sayMsg "FRT10[320]  gitR Commands (${aArg1:0:3}) aCmd: '${aCmd}'" 1                                 # .(20429.03.2 Beg RAM Added)

     if [ "${aCmd}"    ==  "gitR" ]; then

        sayMsg "FRT10[324]  gitR:  '${aArg1}' '${aArg2}' '${aArg3}' '${aArg4}', bDoit: '${bDoit}', bDebug: '${bDebug}', bQuiet: '${bQuiet}'" -1

        shift
# echo "$( dirname $0 )/gitR/FRT22_gitR1_p2.02.sh"  "${aArg1}" "${aArg2}" "${aArg3}" "${aArg4}"
#      "$( dirname $0 )/gitR/FRT22_gitR1_p2.02.sh"  "${aArg1}" "${aArg2}" "${aArg3}" "${aArg4}"
#      "$( dirname $0 )/gitR/FRT22_gitR1_p2.02.sh"  "$@"
# echo "$( dirname $0 )/gitR/FRT22_gitR1_d2.04.sh"  "$@"
       "$( dirname $0 )/gitR/FRT22_gitR1_p2.04.sh"  "$@"                                                   # .(21027.04.2)

        ${aLstSp}
        exit
     fi # eoc gitR Commands
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========

# ------------------------------------------------------------------------------------                      # .(30716.01.8 Beg Add)
#
#       DOKR Commands
#
#====== =================================================================================================== #

#       sayMsg "FRT10[346]  dokS Commands (${aArg1:0:3})"                                                   # .(20429.02.2 Beg RAM Added)

     if [ "${aCmd}"     == "dokR" ]; then

        sayMsg "FRT10[350]  dokR: '${aArg1}' '${aArg2}' '${aArg3}' '${aArg4}', bDoit: '${bDoit}', bDebug: '${bDebug}', bQuiet: '${bQuiet}'"

        shift
       "$( dirname $0 )/dokR/FRT24_dokR1.sh"  "$@"

        ${aLstSp}
        exit
     fi # eoc keyS Commands                                                                                 # .(30716.01.8 End)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#========================================================================================================== #  ===============================  #
# ------------------------------------------------------------------------------------
#
#       KEYS Commands
#
#====== =================================================================================================== #

#       sayMsg "FRT10[367]  keyS Commands (${aArg1:0:3})"                                                   # .(20429.02.2 Beg RAM Added)

     if [ "${aCmd}"     == "keyS" ]; then

        sayMsg "FRT10[371]  keyS: '${aArg1}' '${aArg2}' '${aArg3}' '${aArg4}', bDoit: '${bDoit}', bDebug: '${bDebug}', bQuiet: '${bQuiet}'"

        shift
       "$( dirname $0 )/keyS/FRT21_Keys1_p2.01.sh"  "$@"

        ${aLstSp}
        exit
     fi # eoc keyS Commands                                                                                 # .(20429.02.2 End)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#========================================================================================================== #  ===============================  #

# ------------------------------------------------------------------------------------
#
#       APP Commands                                                                                        # .(20508.01.2 Beg RAM Put into seperate App script)
#
#====== =================================================================================================== #

#       sayMsg "FRT10[389]  appR Commands (${aArg1:0:3})"                                                   # .(20429.02.2 Beg RAM Added)

     if [ "${aCmd}"     == "appR" ]; then

        sayMsg "FRT10[393]  appR:   '${aArg1}' '${aArg2}' '${aArg3}' '${aArg4}', bDoit: '${bDoit}', bDebug: '${bDebug}', bQuiet: '${bQuiet}'" 1

        shift
# echo "$( dirname $0 )/appR/FRT23_FRApp1_p1.06.sh"  "$@"                                                   ##.(20601.01.5)
#      "$( dirname $0 )/appR/FRT23_FRApp1_p1.06.sh"  "$@"                                                   ##.(20601.01.5)
       "$( dirname $0 )/appR/FRT23_FRApp1_u1.07.sh"  "$@"                                                   # .(20601.01.5 RAM Use u1.xx rather than p1.xx)

        ${aLstSp}
        exit
     fi # eoc appR Commands                                                                                 # .(20429.02.2 End).(20508.01.2 End)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#========================================================================================================== #  ===============================  #

# ------------------------------------------------------------------------------------
#
#       PROXY Commands
#
#====== =================================================================================================== #

#    if [ "${1:0:3}" == "pro" ]; then                                                                       ##.(20429.02.2)
     if [ "${aCmd}"     == "proX" ]; then                                                                   # .(20429.02.2 RAM Beg Added)

        sayMsg "FRT10[416]  proX: '${aArg1}' '${aArg2}' '${aArg3}' '${aArg4}', bDoit: '${bDoit}', bDebug: '${bDebug}', bQuiet: '${bQuiet}'"

        shift
#      "$( dirname $0 )/proX/FRT24_Proxy_v1.06\`20620-1041.sh"  "$@"
#      "$( dirname $0 )/proX/FRT24_Proxy1_v1.07\`20620-1052.sh"  "$@"
       "$( dirname $0 )/proX/FRT24_Proxy1_u1.07.sh"  "$@"

        ${aLstSp}
        exit
     fi # eoc proX Commands                                                                                 # .(20620.02.2 RAM End)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========

# ------------------------------------------------------------------------------------
#
#       Set Var Path Command                                                                                # .(20102.01.2 Beg RAM Added Command)
#
#====== =================================================================================================== #

        sayMsg    "FRT10[436]  Set Var Command" sp;

  if [ "${aCmd}" == "Set Var" ]; then

# --------------------------------------------------------------------

                aInfoScr="._2/JPTs/RSS/Info/RSS22_Info.sh"; bOK=0                                           # .(21122.02.1 RAM Fix backsplashed)

  if [ "${aArg2}" == "path" ]; then
#       sayMsg    "FRT10[445]  SetVar" 1

     if [ -f "${aInfoScr}" ] && [ -d ".git" ]; then bOK=1; fi
     if [ "${bOK}" == "0" ]; then
        echo -e "\n  * You must be in the FRTools Repo folder. \n"; exit
        fi
        aPath1="$( pwd )/._2/bin";

        if [ "$3" == "-user" ] || [ "$4" == "-user"      ]; then aUser="-user"; fi                          # .(21126.08.2 RAM Blank if not passed)
        aShell="-bash";        if [ "${aOSv:0:1}" == "w" ]; then aShell="-sys"; fi                          # .(21129.07.2)
#                              if [ "${aOSv:0:1}" != "w" ]; then aUser="-bash"; fi                          # .(21203.05.1 RAM Can't be -user or -sys in Unix or GitBash ?? )

     if [ "${bDoit}" == "0" ] ; then

#       aBashrc=".bashrc";  if [ ! -f    "~/${aBashrc}" ]; then aBashrc="profile";  fi                      ##.(21121.03.9)
#       aBashrc=".bashrc";  if [ ! -f -a "~/${aBashrc}" ]; then aBashrc="profile";  fi                      ##.(21121.03.9  RAM Use alternate hidden profile file).(21121.03.11)
#       aBashrc=".profile"; if [ ! -f -a "~/${aBashrc}" ]; then aBashrc=".bashrc";  fi                      ##.(21121.03.11 RAM Use .profile if it exists).(21121.03.21)
#       aBashrc=".profile"; if [   -f -a  ~/.bashrc     ]; then aBashrc=".bashrc";  fi                      ##.(21121.03.21 RAM Good Grief).(21121.03.31)
        aBashrc=".bashrc";  if [   -f -a  ~/.profile    ]; then aBashrc=".profile"; fi                      # .(21121.03.31 RAM More Good Grief)

#       aWhere="the ~/${aBashrc} file"; if [ "${aOSv:0:1}" == "w" ]; then aWhere="the Windows System"; fi   ##.(21121.03.10).(21126.09.1)
        aWhere="${aOS} Shell"; if [ "${aOSv:0:1}" == "w" ]; then aWhere="Windows System Environment"; fi    # .(21121.03.10).(21126.09.1)
        if [ "${aUser}" == "-user" ]; then aWhere="Windows User Environment"; aShell="-user"; fi            # .(21126.08.11).(21129.07.2)

        echo -e "\n    The Path to FRTools will be set in the ${aWhere} with: RSS Info Path Add \"{Path}\" ${aUser}"

                    "${aInfoScr}" path add "${aPath1}" "${aUser}"                                           # .(21126.08.3)

        if [ "$?" != "1" ]; then echo -e "\n    Add -doit to the command line to add the path to FRTools."; fi
        ${aLstSp}; exit
        fi
#       --------------------------------------------------------

     if [ "${bDoit}" == "1" ] ; then

#          echo       "${aInfoScr}" path add -doit "${aPath1}" "aUser: '${aUser}'"; #  exit                 #
    export bQuiet=1;  "${aInfoScr}" path add -doit "${aPath1}" "${aUser}"                                   # .(21126.08.4).(21127.07.03)

           if [ "$?" == "1" ]; then ${aLstSp}; exit; fi                                                     # .(21122.01.5 if no change to path)

#          aPath2="$( "${aInfoScr}" path show "\._2"         )"                                             ##.(21126.01.1)
#          aPath2="$( "${aInfoScr}" path show "FRTools" -sys )"                                             ##.(21126.01.1 RAM Need to check SYSTEM paths).(21129.07.3)
#          aPath2="$( "${aInfoScr}" path show "FRTools" "${aShell}" )" | awk 'NR == 2'                      # .(21129.07.3 RAM Need to check $aShell paths)
           aPath2="$( "${aInfoScr}" path show "FRTools" "${aShell}" )"                                      # .(21129.07.3 RAM Need to check $aShell paths)
#          echo " aOSv: '${aOSv}' '${aOSv/w}', aShell; '${aShell}' aPath2: '${aPath2}'";                    # Includes leaning CR
   if [ "${aPath2}" != "" ]; then
   if [ "${aPath1}" == "${aPath2:4}" ]; then exit; fi                                                       # .(21129.07.4 RAM Tif no change to path ?? see .(21122.01.5 above)

#          echo " ls -1 \"${aPath1/bin/CMDs}\""
#                 ls -1 "${aPath1/bin/CMDs}"
#          echo " aOSv: '${aOSv}' '${aOSv/w}', aShell; '${aShell}' aPath2: '${aPath2:6:1}'";
#          echo "cp -p \"${aPath1/bin/CMDs}/\"*"  \"${aPath1}/\""; exit

        if [ "${aOSv/w}" == "${aOSv}" ]; then  # Unix                                                       # .(21203.06.1 RAM Beg Copy Uppercase bin files in Linux)
#          echo "--- let's copy CMDs for aUser: '${aUser}' and or '${aShell}', aOSv: '${aOSv}'";

                 cp  -p "${aPath1/bin/CMDs}/"*  "${aPath1}/"  >/dev/null                                    # .(21203.06.2 RAM "${aPath1/bin/CMDs}/*" no workie)
           fi                                                                                               # .(21203.06.1 RAM End)
        if [ "${aPath2:6:1}" == "*" ]; then aPath2="        ${aPath1}"; fi                                  # .(21203.05.2)

#          aToDo="restart this session"; if [ "${aOSv:0:1}" == "w" ]; then aToDo="login again"; fi          ##.(21126.09.2).(21126.09.5)
           aToDo="login again";          if [ "${aOSv:0:1}" == "g" ]; then aToDo="restart this session"; fi # .(21126.09.5)
                 if [ "${aOSv/w}" != "${aOSv}" ]; then  echo ""; fi # Windows                               # .(21203.06.3 RAM Why??)
                 echo "    The Path to FRTools has been set to:"; echo "              '${aPath2:8}'."
                 echo ""
                 echo "  * Please ${aToDo} for the Path to take effect."                                    # .(21126.09.3)
      else
        echo -e     "\n    The Path to FRTools has not been set."
        fi
        ${aLstSp}; exit                                                                                     # .(21127.08.1)
        fi # eif bDoit
     fi # eoc set path
#       --------------------------------------------------------

        sayMsg    "FRT10[519]  set var path ${aArg2} '${aArg3}' '${aArg4}'" sp;
  if [ "${aArg2}" == "path" ]; then                                                                         # .(21120.03.6 RAM Beg ?? Why here s.b. rss info var set aVar aVal)
       "${aInfoScr}" vars set -doit "${aArg3}" "${aArg4}"
     fi # eoc set var
#       --------------------------------------------------------
     fi # eoc set                                                                                           # .(20102.01.2 RAM End)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========

# ------------------------------------------------------------------------------------
#
#       DOC Commands                                                                                        # .(21128.02.2 RAM Beg Add Command)
#
#====== =================================================================================================== #

        sayMsg    "FRT10[535]  Next Command" sp;

  if [ "${aCmd}" == "DOC" ]; then

        sayMsg    "FRT10[539]  DOC Commands" -1
        sayMsg    "FRT10[540]  appR:   '${aArg1}' '${aArg2}' '${aArg3}' '${aArg4}', bDoit: '${bDoit}', bDebug: '${bDebug}', bQuiet: '${bQuiet}'" -1

        shift
       "$( dirname $0 )/FRT30_docR0_p1.01.sh"  "$@"                                                         # .(21128.02.3)

     ${aLstSp}
     fi # eoc Next Command                                                                                  # .(21128.02.2 RAM End)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========

# ------------------------------------------------------------------------------------
#
#       NEXT COMMAND Commands                                                                               # .(20102.01.2 Beg RAM Added Command)
#
#====== =================================================================================================== #

        sayMsg    "FRT10[557]  Next Command" sp;

  if [ "${aCmd}" == "Next Command" ]; then

        sayMsg    "FRT10[561]  Next Command" 1

     ${aLstSp}
     fi # eoc Next Command                                                                                  # .(20102.01.2 End)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========

# ------------------------------------------------------------------------------------
#
#       END
#
#========================================================================================================== #  ===============================  #
#*\
##SRCE     +====================+===============================================+
##RFILE    +====================+=======+===================+======+=============+
#*/
