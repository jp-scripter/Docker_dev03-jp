#!/bin/bash
#*\
##=========+====================+================================================+
##RD         gitr clone         | Git Clone {Project}
##RFILE    +====================+=======+===============+======+=================+
##FD   FRT23_gitR_clone.sh      |  24859| 11/01/22 15:58|   474| p1.03-21101-1558
##FD   FRT23_gitR_clone.sh      |  27579| 11/05/22 18:00|   507| p1.03-21105-1800
##FD   FRT23_gitR_clone.sh      |  28520| 11/05/22 19:00|   515| p1.03-21105-1900
##FD   FRT23_gitR_clone.sh      |  29196| 11/07/22 08:45|   528| p1.03-21107-0845
##FD   FRT23_gitR_clone.sh      |  33656| 11/27/22 17:20|   567| p1.04-21127.1720
##FD   FRT23_gitR_clone.sh      |  42798| 12/03/22 14:24|   696| p1.04-21203.1424
##FD   FRT23_gitR_clone.sh      |  47389| 12/04/22 20:23|   788| p1.04-21204.2023
##FD   FRT23_gitR2_clone.sh     |  54109| 12/06/22 14:45|   844| p1.04-21206.1445
##DESC     .--------------------+-------+---------------+------+-----------------+
#            Use the commands in this script to run gitr clone {Project}
#
##LIC      .--------------------+----------------------------------------------+
#            Copyright (c) 2021 8020Data-FormR * Released under
#            MIT License: http://www.opensource.org/licenses/mit-license.php
##FNCS     .--------------------+----------------------------------------------+

##CHGS     .--------------------+----------------------------------------------+
# .(21026.01 10/26/22 RAM 12:00p| Delete all files in RepoDir)
# .(21029.01 10/29/22 RAM 12:00p| Copy/Zip repo to ${aRepoDir}_v${aTS})
# .(21029.02 10/29/22 RAM 14:16p| Create config file if not found
# .(21029.03 10/29/22 RAM  8:29p| Improved Dir location
# .(21030.01 10/30/22 RAM  6:00p| Don't remove _ from Backup folder/zipfile name
# .(21101.01 11/01/22 RAM  5:11p| Parse Clone URL if passed
# .(21101.02 11/01/22 RAM  5:58p| Determine Parent folder
# .(21101.03 11/01/22 RAM  5:58p| Doit if config file is created or updated
# .(21105.01 11/05/22 RAM  4:29p| If no {Stage}, then aStage == "", not {stg1}-{ownr}
# .(21105.02 11/05/22 RAM  5:00p| Show config after update
# .(21105.03 11/05/22 RAM  5:43p| If Github URL parsed, then modify RepoDir
# .(21105.04 11/05/22 RAM  6:00p| Always set aWebsDir to aPDir, and fix
# .(21105.05 11/05/22 RAM  7:00p| Set c1 if parsing and in Project_ folder
# .(21107.01 11/07/22 RAM  8:45a| Check if RepoDir is completely removed
# .(21118.02 11/27/22 RAM  3:10p| Add RepoDir folder to parsed argument
# .(21127.01 11/27/22 RAM  3:10p| Change name of gitr-config file
# .(21127.02 11/27/22 RAM  3:10p| RDir may not exist
# .(21127.08 11/27/22 RAM  8:30p| Added ${aLstSp} in various places
# .(21129.02 11/27/22 RAM  8:45a| Display full git pull and clone result
# .(21130.01 11/30/22 RAM 10:20a| Only show 21 lines of config file
# .(21201.09 12/01/22 RAM  6:10p| Improve checking if all repo files are deleted
# .(21202.02 12/02/22 RAM  2:45p| Improve gitr clone
# .(21204.01 12/04/22 RAM  8:20p| Add Refresh and Edit commands
# .(21202.02 12/05/22 RAM  6:40p| Allow Yes or No answers
# .(21202.02 12/05/22 RAM  7:10p| Must use ( )s for array asignments
# .(21205.03 12/05/22 RAM  7:50p| Use PrjN Uppercase for gitR-config.sh
# .(21206.01 12/06/22 RAM  9:00a| Prompt for Edit or Doit after creating configfile
# .(21206.02 12/06/22 RAM  1:55p| Make created and updated displays the same
# .(21206.03 12/06/22 RAM  2:45p| .git/info/sparse-checkout may not be created
# .(21206.04 12/06/22 RAM  3:40p| Use WebsDir if valid

##PRGM     +====================+===============================================+
##ID 69.600. Main               |
##SRCE     +====================+===============================================+
#*/
#========================================================================================================== #  ===============================  #

    aVdt="Dec 06, 2022  2:45p"; aVtitle="formR gitR Tools"                                                                      # .(21113.05.6 RAM Add aVtitle for Version in Begin)
    aVer="$( echo $0 | awk '{  match( $0, /_[dpstuv][0-9]+\.[0-9]+/ ); print substr( $0, RSTART+1, RLENGTH-1) }' )"             # .(21031.01.1 RAM Add [d...).(20416.03.8 "_p2.02", or _d1.09)

                               bHelp=0
 if [ "$1" ==  "help"  ]; then bHelp=1; shift; fi
 if [ "$1" == "-help"  ]; then bHelp=1; shift; fi
 if [ "$2" == "-help"  ]; then bHelp=1; fi
 if [ "$3" == "-help"  ]; then bHelp=1; fi

                               bAll=0
 if [ "$1" == "-all"   ]; then bAll=1; shift; fi
 if [ "$2" == "-all"   ]; then bAll=1; fi
 if [ "$3" == "-all"   ]; then bAll=1; fi
 if [ "$4" == "-all"   ]; then bAll=1; fi            # .(21204.01.21)

                               bDoit=0
 if [ "$1" == "-doit"  ]; then bDoit=1; shift; fi
 if [ "$2" == "-doit"  ]; then bDoit=1; fi
 if [ "$3" == "-doit"  ]; then bDoit=1; fi
 if [ "$4" == "-doit"  ]; then bDoit=1; fi
 if [ "$5" == "-doit"  ]; then bDoit=1; fi            # .(21204.01.22)

                               bEdit=0                # .(21204.01.23 RAM Beg)
 if [ "$1" == "-edit"  ]; then bEdit=1; shift; fi
 if [ "$2" == "-edit"  ]; then bEdit=1; fi
 if [ "$3" == "-edit"  ]; then bEdit=1; fi
 if [ "$4" == "-edit"  ]; then bEdit=1; fi
 if [ "$5" == "-edit"  ]; then bEdit=1; fi            # .(21204.01.23 RAM End)

                               aPrj="$1"
#if [ "${aPrj}" == ""  ]; then aPrj="FRNet"; fi
 if [ "${aPrj}" == ""  ]; then bHelp=1; fi

                               aRepoDir="$2"   # .(21118.02.1 RAM)

#   -----------------------------------------------------------------
     aLstSp="echo "; if [ "${aOSv/w}" != "${aOSv}" ]; then aLstSp=""; fi                                    # .(10706.09.1 RAM Windows returns an extra blank line).(21113.06.1 RAM Reverse).(21120.02.1)

#========================================================================================================== #  ===============================  #

