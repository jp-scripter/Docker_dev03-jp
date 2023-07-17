#!/bin/bash

            aService=$( net start | awk '/Docker Desktop Service/' )
    if [ "${aService}" == "" ]; then
            echo -e "\n** The Docker Desktop Service is not running\n"
            exit
            fi
# -----------------------------------------------------------------

function Help() {

    if [ "$1" != "" ]; then echo ""; echo "  $1"; fi
    dokR="JPT dokR"; aScr="$( basename "${BASH_SOURCE[0]}" )"; if [ "${aScr}" == "dr" ]; then dokR="DR"; fi; if [ "${aScr}" == "dokr" ]; then dokR="dokR"; fi
    echo ""
    echo "    ${dokR} run {ContainerName} {VersionNo}           Run the Image, {ContainerName}.image:{VersionNo}, as {ContainerName}"
    echo "    ${dokR} run {VersionNo}                           Run the current Container with a different image {VersionNo}"
    echo "    ${dokR} run                                       Run the current Container"
    echo ""
    echo "    ${dokR} commit {ContainerName} {VersionNo}        Commit the current Container to a new Image, {ContainerName}.image:{VersionNo}"
    echo "    ${dokR} commit {VersionNo}                        Commit the current Container to a new image with a new {VersionNo}"
    echo "    ${dokR} commit                                    Commit the current Container to the same Image"
    echo ""
    echo "    ${dokR} restart                                   Stop, restart the current container"
    echo "    ${dokR} attach                                    Stop, restart and attach the current container"
    echo "    ${dokR} stop                                      Stop the current container"
    echo "    ${dokR} rm                                        Stop and remove the current container"
    echo "    ${dokR} [ show | ps  ]                            Show docker runing containers"
    echo "    ${dokR} [ show | psa ] [ -a | all ]               Show docker runing and stopped containers"
    echo ""
    echo "    ${dokR} build                                     Show Dockerfile to build a docker image"
    echo "    ${dokR} build {ContainerName}                     .. then tag it with {ContainerName}.image:latest"
    echo "    ${dokR} build {ContainerName}:{VersionNo}         .. then tag it with {ContainerName}.image:{VersionNo}"
    echo "    ${dokR} build [ .. ] -doit                        .. actuall build it with or without tag"
    echo "    ${dokR} tag {ImageId} {ContainerName}:{VersionNo} Rename docker image"
    echo "    ${dokR} [ list | images ]                         List docker images"
    echo "    ${dokR} [ list | images ] [ -a | all ]            List all docker images including intermediate images"
    echo "    ${dokR} [ dellete | rmi ] {ContainerName} {VersionNo}  Delete the Image, {ContainerName}.image:{VersionNo}, as {ContainerName}"
    echo "    ${dokR} [ dellete | rmi ] {VersionNo}                  Delete the the current Container's image with {VersionNo}"
    echo ""
    }
# -----------------------------------------------------------------

function setCmd1() {
     if [ "${aCmd}"  != ""   ]; then return; fi
#    if [ "${aCMD1:0:2}" == "$1" ] || [ "${aCMD2}" == "$1" ] || [ "${aCMD3}" == "$1" ]; then aCmd="$2";
     if [ "${aCMD1:0:3}" == "$1" ]; then aCName="${aArg2}"; aVerNo="${aArg3}"; aCmd="$2"; return; fi
     if [ "${aCMD1:0:2}" == "$1" ]; then aCName="${aArg2}"; aVerNo="${aArg3}"; aCmd="$2"; return; fi
     if [ "${aCMD2:0:2}" == "$1" ]; then aCName="${aArg1}"; aVerNo="${aArg3}"; aCmd="$2"; return; fi
     if [ "${aCMD3:0:2}" == "$1" ]; then aCName="${aArg1}"; aVerNo="${aArg2}"; aCmd="$2"; return; fi; # fi
     }
# -----------------------------------------------------------------

