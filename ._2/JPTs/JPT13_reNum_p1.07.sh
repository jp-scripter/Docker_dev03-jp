#!/bin/bash

         aFile="$( basename $1 )"
         aFCd="$2"

      if [ "${bDoit}"  == "" ]; then bDoit=0; fi
      if [ "${bQuiet}" == "" ]; then bQuiet=0; fi
      if [ "${aFCd}"   == "" ]; then aFCd="${aFile:0:5}"; fi   # .(21128.03.1 RAM First 5 chars of Filename)

#             aFCd='GitR1'; aFile="FRT22_${aFCd}_p2.02.sh"
#             aFCd='JPFns'; aFile="JPT12_Main2Fns_p1.06.sh"
#             aFCd='FRT10'; aFile="${aFCd}_frt_p1.06.sh"
#             aFCd='{JPT}'; aFile="FRT90_frt_u1.06-MT.sh"
#             aFCd='JPT10'; aFile="JPT10_Main0_p1.06.sh"

#     if [ "${aFCd}" == "FRT10" ]; then aFCd="FRT10"; fi       # .(21128.03.2 RAM Use as is)          keyS1     
      if [ "${aFCd}" == "FRT21" ]; then aFCd="keyS1"; fi       # .(21128.03.3 RAM Swap)               keyS1     
      if [ "${aFCd}" == "FRT22" ]; then aFCd="gitR1"; fi       #                                      gitR1
      if [ "${aFCd}" == "FRT23" ]; then aFCd="gitR2"; fi       # .(21128.03.4 RAM Swap)               gitR_clone

#     if [ "${aFCd}" == "FRA23" ]; then aFCd="FRApp"; fi       # .(21128.03.5 RAM Visit later)        ??  

#     if [ "${aFCd}" == "JPT10" ]; then aFCd="JPT10"; fi       # .(21128.03.6 RAM Use as is)          Main1     
      if [ "${aFCd}" == "JPT12" ]; then aFCd="JPFns"; fi
#     if [ "${aFCd}" == "JPT13" ]; then aFCd="JPT13"; fi       # .(21128.03.7 RAM Use as is)          reNum     
#     if [ "${aFCd}" == "JPT21" ]; then aFCd="JPT21"; fi       # .(21128.03.8 RAM Use as is)          Dirs1
#     if [ "${aFCd}" == "JPT30" ]; then aFCd="JPT30"; fi       # .(21128.03.9 RAM Use as is)          docR0    
      if [ "${aFCd}" == "FRT90" ]; then aFCd="{JPT}"; fi       #                                      Template
      if [ "${aFCd}" == "FRT99" ]; then aFCd="{JPT}"; fi       # .(21128.03.10 RAM Swap)              Template

#     if [ "${aFCd}" == "RSS21" ]; then aFCd="RSS21"; fi       # .(21128.03.11 RAM Use as is)         ListList
#     if [ "${aFCd}" == "RSS22" ]; then aFCd="RSS22"; fi       # .(21128.03.12 RAM Use as is)         DirList
      if [ "${aFCd}" == "RSS22" ]; then aFCd="RSS23"; fi       # .(21128.03.13 RAM Use as is)         Info 

#        bDoit=0

# ------------------------------------------------------------------------------------------------------------------------------

      if [ ! -f "${aFile}" ]; then
         echo ""
         echo " ** The script file, '${aFile}', is not in the current folder."
#        echo ""
         exit
         fi

         echo "  - JPT13[ 46]  aFCd:  '${aFCd}', aFile: '${aFile}'"; #  exit

# ---------------------------------------------------------------

#       "##FD   %-25s                    |%7d    | %-15s         |%6d   | %s\n"
#               -------------------------+-------+---------------+------+-----------------
#       '##FD   JPT21_gitr.sh            |   9479| 11/25/21 8:35a|   136| v1.02.11003.01
#     6) ##FD   FRT22_GitR1_p2.02.sh     |  66322|  5/01/22 20:40|  1173| p2.02-20501-2040

         aTS=$( date '+%y%m%d.%H%M' ); aTS="\`${aTS:1}";  # echo "  aTS: '${aTS}'"; # exit
         aCnts="$( wc ${aFile} | awk '{ printf "%7d%6d\n", $3, $1 }' )";
         nSize=${aCnts:1:6}; nSize=$(( ${nSize} + 82 ))
