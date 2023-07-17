#!/bin/bash
#*\
##=========+====================+================================================+
##RD         DirList            | RSS Dir Lister
##RFILE    +====================+=======+===================+======+=============+
##FD   RSS22-DirList.sh         |   7556|  3/07/18  5:41|   146| v1.02`90315
##FD   RSS22_DirList.sh         |  11987| 12/03/22 13:46|   180| p1.03`21203.1346
##FD   RSS22_DirList.sh         |  13274| 12/06/22 18:45|   190| p1.03`21206.1845
##FD   RSS22_DirList.sh         |  15269| 12/31/22 11:59|   199| p1.03`21231.1159
##FD   RSS22_DirList.sh         |  16556|  5/03/23 16:10|   215| p1.03`30503.1610
##FD   RSS22_DirList.sh         |  17410|  5/16/23  8:45|   230| p1.04`30516.0845
##FD   RSS22_DirList.sh         |  18645|  5/16/23  9:20|   243| p1.04`30516.0920
##DESC     .--------------------+-------+-------------------+------+------------+
#            List directory counts using du on every subfolder, where
#
#              DirList [-r Levels] [-c Columns]                                            # .(21206.06.2)
#                      [-r Levels}                 {Levels} down, (defaults to 1)          # .(21206.06.3)
#                                  [-c Columns}    0) Names only,                          # .(21206.06.4)
#                                                  1) Names & Sizes only, (default)
#                                                  2) Names & Sizes and Files
#                                                  3) Names & Sizes, Files and Dirs
#
##LIC      .--------------------+----------------------------------------------+
#            Copyright (c) 2018-2022 JScriptWare * Released under
#            MIT License: http://www.opensource.org/licenses/mit-license.php
##FNCS     .--------------------+-------+-------------------+------+-----------+
#
##CHGS     .--------------------+-------+-------------------+------+-----------+
# .(81007.01 10/07/18 RAM  2:00a| Created
# .(81007.03 10/07/18 RAM  2:00a| Get rid of ErrorLog
# .(81007.04 10/07/18 RAM  4:00a| Add quotes
# .(81007.05 10/07/18 RAM  8:00a| Only allow numbers for nLvl or nTyp args
# .(81007.06 10/07/18 RAM  5:30p| Fix names with spaces not printing properly
# .(81007.07 10/07/18 RAM  5:40p| Sort result
# .(90315.05  3/15/19 RAM 11:20a| Fix help
# .(21027.04 10/27/22 RAM  3:20p| Modify Heading
# .(21203.02 12/03/22 RAM 11:40p| Put quotes around $1 and aDir
# .(21203.03 12/03/22 RAM 11:40p| Exclude node_modules and .git
# .(21203.04 12/03/22 RAM 11:40p| Change Column codes
# .(21206.06 12/06/22 RAM  6:45p| Add -r and -c to dirlist
# .(21206.06 12/31/22 RAM 11:59p| 2nd attempt at -r and -c for dirlist
# .(30503.03  5/03/23 RAM  4:09p| Exclude .next
# .(30516.01  5/16/23 RAM  8:45a| Add commas
# .(30516.02  5/16/23 RAM  9:20a| Add version and source

##PRGM     +====================+===============================================+
##ID 69.600. Main               |
##SRCE     +====================+===============================================+
#*/
    aVdt="May 16, 2023 9:20a"; aVtitle="Robin's Script Tools"                                                                   # .(21113.05.6 RAM Add aVtitle for Version in Begin).(30516.02.1)
    aVer="$( echo $0 | awk '{  match( $0, /_[dpstuv][0-9]+\.[0-9]+/ ); print substr( $0, RSTART+1, RLENGTH-1) }' )"             # .(21031.01.1 RAM Add [d...).(20416.03.8 "_p2.02", or _d1.09)

            LIB="RSS"; LIB_LOG=${LIB}_LOG; LIB_USER=${LIB}_USER                             # .(80923.01.1)

  function  logIt() {                                                                       # .(80920.02.1)
            aFncLine="$1[$2]             "; aFncLine="${aFncLine:0:17} $3";
#           aFncLine="${aFncLine/ \//\/}";  aFncLine="${aFncLine/ C:/C:}";  aFncLine="${aFncLine/ D:/D:}";  aFncLine="${aFncLine/ M:/M:}";
   if [ -f "$LIB_LOG" ]; then echo "$( date '+%Y%m%d-%H%M%S%z')  ${SCN_SERVER:0:11} ${LIB_USER:0:8}  ${aFncLine}" >>"$LIB_LOG"; fi
            }

  if [ "${1:0:3}" == "ver" ] || [ "${1:0:2}" == "-v" ]; then                                                # .(20420.07.1 RAM Added Version).(21113.05.1 RAM Beg Added).(30516.02.2 RAM Beg Add verson and source)
     echo ""
     echo "  ${aVtitle}: ${aVer}   (${aVdt})"                                                               # .(21113.05.2)
     if [ "${1:0:3}" == "-ve" ]; then echo "    $0"; fi                                                     # .(20620.01.1 RAM)
     echo ""
     exit
     fi                                                                                                     # .(21113.05.1 RAM End)

  if [ "${1}" == "source"   ]; then echo ""; echo $0 | awk '{                         print "  '$LIB' Script File(s): \"" $0 "\"" }'; echo ""; exit; fi  # .(80923.02.3 Was "JPT-..)