function setCmd2() {
     if [ "${aCmd}"  != ""    ]; then return; fi
     if [ "${aCMD12}" == "$1" ]; then aCName="${aArg3}"; aVerNo="${aArg4}"; aCmd="$2"; fi
     if [ "${aCMD13}" == "$1" ]; then aCName="${aArg2}"; aVerNo="${aArg4}"; aCmd="$2"; fi
     if [ "${aCMD23}" == "$1" ]; then aCName="${aArg1}"; aVerNo="${aArg4}"; aCmd="$2"; fi
     if [ "${aCMD14}" == "$1" ]; then aCName="${aArg2}"; aVerNo="${aArg3}"; aCmd="$2"; fi
     if [ "${aCMD24}" == "$1" ]; then aCName="${aArg1}"; aVerNo="${aArg3}"; aCmd="$2"; fi
     if [ "${aCMD34}" == "$1" ]; then aCName="${aArg1}"; aVerNo="${aArg2}"; aCmd="$2"; fi
     }
# -----------------------------------------------------------------

#   aArg1="rmi"
#   aArg1="tag"; aArg2="0f7044c80f6f"; aArg3="foo:1.03";
    aArg1="$1"; aArg2="$2"; aArg3="$3"; aArg4="$4"

 if [ "${aArg1}" == "" ]; then Help "Please enter any of the following commands:"; exit; fi

    aCMD1=$(  echo "${aArg1:0:3}"              | tr '[:lower:]' '[:upper:]' )
    aCMD2=$(  echo "${aArg2:0:2}"              | tr '[:lower:]' '[:upper:]' )
    aCMD3=$(  echo "${aArg3:0:2}"              | tr '[:lower:]' '[:upper:]' )
    aCMD12=$( echo "${aArg1:0:2}${aArg2:0:2}"  | tr '[:lower:]' '[:upper:]' )
    aCMD13=$( echo "${aArg1:0:2}${aArg3:0:2}"  | tr '[:lower:]' '[:upper:]' )
    aCMD23=$( echo "${aArg2:0:2}${aArg3:0:2}"  | tr '[:lower:]' '[:upper:]' )
    aCMD14=$( echo "${aArg1:0:2}${aArg4:0:2}"  | tr '[:lower:]' '[:upper:]' )
    aCMD24=$( echo "${aArg2:0:2}${aArg4:0:2}"  | tr '[:lower:]' '[:upper:]' )
    aCMD34=$( echo "${aArg3:0:2}${aArg4:0:2}"  | tr '[:lower:]' '[:upper:]' )

    aCmd=""

    setCmd2 "PS-A" "Show All"
    setCmd2 "-APS" "Show All"
    setCmd2 "PSAL" "Show All"
    setCmd2 "ALPS" "Show All"
    setCmd2 "SHAL" "Show All"
    setCmd2 "ALSH" "Show All"
    setCmd2 "SH-A" "Show All"
    setCmd2 "-ASH" "Show All"
    setCmd1 "PSA"  "Show All"             # .(30716.02.1 RAM Add)
    setCmd1 "PS"   "Show"
    setCmd1 "SH"   "Show"

    setCmd2 "IM-A" "List All"
    setCmd2 "-AIM" "List All"
    setCmd2 "IMAL" "List All"
    setCmd2 "ALIM" "List All"
    setCmd2 "LIAL" "List All"
    setCmd2 "ALLI" "List All"
    setCmd2 "LI-A" "List All"
    setCmd2 "-ALI" "List All"
    setCmd1 "IM"   "List"
    setCmd1 "LI"   "List"

    setCmd1 "TA"   "Tag"

    setCmd2 "BU-D" "Build -doit"
    setCmd1 "BU"   "Build"

    setCmd1 "DE"   "Delete"
    setCmd1 "RMI"  "Delete"  # if found stop looking
    setCmd1 "RM"   "Remove"

    setCmd1 "RU"   "Run"
    setCmd1 "CO"   "Commit"
    setCmd1 "RE"   "Restart"
    setCmd1 "ST"   "Stop"
    setCmd1 "AT"   "Attach"

    echo "aCmd ${aCmd}, aCMD1: '${aCMD1}', aCName: '${aCName}', aVerNo: '${aVerNo}'"; # exit
