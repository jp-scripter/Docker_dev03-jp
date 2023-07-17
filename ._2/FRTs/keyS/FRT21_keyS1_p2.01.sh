#!/bin/bash
#*\
##=========+====================+================================================+
##RD         Keys               | Manage Private and Public Keys
##RFILE    +====================+=======+=================+======+===============+
##FD   JPT21-Keys.sh            |   9479|  7/07/21 13:48|   136| v1.05.81008.01
##FD   FRT21_Keys1.sh           |  55315| 12/01/22 09:03|   885| p2.01-21201.0903
##DESC     .--------------------+-------+---------------+------+---------------+
#            Use the commands in this script to manage key files for accessing
#            remote servers with SSH. See [ "${aCmd}" == "Help" ]
##LIC      .--------------------+----------------------------------------------+
#            Copyright (c) 2021 8020Data-JPT * Released under
#            MIT License: http://www.opensource.org/licenses/mit-license.php
##FNCS     .--------------------+-------+-------------------+------+-----------+
#            Show Keys          |
#            Make SSH Key       |
#            Delete SSH Key     |
#            Copy SSH Key       |
#            Show SSH Hosts     |
#            Test SSH Host      |
#            sayMsg( )          |
#            pickFile()         |
##CHGS     .--------------------+-------+-------------------+------+-----------+
# .(10705.01  7/05/21 RAM  1:00p| Change aKeyFile to aHost
# .(10705.04  7/05/21 RAM  4:00p| Next line tries to appear on same line
# .(10706.01  7/06/21 RAM  1:00p| Use _a, not _v for KeyFile version
# .(10706.02  7/06/21 RAM  2:00p| Pick from authorized_keys
##.(10706.03  7/06/21 RAM  3:00p| Different key fingerprint in Ubuntu v14
# .(10706.05  7/06/21 RAM  5:00p| Display different KeyType
# .(10706.06  7/06/21 RAM  6:00p| Could not find or delete authorized_keys
# .(10706.09  7/06/21 RAM  9:00p| Only add final blank line in Linux systems
# .(10706.10  7/06/21 RAM 10:00p| Only list _key files
# .(10707.01  7/07/21 RAM  1:00p| If no file name
# .(10707.02  7/07/21 RAM  2:00p| Add Password to SSH Config
# .(10714.01  7/07/21 RAM 10:15a| Change All-Hosts to Any-Host
# .(10715.01  7/15/21 RAM  1:30p| Added sayMsg( "", aMsg, bDebug )
# .(10718.01  7/18/21 RAM  1:00p| Try -P '' vs -N ''
# .(10718.02  7/18/21 RAM  2:00p| Add line before Invalid pick number
# .(10718.04  7/18/21 RAM  8:15p| Added 'silently' as a synonym for 'quietly'
# .(10718.05  7/18/21 RAM  8:30p| Add bQuiet for Delete
# .(30324.01  3/24/23 RAM  4:30p| Remove ma-ss for Make SSH Host 

##PRGM     +====================+===============================================+
##ID 69.600. Main               |
##SRCE     +====================+===============================================+
#*/
     bDebug=1
     bSpace=1
     aLstSp="echo "; if [ "${OS:0:3}" == "Win" ]; then aLstSp=""; fi                                        # .(10706.09.1)

     aVdt="Jul 18 2021 20:30"                                                                               # .(20601.01.1 RAM)

#    aVer="$( echo $0 | awk '{    sub(  /.+_u/,           "u"        ); sub( /\.sh/, ""); print }' )"                # "u2.02"
#    aVer="$( echo $0 | awk '{    sub(  /.+_([pstuv])/,   "v"        ); sub( /\.sh/, ""); print }' )"                # "v2.02"
#    aVer="$( echo $0 | awk '{ gensub(  /.+_([pstuv]).+/, "\\1", "g" ); sub( /\.sh/, ""); print }' )"                #  no workie
#    aVer="$( echo $0 | awk    'match( $0, /_[pstuv][0-9.]+/,  a  ); { print a[1] }' )"                              #  no workie
     aVer="$( echo $0 | awk '{  match( $0, /_[pstuv][0-9]+\.[0-9]+/ ); print substr( $0, RSTART+1, RLENGTH-1) }' )"  # "p2.02"

  if [ "${1:0:3}" == "ver" ] || [ "${1:0:2}" == "-v" ]; then                                                # .(20420.07.1 RAM Added Version)
     echo ""
#    echo "  FRTool keyS Version ${aVer}   ($( date "+%b %-d %Y %H:%M" ))"                                  ##.(20429.04.1)
     echo "  FRTool keyS Version ${aVer}   (${aVdt})"                                                       # .(20429.04.1 RAM)
     if [ "${1:0:3}" == "-vv" ]; then echo "  $0"; fi                                                       # .(20620.01.1 RAM)
     echo ""
     exit
     fi
#    -- --- ---------------  =  ------------------------------------------------------  #

function sayMsg( ) {  aMsg="$1"; aSp=""; # aSp=" -- space --";
  bDebug1=${bDebug};  if [ "$2" != "" ]; then bDebug1=$2; fi
    if [ "${bDebug1}" == "0" ]; then                return;    fi
#    echo ""; echo "-1- bDebug: ${bDebug}, \$2: $2; bSpace: '${bSpace}',  bDebug1: '${bDebug1}' != '3', aMsg: '${aMsg}'"
    if [ "${aMsg}"    == ""  ]; then bSpace=$(( 1 - bSpace )); aMsg="$2"; bDebug1=$3; fi                    # .(10715.01.3)
#             echo "-2- bDebug: ${bDebug}, \$2: $2; bSpace: '${bSpace}',  bDebug1: '${bDebug1}' != '3', aMsg: '${aMsg}'"
    if [ "${bSpace}"  == "1" ] && [ "${bDebug1}" != "3" ]; then echo "${aSp}"; bSpace=0;  fi
    if [ "${bDebug1}" == "1" ]; then echo "  - ${aMsg}"; return;    fi
    if [ "${bDebug1}" == "2" ]; then echo " ** ${aMsg}"; ${aLstSp}; exit; fi                                # .(10706.09.2 RAM Windows returns an extra blank line)
    if [ "${bDebug1}" == "3" ]; then echo     "${aMsg}"; return;    fi
    }

# -------------------------------------------------------------------------------------

    aCmd1=$( echo ${1:0:2} | tr '[:upper:]' '[:lower:]')
    aSub1=$( echo ${2:0:2} | tr '[:upper:]' '[:lower:]'); aCmd2=${aCmd1}-${aSub1}
    aOpt1=$( echo ${3:0:2} | tr '[:upper:]' '[:lower:]'); aCmd3=${aCmd2}-${aOpt1}

    if [ "${THE_SERVER}"  == "" ]; then THE_SERVER=${SCN_SERVER}; fi
    if [ "${THE_SERVER}"  == "" ]; then THE_SERVER="et100d-w10p"; fi

# -------------------------------------------------------------------------------------

     aCmd1=${aCmd1/ls/li}; aCmd1=${aCmd1/ls/li}; aCmd1=${aCmd1/ls/li};

#    aCmd2: sh-ss', aCmd3: 'sh-ss-ho'

