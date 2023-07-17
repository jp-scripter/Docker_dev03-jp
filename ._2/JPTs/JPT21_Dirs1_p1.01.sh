#!/bin/bash
#*\
##=========+====================+================================================+
##RD         Dirs               | JScriptWare Create Project Folders
##RFILE    +====================+=======+=================+======+===============+
##FD   JPT21_Dirs1.sh           |   9479|   4/16/22  4:16a|   136| v1.05.20417.011
##DESC     .--------------------+-------+-----------------+------+---------------+
#            Use the commands in this script to create project folders.
#
##LIC      .--------------------+----------------------------------------------+
#            Copyright (c) 2022 JScriptWare.us * Released under
#            MIT License: http://www.opensource.org/licenses/mit-license.php
##FNCS     .--------------------+-------+-------------------+------+-----------+
#                               |
#                               |
#                               |
##CHGS     .--------------------+-------+-------------------+------+-----------+
# .(20420.08  4/20/22 RAM  8:06p| Created

##PRGM     +====================+===============================================+
##ID 69.600. Main               |
##SRCE     +====================+===============================================+
#*/

    aFldr=$( echo $0 | awk '{       gsub( /[//\\][^//\\]*$/,  "" ); print }' )                              # .(20416.03.1 RAM Get aVer and lost main2Fns)
#   aVer=$(  echo $0 | awk '{ v = gensub( /.+[-_]([ptu][0-9.]+).sh/, "\\1", "g", $0 ); print v }' )         # just: _p1                   # .(20416.01.1 RAM)
#   aJFns="${aFldr}/JPT12_Main2Fns_${aVer}.sh"; if [ -f "${aJFns}" ]; then source "${aJFns}";     # else    # require "JPT12-main2Fns.sh" # .(80920.02.1).(20416.03.2 RAM Check if file exists)
    aJFns="${aFldr}/JPT12_Main2Fns_p1.05.sh";   if [ -f "${aJFns}" ]; then source "${aJFns}"; fi; # fi      # .(20416.03.3 RAM Check if p1.05 exists)

    bSpace=0; setOS;
    aLstSp="echo "; if [ "${aOSv:0:1}" == "w" ]; then aLstSp=""; fi                                         # .(10706.09.1 RAM Windows returns an extra blank line)

    if [ "${bDebug}" != "1" ]; then getOpt "-d" "-de"; bDebug=${nOpt}; fi; sayMsg "JPT21[ 30]  bDebug: '${bDebug}'"
    if [ "${bQuiet}" != "1" ]; then getOpt "qu" "-q";  bQuiet=${nOpt}; fi; sayMsg "JPT21[ 31]  bQuiet: '${bQuiet}'"
    if [ "${bDoit}"  != "1" ]; then getOpt "do" "-do"; bDoit=${nOpt};  fi; sayMsg "JPT21[ 32]  bDoit:  '${bDoit}'"

            aTest=0
#   if [ "${aTest}" == "test1" ]; then  # /webs/FRTools/server
#   if [ "${aTest}" == "test2" ]; then  # /C/Repos/FRTools/server
#   if [ "${aTest}" == "test3" ]; then  # ../et218t/webs/FRTools/server
#   if [ "${aTest}" == "test4" ]; then  # ../et218t/webs/nodeapps/FRTools_/dev01-robin/client & server
#
#   --------------------------------------------

#   aCust="SCN2"; aSvr="sc178p"
    aCust="8020"; aSvr="et218t"

#   aProject="FRTools"
#   aProject="FRTools_"
#   aProject="Protest"
    aProject="$1"                       # Should have trailing _ if aStage not MT

    aStage=""
    aStage="Dev01-Robin"
    aStage="${2/./}"                    # . for none

#   a1c_App="1c-My-React-App"
#   a1s_App="1s-My-React-App"
                                   a1c_App=""
                                   a1s_App=""
    if [ "${3:1:1}" == "c" ]; then a1c_App="$3"; fi
    if [ "${3:1:1}" == "s" ]; then a1s_App="$3"; fi
    if [ "$4"       == "c" ]; then a1c_App="${a1s_App/s/c}"; fi
    if [ "$4"       == "s" ]; then a1s_App="${a1c_App/c/s}"; fi