#   echo "aCmd ${aCmd}, aCMD1: '${aCMD2}', aArg1: '${aArg1:0:2}', aArg2: '${aArg2}'"; exit
#   echo "aCmd ${aCmd}, aCMD13: '${aCMD13}', aArg1: '${aArg1:0:2}', aArg2: '${aArg2}'"; exit
#   echo "aCmd ${aCmd}, aCMD23: '${aCMD23}', aArg1: '${aArg1:0:2}', aArg2: '${aArg2}'"; exit
#   echo "aCmd ${aCmd}, aCMD14: '${aCMD14}', aArg1: '${aArg2}', aArg2: '${aArg3}'"; exit

# ---------------------------------------------

if [ "${aCmd}" == "" ]; then
    Help "Please enter a valid command:"
    exit
    fi

#   echo ""

#   echo "aCmd1 ${aCmd}, aCMD12: '${aCMD12}', aArg1: '${aArg1:0:2}', aArg2: '${aArg2}'";   exit

# ---------------------------------------------------------------------------------------------------------------------------------------------

  function  getCName() {
            aCName="$1"; aVerNo="$2"; # echo "aCName: '${aCName}'; aVerNo: '${aVerNo}'"

            aCName=$( echo "${aCName/.image/}" | tr '[:upper:]' '[:lower:]' )
    if [ "${aCName/:/}" != "${aCName}" ]; then aVerNo="${aCName##*:}"; aCName="${aCName%%:*}"; fi

                                        aTagName=""
    if [ "${aCName}" != ""   ];    then aTagName="${aCName}.image:latest";
    if [ "${aVerNo}"  != ""  ];    then aTagName="${aCName}.image:${aVerNo}"; fi; fi;  echo "aCName: '${aCName}'; aVerNo: '${aVerNo}', aTagName: '${aTagName}'"

            bUseSaved=0;    if [ "$3" == "" ] || [ "${3:0:4}" == "use"  ]; then bUseSaved=1;         fi
            bSaveIt=0;      if [ "$3" == "" ] || [ "${3:0:4}" == "save" ]; then             bSave=1; fi
                            if [ "$3" == "" ] || [ "${3:0:4}" == "both" ]; then bUseOnly=1; bSave=1; fi
                            if                   [ "${3:0:4}" == "dont" ]; then bUseOnly=0; bSave=0; fi
    if [ "${bUseSaved}" == "1" ]; then
    if [ "${aCName}"  == "" ]; then aCName="${TheCName}"; aVerNo="${TheVerNo}"; fi; fi

    if [ "${bSaveIt}"   == "1" ]; then
    if [ "${aCName}"  != "" ]; then export TheCName="${aCName}"; export TheVerNo="${aVerNo}"; fi; fi
        }
# -----------------------------------------------------------------