# if [ "${bDebug}" == "1"       ]; then echo ""; echo "aCmd1aSub1: '${aCmd1:0:2}${aSub1:0:2}'"; fi; echo ""; # exit
                                        aCmd=""
  if [ "${aCmd1}" == "-h"       ]; then aCmd="Help"; fi
  if [ "${aCmd1}" == "he"       ]; then aCmd="Help"; fi
  if [ "${aCmd1}" == "ho"       ]; then aCmd="Host Help"; fi

  if [ "${aCmd1}" == "sh"       ]; then aCmd="Show Keys";           a=1; fi
  if [ "${aCmd1}" == "li"       ]; then aCmd="Show Keys";           a=1; fi
  if [ "${aCmd2}" == "sh-al"    ]; then aCmd="Show Keys";           a=2; fi
  if [ "${aCmd2}" == "sh-ke"    ]; then aCmd="Show Keys";           a=2; fi
  if [ "${aCmd2}" == "ke-sh"    ]; then aCmd="Show Keys";           a=2; fi
  if [ "${aCmd3}" == "ke-sh-al" ]; then aCmd="Show Keys";           a=3; fi
  if [ "${aCmd2}" == "li-al"    ]; then aCmd="Show Keys";           a=2; fi
  if [ "${aCmd2}" == "li-ke"    ]; then aCmd="Show Keys";           a=2; fi
  if [ "${aCmd2}" == "ke-li"    ]; then aCmd="Show Keys";           a=2; fi
  if [ "${aCmd3}" == "ke-li-al" ]; then aCmd="Show Keys";           a=3; fi

  if [ "${aCmd1}" == "ss"       ]; then aCmd="List SSH Hosts";      a=1; fi
  if [ "${aCmd2}" == "sh-ss"    ]; then aCmd="List SSH Hosts";      a=2; fi
  if [ "${aCmd3}" == "sh-ss-ho" ]; then aCmd="List SSH Hosts";      a=3; fi
  if [ "${aCmd2}" == "sh-ho"    ]; then aCmd="List SSH Hosts";      a=2; fi
  if [ "${aCmd2}" == "li-ho"    ]; then aCmd="List SSH Hosts";      a=2; fi
  if [ "${aCmd3}" == "li-ss-ke" ]; then aCmd="List SSH Hosts";      a=3; fi
  if [ "${aCmd3}" == "li-ss-ho" ]; then aCmd="List SSH Hosts";      a=3; fi
  if [ "${aCmd3}" == "li-ho-ss" ]; then aCmd="List SSH Hosts";      a=3; fi
  if [ "${aCmd3}" == "li-ho-ke" ]; then aCmd="List SSH Hosts";      a=3; fi
  if [ "${aCmd2}" == "ho-sh"    ]; then aCmd="List SSH Hosts";      a=2; fi
  if [ "${aCmd2}" == "ho-li"    ]; then aCmd="List SSH Hosts";      a=2; fi
  if [ "${aCmd3}" == "ho-sh-ke" ]; then aCmd="List SSH Hosts";      a=3; fi
  if [ "${aCmd3}" == "ho-ss-sh" ]; then aCmd="List SSH Hosts";      a=3; fi
  if [ "${aCmd3}" == "ho-li-ss" ]; then aCmd="List SSH Hosts";      a=3; fi
  if [ "${aCmd3}" == "ho-li-ke" ]; then aCmd="List SSH Hosts";      a=3; fi
  if [ "${aCmd2}" == "ss-ke"    ]; then aCmd="List SSH Hosts";      a=2; fi
  if [ "${aCmd2}" == "ss-ho"    ]; then aCmd="List SSH Hosts";      a=2; fi
  if [ "${aCmd2}" == "ss-li"    ]; then aCmd="List SSH Hosts";      a=2; fi
  if [ "${aCmd3}" == "ss-li-ke" ]; then aCmd="List SSH Hosts";      a=3; fi
  if [ "${aCmd3}" == "ss-li-ho" ]; then aCmd="List SSH Hosts";      a=3; fi
  if [ "${aCmd3}" == "ss-ho-li" ]; then aCmd="List SSH Hosts";      a=3; fi
  if [ "${aCmd3}" == "ss-ke-li" ]; then aCmd="List SSH Hosts";      a=3; fi
  if [ "${aCmd3}" == "ss-li-ke" ]; then aCmd="List SSH Hosts";      a=3; fi
  if [ "${aCmd3}" == "ss-li-ho" ]; then aCmd="List SSH Hosts";      a=3; fi

  if [ "${aCmd1}" == "ma"       ]; then aCmd="Make SSH Key";        a=1; fi
  if [ "${aCmd2}" == "ma-ke"    ]; then aCmd="Make SSH Key";        a=2; fi
  if [ "${aCmd2}" == "ss-ma"    ]; then aCmd="Make SSH Key";        a=2; fi
  if [ "${aCmd2}" == "ma-ss"    ]; then aCmd="Make SSH Key";        a=2; fi
  if [ "${aCmd3}" == "ss-ma-ke" ]; then aCmd="Make SSH Key";        a=3; fi
  if [ "${aCmd3}" == "ma-ss-ke" ]; then aCmd="Make SSH Key";        a=3; fi

  if [ "${aCmd1}" == "ss"       ]; then aCmd="Set SSH Host";        a=1; fi
  if [ "${aCmd2}" == "ss-se"    ]; then aCmd="Set SSH Host";        a=2; fi
  if [ "${aCmd2}" == "se-ss"    ]; then aCmd="Set SSH Host";        a=2; fi
  if [ "${aCmd2}" == "se-ho"    ]; then aCmd="Set SSH Host";        a=2; fi
  if [ "${aCmd3}" == "ss-se-ho" ]; then aCmd="Set SSH Host";        a=3; fi
  if [ "${aCmd3}" == "se-ss-ho" ]; then aCmd="Set SSH Host";        a=3; fi
  if [ "${aCmd2}" == "ho-se"    ]; then aCmd="Set SSH Host";        a=2; fi
  if [ "${aCmd2}" == "ho-ss"    ]; then aCmd="Set SSH Host";        a=2; fi
  if [ "${aCmd3}" == "ss-ho-se" ]; then aCmd="Set SSH Host";        a=3; fi
  if [ "${aCmd3}" == "se-ho-ss" ]; then aCmd="Set SSH Host";        a=3; fi
# if [ "${aCmd2}" == "ma-ss"    ]; then aCmd="Set SSH Host";        a=2; fi   # .(30324.01.1 RAM Remove)
  if [ "${aCmd2}" == "ma-ho"    ]; then aCmd="Set SSH Host";        a=2; fi
  if [ "${aCmd3}" == "ss-ma-ho" ]; then aCmd="Set SSH Host";        a=3; fi
  if [ "${aCmd3}" == "ma-ss-ho" ]; then aCmd="Set SSH Host";        a=3; fi
  if [ "${aCmd3}" == "ma-ho-ss" ]; then aCmd="Set SSH Host";        a=3; fi

  if [ "${aCmd1}" == "de"       ]; then aCmd="Delete SSH Key";      a=1; fi
  if [ "${aCmd2}" == "de-ke"    ]; then aCmd="Delete SSH Key";      a=2; fi
  if [ "${aCmd2}" == "ss-de"    ]; then aCmd="Delete SSH Key";      a=2; fi
  if [ "${aCmd3}" == "de-ss-ke" ]; then aCmd="Delete SSH Key";      a=3; fi
  if [ "${aCmd3}" == "ss-de-ke" ]; then aCmd="Delete SSH Key";      a=3; fi

  if [ "${aCmd1}" == "co"       ]; then aCmd="Copy SSH Key";        a=1; fi
  if [ "${aCmd2}" == "co-ke"    ]; then aCmd="Copy SSH Key";        a=2; fi
  if [ "${aCmd2}" == "ss-co"    ]; then aCmd="Copy SSH Key";        a=2; fi
  if [ "${aCmd2}" == "ss-ke"    ]; then aCmd="Copy SSH Key";        a=2; fi
  if [ "${aCmd3}" == "co-ss-ke" ]; then aCmd="Copy SSH Key";        a=3; fi
  if [ "${aCmd3}" == "ss-co-ke" ]; then aCmd="Copy SSH Key";        a=3; fi

  if [ "${aCmd1}" == "te"       ]; then aCmd="Test SSH Host";       a=1; fi
  if [ "${aCmd2}" == "ss-ho"    ]; then aCmd="Test SSH Host";       a=2; fi
  if [ "${aCmd2}" == "ho"       ]; then aCmd="Test SSH Host";       a=2; fi
  if [ "${aCmd2}" == "te-ho"    ]; then aCmd="Test SSH Host";       a=2; fi
  if [ "${aCmd3}" == "te-ss-ho" ]; then aCmd="Test SSH Host";       a=3; fi

