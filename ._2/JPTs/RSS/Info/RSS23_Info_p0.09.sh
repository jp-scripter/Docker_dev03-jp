#!/bin/bash
#*\
##=========+====================+================================================+
##RD         Info               | RSS Set and Show Stuff
##RFILE    +====================+=======+===================+======+=============+
##FD   RSS22-Info.sh            |   9510|  9/26/18 22:53|   191| v0.07.80923
##FD   RSS22-Info.sh            |  17214| 11/12/22 16:04|   318| p0.08.21112-1604
##FD   RSS22-Info.sh            |  18141| 11/12/22 18:28|   327| p0.08.21112-1828
##FD   RSS22-Info.sh            |  19554| 11/13/22 17:25|   344| p0.08.21113-1725
##FD   RSS22_Info.sh            |  25926| 11/20/22 13:43|   434| p0.08-21120.1343
##FD   RSS22_Info.sh            |  34136| 11/22/22 09:34|   523| p0.08-21122.0934
##FD   RSS22_Info.sh            |  54407| 11/27/22 19:42|   809| p0.08-21127.1942
##FD   RSS22_Info.sh            |  57783| 12/31/22 19:30|   835| p0.08-21231.1930
##FD   RSS22_Info.sh            |  61468|  5/20/23 17:16|   910| p0.09`30520.1716
##FD   RSS22_Info.sh            |  71514|  5/21/23 09:50|  1014| p0.09`30521.0950
##FD   RSS22_Info.sh            |  81273|  5/23/23 14:42|  1186| p0.09`30523.1442
##DESC     .--------------------+-------+-------------------+------+------------+
#
#
##LIC      .--------------------+----------------------------------------------+
#            Copyright (c) 2018 SicommNet-JPT * Released under
#            MIT License: http://www.opensource.org/licenses/mit-license.php
##FNCS     .--------------------+-------+-------------------+------+-----------+
#
##CHGS     .--------------------+-------+-------------------+------+-----------+
# .(80923.01  9/23/18 RAM  3:26p| Create it
# .(80926.06  9/26/10 RAM 10:52p| Fix backslashes
# .(80929.01  9/29/10 RAM  8:19p| Add 2 spaces to: info path
# .(81014.02 10/14/10 RAM  9:30a| Modify Version cmd
# .(81014.03 10/14/10 RAM 10:15a| Show Help if bCmdRan == 0
# .(81014.04 10/14/10 RAM 11:00a| Add newCmd template
# .(21112.01 11/12/22 RAM 12:00p| Modify RSS Version
# .(21112.03 11/12/22 RAM  4:04p| Add RSS Info Var Set
# .(21112.06 11/12/22 RAM  6:28p| Put quotes around value if necessary
# .(21113.04 11/13/22 RAM  5:25p| SETX didn't work again
# .(21114.01 11/14/22 RAM  5:55a| Make Path Show smarter
# .(21114.02 11/14/22 RAM  2:00p| Add -doit to Path Clean and Add
# .(21114.04 11/14/22 RAM  6:30a| Add Path clean
# .(21114.05 11/14/22 RAM  7:55a| Add Path add
# .(21120.06 11/20/22 RAM  1:40p| Add cvt to AwkPgm to deal with Windows' paths
# .(21121.01 11/21/22 RAM  4:30p| Fix searching for a path in windows
# .(21121.03 11/21/22 RAM  4:00p| Allow for .bashrc or .profile
# .(21122.01 11/22/22 RAM  9:00a| Add Parse args
# .(21124.01 11/24/22 RAM  2:00p| Get $PATH with REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" -v PATH
# .(21124.02 11/24/22 RAM  2:00p| Check if PATH length > 2047
# .(21125.01 11/25/22 RAM  2:00p| Update path with REG ADD "...
# .(21125.02 11/25/22 RAM  2:00p| Don't cvt2winPath slashes in OS = windows
# .(21125.03 11/25/22 RAM  7:00p| IGNORECASE when searching info show path
# .(21125.04 11/25/22 RAM  7:35p| Add Command comment seperators
# .(21125.06 11/25/22 RAM  8:15p| Add -sys, -user and -bash options to Path show
# .(21126.02 11/26/22 RAM 12:00p| Handle slashes when searching info show path
# .(21126.03 11/26/22 RAM  1:00p| Display None found when searching info show path
# .(21126.04 11/26/22 RAM  2:00p| Add Show OS command
# .(21126.06 11/26/22 RAM  5:30p| Fix extracted path from .bashrc
# .(21126.08 11/26/22 RAM  6:11p| Add -user option to 'frt set path'
# .(21126.09 11/26/22 RAM  7:20p| Modify System/Shell names for PATH
# .(21127.07 11/27/22 RAM  7:40p| Surpress Info Path Add msg if FRT setPath
# .(21121.03 11/30/22 RAM  9:45a| Select .profile over .bashrc
# .(21201.03 12/01/22 RAM  9:25a| Run source ~/${bashrc} to set PATH
# .(21121.03 12/03/22 RAM  3:10p| Use another method to select .profile over .bashrc
# .(21121.03 12/03/22 RAM  6:50p| Reverse method to select .profile over .bashrc
# .(21114.02 12/31/22 RAM  7:00p| Clean up if [ ]; then ; else ; fi
# .(21231.04 12/31/22 RAM  7:30p| Escape parens in THE_SERVER
# .(30520.01  5/20/23 RAM  4:16p| Add Show Server
# .(30520.02  5/20/23 RAM  5:16p| Add Set Profile
# .(30521.01  5/21/23 RAM  9:50a| Add User
# .(30521.03  5/21/23 RAM  9:50a| Add User
# .(30522.01  5/22/23 RAM  8:25a| Check that path -sys or -user only works in windows
# .(30522.02  5/23/23 RAM  2:42p| Add -debug and -debuG
# .(30611.01  6/11/23 RAM 11:00a| Fix info vars

##PRGM     +====================+===============================================+
##ID 69.600. Main               |
##SRCE     +====================+===============================================+
#*/
          aVdt="May 21, 2023  10:15p"; aVtitle="OS Info Tools"
          aVer="$( echo $0 | awk '{ match( $0, /_[dpstuv][0-9]+\.[0-9]+/ ); print substr( $0, RSTART+1, RLENGTH-1) }' )"  # .(21111.04.1)

          LIB=RSS; LIB_LOG=${LIB}_LOG; LIB_USER=${LIB}_USER

  function  logIt() {
            aFncLine="$1[$2]             "; aFncLine="${aFncLine:0:17} $3";
#           aFncLine="${aFncLine/ \//\/}";  aFncLine="${aFncLine/ C:/C:}";  aFncLine="${aFncLine/ D:/D:}";  aFncLine="${aFncLine/ M:/M:}";
   if [ -f "$LIB_LOG" ]; then echo "$( date '+%Y%m%d-%H%M%S%z')  ${SCN_SERVER:0:11} ${LIB_USER:0:8}  ${aFncLine}" >>"$LIB_LOG"; fi
         }
            bDefined=$( type -t sayMsg ); if [ "${bDefined}" != "function" ]; then          # .(30522.03.1 RAM Add sayMsg)
  function  sayMsg() { if [ "${bDebug}" == "1" ] || [ "$2" == "3" ]; then if [ "$2" -ge "1" ]; then echo "$1"; fi; if [ "$2" == "2" ]; then exit; fi fi }
            fi
#   +===== +================== +=========================================================== # ==========+

#           bDebug=1                                                                        # .(30522.02.1)
     if [ "$1" == "test"     ]; then bTest=1; shift; else bTest=0; fi

            mARGs1=( "$@" ); mArgs2=(); j=0                                                 # .(21122.01.1 RAM Beg Added Parse Args)

#          +------------------ +-----------------------------------------------------------

            for (( i = 0; i < ${#mARGs1[@]}; i++ )); do

              aArg="$( echo "${mARGs1[i]}" | tr '[:upper:]' '[:lower:]' )"

              case "${aArg}" in
              -do*) bDoit=1;  ;;
              -de*) bDebug=1; aDebug=${mARGs1[j]}; mARGs1[j]="";                            # .(30522.02.2 RAM Add Debug)
                      if [ "${aDebug}" == "-debuG" ]; then bExit=1; fi ;;                   # .(30522.02.3 RAM Add DebuG to set bExit)
#                  *) j=$(( j + 1 ));  mArgs2[j]="${mArgs1[i]}"; ;;
                   *) j=$(( j + 1 ));  mArgs2[j]="${aArg}"; ;;                              #
                 esac                                                                       # .(21122.01.1 RAM End)
#           echo "  * aArg: '${aArg}', mArgs2[$j]: '${mArgs2[j]}', mARGs1[$((j-0))]: '${mARGs1[$((j-0))]}'"
            done

#          +------------------ +-----------------------------------------------------------

            aCmd1="${mArgs2[1]}"                                                            # .(21122.01.2)
            aCmd2="${mArgs2[2]}"; aARG0="${mARGs1[1]}"                                      # .(21122.01.3)
            aArg1="${mArgs2[3]}"; aARG1="${mARGs1[2]}"                                      # .(21122.01.4).(30521.03.1 RAM Fix Case)
            aArg2="${mArgs2[4]}"; aARG2="${mARGs1[3]}"                                      # .(21122.01.5).(30521.03.2)
            aArg3="${mArgs2[5]}"; aARG3="${mARGs1[4]}"                                      # .(21122.01.5).(30521.03.3 RAM Add aAgr)
            aArg4="${mArgs2[6]}"; aARG4="${mARGs1[5]}"                                      # .(21122.01.5).(30521.03.4 RAM Fix Case)
            bCmdRan=0

            echo ""

#   +----- +------------------ +----------------------------------------------------------- # ----------+

#           echo " 0. aCmd: $aCmd1.$aCmd2 ['${aArg1}','${aArg2}','${aArg3}','${aArg4}']; bDoit: '${bDoit}', bDebug: '${bDebug}', bExit: '${bExit}'"

     if [ "$aCmd1" == ""        ]; then aCmd1=help; fi
     if [ "$aCmd2" == ""        ]; then aCmd2=show; fi
#           echo " ** aCmd: $aCmd1.$aCmd2 ['${aArg1}','${aArg2}','${aArg3}','${aArg4}']; ['$aARG1','${aARG2}','${aARG3}','${aARG4}']"; # exit
#           echo " 1. aCmd: $aCmd1.$aCmd2 ['${aArg1}','${aArg2}','${aArg3}','${aArg4}']; ['${mARGs1[1]}','${mARGs1[2]}','${mARGs1[3]}','${mARGs1[4]}','${mARGs1[5]}'], b=${b}, aARG='${aARG}'"; # exit