# if [ "${1}" == "source"   ]; then echo ${aFns}     | awk '{                         print "                      \""    $0 "\"" }'; echo ""; exit; fi  # .(30516.02.2)

# +------- +------------------ +----------------------------------------------------------- # ------------+ ------------------- # --------------+

            aNums="0123456789";                                                                                                                          # .(21206.06.7 RAM Beg Much different)
            aDir="."; if [ "${1:0:1}" != "-" ]; then aDir="$1"; fi;
                      if [ "${aNums##*$aDir*}" != "" ] && [ "${1:0:1}" != "-" ]; then shift; else aDir="."; fi                                           # .(21206.06.8)
            nLvl="";  if [ "${1:0:1}" != "-" ]; then nLvl=$1; fi                                                                                         # .(21206.06.9 RAM Was: nLvl=$2; if [ "$2" = "" ]; then nLvl=1; fi)
#           nTyp=$3;  if [ "$3"      == "" ]; then nTyp=3;    fi   # 1)Names only, 2)Sizes only, 3)Sizes, Files and Dirs
            nTyp="";  if [ "${2:0:1}" != "-" ]; then nTyp=$2; fi   # 0)Names only, 1)Sizes only, 2)Sizes, and Files, 3)Sizes, Files and Dirs             # .(21203.04.1 RAM Change nTyp codes)# .(21206.06.7 RAM End)

            mArgs=( "$@" );                          # echo "-- aDir: ${aDir}, nLvl: ${nLvl}; nTyp: ${nTyp}"                                             # .(21206.06.5 RAM Beg)