#         sayMsg "keyS1[179]  aCmd: '${aCmd}', aCmd1: '${aCmd1}', aCmd2: '${aCmd2}', aCmd3: '${aCmd3}'" 2

# ----------------------------------------------------------------------------------------------------------
#
#    HELP
#
# == ==== =================================================================================================================

  if [ "${aCmd}"  == "" ] || [ "${aCmd}" == "Help" ]; then

     echo ""
     echo "  Useful formR keyS Commands ${aVer}   (${aVdt})"                  # .(20620.01.1 RAM
     echo "  ---------------------------------------------------------------  ----------------------------------------"
     echo ""
     echo "    keyS  List                                                     List Private and Public Key Files "
     echo "          Host Help                                                Host Naming Conventions"
     echo ""
#    echo "    keyS  Make SSH Key  {Account}   {Host} {KeyOwner} {Repo}       Make SSH Keyfile"
#    echo "          Make SSH Key  {Account}   {Host} {KeyName}               Make SSH Keyfile"
     echo "    keyS  Make SSH Key  {KeyOwner}  {Host} {HostUser} {Resource}   Make SSH Keyfile"
     echo "                        {KeyOwner}                                 Owner of the Private and Public Key files"
     echo "                                    {Host}                           IP Address or Name of Host (e.g. GitHub)"
     echo "                                                                     if not given, \"Any-Host\""           # .(10714.01.1)
     echo "                                           {HostUser}              UserID within the Host Server or Service"
     echo "                                                                     with access to Host Resources"
     echo "                                                                     can be \"account\" for All Resources"
     echo "                                                      {Resource}   Name of Resource, e.g. GitHub Respository"
     echo ""
     echo "    keyS  Delete SSH Key  {KNo} [au[thorized_keys]]                Delete Key File. If {KNo} = 0, pick from list"
     echo "          Copy SSH Key  {KNo}                                      Copy text of Public Key into clipboard"
     echo "          List SSH Hosts Keys                                      List Keys for Hosts in SSH Config"
#    echo "          Set  SSH Host {KNo} {Host} {Account} {Repo} {KeyOwner}   Set  Host Alias Name in SSH Config"
     echo "          Set  SSH Host {KNo}       {Host} {HostUser} {Resource}   Set  Host Alias Name in SSH Config"
     echo "          Test SSH Host {HostAliasName}                            Test Host Alias Name with SSH"
     echo ""
     echo "  Notes: Only two lowercase letter are needed for each command, seperated by spaces"
     echo "         One or more command options follow. Help for the command is dispayed if no options are given"
     echo "         The options, debug, doit and quietly, can follow anywhere after the command"
     ${aLstSp}                                                                                              # .(10706.09.3)
     exit
     fi
# -------------------------------------------------------------------------------------

  if [ "${aCmd}"  == "Host Help" ]; then
     echo ""
     echo "         While keys belong individual people, they are used to gain entry into "
     echo "         Host Servers and Web Services, like GitHub or Amazon's AWS. They enter as "
     echo "         a Host User that may be different than the Key Owner.  Once inside the "
     echo "         Key can also unlock one or more services within the Host."
     ${aLstSp}                                                                                              # .(10706.09.4)
     exit
     fi
# -------------------------------------------------------------------------------------
#         sayMsg "Shifting ${a} times" 2

     if [ "${a}" == "1" ]; then shift; fi
     if [ "${a}" == "2" ]; then shift; shift; fi
     if [ "${a}" == "3" ]; then shift; shift; shift; fi

#         sayMsg "aCmd: ${aCmd}: $1 \"$2\" \"$3\" \"$4\" \"$5\"" 1

             aArg7="$7";  aArg8="$8";    bQuiet=0; aArg1="$1";     aArg2="$2";     aArg3="$3";     aArg4="$4";     aArg5="$5";     aArg6="$6";
     if [ "${aArg1:0:2}" == "qu" ]; then bQuiet=1; aArg1="$aArg2"; aArg2="$aArg3"; aArg3="$aArg4"; aArg4="$aArg5"; aArg5="$aArg6"; aArg6="$aArg7"; aArg7="$aArg8"; fi
     if [ "${aArg2:0:2}" == "qu" ]; then bQuiet=1;                 aArg2="$aArg3"; aArg3="$aArg4"; aArg4="$aArg5"; aArg5="$aArg6"; aArg6="$aArg7"; aArg7="$aArg8"; fi
     if [ "${aArg3:0:2}" == "qu" ]; then bQuiet=1;                                 aArg3="$aArg4"; aArg4="$aArg5"; aArg5="$aArg6"; aArg6="$aArg7"; aArg7="$aArg8"; fi
     if [ "${aArg4:0:2}" == "qu" ]; then bQuiet=1;                                                 aArg4="$aArg5"; aArg5="$aArg6"; aArg6="$aArg7"; aArg7="$aArg8"; fi
     if [ "${aArg5:0:2}" == "qu" ]; then bQuiet=1;                                                                 aArg5="$aArg6"; aArg6="$aArg7"; aArg7="$aArg8"; fi
     if [ "${aArg6:0:2}" == "qu" ]; then bQuiet=1;                                                                                 aArg6="$aArg7"; aArg7="$aArg8"; fi
     if [ "${aArg7:0:2}" == "qu" ]; then bQuiet=1;                                                                                                 aArg7="$aArg8"; fi
     if [ "${aArg8:0:2}" == "qu" ]; then bQuiet=1;                                                                                                                 fi

     if [ "${aArg1:0:2}" == "si" ]; then bQuiet=1; aArg1="$aArg2"; aArg2="$aArg3"; aArg3="$aArg4"; aArg4="$aArg5"; aArg5="$aArg6"; aArg6="$aArg7"; aArg7="$aArg8"; fi
     if [ "${aArg2:0:2}" == "si" ]; then bQuiet=1;                 aArg2="$aArg3"; aArg3="$aArg4"; aArg4="$aArg5"; aArg5="$aArg6"; aArg6="$aArg7"; aArg7="$aArg8"; fi
     if [ "${aArg3:0:2}" == "si" ]; then bQuiet=1;                                 aArg3="$aArg4"; aArg4="$aArg5"; aArg5="$aArg6"; aArg6="$aArg7"; aArg7="$aArg8"; fi
     if [ "${aArg4:0:2}" == "si" ]; then bQuiet=1;                                                 aArg4="$aArg5"; aArg5="$aArg6"; aArg6="$aArg7"; aArg7="$aArg8"; fi
     if [ "${aArg5:0:2}" == "si" ]; then bQuiet=1;                                                                 aArg5="$aArg6"; aArg6="$aArg7"; aArg7="$aArg8"; fi
     if [ "${aArg6:0:2}" == "si" ]; then bQuiet=1;                                                                                 aArg6="$aArg7"; aArg7="$aArg8"; fi
     if [ "${aArg7:0:2}" == "si" ]; then bQuiet=1;                                                                                                 aArg7="$aArg8"; fi
     if [ "${aArg8:0:2}" == "si" ]; then bQuiet=1;                                                                                                                 fi

                                         bDoit=0;
     if [ "${aArg1:0:2}" == "do" ]; then bDoit=1;  aArg1="$aArg2"; aArg2="$aArg3"; aArg3="$aArg4"; aArg4="$aArg5"; aArg5="$aArg6"; aArg6="$aArg7"; aArg7="$aArg8"; fi
     if [ "${aArg2:0:2}" == "do" ]; then bDoit=1;                  aArg2="$aArg3"; aArg3="$aArg4"; aArg4="$aArg5"; aArg5="$aArg6"; aArg6="$aArg7"; aArg7="$aArg8"; fi
     if [ "${aArg3:0:2}" == "do" ]; then bDoit=1;                                  aArg3="$aArg4"; aArg4="$aArg5"; aArg5="$aArg6"; aArg6="$aArg7"; aArg7="$aArg8"; fi
     if [ "${aArg4:0:2}" == "do" ]; then bDoit=1;                                                  aArg4="$aArg5"; aArg5="$aArg6"; aArg6="$aArg7"; aArg7="$aArg8"; fi
     if [ "${aArg5:0:2}" == "do" ]; then bDoit=1;                                                                  aArg5="$aArg6"; aArg6="$aArg7"; aArg7="$aArg8"; fi
     if [ "${aArg6:0:2}" == "do" ]; then bDoit=1;                                                                                  aArg6="$aArg7"; aArg7="$aArg8"; fi
     if [ "${aArg7:0:2}" == "do" ]; then bDoit=1;                                                                                                  aArg7="$aArg8"; fi
     if [ "${aArg8:0:2}" == "do" ]; then bDoit=1;                                                                                                                  fi

                                         bDebug=0;
     if [ "${aArg1:0:2}" == "de" ]; then bDebug=1; aArg1="$aArg2"; aArg2="$aArg3"; aArg3="$aArg4"; aArg4="$aArg5"; aArg5="$aArg6"; aArg6="$aArg7"; aArg7="$aArg8"; fi
     if [ "${aArg2:0:2}" == "de" ]; then bDebug=1;                 aArg2="$aArg3"; aArg3="$aArg4"; aArg4="$aArg5"; aArg5="$aArg6"; aArg6="$aArg7"; aArg7="$aArg8"; fi
     if [ "${aArg3:0:2}" == "de" ]; then bDebug=1;                                 aArg3="$aArg4"; aArg4="$aArg5"; aArg5="$aArg6"; aArg6="$aArg7"; aArg7="$aArg8"; fi
     if [ "${aArg4:0:2}" == "de" ]; then bDebug=1;                                                 aArg4="$aArg5"; aArg5="$aArg6"; aArg6="$aArg7"; aArg7="$aArg8"; fi
     if [ "${aArg5:0:2}" == "de" ]; then bDebug=1;                                                                 aArg5="$aArg6"; aArg6="$aArg7"; aArg7="$aArg8"; fi
     if [ "${aArg6:0:2}" == "de" ]; then bDebug=1;                                                                                 aArg6="$aArg7"; aArg7="$aArg8"; fi
     if [ "${aArg7:0:2}" == "de" ]; then bDebug=1;                                                                                                 aArg7="$aArg8"; fi
     if [ "${aArg8:0:2}" == "de" ]; then bDebug=1;                                                                                                                 fi