#   +----- +------------------ +----------------------------------------------------------- # ----------+

      if [ "${aCmd1:0:3}" == "use" ]; then aArg=${aArg1}; aCmd1=user; b=0                                   # .(30521.01.1 Beg RAM Add Profile command)
         if [ "${aCmd2:0:3}" == "sho" ] || [ "${aCmd2:0:3}" == "add" ]; then if [ "${aCmd2}" == "sho" ]; then aCmd2=show; fi
                 aCmd2=${aCmd2}; b=1; else aArg1=${aCmd2}; if [ "${aArg}" != "" ]; then aCmd2=${aArg}; else aCmd2=show; fi; fi;
            if [ "${b}" == "0" ]; then aCmd2=show; aArg1="${mArgs2[2]}"; aARG1="${aARG0}";  fi
            else
      if [ "${aCmd2:0:3}" == "use" ]; then aCmd=${aCmd1}; aCmd1=user;
         if [ "${aCmd:0:3}"  == "sho" ] || [ "${aCmd:0:3}"  == "add" ]; then if [ "${aCmd2}" == "sho" ]; then aCmd2=show; fi
                 aCmd2=${aCmd}; else  if [ "${aCmd}" != "" ]; then aCmd2=${aCmd}; else aCmd2=show; fi; fi;
            fi; fi                                                                                          # .(30521.01.1 End)

#   +----- +------------------ +----------------------------------------------------------- # ----------+

      if [ "${aCmd1:0:3}" == "pro" ]; then aArg=${aArg1}; aCmd1=profile; b=0;                               # .(30520.02.1 Beg RAM Add Profile command)
         if [ "${aCmd2:0:3}" == "sho" ] || [ "${aCmd2:0:3}" == "edi" ] || [ "${aCmd2:0:3}" == "sav" ]; then
                 if [ "${aCmd2}" == "sho" ]; then aCmd2=show; fi; if [ "${aCmd2}" == "edi" ]; then aCmd2=edit; fi; if [ "${aCmd2}" == "sav" ]; then aCmd2=save; fi
                 aCmd2=${aCmd2}; b=1; else aArg1=${aCmd2}; if [ "${aArg}" != "" ]; then aCmd2=${aArg}; else aCmd2=show; fi; fi;
#           if [ "${b}" == "0" ]; then aCmd2=show; aArg1="${mArgs2[2]}"; aARG1="${mARGs1[1]}"; aArg2="${mArgs2[3]}"; aARG2="${mARGs1[2]}"; aArg3="${mArgs2[4]}"; aARG3="${mARGs1[4]}"; aArg4="${mArgs2[5]}"; aARG4="${mARGs1[4]}"; fi
#           if [ "${b}" == "0" ]; then aCmd2=show; aArg1="${mArgs2[2]}"; aARG1="${aARG0}";     aArg2="${aArg3}";     aARG2="${aARG1}";     aArg3="${aArg4}";     aARG3="${aARG2}";     aArg4="${aArg5}";     aARG4="${aARG3}";     fi
#           if [ "${b}" == "0" ]; then aCmd2=show; aArg4="${aArg3}";     aArg3="${aArg2}";     aArg2="${mArgs2[3]}"; aArg1="${mArgs2[2]}"; aARG4="${mArgs2[5]}"; aARG3="${mArgs2[4]}"; aARG2="${mArgs2[3]}"; aARG1="${mArgs2[2]}"; fi
            if [ "${b}" == "0" ]; then aCmd2=show; aArg4="${aArg3}";     aArg3="${aArg2}";     aArg2="${mArgs2[3]}"; aArg1="${mArgs2[2]}"; aARG4="${aARG3}";     aARG3="${aARG2}";     aARG2="${aARG1}";     aARG1="${aARG0}";     fi
#           echo " ** aCmd: $aCmd1.$aCmd2 ['${aArg1}','${aArg2}','${aArg3}','${aArg4}']; ['$aARG1','${aARG2}','${aARG3}','${aARG4}'], b=${b}"; # exit

            else
      if [ "${aCmd2:0:3}" == "pro" ]; then aCmd=${aCmd1}; aCmd1=profile;
         if [ "${aCmd:0:3}"  == "sho" ] || [ "${aCmd:0:3}"  == "edi" ] || [ "${aCmd:0:3}"  == "sav" ]; then
                 if [ "${aCmd}"  == "sho" ]; then aCmd=show; fi;   if [ "${aCmd}" == "edi" ]; then aCmd=edit; fi
                 aCmd2=${aCmd}; else  if [ "${aCmd}" != "" ]; then aCmd2=${aCmd}; else aCmd2=show; fi; fi;
            fi; fi                                                                                          # .(305202.02.1 End)

#    if [ "${aCmd1:0:3}" == "pro" ]; then aCmd1=profile;  aCmd2="$aCmd2"; fi                                # .(30520.02.1 RAM Add Save Profile)
#    if [ "${aCmd2:0:3}" == "pro" ]; then aCmd1=profile;  aCmd2="$aCmd1"; fi                                # .(30520.02.2)
#    if [ "${aArg1:0:3}" == "pro" ]; then aCmd1=profile;  aCmd2="save";   fi                                # .(30520.02.3)

                                                          b=0; aCmd=${aCmd2};
#           echo " 2. aCmd: $aCmd1.$aCmd2 ['${aArg1}','${aArg2}','${aArg3}','${aArg4}']; ['$aARG1','${aARG2}','${aARG3}','${aARG4}'], aCmd: '${aCmd}'; b=${b}"; # exit

#   +----- +------------------ +----------------------------------------------------------- # ----------+

     if [ "${aArg1:0:3}" == "ser" ]; then aArg2=${aArg2}; b=1; if [ "${aCmd2:0:3}" == "sho" ]; then aCmd=show; fi; fi # aCmd1=vars; aCmd2="show";     b=1; fi # .(30520.01.3)
     if [ "${aCmd2:0:3}" == "ser" ]; then aArg2=${aArg1}; b=1; if [ "${aCmd1:0:3}" == "sho" ]; then aCmd=show; fi; fi # aCmd1=vars; aCmd2="show";     b=1; fi # .(30520.01.2)
     if [ "${aCmd1:0:3}" == "ser" ]; then                 b=1; if [ "${aCmd2:0:3}" == "sho" ]; then aCmd=show; fi; fi # || [ "${aCmd2:0:3}" == "mak" ]; then aArg2=""; else aArg2=${aCmd2}; aCmd2="make"; fi;
                                                                                                                      # aCmd1=vars; aCmd2="${aCmd2}"; b=1; fi # .(30520.01.1 RAM Add Show|Set server)
#          +------------------ +-----------------------------------------------------------

        if [ "${b}" == "1"    ]; then aCmd1=vars;     aArg1=server; aArg2=""; aArg3=""; aArg3=""; aArg4="";

#           echo  " 3. aCmd: $aCmd1.$aCmd2 ['${aArg1}','${aArg2}','${aArg3}','${aArg4}']; ['$aARG1','${aARG2}','${aARG3}','${aARG4}'], aCmd: '${aCmd}'; b=${b}"; # exit

     if [ "${aCmd:0:3}"  == "sho" ]; then aCmd2="show"; fi; # aARG="$( echo "${aARG1}" | tr '[:upper:]' '[:lower:]' )"
     if [ "${aCmd:0:3}"  == "mak" ]; then aCmd2="make"; fi;                            bKeep=0
     if [ "${aCmd:0:3}"  != "mak" ] && [ "${aCmd:0:3}"  != "sho" ]; then aCmd2="make"; bKeep=1; fi;
     if [ "${aCmd:0:3}"  == "ser" ]; then aCmd2="make";                                bKeep=2; fi;

     if [ "${bKeep}"     == "2"   ]; then aARG4="${mARGs1[5]}"; aARG3="${mARGs1[4]}"; aARG2="${mARGs1[3]}"; aARG1="${mARGs1[2]}"; fi
     if [ "${bKeep}"     == "1"   ]; then aARG4="${mARGs1[4]}"; aARG3="${mARGs1[3]}"; aARG2="${mARGs1[2]}"; aARG1="${mARGs1[1]}"; fi

#           echo  " 4. aCmd: $aCmd1.$aCmd2 ['${aArg1}','${aArg2}','${aArg3}','${aArg4}']; ['$aARG1','${aARG2}','${aARG3}','${aARG4}'], b=${b}, aARG='${aARG}'"; # exit

#    if [ "${mArgs2[2]:0:3}" != "sho" ]; then  aARG4="${aARG3}"; aARG3="${aARG2}"; aARG2="${aARG1}"; aARG1="${aARG0}"; fi
#    if [ "${mArgs2[2]:0:3}" == "ser" ]; then  aARG4="${aARG3}"; aARG3="${aARG2}"; aARG2="${aARG1}"; aARG1="${aARG0}"; fi
#    if [ "${mArgs2[2]:0:3}" == "sho" ]; then  aARG4="${aARG4}"; aARG3="${aARG3}"; aARG2="${aARG2}"; aARG1="${aARG1}"; fi
#    if [ "${aARG:0:3}"      == "ser" ]; then  aARG4=""; aARG3=""; aARG2=""; aARG1=""; fi
#    if [ "${aARG:0:3}"      == "ser" ]; then  aARG4="${aARG3}"; aARG3="${aARG2}"; aARG2="${aARG1}"; aARG1="${aARG0}"; fi

                                               aARG="$( echo "${aARG1}" | tr '[:upper:]' '[:lower:]' )"
#               if [ "${bKeep}" == "1" ]; then aARG=""; fi

#           echo  " 5. aCmd: $aCmd1.$aCmd2 ['${aArg1}','${aArg2}','${aArg3}','${aArg4}']; ['$aARG1','${aARG2}','${aARG3}','${aARG4}'], b=${b}, aARG='${aARG}'"; # exit
#           echo  " 5. aCmd: $aCmd1.$aCmd2 ['${aArg1}','${aArg2}','${aArg3}','${aArg4}']; ['${mARGs1[1]}','${mARGs1[2]}','${mARGs1[3]}','${mARGs1[4]}','${mARGs1[5]}'], b=${b}, aARG='${aARG}'"; # exit

     if [ "${aARG:0:3}"      == "sho" ]; then  aCmd2=show; fi
     if [ "${aARG:0:3}"      == "ser" ] || [ "${aARG:0:3}"  == "sho" ] || [ "${aARG:0:3}" == "mak" ]; then #  || [ "${aARG:0:3}" == "var" ] && [ "1" == "2" ]; then
                                               aARG4="${mARGs1[6]}"; aARG3="${mARGs1[5]}"; aARG2="${mARGs1[4]}"; aARG1="${mARGs1[3]}";
#                                              aARG4="${mARGs1[5]}"; aARG3="${mARGs1[4]}"; aARG2="${mARGs1[3]}"; aARG1="${mARGs1[2]}";
#                                              aARG4="${mARGs1[4]}"; aARG3="${mARGs1[3]}"; aARG2="${mARGs1[2]}"; aARG1="${mARGs1[1]}";
#                                              aARG4="${mARGs1[3]}"; aARG3="${mARGs1[2]}"; aARG2="${mARGs1[1]}"; aARG1="${mARGs1[0]}";
           fi # eif aARG in (ser, sho, mak)
           fi # eif b=1

#          +------------------ +-----------------------------------------------------------

#           echo  " 6. aCmd: $aCmd1.$aCmd2 ['${aArg1}','${aArg2}','${aArg3}','${aArg4}']; ['$aARG1','${aARG2}','${aARG3}','${aARG4}'], b=${b}, aARG='${aARG}'"; # exit
#           echo  " 7. aCmd: $aCmd1.$aCmd2 ['${aArg1}','${aArg2}','${aArg3}','${aArg4}']; ['${mARGs1[1]}','${mARGs1[2]}','${mARGs1[3]}','${mARGs1[4]}','${mARGs1[5]}'], b=${b}, aARG='${aARG}'"; # exit