#   a1c_App="1c-Tools"
#   a1s_App="1s-Tools"
#   a1c_AppName="1c-Tools App"
#   a1s_AppName="1s-Tools App"

#   a1c_AppName="1c-App1c"
#   a1s_AppName="1s-App1s"

#   --------------------------------------------

    bWEBs=0                             # makDir "{WEBs}/._1"

    aAppsDir=""                         # makDir "{WEBs}/._1/"
#   aAppsDir="/nodeapps"                # makDir "{WEBs}{AppsDir}/._1/"

    bDocs=0                             # makDir "{WEBs}/{Project}{Stage}/.docs/._3d"
    bClient=1                           # makDir "{WEBs}/{Project}{Stage}/client/{1c-App}/._4"
    bServer=1                           # makDir "{WEBs}/{Project}{Stage}/server/{1s-App}/._4"

    bClient=1; if [ "${a1c_App}" == "" ]; then bClient=0; fi
    bServer=1; if [ "${a1s_App}" == "" ]; then bServer=0; fi

    bFRTonly=0
#   nFRTs="1,  3d,3c,3s,  "
#   nJPTs="1,2,3d,3c,   4,"
    nFRTs="3c,"
    nJPTs="3c,"

#   -----------------------------------

 if [ "${THE_SERVER}" == "" ]; then THE_SERVER=${SCN_SERVER}; fi
 if [ "${aSvr}"       == "" ]; then aSvr="${THE_SERVER:0:5}"; fi

#   aRootDir="/C/WEBs/8020/VMs/et218t/webs/nodeapps"
    aRootDir="$( pwd )"

#   aRootDir="/C/WEBs/SCN2/VMs/${aSvr}" # SicommNet VM
#   aRootDir="/C/WEBs/8020/VMs/${aSvr}" # 8020data VM
#   aRootDir="/C"                       # Robins's PC
#   aRootDir="/C/Repos"                 # Bruce's PC
#   aRootDir=""                         # Unix Server

#if [ "${bWebs}" == "1" ]; then
                                                                                    aWEBS=""
#   if [ "$( echo "${aSvr}" | awk '//                { print 1 }' )" == "1" ]; then aWEBs=""      ; fi # Bruce's PC
    if [ "$( echo "${aSvr}" | awk '/sc[1-2][0-9]{2}/ { print 1 }' )" == "1" ]; then aWEBs="/webs" ; fi # SicommNet VM
#   if [ "$( echo "${aSvr}" | awk '/sc[1-2][0-9]{2}/ { print 1 }' )" == "1" ]; then aWEBs="/webs" ; fi # Unix Server
#   if [ "$( echo "${aSvr}" | awk '/et21[0-9]{2}/    { print 1 }' )" == "1" ]; then aWEBs="/webs" ; fi # 8020data VM
#   if [ "$( echo "${aSvr}" | awk '/rm212/           { print 1 }' )" == "1" ]; then aWEBs="/WEBs" ; fi # Robin's PC  Cust: 8020 or SCN2
#   fi

#   sayMsg "JPT21[102]  bDoit: '${bDoit}'" 2
#   sayMsg "JPT21[103]  aProject: '${aProject}', aStage: '${aStage}' " 1

#   -----------------------------------------------------------------------

#   bWEBs=1                             # makDir "{WEBs}/._1"
#   aAppsName="Node"                    # makDir "{WEBs}{AppsDir}/._1/"
#   aStage="Prod-Master"                # makDir "{WEBs}/{Project}{Stage}/._2"
#   bDocs=1                             # makDir "{WEBs}/{Project}{Stage}/.docs/._3d"
#   bClient=1                           # makDir "{WEBs}/{Project}{Stage}/client/{1c-App}/._4"
#   bServer=1                           # makDir "{WEBs}/{Project}{Stage}/server/{1s-App}/._4"