#        nLines=$(( ${aCnts:8:5} - 1 ))                                                             # .(21117.03.2 RAM nLines - 1)
         nLines=$(( ${aCnts:8:5} + 1 ))                                                             # .(21128.03.2 RAM nLines + 1)
         aDate="$( date '+%-m/%d/%y %H:%M' )"
         aDat2="$( date '+%b %d, %Y %l:%M%p' | awk '{ sub( /PM/, "p"); sub( /AM/, "a"); print }' )" # .(21117.04.2 RAM Add nice version date)

#                                                            FRT90_frt_u1.06-MT.sh
#        aVer=$( echo ${aFile} | awk '{ v = gensub( /.+[-_]([ptu][0-9.]+).sh/,                                          "\\1", "g", $0 ); print v }' )
#        aVer=$( echo ${aFile} | awk '{ v = gensub( /.+[-_]([ptu][0-9.]+)(-MT)*.sh/,                                    "\\1", "g", $0 ); print v }' )
#        aVer=$( echo ${aFile} | awk '{ v = gensub( /.+[-_]([ptuv][0-9.]+[abz]*)(-.+)*.(sh|js|json.njs|json|njs|html)/, "\\1", "g", $0 ); print v }' )
#        aVer=$( echo ${aFile} | awk '{ v = gensub( /.+[-_]([ptuv][0-9]+[absz]*)([-.]*[0-9]+[absz]*)*.(sh|js|json.njs|json|njs|html)/, "\\1\\2", "g", $0 ); print v }' )
         aVer=$( echo ${aFile} | awk '{ v = gensub( /.+[-_]([ptu][0-9.]+[absz]*)*(_v[0-9.-]+[absz]*)*\.(sh|js|json.njs|json|njs|html)/, "\\1\\2", "g", $0 ); print v }' )

         aFle=$( echo ${aFile} | awk '{ sub( /_'${aVer}'/, "" ); print }' );

         aVer2=${aVer}; aVer=${aVer/./-};
#        aVer=$( echo ${aVer}  | awk '{ sub( /^v[0-9.]+/,       "v1" ); print }' ); aVer1=${aVer}
         aVer=$( echo ${aVer}  | awk '{ sub( /_v[0-9-]+[absz]+/, ""  ); print }' ); aVer=${aVer/-/.}; aVer1=${aVer}

         echo ""
         echo "  - JPT13[ 76]  aFle:  '${aFle}', aVer: '${aVer}', aVer2: '${aVer2}'";  # exit

#        aVer="${aVer}-${aTS:1}";                                   aVn="v${aVer:1}"
#        aVer="${aVer}-${aTS:1}"; if [ "${aVer:0:1}" != "u" ]; then aVn="v${aVer:1}"; fi
         aVer="${aVer}-${aTS:1}";                                   aVn="x${aVer:1}"            # backup copy, not used


   if [ "${aFle}" == "${aVer1}" ]; then
#        echo ""; echo " ** Failed to parse version: '${aFle}'"; echo ""; # exit
         aVer="u1-${aTS:1}";                                        aVn="x${aVer:1}"            # backup copy, not used
         fi

# ---------------------------------------------------------------------------------------