function prtImages( ) {
#           echo "         1         2         3         4         5         6         7         8         9        10        11        12        13         14"
#           echo "123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 12345678"
#           docker images

#           echo ""
#           echo "-----------------------------------------------------------------------------------------------------------"
#           echo "REPOSITORY IMAGE NAME                                                    TAG            IMAGE ID     CREATED       SIZE  "
#           echo "------------------------------------------------------------------------ -------------- ------------ ------------- ------"

            echo "------------------------------------------------------------------------------------------------------------------"
            echo "REPOSITORY IMAGE NAME                                 TAG                   IMAGE ID          CREATED         SIZE"
            echo "----------------------------------------------------- --------------------- ------------ ------------------ ------"

            aAll=$1;        if [ "$1" == "" ]; then aAll=""; fi
            aFilter="/$2/"; if [ "$2" == "" ]; then aFilter="NR > 1"; fi
            nPos=$( docker images ${aAll} | awk 'NR == 1 { print index( $0, "TAG" ) }' ); # echo -e "\n  nPos: ${nPos}"
aAwkScr='
function trim(    a ) { sub( /[ \t]+$/, "", a ); sub( /^[ \t]+/, "", a ); return a }
function chop( n, a ) { sub( /[ \t]+$/, "", a ); sub( /^[ \t]+/, "", a );
    return (length(a) > n) ? substr( a, 1, n-4 ) "... " : substr( a "                ", 1, n )
            }
BEGIN{   nPos = 0'${nPos}' }
          { aName    = chop( 53, $1 ) # was 72
            aTag     = chop( 18, $2 ) # was 14
            aImageId = chop( 12, $3 )
            aCreated = trim(     substr( $0, nPos + 31, 14 ) )  # 128 = 97 + 31
            aSize    = trim(     substr( $0, nPos + 46, 14 ) )  # 143 = 97 + 46

            printf "%-53s %-21s %-12s %18s %6s\n", aName, aTag, aImageId, aCreated, aSize
            }
END{ }'
            aFmt="{{.ID}},{{.Image}},{{.Command}},{{.RunningFor}},{{.Status}},{{.Ports}},{{.Names}}"

            docker images ${aAll} | awk "${aFilter}" | awk "${aAwkScr}" | sort
            }