#   aAppsDir=""                         # makDir "{WEBs}/._1/"
#   aAppsDir="/nodeapps"                # makDir "{WEBs}{AppsDir}/._1/"

#   --------------------------------------------------------------------------------------------

#   bDoit=1
#   bQuiet=0
#   bFRTonly=0    # ???

#   aTest="test1"
#   aTest="test2"
#   aTest="test3"
#   aTest="test4"

#   -----------------------------------

 if [ "${aTest}" == "test1" ]; then     # /webs/FRTools/server

    aCust="8020"; aSvr="et218t"
    aRootDir=""                         # Unix Server
    aProject="FRTools"
    aWEBs="/webs"                       # Unix Server
    bWEBs=1                             # makDir "{WEBs}/._1"
    aStage=""                           # makDir "{WEBs}/{Project}/._2"
    bClient=1                           # makDir "{WEBs}/{Project}{Stage}/client/{1c-App}/._4"

    fi
#   -----------------------------------

 if [ "${aTest}" == "test2" ]; then     # /C/Repos/FRTools/server

    aCust="8020"; aSvr="et218t"
    aRootDir="/C/Repos"                 # Bruce's PC
    aProject="FRTools"
    aWEBs=""                            # Bruce's PC
    bWEBs=1                             # makDir "{WEBs}/._1"
    aStage=""                           # makDir "{WEBs}/{Project}/._2"
#   bClient=1                           # makDir "{WEBs}/{Project}{Stage}/client/{1c-App}/._4"
    bServer=1                           # makDir "{WEBs}/{Project}{Stage}/Server/{1s-App}/._4"

    fi
#   -----------------------------------

 if [ "${aTest}" == "test3" ]; then     # ../et218t/webs/FRTools/server

    aCust="8020"; aSvr="et218t"
    aRootDir="/C/WEBs/8020/VMs/${aSvr}" # 8020data VM
    aProject="FRTools"
    aWEBs="/webs"                       # 8020data VM
    bWEBs=1                             # makDir "{WEBs}/._1"
    aStage=""                           # makDir "{WEBs}/{Project}/._2"
#   bClient=1                           # makDir "{WEBs}/{Project}{Stage}/client/{1c-App}/._4"
    bServer=1                           # makDir "{WEBs}/{Project}{Stage}/Server/{1s-App}/._4"

    fi
#   -----------------------------------

 if [ "${aTest}" == "test4" ]; then     # ../et218t/webs/nodeapps/FRTools_/dev01-robin/client & server

    aCust="8020"; aSvr="et218t"
    aRootDir="/C/WEBs/8020/VMs/${aSvr}" # 8020data VM
    aProject="FRTools_"                 # Dev Version
    aWEBs="/webs"                       # 8020data VM
    bWEBs=1                             # makDir "{WEBs}/._1"
    aAppsName="Node"                    # makDir "{WEBs}{AppsDir}/._1/"
    aAppsDir="/nodeapps"                # makDir "{WEBs}{AppsDir}/._1/"
    aStage="Dev01-Robin"                # makDir "{WEBs}/{Project}{Stage}/._2"
    bClient=1                           # makDir "{WEBs}/{Project}{Stage}/client/{1c-App}/._4"
    bServer=1                           # makDir "{WEBs}/{Project}{Stage}/Server/{1s-App}/._4"

    fi
#   -----------------------------------
#   -----------------------------------------------------------------------

