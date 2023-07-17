#!/bin/bash
#*\
##=========+====================+================================================+
##RD         FileList           | RSS File Lister aka RDir
##RFILE    +====================+=======+================+======+================+
##FD   RSS21-FileList.sh        |   9479| 10/08/18  1:48p|   136| v1.5.81008.01
##FD   RSS21_FileList.sh        |  12243| 11/14/22  8:05p|   179| v1.07.21114.2005
##FD   RSS21_FileList.sh        |  12902| 11/17/22 12:01p|   184| v1.07.21117.1201
##FD   RSS21_FileList.sh        |  14539| 12/03/22 11:30a|   187| p1.07.21203.1130
##DESC     .--------------------+-------+----------------+------+----------------+
#            List files similar to Windows dir.  Also use switches
#
#              rdir {Dir} {Filesearch} (not {Dir}/{Filesearch})
#
#              -r #  Recursively Down n Levels
#              -s #  Sort by 1) Size, 2) Date, or 3) Name
#              -s #r Sort in reverse order: highest at top
#              -d #  Saved n Previous Days back
#              -n #  Saved n Previous Months back
#              -x "" Exclude files.  Defaults to node_modules and .git
#
##LIC      .--------------------+----------------------------------------------+
#            Copyright (c) 2018-2022 JScriptWare * Released under
#            MIT License: http://www.opensource.org/licenses/mit-license.php
##FNCS     .--------------------+-------+-------------------+------+-----------+
#
##CHGS     .--------------------+-------+-------------------+------+-----------+
# .(80916.01  9/16/18 RAM  3:26p| Add source command
# .(80916.02  9/16/18 RAM  8:15a| Add version
# .(80916.03  9/17/18 RAM  2:08p| Add Header
# .(80920.03  9/20/18 RAM  3:00p| Change heading; Add LogIt for old heading
# .(80923.03  9/23/18 RAM  6:50a| Change JPT to RSS
# .(80925.04  9/25/18 RAM  6:25a| Replace % with *
# .(81005.01 10/05/18 RAM 10:00p| Fix sort sequence
# .(81005.02 10/05/18 RAM 11:30p| Make -s 3 the default
# .(81008.01 10/08/18 RAM  1:45a| Always sort by Date-Time 2nd
# .(90401.01  4/01/19 RAM  1:45p| Add Help
# .(90401.02  4/01/19 RAM  1:45p| Add Find Tip
# .(10826.01  8/26/21 RAM  3:25p| Add -not node-modules
# .(10923.01  9/23/21 RAM  4:16a| Add commented out awk statement
# .(11010.01 10/10/21 RAM  8:05p| Add -i option, defaults to /node-modules$/
# .(21114.07 11/13/22 RAM  8:05p| Change Headings
# .(21117.02 11/17/22 RAM  9:45p| Get rid of ".40.3971848000  ."
# .(21203.01 12/03/22 RAM 11:30a| Exclude only ".git"

##PRGM     +====================+===============================================+
##ID 69.600. Main               |
##SRCE     +====================+===============================================+
#*/
# +------- +------------------ +----------------------------------------------------------- # ------------+ ------------------- # --------------+

    aVdt="Dec 03, 2022 11:30a"; aVtitle="formR gitR Tools"                                                                      # .(21113.05.6 RAM Add aVtitle for Version in Begin)
    aVer="$( echo $0 | awk '{  match( $0, /_[dpstuv][0-9]+\.[0-9]+/ ); print substr( $0, RSTART+1, RLENGTH-1) }' )"             # .(21031.01.1 RAM Add [d...).(20416.03.8 "_p2.02", or _d1.09)

    nMaxDepth=1; i=-1;                                                                                                          ## .(60506.01.1)