#   +----- +------------------ +----------------------------------------------------------- # ----------+

#    if [ "${aCmd2:0:3}" == "sho"    ]; then aCmd2=show; if [ "${aCmd1:0:3}" != "pro" ]; then aARG1="${aArg1}"; else aARG1="${mARGs1[1]}"; fi; fi   ##.(30521.03.5 RAM
#    if [ "${aCmd2:0:3}" == "sav"    ]; then aCmd2=save; if [ "${aCmd1:0:3}" != "pro" ]; then aARG1="${aArg1}"; else aARG1="${mARGs1[1]}"; fi; fi   ##.(30521.03.6 RAM

     if [ "${aCmd2:0:3}" == "sho"    ]; then aCmd2=show; fi; # aARG1="${aArg1}"; fi                                                                 # .(30521.03.5 RAM
     if [ "${aCmd2:0:3}" == "sav"    ]; then aCmd2=save; fi; # aARG1="${aArg1}"; fi                                                                 # .(30521.03.6 RAM
     if [ "${aArg2:0:2}" == "os"     ]; then aArg1=os;       aArg2=""; fi                                                                           # .(30521.03.7 RAM

     if [ "${aCmd1:0:3}" == "sho"    ]; then aCmd1=vars
        if [ "${aCmd2:0:3}" == "pat" ]; then aCmd1=path; fi
        if [ "${aCmd2:0:3}" == "var" ]; then aCmd1=vars; fi
        if [ "${aCmd2:0:3}" == "log" ]; then aCmd1=log;  fi; aCmd2=show
        fi # eof show

#   +----- +------------------ +----------------------------------------------------------- # ----------+

            aLstSp="echo "; if [ "${OSTYPE}" == "msys" ]; then aLstSp=""; fi                                # .(10706.09.1 RAM Windows returns an extra blank line).(21113.06.1 RAM Reverse).(21120.02.9).(30521.01.2 RAM reset)
#           echo  "  - RSS01[ 66]  aOSv: ${aOSv}, ${OSTYPE}, aLstSp: '${aLstSp}'"; ${aLstSp}; exit

      if [ "${bDebug}" == "1" ]; then                                                                       # .(30522.02.4)
#           echo  "*** aCmd: $aCmd1.$aCmd2  '${aArg1}', '${aArg2}', bCmdRan: ${aCmdRan}"; ${aLstSp}; exit
            echo  " 8. aCmd: $aCmd1.$aCmd2 ['${aArg1}','${aArg2}','${aArg3}','${aArg4}']; ['$aARG1','${aARG2}','${aARG3}','${aARG4}']";
         if [ "${bExit}" == "1" ]; then ${aLstSp}; exit; else echo ""; fi                                   # .(30522.02.5)
            fi                                                                                              # .(30522.02.6)

#   +----- +------------------ +----------------------------------------------------------- # ----------+

function Help() {                                                                                           #.(81014.03.1 Beg RAM Create function)
            aUser=$( echo "${HOME}" | awk '{ sub( /.*[\\/]/, "" ); print }' )                               # .(30520.01.4)
#           echo "  $LIB Info Commands              $( echo $0 | awk '{ gsub( /.+_[ptuv]|.sh/, ""); print }' )"
            echo "  Usefull RSS Info Tools   (${aVer})            (${aVdt})"                                # .(21111.04.2)
            echo "  ------------------------------------------  ---------------------------------"
            echo "    RSS Info Path [Show] [-sys|-user|-bash]   Show PATH for Environment"
#           echo "    RSS Info Path Clean  [-sys|-user] [-doit] Remove Duplicate Paths from [System] PATH"
#           echo "    RSS Info Path Add  {Path} [-user] [-doit] Add {Path} to [System] PATH"
#           echo "    RSS Info Vars Set  {Name} {Value}         Set [System] Environment Variable"
            echo "    RSS Info Vars Show {Search}               Show Environment Variables (Use ! for non-leading search string)"
            echo "    RSS Info Vars Show  OS                    Show Current OS Variables"                              # .(21126.04.1 RAM)
            echo "    RSS Info Vars Server {Parms}              Show Server Name"                                       # .(30520.01.5)
            echo "    RSS Info Profile [edit|show] [user]       Edit or Show ~\.bash_profile for user: ${aUser}"        # .(30520.02.1)
            echo "    RSS Info Profile [save] [user] [-doit]    Save ~\.bash_profile for user: ${aUser}"                # .(30520.02.2)
            echo "    RSS Info User [add] [user]                Add user. Current user is: ${aUser}"                    # .(30520.03.1)
#           echo "    RSS Info Top                              Show Top Running Programs (Unix only)"
#           echo "    RSS Info Log Show                         Show $LIB Log"
#           echo "    RSS Info Log Set {LogFile} {User}         Set $LIB log"
#           echo "    RSS Info Log On                           Turn $LIB log on"
#           echo "    RSS Info Log Off                          Turn $LIB log off"
            ${aLstSp}
            exit
            }
     if [ "$aCmd1" == "help" ]; then Help; fi                                               #.(81014.03.1 End)

#   +----- +------------------ +----------------------------------------------------------- # ----------+

#====== =================================================================================================== #  ===========

# ------------------------------------------------------------------------------------
#
#       Log Commands
#
#====== =================================================================================================== #

     if [  "$aCmd1" == "log" ]; then     # if  aCmd1 == log

     if [  "$aCmd2" == "set" ] || [ "$aCmd2" == "on"  ]; then # if  aCmd2 == log set
#    if [[ "$aCmd2" == "set"   ||   "$aCmd2" == "on" ]]; then
#    if [  "$aCmd2" == "set" ]; then

                aTS=$( date '+%Y%m%d'); aTS=${aTS:3}
                export RSS_USER="${USERNAME%%.*}          "  # First name; Delete after and including ."

#               LIB_LOG="/C/Home/SCN2/_/LOGs/${LIB}s/"
            if [ "${SCN_SERVER:7:1}" == "w" ];then           # sc163d-w08s_Sherman3 (192.168.109.8)
#               LIB_LOG="/C/Home/SCN2/_/LOGs/${LIB}s/"
                LIB_LOG="C:\\Home\\SCN2\\_\\LOGs\\RSSs\\"

                if [ ! -d "/C/Home/SCN2"                ]; then mkdir "/C/Home/SCN2"; fi
                if [ ! -d "/C/Home/SCN2/_"              ]; then mkdir "/C/Home/SCN2/_"; fi
                if [ ! -d "/C/Home/SCN2/_/LOGs"         ]; then mkdir "/C/Home/SCN2/_/LOGs"; fi
                if [ ! -d "/C/Home/SCN2/_/LOGs/${LIB}s" ]; then mkdir "/C/Home/SCN2/_/LOGs/${LIB}s"; fi

              else
                LIB_LOG="/home/SCN2/_/LOGs/${LIB}s/"

                if [ ! -d "/home/SCN2"                  ]; then mkdir "/home/SCN2"; fi
                if [ ! -d "/home/SCN2/_"                ]; then mkdir "/home/SCN2/_"; fi
                if [ ! -d "/home/SCN2/_/LOGs"           ]; then mkdir "/home/SCN2/_/LOGs"; fi
                if [ ! -d "/home/SCN2/_/LOGs/${LIB}s"   ]; then mkdir "/home/SCN2/_/LOGs/${LIB}s"; fi
                fi
#               fi

                RSS_LOG="${LIB_LOG}${LIB}-Log_v${aTS}.log"

#           if [ ! -f "$RSS_LOG" ]; then
                echo "" >"$RSS_LOG";
                echo "$( date '+%Y%m%d-%H%M%S%z')  ${SCN_SERVER:0:11} ${JPT_USER:0:8}  RSS-setLog[1]     Created Log file: ${RSS_LOG}" >>"${RSS_LOG}"
                echo "  Created Log file: ${RSS_LOG}"
                echo ""
#               fi

                aCmd2="on"
                ${aLstSp}; bCmdRan="1"                                                      #.(81014.03.2)
            fi                          # eif aCmd2 == log set
#    +---- +------------------ +----------------------------------------------------------- # --------+

#====== =================================================================================================== #

# ------------------------------------------------------------------------------------
#
#       Log On Command
#
#====== =================================================================================================== #

     if [ "$aCmd2" == "on" ]; then      # if  aCmd2 == log on

            if [ "${SCN_SERVER:7:1}" == "w" ];then  # sc163d-w08s_Sherman3 (192.168.109.8)
                echo "  setx RSS_USER \"${RSS_USER}   \""
                echo "  set  RSS_USER=\"${RSS_USER}   \""
                echo "  setx RSS_LOG \"$( echo "${RSS_LOG}" | tr "\\\\", "/" )\""                       # .(80926.06.1 RAM My goodness)
                echo "  set  RSS_LOG=\"$( echo "${RSS_LOG}" | tr "\\\\", "/" )\""                       # .(80926.06.2)
              else
                echo "  export RSS_USER=\"${RSS_USER}\""
                echo "  export RSS_LOG=\"${RSS_LOG}\""
                fi

                echo "" >>"${RSS_LOG}"
                echo "$( date '+%Y%m%d-%H%M%S%z')  ${SCN_SERVER:0:11} ${RSS_USER:0:8}  RSS-setLog[2]     Start Logging" >>"${RSS_LOG}"
                ${aLstSp}; bCmdRan="1"                                                      #.(81014.03.3)
            fi                          # eif aCmd2 == log on
#    +---- +------------------ +----------------------------------------------------------- # --------+

#====== =================================================================================================== #

# ------------------------------------------------------------------------------------
#
#       Log Off Command
#
#====== =================================================================================================== #

     if [ "$aCmd2" == "off" ]; then     # if  aCmd2 == log off

       if [ ! -f "$RSS_LOG" ]; then
            echo "* Logfile does not exist"
         else
                echo "" >>"${RSS_LOG}"
                echo "$( date '+%Y%m%d-%H%M%S%z')  ${SCN_SERVER:0:11} ${RSS_USER:0:8}  RSS-setLog[3]     Stop Logging"  >>"${RSS_LOG}"

            if [ "${SCN_SERVER:7:1}" == "w" ];then
                echo "  setx ${LIB}_USER "
                echo "  set  ${LIB}_USER="
              else
                echo "  export ${LIB}_LOG="
                fi
            fi
                ${aLstSp}; bCmdRan="1"                                                      #.(81014.03.6)
            fi                          # eif aCmd2 == log off
#    +---- +------------------ +----------------------------------------------------------- # --------+

#====== =================================================================================================== #

# ------------------------------------------------------------------------------------
#
#       Show Log Command
#
#====== =================================================================================================== #

     if [ "$aCmd2" == "show" ]; then    # if  aCmd2 == log show

       if [ ! -f "$RSS_LOG" ]; then
            echo "* Logfile does not exist"
         else
            echo "  Showing RSS log file: \"$( echo "${RSS_LOG}" | tr "\\\\", "/" )\""; echo ""             # .(80926.06.3 If it contains backslashes)
            tail -n 20 "${RSS_LOG}"
            fi
            ${aLstSp}; bCmdRan="1"                                                                          #.(81014.03.7)
            fi                          # eif aCmd2 == log show