#         sayMsg "keyS1[279]  aArg1: '${aArg1}', aArg2: '${aArg2}', aArg3: '${aArg3}', aArg4: '${aArg4}', bDoit: '${bDoit}', bDebug: '${bDebug}', bQuiet: '${bQuiet}'" 2

          aServer=${THE_SERVER}; if [ "${aServer}" == "" ]; then aServer="${SCN_SERVER}"; fi
          aOS="linux"; if [ "${aServer:7:1}" == "w" ]; then aOS="windows"; fi
                       if [ "${aServer:7:1}" == "m" ]; then aOS="mac";     fi
          aServer=${aServer:0:6}
#         sayMsg "aServer: ${aServer}, aOS: ${aOS}" 2 exit

# ----------------------------------------------------------------------------------------------------------

     sayMsg "keyS1[289]  Begin Keys Commands"


#    SHOW KEYS
#
# == ========= ============================================================================================================

     sayMsg "keyS1[296]  Show Keys"
  if [ "${aCmd}" == "Show Keys" ]; then

     cd ~/.ssh

# ----------------------------------------------------------------------------------------------

#   mFileList=( $( rdir | awk '/key|rsa/' ) )
#   readarray -t mFileList < <( rdir -s 2 -x '#' | awk '!/_keys/' | awk '/key|rsa/' )                       ##.(10706.10.1)
    readarray -t mFileList < <( rdir -s 2 -x '#' | awk '!/_keys/' | awk '/_key/'    )                       # .(10706.10.1 RAM Only _key and _key.pub)

    echo ""
    echo "No. Key File Name / Comment                                        Date / Fingerprint"
    echo "--- -------------------------------------------------------------  -----------------------------------------------------"
    echo "    Private keys for accessing remote servers from (${THE_SERVER:0:6})"
    echo "--- -------------------------------------------------------------  -----------------------------------------------------"

#   for f in ~/.ssh/*_key; do ssh-keygen -l -f "$f"; done

if [ "${#mFileList[@]}" == "0" ]; then
    echo "  * There are no private keys in the folder: ~/.ssh";
    echo ""
#   exit
    fi

    i=1
for aFileStat in "${mFileList[@]}"; do

# 123456789 123456789 123456789 123
#        2635  2021-05-16 21:20  ./robinmattern@github-account_v210516_key
#                                  suzeeparker@github-robinmattern-formr_v210516_key.pub
#                  ssh-keygen -lf  id_rsa.pub

    aFile=${aFileStat:34}
    aDate=${aFileStat:14:16}
    aDate=$( ls -l --time-style=full-iso ${aFile} | awk '{ print $6" "substr($7,1,11) }' )

#   echo "${i}) ${aFileStat:0:33}  -- ${aFile}"

if [ "${aFile/pub/}" != "${aFile}" ]; then

    aKey=$( ssh-keygen -lf ./${aFile} )
#   echo  "${i} ${aFile} ${aDate} ${aKey}" | awk '{ printf "%3d. %-55s %s %-15s %s\n", $1, $2, $3" "$4, $7, $6 }'
    echo  "${i} ${aFile} ${aDate}"         | awk '{ printf "%2d. %-62s %s \n",         $1, $2, $3" "$4 }'

    readarray -t mKeys < <( ssh-keygen -l -f ${aFile} ); #   echo "------";  echo ${mKeys};  echo "------"
 for aKey in "${mKeys[@]}"; do
     echo ${aKey} | awk '{ printf "%2s  %-62s %s\n", "", $3, $2 }'
     done

     i=$(( i + 1 ))
     echo ""
#    ${aLstSp}                                                                                              # .(10706.09.5)
     fi
     done

# ----------------------------------------------------------------------------------------------------------

     aDate=""
 if [ -f "authorized_keys" ]; then                                                                          # .(10706.06.1 RAM Use two [[ ]]s)

#    aDate=$( rdir  'authorized_keys' | awk 'NR == 4 { print $2" "$3 }' )
     aDate=$( ls -l --time-style=full-iso 'authorized_keys' | awk '{ print $6" "substr($7,1,11) }' )
     fi

     echo ""
     echo "No. Key Comment                                                    Date / Fingerprint"
     echo "--- -------------------------------------------------------------  --------------------------------------------------"
     echo "    Public keys for accessing this server (${THE_SERVER:0:6})                 ${aDate}"
     echo "--- -------------------------------------------------------------  --------------------------------------------------"

 if [ ! -f "authorized_keys" ]; then                                                                        # .(10706.06.2)
     echo "  * There are no public keys in the file: ~/.ssh/authorized_keys";
     echo ""
     exit
     fi

