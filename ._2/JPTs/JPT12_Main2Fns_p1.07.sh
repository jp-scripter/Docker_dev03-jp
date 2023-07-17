#!/bin/bash
#*\
##=========+====================+================================================+
##RD         JPT Launcher Fns   | JPT Common Functions
##RFILE    +====================+=======+===============+======+=================+
##FD   JPT12_Main2Fns.sh        |  24586|  5/03/22  9:09|   407| p1.06-20503-0909
##FD   JPT12_Main2Fns.sh        |  25287|  5/03/22 15:43|   427| p1.06-20503-1543
##FD   JPT12_Main2Fns.sh        |  30170|  5/08/22 18:36|   491| p1.06-20508-1836
##FD   JPT12_Main2Fns.sh        |  30197|  6/01/22 10:15|   491| u1.06-20601-1015
##FD   JPT12_Main2Fns.sh        |  35619|  6/20/22 21:55|   538| u1.06-20620-2155
##FD   JPT12_Main2Fns.sh        |  37566|  6/23/22 09:34|   565| u1.06-20623-0934
##FD   JPT12_Main2Fns.sh        |  39508|  6/25/22 11:38|   586| u1.06-20625-1138
##FD   JPT12_Main2Fns.sh        |  41252| 10/27/22 12:00|   605| u1.06-21027-1200
##FD   JPT12_Main2Fns.sh        |  41977| 11/13/22 17:31|   594| p1.07-21113-1731
##FD   JPT12_Main2Fns.sh        |  44435| 11/20/22 13:58|   611| p1.07-21120.1358
##FD   JPT12_Main2Fns.sh        |  46030| 11/27/22 14:33|   624| p1.07-21127.1433
##FD   JPT12_Main2Fns.sh        |  45555|  5/20/23 21:00|   626| p1.07-30520.2100
##DESC     .--------------------+-------+---------------+------+-----------------+
#            Common function for JScriptWare Tools
#
##LIC      .--------------------+----------------------------------------------+
#            Copyright (c) 2018 JScriptware Power Tools * Released under
#            MIT License: http://www.opensource.org/licenses/mit-license.php
##FNCS     .--------------------+----------------------------------------------+
#            sayMsg( )          |
#            setOS( )           |
#            logIt( )           |
#            askYN( )           |                                                       #.(20503.03.3 RAM Added)
#            sayMsg( )          |
#            setArgs()          |
#            getOpts()          |
#            getOpt()           |
#            setCmds()          |
#            getCmd()           |
#            setLv()            |
#            isDir()            |                                                       # .(20623.02.1 RAM Added)
#            Begin()            |
#          # Run()              |                                                       ##.(21113.02.1 RAM Not Added)
#            End()              |
#
##CHGS     .--------------------+----------------------------------------------+
# .(80916.02  9/16/18 RAM  8:50a| Break out $nLv and $aAct
# .(80917.01  9/17/18 RAM  4:10p| Fix bug when $aAct = x
# .(80920.01  9/20/18 RAM  1:20p| Put JPTnn..sh scripts into JPTs not JSHs
# .(80920.02  9/20/18 RAM  2:45p| Add logIt()

# .(80923.02  9/23/18 RAM  9:45a| Change JPT to LIB









# .(20409.05  4/09/22 RAM  9:30a| Add askYN()
# .(20409.05  4/09/22 RAM  9:30a| Add Begin() and End()

# .(20418.01  4/18/22 RAM  9:30a| Add sayMsg()
# .(20418.02  4/18/22 RAM  9:30a| Add getOpt()
# .(20418.03  4/18/22 RAM  9:45a| Add getCmd()
# .(20429.09  4/29/22 RAM  7:30p| Convert aArgsNs to lowercase
# .(20429.09  5/01/22 RAM  2:45p| Run Args_toLower once
# .(20502.02  5/02/22 RAM  3:45p| Keep bDebug if set
# .(20502.06  5/02/22 RAM 12:00p| Major overhaul of JPT12_Main2Fns_p1.06.sh
# .(20503.03  5/03/22 RAM 12:30p| Added askYn()
# .(20503.04  5/03/22 RAM  3:11p| Removed 2nd version of sayMsg
# .(20508.03  5/08/22 RAM  4:00p| Added THE_SERVER checks
# .(20601.02  6/01/22 RAM 10:15p| Never sayMsg if bQuiet = 1
# .(20601.04  6/01/22 RAM  7:00p| Played with dBug and nLen
# .(20620.04  6/20/22 RAM  5:45p| Rework sayMsg sp functionality, Use bNoQuit, Use bNoQuit
# .(20620.06  6/20/22 RAM  6:00p| Wrote sayMBugEnd, bDebug1 can't be ''
# .(20620.07  6/20/22 RAM  6:45p| Why is bDebug special
# .(20620.09  6/20/22 RAM  7:45p| Do    print if bDebug=1 and sayMsg ... -1
# .(20620.09  6/20/22 RAM  7:45p| Ok, print space before exit
# .(20622.01  6/22/22 RAM  4:45p| Write getCmd1 for 1st level cmd
# .(20623.02  6/23/22 RAM  9:30a| Added isDir()
# .(20623.03  6/23/22 RAM  1:30p| Add aOS back, Don't assign bSP=1, aSP=$2
# .(20623.09  6/23/22 RAM  7:45p| Don't re-assign bDebug1, or aSP)
# .(20620.09  6/23/22 RAM  2:45p| Don't print if bDebug=1 and sayMsg ... 1
# .(20625.04  6/25/22 RAM  8:00p| Set bSpace=1, not 0 and add export
# .(21027.02 10/27/22 RAM 12:00p| Add "*" as optional getCmd 2nd Arg
# .(21112.02 11/12/22 RAM 11:50a| Export useful variables
# .(21112.04 11/12/22 RAM  4:30p| Change SCN_SERVER to THE_SERVER
# .(21112.05 11/12/22 RAM  4:30p| Create THE_SERVER if missing
# .(21113.01 11/12/22 RAM 12:00p| Combine Main2Fns for JPT, FRT and RSS
# .(21113.02 11/12/22 RAM  1:30p| Don't add Run
# .(21113.05 11/12/22 RAM  5:30p| Move Version in to Begin
# .(21120.02 11/20/22 RAM  1:58p| Fix aOSv and aLstSp
# .(21126.05 11/26/22 RAM  3:37p| Set aOSv again for GitBash and ComEmu
# .(21126.07 11/26/22 RAM  5:48p| Remove aVdt.. version vars from this script
# .(21112.02 11/27/22 RAM  2:33p| Export aOS
# .(30520.03  5/20/23 RAM  8:54p| Change RSS22-Info to RSS23_Info

##PRGM     +====================+===============================================+
##ID 69.600. Main               |
##SRCE     +====================+===============================================+
#*/
#    aVdt_x="Nov 27, 2022  2:33p"; aVtitle_x="JavaScriptware Tools Utility Fns"                 # .(21113.05.4 RAM Add aVtitle for Version in Begin)
#    aVer_x="$( echo $0 | awk '{  match( $0, /_[dpstuv][0-9]+\.[0-9]+/ ); print substr( $0, RSTART+1, RLENGTH-1) }' )"  # .(21031.01.1 RAM Add [d...).(20416.03.8 "_p2.02", or _d1.09)