#    +---- +------------------ +----------------------------------------------------------- # --------+
        fi                              # eif aCmd1 == log
#   +----- +------------------ +----------------------------------------------------------- # ----------+

#====== =================================================================================================== #  ===========

# ------------------------------------------------------------------------------------
#
#       Path Commands
#
#====== =================================================================================================== #

           sayMsg "RSS[ 406]  aCmd: ${aCmd1}.${aCmd2}, aArg1: ${aArg1}" 1; # ${aLstSp}; exit

     if [ "$aCmd1" == "path" ]; then    # if  aCmd1 == path

function cvt2winPath() { nLen=110                                                                           # .(21131.06.1 RAM Beg)
      if [ "$2" != "w" ];  then aNewPath="$1"; else
         aNewPath="$1" #="$( echo "$1"   | awk '{ sub( /\/n/, "{n}" ); print }' )"
         aNewPath="$( echo "${aNewPath}" | awk '{ gsub( /:/, ";"); gsub( /\/[cC]/, "C:" ); gsub( /\//, "\\" ); print }' )"
#        aNewPath="$( echo "${aNewPath}" | awk '{ sub( /{n}/, "\\n" ); print }' )"
         fi
      if [ "$3" == "1" ]; then echo "${aNewPath}"; return; fi
         echo "${aNewPath}" | awk '{ n = length($0);  print n < '${nLen}' ? $0 : substr( $0, 1, '${nLen}' ) "..." }'  # Find 1st 80 chars in $PATH
         }                                                                                                  # .(21131.06.1 RAM End)
#    +---- +------------------ +-----------------------------------------------------------

aAwkPgm1='
function cvt( a ) {  # print "--- a: '" a "', d: '" d "'";
          if (d == ";") { sub( /\/[cC]/, "C:", a ); gsub( /\//, "\\", a ) };
       return a                                                                                             # .(21120.06.1 RAM cvt path character)
         }
BEGIN  { d = ARGV[1]; aPath = d; bShow=ARGV[2] != "new"; ARGC=1; IGNORECASE=1; m=0 }                        # .(21114.01.1 RAM Beg Write Awk program to mark dups).(21125.03.1 RAM Added IGNORECASE).(21126.03.1)
#      { print index( aPath, d $0 d ) " " aPath }
       { n = index( aPath, d $0 d ); } # printf "%3d %s %5d\n", NR, n "   " cvt( $0 ), length( aPath) }
       { if (n > 0) { if (bShow) { printf "%3d %s\n", NR, " x " cvt( $0 ) } }                               # .(21120.06.2)
               else { if (bShow) { printf "%3d %s\n", NR, "   " cvt( $0 ) }; aPath = aPath d $0; m++ }      # .(21120.06.3).(21126.03.2)
#                                                                            aPath = aPath d $0             # .(21120.06.3)
          }
END    { if (bShow != 1) { print aPath }
           else { if (m == 0) { print "     * None found" } }                                               # .(21126.03.3 RAM Print "None found")
         }                                                                                                  # .(21114.01.1 RAM End)
'
#    +---- +------------------ +-----------------------------------------------------------

           aDelim=":"; if [ "${aOSv:0:1}" == "w" ]; then aDelim=";"; fi;                                    # .(21120.06.4)

     if [ "$aCmd2" != "show"  ] && [ "$aCmd2" != "clean"  ] && [ "$aCmd2" != "add"  ]; then                 # .(21120.04.1 RAM)
           aArg1="$aCmd2"; aCmd2="show"; aArg2="$3"; fi                                                     # .(21120.04.2).(21125.06.4 RAM Add aArg2)

#    +---- +------------------ +----------------------------------------------------------- # --------+

#          a="$( cmd /c "echo %PATH%" )"                                                                    # .(21120.06.5 RAM How to get Windows Path)
#          echo "-- aCmd2: $aCmd2, aArg1: $aArg1, PATH: ${PATH};"; exit
     if [ "$aCmd2" == "show"  ]; then
                                               aShell=${aArg2};                                             # .(21125.06.1 RAM Beg Show different paths)
           if [ "${aArg1:0:1}"  == "-" ]; then aShell=${aArg1}; aArg1="${aArg2}"; fi
           if [ "${aShell:0:1}" != "-" ]; then aShell="-bash"; if [ "${aOSv:0:1}" == "w" ]; then aShell="-user"; fi; fi                     # .(21125.06.1 RAM End)
#          echo "aArg1: '$aArg1', aShell: '$aShell'"; exit

     if [ "${aShell}" == "-sys"  ]; then                                                                                                    # .(21125.06.2
     if [ "${OSTYPE}" != "msys"  ]; then echo "  -sys only workd in Windows"; $aLstSp; exit; fi                                             # .(30522.01.1 RAM Chk if windows)
           aOldPATH="$( cmd //c REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" -v PATH )";     # .(21125.05.1 RAM Get Windows PATH)
           aOldPATH="$( echo "${aOldPATH}" | awk '/PATH/ { sub( /.+_SZ +/, "" ); print }' )"; aDelim=";"; fi                                # .(21125.05.2)

     if [ "${aShell}" == "-user" ]; then                                                                                                    # .(21125.06.3
     if [ "${OSTYPE}" != "msys"  ]; then echo "  -sys only workd in Windows"; $aLstSp; exit; fi                                             # .(30522.01.1 RAM Chk if windows)
           aOldPATH="$( cmd //c REG QUERY "HKEY_CURRENT_USER\Environment" -v PATH )"                                                        # .(21125.03.1 RAM Get Windows PATH)
           aOldPATH="$( echo "${aOldPATH}" | awk '/PATH/ { sub( /.+_SZ +/, "" ); print }' )"; aDelim=";"; fi                                # .(21125.01.2)
#          aOldPATH="$( echo "${aOldPATH}" | tr '[:upper:]' '[:lower:]' )"; aDelim=";"                                                      ##.(21125.03.2)

     if [ "${aShell}" == "-bash" ]; then                                                                    # .(21125.06.4
           aOldPATH="$PATH"; aDelim=":"
           fi

#          echo -e "\n    aOSv: ${aOSv}; aArg1: '${aArg1}'; PATH Length: ${#aOldPATH}\n----------------------------------------------------------------"
#          echo ${aOldPATH} | tr "${aDelim}" "\n" | awk '{ printf "%3d %s %5d\n", NR, " ? " $0, nLen; nLen = nLen + length($0) }'; echo ""; # exit

#    if [ "$aArg1" == ""      ]; then echo $PATH | tr : "\n" | awk             '{ print "  " $0 }'    ; fi                                  ##.(80929.01.1 Added print).(21114.01.2)
#    if [ "$aArg1" == ""      ]; then echo $PATH       | tr : "\n"                              | awk "${aAwkPgm1}" "${aDelim}"; fi         ##.(21114.01.2 RAM Use AwkPgm).(21120.06.6).(21125.01.3)
     if [ "$aArg1" == ""      ]; then echo ${aOldPATH} | tr "${aDelim}" "\n" | awk 'NF > 0'     | awk "${aAwkPgm1}" "${aDelim}"; fi         # .(21114.01.2 RAM Use AwkPgm).(21120.06.6).(21125.01.3).(21125.01.3 RAM Fuck you NF > 1 S.B NF > 0)
#    if [ "$aArg1" == ""      ]; then echo ${aOldPATH} | tr "${aDelim}" "\n" | awk '{ printf "%3d %s %5d\n", NR, "?   " $0, nLen; nLen = nLen + length($0) }'; fi

     if [ "$aArg1" != ""      ]; then aArg1="$( echo "${aArg1}" | awk '{ gsub( /\\/, "\\\\" ); gsub( /\//, "\\/" ); print }' )"; fi         # echo "aArg1: ${aArg1}";fi # .(21126.02.1 RAM Handle slashes in aArg1)
#    if [ "$aArg1" != ""      ]; then echo $PATH       | tr : "\n"           | awk '/'$aArg1'/  { print "  " $0 }'             ; fi         ##.(80929.01.2 ?? if $aArg1 != "")
#    if [ "$aArg1" != ""      ]; then echo $PATH       | tr : "\n"           | awk '/'$aArg1'/' | awk "${aAwkPgm1}" "${aDelim}"; fi         ##.(80929.01.2 Added print   ).(21114.01.3).(21120.06.7).(21125.01.4)
     if [ "$aArg1" != ""      ]; then echo ${aOldPATH} | tr "${aDelim}" "\n" | awk '/'$aArg1'/' | awk "${aAwkPgm1}" "${aDelim}"; fi         # .(80929.01.2 Added print   ).(21114.01.3).(21120.06.7).(21125.01.4)

            ${aLstSp}; bCmdRan="1"                                                                                                          # .(81014.03.8)
            fi                          # eif aCmd2 == path show
#   +----- +------------------ +----------------------------------------------------------- # ----------+

#====== =================================================================================================== #

# ------------------------------------------------------------------------------------
#
#       Clean Path Command
#
#====== =================================================================================================== #

            sayMsg "RSS[ 493]  aCmd: ${aCmd1}.${aCmd2}, aArg1: ${aArg1}, bCmdRan: ${bCmdRan}" 1;  # ${aLstSp}; exit

     if [ "$aCmd2" == "clean" ]; then                                                       # .(21114.04.1 RAM Beg Add clean)

#           aDoit=""; if [ "$4" == "-doit" ]; then aDoit="-doit"; fi
#           aNewPATH="$( echo $PATH | tr : "\n" | awk  "${aAwkPgm}" "${aDelim}" "new" )"    ##.(21120.06.8).(21124.01.1)
#           aNewPATH="$( cvt2winPath "${aNewPATH:2}" ${aOSv:0:1} 1 )"                       ##.(21124.01.2)

#                        cmd //c REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" -v PATH
            aOldPATH="$( cmd //c REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" -v PATH )"     # .(21124.01.3 RAM Get Windows PATH)