# ------------------------------------------------------------------------------------
#
#       HELP Command
#
#====== =================================================================================================== #  ===========

 if [ "${bHelp}" == "1" ]; then

    echo ""
    echo "  Retreive / Clone Latest Repository   (${aVer})                        (${aVdt})"
    echo "  -----------------------------------------------------------------------------------------"
    echo "   Syntax: gitr clone {Project}|{GitHub URL} [{RepoDir}] [-all] [-doit] [-edit]"
    echo ""
    echo "    Clone a GitHub Repository for {Project} or {GitHub URL}, partially or fully"
    echo "      If {Project} is a GitHub URL, then parse it and save a Config File"
    echo "      If {RepoDir} is present, then save it into Config File as well"
    echo "      if -all  is  provided, then clone all repository files"
    echo "      If -doit is not provided, then show contents of the Git {Project} Config File "
    echo "      If -doit is provided, then backup {RepoDir} and clone a new Repossitory"
    echo ""
    echo "    Uses a Config File, \"{Project}_gitR-config.sh\", in the current {WebsDir} folder"
    echo "    It contains the following variables, for example: (no spaces before or after = )"
    echo ""
    echo "      Project=\"FRApps\""
    echo "      Stage=\"prod-master\""
    echo "      GitHub_Acct=\"8020data\""                                                               # .(21101.01.1 RAM Add Acct and SSH Key)
    echo "      GitHub_Cert=\"github-usr\""
    echo "      GitHub_SSH=\"no\""                                                                      # .(21101.01.2)
    echo ""
    echo "      RepoDir=\"{Project}_{Stage}\"   # In Workstation: C:\\Repos "
    echo "      RepoDir=\"{Project}\"           # In Server:      /webs "
    echo ""
    echo "      WebsDir=\"C:\\Repos\", or \"/webs\""
    echo ""
    echo "   #  Apps+=\"/client1/\""            # Include folder(s) when Sparse is on"
    echo "      Apps+=\"/client1/1c1_my-html-custom-app/\""
    echo "      Apps+=\"/client3/1c3_my-react-custom-app/\""
    echo "      Apps+=\"/client1/\""
    echo ""
    echo "    Only the folders named in the Apps array will be retreived after: gitr pull, gitr clone, or "
    echo "      gitr sparse checkout [on].  Retreives all files after: gitr sparse off, or gitr clone -all."

    ${aLstsp}; exit
    fi
#   --- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#========================================================================================================== #  ===============================  #

    aStage_var="{prod1-robin}"
    aGitHub_Cert_var="{github-ram}"
    aGitHub_Acct_var="{robinmattern}"                                                                   # .(21101.01.3)
    aGitHub_SSH_var="{yes}"                                                                             # .(21101.01.4)

# ------------------------------------------------------------------------------------
#
#       Parse Args
#
#====== =================================================================================================== #  ===========

# if [ "${aPrj/-/}"  != "${aPrj}" ] || [ "${aPrj/:/}" != "${aPrj}" ] || [ "${aPrj/-/}" != "${aPrj}" ]; then bParse=1; else bParse=0; fi

         bParse=$( echo "${aPrj}" | awk '/^[a-zA-Z0-9]+_?$/ { print 0; exit }; { print 1 }' );         # .(21101.01.4 RAM 1st work contains _)
 #       echo -e "\n  aPrj: ${aPrj}', bParse: ${bParse}"; exit
 if [ "${bParse}" == "1" ]; then                                                                       # .(21101.01.5 RAM Beg Parse if aPrj = location)

#       {Project}_{stg1}-{ownr}
#       {GitHub_Cert}:{GitHub_Acct}/{Project}_{stg1}-{ownr}
#        git@github.com:robinmattern/FRTools_prod1-robin.git
#        https://github.com/{GitHub_Acct}/{Project}_{stg1}-{ownr}
#        https://github.com/robinmattern/FRTools_prod1-robin.git

#       {GitHub_Cert}:{GitHub_Acct}/{Project}_{stg1}-{ownr}"
#       {GitHub_Acct}              /{Project}_{stg1}-{ownr}"

#   -------------------------------- Parse GitHub URL arg -----