#          if [ "${LIB}" == "" ]; then LIB=JPT; Lib=RSS; fi                                 ##.(80926.01.1)
           if [ "${LIB}" == "" ]; then LIB=JPT; Lib=JPT; fi                                 # .(80926.01.1).(21113.01.1 RAM Was RSS)

#         LIB=RSS; LIB_LOG=${LIB}_LOG; LIB_USER=${LIB}_USER; Lib=rss                        ##.(80923.02.1).(80925.01.1)
                   LIB_LOG=${LIB}_LOG; LIB_USER=${LIB}_USER                                 # .(80925.01.2
                   LIB_LOG=${!LIB_LOG} LIB_USER=${!LIB_USER}                                # .(80925.01.1 uses Indirect Expansion)

# ----------------------------------------------------------------








# +------- +------------------ +----------------------------------------------------------- # ------------+ ------------------- # --------------+

function  setOS() {

     if [ "${OS:0:7}"     == "Windows" ]; then aOSv="w10p"; aName="Windows"; fi                                                 # .(21112.05.2 RAM Is it Windows)
     if [ "${OSTYPE:0:5}" == "linux"   ]; then aOSv="linx"; aName="Linux";   fi                                                 # .(21112.05.3 RAM Is it Linux)
     if [ -f "/etc/issue" ]; then aOSv=$( cat "/etc/issue" | awk '/Ubuntu/ { print "ub" substr($0,8,2) }' ); fi                 # .(21112.05.4 RAM Is it Ubuntu)
     if [ "${aOSv:0:2}"   == "ub"      ]; then              aName="Ubuntu";  fi                                                 # .(21112.05.5)

#       -------------------------------------------------------------

# if [ "${THE_DRIVES}" == "" ]; then echo ""; echo  "* \$THE_DRIVES is NOT DEFINED; NFS Vol won't be correct";  exit; fi        # .(90321.02.1)
  if [ "${THE_SERVER}" == "" ]; then echo ""; echo  "* THE_SERVER is NOT Defined; The OS, '${aOSv}', may not be correct."
        THE_SERVER="${HOSTNAME:0:6}-${aOSv}_${aName}-Prod1 (127.0.0.1)";  pause "  Setting it to \"${THE_SERVER}\"."            # .(21112.05.6)
#                             echo "./RSS/Info/RSS23_Info.sh vars set THE_SERVER  ${THE_SERVER}"
        export aOSv                                                                                                             # .(21112.05.7 RAM Needed for set vars)
#       $( dirname "${BASH_SOURCE}"     )/Info/RSS23_Info.sh vars set THE_SERVER  "${THE_SERVER}"                               ##.(21113.01.2)
#       $( dirname "${BASH_SOURCE}" )/RSS/Info/RSS23_Info.sh vars set THE_SERVER  "${THE_SERVER}"                               # .(21113.01.2 RAM it's always JPT)
        $( dirname "$0"                 )/Info/RSS23_Info.sh vars set THE_SERVER  "${THE_SERVER}"                               # .(30520.03.1 RAM ???)
        exit
        fi
        # exit; fi                                                                                                              # .(21112.04.2)
#       -------------------------------------------------------------

     aSCN_SERVER=$( echo ${THE_SERVER} | tr '[:upper:]' '[:lower:]' )                   # .(20508.03.5 RAM Set var from THE_SERVER)
     aIP=${aSCN_SERVER##* (}; aIP=${aIP//)/}

     aSvr=${aSCN_SERVER%%_*}
     aOSv=${aSvr##*-}                                                                   # [wmu?] 1st char after -
     aSvr=${aSvr%%-*}

     aTHE_SERVER=${aTHE_SERVER// (*}                                                    # .(90326.04.1 Delete everything after " (").(21112.04.3 RAM End)
#    echo "setOS[1]  bTest: ${bTest}, bQuiet: ${bQuiet}, aSvr: ${aSvr}, aOSv: ${aOSv}, aIP: ${aIP}"; exit

#if [ "${aOSv:0:1}" == "w" ]; then                                                      # .(21120.02.4)
#             set | awk '/hostcomplete:/'; echo ""
#    bGFW2=$( set | awk '/hostcomplete:/ { print 1; exit }' )                           # .(21120.02.5 RAM No workie because this code is returned by set)
#    fi                                                                                 # .(21120.02.6)
#    bGFW1=$( echo "$PATH" | tr : "\n" | awk '/\/(git|Git)\/usr\// { print 1 }' )       ##.(21120.02.7)
#             echo "$PATH" | tr : "\n" | awk '/(git|Git)\/usr/'
#    bGFW1=$( echo "$PATH" | tr : "\n" | awk '/(git|Git)\/usr/ { print 1; exit }' )     # .(21120.02.8)                         # .(21112.05.1 RAM Check if /git/usr/bin in path)
     bGFW1=$( echo "$PATH" | tr : "\n" | awk '/mingw64/ { print 1; exit }' )            # .(21126.05.1 RAM One last Time)       # .(21112.05.1 RAM Check if /git/usr/bin in path)
  if [ "${bGFW1}" == "1" ]; then                                                                                                # .(21112.05.2 RAM Was if [ "${ConEmuTask}" != "" ])
     aOSv="gfw1"
     fi
     bGFW2=$( echo "$PATH" | tr : "\n" | awk '/ConEmu/ { print 1; exit }' )             # .(21126.05.2 RAM Beg And ConEmu)
  if [ "${bGFW2}" == "1" ]; then                                                                                                # .(21112.05.2 RAM Was if [ "${ConEmuTask}" != "" ])
     aOSv="gfw2"
     fi                                                                                 # .(21126.05.2 RAM End)
 #  echo "bGFW1: ${bGFW1}, bGFW2: ${bGFW2}"; exit

                                       aDrv=""
  if [ "${aOSv:0:1}" == "g"    ]; then aDrv="/c"  ; fi    # Windows Git Bash
  if [ "${aOSv:0:1}" == "m"    ]; then aDrv=""    ; fi    # MacOS                       # .(20623.03.1)
  if [ "${aOSv:0:1}" == "u"    ]; then aDrv=""    ; fi    # Ubuntu                      # .(20623.03.2)
  if [ "${aOSv:0:2}" == "rh"   ]; then aDrv=""    ; fi    # Red Hat                     # .(20623.03.3)
  if [ "${aOSv:0:1}" == "w"    ]; then aDrv="C:"  ; fi    # Windows
  if [ "${aOSv}"     == "w08s" ]; then aDrv="D:"  ; fi

                                       aVOL=""            ; aVol="/nfs/u06"
# if [ "${aNFS}"     == "_"    ]; then aVOL=""            ; aNFS="/nfs/u06"             # .(90326.02.1).(21113.01.6 aNFS was set by Run())
  if [ "${aOSv:0:1}" == "g"    ]; then aVOL="c/vols/u06"                    ; fi
  if [ "${aOSv:0:1}" == "w"    ]; then aVOL="C:/VOLs/U06"                   ; fi

# if [ "${aOSv}"     == "w10p" ]; then                      aNFS="M:/U06"   ; fi        ##.(90315.01.3 M: is now N:)
  if [ "${aOSv}"     == "w10p" ]; then                      aNFS="N:/U06"   ; fi        # .(90315.01.3 M: is now N:)
# if [ "${aOSv}"     == "w08s" ]; then aVOL="D:/VOLs/U06" ; aNFS="M:/U06"   ; fi        ##.(90315.01.4 M: is now N:)
  if [ "${aOSv}"     == "w08s" ]; then aVOL="D:/VOLs/U06" ; aNFS="N:/U06"   ; fi        # .(90315.01.4 M: is now N:)

#    fi  # eif "${aNFS}" == "_"                                                         # .(90326.02.2).(21113.01.7)

     export aOSv                                                                                                                # .(21112.02.1 RAM Export aOSv)

     aOS="linux"; if [ "${aOSv:0:1}" == "w" ]; then aOS="windows"; fi                   # .(20623.03.4)
                  if [ "${aOSv:0:1}" == "m" ]; then aOS="macOS";   fi                   # .(20623.03.5)
                  if [ "${aOSv:0:1}" == "g" ]; then aOS="GitBash"; fi                   # .(20623.03.6)

     export aOS                                                                                                                 # .(21112.02.1 RAM Export aOS)

  if [ "${bQuiet}"   == "0"      ] || [ "1" == "0" ]; then
     aCmd0="${aCmd}                       "; aCmd0="${aCmd0:0:23}";
     echo "  THE_SERVER: ${aTHE_SERVER}; aSvr: ${aSvr}, aOSv: ${aOSv}, aIP: ${aIP}"                                             # .(21112.04.4)
     echo "        aCmd: ${aCmd0};  aDrv=${aDrv} aVOL=${aVOL}; aNFS=${aNFS};  Main2Fns Lib=${Lib}";
     fi
#    exit

     } # eof setOS
#   ------- ------------------  =  ---------------------------------------------------  #  ----------------

#======= ================================================================================================== #  ===========

function  logIt() {                                                                                          # .(80920.02.1)
          aFncLine="$1[$2]             "; aFncLine="${aFncLine:0:17} $3"; # aFncLine="${aFncLine/ \//\/}";
#         aFncLine="${aFncLine/ \//\/}";  aFncLine="${aFncLine/ C:/C:}";  aFncLine="${aFncLine/ D:/D:}";  aFncLine="${aFncLine/ M:/M:}";

 if [   "${JPT_LOG}" != "" ]; then echo "$( date '+%Y%m%d-%H%M%S%z')  ${SCN_SERVER:0:11} ${JPT_USER:0:8}  ${aFncLine}" >>"${JPT_LOG}"; fi
 if [ -f "$LIB_LOG"        ]; then echo "$( date '+%Y%m%d-%H%M%S%z')  ${THE_SERVER:0:11} ${LIB_USER:0:8}  ${aFncLine}" >>"$LIB_LOG"; fi   # .(21112.04.1)

          } # eof logIt
#   ------- ------------------  =  ---------------------------------------------------  #  ----------------

function pause() {                                                                      # .(20409.05.3 RAM Beg)
         echo "$1"
         read -p "  Press any key to continue."
         } # eof pause                                                                      # .(20409.05.3 RAM End)
#   ------- ------------------  =  ---------------------------------------------------  #  ----------------

function askYN() {                                                                      # .(20409.05.3 RAM Beg)
         echo "    $1"
         echo ""; read -p "    Enter Yes or No: [y/n]: " aAnswer
         aAnswer=$( echo ${aAnswer} | awk '/^[ynYN]+$/' )
 if [ "${aAnswer}" == "" ]; then echo ""; echo "  * Please Yes or No."; exit; fi
         aAnswer=$( echo ${aAnswer} | awk '/^[yY]+$/ { print "y" }' )
#if [ "${aAnswer}" != "y" ]; then exit; fi

         } # eof askYN                                                                      # .(20409.05.3 RAM End)
#   ------- ------------------  =  ---------------------------------------------------  #  ----------------

function  Begin() {                                                                     # .(20409.06.1 RAM Beg)

          aArgs="";  aWhat=""; bRan=0;
      for aArg in "$@"; do
          if [ "${aArg/[ *]/}" != "${aArg}" ]; then aArg="\"${aArg}\""; fi;        # Quote arg with "*" or " "
          if [ "${aArg}"       != "${aCmd}" ]; then aArgs="${aArgs} ${aArg}"; fi   # delete "${aCmd} "
          done

  if [ "${aCmd}"     == "help" ]; then bTest=0; fi
  if [ "${bTest}" == "1"       ]; then echo ""; fi

#         aCmd=$( echo ${aCmd} | tr '[:upper:]' '[:lower:]' )
          aCmd=$1                                                                                           # .(21113.06.01)

#         logIt "${LIB}1-main1" 0 "${aFns/2Fns/1}  ${aCmd}${aArgs}"                                         # .(80920.02.2).(80923.02.2 Was "JPT1-..)

  if [ "${1:0:3}" == "ver" ] || [ "${1:0:2}" == "-v" ]; then                                                # .(20420.07.1 RAM Added Version).(21113.05.1 RAM Beg Added)
#    aVer="$( echo $0 | awk '{ match( $0, /_[dpstuv][0-9]+\.[0-9]+/ ); print substr( $0, RSTART+1, RLENGTH-1) }' )"  # .(21031.01.1 RAM Add [d...).(20416.03.8 "_p2.02", or _d1.09)
     echo ""
#    echo "  Robin's Shell Scripts Version: ${aVer}   ($( date "+%b %-d %Y %H:%M" ))"                       ##.(20429.04.1)
     echo "  ${aVtitle}: ${aVer}   (${aVdt})"                                                               # .(21113.05.2)
     if [ "${1:0:3}" == "-ve" ]; then echo "    $0"; fi                                                     # .(20620.01.1 RAM)
     echo ""
     exit
     fi                                                                                                     # .(21113.05.1 RAM End)
# if [ "${aCmd}" == "version"  ]; then echo ""; echo $0 | awk '{ gsub( /.+-v|.sh/, "" ); print "  JPT Version: " $0 }'; echo ""; exit; fi
# if [ "${aCmd}" == "version"  ]; then echo ""; echo $0 | awk '{ gsub( /.+-v|.sh/, "" ); print "  '$LIB' Version: "          $0      }'; echo ""; exit; fi  # .(80923.02.4 Was "JPT-..)
  if [ "${aCmd}" == "source"   ]; then echo ""; echo $0 | awk '{                         print "  '$LIB' Script File(s): \"" $0 "\"" }';                fi  # .(80923.02.3 Was "JPT-..)
  if [ "${aCmd}" == "source"   ]; then echo ${aFns}     | awk '{                         print "                      \""    $0 "\"" }'; echo ""; exit; fi

        } # eof Begin                                                                   # .(20409.06.1 RAM End)
#   ------- ------------------  =  ---------------------------------------------------  #  ----------------

function End() {                                                                        # .(20409.06.2 RAM Beg)

    if [ "${aWhat}" == ""  ]; then
    if [ "${bTest}" != "1" ]; then echo ""; fi; bTest=0; fi
    if [ "${bTest}" == "1" ]; then echo ""; return; fi
    if [ "${bRan}"  == "0" ]; then
    if [ "${aWhat}" != ""  ]; then echo ""; aWhat="Script for Tool"; else aWhat="Tool"; fi

       echo "* $LIB ${aWhat}, ${aCmd}, NOT FOUND"                                       # .(80923.02.11 Was JPT ${aWhat})
    if [ "${aWhat}" == ""  ]; then Help; else echo ""; fi

       fi # eif "${bRan}"  == "0"
       } # eof End                                                                      # .(20409.06.2 RAM End)
#   ------- ------------------  =  ---------------------------------------------------  #  ----------------

function isDir( ) {                                                                     # .(20623.02.2 RAM Beg Added)
         aFind="$1";        bChildOk=$3;  bRootOnly=$2
         aChild=""; if [ "${bChildOk}"  == "1" ]; then aChild="/.+"; fi
         aRoot="?"; if [ "${bRootOnly}" == "1" ]; then aRoot="$";    fi
         aDir="$( pwd | awk '{ nPos = match( tolower($0), "'"/${aFind}(${aChild})${aRoot}"'", a ); print a[0] }' )"
 echo "${aDir:1}"
    }                                                                                   # .(20623.02.2 RAM End)
#   ------- ------------------  =  ---------------------------------------------------  #  ----------------

#======= ================================================================================================== #  ===========

function sayMBugEnd() {                                                                                     # .(20620.06.1 RAM Beg)
      if [ "$1" == "1" ]; then
            echo ""; echo "----------------------------------------------------------------------------------------------------------"; echo ""
            fi
         }                                                                                                  # .(20620.06.1 RAM End)
#   ------- ------------------  =  ---------------------------------------------------  #  ----------------

function sayMsg( ) {  aMsg="$1"; aSP=$3;  aSp="";             bSP=0; if [ "${bMBug}" == "" ]; then bMBug=0; fi
#                                         aSp=" -- space --";

            dBug2="$2"; if [ "$1" == "sp" ]; then dBug2="$3"; aSP=$4; bSP=1; aMsg="$2"; fi                  # .(20620.04.1 RAM Beg Redo sp functionality)
                        if [ "$2" == "sp" ]; then dBug2="$3"; aSP=$2; fi                                    # .(20623.09.1 RAM Don't assign bSP=1, aSP=$2)
                        if [ "$3" == "sp" ]; then dBug2="$4"; aSP=$3; fi                                    # .(20623.09.2)
                        if [ "$4" == "sp" ]; then             aSP=$4; fi                                    # .(20620.04.1 RAM End).(20623.09.3)


#           bNoQuit=0;  if [ "$2"       == "2" ] || [ "$3" == "2"        ] || [ "$4" == "2"       ]; then bNoQuit=1; fi        # .(20601.02.3)
            bNoQuit=0;  if [ "${dBug2}" == "1" ] || [ "${dBug2}" == "-1" ] || [ "${dBug2}" == "2" ]; then bNoQuit=1; fi
#           bDebug1=${bDebug};  if [ "$2" != ""          ]; then bDebug1=$2;       fi
            bDebug1=${bDebug};  if [ "${dBug2}" != ""    ]; then bDebug1=${dBug2};
            fi

#   if [ "${bMBug}"  ==  "1" ]; then echo "-0- bDebug1: '${bDebug1}', bDebug: '${bDebug}', dBug2: '${dBug2}', bNoQuit: '${bNoQuit}', bSP: '${bSP}', aSP: '${aSP}', aMsg: '${aMsg}'"; fi

    if [ "${dBug2}"  == "-1" ] ||  [ "${dBug2}" == ""    ]; then bDebug1=0; fi                              # .(20620.09.1)
    if [ "${bDebug}" ==  "1" ] &&  [ "${dBug2}" == "-1"  ]; then bDebug1=1; fi                              # .(20620.09.2)
    if [ "${bDebug}" ==  "1" ] &&  [ "${dBug2}" ==  "1"  ]; then bDebug1=0; fi                              # .(20620.09.3)
    if                             [ "${dBug2}" ==  "1"  ]; then bDebug1=1; fi                              # .(20620.09.4)
    if                             [ "${dBug2}" ==  "2"  ]; then bDebug1=2; fi                              # .(20620.09.5)


#   if [ "${bDebug}" ==  "1" ] && [ "${bDebug1}" == "-1" ]; then bDebug1=1; fi                              ##.(20620.09.3 RAM Only force print if bDebug = 1 and bDebug1 = -1 )

    if [ "${bMBug}"  ==  "1" ]; then echo "-1- bDebug1: '${bDebug1}', bQuiet: '${bQuiet}', dBug2: '${dBug2}', bNoQuit: '${bNoQuit}', bSP: '${bSP}', aSP: '${aSP}', aMsg: '${aMsg}'"; fi

    if [ "${bQuiet}" ==  "1" ]  && [ "${bNoQuit}" == "0" ]; then sayMBugEnd ${bMBug}; return; fi            # .(20601.02.3).(20620.04.2 RAM Use bNoQuit).(20620.06.2)

    if [ "${bDebug1}" == "0" ];                             then sayMBugEnd ${bMBug}; return; fi;           # .(20620.06.3)

#   if [ "${aMsg}"   == "sp" ]  && [ "${bDebug}" == "1"  ]; then aSP=1; bSpace=0; fi                        # .(20502.02.1)
#   if [ "${bSP}"     == "1" ]  && [ "${bDebug}" == "1"  ]; then bSP=1; bSpace=0; fi                        # .(20502.02.3)
    if [ "${bSP}"     == "1" ]  && [ "${bSpace}" == "0"  ]; then        bSpace=1; fi                        # .(20620.07.1 RAM Why is bDebug special)

    if [ "${bMBug}"   == "1" ]; then echo "-2- bDebug1: '${bDebug1}', bDebug: '${bDebug}', bSpace:  '${bSpace}', bSP: '${bSP}', aSP: '${aSP}', aMsg: '${aMsg}'"; fi

#   if [ "${aMsg}"    == ""  ] || [ "${aMsg}" == "sp" ];    then bSpace=$(( 1 - bSpace )); aMsg="$2"; bDebug1=$3;     aSP=$4; fi  # toggle bSpace
#   if [ "${aMsg}"    == ""  ] || [ "${bSP}"  == "1"  ];    then bSpace=$(( 1 - bSpace ));            bDebug1=${bSP}; aSP=$4; fi  # toggle bSpace  # .(20502.02.1 Keep bDebug if set)
    if [ "${aMsg}"    == ""  ] || [ "${bSP}"  == "1"  ];    then bSpace=$(( 1 - bSpace ));                                    fi  # .(20620.09.6 RAM Don't re-assign bDebug1, or aSP)
    if [ "${bDebug1}" == ""  ];                             then sayMBugEnd ${bMBug}; return; fi            # .(20620.06.4).(bDebug1 can't be ''

    if [ "${bMBug}"   == "1" ]; then echo "-3- bDebug1: '${bDebug1}', bDebug: '${bDebug}', bSpace:  '${bSpace}', bSP: '${bSP}', aSP: '${aSP}', aMsg: '${aMsg}'"; fi

#   if [ "${bSpace}"  == "1" ]  && [ "${bDebug1}" != "3" ]; then echo "${aSp}"; bSpace=0; fi                                    # A leading space has just been displayed, print one next
    if [ "${bSpace}"  == "0" ]  && [ "${bDebug1}" != "3" ]; then echo "${aSp}"; bSpace=1; fi                                    # A leading space has been not displayed,  print this one

    if [ "${bDebug1}" == "1" ]; then echo "  - ${aMsg}"; fi

    if [ "${bDebug1}" == "2" ]; then echo " ** ${aMsg}";                                                    # .(20620.09.7 RAM  # Ok, pring space before exit)
    if [ "${aSP}"    == "sp" ]; then echo     "${aSp}" ; fi; ${aLstSp}; exit; fi                            # .(10706.09.2)
#   if [ "${bDebug1}" == "2" ]; then                         ${aLstSp}; exit; fi                            ##.(10706.09.3 RAM  # No trailing space on exit)

    if [ "${bDebug1}" == "3" ]; then echo     "${aMsg}"; fi
    if [ "${aSP}"    == "sp" ]; then echo     "${aSp}" ; export bSpace=1; fi                                # .(20625.04 RAM Set bSpace=1, not 0 and add export)

    if [ "${bMBug}" == "1"   ]; then echo "-4- bDebug1: '${bDebug1}', bDebug: '${bDebug}', bSpace:  '${bSpace}', aSP: '$aSP', bQuiet: '${bQuiet}', "; sayMBugEnd ${bMBug}; fi # .(20620.06.4)
    }
#   ------- ------------------  =  ---------------------------------------------------  #  ----------------

#======= ================================================================================================== #  ===========

function setArgs( ) {                                                                   # .(20429.09.8 Beg RAM Added)

    mARGs=( "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" "$9" )

    aArg1="$( echo "$1" | tr '[:upper:]' '[:lower:]' )"
    aArg2="$( echo "$2" | tr '[:upper:]' '[:lower:]' )"
    aArg3="$( echo "$3" | tr '[:upper:]' '[:lower:]' )"
    aArg4="$( echo "$4" | tr '[:upper:]' '[:lower:]' )"
    aArg5="$( echo "$5" | tr '[:upper:]' '[:lower:]' )"
    aArg6="$( echo "$6" | tr '[:upper:]' '[:lower:]' )"
    aArg7="$( echo "$7" | tr '[:upper:]' '[:lower:]' )"
    aArg8="$( echo "$8" | tr '[:upper:]' '[:lower:]' )"
    aArg9="$( echo "$9" | tr '[:upper:]' '[:lower:]' )"

#   aArg1="$( echo "${aArg1}" | awk '{ print tolower( $0 ) }' )"                        # .(20429.09.01 Beg RAM)
#   aArg2="$( echo "${aArg2}" | awk '{ print tolower( $0 ) }' )"
#   aArg3="$( echo "${aArg3}" | awk '{ print tolower( $0 ) }' )"
#   aArg4="$( echo "${aArg4}" | awk '{ print tolower( $0 ) }' )"
#   aArg5="$( echo "${aArg5}" | awk '{ print tolower( $0 ) }' )"
#   aArg6="$( echo "${aArg6}" | awk '{ print tolower( $0 ) }' )"
#   aArg7="$( echo "${aArg7}" | awk '{ print tolower( $0 ) }' )"
#   aArg8="$( echo "${aArg8}" | awk '{ print tolower( $0 ) }' )"                        # .(20429.09.01 End)

    aCmd0="$1 $2 $3"; aCmd0="$( echo "${aCmd0}" | awk '{ sub( / +$/, "" ); print }' )"
    sayMsg sp "JPFns[387]  aArg1: '$aArg1', aArg2: '$aArg2', aArg3: '$aArg3', aArg4: '$aArg4', aArg5: '$aArg5', aArg6: '$aArg6', aArg7: '$aArg7', aArg8: '$aArg8', aArg9: '$aArg9'" 0

    } # eof setArgs
#   ------- ------------------  =  ---------------------------------------------------  #  ----------------

#======= ================================================================================================== #  ===========

function getOpts() { dBug=$2
    sayMsg    "JPFns[395]  aArg1:'$aArg1', aArg2:'${aArg2}', aArg3:'$aArg3', aArg4:'$aArg4', aArg5:'$aArg5', aArg6:'$aArg6', aArg7:'$aArg7', aArg8:'$aArg8', aArg9:'$aArg9' " ${dBug} # Called 3 or 4 files

    if [ "${1/b/}" != "$1" ]; then if [ "${bDebug}"  != "1" ]; then getOpt "-b" "-de";  export bDebug=${nOpt};  fi; sayMsg "JPFns[397]  bDebug:  '${bDebug}'"  ; fi   # .(20501.01.3)
    if [ "${1/d/}" != "$1" ]; then if [ "${bDoit}"   != "1" ]; then getOpt "-d" "doit"; export bDoit=${nOpt};   fi; sayMsg "JPFns[398]  bDoit:   '${bDoit}'"   ; fi   # .(20501.01.5)
    if [ "${1/q/}" != "$1" ]; then if [ "${bQuiet}"  != "1" ]; then getOpt "-q" "qu";   export bQuiet=${nOpt};  fi; sayMsg "JPFns[399]  bQuiet:  '${bQuiet}'"  ; fi   # .(20501.01.4)
    if [ "${1/g/}" != "$1" ]; then if [ "${bGlobal}" != "1" ]; then getOpt "-g" "glo";  export bGlobal=${nOpt}; fi; sayMsg "JPFns[400]  bGlobal: '${bGlobal}'" ; fi
#   if [ "${1/l/}" != "$1" ]; then if [ "${bLocal}"  != "1" ]; then getOpt "-l" "loc";  export bLocal=${nOpt};  fi; sayMsg "JPFns[401]  bLocal:  '${bLocal}'"  ; fi

    } # eof getOpts
#   ------- ------------------  =  ---------------------------------------------------  #  ----------------

#======= ================================================================================================== #  ===========

function getOpt( ) { # echo "getObj('$1');"
#   sayMsg sp "JPFns[409]  aARG1:'${mARGs[0]}', aARG2:'${mARGs[1]}', aARG3:'${mARGs[2]}', aARG4:'${mARGs[3]}', aARG5:'${mARGs[4]}', aARG6:'${mARGs[5]}', aARG7:'${mARGs[6]}', aARG8:'${mARGs[7]}' " 1
    sayMsg    "JPFns[410]  aArg1:'$aArg1', aArg2:'$aArg2', aArg3:'$aArg3', aArg4:'$aArg4', aArg5:'$aArg5', aArg6:'$aArg6', aArg7:'$aArg7', aArg8:'$aArg8', aArg9:'$aArg9' " ${dBug} # Called 3 or 4 files

                                                   w=${#2};            nOpt=0; mKeep=( 0 1 2 3 4 5 6 7 8 )
    if [ "${aArg1:0:2}" == "$1" ] || [ "${aArg1:0:$w}" == "$2" ]; then nOpt=1; mKeep=(   1 2 3 4 5 6 7 8 ); aArg1="$aArg2"; aArg2="$aArg3"; aArg3="$aArg4"; aArg4="$aArg5"; aArg5="$aArg6"; aArg6="$aArg7"; aArg7="$aArg8"; fi
    if [ "${aArg2:0:2}" == "$1" ] || [ "${aArg2:0:$w}" == "$2" ]; then nOpt=1; mKeep=( 0   2 3 4 5 6 7 8 );                 aArg2="$aArg3"; aArg3="$aArg4"; aArg4="$aArg5"; aArg5="$aArg6"; aArg6="$aArg7"; aArg7="$aArg8"; fi
    if [ "${aArg3:0:2}" == "$1" ] || [ "${aArg3:0:$w}" == "$2" ]; then nOpt=1; mKeep=( 0 1   3 4 5 6 7 8 );                                 aArg3="$aArg4"; aArg4="$aArg5"; aArg5="$aArg6"; aArg6="$aArg7"; aArg7="$aArg8"; fi
    if [ "${aArg4:0:2}" == "$1" ] || [ "${aArg4:0:$w}" == "$2" ]; then nOpt=1; mKeep=( 0 1 2   4 5 6 7 8 );                                                 aArg4="$aArg5"; aArg5="$aArg6"; aArg6="$aArg7"; aArg7="$aArg8"; fi
    if [ "${aArg5:0:2}" == "$1" ] || [ "${aArg5:0:$w}" == "$2" ]; then nOpt=1; mKeep=( 0 1 2 3   5 6 7 8 );                                                                 aArg5="$aArg6"; aArg6="$aArg7"; aArg7="$aArg8"; fi
    if [ "${aArg6:0:2}" == "$1" ] || [ "${aArg6:0:$w}" == "$2" ]; then nOpt=1; mKeep=( 0 1 2 3 4   6 7 8 );                                                                                 aArg6="$aArg7"; aArg7="$aArg8"; fi
    if [ "${aArg7:0:2}" == "$1" ] || [ "${aArg7:0:$w}" == "$2" ]; then nOpt=1; mKeep=( 0 1 2 3 4 5   7 8 );                                                                                                 aArg7="$aArg8"; fi
    if [ "${aArg8:0:2}" == "$1" ] || [ "${aArg8:0:$w}" == "$2" ]; then nOpt=1; mKeep=( 0 1 2 3 4 5 6   8 );                                                                                                                 fi

#   sayMsg    "JPFns[422]  getOpt( '$1' '$2' ) -> mKeep: '${mKeep[*]}'; mARGs: '${mARGs[*]}'" # 1;

    mARgs=(); for i in ${mKeep[@]}; do mARgs+=( ${mARGs[$i]} );
    done; mARGs=( ${mARgs[@]} )

    sayMsg    "JPFns[427]  mARGs[$i]:'${mARGs[$i]}', mARgs: '${mARgs[*]}'"
#   done; mARGs=( ${mARgs[@]} )

#   sayMsg sp "JPFns[430]  \$1: '$1', \$2: '$2' -- nOpt:  ${nOpt}" ${bBug} # sp
#   sayMsg    "JPFns[431]  aArg1:'$aArg1', aArg2:'$aArg2', aArg3:'$aArg3', aArg4:'$aArg4', aArg5:'$aArg5', aArg6:'$aArg6', aArg7:'$aArg7', aArg8:'$aArg8', aArg9:'$aArg9' " 1 # Called 3 or 4 files
#   sayMsg    "JPFns[432]  aARG1:'${mARGs[0]}', aARG2:'${mARGs[1]}', aARG3:'${mARGs[2]}', aARG4:'${mARGs[3]}', aARG5:'${mARGs[4]}', aARG6:'${mARGs[5]}', aARG7:'${mARGs[6]}', aARG8:'${mARGs[7]}' " 1

    } # eof getOpt
#   ------- ------------------  =  ---------------------------------------------------  #  ----------------

#======= ================================================================================================== #  ===========

function setCmds( ) {
    aCmd=""; dBug=$1                                                                                        # .(20601.04.1 RAM Added dBug="$1})

#   aCmd0="${aArg1} ${aArg2} ${aArg3}";

    aCmd1=${aArg1:0:2};                               aCmd1=${aCmd1/ls/li};                                 # .(20429.09.8)
    aSub1=${aArg2:0:2};    aCmd2=${aCmd1}-${aSub1};   aSub1=${aSub1/ls/li}; aCmd2_=${aCmd2}                 # .(21027.02.2).(20429.09.9)
    aSub2=${aArg3:0:2};    aCmd3=${aCmd2}-${aSub2};   aSub2=${aSub2/ls/li}; aCmd3_=${aCmd3}                 # .(21027.02.3).(20429.09.10)

    if [ "${aCmd1}" == "he" ] || [ "${aCmd1}" == "" ]; then aCmd0="help"; aCmd="Help"; fi                   # .(20622.03.1 RAM Added aCmd="Help")

#   bSpace=1; bMBug=1    # Don't print space unless sp passed; print sayMsg debug statements
    sayMsg sp "JPFns[451]  aCmd:   '${aCmd}', aCmd1: '${aCmd1}', aCmd2: '${aCmd2}', aCmd3: '${aCmd3}', aCmd0: '${aCmd0}', bQuiet: ${bQuiet}, dBug: ${dBug}" ${dBug} # 1   # .(20601.04.2)

    } # eof setCmds
#   ------- ------------------  =  ---------------------------------------------------  #  ----------------

#======= ================================================================================================== #  ===========

function setLv() {
    sayMsg    "JPFns[459]  nLv: $1, aArg1:'$aArg1', aArg2:'$aArg2', aArg3:'$aArg3', aArg4:'$aArg4', aArg5:'$aArg5', aArg6:'$aArg6', aArg7:'$aArg7' " ${dBug}

    if [ "$1" == "1" ]; then aArg1="${aArg2}"; aArg2="${aArg3}"; aArg3="${aArg4}"; aArg4="${aArg5}"; aArg5="${aArg6}"; aArg6="${aArg7}"; aArg7="${aArg8}";
                             mARgs=(); mKeep=( 1 2 3 4 5 6 ); for i in ${mKeep[@]}; do mARgs+=( ${mARGs[$i]} ); done;  mARGs=( ${mARgs[@]} )
                             fi

    if [ "$1" == "2" ]; then aArg1="${aArg3}"; aArg2="${aArg4}"; aArg3="${aArg5}"; aArg4="${aArg6}"; aArg5="${aArg7}"; aArg6="${aArg8}";
                             mARgs=(); mKeep=(   2 3 4 5 6 ); for i in ${mKeep[@]}; do mARgs+=( ${mARGs[$i]} ); done;  mARGs=( ${mARgs[@]} )
                             fi

    if [ "$1" == "3" ]; then aArg1="${aArg4}"; aArg2="${aArg5}"; aArg3="${aArg6}"; aArg4="${aArg7}"; aArg5="${aArg8}";
                             mARgs=(); mKeep=(     3 4 5 6 ); for i in ${mKeep[@]}; do mARgs+=( ${mARGs[$i]} ); done; mARGs=( ${mARgs[@]} )
                             fi

    sayMsg    "JPFns[473]  aCmd:  '${aCmd}', nLv: $1, aArg1:'$aArg1', aArg2:'$aArg2', aArg3:'$aArg3', aArg4:'$aArg4', aArg5:'$aArg5', aArg6:'$aArg6', aArg7:'$aArg7' "
    sayMsg    "JPFns[474]  aCmd:  '${aCmd}', nLv: $1, aARG1:'${mARGs[0]}', aARG2:'${mARGs[1]}', aARG3:'${mARGs[2]}',  aARG4:'${mARGs[3]}', aARG5:'${mARGs[4]}', aARG6:'${mARGs[5]}', aARG7:'${mARGs[6]}' " sp ${dBug}

    return
    } # eof setLv
#   ------- ------------------  =  ---------------------------------------------------  #  ----------------

#======= ================================================================================================== #  ===========

function getCmd1( ) {    # dBug=""; # "1"                                               # .(20622.02.1 RAM Beg Added)

#   sayMsg    "JPFns[484]  aArg1: '${aArg1}', \$1: '$1', \$2: '$2', \$3: '$3' " 1

#   if [ "${aArg1:0:5}" == "${1:0:5}" ] || [ "${aArg1:0:5}" == "${2:0:5}" ]; then aCmd=$3; fi
#   if [ "${aArg1:0:4}" == "${1:0:4}" ] || [ "${aArg1:0:4}" == "${2:0:4}" ]; then aCmd=$3; fi
    if [ "${aArg1:0:3}" == "${1:0:3}" ] || [ "${aArg1:0:3}" == "${2:0:3}" ]; then aCmd=$3; fi
#   if [ "${aArg1:0:2}" == "${1:0:2}" ] || [ "${aArg1:0:2}" == "${2:0:2}" ]; then aCmd=$3; fi

    } # eof getCmd1                                                                     # .(20622.02.1 RAM End)
#   ------- ------------------  =  ---------------------------------------------------  #  ----------------

function getCmd( ) {    # dBug="1"; # "1"                                               # .(20601.04.3 RAM Added dBug="$3})

    if [ "${aCmd}" != "" ]; then return; fi                                             # .(20502.03.2 RAM Don't continue if already set)

    sayMsg sp "JPFns[498]  aArg1: '${aArg1}', aCmd: '${aCmd}', aCmd1: '${aCmd1}', aCmd2_: '${aCmd2_}', aCmd3_: '${aCmd3_}', \$1: '$1', \$2: '$2', \$3: '$3', \$4: '$4', \$5: '$5', dBug: ${dBug} " ${dBug} # -1

                                                                cmd=$4; dBug1=$5; c1=$1; c2=$2; c3=$3;       # .(20601.04.4).(20625.06.1 RAM Good grief)
 if [ "$4" == ""  ] || [ "$4" == "0" ] || [ "$4" == "1" ]; then cmd=$3; dBug1=$4; c1=$1; c2=$2; c3=""; fi    # .(20508.04.1 RAM).(20601.04.5).(20625.06.2)
 if [ "$3" == ""  ] || [ "$3" == "0" ] || [ "$3" == "1" ]; then cmd=$2; dBug1=$3; c1=$1; c2=""; c3=""; fi    # .(20508.04.2 RAM).(20601.04.6).(20625.06.3)

  if [ "$2" == "*" ]; then aCmd2="${aCmd2:0:2}-"; aCmd3="${aCmd3:0:2}--"; c2=""; c3="";                       # .(21027.02.4 RAM Allow 2nd Cmd to be "*")
                      else aCmd2="${aCmd2_}";     aCmd3="${aCmd3_}"; fi                                       # .(21027.02.5 RAM Gotta use original)

 if [ "${dBug1}" == "1" ]; then dBug=1; fi                                              # .(20601.04.7)
 if [ "${dBug}"  == ""  ]; then dBug=0; fi                                              # .(20601.04.7)

    sayMsg    "JPFns[510]  aArg1: '${aArg1}', aCmd1: '${aCmd1}', aCmd2: '${aCmd2}', aCmd3: '${aCmd3}', \$1: '$c1', \$2: '$c2', \$3: '$c3', dBug: ${dBug}" ${dBug}

#if [ "$3"           == ""   ]; then                                                     ##.(20508.04.3)
#if [ "${aCmd2:2:1}" == "-"  ]; then                                                     ##.(20508.04.3 RAM if "${aCmd2:2:1}" == "-").(20625.06.4)
 if [ "$c2"          == ""   ]; then                                                     # .(20508.04.3 RAM if "$2" is MT, not if "${aCmd2:2:1}" == "-").(20625.06.4)

#              bOk1=0; if [ "${aArg1:0:2}-" == "${aCmd2}" ] || [ "${aArg1}" == "$c1" ]; then bOk1=1; fi                             ##.(20625.06.5)
               bOk1=0; if [ "${aArg1:0:2}-" == "${aCmd2}" ] || [   "${c2}"  == "$c1" ]; then bOk1=1; fi                             # .(20625.06.5)
       if [ "${bOk1}" == "1" ]; then

    nLen=${#1}                                                                                                                      # .(20601.04.5 RAM Added nLen)
#   sayMsg    "JPFns[521]      Checking aCmd1:  '${aCmd1}'    == '$1',   or aArg1: '${aArg1:0:${nLen}}' == '$1', ${nLen}" ${dBug}   # .(20601.04.6 RAM Added nLen)
    sayMsg    "JPFns[522]      Checking aCmd1:  '${aCmd1}'    == '$c1'   or aArg1: '${aArg1}' == '$c1'" ${dBug}                     # .(20601.04.6 RAM Added nLen)

# if [ "${aCmd1}"           == "$1"  ]; then aCmd="$cmd"; setLv 1; return; fi
# if [ "${aArg1:0:${nLen}}" == "$1"  ]; then aCmd="$cmd"; setLv 1; return; fi           ##.(20502.03.1 RAM Special case).(20601.04.4).(20625.06.6)
  if [ "${aArg1}"           == "$c1" ]; then aCmd="$cmd"; setLv 1; return; fi           # .(20502.03.1 RAM Special case).(20601.04.4).(20625.06.6)
# if [ "${aArg1}"     == "${c1:0:2}" ]; then aCmd="$cmd"; setLv 1; return; fi           # .(20502.03.2 RAM Special case with just 2 chars)
     else
    sayMsg    "JPFns[529]      No Check aCmd1: '${aCmd1}'    == '$c1'   or '${aArg1:0:2}-' != '${aCmd2}'" ${dBug}                  # .(20601.04.6 RAM Added nLen).(20625.06.7)
       fi
##                                                                  return              # .(20508.04.4 RAM Don't continue)
    fi  # eif [ "${aCmd2:2:1}" == "-" ]
#   -----------------------------------------------------

#if [ "$4" == "" ]; then                                                                ##.(20508.04.5)
#if [ "${aCmd3:5:1}" == "-" ]; then                                                     ##.(20508.04.5).(20625.06.5)
 if [ "$c3"          == ""  ]; then                                                     # .(20508.04.5).(20625.06.5)

#   sayMsg    "JPFns[539]      Checking aCmd2a: '${aCmd2}'    == '$1-$2'    or '$2-$1'"   ${dBug}
    sayMsg    "JPFns[540]      Checking aCmd2a: '${aCmd2}'    == '$c1-$c2'  or '$c2-$c1'" ${dBug}

    if [ "${aCmd2}" == "$c1-$c2"  ]; then aCmd="$cmd"; setLv 2; return; fi   # aCmd2 <= ${aArg1:0:2}-${aArg2:0:2}, i.e. entered command   # .(20625.06.7)
#   if [ "${aCmd3}" == "$c1-$c2-" ]; then aCmd="$cmd"; setLv 2; return; fi

    if [ "${aCmd2}" == "$c2-$c1"  ]; then aCmd="$cmd"; setLv 2; return; fi              # .(20625.06.8)
#   if [ "${aCmd3}" == "$c2-$c1-" ]; then aCmd="$cmd"; setLv 2; return; fi

#   if [ "${aCmd1}" == "$c1"      ]; then aCmd="$cmd"; setLv 1; return; fi
#   if [ "${aCmd3}" == "$c1--"    ]; then aCmd="$cmd"; setLv 1; return; fi

                                                                return                  # .(20626.01.1 RAM No need to check the following if $c3 == "")

#   sayMsg    "JPFns[553]      Checking aCmd2b: '${aCmd2}'    == '$1-$3'    or '$2-$3'    or '$3-$1'    or '$3-$2'"   ${dBug}
    sayMsg    "JPFns[554]      Checking aCmd2b: '${aCmd2}'    == '$c1-$c3'  or '$c2-$c3'  or '$c3-$c1'  or '$c3-$c2'" ${dBug}

    if [ "${aCmd2}" == "$c1-$c3"  ]; then aCmd="$cmd"; setLv 2; return; fi
    if [ "${aCmd2}" == "$c2-$c3"  ]; then aCmd="$cmd"; setLv 2; return; fi
    if [ "${aCmd2}" == "$c3-$c1"  ]; then aCmd="$cmd"; setLv 2; return; fi
    if [ "${aCmd2}" == "$c3-$c2"  ]; then aCmd="$cmd"; setLv 2; return; fi

                                                                return                  # .(20508.04.6 RAM Don't continue)
    fi  # eif [ "$c3" == "" ]
#   -----------------------------------------------------

    sayMsg    "JPFns[565]      Checking aCmd3:  '${aCmd3}' == '$1-$2-$3' or '$1-$3-$2' or '$2-$3-$1' or '$2-$1-$3'  or '$3-$1-$2' or '$3-$2-$1'" ${dBug}







    if [ "${aCmd3}" == "$1-$2-$3" ]; then aCmd="$cmd"; setLv 3; return; fi
    if [ "${aCmd3}" == "$1-$3-$2" ]; then aCmd="$cmd"; setLv 3; return; fi
    if [ "${aCmd3}" == "$2-$3-$1" ]; then aCmd="$cmd"; setLv 3; return; fi
    if [ "${aCmd3}" == "$2-$1-$3" ]; then aCmd="$cmd"; setLv 3; return; fi
    if [ "${aCmd3}" == "$3-$1-$2" ]; then aCmd="$cmd"; setLv 3; return; fi
    if [ "${aCmd3}" == "$3-$2-$1" ]; then aCmd="$cmd"; setLv 3; return; fi

#   if [ "${aCmd3}" == "$1-$3-"   ]; then aCmd="$4";   setLv 2; return; fi
#   if [ "${aCmd3}" == "$3-$1-"   ]; then aCmd="$4";   setLv 2; return; fi
#   if [ "${aCmd3}" == "$2-$3-"   ]; then aCmd="$4";   setLv 2; return; fi
#   if [ "${aCmd3}" == "$3-$2-"   ]; then aCmd="$4";   setLv 2; return; fi

    sayMsg sp "JPFns[585]  aCmd: 'NOT FOUND': '${aCmd1}',  aCmd2: '${aCmd2}', aCmd3: '${aCmd3}', nLv: '${nLv}'"  ${dBug}
#   sayMsg sp "JPFns[586]  aArg1:'$aArg1', aArg2:'$aArg2', aArg3:'$aArg3', aArg4:'$aArg4', aArg5:'$aArg5', aArg6:'$aArg6', aArg7:'$aArg7'' "  ${dBug}

#   if [ "${mLv}" == "1" ]; then aArg1="${aArg2}"; aArg2="${aArg3}"; aArg3="${aArg4}"; aArg4="${aArg5}"; aArg5="${aArg6}"; aArg6="${aArg7}"; aArg7="${aArg8}"; fi
#   if [ "${nLv}" == "2" ]; then aArg1="${aArg3}"; aArg2="${aArg4}"; aArg3="${aArg5}"; aArg4="${aArg6}"; aArg5="${aArg7}"; aArg6="${aArg8}"; fi
#   if [ "${nLv}" == "3" ]; then aArg1="${aArg4}"; aArg2="${aArg5}"; aArg3="${aArg6}"; aArg4="${aArg7}"; aArg5="${aArg8}"; fi

       dBug=0

       } # eof getCmd
#   ------- ------------------  =  ---------------------------------------------------  #  ----------------

#======= ================================================================================================== #  ===========

#                          aArg1="$1";     aArg2="$2";     aArg3="$3";     aArg4="$4";     aArg5="$5";     aArg6="$6";     aArg7="$7";     aArg8="$8";     aArg9="$9";
#   sayMsg "" "JPFns[600]  aArg1:'$aArg1', aArg2:'$aArg2', aArg3:'$aArg3', aArg4:'$aArg4', aArg5:'$aArg5', aArg6:'$aArg6', aArg7:'$aArg7', aArg8:'$aArg8', aArg9:'$aArg9' " 1
#   sayMsg    "JPFns[601]    \$1:'$1',       \$2:'$2',       \$3:'$3',       \$4:'$4',       \$5:'$5',       \$6:'$6',       \$7:'$7',       \$8:'$8',       \$9:'$9' " 1

#   if [ "${bQuiet}" != "1" ]; then getOpt "qu" "-q";  bQuiet=${nOpt}; fi; sayMsg "JPT12[114]  bQuiet: '${bQuiet}'"
#   if [ "${bDebug}" != "1" ]; then getOpt "-d" "-de"; bDebug=${nOpt}; fi; sayMsg "JPT12[115]  bDebug: '${bDebug}'"
#   if [ "${bDoit}"  != "1" ]; then getOpt "do" "-do"; bDoit=${nOpt};  fi; sayMsg "JPT12[116]  bDoit:  '${bDoit}'"

#   aCmd0="${aArg1} ${aArg2} ${aArg3}";   aCmd=""

#   if [ "${aCmd1}" == "aa"       ]; then aCmd="{CmdName}";  nLv=1; fi
#   if [ "${aCmd2}" == "aa-cc"    ]; then aCmd="{CmdName}";  nLv=2; fi
#   if [ "${aCmd2}" == "cc-aa"    ]; then aCmd="{CmdName}";  nLv=2; fi
#   if [ "${aCmd3}" == "cc-bb-aa" ]; then aCmd="{CmdName}";  nLv=3; fi
#   if [ "${aCmd3}" == "aa-bb-cc" ]; then aCmd="{CmdName}";  nLv=3; fi
#   if [ "${aCmd3}" == "bb-aa-cc" ]; then aCmd="{CmdName}";  nLv=3; fi

#   getCmd "aa" "bb" "cc" "CmdName"

#   ------- ------------------  =  ---------------------------------------------------  #  ----------------

#======= ================================================================================================== #  ===========
#*\
##SRCE     +====================+===============================================+
##RFILE    +====================+=======+===================+======+=============+
#*/