#    cat authorized_keys # | awk '{ aKey = substr($2,1,54); printf "%3d. %-55s %s... \n", NR, $3, aKey }'
#    cat authorized_keys   | awk '{ split( $0, mKey, " "); aCmt=mKey[3]; aKey = substr($2,1,50); printf "%3d. %-55s %s...\n", NR, aCmt, aKey  }'
#    cat authorized_keys   | awk '{ sub( /.+ /, "cc", aCmt ); aKey = substr($2,1,50); printf "%3d. %-55s %s...\n", NR, aCmt, aKey  }'
#    cat authorized_keys   | awk '{ aCmt = substr($0,382,22) "---"; aKey = substr($2,1,50); printf "%3d. %-55s %s...\n", NR, aCmt, aKey  }'
#    cat authorized_keys   | awk '{ aCmt = substr($0,382,22) "---"; aKey = substr($2,1,50); printf "%3d. %-55s %s...\n", NR, $3"..." , aKey  }'
#    cat authorized_keys   | awk '{ nLen = length($3); aKey = substr($2,1,50); printf "%3d. %-55s %s...\n", NR, substr( $3, 1, nLen-1) , aKey  }'

#   if [ -n "$line" ] && [ "${line###}" == "$line" ]; then  # Make sure lone isn't a comment or blank.
#        echo "$line"  >| "$TEMPFILE"
#        ssh-keygen -l -f "$TEMPFILE"
#        fi

#  if [ "${aOS}" == "linux" ]; then                                                                                                    ##.(10706.03.1)
      ssh-keygen -l -f ~/.ssh/authorized_keys | awk '{ nLen = length($3); printf "%2d. %-62s %s\n", NR, substr( $3, 1, nLen-1), $2 }'  # .(10706.03.2 RAM This Works)
#  else                                                                                                                                ##.(10706.03.3 Beg)
#  while read line; do
#    [[ -n "$line" ]] && [ "${line###}" = "$line" ] &&                               ssh-keygen -l -f /dev/stdin <<<$line | awk '{ nLen = length($3); printf "%3d. %-62s %s\n", NR, substr( $3, 1, nLen-1), $2 }';
##   [[ -n "$line" ]] && [ "${line###}" = "$line" ] && awk '{ printf "%s\n", $0 }' | ssh-keygen -l -f /dev/stdin
##   [[ -n "$line" ]] && [ "${line###}" = "$line" ] && printf '%s\n' "$line"       | ssh-keygen -l -f /dev/stdin          | awk '{ nLen = length($3); printf "%3d. %-62s %s\n", NR, substr( $3, 1, nLen-1), $2 }'
##   [[ -n "$line" ]] && [ "${line###}" = "$line" ] && printf '%s\n' "$line"       | ssh-keygen -l -f /dev/stdin <<<$line | awk '{ nLen = length($3); printf "%3d. %-62s %s\n", NR, substr( $3, 1, nLen-1), $2 }'
##   [[ -n "$line" ]] && [ "${line###}" = "$line" ] && printf '%s\n' "$line"       | awk '{ print }'
#    done < ~/.ssh/authorized_keys
#    fi                                                                                                                                ##.(10706.03.3 End)

     ${aLstSp}                                                                                              # .(10706.09.6)
     fi # eoc Show Keys --------------------------------------------------------------------------------


#    MAKE SSH KEY
#
# == ============ =========================================================================================================

     sayMsg "keyS1[405]  Make SSH Key (${aCmd})"

  if [ "${aCmd}" == "Make SSH Key" ]; then

  if [ "$1" == "" ]; then
     echo "";
     echo "  Make an SSH Keyfile using with ssh-keygen"
     echo ""
     echo "         Make SSH Key  {KeyOwner}  {Host} {HostUser} {Resource}  Make SSH Keyfile"
     echo ""
     echo "                       {KeyOwner}                                Owner of the Private and Public Key files"
     echo "                                   {Host}                          IP Address or Name of Host (e.g. GitHub)"
     echo "                                                                   if not given, \"Any-Host\""           # .(10714.01.1)
     echo "                                          {HostUser}             UserID within the Host Server or Service"
     echo "                                                                   with access to Host Resources"
     echo "                                                                   can be \"account\" for All Resources"
     echo "                                                     {Resource}  Name of Resource, e.g. GitHub Respository"
     ${aLstSp}                                                                                              # .(10706.09.7)
     exit
     fi

#    ------------------------------------------------------------------
     sayMsg "keyS1[427]  aArg1: '${aArg1}', aArg2: '${aArg2}', aArg3: '${aArg3}', aArg4: '${aArg4}', "

#    aKeyOwner="${aArg1}"
#    aHost="${aArg2}"
#    aKeyName="${aArg3}"
#    aRepoName="${aArg4}"

#  if [ "${aHost}" == "" ];                                        then aHost="Any-Host"; fi                        # .(10714.01.2 RAM Change All-Hosts to Any-Host)
## if [ "${aHost}" == "All-Hosts" ];                               then aHost="Any"; aHostUser="Account"; fi        # .(10714.01.3)
#
#                                                                       aHostUser="${aKeyName}"
#  if [ "${aKeyName}" == ""          ];                            then aHostUser="Hosts"; aKeyName="Account"; fi
#  if [ "${aKeyName}" == "Account"   ] && [ "${aHost}" == "any" ]; then aHostUser="Accounts";                  fi   # .(10714.01.4)
## if [ "${aKeyName}" == "Account"   ] && [ "${aHostUser}" == "Hosts" ]; then aHostUser="$( echo ${aKeyOwner} | awk '{ sub( /[.-_].+/, "" ); print }' )"; fi
#  if [ "${aKeyName/-/}" != "${aKeyName}" ];                       then aHostUser="${aKeyName/.+-/}"; fi
#
#  if [ "${aRepoName}" != ""        ];                             then aRepoName="-${aRepoName}";    fi

     aKeyOwner="${aArg1}"
     aHost="${aArg2}"
     aHostUser="${aArg3}"
     aResource="${aArg4}";                if [ "${aArg5}" != "" ]; then aResource="${aArg4}-${aArg5}"; fi
#    aKeyName="$( echo ${aKeyOwner} | awk '{ sub( /[.-_].+/, "" ); print }' )"
     aKeyName="$( echo ${aKeyOwner} | awk '{ sub( /\..+/,    "" ); print }' )"

   if [ "${aHost}" == "" ];                                        then aHost="Any-Host"; fi                        # .(10714.01.5)

   if [ "${aHostUser}" == "" ];                                    then aHostUser="${aKeyName}"; fi
   if [ "${aHostUser/${aKeyName}/}" != "${aHostUser}" ];           then aHostUser="${aResource}"; aResource=""; fi

   if [ "${aHostUser}" != "" ];                                    then aHostUser="_${aHostUser}"; fi
   if [ "${aResource}" != "" ];                                    then aResource="_${aResource}"; fi

     aDate=$( date '+%y%m%d' );                                              # sayMsg "keyS1[461]  aDate: '${aDate}'" 2
#    aKeyFile=${aKeyOwner}@${aHost}_${aHostUser}${aRepoName}_v${aDate};        sayMsg "keyS1[462]  aKeyFile: '${aKeyFile}'" 2
#    aKeyFile=${aKeyOwner}@${aHost}${aHostUser}${aResource}_v${aDate};         sayMsg "keyS1[463]  aKeyFile: '${aKeyFile}'"
     aKeyFile=${aKeyOwner}@${aHost}${aHostUser}${aResource}_a${aDate};         sayMsg "keyS1[464]  aKeyFile: '${aKeyFile}'" # .(10706.01.1 RAM Use _a)