function makDir( ) {
    aDir="$1"
    aDir_="$2"
    bOK=0
#      sayMsg  "makDir[ 1]    aDir: '${aDir}'" 1
       aDir2="$( echo "${aDir}" | awk '/_[1-4][dsc]?\/(FRTs|JPTs)/ { sub( /.+\._/, "" ); print }' )"
 if [ "${aDir2}" != "" ]; then
    if [ "${aDir2:3:4}" == "JPTs" ]; then if [ "${nJPTs/${aDir2:0:2},/}" != "${nJPTs}" ]; then bOK=1; fi; fi
    if [ "${aDir2:3:4}" == "FRTs" ]; then if [ "${nFRTs/${aDir2:0:2},/}" != "${nFRTs}" ]; then bOK=1; fi; fi
    if [ "${aDir2:2:4}" == "JPTs" ]; then if [ "${nJPTs/${aDir2:0:1},/}" != "${nJPTs}" ]; then bOK=1; fi; fi
    if [ "${aDir2:2:4}" == "FRTs" ]; then if [ "${nFRTs/${aDir2:0:1},/}" != "${nFRTs}" ]; then bOK=1; fi; fi
#      sayMsg  "makDir[ 2]    aDir2: ${aDir2:0:1}, ${aDir2:2:4}, bOK: ${bOK}" 1
    if [ "${bOK}" == "0" ]; then return; fi
    fi

    aDir="$( echo "${aDir}" | awk '{ sub( /{Svr}/,              "'${aSvr}'"       ); print }' )"
    aDir="$( echo "${aDir}" | awk '{ sub( /{WEBs}/,             "'${aWEBs}'"      ); print }' )"
    aDir="$( echo "${aDir}" | awk '{ sub( /{Cust}/,             "'${aCust}'"      ); print }' )"
    aDir="$( echo "${aDir}" | awk '{ sub( /{AppsDir}/,          "'${aAppsDir}'"   ); print }' )"
    aDir="$( echo "${aDir}" | awk '{ sub( /{Project}/,          "'${aProject}'"   ); print }' )"
    aDir="$( echo "${aDir}" | awk '{ sub( /{Stage}/,   tolower( "'${aStage}'"   ) ); print }' )"
    aDir="$( echo "${aDir}" | awk '{ sub( /{1c-App}/,  tolower( "'${a1c_App}'"  ) ); print }' )"
    aDir="$( echo "${aDir}" | awk '{ sub( /{1s-App}/,  tolower( "'${a1s_App}'"  ) ); print }' )"

#   aDir="${aDir/{Cust}/${aCust}/"
#   aDir="${aDir/{Project}/${aProject}/"
#   aDir="${aDir/{Stage}/${aStage}/"
#   aDir="${aDir/{1c-App}/${a1c_App}/"
#   aDir="${aDir/{1s-App}/${a1s_App}/"

 if [ "${bQuiet}"   == "0" ]; then

 if [ "${bFRTonly}" != "1" ]; then
       sayMsg  "makDir[ 3]    mkdir  -p \"${aRootDir}${aDir}\"" 1

    else

 if [ "${aDir/FRTs/}" != "${aDir}" ]; then

#      echo                   ${aRootDir}  ${aDir}  /Proxy/makNginxConf.njs"
       sayMsg  "makDir[ 4]    ${aRootDir}  ${aDir}  /Proxy/makNginxConf.njs" 1
    fi
    fi; fi

 if [ "${bDoit}"   == "1"  ]; then
                              mkdir  -p  "${aRootDir}${aDir}";
    fi

#   return
 if [ "${aDir_}"   != ""   ]; then
                              makDirName "${aDir}/${aDir_}"
    fi
    }
# ---------------------------------------------