awkPgm='
BEGIN { bDebug = 0;                               aSSH = "yes" }

       /http/       { sub( /https?:\/\//,   "" ); aSSH = "no"  }
            bDebug  { print "\n  1    $0: " $0 ", aSSH: " aSSH }

       /\.git/      { sub( /\.git/, "" ) } { sub( /:\//, ":" ) }  # .(21207.01.1 RAM Remove :/)
       /github.com/ { sub( /github.com\//, "" ) }
            bDebug  { print "  2    $0: " $0 }

#      /\//         { split( $0"/", m, /\// ); sub( /\/.+/, "" );  aRepo1 = m[2] ? m[2] : m[1]
                    { split( $0"/", m, /\// ); sub( /\/.+/, "" );  aRepo1 = m[2] ? m[2] : m[1];  aRepo = match( aRepo1, /^([a-zA-Z0-9_-]+)$/ ) ? aRepo1 : "{Project}";
        if (bDebug) { print "  3    $0: " $0 ", aRepo1: " aRepo1 }
                      split( $0":", m, /:/ ); if ( aSSH == "no" ) { aCert = "n/a"; aAcct = m[1] }
                                                            else { aCert = m[2] ? m[1] : "n/a";  aAcct = m[2] ? m[2] : "n/a"; aSSH = aCert == "n/a" ? "no" : aSSH } }
            bDebug  { print "  4 aRepo: " aRepo ", aCert: " aCert ", aAcct: " aAcct ", aSSH: " aSSH }

                    { split( aRepo"_", m, /_/ );                   aProj = ( m[1] != aAcct) ? m[1] : "{Project}";     aStge = m[2] ? m[2] : "{stg1}-{ownr}"
        if (bDebug) { print "  5 aProj: " aProj ", aStge: " aStge }
                      split( aStge"-", m, /-/ );                   aOwnr = m[2] ? "-" m[2] : ""; aStge = m[1] ? "_" m[1] : "" }
            bDebug  { print "  6 aProj: " aProj ", aStge: " aStge ", aOwnr: " aOwnr "\n" }

                    { print  "    " aAcct " " aProj " " aStge""aOwnr " " aSSH " " aCert }  # return "${aURL}"

END   { }'
#   --- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

    aURL="$( echo "${aPrj}" | awk "${awkPgm}" )";                                   #   echo "${aURL}"; exit
    echo  -e "   Parsed URL: '${aURL}'";  # exit

    aGitHub_Acct_arg="$( echo "${aURL}" | awk '{ print $1 }' )"
    aProj_arg="$(        echo "${aURL}" | awk '{ print $2 }' )"
    aStage_arg="$(       echo "${aURL}" | awk '{ print $3 }' )"; aStage_arg="${aStage_arg/_}"
    aGitHub_SSH_arg="$(  echo "${aURL}" | awk '{ print $4 }' )"
    aGitHub_Cert_arg="$( echo "${aURL}" | awk '{ print $5 }' )"

if [ "${aProj_arg}"        != "{Project}"     ]; then aPrj="${aProj_arg}"; fi

#f [ "${aStage_arg}"       == "{stg1}-{ownr}" ]; then aStage_var="${aStage_var}"; fi   ##.(21105.01.11)
#f [ "${aStage_arg}"       != "{stg1}-{ownr}" ]; then aStage_var="${aStage_arg}"; fi   ##.(21105.01.11)
                                                      aStage_var="${aStage_arg}"       # .(21105.01.11)

if [ "${aGitHub_Cert_arg}" != "n/a"           ]; then aGitHub_Cert_var="${aGitHub_Cert_arg}"; fi
if [ "${aGitHub_Acct_arg}" != "n/a"           ]; then aGitHub_Acct_var="${aGitHub_Acct_arg}"; fi
                                                      aGitHub_SSH_var="${aGitHub_SSH_arg}";
    fi  # eif "${bParse}" == "1"                                                                            # .(21101.01.5 RAM End)
#   -----------------------------------------------------------

# if [ "${aRepoDir}" == "" ]; then aRepoDir="${aStage_var}"; fi                                             # .(21118.02.2)

    aProj="$( echo "${aPrj}" | tr '[:upper:]' '[:lower:]' )"                                                # .(21101.02.1 RAM End)
if [ "$2" != "" ]; then                                                                                     # .(21207.01.1 RAM Beg Parse aArg2)
    aPrjN="$( echo "$2" | awk '{ split( $0"/", m, "/" ); print m[1] }' )"; echo "  aPrjN: ${aPrjN}"
    aStge="$( echo "$2" | awk '{ split( $0"/", m, "/" ); print m[2] }' )"; 
    if [ "${aStge}" == "" ]; then aStge=${aStage_var}; fi; echo "  aStge: ${aStge}"
    aRepoDir="${aPrjN}/${aStge}"; 
    aPrjN=${aPrjN/_}; if [ "${aPrjN}" == "$2" ]; then aRepoDir="${aPrjN}"; fi 
  else 
    aPrjN="${aPrj/_}"; 
    aRepoDir="${aPrjN/}_${aStage_var}"
    fi                                                                                                      # .(21207.01.1 RAM End)
    aRepo="${aPrj/_}_${aStage_var}"                                                                         # .(21207.01.2 RAM Set here?) 

#   echo -e "   aRepo: '${aPrj/_}_${aStage_var}', aCert: '${aGitHub_Cert_var}', aAcct: '${aGitHub_Acct_var}', aSSH: '${aGitHub_SSH_var}'";  exit
    echo -e "   aPrjN: '${aPrjN}', aRepoDir: '${aRepoDir}', aRepo: '${aPrj/_}_${aStage_var}', aCert: '${aGitHub_Cert_var}', aAcct: '${aGitHub_Acct_var}', aSSH: '${aGitHub_SSH_var}'";  # exit

#   --- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#========================================================================================================== #  ===============================  #

# ------------------------------------------------------------------------------------
#
#        Determine Parent Folder, ${aPDir}
#
#====== =================================================================================================== #  ===========

         aDir="$( basename $( pwd ) )";        # echo "-- aPDir: ${aPDir}"
         aPDir=$( basename $( cd ..; pwd ) );  # echo "-- aPDir: ${aPDir}, aPrj: ${aPrj}"

 if [  "${aDir}" == "webs" ] || [  "${aDir}" == "nodeapps" ] || [  "${aDir}" != "Repos" ]; then aPDir="${aDir}"; fi
 if [ "${aPDir}" != "webs" ] && [ "${aPDir}" != "nodeapps" ] && [ "${aPDir}" != "Repos" ]; then aPDir=""; fi

 if [ "${aPDir}" == "" ] && [ "1" == "0" ]; then                                                            # .(21101.03.1 RAM Don't abort)

    echo ""
    echo "     ** The folder, '${aDir}', doesn't appear to be a /Repos or /webs folder."
    echo ""
    exit
    fi                                                                                                      # .(21101.02.1 RAM End)
#   -----------------------------------------

function askYN() {                                                                                          # .(21202.02.1 RAM Beg Add askYN)
         echo    "  $1"
         read -p "     Enter Yes or No: [y/n]: " aAnswer
#        aAnswer=$( echo ${aAnswer} | awk '/^[ynYN]+$/' )
         aAnswer=$( echo ${aAnswer} | awk '/^[ynYN](es|o)*$/' )                                             # .(21202.02.11 RAM Allow Yes or No answers)
 if [ "${aAnswer}" == "" ]; then echo "  * Please answer with y or n."; exit; fi
         aAnswer=$( echo ${aAnswer} | awk '/^[yY](es)*$/ { print "y" }' )
 if [ "${aAnswer}" != "y" ]; then aAnswer="n"; fi

         } # eof askYN                                                                                      # .(21202.02.1 RAM End)
#   -----------------------------------------

                                                 aConfigFile=""                                                      ##.(21127.01.1 RAM Beg)
#if [ -f "../../gitr_${aProj}-config.sh" ]; then aConfigFile="../../gitr_${aProj}-config.sh";  aCurDir="../../"; fi
#if [ -f "../../gitr_${aProj}_config.sh" ]; then aConfigFile="../../gitr_${aProj}_config.sh";  aCurDir="../../"; fi  # .(21029.03.1 RAM)
#if [ -f "../../gitr_${aProj}config.sh"  ]; then aConfigFile="../../gitr_${aProj}config.sh";   aCurDir="../../"; fi
#if [ -f    "../gitr_${aProj}-config.sh" ]; then aConfigFile="../gitr_${aProj}-config.sh";     aCurDir="../"; fi
#if [ -f    "../gitr_${aProj}_config.sh" ]; then aConfigFile="../gitr_${aProj}_config.sh";     aCurDir="../"; fi     # .(21029.03.2)
#if [ -f    "../gitr_${aProj}config.sh"  ]; then aConfigFile="../gitr_${aProj}config.sh";      aCurDir="../"; fi
#if [ -f       "gitr_${aProj}-config.sh" ]; then aConfigFile="gitr_${aProj}-config.sh"; fi;    aCurDir="./"
#if [ -f       "gitr_${aProj}_config.sh" ]; then aConfigFile="gitr_${aProj}_config.sh"; fi;    aCurDir="./"          # .(21029.03.3)
#if [ -f       "gitr_${aProj}config.sh"  ]; then aConfigFile="gitr_${aProj}config.sh"; fi;     aCurDir="./"          ##.(21127.01.1 RAM End)

                                                 aConfigFile="";                                                     # .(21205.03.1).(21207.01.3 RAM Set Above)
#                                                aConfigFile=""; aPrjN="${aPrj}"                                     # .(21127.01.2 RAM Beg Change Config file name).(21205.03.1)
 if [ -f "../../${aPrjN}_gitR-config.sh" ]; then aConfigFile="../../${aPrjN}_gitR-config.sh";  aCurDir="../../"; fi  # .(21205.03.2 RAM Beg Use Uppercase PrjN)
 if [ -f "../../${aPrjN}_gitR_config.sh" ]; then aConfigFile="../../${aPrjN}_gitR_config.sh";  aCurDir="../../"; fi  # .(21029.03.1 RAM)
 if [ -f    "../${aPrjN}_gitR-config.sh" ]; then aConfigFile="../${aPrjN}_gitR-config.sh";     aCurDir="../"; fi
 if [ -f    "../${aPrjN}_gitR_config.sh" ]; then aConfigFile="../${aPrjN}_gitR_config.sh";     aCurDir="../"; fi     # .(21029.03.2)
 if [ -f       "${aPrjN}_gitR-config.sh" ]; then aConfigFile="${aPrjN}_gitR-config.sh"; fi;    aCurDir="./"
 if [ -f       "${aPrjN}_gitR_config.sh" ]; then aConfigFile="${aPrjN}_gitR_config.sh"; fi;    aCurDir="./"          # .(21029.03.3).(21127.01.2 RAM End).(21205.03.2 RAM End)

 if [ "${aWebsDir}" == "" ]; then
#   aWebsDir=$( basename $( ls -1 ${aCurDir} ) )
#   aWebsDir=$( dirname ${aConfigFile} )
    aWebsDir=$( builtin cd ${aCurDir}; pwd )
#   aWebsDir="/C/WEBs/8020/VMs/et217p_formR0/webs"
#   aWebsDir="/C/Repos"
#   aWebsDir="/webs"

#   echo "   Setting aWebsDir: '${aWebsDir}', aCurDir: ${aCurDir}"
    fi
# ------------------------------------------------------------------------------------
#
#====== =================================================================================================== #  ===========
#
#        Create new "${aPrj}_gitr-config.sh", file
#
#====== =================================================================================================== #  ===========

    echo "   Setting: aWebsDir: '${aWebsDir}',   aCurDir: ${aCurDir}, aPrjN: ${aPrjN}, aRepoDir: '${aRepoDir}'"; # exit

                                                 aConfigFile="${aConfigFile/_-/_}"
 if [ "${aConfigFile}" == "" ]; then                                                        # .(21127.01.3 RAM It wasn't found above)
#        aConfigFile=gitr_${aProj}-config.sh;    aConfigFile="${aConfigFile/_-/_}"          ##.(21127.01.4)
#        aConfigFile=${aProj}_gitr-config.sh;    aConfigFile="${aConfigFile/_-/_}"          ##.(21127.01.4 RAM Create one with this name).(21205.03.3)
         aConfigFile=${aPrjN}_gitR-config.sh;    aConfigFile="${aConfigFile/_-/_}"          # .(21205.03.3)

    if [ "${bDoit}" != "1" ]; then                                                          # .(21101.02.1)
#   echo ""
#   echo "   Syntax: gitr clone {Project} [-all] [-doit]"
    echo ""
    echo "     ** Config file, '${aConfigFile}', not found."
    echo ""
    fi                                                                                      # .(21101.02.2)
# ------------------------------------------------------------------------------------

                                              bDir=1;              c1="#"; c2="#"       # 1 /webs/prj  or /webs/prj_                            # .(21029.03.4 RAM Beg)
    if [ "${aDir/_}"  != "${aPrj/_}"  ]; then bDir=0;                                   # 0 /webs
    if [ "${aPrj/_}"  == "${aPDir/_}" ]; then bDir=3; fi; else                          # 3 /webs/prj/stg
    if [ "${aDir/_}"  == "${aDir}"    ]; then bDir=2; fi; fi;      c3="#"; c4="#"       # 2 /webs/prj

#   echo "aPrj: ${aPrj}, aStage_var: '${aStage_var}', aDir: ${aDir}, aPDir: ${aPDir}, bDir: ${bDir}; '${c1}${c2}${c3}${c4}'"

    if [ "${bDir}" == "0" ] && [ "${aPrj/_}_" == "${aPrj}" ]; then c1=" "; fi;          # 1 /webs/prj_stg   # 1 gitr_{Project}_config.sh
    if [ "${bDir}" == "3" ] && [ "${aPrj/_}_" == "${aPrj}" ]; then c2=" "; c1="#"; fi;  # 2 /webs/prj_/stg  # 2 gitr_{Project}_stg-config.sh
    if [ "${bDir}" == "1" ] && [ "${aPrj/_}_" == "${aPrj}" ]; then c2=" "; fi;          # 2 /webs/prj_/stg  # 2 gitr_{Project}_stg-config.sh

#   if [ "${bDir}" == "0" ] && [ "${aPrj/_}"  == "${aPrj}" ]; then c3=" "; fi;          # 3 /webs/prj       # 3 gitr_{Project}-config.sh
    if [ "${bDir}" == "0" ] && [ "${aPrj/_}"  == "${aPrj}" ]; then c1=" "; fi;          # 3 /webs/prj       # 3 gitr_{Project}-config.sh
    if [ "${bDir}" == "2" ] && [ "${aPrj/_}"  == "${aPrj}" ]; then c3=" "; c1="#"; fi;  # 3 /webs/prj       # 3 gitr_{Project}-config.sh
    if [ "${bDir}" == "1" ] && [ "${aPrj/_}"  == "${aPrj}" ]; then c4=" "; fi;          # 4 /webs/prj/stg   # 4 gitr_{Project}-stg-config.sh    # .(21029.03.4 RAM End)

#   echo "aPrj: ${aPrj}, aStage_var: '${aStage_var}', aDir: ${aDir}, aPDir: ${aPDir}, bDir: ${bDir}; '${c1}${c2}${c3}${c4}', aConfigFile: '${aConfigFile}'" ; # exit

#   if [ "${bDir}" == "1" ] && [ "${bParse}"      == "1 "  ]; then c1=" "; c4="#"; fi;  # 1 /webs/prj_stg   # 1 gitr_{Project}_config.sh  ##.(21105.05.1)
    if [ "${bDir}" == "1" ] && [ "${bParse}${c4}" == "1 "  ]; then c1=" "; c4="#"; fi;  # 1 /webs/prj_stg   # 1 gitr_{Project}_config.sh  # .(21105.05.1 RAM Set c1 only if c4 was set)
    if [ "${bDir}" == "1" ] && [ "${bParse}${c4}" == "1#"  ]; then c2=" "; c1="#"; fi;  # 1 /webs/prj_stg   # 1 gitr_{Project}_config.sh  ##.(21105.05.2 RAM Set c2, if c4 was not set, or just keep it set to c2)

    if [ "${aStage_var}" == "{stg1}-{ownr}" ]; then aStage_var="";         c3=" "; c1="#"; c2="#"; c4="#"; fi   # .(21105.01.1 RAM If no ${aStage}).(21105.04.2)

    if [ "${aRepoDir}"   == ""              ]; then                        c5="#";
                                               else                        c5=" "; c3="#"; c1="#"; c2="#"; c4="#"; fi

#   echo "   aPrj: '${aPrj}', aStage_var: '${aStage_var}', aDir: ${aDir}, aPDir: ${aPDir}, bDir: ${bDir}; '${c1}${c2}${c3}${c4}', aConfigFile: '${aConfigFile}'" ; # exit

    if [ "${bDir}" == "1" ]; then aWebsDir=$( builtin cd ..; pwd ); fi                                      # .(21105.04.1 RAM Always set to /webs)

              aRepo="${aPrj/_}_${aStage_var}"                                                               # .(21106.01.6 RAM Beg).(21207.01.x RAM Set Above)
              aGitHub_URL2="http://gitHub.com/\${GitHub_Acct}"
      if [ "${aGitHub_SSH_var}" == "yes" ]; then
              aGitHub_URL2="${aGitHub_Cert_var}:${aGitHub_Acct_var}"
              fi                                                                                            # .(21106.01.6 RAM End)
    echo "#!/bin/bash"                                                                  > "${aConfigFile}"  # .(21029.02.1 RAM Beg Create it if not found)
    echo ""                                                                             >>"${aConfigFile}"
    echo "    Project=\"${aPrjN/_}\""                                                   >>"${aConfigFile}"
#   echo "    Stage=\"{stg1}-{owner}\""                                                 >>"${aConfigFile}"
#   echo "    GitHub_Acct=\"github-{usr}:{account}\""                                   >>"${aConfigFile}"
    echo "    Stage=\"${aStage_var}\""                                                  >>"${aConfigFile}"
    echo "    GitHub_Acct=\"${aGitHub_Acct_var}\""                                      >>"${aConfigFile}"
    echo "    GitHub_Cert=\"${aGitHub_Cert_var}\""                                      >>"${aConfigFile}"
    echo "    GitHub_SSH=\"${aGitHub_SSH_var}\""                                        >>"${aConfigFile}"
    echo ""                                                                             >>"${aConfigFile}"
if [ "$c5" == "#" ]; then
    echo "$c1   RepoDir=\"\${Project}_\${Stage}\"     # 1 {Project}_gitR_config.sh"     >>"${aConfigFile}"
    echo "$c2   RepoDir=\"\${Project}_/\${Stage}\"    # 2 {Project}_gitR_stg-config.sh" >>"${aConfigFile}"
    echo "$c3   RepoDir=\"\${Project}\"              # 3 {Project}_gitR-config.sh"      >>"${aConfigFile}"
    echo "$c4   RepoDir=\"\${Project}/\${Stage}\"     # 4 {Project}_gitR-stg-config.sh" >>"${aConfigFile}";
    echo ""; fi
if [ "$c5" == " " ]; then
    echo "    RepoDir=\"${aRepoDir}\""                                                  >>"${aConfigFile}";
    fi                                                                                  >>"${aConfigFile}"
    echo ""                                                                             >>"${aConfigFile}"
    echo "    WebsDir=\"${aWebsDir}\""                                                  >>"${aConfigFile}"
    echo "    GitHub_URL=\"http://gitHub.com/\${GitHub_Acct}/${aRepo}\""                >>"${aConfigFile}"  # .(21106.01.7 RAM Add these)
    echo "    GitHub_Cmd=\"git clone ${aGitHub_URL2}/${aRepo}.git  ${aRepoDir}\""       >>"${aConfigFile}"  # .(21106.01.8)
#   echo "#   WebsDir=\"/webs\""                                                        >>"${aConfigFile}"
    echo ""                                                                             >>"${aConfigFile}"
#   echo "    Apps+=(  \"/._2/\" )"                                                     >>"${aConfigFile}"  # .(21202.02.2 RAM Beg Push paths into Apps array).(21202.02.21 Must use ()s)
    echo "    Apps+=( \"/client1/\" )"                                                  >>"${aConfigFile}"
    echo "    Apps+=( \"/server1/\" )"                                                  >>"${aConfigFile}"
    echo "    Apps+=( \"/README.md\" )"                                                 >>"${aConfigFile}"
    echo "    Apps+=( \"/code-workspace\" )"                                            >>"${aConfigFile}"
#   echo "    Apps+=( \"/client1/1c1_my-html-custom-app/\" )"                           >>"${aConfigFile}"
#   echo "    Apps+=( \"/client1/2c1_my-html-remote-app/\" )"                           >>"${aConfigFile}"  # .(21202.02.2 RAM End).(21202.02.21)
    echo ""                                                                             >>"${aConfigFile}"
    echo "# - ------------------------------------------------"                         >>"${aConfigFile}"  # .(21130.01.2)
    echo ""                                                                             >>"${aConfigFile}"
    echo "    export aProject=\"\${Project}\""                                          >>"${aConfigFile}"
    echo "    export aStage=\"\${Stage}\""                                              >>"${aConfigFile}"
    echo "    export aRepo=\"\${Project}_${Stage}\"         # Edit ? "                  >>"${aConfigFile}"  # .(21202.02.3 RAM Add aRepo=)
    echo "    export aRepoDir=\"\${RepoDir}\""                                          >>"${aConfigFile}"
    echo "    export aWebsDir=\"\${WebsDir}\""                                          >>"${aConfigFile}"
    echo "    export aGitHub_Acct=\"\${GitHub_Acct}\""                                  >>"${aConfigFile}"
    echo "    export aGitHub_Cert=\"\${GitHub_Cert}\""                                  >>"${aConfigFile}"
    echo "    export aGitHub_SSH=\"\${GitHub_SSH}\""                                    >>"${aConfigFile}"
    echo "    export Apps"                                                              >>"${aConfigFile}"
    echo ""                                                                             >>"${aConfigFile}"  # .(21029.02.1 RAM End)

#   -----------------------------------------

    if [ "${bDoit}" != "1" ]; then                                                          # .(21101.02.3 RAM Continue if bDoit)

    echo "  You can edit the vars above in the 'gitR config' file just created, e.g."
    echo "    Stage, GitHub_Acct and Apps, as appropriate.  You can also set GitHub_SSH"    # .(21202.02.4)
    echo "    to yes and provide the GitHub_Cert to update, i.e. push, your repository."    # .(21202.02.4)
    echo ""
    echo "-------------------------------------------------------------------------------"
#    cat   "${aConfigFile}" | awk 'NR <= 20 { print "  " $0 }'                              ##.(21130.01.1 RAM).(21130.01.11)
     cat   "${aConfigFile}" | awk '/# - -/ { exit } { print "  " $0 }'                      # .(21130.01.11 RAM May be on a different line)
    echo "-------------------------------------------------------------------------------"
    echo ""
    if [ "${aGitHub_SSH_var:0:1}" == "{" ]; then                                            # .(21207.02.4 RAM Beg No Doit option)
          askYN "Do you want to edit this gitR config file before cloning this Repo: ${aRepo}?";  # .(21202.02.7)
          if [ "${aAnswer}" == "n" ]; then ${aLstSp}; exit; fi
          if [ "${aAnswer}" == "y" ]; then aAnswer="e"; fi 
       else                                                                                 # .(21207.02.4 RAM End)
#   echo "  Opening nano for you to make edits to: ${aConfigFile},:"                        ##.(21202.02.5)
    echo "  Do you want to get the clone now or use nano to edit '${aConfigFile}':"         # .(21202.02.5 RAM Beg)
#   read -s -n 1 -p "     Press any key, or CTRC-C to bypass.  "; echo ""
    read         -p "    Please enter Edit, Doit or None: [e/d/n]: " aAnswer                # .(21206.01.1 RAM Beg Three choices)
         aAnswer="$(   echo "${aAnswer}" | awk '/^[ednEDN](dit|oit|one)*$/' | tr '[:upper:]' '[:lower:]' )"
 if [ "${aAnswer}" == "" ]; then echo "  * Please answer with e, d or n."; aAnswer="n"; fi
 
      fi # eif                                                                              # .(21207.02.2)
 
 if [ "${aAnswer:0:1}" == "n" ]; then
         rm "${aConfigFile}"
         ${aLstSp}; exit
         fi
 if [ "${aAnswer:0:1}" == "e" ]; then                                                       # .(21206.01.1 RAM End)
         nano "${aConfigFile}"; echo ""
         echo "  Then run the command again, gitr clone ${aPrjN} to view the revised settings."   # .(21202.02.5 RAM End)
         ${aLstSp}; exit
         fi                                                                                 # .(21206.01.2 RAM Beg)
 if [ "${aAnswer:0:1}" == "d" ]; then
         bDoit="1"
         fi                                                                                 # .(21206.01.2 RAM End)
#  -----------------------------------------

    source  "${aConfigFile}"                                                                # .(21204.01.24 RAM Beg)

 if [ -d "${aWebsDir}/${aRepoDir}/.git" ]; then                                             # .(21206.03.1 RAM May not be created yet)

    echo           "${mApps[0]}"   >"${aWebsDir}/${aRepoDir}/.git/info/sparse-checkout"
for (( i=1; i<=$(( ${#mApps[*]} - 1 )); i++ )); do
    echo           "${mApps[$i]}" >>"${aWebsDir}/${aRepoDir}/.git/info/sparse-checkout"
    done                                                                                    # .(21204.01.24 RAM End)

#   ${aLstSp}; exit
    fi # eif -d "${aWebsDir}/${aRepoDir}/.git"                                              # .(21206.03.2)
#   -----------------------------------------
    fi                                                                                      # .(21101.02.4)
#   -----------------------------------------
    fi # eif bDoit == 0, unless aAnswer is Doit
#   ---------------------------------------------------------------------------------------------------------------------

#====== =================================================================================================== #  ===========
#
#        Update "${aPrj}_gitr-config.sh", file
#
#====== =================================================================================================== #  ===========

if [ "${bParse}" == "1" ]; then                                                             # .(21105.03.0 Update config file)

    aTS=$( date '+%y%m%d.%H%M' ); aTS=${aTS:1}
    cp -p "${aConfigFile}" "${aConfigFile/.sh}_v${aTS}.sh"

                                                    aRepoDir_arg="\${Project}_/\${Stage}";   # .(21105.03.1)
    if [ "${aPrj/_}_" != "${aDir}" ];          then aRepoDir_arg="\${Project}_\${Stage}"; fi # .(21105.03.2)
    if [ "${aStage_arg}" == "{stg1}-{ownr}" ]; then aRepoDir_arg="\${Project}"; fi           # .(21105.03.3)
    if [ "${aStage_arg}" == "{stg1}-{ownr}" ]; then aStage_arg=""; fi                        # .(21105.01.2 RAM Here too)

awkPgm='
BEGIN { }
    /    Stage=/                                           { print "    Stage=\"'${aStage_arg}'\""            ; next }
    /    GitHub_Acct=/ && "'${aGitHub_Acct_arg}'" != "n/a" { print "    GitHub_Acct=\"'${aGitHub_Acct_arg}'\""; next }
    /    GitHub_Cert=/ && "'${aGitHub_Cert_arg}'" != "n/a" { print "    GitHub_Cert=\"'${aGitHub_Cert_arg}'\""; next }
    /    GitHub_SSH=/                                      { print "    GitHub_SSH=\"'${aGitHub_SSH_arg}'\""  ; next }
    /    RepoDir=/                                         { print "#   " substr( $0, 5)                                # .(21105.03.4)
                                                             print "    RepoDir=\"'${aRepoDir_arg}'\""        ; next }  # .(21105.03.5)
                                                           { print }
      { }
END   { }'

    cat "${aConfigFile/.sh}_v${aTS}.sh" | awk "${awkPgm}" >"${aConfigFile}"

    echo -e "\n * Config file, '${aConfigFile}', updated."

#   echo -e "\n-------------------------------------"; cat "${aConfigFile}"; echo -e "-------------------------------------\n"

    if [ "${bDoit}" != "1" ]; then                                                          # .(21101.02.5)

       $0 "${aPrj}"                                                                         # .(21105.02.1 RAM Show updated config)
       echo ""; exit                                                                        # .(21127.08.5)
    fi                                                                                      # .(21101.02.6)
#   -----------------------------------------
    fi
#   ---------------------------------------------------------------------------------------------------------------------

#====== =================================================================================================== #  ===========
#
#        Set vars in "${aConfigFile}", file
#
#====== =================================================================================================== #  ===========

#   source  "gitr_${aProj}-config.sh"
    source  "${aConfigFile}";

#   echo "----- source  \"${aConfigFile}\", aRepo: '${aRepo}'"; # exit
#   echo "aWebsDir: ${aWebsDir}"; exit

if [ "${aStage_arg}"       != "" ]; then aStage="${aStage_arg}"; fi
if [ "${aGitHub_Acct_arg}" != "" ]; then aGitHub_Acct="${aGitHub_Acct_arg}"; fi
if [ "${aGitHub_Cert_arg}" != "" ]; then aGitHub_Cert="${aGitHub_Cert_arg}"; fi
if [ "${aGitHub_SSH_arg}"  != "" ]; then aGitHub_SSH="${aGitHub_SSH_arg}"; fi

    bSSH=$( echo "${aGitHub_SSH}" | awk '/yes|Yes|YES/ { print "1"; }' ); if [ "${bSSH}" != "1" ]; then bSSH="0"; fi
#   bSSH=$( echo "${aGitHub_SSH}" | awk '/yes|Yes|YES/ { print "1"; exit }; { print "0" }' ); if [ "${bSSH}" != "1" ]; then bSSH="0"; fi

    aGitHub_URL="${aGitHub_Cert}:${aGitHub_Acct}"
if [ "${bSSH}" == "0" ]; then
    aGitHub_URL="https://github.com/${aGitHub_Acct}"
    fi
#   echo -e "\n  aGitHub_URL: ${aGitHub_URL}/${aProject}_${aStage}\n"; # exit

#   -----------------------------------------------------------------

                                        bCone=0;
 if [ "${aWebsDir:0:2}" == "/C" ]; then bCone=1; fi  # Get files in root folder

#for (( i=0; i <= $(( ${#Apps[*]}  - 1 )); i++ )); do mApps[$i]=${Apps[$i]}; done                           ##.(21105.03.x Set vars from config file) ).(21202.02.22)
#for (( i=0; i <= $(( ${#Apps[@]}  - 1 )); i++ )); do mApps[$i]=${Apps[$i]}; done                           ##.(21105.03.x Set vars from config file) ).(21202.02.22)
 for (( i=0; i <= $(( ${#Apps[@]}  - 1 )); i++ )); do mApps+=( ${Apps[$i]} ); done                          # .(21105.03.x Set vars from config file) ).(21202.02.22)

 if [ "${aRepo}" == "" ]; then                                                                              # .(21202.02.6 RAM Beg Use if set in config file)
    aRepo=${aProject}_${aStage}; if [ "${aStage}" == "" ]; then aRepo=${aProject}; fi                       # .(21105.01.3 RAM Get rid of _)
    fi
    aRepo="$( echo "${aRepo}" | awk '{ sub( /_$/, "" ); print }' )"                                         # .(21105.01.4)

#   ---------------------------------------------------------------------------------------------------------------------

#====== =================================================================================================== #  ===========
#
#        Show and/or edit vars in "${aConfigFile}", file
#
#====== =================================================================================================== #  ===========

 if [ "${bDoit}" == "0" ]; then

#   --------------------------------------------------------------------------

 if [ "${bEdit}" == "1" ]; then                                                                             # .(21204.01.25 RAM Beg Add Edit command)

    sBug=${bDebug};
 if [ "${sBug}" == "1" ]; then

    echo  -e "\n      ${aConfigFile}"
    echo       "  --- ---------------------------------------------"
#   cat "${aConfigFile}" | awk            '/    Apps/   { gsub( /[")]/, ""); print "      " (i++) ") " substr( $0, 12 ) }'
    cat "${aConfigFile}" | awk '/#/ { next }; / Apps\+/ { gsub( /[(+=")]/, "" ); sub( /^ +Apps +/, ""); printf "     %2d) %s\n", i++, $0  }'

    echo  -e "\n      .git/info/sparse-checkout"
    echo       "  --- ---------------------------------------------"
 if [ -d "${aWebsDir}/${aRepoDir}/.git/info/sparse-checkout" ]; then                                        # .(21204.01.31 RAM Check if exists)
    cat  "${aWebsDir}/${aRepoDir}/.git/info/sparse-checkout" | awk '{ printf "     %2d) %s\n", NR-1, $0 }'
  else                                                                                                      # .(21204.01.32)
    echo "      0)"                                                                                         # .(21204.01.33)
    fi                                                                                                      # .(21204.01.34)

    echo ""
    fi  # eif sBug

 if [ "${sBug}" == "1" ]; then ls -l "${aConfigFile}"; fi

    nano  "${aConfigFile}"

 if [ "${sBug}" == "1" ]; then ls -l "${aConfigFile}"; fi

#source   "${aConfigFile}"
#   mApps=$(                 cat "${aConfigFile}" | awk '/#/ { next }; / Apps+=/ { gsub( /[(+=")]/, "" ); sub( /^ +Apps +/, ""); print $0 }' )
    readarray -t  mApps < <( cat "${aConfigFile}" | awk '/#/ { next }; / Apps\+/ { gsub( /[(+=")]/, "" ); sub( /^ +Apps +/, ""); print $0 }' )

 if [ "${sBug}" == "1" ]; then
    echo -e "\n      \${mApps[@]}  (source: ${aConfigFile})"
    echo      "  --- ---------------------------------------------------------------------------------------------------"
    echo -e    "      ${mApps[@]}\n"

    echo      "      \${mApps[i]} >>.git/info/sparse-checkout"
    echo      "  --- ---------------------------------------------"
    echo   "      0)  ${mApps[0]}"
  for (( i=1; i<=$(( ${#mApps[*]} - 1 )); i++ )); do
    echo  "      $i)  ${mApps[$i]}"
    done

#   echo -e "\n  --- ${aWebsDir}/${aRepoDir}/.git/info/sparse-checkout"
#   echo -e "\n  --- .git/info/sparse-checkout"
    fi

 if [ -d "${aWebsDir}/${aRepoDir}/.git" ]; then                                             # .(21206.03.3)
    echo             "${mApps[0]}"   >"${aWebsDir}/${aRepoDir}/.git/info/sparse-checkout"
  for (( i=1; i<=$(( ${#mApps[*]} - 1 )); i++ )); do
    echo             "${mApps[$i]}" >>"${aWebsDir}/${aRepoDir}/.git/info/sparse-checkout"
    done
  else                                                                                      # .(21206.03.4 RAM Beg)
    echo -e "\n  After cloning this repository, you can limit files and folders to the Sparse Apps list."
    exit
    fi                                                                                      # .(21206.03.4 RAM End)

 if [ "${sBug}" == "0" ]; then
    echo -e "\n  To reapply sparse files and folder list:\n"
    cat  "${aWebsDir}/${aRepoDir}/.git/info/sparse-checkout" | awk '{ printf "    %2d) %s\n", NR-0, $0 }'

  else
    echo -e "\n  To reapply sparse files and folder list: (.git/info/sparse-checkout)"; echo      "  --- ---------------------------------------------"
    cat  "${aWebsDir}/${aRepoDir}/.git/info/sparse-checkout" | awk '{ printf "     %2d) %s\n", NR-1, $0 }'

    echo -e "\n      ${aConfigFile}"
    echo      "  --- ---------------------------------------------"
#   cat "${aConfigFile}" | awk            '/    Apps/ { gsub( /[")]/, ""); print "      " (i++) ") " substr( $0, 12 ) }'
    cat "${aConfigFile}" | awk '/#/ { next }; / Apps\+/ { gsub( /[(+=")]/, "" ); sub( /^ +Apps +/, ""); printf "     %2d) %s\n", i++, $0 }'
    fi

    echo -e "\n  Run: gitr sparse refresh"

    ${aLstSp}; exit

    fi  # eif sparse edit                                                                                   # .(21204.01.25 RAM End)
#   --------------------------------------------------------------------------

    echo ""
#   echo "  The file, ${aCurDir}gitr_${aProj}-config.sh, contains:"
    echo "  The file, ${aConfigFile}, contains:"
    echo "  -------------------------------------------------------------------------------"
    echo "#!/bin/bash"                                                                                      # .(21206.02.0)
    echo ""
    echo "      Project=\"${aProject}\""                                                                    # .(21206.02.1 RAM Make the same as when created)
    echo "      Stage=\"${aStage}\""                                                                        # .(21206.02.2)
#   echo ""

#        aAll="";          aCone="only those files in {Apps[i]} folders in Repo: ${aProject}_${aStage}"     ##.(21105.01.4)
         aAll="";          aCone="only those files in the {Apps[i]} folders from Repo: ${aRepo}"            # .(21105.01.4 RAM Was: ${aProject}_${aStage})
 if [ "${bCone}" == "1" ]; then aCone="all files in the Repo root folder (i.e. bCone=1), and\n         ${aCone:5} "; fi
 if [ "${bAll}"  == "1" ]; then aCone="all files in all folders from Repo : ${aRepo}"; aAll="-all "; fi     # .(21105.01.5)

    echo "      GitHub_Acct=\"${aGitHub_Acct}\""                                                            # .(21206.02.3)
    echo "      GitHub_Cert=\"${aGitHub_Cert}\""                                                            # .(21206.02.4)
    echo "      bCone:   ${bCone},  bAll: ${bAll};  bSSH: ${bSSH}"
    echo ""
    echo "      RepoDir=\"${aRepoDir}\""                                                                    # .(21206.02.5)
    echo "      WebsDir=\"${aWebsDir}\""                                                                    # .(21206.02.6)
    echo "      Git_URL=\"http://gitHub.com/${aGitHub_Acct}/${aRepo}\""                                     # .(21105.01.7).(21202.02.12 RAM Move here).(21206.02.7)
    echo "      Git_Cmd=\"git clone ${aGitHub_URL}/${aRepo}.git  ${aRepoDir}\""                             # .(21105.01.6).(21202.02.13).(21206.02.8)
    echo ""
#   echo "    Apps[1]: ${mApps[1]}"

#   for aApp in "${mApps[@]}"; do  echo "  ${aApp}"; done
    for (( i=0; i <= $(( ${#mApps[@]} - 1 )); i++ )); do
#   echo "      Apps[$(( $i + 1 ))]: ${mApps[ $i ]}"                                                        ##.(21202.02.14)
    echo "      Apps+=( \"${mApps[ $i ]}\" )"                                                               # .(21202.02.14 RAM Change Array Assignment).(21202.02.23).(21206.02.9)
    done

    echo ""
    echo "  -------------------------------------------------------------------------------"

#   echo "-- aArg1: ${aArg1}; aArg2: ${aArg2}, bDoit: ${bDoit}"; exit          

    askYN "Do you want to edit this gitR config file before cloning this Repo: ${aRepo}?";                  # .(21202.02.7)
         if [ "${aAnswer}" == "y" ]; then nano "${aConfigFile}"; fi             # .(21202.02.8)
    echo ""                                                                     # .(21202.02.9)
    echo -e "  To clone ${aCone}"
    echo ""
    echo    "    Run: gitr clone ${aPrjN} ${aAll}-doit"                         # .(21127.08.3 RAM Uppercase Project)

    exit # ${aLstSp}; exit                                                      # .(21127.08.4)
    fi
#   ---------------------------------------------------------------------------------------------------------------------

#====== =================================================================================================== #  ===========
#
#        Backup ${aRepoDir} folder
#
#====== =================================================================================================== #  ===========

#   echo "Using Gitr config file: ${aConfigFile}"
#   echo "aWebsDir: ${aWebsDir}"; echo "aCurDir was $( pwd )"; exit             ##.(21206.04.2) 
    cd "${aWebsDir}"                                                            # .(21206.04.2 RAM ??) 

#   -----------------------------------------------------------------

    bCpy=1; bZip=0

 if [ -d "${aRepoDir}/.git" ] && [ "${bCpy}" == "1" ]; then                     # .(21029.01.1 RAM Beg Copy repo to ${aRepoDir}_v${aTS})

    aTS=$( date '+%y%m%d.%H%M' ); aTS=${aTS:1}
    if [ ! -d "${aRepoDir}_v${aTS}" ]; then mkdir  "${aRepoDir}_v${aTS}"; fi    # .(21030.01.1 RAM Don't remove _)
    echo -e "\nBacking up to '${aWebsDir}/${aRepoDir}_v${aTS}'"
#   cp -pr "${aRepoDir}"/*  "${aRepoDir}_v${aTS}";
    cp -pa "${aRepoDir}"/.  "${aRepoDir}_v${aTS}";
    fi                                                                          # .(21029.01.1 RAM End)
#   -----------------------------------------------------------------

 if [ -d "${aRepoDir}/.git" ] && [ "${bZip}" == "1" ]; then                     # .(21029.01.2 RAM Beg Zip repo to ${aRepoDir}_v${aTS}.zip)

    aTS=$( date '+%y%m%d.%H%M' ); aTS=${aTS:1}
    aZipFile="${aRepoDir}_v${aTS}.zip"                                          # .(21030.01.2 RAM Don't remove _)
    if [ -f "${aZipFile}" ]; then rm "${aZipFile}"; fi
    echo -e "\nZiping into '${aZipFile}'"
    zip a -r -bt '-x!node_modules' "${aZipFile}" "${aRepoDir}" | awk '/to archive|size/ { print "  " $0 }; /Globa/ { print "  In " $4 " secs" }'
    fi                                                                          # .(21029.01.2 RAM End)
#   -----------------------------------------------------------------

    rm -fr "${aWebsDir}/${aRepoDir}"/*  2>/dev/null                                         # .(21026.01.1 RAM Delete all files in RepoDir).(21201.09.1 RAM Use full path)
    rm -fr "${aWebsDir}/${aRepoDir}"/.* 2>/dev/null.                                        # .(21201.09.2)

            aRDir="$( dirname $0)/../../JPTs/RSS/DirList/RSS22_DirList.sh"                  # .(21127.02.1 RDir may not exist).(21201.09.3)
 if [ -d "${aWebsDir}/${aRepoDir}" ]; then                                                  # .(21127.08.3 RAM check if folder is still there).(21201.09.4)
#           nCnt=$( ls -la "${aWebsDir}/${aRepoDir}" | awk '/total/ { print $2 }' )         ##.(21107.01.1 RAM Check if RepoDir contains files).(21201.09.5)
            nCnt=$( "${aRDir}" "${aWebsDir}/${aRepoDir}" | awk 'NR == 4 { print $1 }' )     # .(21107.01.1 RAM Check if RepoDir contains files).(21201.09.5)
#           echo " ---- $( pwd ), nCnt: ${nCnt}, ls -la \"${aWebsDir}/${aRepoDir}\""; # exit

    if [ "${nCnt}" != "0" ]; then

         echo -e "\n * The repo folder, ${aRepoDir} was not completey removed"

         cd "${aWebsDir}"                                                                   # .(21202.02.10)
         if [ -f "${aRDir}" ]; then "${aRDir}" "${aRepoDir}" 2 3 | awk '{ print "  " $0 }'; exit; fi  # .(21127.02.2 Show remaining files).(21201.09.6)
         exit
      fi                                                                                    # .(21127.08.3)
    fi
#   ---------------------------------------------------------------------------------------------------------------------

#====== =================================================================================================== #  ===========
#
#        Clone, i.e. replace ${aRepoDir} folder
#
#====== =================================================================================================== #  ===========

#   exit
    echo ""
    echo "Cloning ${aGitHub_URL}/${aRepo}.git"                                              # .(21105.01.8)

 if [ "${bAll}" == "1" ]; then

#   git clone               "${aGitHub_URL}/${aProject}_${aStage}.git"  "${aRepoDir}" 2>&1 | awk '{ print "   " $0 }'; nErr=$?  ##.(21105.01.9).(21129.02.2)
    git clone               "${aGitHub_URL}/${aRepo}.git"               "${aRepoDir}" 2>&1 | awk '{ print "   " $0 }'; nErr=$?  # .(21105.01.9).(21129.02.2)
#   git clone               "https://github.com/8020data/FRApps_prod-master.git"

    if [ "${nErr}" != "0" ]; then exit; fi

    cd "${aRepoDir}"

  else
    git clone --no-checkout "${aGitHub_URL}/${aRepo}.git"               "${aRepoDir}" 2>&1 | awk '{ print "   " $0 }'; nErr=$?  # .(21105.01.10).(21129.02.3)
#   git clone --no-checkout "github-ram:robinmattern/FRApps_prod-robin.git" FRApps;    nErr=$?

    if [ "${nErr}" != "0" ]; then exit; fi

    cd "${aRepoDir}"

    git sparse-checkout init             # same as init --cone
#   git sparse-checkout init --cone
#   git sparse-checkout init --sparse-index
#   git sparse-checkout init --no-sparse-index

#   echo ""
#   echo "git config --worktree core.sparse --- before -------------------------------------------------------"
#   git config --worktree -l | awk '/sparse|exten/ { print "   " $0 }'
#   git config --local    -l | awk '/sparse|exten/ { print "   " $0 }'

if [ "${bCone}" == "0" ]; then

    git config --worktree core.sparsecheckoutcone false    # Don't get files in root folder
    fi

    echo ""
    echo "git config --worktree core.sparse ---------------------------------------------------"
    git config --worktree  -l | awk '/sparse|exten/ { print "   " $0 }'                 # Display sparse settings
    git config --local     -l | awk '/sparse|exten/ { print "   " $0 }'

#   echo ""; exit

#   echo "-  git sparse-checkout set '${aRepoDir}/${mApps[0]}";
#   git sparse-checkout set "'${aRepoDir}/${mApps[0]}"
#   touch "${aWebsDir}/${aRepoDir}/.git/info/sparse-checkout "
    echo  "${mApps[0]}"   >"${aWebsDir}/${aRepoDir}/.git/info/sparse-checkout"          # .(21201.09.7)

for (( i=1; i<=$(( ${#mApps[*]} - 1 )); i++ )); do
#   echo "-  git sparse-checkout add '${aRepoDir}/${mApps[$i]}'"
#   git sparse-checkout add "'${aRepoDir}/${mApps[$i]}"                                 ##.(21201.09.8)
    echo  "${mApps[$i]}" >>"${aWebsDir}/${aRepoDir}/.git/info/sparse-checkout"          # .(21201.09.8)
    done

#   git sparse-checkout add ".code-workspace"   # root files pulled due to --cone
#   git sparse-checkout add ".vscode/*"
#   git sparse-checkout add ".url"

#   git sparse-checkout add "/LICENSE"
#   git sparse-checkout add "/README.md"
#   git sparse-checkout add "/index.html"

    echo ""
    echo "cat .git/info/sparse-checkout -----------------------------------------------------------"
          cat .git/info/sparse-checkout | awk '{ print "   " $0 }'

#   echo ""; exit

    echo ""
    git checkout

    fi  # eif bAll == 0
#   ---------------------------------------------------------------------------------------------------------------------

#====== =================================================================================================== #  ===========
#
#        DirList ${aRepoDir}
#
#====== =================================================================================================== #  ===========

#   echo ""
#   rdir -r 9 "index"     | awk           'NF > 0 { print }'
#   rdir -r 9 "README.md" | awk 'NR > 3 && NF > 0 { print }'
#   rdir -r 9 "LICENSE"   | awk 'NR > 3 && NF > 0 { print }'

    rss dirlist 1 3 | awk '{ print "  " $0 }'

    echo -e "\n Be sure to change into your new Repo folder: cd ${aRepoDir}"
#   echo ""

#   -----------------------------------------------------------------

#   git sparse-checkout list

#   git sparse-checkout disable

#   git config --worktree core.sparsecheckout true
#   git sparse-checkout reapply

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