# -----------------------------------------------------------------

  function  prtContainers( ) {
#           echo "         1         2         3         4         5         6         7         8         9        10        11        12        13         14       15        16        17        18"
#           echo "123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 "

#           echo ""
#  1.       echo "------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
#           echo "CONTAINER ID   IMAGE                                                                  COMMAND                  CREATED        STATUS        PORTS                NAMES"
#           echo "-------------  ---------------------------------------------------------------------  -----------------------  -------------  ------------  -------------------  --------------------"

#  2.       echo "---------------------------------------------------------------------------------------------------------------------------------------------------------------"
#           echo "CONTAINER NAME     IMAGE NAME                                            STATUS         IMAGE ID     CREATED       COMMAND                PORTS"
#           echo "------------------ ----------------------------------------------------- -------------- ------------ ------------- ---------------------- ---------------------"

#  3.       echo "---------------------------------------------------------------------------------------------------------------------------------------------------------------"
#           echo "IMAGE NAME : TAG                                      CONTAINER NAME     IMAGE ID        CREATED     STATUS        COMMAND                PORTS"
#           echo "----------------------------------------------------- ------------------ ------------ -------------  ------------- ---------------------- ---------------------"

            aAll=$1;        if [ "$1" == "" ]; then aAll=""; fi
            aFilter="/$2/"; if [ "$2" == "" ]; then aFilter="NR > 0"; fi;          # docker ps ${aAll}

#  4.       echo "---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
#           echo "IMAGE NAME : TAG                                      CONTAINER NAME      IMAGE ID          CREATED       STATUS                     COMMAND                PORTS                "
#           echo "----------------------------------------------------- ------------------- ------------ ------------------ -------------------------- ---------------------- ---------------------"

#  5.       echo "-------------------------------------------------------------------------------------------------------------------------------------------------------------------"
#           echo "IMAGE NAME : TAG                                      CONTAINER NAME        IMAGE ID          CREATED       STATUS     COMMAND                PORTS                "
#           echo "----------------------------------------------------- --------------------- ------------ ------------------ ---------- ---------------------- ---------------------"

            echo "----------------------------------------------------------------------------------------------------------------------------------------------------------------"
            echo "IMAGE NAME : TAG                                      CONTAINER NAME        IMAGE ID          STATUS                COMMAND                PORTS                "
            echo "----------------------------------------------------- --------------------- ------------ -------------------------- ---------------------- ---------------------"

#           aCHeads=$( docker ps ${aAll} | awk 'NR == 1' );                        # echo "${aCHeads}"
#           nPos1=$( echo "${aCHeads}" | awk '{ print index( $0, "COMMAND" ) }' ); # echo "  COMMAND nPos: ${nPos1}"
#           nPos2=$( echo "${aCHeads}" | awk '{ print index( $0, "PORTS"   ) }' ); # echo "  PORTS   nPos: ${nPos2}"
#           nPos3=$( echo "${aCHeads}" | awk '{ print index( $0, "NAMES"   ) }' ); # echo "  NAMES   nPos: ${nPos3}"
aAwkScr='
  function  trim(    a ) { sub( /[ \t]+$/, "", a );  sub( /^[ \t]+/, "", a ); return a }
  function  chop( n, a ) { sub( /[ \t]+$/, "", a );  sub( /^[ \t]+/, "", a );
    return (length(a) > n) ? substr( a, 1, n-4 ) "... " : substr( a "                ", 1, n )
            }
#BEGIN{     nPos1 = '${nPos1}';  nPos2 = '${nPos2}'; nPos3 = '${nPos3}'; }
#         { aImageId =       $1
#           aTag     = chop( 53, substr( $0,  16, nPos1 -16            ) )
#           aCommand = chop( 24, substr( $0, nPos1 +  0, 24            ) )  # 108 = 108 +  0          chop( 24, substr( $0, nPos +  0, 24 ) )
#           aCreated = trim(     substr( $0, nPos1 + 25, 14            ) )  # 133 = 108 + 25
#           aStatus  = chop( 23, substr( $0, nPos1 + 40, 23            ) )  # 148 = 108 + 40  was 13; chop( 15, substr( $0, nPos + 40, 16 )
#           aPorts   =           substr( $0, nPos2 +  0, nPos3 - nPos2 )    # 162 = 108 + 54
#           aName    = chop( 18, substr( $0, nPos3 +  0, 25            ) ); # 183 = 108 + 75  # print "--- aName: \"" substr( $0, nPos + 75, 20 ) "\" -> \"" aName "\"";
BEGIN{ }
          { aImageId = $1  # .ID
            aTag     = $2  # .Image
            aCommand = $3
            aCreated = $4  # .RunningFor
            aStatus  = $5; # sub( /\(.+/, "", aStatus )
            aPorts   = $6
            aNames   = $7

#           printf "%-14s %-70s %-15s %-15s %15s %-20s %-15s\n",  aImageId, aTag,   aCommand, aCreated, aStatus,  aPorts,   aName
#           printf "%-18s %-50s %-15s %-12s %14s  %-22s %-22s\n", aName,    aTag,   aStatus,  aImageId, aCreated, aCommand, aPorts
#  4.       printf "%-18s %-53s %-14s %-12s %13s %-24s %-21s\n",  aName,    aTag,   aStatus,  aImageId, aCreated, aCommand, aPorts
#  5.       printf "%-53s %-19s %-12s %18s %-26s %-24s %-21s\n",  aTag,     aNames, aImageId, aCreated, aStatus,  aCommand, aPorts
            printf "%-53s %-21s %-12s %26s %-24s %-21s\n",        aTag,     aNames, aImageId,           aStatus,  aCommand, aPorts
            }
END{ }'
            aFmt="{{.ID}},{{.Image}},{{.Command}},{{.RunningFor}},{{.Status}},{{.Ports}},{{.Names}}"

            docker ps ${aAll} --format  "${aFmt}"  | awk  "${aFilter}"  | awk -F,   "${aAwkScr}"  | sort -k 1.16
#     echo "docker ps ${aAll} --format \"${aFmt}\" | awk \"${aFilter}\" | awk -F, \"\${aAwkScr}\" | sort -k 1.16"
#     echo "${aAwkScr}"
            }
# -----------------------------------------------------------------

  function  prtCmd( ) {
#           echo "prtCmd( '$1' )"
            echo -e "\n    \`# $1  \`"
            }
# -----------------------------------------------------------------

# ---------------------------------------------

if [ "${aCmd}" == "Run" ]; then

            getCName "${aCName}" "${aVerNo}"

            bKill=1

            aName=$( docker images --format "{{.Repository}}:{{.Tag}}" | awk "/${aTagName/.image/}/" )
    if [ "${aName}" != "" ]; then aTagName="${aTagName/.image/}"; else
            aName=$( docker images --format "{{.Repository}}:{{.Tag}}" | awk "/${aTagName}/" ); fi
    if [ "${aName}" == "" ]; then
            echo -e "\n** There is no Image named, '${aTagName}'"
            exit
            fi