function makDirName( ) {
    aDir="$1"
#   echo "echo \"${aDir}\"  | awk '{ sub( /{a1c_App}/,  \"'${a1c_AppName}'\" ); print }'"; return

    aDir="$( echo "${aDir}" | awk '{ sub( /{Svr}/,     "'${aSvr}'"        ); print }' )"
    aDir="$( echo "${aDir}" | awk '{ sub( /{WEBs}/,    "'${aWEBs}'"       ); print }' )"
    aDir="$( echo "${aDir}" | awk '{ sub( /{Cust}/,    "'${aCust}'"       ); print }' )"
    aDir="$( echo "${aDir}" | awk '{ sub( /{Project}/, "'${aProject/_/}'" ); print }' )"
    aDir="$( echo "${aDir}" | awk '{ sub( /{Stage}/,   "'${aStage/\//}'"  ); print }' )"
    aDir="$( echo "${aDir}" | awk '{ sub( /{1c-App}/,  "'${a1c_AppName}'" ); print }' )"
    aDir="$( echo "${aDir}" | awk '{ sub( /{1s-App}/,  "'${a1s_AppName}'" ); print }' )"
    aDir="$( echo "${aDir}" | awk '{ sub( /{AppsName}/,"'${aAppsName}'"   ); print }' )"

    aDir="${aDir/@/ }"
    aDir="${aDir/!/\\!}"
#   aDir="${aDir/\'/\\\'}"

 if [ "${aStage}"   ==  "" ]; then aDir="${aDir/Stage /Main Stage}"; fi

 if [ "${bQuiet}"   == "0" ]; then

 if [ "${bFRTonly}" != "1" ]; then
#      echo                  "mkdir  -p \"${aRootDir}${aDir}\""
       sayMsg  "makDirName[1] mkdir  -p \"${aRootDir}${aDir}\"" 1
    fi;
    fi

 if [ "${bDoit}"    == "1" ]; then
                              mkdir  -p  "${aRootDir}${aDir}";
    fi
    }
# ---------------------------------------------

function shoEm( ) {
    sayMsg "shoEm[  1]  aSvr      : '${aSvr}'"      $1
    sayMsg "shoEm[  2]  aCust     : '${aCust}'"     $1
    sayMsg "shoEm[  3]  aRootDir  : '${aRootDir}'"  $1    # 8020data VM
    sayMsg "shoEm[  4]  aProject  : '${aProject}'"  $1    # Dev Version
    sayMsg "shoEm[  5]  aWEBs     : '${aWEBs}'"     $1    # 8020data VM
    sayMsg "shoEm[  6]  bWEBs     :  ${bWEBs}"      $1    # makDir "{WEBs}/._1"
    sayMsg "shoEm[  7]  aAppsName : '${aAppsName}'" $1    # makDir "{WEBs}{AppsDir}/._1/"
    sayMsg "shoEm[  8]  aAppsDir  : '${aAppsDir}'"  $1    # makDir "{WEBs}{AppsDir}/._1/"
    sayMsg "shoEm[  9]  aStage    : '${aStage}'"    $1    # makDir "{WEBs}/{Project}{Stage}/._2"
    sayMsg "shoEm[ 10]  bFRTonly  :  ${bFRTonly}"   $1    # makDir "{WEBs}/{Project}{Stage}/._2/FRTs"
    sayMsg "shoEm[ 11]  bClient   :  ${bClient}"    $1    # makDir "{WEBs}/{Project}{Stage}/client/._3"
    sayMsg "shoEm[ 12]  1c_App    : '${a1c_App}'"   $1    # makDir "{WEBs}/{Project}{Stage}/client/{1c-App}/._4"
    sayMsg "shoEm[ 13]  bServer   :  ${bServer}"    $1    # makDir "{WEBs}/{Project}{Stage}/server//._4"
    sayMsg "shoEm[ 14]  1s_App    : '${a1s_App}'"   $1    # makDir "{WEBs}/{Project}{Stage}/client/{1c-App}/._4"
    sayMsg "shoEm[ 15]  bdocs     :  ${bDocs}"      $1    # makDir "{WEBs}/{Project}{Stage}/.docs
    sayMsg "" $1
       }
# ---------------------------------------------

function fixAppName( ) {
    if [ "${1/App/}" != "${1}" ]; then
       aName=$1
#      echo "Found: a1c_AppName: ${1}"
     else
       aName="${1}@App"
#      echo "Not Found: a1c_AppName: ${1}"
       fi

    if [ "${1/ App/}" != "${1}" ]; then
#      echo "Found: a1c_AppName: ${1}"
       aName="${1/ App/@App}"
       fi
#      echo "\$1: '${1}' -- '${aName}'"
    }