#    -----------------------------------------------------------------

     aDoit=""
#    aDoit="doit"
  if [ "${bDoit}"  == "1" ]; then aDoit="doit"; fi

     aQuiet=""; aPassPhrase=
  if [ "${bQuiet}" == "1" ]; then
#    aQuiet1="-N \"\" -q ";
     aQuiet1="-P '' -q ";                                                                                                   # .(10718.01.1 RAM Try -P '' vs -N '')
#    aQuiet1="-N '' -q ";
#    aQuiet2="-N \${aPassPhrase} -q ";                                                                                      ##.(10718.01.1)

     if [ -f "${HOME}/.ssh/${aKeyFile}_key" ] && [ "${aDoit}" == "doit" ]; then rm "${HOME}/.ssh/${aKeyFile}_key"; fi       # .(10706.06.3)
     fi

#    bQuiet=0                                                                                                               # .(10718.02.1 RAM ???)
  if [ "${bQuiet}" == "0" ]; then
     sayMsg  "keyS1[484]  ssh-keygen -t rsa ${aQuiet1}-f \"${HOME}/.ssh/${aKeyFile}_key\" -C \"${aKeyFile}\"" 1 ;
#    sayMsg  "" "aDoit: '${aDoit}', bQuiet1: '${bQuiet1}'" 1;
  if [ "${bDoit}" == "1" ]; then echo ""; fi
     fi

 if [ "${aDoit}" == "doit" ]; then

          eval "ssh-keygen -t rsa ${aQuiet1}-f \"${HOME}/.ssh/${aKeyFile}_key\" -C \"${aKeyFile}\""; nErr=$?

#    if [ "${bQuiet}" == "0"    ]; then echo ""; fi
     fi

     if [ "${bQuiet}" == "0"    ]; then
     if [ "${aDoit}"  != "doit" ] || [ "${nErr}" == "1" ]; then aNOT="NOT "; else aNOT=""; fi
     echo ""
     sayMsg "A new keyfile has ${aNOT}been saved to: ${HOME}/.ssh/${aKeyFile}_key" 1
     if [ "${aDoit}"  != "doit" ]; then sayMsg "Add \"doit\" to the command to really make the key file." 1; fi
     fi

     ${aLstSp}                                                                                              # .(10706.09.8)
     fi # eoc Make SSH Key ----------------------------------------------------------------------------


#    pickFile
#
# == ======== =============================================================================================================

function pickFile() {

  if [ "$2" == "authorized_keys" ]; then                                                                    # .(10706.02.1 Beg RAM Pick from authorized_keys)

      aKeyType="Public Key"                                                                                 # .(10706.05.1)

#     mKeys=( $( cat ~/.ssh/authorized_keys | awk 'NF > 0 { nLen = length($3); printf "%3d. %-62s\n", NR, substr( $3, 1, nLen-1) }' ) )
#     mKeys=( $(   cat ~/.ssh/authorized_keys | awk 'NF > 0 { printf "%3d. %-62s\n", NR, $3 }' ) )
#     mKeys=$(     cat ~/.ssh/authorized_keys | awk 'NF > 0 { printf "%3d. %-62s\n", NR, $3 }' )
#                  cat ~/.ssh/authorized_keys | awk 'NF > 0 { printf "%3d. %-62s\n", NR, $3 }'
#                  cat ~/.ssh/authorized_keys

      readarray -t mKeys < <( cat ~/.ssh/authorized_keys | awk 'NF > 0 { printf "%2d. %-62s\n", NR, $3 }' )

#if [ ! -a "~/.ssh/authorized_keys" ]; then                                                                 ##.(10706.06.4 It was a PC delimitedd file!!!)
 if [ "${mKeys}" == "" ]; then                                                                              # .(10706.06.4)
      echo "  * There are no Public Keys in the file: ~/.ssh/authorized_keys";
      echo ""
      aArg1=""
      exit
      fi

    else                                                                                                    # .(10706.02.2)
#     -------------------------------------------------------------

      aKeyType="Private Key File"                                                                           # .(10706.05.2)

      aSSH_Dir="~/.ssh";  aSSH_Dir="${HOME}/.ssh"; aSSH_Dir="${aSSH_Dir/\/c/C:}"
      aCmd="rdir -s 2 \"${aSSH_Dir}\" _key.pub";                                       # sayMsg "pickFile[ 2] ${aCmd}" 1
#     mKeys=( $( rdir "${aSSH_Dir}" | awk '/_key.pub/ { printf "%4d %s\n", NR, $4 $5 $6 $7 }' ) )
#     mKeys=$(            ${aCmd} | awk 'NR > 3 && NF > 0' | awk '{ sub( /^.+\.ssh/, "~/.ssh" ); printf "%4d %s\n", NR, $0 }' )
#     mKeys=$( bash -c '( ${aCmd} | awk 'NR > 3 && NF > 0' | awk '{ sub( /^.+\.ssh/, "~/.ssh" ); printf "%4d %s\n", NR, $0 }' )' )

#     readarray -t mKeys < <( ${aCmd} | awk 'NR > 3 && NF > 0' | awk '{ sub( /^.+\.ssh/, "~/.ssh" ); printf "%3d. %s\n", NR, $0 }' )
      readarray -t mKeys < <( ${aCmd} | awk 'NR > 3 && NF > 0' | awk '{ sub( /^.+\.ssh\//, "" ); printf "%2d. %s\n", NR, $0 }' )

      fi                                                                                                    # .(10706.02.3)
#     -------------------------------------------------------------

      if [ "${aArg1}" == "" ] || [ "${aArg1}" == "0" ]; then

      echo ""
  if [ "$2" == "authorized_keys" ]; then
      echo ""
      echo "No. Public Keys for accessing this server (${THE_SERVER:0:6})                       ${aDate}"
      echo "--- -------------------------------------------------------------  --------------------------------------------------"
    else
      echo "No. Private Key Files for accessing remote servers"
#     echo "--- -------------------------------------------------------------  --------------------------------------------------"
      echo "--- -------------------------------------------------------------"
      fi

      if [ "${#mKeys[@]}" == "0" ]; then
         echo "  * There are no ${aKeyType}s";
         aArg1=""
         echo ""
         exit
         fi

     for aFile in "${mKeys[@]}"; do echo "${aFile}"; done

         echo ""; read -p "    Enter the number of a ${aKeyType} to $1: " aAnswer                           # .(10706.05.3)
         aAnswer=$( echo ${aAnswer} | awk '/^[0-9]+$/' ); bSpace=0
         if [ "${aAnswer}" == "" ]; then echo ""; sayMsg "Please enter a number." 2; fi                     # .(10718.02.2 RAM Add line before msg)
#        echo "";                                                                                           ##.(10705.04.1)
         aArg1=${aAnswer}
#        echo "";                                                                                           ##.(10705.04.2)
         if [ "${OS:0:3}" == "Win" ]; then echo ""; fi                                                      # .(10705.04.2 Next line tries to appear on same line)

         fi  # eif "${aArg1}" == "0"
#    -------------------------------------------------------------

                                                            sayMsg "pickFile[ 3] mKeys[#]: ${#mKeys[@]}"
                                                         ## sayMsg "pickFile[ 4] mKeys: ${mKeys}"                1
#                                                         # sayMsg "pickFile[ 5] aArg1: ${aArg1}"                1
     for aFile in "${mKeys[@]}"; do i=$(( i + 1 ));      ## sayMsg "pickFile[ 6]  i: ${i} == ${aArg1}"           1
     if [ "${i}" == "${aArg1}" ]; then                    # sayMsg "pickFile[ 7]  aKeyFile:      ${aFile:5}}"    1
         aKeyFile=${aFile:4}; fi;                         # sayMsg "pickFile[ 8]  ${i}) aFile: ${aFile}"         1
         done;                                            # sayMsg "pickFile[ 9]  ${i}) aFile:      ${aKeyFile}" 1

  if [ "${aKeyFile}" == "" ]; then
#        sayMsg "There is no Key File for No. ${aArg1}." 2;                                                 ##.(10706.05.3)
         sayMsg "There is no ${aKeyType} for No. ${aArg1}." 2;                                              # .(10706.05.3)
         return
         fi
#    -------------------------------------------------------------

#        aKeyFile=${aKeyFile/\~\/.ssh/${aSSH_Dir}}
         aKeyFile=${aSSH_Dir}/${aKeyFile}

     } # eof pickFile ---------------------------------------------------------------------------