#hile [[ $# > 1 ]]; do key="$1"; # echo "key: '${key}', \$2: '$2'"
while [[ $# > 0 ]]; do key="$1"; # echo "key: '${key}', \$2: '$2'"
                                                                                       aExcl="node_mod|bower_comp|\\.git"       # .(80118.01.1).(21203.01.1 RAM Exclude only ".git")
                                                                                       aIncl=""                                 # .(11010.01.1)
   case $key in
      -r|-R)  if [ "${2:0:1}" != "-" ] && [  ! -z  $2 ]; then nMaxDepth=$2; shift; else nMaxDepth=99;                    fi; ;; # echo "nMaxDepth: $nMaxDepth"; ;;
      -d|-D)  if [ "${2:0:1}" != "-" ] && [  ! -z  $2 ]; then nDays=$2;                       shift;                     fi; ;; # echo "nDays: ${nDays}"; ;;
      -m|-M)  if [ "${2:0:1}" != "-" ] && [  ! -z  $2 ]; then nMths=$2; nDays=$[nMths * 30];  shift;                     fi; ;; # echo "nDays: ${nDays}"; ;;
      -s|-S)  if [ "${2:0:1}" != "-" ] && [  ! -z  $2 ]; then nSort="$2";   shift; else nSort="2";                       fi; ;; # echo "nSort: ${nSort}"; ;;
      -x|-X)  if [ "${2:0:1}" != "-" ] && [  ! -z  $2 ]; then aExcl="$2";   shift; else aExcl="node_mod|bower_comp";     fi; ;; # echo "aExcl: ${aExcl}"; ;;
#     -i|-I)  if [ "${2:0:1}" != "-" ] && [  ! -z  $2 ]; then aIncl="$2";   shift; else aIncl="node_modules$";           fi; ;; # echo "aIncl: ${aIncl}"; ;; # .(11010.01.2 RAM Add -i Inclide option).(11010.01.2 RAM Use -x)
#     -i|-I)  if [ "${2:0:1}" != "-" ] && [ "n" == $2 ]; then aIncl="node_module$";         fi; ;; # echo "aIncl: ${aIncl}"; ;;                              # .(11010.01.2 RAM Add -i Inclide option)
      -f|-F)  if [ "${2:0:1}" != "-" ]                 ; then bFile="1" ;                     shift;                     fi; ;; # echo "bFile: ${bFile}"; ;;
      -h|--help|-help|help|/\?)                               aHelp=true;             ;;                                                                     # .(90401.01.1 Added -help)
      *)                         i=`expr $i + 1`;             mArgs[$i]="$key";       ;;     # .(60506.01.2)
    esac;
    shift;
   done
# +------- +------------------ +----------------------------------------------------------- # ------------+ ------------------- # --------------+

#       aLstSp="echo "; if [ "${aOSv/w}" != "${aOSv}" ]; then aLstSp=""; fi                                                     # .(10706.09.1 RAM Windows returns an extra blank line).(21113.06.1 RAM Reverse).(21120.02.2)

#  if [ "${1:0:1}" != "-" ]; then mArgs[i++]="$1"; fi

# a="."; b='*'; opt="-maxdepth 1"
# echo "mArgs: '${mArgs[*]}', len=${#mArgs[*]}"