#           for aArg in "$[@]"; do                     echo "aArg: "
            for (( i = 0; i < ${#mArgs[@]}; i++ )); do aArg="${mArgs[$i]}"; # echo "-- $i: ${mArgs[$i]:1:1} = ${mArgs[ (( i + 1 )) ]}"
                if [ "${aNums##*$aArg*}" != "" ]    && [ "${aDir}" == "." ]   &&  [ "${aArg:0:1}" != "-" ]; then aDir="${aArg}"; fi                      # .(21206.06.10)
#               if [ "${mArgs[$i]}" == "-r" ]; then nLvl="${mArgs[ (( i + 1 )) ]}"; if [ "${nTyp}" == "" ]; then nTyp="${mArgs[ (( i + 2 )) ]}"; fi; fi  ##.(21206.06.11)
 #              if [ "${mArgs[$i]}" == "-c" ]; then nTyp="${mArgs[ (( i + 1 )) ]}"; if [ "${nLvl}" == "" ]; then nLvl="${mArgs[ (( i + 2 )) ]}"; fi; fi  ##.(21206.06.12)
                if [ "${mArgs[$i]}" == "-r" ]; then nLvl="${mArgs[ (( i + 1 )) ]}"; nTyp="${mArgs[ (( i + 2 )) ]}"; fi                                   # .(21206.06.11)
                if [ "${mArgs[$i]}" == "-c" ]; then nTyp="${mArgs[ (( i + 1 )) ]}"; if [ "${nLvl}" == "" ]; then nLvl="${mArgs[ (( i + 2 )) ]}"; fi; fi  # .(21206.06.12)
                done;
#           if [ "${mArgs[0]:0:1}"  == "-"  ]; then aDir="."; fi
#           if [ "$nLvl" == "-c"            ]; then nLvl=${nTyp}; fi                                                                                     # .(21206.06.5 RAM End)

            aNums="0123456789";                      # echo "-- aDir: ${aDir}, nLvl: ${nLvl}; nTyp: ${nTyp}"                                             ##.(81007.05.1).(21206.06.13)
#           if [ -z "${aNums##*$aDir*}"       ]     && [ "${aDir}" != "." ]; then nTyp=${nLvl}; nLvl=${aDir}; aDir="."; echo "nums in aDir"; fi          ##.(81007.05.2).(21206.06.14)
            if [    "${aNums##*$nLvl*}" != "" ] || [ "${nLvl}" == "" ]; then nLvl=1; fi                                                                  # .(21206.06.13)
            if [    "${aNums##*$nTyp*}" != "" ] || [ "${nTyp}" == "" ]; then nTyp=1; fi                                                                  # .(21206.06.14)

#   echo "  aCmd: ${aCmd}; aDir: ${aDir}; nLvl: ${nLvl}; nTyp: ${nTyp}"; # exit

#HELP
#---------------------------------------------------------------

#   if [ "${aCmd}" == ""        ]; then aCmd=help; fi
    if [ "${aDir}" ==  "-help"  ]; then aDir=help; fi                                       # .(90315.05.1 RAM aCmd=dirlist)
    if [ "${aDir}" == "--help"  ]; then aDir=help; fi                                       # .(90315.05.2 RAM)
    if [ "${aDir}" == "help"    ]; then

            echo ""
            echo "  List Directory Files, Dir Counts & Sizes   (${aVer})  (${aVdt})"
            echo "  --------------------------------------------------  ------------------------------------------------"
            echo "    RSS DirList {Dir} [-r {Level} ] [ -c {Typ} ]       Display NFS Directories, down to level {Level}"        # .(21206.06.6)
#           echo "                                         {Typ}         1) Names only, 2) Sizes only, 3) Files and Dirs"       ##.(21203.04.2)
            echo "                                         {Typ}         0) Names only, 1) Sizes only, "                        # .(21203.04.2)
            echo "                                                       2) Sizes and Files, 3) Sizes, Files and Dirs"          # .(21203.04.2)
            echo "                                                       Default is: dirlist 1 1, or dirlist . 1 1"             # .(21203.04.3 RAM was 1 2)
#           echo ""
            ${aLstSp}; exit
    fi
#  ------------------------------------------------------------------------------------------

  function  getCnts1() {
        aDir="$1"; if [ ! "${a/lost+found/}" = "$a" ]; then return; fi              # .(11203.02.5 RAM Use Quotes)
#       printf "%12s %7s %6s  %s\n" "" "" "" $1                                     ##.(11203.02.6 )
        printf "%12s %9s %7s  %s/\n" "-" "-" "-" "${aDir}"                          # .(81007.06.1).(11203.02.6)
        }

  function  getCnts2() {
        aDir="$1"; if [ ! "${aDir/lost+found/}" = "$aDir" ]; then return; fi        # .(11203.02.7 RAM Use Quotes)
#       aDir=${aDir## /}

#       echo ""
#       printf "  du -L -b --max-depth=0 \"$aDir\"\n"
#       printf "  ls -l -L -R \"$aDir\" | grep ^- | wc -l\n"
#       printf "  ls -l -L -R \"$aDir\" | grep ^d | wc -l\n"
#       return

        nSize=999; nFles="-"; nDirs="-"
    if [ "$nTyp" == "2" ] || [ "$nTyp" == "3" ]; then                               # .(21203.04.4)
        nFles=$( ls -l -L -R "${aDir}" 2>/dev/null | grep ^- | wc -l )              # Counts number of files in all subfolders (takes a long time)
#       nDirs=$( ls -l -L -R  $1       2>>$aErrLog | grep ^d | wc -l )              # Counts number of folders in all subfolders (takes a long time)
#       nDirs=$( ls -l -L -R  $1       2>/dev/null | grep ^d | wc -l )              ##.(81007.03.1).(11203.02.8)
        nDirs=$( ls -l -L -R "${aDir}" 2>/dev/null | grep ^d | wc -l )              # .(81007.04.1).(11203.02.8)
        fi

#       nSize=$( du -L    --max-depth=0  $1       2>>$aErrLog  )                    # Counts number of bytes in all subfolders (quick)
#       nSize=$( du -L    --max-depth=0  $1       2>/dev/null )                     ##.(81007.03.2).(11203.02.9)
#       nSize=$( du -L    --max-depth=0 "${aDir}" 2>/dev/null )                     ##.(81007.03.2).(11203.02.9)
        nSize=$( du -L -b --max-depth=0 "${aDir}" 2>/dev/null )                     # .(81007.04.1 Display bytes).(11203.02.9)

        export LC_NUMERIC="en_US"

#       nSize=$( echo $nSize | sed 's/\x0*/ /' )
        aStrc=$( echo $nSize | awk '{ sub( / .*/, "" ); print }' )
#       aStrc=$( echo $nSize | awk '{ gsub( /\B(?=(\d{3})+(?!\d))/, "," ); print; }' )
#       aStrc=$( echo $nSize | awk '{ gsub( /\B(?=([0-9]{3})+(?![0-9]))/, "," ); print; }' )
#       aStrc=$( echo $nSize | awk '{ printf "%d@%d\n" }' )
#       aStrc=$( echo $nSize | awk "{ printf \"%d@%'d\n\" }" )
#       echo  { printf "%d@%'d\n", $1, $2 }  >t.awk
        aStrc=$( printf "%'d\n" $aStrc )                                           # .(30516.01.1 RAM Add Commas)
#       echo 1234567 | awk "{ printf \"%'d\n\",\$1}"

#       echo "'$nSize' '${aStrc}'"; exit # '2152308188/data' '2152308188'

#       echo ""
#       printf "nSize:%6d == du -L -b --max-depth=0 \"$aDir\"\n"        ${aStrc}
#       printf "nFles:%6d == ls -l -L -R \"$aDir\" | grep ^- | wc -l\n" ${nFles}
#       printf "nDirs:%6d == ls -l -L -R \"$aDir\" | grep ^d | wc -l\n" ${nDirs}
#       printf "nSize:%6d == \"%s\"\n" "${aStrc}" "$aDir"
#       return

    if [ "$nTyp" == "2" ]; then nDirs="        -"; fi                               # .(21203.04.5)

# if [[ ${#aStrc} -gt 8 ]]; then aStrc=`expr $aStrc / 1000`; s="${aStrc}K"; fi      # results is a neg number ??

#       printf "%12d %7d %6d     %s\n" $s $a     $b     $1
#       printf "%12s %9s %7s  %s\n"   $aStrc  $nFles $nDirs  $1
#       printf "%12s %9s %7s  %s/\n"  $aStrc  $nFles $nDirs  $1
#       printf "%12s %9s %7s  %s/\n"  $aStrc  $nFles $nDirs "$1"                    # .(81007.04.2)
#       printf "%12s %9s %7s  %s/\n" "$aStrc" $nFles $nDirs "${aDir}"               # .(81007.06.1).(11203.02.10)
        printf "%15s %7s %6s  %s/\n" "$aStrc" $nFles $nDirs "${aDir}"               # .(81007.06.1).(11203.02.10).(30516.01.2)
        }
#  ------------------------------------------------------------------------------------------

 if [ "$aErrLog" = "" ]; then
        aDte=$(date +%y%m%d.%H%M); aDte=${aDte:1}
        aErrLog=sc${aDte}_dirlist-errors.log
if [ ! "$nTyp" = "1" ]; then
#       echo "" >$aErrLog                                                           ##.(81007.03.3)
        aErrLog=""                                                                  # .(81007.03.3)
        fi; fi

if [ "$bHdr" != "0" ]; then
        s="s"; if [ "${nLvl}" == "1" ]; then s=""; fi
#       echo ""
#       echo      " Folder Size  Files     Dirs    Path (${aDir} - ${nLvl} level$s)"
#       echo -e "\n Folder Size     Files    Dirs  $( pwd )/$aDir (${nLvl} level$s)"
        echo -e "\n  Folder Size     Files   Dirs  $( pwd )/$aDir (${nLvl} level$s)" # .(30516.01.3)

#       echo " ----------- ------- ------      ---------------------------------------------------"
#       echo " +---------- +-------- +------ +----------------------------+-------------------+---------- +-------------+"   # .(81005.02.2)
#       echo "+--,--,--,-- +-------- +------ +----------------------------+-------------------+---------- +-------------+"   # .(81005.02.2)
        echo "+-------------- +------ +----- +----------------------------+-------------------+---------- +-------------+"   # .(81005.02.2).(30516.01.4)
        fi

#       aExcl='('  -path './.git/*' -or -path '*/node_modules/*' ')'                 # error
#       aExcl="'(' -path './.git/*' -or -path '*/node_modules/*' ')'"                # finds none
#       aExcl="(   -path './.git/*' -or -path '*/node_modules/*'  )"                 # finds all
#       aExcl="(   -path  ./.git/*  -or -path */node_modules/* )"                    # finds none
#       aExcl="(   -path  ./.git/*  -or -path */node_modules/* -or- .next/* )"
#       aExcl="\!  -path  '*.git/*' \!  -path '*node_modules/*'  \! -path '*.next*'"
#       aExcl="\(  -path  '*.git/*' -or -path '*node_modules/*' -or -path '*.next/*' \)"
#       aExcl="\(  -path \"*.git/*\" \)"
#       aExcl="(   -path \"*.git/*\"  )"
#       aExcl="(   -path '\*.git/\*'  )"
#       aExcl="(   -path \"\*.git/\*\" )"

  if [ "$nTyp" == "0" ]; then
#       find   $aDir   -maxdepth $nLvl -type d                                  2>>$aErrLog |        while read -r  dir; do getCnts1   "$dir";  done  ##.(81007.03.4)
#       find "${aDir}" -maxdepth $nLvl -type d                                  2>/dev/null |        while read -r aDir; do getCnts1  "$aDir";  done  ##.(81007.03.4).(21203.02.1)
        find "${aDir}" -maxdepth $nLvl -type d -not '(' -path '*/.git/*' -or -path */node_modules/* ')'  2>/dev/null |        while read -r aDir; do getCnts1 "${aDir}"; done   # .(81007.03.4).(21203.02.1).(21203.03.1 RAM Exclude .git)
      else
#       find   $aDir   -maxdepth $nLvl -type d                                  2>>$aErrLog |        while read -r  dir; do getCnts2   "$dir";  done  ##.(81007.03.5)
#       find  "$aDir"  -maxdepth $nLvl -type d                                  2>/dev/null | sort | while read -r aDir; do     echo  "$aDir";  done
#       find "${aDir}" -maxdepth $nLvl -type d                                  2>/dev/null | sort | while read -r aDir; do getCnts2 "${aDir}"; done  ##.(81007.07.1).(21203.02.2)
#       find "${aDir}" -maxdepth $nLvl -type d -not -path */.git|node-modules/* 2>/dev/null | sort | while read -r aDir; do getCnts2 "${aDir}"; done  ##.(81007.07.1).(21203.02.2).(21203.03.2)
#       find "${aDir}" -maxdepth $nLvl -type d -not ${aExcl}                    2>/dev/null | sort | while read -r aDir; do getCnts2 "${aDir}"; done  ##.(81007.07.1).(21203.02.2).(21203.03.2)
#       find "${aDir}" -maxdepth $nLvl -type d -not '(' -path '*/.git/*' -or -path */node_modules/* ')'  2>/dev/null | sort | while read -r aDir; do getCnts2 "${aDir}"; done   # .(81007.07.1).(21203.02.2).(21203.03.2)
        find "${aDir}" -maxdepth $nLvl -type d -not '(' -path '*git/*'   -or -path '*node_modules/*' -or -path '*.next/*' ')' 2>/dev/null |        while read -r aDir; do getCnts2 "${aDir}"; done  # .(81007.03.4).(21203.02.1).(21203.03.1 RAM Exclude .git).(30503.03.1 RAM Exclude .next)

#       find "${aDir}" -maxdepth $nLvl -type d      "${aExcl}"                  2>/dev/null | sort | while read -r aDir; do getCnts2 "${aDir}"; done   # .(81007.07.1).(21203.02.2).(21203.03.2)
#       find "${aDir}" -maxdepth $nLvl -type d -not "${aExcl}"
#echo   find "${aDir}" -maxdepth $nLvl -type d -not "${aExcl}"
        fi

  if [ "$bHdr" != "0" ]; then
        ${aLstSp}; exit
#       echo ""
        fi

# +------- +------------------ +----------------------------------------------------------- # ------------+ ------------------- # --------------+
#*\
##SRCE     +====================+===============================================+
##RFILE    +====================+=======+===================+======+=============+
#*/