# --------------------------------------------------

  if [ "test AppName" == "text AppName" ]; then

    a1c_App="1c-My-React-App"
    a1c_AppName="1c-My-React-App"

    a1c_App="1c-Tools"
    a1c_AppName="${a1c_App}"

    a1c_App="1c-Tools"
    a1c_AppName="1c-Tools@App"

    a1c_App="1c-Tools"
    a1c_AppName="1c-Tools App"

    fi

    fixAppName ${a1c_AppName}; a1c_AppName=${aName}
    fixAppName ${a1s_AppName}; a1s_AppName=${aName}

#   fixAppName "1c-Tools App";
#   fixAppName "1c-Tools"
#   fixAppName "My-React-App"

# --------------------------------------------------------------------------------------------------------------------------------------

#   makDir "{WEBs}{AppsDir}/{Project}/{Stage}"; exit
#   makDir "{WEBs}{AppsDir}/{Project}/{Stage}/._2/FRTs"               "!2_Runtime Tools for {Cust}'s {Project} Apps in et218t on Stage {Stage}"; exit
#   aStage="/${aStage}"
#   makDir "{WEBs}{AppsDir}/{Project}{Stage}/client/._3c/FRTs"        "!3c_Runtime Tools for {Cust}'s {Project} Client Apps in {Svr} on Stage {Stage}"
#   makDir "{WEBs}{AppsDir}/{Project}{Stage}/client/{1c-App}/._4"    "!4_Runtime Files for 8020's {Project} {1c-App} in et218t on Stage {Stage}"; exit

# --------------------------------------------------------------------------------------------------------------------------------------

      sayMsg sp "JLP21[293]  bDoit: '${aDoit}', bQuiet: '${bQuiet}', bFRTonly: ;${bFRTonly}'" sp 1

      shoEm 1

 if [ "${bWEBs}" == "1" ]; then
    makDir "{WEBs}"
    makDir "{WEBs}/._1"                                                "!1_Runtime Files for {Cust}'s Web Projects in {Svr} on All Stages"
    makDir "{WEBs}/._1/FRTs"                                           "!1_Runtime FormR Tools for {Cust}'s FormR Apps in {Svr} on All Stages"
    makDir "{WEBs}/._1/JPTs"                                           "!1_Runtime JScripWare Tools in {Svr} on All Stages"
    fi

 if [ "${aAppsName}" != "" ]; then
    makDir "{WEBs}{AppsDir}"
    makDir "{WEBs}{AppsDir}/._1/"                                      "!1_Runtime Files for {Cust}'s {AppsName} Projects in {Svr} on All Stages"
    makDir "{WEBs}{AppsDir}/._1/FRTs"                                  "!1_Runtime FormR Tools for {Cust}'s {Project} Apps in {Svr} on All Stages"
    makDir "{WEBs}{AppsDir}/._1/JPTs"                                  "!1_Runtime JScripWare Tools in {Svr} on All Stages"
    fi

 if [ "${aStage}" != "" ]; then
    aStage="/${aStage}"
    makDir "{WEBs}{AppsDir}/{Project}"
    makDir "{WEBs}{AppsDir}/{Project}/._"                              "!1_Support Files for {Cust}'s {Project} Project in {Svr} on All Stages"
    makDir "{WEBs}{AppsDir}/{Project}/._1"                             "!1_Runtime Files for {Cust}'s {Project} Project in {Svr} on All Stages"
    makDir "{WEBs}{AppsDir}/{Project}/._1/FRTs"                        "!1_Runtime FormR Tools for {Cust}'s {Project} Project in {Svr} on All Stages"
    makDir "{WEBs}{AppsDir}/{Project}/._1/JPTs"                        "!1_Runtime JScripWare Tools in {Svr} on All Stages"
    fi