#           aOldPATH="$( echo "${aOldPATH}" | awk '{ sub( /[\s\S ]+REG_SZ /, "" ); print }' )"     # {aOldPATH:105}"                        ##.(21124.01.3)
            aOldPATH="$( echo "${aOldPATH}" | awk '/PATH/ { sub( /.+REG_SZ +/, "" ); print }' )"   # {aOldPATH:105}"                        # .(21124.01.4)

            aNewPATH="$( echo "${aOldPATH}" | awk "${aAwkPgm}" "${aDelim}" "new" )"; aNewPATH="${aNewPATH:2}"                               # .(21124.01.5)

      if [ "${#aNewPATH}" -gt "2047" ]; then                                                # .(21124.02.1 RAM Beg Check if PATH len > 2047)
            echo -e " ** The new PATH can't be greater than 2047 characters. It is now ${#aNewPATH} chars."
            echo    "    You can reset the registry value of HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment\Path."
            echo -e "    and then reboot Windows.\n"
            exit
            fi                                                                              # .(21124.02.1 RAM End)

            nDups=$(( ${#aOldPATH} - ${#aNewPATH} )); # echo "nDups: '${nDups}'"; # exit    # .(21125.01.6 RAM Beg)

      if [ "${nDups}" == "0" ]; then
            echo -e "  * The New PATH will be the same as the Old PATH."
            exit
            fi                                                                              # .(21125.01.6 RAM End)

      if [ "$3" == "-doit" ]; then

#           echo "$0 vars set -doit PATH \"${aNewPATH}\""
#                           "${BASH_SOURCE}      vars set -doit PATH \"${aNewPATH}\""
#                "$( dirname ${BASH_SOURCE} )/$0 vars set -doit PATH \"${aNewPATH}\""
#           echo                             "$0 vars set -doit PATH \"...\""

            echo -e "    About to remove ${nDups} chars from the global System PATH."

      if [ "${aDelim}" == ":" ]; then                                                       # .(21125.01.7)

           "$0" vars set PATH -doit "${aNewPATH}"                                           # .(21124.01.5 RAM Let's see if this works)

            if [ "$?" == "1" ]; then exit; fi                                               # .(21124.01.6 RAM Exit if it doesn't)
          else                                                                              # .(21125.01.8)
            cmd //c REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" -v PATH -d "${aNewPath}" # .(21125.01.9)

            fi  # eif "${aDelim}" == ":"                                                    # .(21125.01.10)

            echo -e "    The new PATH has been reset (${#aNewPATH} chars).\n"
         else
            echo -e "    The Old PATH will have (${nDups}) chars removed from the new PATH (${#aNewPATH} chars)\n"; echo "${aNewPATH}"

            fi # eif -doit or not
#           fi

            ${aLstSp}; bCmdRan="1"                                                          # .(81014.03.8)
            fi #  eoc aCmd2 == path clean ??                                                # .(21114.04.1 RAM End ??)

        fi  #  eoc ???                                                                      # .(30522.03.x RAM End of what?? )
#    +---- +------------------ +----------------------------------------------------------- # --------+

#====== =================================================================================================== #

# ------------------------------------------------------------------------------------
#
#       Add Path Command
#
#====== =================================================================================================== #

            sayMsg "RSS[ 563]  aCmd: ${aCmd1}.${aCmd2}, aArg1: ${aArg1}, bCmdRan: ${bCmdRan}" 1; # ${aLstSp}; exit

     if [ "$aCmd2" == "add_xx" ]; then                                                      # .(21114.05.1 RAM Beg Add Path Add)

#           aDoit=""; if [ "$4" == "-doit" ]; then aDoit="-doit"; fi
#           aNewPath=$( echo "$4;$PATH" | tr : "\n" | awk  "${aAwkPgm}" ";" "new" )
                                         bDoit=0;     aPath="$3"
            if [ "$3" == "-doit" ]; then bDoit=1;     aPath="$4"; fi
            if [ "$4" == "-doit" ]; then bDoit=1; fi; aPath="$( echo "${aPath}" | awk '{ gsub(/^ +| +$/, "" ); print }' )"
                                          aShell="-sys"                                     # .(21126.08.5)
            if [ "$4"  == "-user" ]; then aShell="-user"; fi                                # .(21126.08.6)
            if [ "$4"  == "-bash" ]; then aShell="-bash"; fi                                # .(21126.08.7)
            if [ "$5"  == "-user" ]; then aShell="-user"; fi                                # .(21126.08.14)
            if [ "$5"  == "-bash" ]; then aShell="-bash"; fi                                # .(21126.08.15)

#           -----------------------------------------------------------

      if [ "${aOSv:0:1}" == "w" ]; then                 aOSname="Windows System"
#           aWinPath="$( echo "${aPath}" | awk '{ sub( /\/[cC]/, "C:" ); gsub( /\//, "\\" ); print }' )"  # .(21121.01.1 RAM aPath for Windows
#           echo "aPath: '/${aPath//\//\\\/}/'"; # exit
#           aOldPath="$( echo "${PATH}" | tr : "\n" | awk /${aPath//\//\\\/}/ | awk 'NR == 1' )"  # Find $aPath in $PATH
#           aOldPath="$( echo "${PATH}"     | awk '{ n = length($0); print substr( $0, 1, n < 80 ? n : 80 ) "..." }' )"  # Find 1st 80 chars in $PATH
#           aOldPath="$( echo "${aPath}"    | awk '{ gsub( /:/, ";"); gsub( /\/[cC]/, "C:" ); gsub( /\//, "\\" ); print }' )"
#           aOldPATH="${PATH}"                                                                                                              ##.(21124.01.6)
      if [ "${aShell}" == "-sys" ]; then
            aOldPATH="$( cmd //c REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" -v PATH )"; fi # .(21124.01.6 RAM Get Windows PATH)
      if [ "${aShell}" == "-user" ]; then
            aOldPATH="$( cmd //c REG QUERY "HKEY_CURRENT_USER\Environment" -v PATH )"           # .(21126.08.8)
            fi
#           aOldPATH="$( echo "${aOldPATH}" | awk '/PATH/ { sub( /.+REG_SZ +/, ""); print }' )" # {aOldPATH:105}"                           ##.(21124.01.7).(21126.08.12)
            aOldPATH="$( echo "${aOldPATH}" | awk '/PATH/ { sub( /.+_SZ +/, ""   ); print }' )" # {aOldPATH:105}"                           ##.(21126.08.12)

#    if [ "$aOldPath" != "" ]; then                                                             ##if $PATH exists, it always will in Windows
#           echo "Found: aPath:    ${aPath}"
#           echo "   in: aOldPath: ${aOldPath}"; # exit
#           aNewPath="${aPath}:${aOldPath/${aPath};/}"                                          ##.(21121.01.2 Find aPath in Path and remote it if found)

#           aOldPath="$( echo "${PATH}"     | awk '{ gsub( /:/, ";"); gsub( /\/[cC]/, "C:" ); gsub( /\//, "\\" ); print }' )"
#           aOldPath="$( echo "${aOldPATH}" | awk '{ n = length($0);  print n < '${nLen}' ? $0 : substr( $0, 1, '${nLen}' ) "..." }' )"     ##Find 1st nLen chars in $PATH
#           aOldPath="$( cvt2winPath "${aOldPATH}" ${aOSv:0:1} )"                               ##.(21121.01.1 For display)
# echo "--- aOldPATH: '${aOldPATH}'"
            aOldPath="$( cvt2winPath "${aOldPATH}" "x" )"                                       ##.(21121.01.1 For display).(21125.02.1 RAM It is a Windows path)
# echo "--- aOldPath: '${aOldPath}'"; exit

            echo "    Old PATH: '${aOldPath}'"                                                  # .(21124.01.8 RAM Display 1st nLen chars of aOldPATH ??)
# echo "--- aPath: '${aPath}'";
            aPath="$( cvt2winPath "${aPath}" "w" 1 )"                                           # .(21125.02.2 RAM Convert the GFW path)
# echo "--- aPath: '${aPath}'"; exit
#           echo "    aAwkPgm: '{ sub( /"${aPath//\//\\\/}";/, \"\" ); print }'"; exit          ##Look for Unix path
#           echo "    aAwkPgm: '{ sub( /"${aPath//\\/\\\\}";/, \"\" ); print }'"; exit          ##Look for Windows path

#           aNewPATH="$( echo "${PATH}"     | awk '{ sub( /'${aPath//\//\\\/}':/, "" ); print }' )" ##.(21121.01.2 Find aPath in PATH and remove it if found)
            aNewPATH="$( echo "${aOldPATH}" | awk '{ sub( /'${aPath//\\/\\\\}';/, "" ); print }' )" # .(21121.01.2 Find aPath in PATH and remove it if found).(21125.01.21)
            aNewPATH="${aPath};${aNewPATH}"                                                     # .(21121.01.3 Put  aPath (back) in front of PATH)

#           aNewPath="$( cvt2winPath "${aPath}:${aNewPATH}" ${aOSv:0:1} )"
#           aNewPath="$( cvt2winPath "${aNewPATH}" ${aOSv:0:1} )"                               ##.(21121.01.4 For display).(21125.02.3 RAM It is a Windows path)
#           aNewPath="${aNewPATH}"                                                              ##.(21121.01.4 For display).(21125.02.4 RAM It is a Windows path)
            aNewPath="$( cvt2winPath "${aNewPATH}" "x" 0 )"                                     # .(21121.01.4 For display).(21125.02.4 RAM It is a Windows path. just chop it])

#           aNewPath="$( cvt2winPath "${aNewPATH}" ${aOSv:0:1} )"                               ##.(21121.01.4 For display).(21125.02.3 RAM It is a Windows path)
#           aNewPath="${aNewPATH}"                                                              ##.(21121.01.4 For display).(21125.02.4 RAM It is a Windows path)
            aNewPath="$( cvt2winPath "${aNewPATH}" "x" 0 )"                                     # .(21121.01.4 For display).(21125.02.4 RAM It is a Windows path. just chop it])

#           aNewPath="$( echo "${aNewPath}" | awk '{ gsub( /:/, ";"); gsub( /\/[cC]/, "C:" ); gsub( /\//, "\\" ); print }' )"
#           aNewPath="$( echo "${aNewPath}" | awk '{ n = length($0);  print n < '${nLen}' ? $0 : substr( $0, 1, '${nLen}' ) "..." }' )"    ## Find 1st 80 chars in $PATH
            aNewPath="${aNewPath}\$PATH";
#           echo " -  New Path: '${aNewPath}'";  exit

#         else                                                                                  ##Not Found
#           aNewPath="${aPath};\$PATH"                                                          ##.(21121.01.3
#           aNewPath="${aWinPath};\$PATH"                                                       ##.(21121.01.3
#           aNewPath="$( echo "${aNewPath}" | awk '{ gsub( /:/, ";"); gsub( /\/[cC]/, "C:" ); gsub( /\//, "\\" ); print }' )"
#           aNewPath="$( echo "${aNewPath}" | awk '{ n = length($0);  print n < 90 ? $0 : substr( $0, 1, 90 ) "..." }' )"    ##Find 1st 80 chars in $PATH
#           echo "       aNewPath: ${aNewPath}"; # exit
#           fi
#         -----------------------------------------------------------

        else # if aOSv is not Windows

#           aBashrc=".bashrc";  if [ ! -f -a "~/${aBashrc}" ]; then aBashrc="profile";  fi      ##.(21121.03.1  RAM Use alternate profile file).(21121.03.12)
#           aBashrc=".profile"; if [ ! -f -a  ~/${aBashrc}  ]; then aBashrc=".bashrc";  fi      ##.(21121.03.12 RAM Use .profile if it exists).(21121.03.22)
#           aBashrc=".profile"; if [   -f -a  ~/.bashrc     ]; then aBashrc=".bashrc";  fi      ##.(21121.03.22 RAM Good Grief).(21121.03.32)
            aBashrc=".bashrc";  if [   -f -a  ~/.profile    ]; then aBashrc=".profile"; fi      # .(21121.03.32 RAM More Good Grief)

                                                        aOSname="~/${aBashrc} file"             # .(21121.03.2)
            aOldPATH="$( cat ~/${aBashrc}   | awk '!/^ *#/' | awk '/export PATH=/ { sub( /.+=/, "" ); print; exit }' )" # .(21121.03.3).(21126.06.1 RAM Exclude commented out lines).(21126.06.2 RAM 1st only only)
            aOldPATH="$( echo "${aOldPATH}" | awk '{ sub( /^ *["]/, "" ); sub( /["] *$/, "" ); print }' )"              # .(21126.06.2 RAM Remove trailing quotes)

      if [ "$aOldPATH" != "" ]; then                                                               # if $PATH exists in .bashrc
            aNewPATH="${aPath}:${aOldPATH/${aPath}:/}"; aNewPath="$( cvt2winPath "${aNewPATH}" ${aOSv:0:1} )"  #.(21121.01.3 Put aPath (back) in front of PATH))
            echo "    Old PATH: '${aOldPATH}'"
          else
            echo "    Old PATH: '${aOldPATH}'"
            aNewPATH="${aPath}:\$PATH"                ; aNewPath="$( cvt2winPath "${aNewPATH}" ${aOSv:0:1} )"
            fi

          fi # eif aOSv not Windows
#         -----------------------------------------------------------

#             echo "    Old PATH: '$( cvt2winPath "${aOldPATH}" ${aOSv:0:1} 1 )'"
#             echo "    New PATH: '$( cvt2winPath "${aNewPATH}" ${aOSv:0:1} 1)'";exit
#             echo "    Old PATH: '${aOldPATH}'"
#             echo "    New PATH: '${aNewPATH}'";  exit

#     if [ "${aOldPath}" == "${aNewPath}" ]; then
      if [ "${aOldPATH}" == "${aNewPATH}" ]; then

            echo "    New PATH: '${aNewPath}'"
            echo "  * The ${aOSname} PATH will remain unchanged."
            exit 1
        else
            echo "    New PATH: '${aNewPath}'"

      if [ "${bDoit}" == "1" ]; then

#           echo "$0 vars set -doit PATH \"${aNewPath:2}\""
#                "${BASH_SOURCE} vars set -doit PATH \"${aNewPath:2}\""
#                "$( dirname ${BASH_SOURCE} )/$0 vars set -doit PATH \"${aNewPath:2}\""
#           echo "  $0" vars set -doit PATH "\"${aNewPath}\""

      if [ "${aDelim}" == ":" ]; then                                                       # .(21125.01.11)

                 "$0" vars set PATH -doit "$( cvt2winPath "${aNewPATH}" ${aOSv:0:1} 1)"     # Convert to Linux path, but no length chop

            if [ "$?" == "1" ]; then exit 1; fi
                  source ~/${aBashrc}                                                       # .(21201.03.1 RAM Set PATH temporarily)
          else  # Windows                                                                   # .(21125.01.12)

#           cmd="$( dirname $0)/../../../bin/nircmd.exe elevatecmd execmd"                  # .(21125.01.13)
            aDir="$( dirname "${BASH_SOURCE}" )";
#          $cmd   "REG ADD \"HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Session Manager\\Environment\" -v PATH -d \"${aNewPATH}\""   # .(21125.01.14)
#     echo $cmd "\"REG ADD \"HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Session Manager\\Environment\" -v PATH -d \"${aNewPATH}\"\"" # .(21125.01.14)
#     echo $cmd "\"REG ADD \\\"HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Session Manager\\Environment\" -v PATH -d \\\"${aNewPATH}\\\"\"" # .(21125.01.14)

     if [ "${aShell}" == "-sys"  ]; then                                                    # .(21126.08.9 RAM Beg)
           aHKey="HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Session Manager\\Environment"; fi
     if [ "${aShell}" == "-user" ]; then
           aHKey="HKEY_CURRENT_USER\\Environment"
           aOSname="Windows User"
           fi                                                                               # .(21126.08.9 RAM End)
           aREGA="REG ADD \"${aHKey}\" /v \"PATH\" /t REG_SZ /d \"${aNewPATH}\" /f"
#          echo  nircmd.exe elevatecmd execmd  "${aREGA}"; exit                             # Works in DOS
           echo  "@echo off"                                 >"${aDir}/@regAdd.bat"
           echo  "nircmd.exe elevatecmd execmd ${aREGA}"    >>"${aDir}/@regAdd.bat"         # .(21125.01.x This finally works works in BASH

#                         echo  nircmd.exe elevatecmd execmd  "${aREGA//\\/\\\\}";  exit    #
# aRes="$( ${aDir}/../../../bin/nircmd.exe elevatecmd execmd  "${aREGA}" 2>&1 )"            # .(21113.04.4 RAM This doesn't work!!)
#          ${aDir}/../../../bin/nircmd.exe elevatecmd execmd  "${aREGA//\\/\\\\}"           # .(21113.04.4 RAM This doesn't work!!)
#          ${aDir}/../../../bin/nircmd.exe elevatecmd execmd  "${aDir}/@regAdd.bat"         # .(21113.04.4 RAM This doesn't work!!)
                                                              "${aDir}/@regAdd.bat"         # .(21125.01.6)
                                                           rm "${aDir}/@regAdd.bat"         # .(21125.01.7 RAM delete .bat file)
            fi # eif windows                                                                # .(21125.01.8)
#           echo -e "    The path, '${aPath}', has been added to the global PATH."

         else # if bDoit=0

            if [ "${aShell}" == "-user" ]; then aOSname="Windows User"; fi                  # .(21126.09.2)
            echo    "    The path, '$( cvt2winPath "${aPath}" ${aOSv:0:1} )', will be added to the ${aOSname} PATH."
#           echo -e "    The path, '${aPath}', will be added to the ${aOSname} PATH."

            fi # eif "${aOldPath}" != "${aNewPath}" no need to change

            ${aLstSp}; bCmdRan="1"                                                          # .(81014.03.8)
            fi                          # eif aCmd2 == path add                             # .(21114.05.1 RAM End)
#    +---- +------------------ +----------------------------------------------------------- # --------+
        fi                              # eif aCmd1 == path
#   +----- +------------------ +----------------------------------------------------------- # ----------+

# ------------------------------------------------------------------------------------
#
#       Vars Commands
#
#====== =================================================================================================== #

           sayMsg "RSS[ 738]  aCmd: ${aCmd1}.${aCmd2}, aArg1: ${aArg1}, bCmdRan: ${bCmdRan}" 1; # ${aLstSp}; exit

     if [ "${aCmd1:0:3}" == "var"  ]; then aCmd1="vars"; fi                                # .(30520.02.x RAM)
     if [ "${aCmd1}"     == "vars" ]; then    # if  aCmd1 == vars

# ------------------------------------------------------------------------------------
#
#       Set Vars Set Command
#
#====== =================================================================================================== #

#    +---- +------------------ +----------------------------------------------------------- # --------+

           sayMsg "RSS[ 751]  aCmd: ${aCmd1}.${aCmd2}, aArg1: ${aArg1}, bCmdRan: ${bCmdRan}" 1; # ${aLstSp}; exit

     if [ "$aCmd2" == "set"  ]; then                                                                     # .(21112.03.2 RAM Beg Add vars set)

function setBashrc() { bDoit=$3                                                                          # .(21112.03.1 RAM Beg Write it).(21114.02.11)
#        aVar="$1"; aVal="$2"; if [ "${aVal/ /}" != "${aVal}" ]; then aVal="\\\"${aVal}\\\""; fi;        # .(21112.06.1 RAM Put Quotes if necessary)
         aVar="$1"; aVal="$2"; if [ "${aVal/ /}" != "${aVal}" ]; then aVal="\\\"${aVal}\\\""; fi;        # .(21112.06.1 RAM Put Quotes if necessary)
#        echo -e "\n aVal: '${aVal}'"; # exit

#    +---- +------------------ +-----------------------------------------------------------

aAwkPgm='
BEGIN { bNew=1 }
    /export '${aVar}'=/ { sub( /=.+/, "='${aVal}'" ); print $0; bNew=0; next }; { print }
END { if ( bNew == 1 ) { print ""; print "  export '${aVar}'='${aVal}'" } }
'
#        echo "-----------------------------------------"
#        echo "${aAwkPgm}"; echo ""
#        echo "-----------------------------------------"
#        exit

#    +---- +------------------ +-----------------------------------------------

   if [ "${bDoit}" == "1" ]; then aVerb="has been"; #aToDo="      Please run: source ~/${aBashrc}"       ##.(21114.02.12).(21121.03.4)
                                                     aToDo="      Please login again"                    # .(21121.03.4)
         cd ~
#        aBashrc=".bashrc";  if [ ! -f -a "~/${aBashrc}" ]; then aBashrc="profile";  fi                  ##.(21121.03.5).(21121.03.13)
#        aBashrc=".profile"; if [ ! -f -a "~/${aBashrc}" ]; then aBashrc=".bashrc";  fi                  ##.(21121.03.13 RAM Use .profile if it exists).(21121.03.23)
#        aBashrc=".profile"; if [   -f -a  ~/.bashrc     ]; then aBashrc=".bashrc";  fi                  ##.(21121.03.23 RAM Good Grief).(21121.03.33)
         aBashrc=".bashrc";  if [   -f -a  ~/.profile    ]; then aBashrc=".profile"; fi                  # .(21121.03.33 RAM More Good Grief)

         aTS=$( date '+%y%m%d.%H%M'); aBak="${aBashrc}_v${aTS}"                                          # .(21121.03.6)
         mv  ${aBashrc}  ${aBak};                                                                        # .(21121.03.7)
         cat ${aBak}  | awk "${aAwkPgm}" >${aBashrc}                                                     # .(21121.03.8)
#        cat ${aBashrc}
#        source ${aBashrc}
      else                                                                                               # .(21114.02.13)

#                                aVerb="will be"; aToDo=""                                               ##.(21114.02.14).(30520.03.2)
                                 aVerb="needs to be"; aToDo=""                                           # .(30520.03.2 RAM Will be?)
                                 aDir=$( dirname $0); aDir=${aDir/_1*/info}                              # .(30520.03.3)
              aToDo="\n    Run ${aDir} Edit Profile"                                                     # .(30520.03.4)
         fi                                                                                              # .(21114.02.15)
#    +---- +------------------ +-----------------------------------------------

         if [ "${bQuiet}" != "1" ]; then                                                                 # .(21127.07.1 RAM Don't speak if setPath)
            echo -e "    The Var, '${aVar}' ${aVerb} set in your ./bash_profile. $aToDo"                 # .(21114.02.16)
#           echo ""
            fi                                                                                           # .(21127.07.2)

         } # eof setBashrc                                                                               # .(21112.03.1 RAM End)
#    +---- +------------------ +-----------------------------------------------------------

#        aArg2="$4"; aArg3="$5";            bDoit=0                                                      # .(21114.02.1 RAM Beg Add bDoit)
#        if [ "${aArg1}" == "-doit" ]; then bDoit=1; aArg1="${aArg2}"; aArg2="${aArg3}"; fi
#        if [ "${aArg2}" == "-doit" ]; then bDoit=1; aArg2="${aArg3}"; fi
#        if [ "${aArg3}" == "-doit" ]; then bDoit=1; fi

#        aVar="${aArg1}"; aVal="${aArg2}"; aVal1="${aVal}"                                               ##.(21114.02.1 RAM End).(30523.04.1)
         aVar="${aARG1}"; aVal="${aArg2}"; aVal1="${aVal}"                                               # .(21114.02.1 RAM End).(30523.04.1 RAM)
         if [ "${aVal/ /}" != "${aVal}" ]; then aVal1="\\\"${aVal}\\\""; fi;
         if [ "${aVal/ /}" != "${aVal}" ]; then aVal1="\"\"${aVal}\"\""; fi;
         if [ "${aVal/ /}" != "${aVal}" ]; then aVal1="\"${aVal}\""; fi;

#        echo "  rss info vars set '${aVar}' '${aVal}' for aOSv: ${aOSv}; bDoit=${bDoit}"; exit

#      if [ "${aOSv:0:1}" == "w" ] || [ "${aOSv:0:1}" == "g" ]; then
       if [ "${aOSv:0:1}" == "w" ]; then                                                                 # .(21126.06.3 RAM Just for Windows)

#        echo -e "  Windows aOSv: '${aOSv}'"
#        echo "  setx ${aVar}=\"${aVal}\" /M"
#                setx ${aVar}="${aVal}" /M
#                /C/WEBs/8020/VMs/et218t/webs/nodeapps/FRTools_/prod1-master/._2/bin/nircmd.exe elevatecmd execmd "SETX ${aVar} ${aVal} /M"

         aDir="$( dirname "${BASH_SOURCE}" )"; aSETX="SETX ${aVar} ${aVal1} /M"

#                ${aDir}/../../../bin/nircmd.exe elevatecmd execmd  "SETX ${aVar} \"${aVal}\" /M"        # .(21113.04.1 RAM No workie)
#        echo "  ${aDir}/../../../bin/nircmd.exe elevatecmd execmd \"SETX ${aVar} ${aVal1} /M\""
#                ${aDir}/../../../bin/nircmd.exe elevatecmd execmd  "SETX ${aVar} ${aVal1} /M"           # .(21113.04.2 RAM No workie)
#        echo "  ${aDir}/../../../bin/nircmd.exe elevatecmd execmd   SETX ${aVar} ${aVal1} /M"
#                ${aDir}/../../../bin/nircmd.exe elevatecmd execmd   SETX ${aVar} ${aVal1} /M            # .(21113.04.3 RAM No workie)

         aSETX1="${aSETX/(/\\(}";   aSETX1="${aSETX1/)/\\)}"                                             # .(21231.04.1 RAM Escape parens)
#        echo "  ${aDir}/../../../bin/nircmd.exe elevatecmd execmd  \"${aSETX1}\""

#        --- ----------------------------------
                                         aTodo="Please Login again for the ${aVar} to take effect."      # .(21114.02.2).(21126.09.6)
         if [ "${bDoit}" == "0" ]; then                                                                  # .(21114.02.3)
                 echo "  ${aSETX}"     ; aToDo=""                             ; aVerb="will be"          # .(21114.02.4)

           else                                                                 aVerb="has been"         # .(21114.02.5)
#                                echo nircmd.exe elevatecmd execmd  "${aSETX}"; aVerb="has been"
#                ${aDir}/../../../bin/nircmd.exe elevatecmd execmd  "${aSETX}"
     aResult="$( ${aDir}/../../../bin/nircmd.exe elevatecmd execmd  "${aSETX}" 2>&1 )"                   # .(21113.04.4 RAM This works!! aResult = "")

             if [ "$?" == "139" ]; then                                                                  # .(21122.01.7 RAM Error code 139 for  Segmentation fault)
                echo -e " ** The DOS command SETX failed\n"
                exit 1; fi                                                                               # .(21122.01.8)

             fi # "${bDoit}" != "0"                                                                      # .(21114.02.6).(21114.02.21)
#        --- ----------------------------------

#        bBash=$( rss info path | awk 'BEGIN{ b=0 }; /\/(Git|git)\/usr/ { b=1; exit }; END { print b }' ); # echo -e "\n * bBash: ${bBash}"
         bBash=0; if [ "${aOSv:0:3}" == "gfw" ]; then bBash=1; fi

#        --- ----------------------------------
         if [ "${bBash}" == "1" ]; then                                                                  # .(21114.02.22)

             echo -e "    The Var, '${aVar}', ${aVerb} set in your bash profile."                        # .(21114.02.7)
#            echo "  Bash  (${aOSv}): setBashrc \"${aVar}\" \"${aVal}\""
                                      setBashrc  "${aVar}"   "${aVal}"  ${bDoit}                         # .(21114.02.8)
           else # "${bBash}" == "1"

             echo -e "    The Var, '${aVar}', ${aVerb} set for all users in Windows.  ${aTodo}"          # .(21114.02.9)

             fi # "${bBash}" != "1"                                                                      # .(21114.02.23)
#        --- ----------------------------------

       else # OS == Linux; OS != Windows

#            echo "  Linux (${aOSv}): setBashrc \"${aVar}\" \"${aVal}\""
                                  setBashrc  "${aVar}"   "${aVal}"  ${bDoit}                             # .(21114.02.10)
             fi # OS == Linux

             bCmdRan="1"
         fi                             # eif aCmd2 == vars set                                          # .(21112.03.2 RAM End)
#    +---- +------------------ +----------------------------------------------------------- # --------+

#====== =================================================================================================== #  ===========

# ------------------------------------------------------------------------------------
#
#       Show Vars Command
#
#====== =================================================================================================== #

            sayMsg "RSS[ 886]  aCmd: ${aCmd1}.${aCmd2}, aArg1: ${aArg1}, bCmdRan: ${bCmdRan}" 1; # ${aLstSp}; exit

# ------------------------------------------------------------------------------------
#
#       Vars Show
#
#====== =================================================================================================== #

     if [ "${aArg1:0:3}" == "ser"  ]; then             bSkip=1; else bSkip=0; fi            # .(21126.04.2 RAM).(30520.01.6 RAM)
     if [ "$aCmd2"       != "show" ] && [ "${bSkip}" == "0" ]; then aArg1=$aCmd2; aCmd2=show; fi
     if [ "$aArg1"       == "os"   ]; then aArg1="OS"; bSkip=1; fi                          # .(21126.04.2 RAM).(30520.01.7 RAM)

            sayMsg "RSS[ 898]  aCmd: ${aCmd1}.${aCmd2}, aArg1: ${aArg1}, bSkip: ${bSkip}" 1;

     if [ "$aCmd2" == "show"   ] && [ "$bSkip" != "1" ]; then                               # .(21126.04.2).(30520.01.8 RAM Was: "$aArg1" != "OS")

#    if [ "$aArg1" == ""       ]; then   set | awk '/^[A-Z]+=/ { print "  "$0 }'; fi        # .(21126.04.3)
#    if [ "$aArg1" == ""       ]; then   set | awk '/^[A-Z]+=/ { a=$0; if (substr( a,1,5 ) == "PATH=") { a = substr( a,1,80 ) "... (" (length($0)-5) " chars)" }; print "  " a }'; fi ##.(30611.01.1).(21126.04.3)
#    if [ "$aArg1" == ""       ]; then   set | awk '!/^[{} ]/  { a=$0; if (substr( a,1,5 ) == "PATH=") { a = substr( a,1,80 ) "... (" (length($0)-5) " chars)" }; print "  " a }'; fi # .(30611.01.1).(21126.04.3)
     if [ "$aArg1" == ""       ]; then   set | awk '!/^[{} ]/  { a=substr( $0,1,80 ); n = match( a, /(Path|PATH)=/ ); if (n > 0) { a =  a "... (" (length($0)-5) " chars)" }; print "  " a }'; fi # .(30611.03.1).(21126.04.3)

     if [ "$aArg1" != ""       ]; then

         if [ "${aArg1:0:1}" == "!" ]; then aArg1="${aArg1:1}.+="; else aArg1="^${aArg1}"; fi
             if [ "$bTest" == 1 ]; then
#              echo "set | awk '/^[A-Z]+=/' | awk 'BEGIN {IGNORECASE=1}  /$aArg1/" | awk '{ print "  "$0 }'; echo "";   # /.#(30611.01.2)
               echo "set | awk '!/^[{} ]/'  | awk 'BEGIN {IGNORECASE=1}  /$aArg1/" | awk '{ print "  "$0 }'; echo "";   # /. (30611.01.2)
            fi
#                    set | awk '/^[A-Z]+=/' | awk 'BEGIN {IGNORECASE=1} /'$aArg1'/        { print "  "$0 }'             # /.#(30611.01.3)
                     set | awk '!/^[{} ]/'  | awk 'BEGIN {IGNORECASE=1} /'$aArg1'/        { print "  "$0 }'             # /. (30611.01.3)

         fi # eif "$aCmd2" == "show aArg1"

         ${aLstSp}; bCmdRan="1"                                                             #.(81014.03.9)
         fi                             # eif aCmd2 == vars show
#   +----- +------------------ +----------------------------------------------------------- # ----------+

# ------------------------------------------------------------------------------------
#
#       Vars Show / Make Server Command
#
#====== =================================================================================================== #

           sayMsg "RSS[ 917]  aCmd: ${aCmd1}.${aCmd2}, aArg1: ${aArg1}, bCmdRan: ${bCmdRan}" 1; # ${aLstSp}; exit

     if [ "${aArg1}" == "server" ]; then                                                    # .(30520.01.9 RAM Beg)

     if [ "${aCmd2}" == "show" ]; then
#          echo ""
        if [ "${THE_SERVER}" != ""  ]; then echo "  THE_SERVER: ${THE_SERVER}"; bCmdRan=1; fi
        if [ "${SCN_SERVER}" != ""  ]; then echo "  SCN_SERVER: ${SCN_SERVER}"; bCmdRan=1; fi
        if [ "${bCmdRan}"    != "1" ]; then echo "  THE_SERVER: Not Defined";   bCmdRan=1; fi
           fi
     if [ "${aCmd2}" == "make" ]; then
            $(dirname $0)/RSS24_setServer.sh "$4" "$5" "$6" "$7" "$8"
            bCmdRan=1
           fi                                                                               # .(30520.01.9 End)
           ${aLstSp}

        fi # eoc server
#   +----- +------------------ +----------------------------------------------------------- # ----------+

# ------------------------------------------------------------------------------------
#
#       Show OS Command
#
#====== =================================================================================================== #

            sayMsg "RSS[ 950]  aCmd: ${aCmd1}.${aCmd2}, aArg1: ${aArg1}, bCmdRan: ${bCmdRan}" 1; # ${aLstSp}; exit

     if [ "$aArg1" == "OS" ]; then                                                          # .(21126.04.1 RAM Beg New Cmd)

        if [ -f /etc/issue ]; then                                                          # .(30520.02.x Beg RAM Add this)
            echo "  OS=$( cat /etc/issue | awk '/Red Hat/ { print $1" "$2" "$5 }; /Ubuntu/ { print $1" "$2 }' )"
            fi                                                                              # .(30520.02.x End)
            set  |  awk 'BEGIN {IGNORECASE=1} /^OS/ { print "  "$0 }'
            echo "  aOSv='${aOSv}'"
            echo "  aOS='${aOS}'"

            ${aLstSp}; bCmdRan="1"                                                          # .(81014.03.9)
        fi                              # eif aCmd1 == vars show OS                         # .(21126.04.1 RAM End)
#    +---- +------------------ +----------------------------------------------------------- # --------+
     fi                                 # eif aCmd1 == vars
#   +----- +------------------ +----------------------------------------------------------- # ----------+

# ------------------------------------------------------------------------------------
#
#       Profile Command
#
#====== =================================================================================================== #

            sayMsg "RSS[ 974]  aCmd: ${aCmd1}.${aCmd2}, aArg1: ${aArg1}, bCmdRan: ${bCmdRan}" 1; # ${aLstSp}; exit

     if [ "${aCmd1:0:3}" == "pro"  ]; then aCmd1="profile"; fi                              # .(30520.02.x RAM Beg)
     if [ "${aCmd1}"     == "profile" ]; then    # if  aCmd1 == vars

            aUSER="$( echo "${HOME}" | awk '{ sub( /.*[\\/]/, "" ); print }' )";            # .(30520.01.4)
            aUser="${aArg1}"; if [ "${aArg1}" == "" ]; then aUser="${aUSER}"; aArg1="${aUser}"; fi

            aHome="/${aUser}"; if [ "${aUser}" != "root" ]; then aHome="/home/${aUser}"; fi

            aProfile="${aHome}/.bash_profile"; if [ "${aUser}" == "template" ]; then
            aProfile="$(dirname $0)/RSS25_.bash_profile"; fi

            sayMsg "RSS[ 984]  aCmd: ${aCmd1}.${aCmd2}, aHome: '${aHome}'" 1

#           --------------------------------------------------------------------

     if [ "${aCmd2:0:3}" == "sho" ]; then

            echo "--------------------------------------------------------------------------------------------"
            echo "  ${aProfile}"
            echo "--------------------------------------------------------------------------------------------"
       sudo cat    "${aProfile}"
            echo "--------------------------------------------------------------------------------------------"
            echo "  ${aProfile}  ($( sudo ls -l --time-style long-iso "${aProfile}" | awk '{ print $6" "$7 }' ))"
            fi
#           --------------------------------------------------------------------

     if [ "${aCmd2:0:3}" == "edi" ]; then

       sudo nano   "${aProfile}"
            echo "--------------------------------------------------------------------------------------------"
            echo "  ${aProfile}"
            fi
#           --------------------------------------------------------------------

     if [ "${aCmd2:0:3}" == "sav" ]; then

     if [ "${bDoit}" != "1" ]; then

            aProfile="$(dirname $0)/RSS25_.bash_profile"
            echo "--------------------------------------------------------------------------------------------"
            cat    "${aProfile}"
            echo "--------------------------------------------------------------------------------------------"
            echo "  ${aProfile}  ($( sudo ls -l --time-style long-iso "${aProfile}" | awk '{ print $6" "$7 }' ))"

            echo -e "\n  To save this profile to ~/.bash_profile for user: ${aUser},"
            echo -e "     add -doit to the command to actually doit."

          else
            if [ "$3" == "-doit" ]; then shift; fi;
#           if [ "$3" != ""      ]; then aHome="/home/$3"; aUser=$3; else aHome="/root"; fi

#           cp  "./Info/RSS25_.bash_profile" ~/.bash_profile
#      echo cp  "$(dirname $0)/RSS25_.bash_profile" ${aHome}/.bash_profile
       sudo cp  "$(dirname $0)/RSS25_.bash_profile" ${aHome}/.bash_profile
            echo -e   "  Saved profile to .bash_profile for user: ${aUser}"
            echo -e "\n  Note: Use the RSS Info Server command to determine THE_SERVER variable"
            echo -e   "        and then set it in the file, '${aHome}/.bash_profile'"

            if [ "${aUser}" == "${aUSER}" ]; then echo "   Then run: source \"${aHome}/.bash_profile\""; fi

            fi # eif -doit
#           --------------------------------------------------------------------
            fi # eif save profile

            ${aLstSp}; bCmdRan=1

        fi # eoc profile
#   +----- +------------------ +----------------------------------------------------------- # ----------+

#====== =================================================================================================== #  ===========

# ------------------------------------------------------------------------------------
#
#       Add / Show User Command
#
#====== =================================================================================================== #

           sayMsg "RSS[1053]  aCmd: ${aCmd1}.${aCmd2}, aArg1: ${aArg1}, bCmdRan: ${bCmdRan}" 1; # ${aLstSp}; exit

     if [ "${aCmd1}" == "user" ]; then                                                      # .(30520.03.4 RAM Beg)

     if [ "${aCmd2}" == "show" ]; then
           aUser=${aArg1}; if [ "${aUser}" == "" ]; then
           aUser=$( echo "${HOME}" | awk '{ sub( /.*[\\/]/, "" ); print }' ); fi

           mRows=( $( cat /etc/passwd | awk '/'${aUser}'/ { print }' | tr ':' '\n' ) )
#          echo "${mRows[@]}"
           aName=${mRows[4]}; n=6; if [ "${mRows[5]/\//}" != "${mRows[5]}" ]; then aName="${mRows[4]} ${mRows[5]//,/}"; n=5; fi
#          echo "aName: '${aName}', n: ${n}, \${mRows[$((n+1))]}, test: '${mRows[5]/\//}' != '${mRows[5]}'"

           printf "    %-12s %s\n" "Userid:"   "${mRows[0]}"
#          printf "    %-12s %s\n" "Whoami:"   "$( whoami )"
           printf "    %-12s %s\n" "FullName:" "${aName}"
           printf "    %-12s %s\n" "UserNos:"  "${mRows[2]} ${mRows[3]}"
           printf "    %-12s %s\n" "Shell:"    "${mRows[$((n+1))]}"
           printf "    %-12s %s\n" "Home:"     "${mRows[$((n+0))]}"
           printf "    %-12s %s\n" "Groups:"   "$( groups | awk '{ print substr($0,20) }' )"
           cat /etc/group | awk '/'${aUser}'/ { sub( /:.+/, "" ); print "      " $0 }'
           bCmdRan=1
           fi

      if [ "${aCmd2}" == "add" ]; then
           aUser=${aArg1}; if [ "${aUser}" == "" ]; then
           echo " ** Please provide a userid"

         else
           sudo adduser ${aUser}
           sudo usermod -aG sudo ${aUser}
#          rss info save profile ${aUser} -doit
           echo "\n  Now run: rss info save profile ${aUser}"
           echo   "  To generate SSH public and private key files"
           bCmdRan=1
           fi
           fi

           ${aLstSp}

        fi # eoc user                                                                       # .(30520.03.4 End)
#   +----- +------------------ +----------------------------------------------------------- # ----------+

#====== =================================================================================================== #  ===========

# ------------------------------------------------------------------------------------
#
#       Top Command
#
#====== =================================================================================================== #

     if [ "$aCmd1" == "top"       ]; then # if  aCmd1 == top                                # .(81014.05.1 Beg)

       if [ "${OSTYPE}" != "msys" ]; then echo " * top only works in linux";                # .(30522.01.3)
          else
            top -b -n 1 | awk '/^[ 0-9]/ { if ($10 > 0.0) { print "    " $0 } }' | sort -k11,11 -k12r   #[bdfgiMhnRrV],
            fi
            ${aLstSp}; bCmdRan="1"
     fi                                   # eif aCmd1 == top                                #.(81014.05.1 End)
#   +----- +------------------ +----------------------------------------------------------- # ----------+

#====== =================================================================================================== #  ===========

# ------------------------------------------------------------------------------------
#
#       New Commands
#
#====== =================================================================================================== #

# ------------------------------------------------------------------------------------
#
#       New Command 1
#
#====== =================================================================================================== #

           sayMsg "RSS[1113]  aCmd: ${aCmd1}.${aCmd2}, aArg1: ${aArg1}, bCmdRan: ${bCmdRan}" 1; # ${aLstSp}; exit

if [ "$aCmd1" == "newcmd1" ]; then      # if  aCmd1 == newcmd1                              #.(81014.04.1 Beg)

     if [ "$aCmd2" == "subcmd1" ]; then # if  aCmd2 == subcmd1

            echo "  Running $aCmd1 $aCmd2"

            ${aLstSp}; bCmdRan="1"
            fi;                         # eif aCmd2 == subcmd1
#    +---- +------------------ +----------------------------------------------------------- # --------+

# ------------------------------------------------------------------------------------
#
#       New Command 2
#
#====== =================================================================================================== #

     if [ "$aCmd2" == "subcmd2" ]; then # if  aCmd2 == subcmd2

            echo "  Running $aCmd1 $aCmd2"

            ${aLstSp}; bCmdRan="1"
            fi                          # eif aCmd2 == subcmd2
#    +---- +------------------ +----------------------------------------------------------- # --------+

     fi                                 # eif aCmd1 == newcmd1                              #.(81014.04.1 End)
#   +----- +------------------ +----------------------------------------------------------- # ----------+

#====== =================================================================================================== #  ===========

     if [ "${aCmd1}" == "source"  ]; then echo $0 | awk '{                         print "  '$LIB' ScriptFile: "   $0    }'; echo ""; exit; fi
#    if [ "${aCmd1}" == "source"  ]; then                                                  echo "                  ${aFns}"; echo ""; exit; fi  # .(21114.03.1 RAM There is not Main2Fns)
#    if [ "${aCmd1}" == "version" ]; then echo $0 | awk '{ gsub( /.+_v|.sh/, "" ); print "  '$LIB' Version: "      $0 }';    echo ""; exit; fi  ##.(81014.02.1)
#    if [ "${aCmd1}" == "version" ]; then echo $0 | awk '{ gsub( /.+_v|.sh/, "" ); print "  '$LIB' Info Version: " $0 }';    echo ""; exit; fi  # .(81014.02.1)
#    if [ "${aCmd1}" == "version" ]; then echo "  $LIB Info Version: $0"; echo ""; exit; fi ##.(81014.02.1).(21112.01.2)
     if [ "${aCmd1}" == "version" ]; then echo "  $LIB Info Version: ${aVer}  (${0##*/})"   # .(21112.01.1 RAM Beg)
            echo "$0" | awk '{ print "   " $0 }'
            exit; fi                                                                        # .(21112.01.1 RAM End)

#   +----- +------------------ +----------------------------------------------------------- # ----------+

     if [ "${bCmdRan}" == "0" ]; then                                                       #.(81014.03.11 Beg)

           echo "  * Info Command, '$aCmd1 $aCmd2', Not Found"; echo ""
           Help;
           fi                                                                               #.(81014.03.11 End)
# +------- +------------------ +----------------------------------------------------------- # ------------+ ------------------- # --------------+

#          echo ""
#          echo "*** aCmd: $aCmd1.$aCmd2 \"$aArg1\", bCmdRan: ${aCmdRan}"; exit
#
#====== =================================================================================================== #  ===========
#*\
##SRCE     +====================+===============================================+
##RFILE    +====================+=======+===================+======+=============+
#*/