#    DELETE SSH KEY
#
# == ============== =======================================================================================================

     sayMsg "keyS1[609]  Delete SSH Key"

  if [ "${aCmd}" == "Delete SSH Key" ]; then

      if [ "${aArg1:0:2}" == "au" ]; then  aArg2="au"; aArg1="0"; fi
      if [ "${aArg2:0:2}" == "au" ]; then

         pickFile "delete" "authorized_keys"
         aKeyType="Public Key"

         aKeyFile=${aKeyFile:1}; aKeyFile=$( echo ${aKeyFile} | awk '{ sub( / +$/, "" ); print }' ); aPrg="!/${aKeyFile}/"
   if [ "${bDoit}" == "1" ]; then
#        echo "awk -i inplace ${aPrg}  ~/.ssh/authorized_keys"
               awk -i inplace ${aPrg}  ~/.ssh/authorized_keys
         fi

        else

         aKeyType="Private Key"
         pickFile "delete"

   if [ "${bDoit}" == "1" ]; then
         rm ${aKeyFile}
         a=1
         fi

         fi
         aKeyFile=$( echo ${aKeyFile} | awk '{ sub( /.+\.ssh\//, "" ); print }' )
         aNot="NOT "; if [ "${bDoit}" == 1 ]; then aNot=""; fi
     if [ "${bDoit}"  != "1" ]; then sayMsg "Add \"doit\" to the command to really delete the key file." 1; fi  # .(10718.02.1 RAM Was "${aDoit}" !="doit")
     if [ "${bQuiet}" == "0" ]; then                                                                        # .(10718.05.1 RAM Add bQuiet for Delete)

         sayMsg "${aKeyType}, \"${aKeyFile/.pub/}\", ${aNot}deleted" 1
         fi                                                                                                 # .(10718.05.2)
     ${aLstSp}                                                                                              # .(10706.09.9)
     fi # eoc Delete SSH Key --------------------------------------------------------------------------


#    COPY SSH KEY
#
# == ============ =========================================================================================================

     sayMsg "keyS1[651]  Copy SSH Key"
  if [ "${aCmd}" == "Copy SSH Key" ]; then

         pickFile "copy"

  if [ "${aOS}" == "linux" ]; then
         sayMsg "Use thekeyboard to copy the Public Key text" 1
         sayMsg "cat \"${aKeyFile}\"    # (${aArg1})" 1; sayMsg "" 3
             cat  "${aKeyFile}"
       else

          aClip="clip"; if [ "${aOS}" == "mac" ]; then aClip="pbcopy";fi
#        sayMsg "clip  < \"${mKeys[${aArg1}]}\"  # (${aArg1})" 1; sayMsg  "" 3
#        sayMsg "clip  < \"${aKeyFile}\"  # (${aArg1})" 1;
         sayMsg "cat \"${aKeyFile}\" | ${aClip}    # (${aArg1})" 1;
                 cat  "${aKeyFile}"  | ${aClip}
         fi
     ${aLstSp}                                                                                              # .(10706.09.9)
     fi # eoc Copy SSH Key ----------------------------------------------------------------------------


#    LIST SSH HOSTS
#
# == ============== =======================================================================================================

     sayMsg "keyS1[676]  List SSH Hosts"
  if [ "${aCmd}" == "List SSH Hosts" ]; then

          cd ~/.ssh

      if [ ! -f ~/.ssh/config ]; then
          sayMsg "There is no ~/.ssh/config file." 2
          fi
#         ------------------------------------------

# aPrg=$( cat  <<EOF
# read -d '' aPrg <<- "_EOF_"
#  cat > "/C/Home/._0/bin/@tmp.awk"  <<EOF
# aPrg='

#         ------------------------------------------

  read -d '' aPrg << EOF
BEGIN { a="" }
  /Host /         { if (aHost > "") {                                                                       # .(10705.01.1 RAM Was aKeyFile)
#                       printf "%-50s %s\\\\n", aHost, aKeyFile
                        printf "%-49s|%-19s|%-29s|%s|\\\n", aHost, aUserID, aHostName, aKeyFile
                        }
                        aHost     = \$2; aKeyFile = "";
#                       aHost     =  substr( aHost " ### Host                                            $%", 1, 49 )
                        aHost     =  substr( aHost "                                                       ", 1, 49 )
                    }
  /IdentityFile / {     aKeyFile  = \$2; }
  /Password /     {     aKeyFile  = "Password: " \$3; }                                                     # .(10707.02.3)
  /HostName /     {     aHostName = \$2; aHostName = substr( aHostName "                             ", 1, 29 ) }
  /User /         {     aUserID   = \$2; aUserID   = substr( aUserID   "                   ",           1, 19 ) }

END               { if (aHost > "") {                                                                       # .(10705.01.2)
                        printf "%-49s|%-19s|%-29s|%s|\\\n", aHost, aUserID, aHostName, aKeyFile
                        }
                    }
EOF
#         ------------------------------------------

#       sayMsg "keyS1[715]  aPrg:" 1; sayMsg "keyS1[715]  --------------------" 1; sayMsg "keyS1[715]  ${aPrg[@]}" 3;                         sayMsg "keyS1[715]  -----------------" 1
#       sayMsg "keyS1[716]  aPrg:" 1; sayMsg "keyS1[716]  --------------------" 1; sayMsg "keyS1[716]  ${aPrg}" 3;                            sayMsg "keyS1[716]  -----------------" 1
#       sayMsg "keyS1[717]  aPrg:" 1; sayMsg "keyS1[717]  --------------------" 1; sayMsg "keyS1[717]  $( cat "/C/Home/._0/bin/@tmp.awk" )" 3; sayMsg "keyS1[717]  -----------------" 1

        IFS=$'\n'
#       mHosts=$( cat ~/.ssh/config | awk -f "/C/Home/._0/bin/@tmp.awk" )
#       mHosts=$( bash -c "( cat ~/.ssh/config | awk '/Host /' )" 2>&1 )
        mHosts=(          $( cat ~/.ssh/config | awk -e "${aPrg}"    ) )

#     echo ssh-keygen -lf " ~/.ssh/robinmattern@github-suzee-formr3_v210516_key"
#          ssh-keygen -lf   ~/.ssh/robinmattern@github-suzee-formr3_v210516_key.pub
#          ssh-keygen -lf   ~/.ssh/brucetroutman@all-accounts_v210511_key.pub
#          aFile="~/.ssh/brucetroutman@all-accounts_v210511_key.pub"  # No workie!!!
#          aFile="${HOME}/.ssh/brucetroutman@all-accounts_v210511_key.pub"  # Workie!!!
#          aFile="${HOME}/.ssh/id_rsa.pub"
#          aDir="${HOME}/.ssh"
#          ls -l "${aDir}"
#          ls -l ~/.ssh
#          ssh-keygen -lf   ${aFile}
#          exit