#  if [ ${#mArgs[*]} = 1 ];   then if [ ! -d  ${mArgs[0]}  ]; then   ##.(60910.01.1 if 1st arg is a folder, use it)
   if [ ${#mArgs[*]} = 1 ];   then if [ ! -d "${mArgs[0]}" ]; then   # .(70930.01.1 opps)
          mArgs[1]=${mArgs[0]};  mArgs[0]="."; fi; fi

       opt="-maxdepth ${nMaxDepth}"; aNum=""
  if [   -z "${mArgs[0]}" ]; then aDir="."; else aDir="${mArgs[0]}";     fi
  if [   -z "${mArgs[1]}" ]; then aStr='*'; else aStr="*${mArgs[1]}*";   fi; aSearch="-iname \"${aStr}\""
  if [ ! -z "${nDays}"    ]; then aSearch="-mtime -${nDays} ${aSearch}"; fi


  if [ ! -z "${nSort}"    ]; then if [ "${nSort:0:1}" == "1" ]; then aNum="n";  fi;
                                  if [ "${nSort:0:1}" == "2" ]; then aNum=",3"; fi
                                  if [ "${nSort:0:1}" == "3" ]; then nSort=4${nSort:1:1}; fi
                                                                     aSort=" | sort -k${nSort:0:1}${aNum}";
                                  if [ "${nSort:1:1}" == "r" ]; then aSort="${aSort}r"; fi; fi

  if [ ! -z "${aIncl}"    ]; then      aExcl=; fi
               aIncl2=$( echo "${aIncl}" |  awk '{ gsub( /[^A-Za-z0-9_]/, "" ); print }' );                                                                          #  echo "aIncl: '${aIncl}'; aIncl2: '${aIncl2}'; aExcl: '${aExcl}'"; #exit
  if [ ! -z "${aExcl}"    ]; then      aExclude=" | awk '/${aExcl}/ { next }; { print }'";                                               aExcl=" -x '${aExcl}'"; fi; #  echo "aExclude: \"${aExclude}\""  # exit
  if [ ! -z "${aIncl}"    ]; then      aInclude=" | awk '/${aIncl}/ { a=\$0; if (1 == gsub(/${aIncl2/$/}/, \"\", a)) { print } }'";      aIncl=" -i '${aIncl}'"; fi; #  echo "aInclude: \"${aInclude}\"";   exit  # .(11010.01.4)


# +------- +------------------ +----------------------------------------------------------- # ------------+ ------------------- # --------------+

  if [ ! -z "${aHelp}"    ]; then

    echo ""
    echo "  File Lister         (${aVer})                                 (${aVdt})"
    echo "  -----------------   -------------------------------------------------------------------------"
    echo "  Syntax: RDir [Path] [Opts] {SearchPattern}"
    echo ""
    echo "    SearchPattern:    Unix Find -iname search string, defaults to '*'"
    echo "    Path:             Optional, defaults to '.'"
    echo ""
    echo "    Opts: -r [n]      Search [n] directory levels, defaults to 99"
    echo "          -d [n]      Search files saved in last [n] days, defaults to 1"
    echo "          -m [n]      Search files saved in last [n] months, defaults to 1"
    echo "          -s [n]      Sort output 1)Size, 2)Date & Time, 3)[path]/Filename"
    echo "          -s [n[r]]   Reverse sort order, defaults to 2r"
    echo "          -x [str]    Exclude RegEx pattern from result, defaults to 'node_mod|bower_comp'"
#   echo "          -i [str]    Include RegEx pattern from result, defaults to 'node_mod|bower_comp'"                              # .(11010.01.3)
#   echo ""
  else

#   echo ""                                                                                                                       ##.(21114.07.2)
#   echo "        find \"${aDir}\"" ${opt} -iname "'"${aStr}"'"
#   echo "        find \"${aDir}\" ${opt} ${aSearch}${aSort}${aExcl}"                                                             ##.(11010.01.5)
# if [ "${bDebug}" == "1" ]; then                                                                                               # .(21117.02.1)
#   echo "        find \"${aDir}\" ${opt} ${aSearch}${aSort}${aExcl}${aIncl}"; fi                                                 # .(11010.01.5).(21114.07.2).(21117.02.2)
#   bQuiet=0; bSpace=0; sayMsg "                                find \"${aDir}\" ${opt} ${aSearch}${aSort}${aExcl}${aIncl}" -1    # .(21117.02.2)
#   echo -e "\n Folder Size     Files    Dirs  $( pwd )/$aDir"                                                                    # .(21114.07.2)
    echo -e "\n   File Size     Date    Time   $( pwd )/$aDir"                                                                    # .(21114.07.2)

  if [ ! -z "${bFile}" ]; then
  echo "  ----------  ----------------  -------------------------------------------------------------------------------------------------------------  ------------------"

          aFmt='  %10s  %TY-%Tm-%Td %TH:%TM  %-110p %f \n';
    else
        # +------- +------------------ +----------------------------------------------------------- # ------------+ ------------------- # --------------+
  echo "  ----------  ----------------  ---------------------------------------------------------------------------"

#         aFmt='  %10s  %TY-%Tm-%Td %TH:%TM      %p\n';                                       #  echo "aFmt '${aFmt}'"          ##.(10707.07.1)
          aFmt='  %10s  %TY-%Tm-%Td %TH:%TM.%TS  %p\n';                                       #  echo "aFmt '${aFmt}'"          # .(10707.07.1 RAM add Seconds)
      fi

# aCmd="find \"${aDir}\" ${opt} ${aSearch} -printf \"  %10s  %TY-%Tm-%Td %TH:%TM  %p\n\"";       echo "aCmd: '${aCmd}'"
# aCmd="find \"${aDir}\" ${opt} ${aSearch} -printf \""${aFmt}"\"";                            #  echo "aCmd: '${aCmd}'"

if [ "${aIncl}" == "" ]; then                                                                                                   # .(11010.01.6 RAM Include just Node_modules folders)
  aCmd="find \"${aDir}\" ${opt} ${aSearch} -not -path "*/node-modules/*" -printf \""${aFmt}"\"";                                # .(10826.01.2 RAM)
else                                                                                                                            # .(11010.01.7 Beg)
  aCmd="find \"${aDir}\" ${opt} ${aSearch} -printf \""${aFmt}"\"";
  fi
                                                                                                                                # .(11010.01.7 End)
# awk '{ n=index($0"/!_", "/!_"); printf "%-100s %s\n", substr($0,1,n-1), substr($0,n+1) }'                                     # .(10923.01.1 RAM ??)
# echo "${aCmd}${aExclude}${aSort}"; exit

if [ "${aIncl}" == "" ]; then                                                                                                   # .(11010.01.8)
# echo "${aCmd}${aExclude}${aSort}";  exit
# eval "${aCmd}${aExclude}${aSort}";  exit                                                                                      # .(10707.,07.2)
# eval "${aCmd}${aExclude}${aSort}" | awk '{ t=substr($3,1,5);                 printf "%12d  %10s %5s  %s\n", $1, $2, t,        $4    }'              ##.(10707.07.2).(10903.03.1)
# eval "${aCmd}${aExclude}${aSort}" | awk '$4 != "." { t=substr($3,1,5); i=index($0,$4); printf "%12d  %10s %5s  %s\n", $1, $2, t, substr($0,i) }'    # .(10707.07.2).(10903.03.1 RAM Print filename with spaces)
  eval "${aCmd}${aExclude}${aSort}" | awk '$4 != "." { t=substr($3,1,5); i=index($0,$4); printf "%12d  %10s %5s  %s\n", $1, $2, t, substr($0,i) }'    # .(21117.02.1 RAM Added $4 != ".")
else                                                                                                                            # .(11010.01.9 Beg)
# echo "${aCmd}${aInclude}${aSort}";  exit
  eval "${aCmd}${aInclude}${aSort}" | awk '$4 != "." { t=substr($3,1,5); i=index($0,$4); printf "%12d  %10s %5s  %s\n", $1, $2, t, substr($0,i) }'    # .(21117.02.2)
  fi                                                                                                                            # .(11010.01.9 End)

if [ "$?" != "0" ]; then                                                                                                        # .(90401.01.1 RAM Beg ??)
   echo "   *** Perhaps the wrong find is being used. Check: which find"
   which find | awk '{ print "       " $0 }'
#  echo ""
   fi                                                                                                                           # .(90401.01.1 RAM Beg ??)

   ${aLstSp} # echo ""
   fi
# +------- +------------------ +----------------------------------------------------------- # ------------+ ------------------- # --------------+
#*\
##SRCE     +====================+===============================================+
##RFILE    +====================+=======+===================+======+=============+
#*/