#                     docker ps -a --format "{{.Image}},{{.Names}}"
            aNames=$( docker ps -a --format "{{.Image}},{{.Names}}" | awk "/${aTagName}|${aCName}/" )
#           echo "'${aNames}' == '${aTagName}', '${aCName}'"; exit

    if [ "${aNames}" != ""  ]; then
    if [ "${bKill}" == "0" ]; then
            echo -e "\n** These containes need to be removed:"
            prtContainers -a "${aTagName}|${aCName}"
            exit
            fi
    if [ "${bKill}" == "1" ]; then
       echo "loopin through aNames"
        for aName in ${aNames}; do
            echo " * Removed Container, '${aName##*,}'"
            docker rm -f "${aName##*,}" >/dev/null
            done
            fi
         fi
            prtCmd "docker run -it --name '${aCName}' '${aTagName}'"
            echo "-----------------------------------------------------------------------------------------"
                    docker run -it --name "${aCName}" "${aTagName}"
            exit
    fi
# ---------------------------------------------

if [ "${aCmd}" == "Commit" ]; then
    getCName       "${aCName}" "${aVerNo}"
    echo "  Commit '${aCName}' '${aVerNo}'"
    fi
# ---------------------------------------------

if [ "${aCmd}" == "Restart" ]; then
    getCName        "${aCName}" "${aVerNo}"
    echo "  Restart '${aCName}' '${aVerNo}'"
    fi
# ---------------------------------------------

if [ "${aCmd}" == "Stop" ]; then
    getCName     "${aCName}" "${aVerNo}"
    echo "  Stop '${aCName}' '${aVerNo}'"
    fi
# ---------------------------------------------

if [ "${aCmd}" == "Remove" ]; then

            getCName "${aCName}" "${aVerNo}"  "dontSave and dontUse"

            prtCmd "docker rm -f '${aCName}'"
            echo "--------------------------------------------------"
                    docker rm -f "${aCName}"
    fi
# ---------------------------------------------

if [ "${aCmd}" == "Attach" ]; then
    getCName       "${aCName}" "${aVerNo}"
    echo "    `# Attach '${aCName}' '${aVerNo}'`"
    fi
# ---------------------------------------------

if [ "${aCmd:0:4}" == "List" ]; then  # aka docker images

    if [ "${aCmd:5:4}" == "All" ]; then aAll=" -a"; else aAll=""; fi

            aAwkCmd=""; if [ "${aCName}" != "" ]; then aAwkCmd="| awk '/${aCName}/'"; fi

#       echo "    `# docker images${aAll} ${aAwkCmd}`"
#       echo "----------------------------------------------------------------------------------"
#   if [ "${aCName}" == "" ]; then docker images ${aAll}; fi
#   if [ "${aCName}" != "" ]; then docker images         | awk 'NR == 1'
#                                  docker images ${aAll} | awk '/'${aCName}'/'; fi
            prtCmd "docker images${aAll} ${aAwkCmd}"
            prtImages "${aAll}" "${aCName}"
    fi
# ---------------------------------------------------------------------------------------------------------------------------------

if [ "${aCmd:0:4}" == "Show" ]; then  # aka docker ps

    if [ "${aCmd:5:4}" == "All" ]; then aAll=" -a"; else aAll=""; fi

            aAwkCmd=""; if [ "${aCName}" != "" ]; then aAwkCmd="| awk '/${aCName}/'"; fi

#   echo "    `# docker ps${aAll} ${aAwkCmd}`"
#   echo "# docker ps '${aCName}' | awk '/${aCName}/'"
#   echo "----------------------------------------------------------------------------------"
#   if [ "${aCName}" == "" ]; then docker ps ${aAll}; fi
#   if [ "${aCName}" != "" ]; then docker ps         | awk 'NR == 1'
#                                  docker ps ${aAll} | awk '/'${aCName}'/'; fi
            prtCmd "docker ps${aAll} ${aAwkCmd}"
            prtContainers   "${aAll}" "${aCName}"
    fi