#          sayMsg "keyS1[736]  {#mHosts} ${#mHosts[@]}" 1

  if [ "${mHosts}" == "" ]; then
     sayMsg "No Hosts are definfed in ~/.ssh/config" 2
   else

     echo ""
     echo "     SSH Host / Key Comment                                   FileName / Fingerprint"
     echo "     -------------------------------------------------------  --------------------------------------------------"

  for aHost in "${mHosts[@]}"; do
#    sayMsg "keyS1[747]  aHost '${aHost}'" 1

     aFile=${aHost:100}; aFile=${aFile//|/}; aFile1="${aFile/\~/${HOME}}";  # sayMsg "keyS1[749]  aFile: '${aFile}', aFile1: '${aFile1}'" 1
     aName="${aHost:0:49} "; if [ "${aName}" == "" ]; then aName="...                                             "; fi;

     aHostName="${aHost:70:29} "

     aUserID="${aHost:50:19} ";                                             # sayMsg "keyS1[754]  aName: '${aName}', aHostName: '${aHostName}', aUserID: '${aUserID}'" 1

     aPassword=""                                                                                           # .(10707.02.1 Beg RAM Added Password)
 if [ "${aFile1:0:8}" == "Password" ]; then
     aPassword=": ${aFile:10}"
     aFile1=""
     fi                                                                                                     # .(10707.02.1 End)
 if [ "${aFile1}" != "" ]; then                                                                             # .(10707.01.1 RAM If no file name)

     echo "     ${aName/\?/-}    ${aFile1}"

 if [ -f "${aFile1}" ]; then
#    echo "ssh-keygen -lf \"${aFile1}\""
            ssh-keygen -lf  "${aFile1}.pub" | awk '{ nLen = length($3); printf "     %-56s %s\n", substr( $3, 1, nLen - 0 ), $2 }'
   else
     echo "   * KeyFile not found"
     fi
   else                                                                                                     # .(10707.01.2)
     echo "     ${aName/\?/-}       Uses password${aPassword}"                                              # .(10707.02.2)
     fi                                                                                                     # .(10707.01.3)

     echo "     ${aUserID}                                     ${aHostName}"
     echo ""
     done
     fi;

#    ${aLstSp}                                                                                              # .(10706.09.10)
     exit
     fi # eoc Show SSH Hosts --------------------------------------------------------------------------


#    SET SSH HOST
#
# == ============ =========================================================================================================

     sayMsg "keyS1[789]  Set SSH Hosts"
  if [ "${aCmd}" == "Set SSH Host" ]; then

  if [ "$1" == "" ]; then
     echo "";
     echo "  Set an SSH Host Name Alias in SSH Config file"
     echo "";
     echo "   Keys  Set SSH Host [{KNo}] {Host} [{HostUser}] [{Resource}]"
     echo "                       {KNo}                                     KeyFile Number. Use 0 or none to pick from a list"
     echo "                              {Host}                             Host Alias Name being set (e.g. GitHub)"
     echo "                              {Host}:{HostName|IPAddress}          can contain real hostname or IP address, "
     echo "                                                                   if not given, \"Any-Host\""           # .(10714.01.6)
     echo "                                      {HostUser}                 UserID within the Host Server or Service"
     echo "                                                                   with access to Host resources"
     echo "                                                                   can be \"account\" for all resources"
     echo "                                                   {Resource}    Name of Resource, e.g. GitHub Respository"
     ${aLstSp}                                                                                              # .(10706.09.11)
     exit
     fi

     aDoit="";  if [ "${bDoit}"  == "1" ]; then aDoit="doit ";   fi
     aDebug=""; if [ "${bDebug}" == "1" ]; then aDebug="debug "; fi

#    sayMsg "keyS1[812]  Set SSH Host: node setSSH_Host.njs ${aArg1} \"${aArg2}\" \"${aArg3}\" \"${aArg4}\"; aDebug: '${aDebug}' aDoit: '${aDoit}'" 1

     aBinDir=${0/\/keys/};
#    -------------------------------------------------------------

#    if [ "${aArg1}" == "0" ]; then
#
#         aSSH_Dir="~/.ssh";  aSSH_Dir="${HOME}/.ssh"; aSSH_Dir="${aSSH_Dir/\/c/C:}"
#         aCmd="rdir -s 2 \"${aSSH_Dir}\" _key.pub"; # sayMsg "${aCmd}" 1
##        readarray -t mKeys < <( ${aCmd} | awk 'NR > 3 && NF > 0' | awk '{ sub( /^.+\.ssh\//, "" ); printf "%3d. %s\n", NR, $0 }' )
##                     mKeys=( $( ${aCmd} | awk 'NR > 3 && NF > 0' | awk '{ sub( /^.+\.ssh\//, "" ); printf "%3d. %s\n", NR, $0 }' ) )
#                      mKeys=$(   ${aCmd} | awk 'NR > 3 && NF > 0' | awk '{ sub( /^.+\.ssh\//, "" ); printf "%3d. %s\n", NR, $0 }' )
#
#     echo ""
#     echo " No. Private key files for accessing remote servers"
##    echo "---- ----------------------------------------------------------  --------------------------------------------------"
#     echo "---- ----------------------------------------------------------"
##       "${aBinDir}/keys" show keys | awk '/_key.pub/ { print $0 }'
#         echo "${mKeys}"
#         echo ""; read -p "  Enter the number of a KeyFile to use: " aAnswer
#         aAnswer=$( echo ${aAnswer} | awk '/^[0-9]+$/' )
#         if [ "${aAnswer}" == "" ]; then sayMsg "Please enter a number." 2; fi
##        echo "";                                                                                          ##.(10705.04.1)
#         aArg1=${aAnswer}
#         fi
#    -------------------------------------------------------------

        nKeyNo=$( echo ${aArg1} | awk '/^[0-9]+$/' )
if [ "${nKeyNo}" != "" ]; then

        pickFile "use"
        fi
#       echo "";              echo "    node ${aBinDir}/setSSH_Host.njs ${aArg1} ${aDoit}${aDebug}\"${aArg2}\" \"${aArg3}\" \"${aArg4}\""
        sayMsg ""; sayMsg   "Keys[ 53]  node ${aBinDir}/setSSH_Host.njs ${aArg1} ${aDoit}${aDebug}\"${aArg2}\" \"${aArg3}\" \"${aArg4}\""

                                        node ${aBinDir}/setSSH_Host.njs ${aArg1} ${aDoit}${aDebug} "${aArg2}"   "${aArg3}"   "${aArg4}"

     ${aLstSp}                                                                                              # .(10706.09.12)
     fi # eoc Set SSH Host ----------------------------------------------------------------------------


#    TEST SSH HOST
#
# == ============= ========================================================================================================

     sayMsg "keyS1[857]  Test SSH Host"
  if [ "${aCmd}" == "Test SSH Host" ]; then

         sayMsg "keyS1[860]  Test SSH Host" 1

     ${aLstSp}                                                                                              # .(10706.09.13)
     fi # eoc Test SSH Host ---------------------------------------------------------------------------


#    NEXT COMMAND
#
# == ============ =========================================================================================================

     sayMsg "keyS1[870]  Next Command"; sayMsg ""
  if [ "${aCmd}" == "Next Command" ]; then

         sayMsg "keyS1[873]  Next Command" 1

     ${aLstSp}                                                                                              # .(10706.09.14)
     fi # eoc Next Command ----------------------------------------------------------------------------

#    END
#
# == === ==================================================================================================================

#*\
##SRCE     +====================+===============================================+
##RFILE    +====================+=======+===================+======+=============+
#*/