aAWKscr1='
BEGIN{ n = 0 }
#      /##FD/ && n == 0 { printf "%4d) ##FD   %-25s| %6d| %14s| %5d| %s\n", NR, "'${aFle}'", '${nSize}', "'${aDate}'", '${nLines}', "'${aVer/-MT/}'"; n = 1; }
       /##FD/           { printf "%4d) %s\n", NR + n, $0 }
       /##DESC/         { printf "%4d) ##FD   %-25s| %6d| %14s| %5d| %s\n", NR, "'${aFle}'", '${nSize}', "'${aDate}'", '${nLines}', "'${aVer/-MT/}'"; n = 1; print "" }
       /'${aFCd}'\[/    { gsub( /'${aFCd}'\[[0-9 ]+\]/, "'${aFCd}'" sprintf( "[%3d]", NR + n ) ); printf "%4d) %s\n", NR + n, $0; next }
END{   }
'
aAWKscr2='
BEGIN{ n = 0 }
#      /##FD/ && n == 0 { printf      "##FD   %-25s| %6d| %14s| %5d| %s\n",     "'${aFle}'", '${nSize}', "'${aDate}'", '${nLines}', "'${aVer/-MT/}'"; n = 1; }
#      /##FD/           { printf      "%s\n",         $0; next }
       /##DESC/         { printf      "##FD   %-25s| %6d| %14s| %5d| %s\n",     "'${aFle}'", '${nSize}', "'${aDate}'", '${nLines}', "'${aVer/-MT/}'"; n = 1; }
       /aVdt=/          { sub( /=.+; aVtitle=/, "=\"'${aDat2}'\"; aVtitle=" ); print; next }                                         # .(21117.04.2)
       /'${aFCd}'\[/    { gsub( /'${aFCd}'\[[0-9 ]+\]/, "'${aFCd}'" sprintf( "[%3d]", NR + n ) ); print; next }
       { print }
END{ }
'
# ------------------------------------------------------------------------------------------------------------------------------

#        aFile2="$( echo "${aFile}" | awk '{ sub( /_[ptu]/,  "_v"  ); print }' )"
#        aFile2="$( echo "${aFile}" | awk '{ sub( /_[ptu]/,  "_x"  ); print }' )"               # backup copy, not used
         aFile2="$( echo "${aFile}" )"                                                          # Keep stage letter

#        aFile2="${aFile/.sh/${aTS}.sh}"; aFile2=$( echo "${aFile2}" | awk '{ sub( /_[ptu]/,  "_v"  ); print }' )"
#                   echo                "'{ sub( /\.sh/, \"${aTS}.sh\" );     sub( /_[ptu]/, \"_v\" ); print }'"
#                   echo "$aFile2" | awk '{ sub( /\.sh/, "'${aTS}'.sh" );     sub( /_[ptu]/,  "_v"  ); print }'
#        aFile2="$( echo "$aFile2" | awk '{ sub( /\.sh/, "'${aTS}'.sh" );     sub( /_[ptu]/,  "_v"  ); print }' )"

         echo "  - JPT13[119]  aFile2:'${aFile2}', aTS: ${aTS:1}";

#        aFile2=${aFile2/.sh/${aTS}.sh}
         aFile2="$( echo "${aFile2}" | awk '{ sub( /_'${aVer2}'/, "_'${aVer1}'" ); print }' )"                                       # Remove part of _old version

#        aFile2="$( echo "${aFile2}" | awk '{    sub( /.(sh|js|json.njs|json|njs|html)/, "_x'${aTS:1}'.bak"          ); print }' )"
#        aFile2="$( echo "${aFile2}" | awk '{    sub( /.(sh|js|json.njs|json|njs|html)/, "_v'${aTS:1}'.bak"          ); print }' )"  # Use _v and same .ext
         aFile2="$( echo "${aFile2}" | awk '{ print gensub( /.(sh|js|json.njs|json|njs|html)/, "_v'${aTS:1}'.\\1", 1 )        }' )"  # Use _v and same .ext
#                                                   gensub( /.*([0-9][0-9])d([0-9][0-9]).*/  , "\\2 \\1", "g", a);
#                                                   'JPT10_Main0_x1.06`21117-1254_x21117-1254.bak'
         echo "  - JPT13[129]  aFile2:'${aFile2}'"; # exit

# ---------------------------------------------------------------

#   if [ "${bQuiet}" == "0" ] && [ "${bDoit}" == 1 ]; then
    if [ "${bQuiet}" == "0" ]; then

         echo ""
    if [ "${bDebug}" == "1" ]; then
         echo "aAWKscr2:"; echo "---------------------------"; echo "${aAWKscr2}"; echo "---------------------------"; echo ""
         fi
         cat "${aFile}" | awk "${aAWKscr1}"

         echo ""
#        echo "    cp -p \"${aFile}\" \"${aFile2}\""

#        echo "    cp -p  '${aFile}'  '${aFile2/.sh/${aTS}.sh}'"
         echo "  - JPT13[146]  cp -p  '${aFile}'  '${aFile2}'"
         fi

# ---------------------------------------------------------------

   if [ "${bDoit}" == "1" ]; then

#        echo             "    cp -p  '${aFile}'  '${aFile2/.sh/${aTS}.sh}'"
#        echo             "    cp -p  '${aFile}'  '${aFile2}'"
#        echo "  - JPT13[155]  cp -p  '${aFile}'  '${aFile2}'"

   if [ "${aFile}" == "${aFile2}" ]; then
         echo ""; echo " ** Failed to make backup copy. Aborting"; echo ""; exit
         fi
                               cp -p  "${aFile}"  "${aFile2}"

   if [ ! -f "${aFile2}" ]; then
         echo ""; echo " ** Failed to make backup copy. Aborting"; echo ""; exit
         fi

#        cat "${aFile2/.sh/${aTS}.bak}" | awk "${aAWKscr2}" >"${aFile}"
         cat "${aFile2}"                | awk "${aAWKscr2}" >"${aFile}"

         echo ""
         echo "  - JPT13[170]  script '${aFile}'   has been formatted."
#        echo ""

         fi
# ------------------------------------------------------------------------------------------------------------------------------