# ---------------------------------------------------------------------------------------------------------------------------------
#
#if [ "${aCmd}" == "Show All" ]; then
#
#   echo "    `# docker ps -a '${aCName}' | awk '/${aCName}/'`"
#   echo "----------------------------------------------------------------------------------"
#   if [ "${aCName}" == "" ]; then docker ps -a; fi
#   if [ "${aCName}" != "" ]; then docker ps    | awk 'NR == 1'
#                                  docker ps -a | awk '/'${aCName}'/'; fi
#   fi
# ---------------------------------------------------------------------------------------------------------------------------------

if [ "${aCmd}" == "Tag" ]; then

            aImageId="${aCName:0:12}"; aCName="${aVerNo}"; aVerNo="${aArg4}"
            getCName  "${aCName}" "${aVerNo}"  # "saveOnly"
#     echo "aCmd ${aCmd}, aCMD1: '${aCMD1}', aImageId: '${aImageId}', aCName: '${aCName}', aVerNo: '${aVerNo}'"; exit

# docker tag 'ubuntu' 'frapps_dev01-ubuntu.image:20.05'
              OldTagName   newTagName with .image and same tag
#                                    aTagName="";
#   if [ "${aCName}" != ""   ]; then aTagName="${aCName}.image:latest";
#   if [ "${aVerNo}"  != ""  ]; then aTagName="${aCName}.image:${aVerNo}"; fi
    if [ "${aTagName}" == "" ]; then
            echo -e "\n** You must provide a Container Name\n"; exit
            fi; # fi
                    echo "docker images -a | awk \"/${aImageId}/ { print \$3 }\""
            aImageOld="$( docker images -a | awk  "/${aImageId}/ { print \$3 }" )"
    if [ "${aImageOld}" == "" ]; then
            echo -e "\n** The ImageId, '${aImageId}', does not exist\n"; exit
            fi
            aCNameOld="$( docker images -a | awk "/^${aCName}.image/ { print \$1 }" )"
    if [ "${aCNameOld}" != "" ]; then
            echo -e "\n** The '${CName}.image' already exists\n"; exit
            fi
exit
#           echo "docker tag ${aImageId} '${aTagName}'"
            prtCmd  "docker tag '${aImageId}' '${aTagName}'"
#           exit
    fi
# ---------------------------------------------------------------------------------------------------------------------------------

if [ "${aCmd:0:5}" == "Build" ]; then

            getCName  "${aCName}" "${aVerNo}" "saveOnly"
    if [ "${aCmd:6:5}" == "-doit" ]; then bDoit=1; else bDoit=0; fi

    if [ ! -f "Dockerfile" ]; then echo -e "\n ** No Dockerfile exists\n"; exit; fi

            aTagCmd=""; #            aTagName=""; aTagCmd=""
#   if [ "${aCName}" != ""   ]; then aTagName="${aCName}.image:latest";
#   if [ "${aVerNo}"  != ""  ]; then aTagName="${aCName}.image:${aVerNo}"; fi
    if [ "${aTagName}" != "" ]; then aTagCmd="&& docker tag {ImageId} ${aTagName}"; fi; # fi

#           echo "   docker build . ${aTagCmd}"
#           prtCmd  "docker build . ${aTagCmd}"
#           echo "----------------------------------------------------------------------------------"
#           echo "aCmd ${aCmd:0:5}, bDoit: '${bDoit}', aTagName: '${aTagName}'"; # exit
#  -----------------------------------------------------------------

if [ "${bDoit}" == "0" ]; then