#   makDir "{WEBs}{AppsDir}/{Project}{Stage}/._1"                  (*) "!1_Runtime Files for {Cust}'s {Project} Project in {Svr} on All Stages"

    makDir "{WEBs}{AppsDir}/{Project}{Stage}"
    makDir "{WEBs}{AppsDir}/{Project}{Stage}/._2"                      "!2_Runtime Files for {Cust}'s {Project} Apps in {Svr} on Stage {Stage}"
    makDir "{WEBs}{AppsDir}/{Project}{Stage}/._2/FRTs"                 "!2_Runtime FormR Tools for {Cust}'s {Project} Apps in {Svr} on Stage {Stage}"
    makDir "{WEBs}{AppsDir}/{Project}{Stage}/._2/JPTs"                 "!2_Runtime JScripWare Tools in {Svr} on Stage {Stage}"

 if [ "${bDocs}" == "1" ]; then
    makDir "{WEBs}{AppsDir}/{Project}{Stage}/.docs"
    makDir "{WEBs}{AppsDir}/{Project}{Stage}/.docs/._3d"               "!3c_Runtime Files for {Cust}'s {Project} Docs in {Svr} on Stage {Stage}"
    makDir "{WEBs}{AppsDir}/{Project}{Stage}/.docs/._3d/FRTs"          "!3c_Runtime FormR Tools for {Cust}'s {Project} Docs in {Svr} on Stage {Stage}"
    fi

 if [ "${bClient}" == "1" ]; then
    makDir "{WEBs}{AppsDir}/{Project}{Stage}/client"
    makDir "{WEBs}{AppsDir}/{Project}{Stage}/client/._3c"              "!3c_Runtime Files for {Cust}'s {Project} Client Apps in {Svr} on Stage {Stage}"
    makDir "{WEBs}{AppsDir}/{Project}{Stage}/client/._3c/FRTs"         "!3c_Runtime FormR Tools for {Cust}'s {Project} Client Apps in {Svr} on Stage {Stage}"
    makDir "{WEBs}{AppsDir}/{Project}{Stage}/client/._3c/JPTs"         "!3c_Runtime JScripWare Tools in {Svr} on Stage {Stage}"
    fi

 if [ "${bServer}" == "1" ]; then
    makDir "{WEBs}{AppsDir}/{Project}{Stage}/server"
    makDir "{WEBs}{AppsDir}/{Project}{Stage}/server/._3s"              "!3s_Runtime Files for {Cust}'s {Project} Server Apps in {Svr} on Stage {Stage}"
    makDir "{WEBs}{AppsDir}/{Project}{Stage}/server/._3s/FRTs"         "!3s_Runtime FormR Tools for {Cust}'s {Project} Server Apps in {Svr} on Stage {Stage}"
    makDir "{WEBs}{AppsDir}/{Project}{Stage}/server/._3s/JPTs"         "!3s_Runtime JScriptWare Tools in {Svr} on Stage {Stage}"
    fi

 if [ "${bClient}" == "1" ]; then
    makDir "{WEBs}{AppsDir}/{Project}{Stage}/client/{1c-App}"
    makDir "{WEBs}{AppsDir}/{Project}{Stage}/client/{1c-App}/._4"      "!4_Runtime Files for 8020's {Project} {1c-App} in {Svr} on Stage {Stage}"
    makDir "{WEBs}{AppsDir}/{Project}{Stage}/client/{1c-App}/._4/FRTs" "!4_Runtime FormR Tools for {Cust}'s {Project} Server Apps in {Svr} on Stage {Stage}"
    fi

 if [ "${bServer}" == "1" ]; then
    makDir "{WEBs}{AppsDir}/{Project}{Stage}/server/{1s-App}"
    makDir "{WEBs}{AppsDir}/{Project}{Stage}/server/{1s-App}/._4"      "!4_Runtime Files for 8020's {Project} {1s-App} in {Svr} on Stage {Stage}"
    makDir "{WEBs}{AppsDir}/{Project}{Stage}/client/{1c-App}/._4/FRTs" "!4_Runtime FormR Tools for {Cust}'s {Project} Server Apps in {Svr} on Stage {Stage}"
    fi


# --------------------------------------------------------------------------------------------------------------------------------------