#           prtCmd  "docker build . ${aTagCmd}"
            prtCmd  "docker build -t '${aTagName}' ."
            echo "----------------------------------------------------------------------------------"
            echo ".. build a Docker image using this Dockerfile:"
            echo "---------------------------------------------"

            cat  Dockerfile;

    if [ "${aTagName}" != "" ]; then
            echo -e "\n\n.. then tag it with: '${aTagName}'"; else echo "";
            fi
            echo -e "\n.. to build the Docker image, run: dr build -doit ${aTagName}";
            exit
#     ------------------------------------------------
      fi # eif bDoit == 0
#  -----------------------------------------------------------------

if [ "${bDoit}" == "1" ]; then

#           echo  "  docker build ."
            prtCmd  "docker build . ${aTagCmd}"
            echo "----------------------------------------------------------------------------------"

            docker build .
#           nErr=$( echo $? )
#           echo "--- Error: ${nErr}"
#           echo "--- Output '${output}'"

    if [ "${aTagName}" == "" ]; then

            aImageId="$( docker images -a | awk '/<none>/ { print $3 }' )"
    if [ "${aImageId}" == "" ]; then
            echo -e "\n** A new Container image was not built";
            exit
            fi  # eif aImageId == "" for new image <none> when aTagName == ""

    if [ "${aImageId}" == "" ]; then
#           echo -e "\n----------------------------------------------------------------------------------"
            prtImages -a "<none>";    # docker images -a | awk "/REPOSITORY|<none>/"; echo ""
            exit
          fi  # eif aImageId != "" for new image <none> when aTagName == ""
#       ---------------------------------------
        fi # eif aTagName == ""
#     ------------------------------------------------

    if [ "${aTagName}" != "" ]; then

            aImageId="$( docker images -a | awk '/<none>/ { print $3 }' )"
    if [ "${aImageId}"  == "" ]; then
            echo -e "\n** A new Container image was not built";

            aCNameOld="$( docker images -a | awk "/^${aCName}.image/ { print \$1 }" )"
    if [ "${aCNameOld}" != "" ]; then
            echo -e " * It seems like the '${aCName}.image' already exists\n";
            fi  # eif aCNameOld != "" for new image <none> when aTagName != ""

#           echo -e "\n----------------------------------------------------------------------------------"
            prtImages -a "<none>|${aCName}.image";     # docker images -a | awk "/REPOSITORY|<none>|${aCName}.image/"; echo ""
            exit
        fi  # eif aImageId == "" for new image <none> when aTagName != ""
#       ---------------------------------------

    if [ "${aImageId}" != "" ]; then
#           echo -e "\n  docker tag '${aImageId}' '${aTagName}'"
#           echo "----------------------------------------------------------------------------------"
            prtCmd "docker tag '${aImageId}' '${aTagName}'"
                    docker tag "${aImageId}" "${aTagName}"
            prtImages -a "${aImageId}";                # docker images -a | awk "/REPOSITORY|${aImageId}/"
            exit
            fi # eif # eif aImageId != "" for new image <none> when aTagName != ""
#       ---------------------------------------
        fi # eif aTagName != ""
#     ------------------------------------------------
      fi # eif bDoit == 1
#  -----------------------------------------------------------------
    fi # eif aCmd:0:5}" == "Build"
# ---------------------------------------------------------------------------------------------------------------------------------

if [ "${aCmd}" == "Delete" ]; then

            getCName   "${aCName}" "${aVerNo}"  "dontSave and dontUse"

            aImageId="${aCName}"; if [ "${aImageId}" == "" ]; then
            echo -e "\n** You must provide an ImageId\n"
            exit
            fi

            echo "aCName: '${aCName}', aVerNo: '${aVerNo}', aImageId: '${aImageId}'"; # exit
            aImageId1="$( docker images -a | awk "/${aImageId}/ { print \$3; exit }" )"  # may be more than one
    if [ "${aImageId1}" == "" ]; then
            echo -e "\n** The ImageId, '${aImageId}', does not exist\n"
            exit
            fi

            prtCmd "docker rmi -f '${aImageId}'"
            echo "--------------------------------------------------"
                    docker rmi -f "${aImageId}"
    fi
# ---------------------------------------------------------------------------------------------------------------------------------

    echo ""