#!/bin/bash
#*\
##=========+====================+================================================+
##RD         gitr               | Git Helper Tools
##RFILE    +====================+=======+===============+======+=================+
##FD   FRT22_gitR1.sh           |  66449|  5/08/22 16:10|  1169| p2.02-20508-1610
##FD   FRT22_gitR1.sh           |  67037|  5/04/22 19:40|  1178| p2.02-20504-1940
##FD   FRT22_gitR1.sh           |  66020|  5/03/22 19:15|  1165| p2.02-20503-1915
##FD   FRT22_gitR1.sh           |  65476|  5/03/22 14:11|  1164| p2.02-20503-1411
##FD   FRT22_gitR1.sh           |  64877|  5/03/22 09:17|  1155| p2.02-20503-0917
##FD   FRT22_gitR1.sh           |  66326|  5/01/22 20:53|  1173| p2.02-20501-2053
##FD   FRT22_gitR1.sh           |  66693|  5/15/22 13:06|  1174| p2.02-20515-1306
##FD   FRT22_gitR1.sh           |  69290|  6/23/22 13:03|  1227| p2.02-20623-1303
##FD   FRT22_gitR1.sh           |  67621|  6/25/22 14:45|  1179| p2.02-20625-1445
##FD   FRT22_gitR1.sh           |  73907|  6/25/22 15:41|  1288| p2.02-20625-1541
##FD   FRT22_gitR1.sh           |  75750|  6/27/22 09:04|  1302| p2.02-20627-0904
##FD   FRT22_gitR1.sh           |  77248| 10/25/22 19:43|  1332| p2.03-21025-1943
##FD   FRT22_gitR1.sh           |  79863| 10/27/22 10:20|  1361| p2.04-21027-1020
##FD   FRT22_gitR1.sh           |  80647| 11/03/22 16:05|  1370| p2.04-21103-1605
##FD   FRT22_gitR1.sh           |  81638| 11/11/22 17:09|  1387| p2.04-21111-1709
##FD   FRT22_gitR1.sh           |  83204| 11/17/22 12:00|  1404| p2.04-21117-1200
##FD   FRT22_gitR1.sh           |  83707| 11/20/22 13:55|  1402| p2.04-21120.1355
##FD   FRT22_gitR1.sh           |  86848| 11/27/22 17:04|  1419| p2.04-21127.1704
##FD   FRT22_gitR1.sh           |  90455| 12/23/22 16:03|  1448| p2.04-21223.1603
##FD   FRT22_gitR1.sh           |  94794| 12/04/22 09:06|  1517| p2.04-21204.0906
##FD   FRT22_gitR1.sh           | 103287| 12/04/22 20:54|  1667| p2.04-21204.2054
##FD   FRT22_gitR1.sh           | 103287| 12/05/22  8:10|  1669| p2.04-21205.0810
##FD   FRT22_gitR1.sh           | 114944| 12/31/22 16:24|  1769| p2.05-21231.1624
##FD   FRT22_gitR1.sh           | 114541|  1/04/23 13:50|  1777| p2.05-30104.1350
##FD   FRT22_gitR1.sh           | 115875|  1/08/23 21:15|  1796| p2.05-30108.2115
##FD   FRT22_gitR1.sh           | 119552|  1/19/23 16:15|  1811| p2.05-30119.1615
##DESC     .--------------------+-------+---------------+------+-----------------+
#            Use the commands in this script to run git commands with helpfull
#            output.
#
##LIC      .--------------------+----------------------------------------------+
#            Copyright (c) 2021 8020Data-FormR * Released under
#            MIT License: http://www.opensource.org/licenses/mit-license.php
##FNCS     .--------------------+----------------------------------------------+
#            Init               | Create .git folder                                                        # .(20430.01.1 RAM Added)
#                               |
#            Commit Comment     |
#            Push               |
#            Fetch              | [All]
#            Pull               |
#            Clone              |                                                                           # .(21027.01.1)
#            Sparse             | [Refresh] | [On|Off] | [Edit]                                             # .(21025.01.1).(21204.01.1)
#            Backup             | [-zip|-copy]                                                              # .(21204.02.1)
#                               |
#            List               | [Local|Remote] Commmits
#            Count              | [Local|Remote] Commmits
#                               |
#            List               | [Local|Remote] Branches
#            Count              | [Local|Remote] Branches
#            Checkout           | [Local|Remote] Branch
#                               |
#            Add                | Remote
#            List               | Remotes [Repo|All]
#            Rename             | Remote
#            Delete             | Remote                                                                    # .(11127.01.1 RAM Was: Remove)
#                               |
#            sayMsg             | echo aMsg if bQuiet == 0, then exit if $2 = 2

#            Var                |
#            Var List           |
#            Var Set            |
#            Var Get            |

#            setBranch          |
#            setProjVars        |
#            getCurRemote       |
#            getCurBranch       |
#            shoGitRemotes1     |
#            shoGitRemotes2     |
#            setConfigFile      |                                                                          # .(21212.02.1)
#
##CHGS     .--------------------+----------------------------------------------+

# .(10822.01 08/22/21 RAM 12:00p| ???
# .(10824.01 08/24/21 RAM  9:35a| Created
# .(11127.01 11/27/21 RAM  8:40a| Changed 'remove remote' to 'delete remote'
# .(11127.02 11/27/21 RAM 10:25a| Changed width of Remote name
# .(20122.01  1/22/22 RAM 10:45a| Added "remote alias" local
# .(20122.03  1/22/22 RAM 12:00p| Changed debug to -debug
# .(20122.04  1/22/22 RAM 12:20p| Added aCmd="List Local Commit"
# .(20429.07  4/29/22 RAM  6:45p| Check Git dir
# .(20430.01  4/30/22 RAM  6:22p| Add Git Init and Vars commands
# .(20501.01  5/01/22 RAM 11:30a| Enable JPT12_Main2Fns_p1.05.sh in sub-scripts
# .(20429.09  5/01/22 RAM  2:45p| Run Args_toLower once
# .(20501.03  5/01/22 RAM 12:22p| Add Git create command
# .(20502.06  5/02/22 RAM 12:00p| Major Overhaul of JPT12_Main2Fns_p1.06.sh
# .(20508.03  5/08/22 RAM  4:10p| Moved THE_SERVER checks to JPT12_Main2Fns
# .(20601.06  6/01/22 RAM 10:15p| Check if .git is in parent folder
# .(20615.01  6/15/22 RAM  8:20p| Set ProjVars when in C:\Repos
# .(20623.13  6/23/22 RAM  1:03p| Move List Remotes All
# .(20623.13  6/26/22 RAM  6:30p| Change Cmd Name to List All Remotes
# .(20627.01  6/27/22 RAM  6:30p| Create Cmd List Branch Commits
# .(21025.01 10/25/22 RAM  7:30p| Add sparse on / off
# .(21026.01 10/26/22 RAM  4:30p| Add sparse list
# .(21027.01 10/27/22 RAM  9:04a| Add clone
# .(21027.02 10/27/22 RAM  9:25a| Chop single command to 4 letters
# .(21027.03 10/27/22 RAM 10:20a| Add "*" as optional getCmd
# .(21111.02 11/11/22 RAM  2:30p| Special case for gitr pull FRTools
# .(21111.03 11/11/22 RAM  5:09p| FormR_U is in /webs not /webs/nodeapps
# .(21113.05 11/13/22 RAM  5:30p| Display Version and Source in Begin
# .(21117.01 11/17/22 RAM 12:00p| Improve gitR Helps
# .(21120.02 11/20/22 RAM  1:55p| Fix aOSv and aLstSp
# .(21122.03 11/20/22 RAM  1:30p| Swap FormR_U for SCN2_U Proj Folder sniffer
# .(21122.04 11/22/22 RAM  7:20p| Swap @ for | in list commits
# .(21118.02 11/27/22 RAM  3:00p| Use gitR_clone_p1.04
# .(21127.03 11/27/22 RAM  4:45p| Improve Git Pull -hard
# .(21127.03 11/27/22 RAM  9:15p| More improvements to Git Pull -hard
# .(21128.05 11/27/22 RAM  6:30p| Sort list commits
# .(21128.06 11/27/22 RAM  7:30p| Implement vars set/get
# .(21129.02 11/27/22 RAM  8:45a| Display full git pull and clone result
# .(21129.03 11/27/22 RAM  4:00p| Improve how script permissions are reset
# .(21201.04 12/01/22 RAM  9:30a| Show two reset permission counts
# .(21204.01 12/04/22 RAM  8:40a| Add Refresh and Edit commands
# .(21204.02 12/04/22 RAM  3:00p| Add Backup command
# .(21205.01 12/05/22 RAM  8:10a| Add -debug to sparse edit
# .(21205.03 12/05/22 RAM  7:50p| Use PrjN Uppercase for gitR-config.sh
# .(21205.04 12/05/22 RAM  9:00p| Determine gitr-config file name
# .(21206.04 12/06/22 RAM  3:20p| Use RepoDir name if valid
# .(21206.05 12/06/22 RAM  6:30p| Show Last Commit for gitr pull
# .(21212.02 12/12/22 RAM  1:50p| Put getConfigFile(s) into setConfigFile
# .(21223.03 12/23/22 RAM  2:30p| Improve Gitr list commits local/remote
# .(21223.04 12/23/22 RAM  3:30p| List commits can only take a branch name as an arg
# .(21223.05 12/23/22 RAM  4:03p| Sort List commits in chronological order
# .(21231.05 12/31/22 RAM 11:58p| Merge back into FRT22_gitR1_p2.04_v21212_temp.sh
# .(30104.01  1/04/23 RAM  1:50p| Improve Local Dir name in list commits
# .(30108.01  1/08/23 RAM  9:15p| Add list commits both
# .(30119.01  1/19/23 RAM  2:30p| Remote upstream from getCurRemote
# .(30108.02  1/08/23 RAM  4:15p| Change col widths in list commits

##PRGM     +====================+===============================================+
##ID 69.600. Main               |
##SRCE     +====================+===============================================+
#*/
#========================================================================================================== #  ===============================  #

        aVdt="Jan 19, 2023  4:15p"; aVtitle="formR gitR Tools"                                              # .(21113.05.6 RAM Add aVtitle for Version in Begin)
        aVer="$( echo $0 | awk '{  match( $0, /_[dpstuv][0-9]+\.[0-9]+/ ); print substr( $0, RSTART+1, RLENGTH-1) }' )"  # .(21031.01.1 RAM Add [d...).(20416.03.8 "_p2.02", or _d1.09)

        LIB="gitR1"; LIB_LOG=${LIB}_LOG; LIB_USER=${LIB}_USER; Lib=${LIB}                                   # .(80923.01.1)


        aFns="$( dirname "${BASH_SOURCE}")/../../JPTs/JPT12_Main2Fns_p1.07.sh"; if [ ! -f "${aFns}" ]; then # .(21113.05.7 RAM Use JPT12_Main2Fns_p1.07.sh)
        echo -e "\n ** RSS1[ 71]  JPT Fns script, '${aJFns}', NOT FOUND\n"; exit; fi; #fi
        source "${aFns}";

#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

        bDoit=0                                                                                             ##.(20501.01.5 RAM !Important don't reset in Sub script)
        bQuiet=1                                                                                            ##.(20501.01.6 RAM).(20601.02.2 bQuiet by default)
        bDebug=0                                                                                            ##.(20501.01.7 RAM)
        bSpace=0;                                                                                           # .(20620.04.8 RAM A space hasn't been displayed, print one next; was 1)

        Begin "$@"                                                                                          # .(21113.05.16)

        setOS; bSpace=1;                                                                                    #  A space hasn't been displayed, print one next
#       aLstSp="echo "; if [ "${aOSv:0:1}" == "w" ]; then aLstSp=""; fi                                     ##.(10706.09.1 RAM Windows returns an extra blank line).(21113.06.1 RAM Reverse).(21120.02.2)
        aLstSp="echo "; if [ "${aOSv/w}" != "${aOSv}" ]; then aLstSp=""; fi                                 # .(10706.09.1 RAM Windows returns an extra blank line).(21113.06.1 RAM Reverse).(21120.02.2)
#       echo "  - gitR1[163]  aOSv: ${aOSv}, ${aOS}, aLstSp: '${aLstSp}'"; ${aLstSp}; # exit

#    -- --- ---------------  =  ------------------------------------------------------  #

#       aOSv=gfw1 | w10p | w08s
#       aOSv=rh62 | rh70 | uv14 | ub16

#       sayMsg    "gitR1[170]  aServer: '${aServer}', aOS: '${aOS}', bDebug: '${bDebug}'" 2

#====== =================================================================================================== #  ===========

# ------------------------------------------------------------------------------------
#
#       HELP Command
#
#====== =================================================================================================== #  ===========

function Help( ) {

        sayMsg    "gitR1[182]  aCmd:  '${aCmd}', aCmd0: '$1', aCmd1: '${aCmd1}'" -1

#    if [ "${aCmd}" != "Help" ] && [ "help" != "$1" ]; then return; fi                                      ##.(21117.01.1)

#    if [ "$1" != "help"  ]; then sayMsg " ** Invalid Command: '$1'" 3 sp; aCmd="Help"; fi                  ##.(20625.05.1)
#    if [ "$1" != "help"  ]; then sayMsg " ** Invalid Command: '$1'" sp 3; fi                               ##.(20625.05.1 RAM A little help with help)
#    if [ "$1" != "help"  ]; then sayMsg " ** Invalid Command: '$1'" 3;    fi                               ##.(20625.05.1 RAM A little help with help)
#    if [ "${aCmd/Help}" == "${aCmd}" ]; then sayMsg " ** Invalid Command: '$1'" 3; aCmd="Help";  fi        ##.(21117.01.2 RAM Works best)
     if [ "${aCmd}" == "" ]; then bQuiet=0; sayMsg " ** Invalid gitR Command: '$1'" 3; aCmd="Help";  fi     # .(21117.01.2 RAM Works best)

     if [ "${aCmd}" == "Help" ]; then                                                                       # .(21117.01.3)

#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

        echo ""
        echo "  Useful gitR Commands   (${aVer})                                 (${aVdt})"
        echo "  -------------------------------------------------------------- -----------------------------------"
        echo "   gitR  Init                                                    Create a .git folder"        # .(20429.03.2 End)
        echo ""
        echo "   gitR  Commit {Comment}                                        Stage and Commit all changes"
        echo "         Push                                                    Upload changes to remote"
        echo "         Fetch                                                   Fetch remote changes (Refs only, i.e. no local changes)"
        echo "         Fetch [All]                                             Fetch remote changes for all remotes and branches"
        echo "         Pull                                                    Merge remote changes (if no merge conflicts)"
        echo "         Pull  [All] -hard  [ hard | --hard ]                    Remove [all] changes before merge"               # .(21127.03.8)
#       echo "         Sparse  On | Off | List                                 Turn sparse-checkout on and/or off"              ##.(21025.01.2 RAM Added).(21026.01.1).(21204.01.2)
        echo "         Sparse [Refresh] On | Off | List | Edit                 Turn sparse-checkout on and/or off"              # .(21204.01.2 RAM Add Refresh and Edit)
        echo "         Clone  {Project} [-doit] [-all]                         Backup and Clone Repo with sparse-checkout"      # .(21027.01.2 RAM Added)
        echo "         Clone  {RepoURL} [-doit] [-all]                         Create config file: gitr_{project}_config.sh"    # .(21101.05.1 RAM Added)
        echo "         Backup {Project} [-doit] [-zip]                         Backup {project}"                                # .(21204.02.2 RAM Add Backup)
        echo ""
        echo "         List Local Commmits [{BranchName}] [-d {Days}]          List Local Commits"
        echo "         Count Local Commmits [{BranchName}                      Count Local Commits"
#       echo "         List Remote Commmits [{GitHost} {GitUser}] {Branch}     List Remote Commits"
        echo "         List Remote Commmits [{BranchName}] [-d {Days}]         List Remote Commits"
        echo "         Count Remote Commmits [{RemoteName}/][{BranchName}      Count Remote Commits"
        echo ""
        echo "         List [Local|Remote] Branches                            List Local and/or Remote Branches"
        echo "         Checkout [{RemoteName}] {BranchName}                    Checkout Local or Remote Branch"
        echo ""
        echo "         Rename Remote [{OldRemoteName}] {OldRemoteName}         Rename Remote e.g. \"origin\""
        echo "         Create Remote {RemoteName} {RemoteURL}                  Create a Repository with Remote URL"             # .(20501.03.1 RAM)
        echo "         Add    Remote {RemoteName} {RemoteURL}                  Add Remote Name for URL"
#       echo "         List Remotes [{RepoName}]                               List Remote URLs for one/current Project Repo"
        echo "         List Remotes                                            List Remote URLs and Branches"
        echo "         List All Remotes                                        List Remote URLs and Branches for all Project Repos"     # .(20623.13.11)
        echo "         Delete Remote [RemoteName}                              Delete Remote Name"                              # .(11127.01.4 RAM Was: Remove Remotes)
        echo ""
        echo "         Var List                                                List all local and global config variables"      # .(20501.02.1 RAM)
        echo "         Var Set {Name} {Value} [-g]                             Set [global] config value"                       # .(20501.02.12)
        echo "         Var Get {Name}                                          Set [global] config value"                       # .(21128.06.1)
        echo ""
        echo "  Notes: Only two lowercase letter are needed for each command, seperated by spaces"
        echo "         One or more command options follow. Help for the command is dispayed if no options are given"
        echo "         The options, -debug, -doit and -quietly, can follow anywhere after the command"      # .(20122.03.2)
#       echo ""
        ${aLstSp}; exit                                                                                     # .(10706.09.3)

        fi                                                                                                  # .(21117.01.4)

#       sayMsg    "gitR1[242]  ${aCmd}" 2
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

  if [ "${aCmd}"  == "Show Help" ]; then
        echo ""
        echo "    gitR Show displays the Git Remote URLs for fetch, pull and push for a Repository Project."
        echo "         The current folder must be a Project folder containing Git branches"
        echo "         Enter a Branch folder name or [all] to show the URLs for all branches"
        ${aLstSp}; exit                                                                                     # .(10706.09.3)
        fi

#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

  if [ "${aCmd}"  == "List Help" ]; then
        echo ""
        echo "    gitR List the Git commits for a Repository Project Branch"
        echo "         The current folder must be a Project folder containing Git branches"
        echo "         Like the Show command, the Remote Alias, referring to a remote repository, "
        echo "           is set for Project Branch folder, but you can provide explicitly"
        ${aLstSp}; exit
                                                                                            # .(10706.09.3)
        fi
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

  if [ "${aCmd}"  == "Remote Help" ]; then
        echo ""
        echo "    GitR Remotes uses Git Alias Names that refer to SSH Host Names contained in your SSH Config file"
        echo "         Use the command, Keys Set SSH Hosts, to create them for different Git Keys files"
        echo "         These names allow Git Keys to be used with the git fetch, pull and push commands"
        ${aLstSp}; exit                                                                                     # .(10706.09.3)
        fi

  if [ "${aCmd}"  == "Sparse Help" ]; then                                                                  # .(21204.01.11 RAM Beg)
        echo ""
        echo "    gitR Sparse allows you to only see a subset of files and folders.  The gitR clone command"
        echo "         creates an array of paths, {App[@]}.   This is used to control the following commands:"
        echo "           - gitR Sparse List                   Display the current list of files and folders"
        echo "           - gitR Sparse Edit                   Edit the list of files and folders"
        echo "           - gitR Sparse On                     Include only those files and foldera in the list"
        echo "           - gitR Sparse Off                    Include all files and foldera in the repo"
        echo "           - gitR Sparse Refresh                Reply current list of files and folders"
        ${aLstSp}; exit
        fi                                                                                                  # .(11204.01.11 RAM End)
     } # eof Help
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#========================================================================================================== #  ===============================  #

        setArgs "${1:0:4}" "$2" "$3" "$4" "$5" "$6" "$7" "$8" "$9"                                          # .(21027.02.1 RAM 'gitr clone'; didn't work, but 'gitr clon' does)

  if [ "${bDebug}" == "1" ]; then dBg=1; fi # echo "setCmds ${dBug}"; fi # exit; fi

        getOpts "bdqgl"
        setCmds                                    # ${dBg}   # 1 # dBug

#       sayMsg sp "gitR1[297]  \$1: '$1', \$2: '$2', \$3: '$3', \$4: '$4', \$5: '$5', \$6: '$6', \$7: '$8'" 1
        sayMsg    "gitR1[298]  aCmd:  '${aCmd}', aCmd1: '${aCmd1}', aCmd2: '${aCmd2}', aCmd3: '${aCmd3}', aCmd0: '${aCmd0}', bDoit: '$bDoit', bDebug: '$bDebug', dBug: '$dBug', bQuiet: '$bQuiet' " sp -1
#       sayMsg    "gitR1[299]  aCmd:  '$aCmd',   aCmd1: '$aCmd1', aCmd2: '$aCmd2', aCmd3: '$aCmd3', aCmd0: '$aCmd0' "

#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#       Help

        getCmd "in"             "Init"                                                  # .(20502.06.x End)

        getCmd "push"           "Push"
#       getCmd "pull"           "Pull"
        getCmd "pull"  "*"      "Pull"                                                  # .(21127.03.1)
        getCmd "clon"  "*"      "Clone"                                                 # .(21027.01.3).(21027.03.2)
        getCmd "back"  "*"      "Backup"                                                # .(21204.02.3)

        getCmd "fe"    "al"     "Fetch All"       0
        getCmd "fetch"          "Fetch"           0     # aArg1 could be All
        getCmd "fe"    ""       "Fetch"                 # is wrong: 'Fetch All'         # .(20625.02.1 RAM Fixed getCmd)

        getCmd "sp" "on"        "Sparse"                                                # .(21025.01.3)
        getCmd "sp" "of"        "Sparse"                                                # .(21025.01.3)
        getCmd "sp" "li"        "Sparse"                                                # .(21026.01.2)
        getCmd "sp" "ed"        "Sparse"                                                # .(21204.01.3)
        getCmd "sp" "re"        "Sparse"                                                # .(21204.01.4)
        getCmd "sp" "re" "on"   "Sparse"                                                # .(21204.01.5)
        getCmd "sp" "re" "of"   "Sparse"                                                # .(21204.01.6)

        getCmd "co"             "Add Commit"
        getCmd "ad" "co"        "Add Commit"

        getCmd "ad" "re"        "Add Remote"
        getCmd "ad" "br"        "Add Branch"

        getCmd "cr" "re"        "Create Remote"   #1

#       getCmd "li" "re" "al"   "List All Remotes"                                       # .(20623.13.12)
#       getCmd "li" "re"        "List Remotes"           # maybe ok: 'List Remotes All'

        getCmd "rm" "re"        "Remove Remote"
        getCmd "de" "re"        "Remove Remote"
        getCmd "re" "re"        "Rename Remote"

        getCmd "ch" "br"        "Checkout Branch" # 1
        getCmd "ch"             "Checkout Branch"

        getCmd "li" "va"        "List Vars"
        getCmd "se" "va"        "Set Var"
        getCmd "ge" "va"        "Get Var"                                               # .(21128.06.2)

        getCmd "li" "co" "br"   "List Branch Commits"                                   # .(20627.01 RAM Create Cmd List Branch Commits)

        getCmd "li" "co" "al"   "List All Commits"
        getCmd "li" "co" "bo"   "List All Commits"
        getCmd "li" "co" "lo"   "List Local Commits"    # is wrong: 'List All Commits'  # .(20625.02.3)
        getCmd "li" "co" "re"   "List Remote Commits"   # is wrong: 'List All Commits'  # .(20625.02.4)
        getCmd "li" "co"        "List Local Commits"    # is wrong: 'List All Commits'  # .(20625.02.5)

#       getCmd "co" "re" "li"   "List Remote Commits"   # is wrong: 'List All Commits'  # .(20625.02.4)
#       getCmd "re" "co" "li"   "List Remote Commits"   # is wrong: 'List All Commits'  # .(20625.02.4)

        getCmd "li" "br" "al"   "List All Branches"
        getCmd "li" "lo" "br"   "List Local Branches"
        getCmd "li" "re" "br"   "List Remote Branches"  # is wrong: 'List Remotes All'  # .(20625.02.2)
        getCmd "li" "br"        "List Local Branches"   # is wrong: 'List All Branches' # .(20625.02.6)

        getCmd "co" "co" "al"   "Count All Commits"
        getCmd "co" "co" "lo"   "Count Local Commits"   # is wrong: 'List All Commits'   # .(20625.02.7)
        getCmd "co" "co" "re"   "Count Remote Commits"  # is wrong: 'List All Commits'   # .(20625.02.8)
        getCmd "co" "co"        "Count Local Commits"   # is wrong: 'List All Commits'   # .(20502.06.x End).(20625.02.9)
        getCmd "co" "re"        "Count Remote Commits"

        getCmd "li" "re" "al"   "List All Remotes"                                       # .(20623.13.12)
        getCmd "li" "re"        "List Remotes"          # maybe ok: 'List Remotes All'

        getCmd "he" "re"        "Remote Help"
        getCmd "he" "sh"        "Show Help"
        getCmd "he" "li"        "List Help"
        getCmd "he" "sp"        "Sparse Help"                                           # .(21204.01.12)

          if [ "${aCmd3}"  ==   "sp--" ]; then aCmd="Sparse Help"; fi                   # .(21204.01.12)

#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

        sayMsg    "gitR1[381]  aCmd:  '${aCmd}', aArg1: '${aArg1}', aArg2: '${aArg2}', aArg3: '${aArg3}', aArg4: '$aArg4', aArg5: '$aArg5', aArg6: '$aArg6', aArg7: '$aArg7', aArg8: '$aArg8', aArg9: '$aArg9'" -1
#       sayMsg    "gitR1[382]  aCmd:  '${aCmd}', aArg1: '${aArg1}', aArg2: '${aArg2}', aArg3: '${aArg3}', aCmd0: '$aCmd0', bGlobal: '${bGlobal}'" -1 # 2
        sayMsg    "gitR1[383]  aCmd:  '${aCmd}', '$aCmd1', '$aCmd2', '$aCmd3', aCmd0: '$aCmd0', '$c1', '$c2', '$c3', aArg1: '${aArg1}' " -1 # -1 or 2

#    if [ "${aCmd}" == "" ]; then aCmd="Help"; fi                                       ##.(20625.05.2 RAM A little help with help).(21117.1.5)

        Help ${aCmd0}

#    if [ "${aCmd3}" == "li-br-al" ]; then sayMsg "  * List Branches All is not a valid command" 3; fi
#    if [ "${aCmd3}" == "ls-br-al" ]; then sayMsg "  * List Branches All is not a valid command" 3; fi
#    if [ "${aCmd3}" == "sh-br-al" ]; then sayMsg "  * Show Branches All is not a valid command" 3; fi
#    if [ "${aCmd3}" == "br-li-al" ]; then sayMsg "  * List Branches All is not a valid command" 3; fi
#    if [ "${aCmd3}" == "br-ls-al" ]; then sayMsg "  * List Branches All is not a valid command" 3; fi
#    if [ "${aCmd3}" == "br-sh-al" ]; then sayMsg "  * Show Branches All is not a valid command" 3; fi

# ------------------------------------------------------------------------------------
#
#       GITR Functions
#
#====== =================================================================================================== #  ===========

# function sayMsg( ) {  ... }                                                                                               ##.(20501.01.6)

#====== =================================================================================================== #  ===========

function setBranch( ) {
     if [ "$1" == "" ]; then return; fi; aBranch=""
        sayMsg "setBranch[ 1 ]  Checking Branch: '$1'";
     if [ "${1/-test/}"  != "$1" ]; then  aBranch=$1; fi
     if [ "${1/-prod/}"  != "$1" ]; then  aBranch=$1; fi
     if [ "${1/-dev/}"   != "$1" ]; then  aBranch=$1; fi
     if [ "${1/main/}"   != "$1" ]; then  aBranch=$1; fi
     if [ "${1/master/}" != "$1" ]; then  aBranch=$1; fi
     if [ "${1/Main/}"   != "$1" ]; then  aBranch=$1; fi
     if [ "${1/Master/}" != "$1" ]; then  aBranch=$1; fi
     if [ "${aBranch}"   != ""   ]; then
        sayMsg "setBranch[ 2 ]  Found Branch: '${aBranch}'" # 1;
      else
        sayMsg "setBranch[ 3 ]  It's not a Branch" # 1;
        fi
     }
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========

function chkGitDir() {             # Check to see if the current dir contains .git source control           # .(20429.07.1 Beg RAM)

    bOk=0; if [ -d       ".git" ]; then bOK=1; fi
           if [ -d    "../.git" ]; then bOK=1; cd ..; fi                                                    # .(20601.06.1 RAM Look up one, too)
           if [ -d "../../.git" ]; then bOK=1; cd ../..; fi                                                 # .(20601.06.1 RAM Look up two, too)

    if [ "${bOK}" != "1" ]; then sayMsg sp "You must be in a folder with Git source control." 2; fi

        aGitDir=$( basename $( pwd ) )
#       echo "    aGitDir: '${aGitDir}'"; exit
        }                                                                                                   # .(20429.07.1 End)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========

function setProjVars( ) {

#       aWebs=$1
        aBrch=$1; # if [ "${aOpt1}" == "all" ]; then aBrch=""; fi

        aProject=""
        aBranch=""
        aStage=""
        aApp=""

# if [ "${aOS}" == "windows" ] || [ "${aOS}" == "GitBash" ]; then                                           ##.(21122.03.4 RAM Added || [ "${aOS}" == "GitBash" ])
  if [ "${aOSv/w}" != "${aOSv}" ]; then                                                                     # .(21122.03.4 RAM What we've been using)

          aDir=$( pwd -P );                  aVMs="/C/WEBs/SCN2/Files/VMs"; aWebs="SCN2"
  if [ "${aDir/8020/}"  != "${aDir}" ]; then aVMs="/C/WEBs/8020/VMs";       aWebs="8020";    fi
  if [ "${aDir/icat/}"  != "${aDir}" ]; then aVMs="/C/WEBs/SCN2/VMs";       aWebs="iCat";    fi
  if [ "${aDir/IODD/}"  != "${aDir}" ]; then aVMs="/C/WEBs/8020/IODD/FormR";aWebs="FormR_I"; fi; fi
  if [ "${aDir/repos/}" != "${aDir}" ]; then aVMs="/C/Repos";               aWebs="Repos";   fi;            # .(20615.01.1 RAM Repos)
  if [ "${aDir/Repos/}" != "${aDir}" ]; then aVMs="/C/Repos";               aWebs="Repos";   fi;            # .(20615.01.1 RAM Repos)

  if [ -d "${aVMs/\/C\//\/D\/}" ]; then aVMs="${aVMs/\/C\//\/D\/}"; fi                                      # .(30104.01.4 RAM Switch Drive letters)
  if [ "${aOS}" == "linux" ]; then

          aDir=$( pwd -P );                  aVMs="";                       aWebs="FormR_U"                 # .(21122.03.1 RAM Switch SCN2_ and FormR_U)
  if [ "${aServer:0:2}" == "sc" ];      then aVMs="";                       aWebs="SCN2_U"; fi
          fi

# if [ "${aDir/nodeapps/}" != "" ] && [ "${aWebs}" == "8020" ]; then        aWebs="8020_N";  fi             ##.(10821.01.1 RAM)

  if [ "${aWebs}" == "8020"      ]; then aApps=""; else aApps="/nodeapps"; fi
# if [ "${aWebs}" == "8020_N"    ]; then                aApps="/nodeapps"; fi                               ##.(10821.01.2 RAM)
  if [ "${aWebs}" == "iCat"      ]; then                aApps="/icatapps"; fi
  if [ "${aWebs}" == "FormR_I"   ]; then                aApps="/P09"     ; fi
# if [ "${aWebs}" == "FormR_U"   ]; then                aApps="/nodeapps"; fi
# if [ "${aWebs}" == "FormR_U"   ]; then                aApps=""         ; fi                               ##.(21111.03.1)

  if [ "${aWebs}" == "Repos"     ]; then                aApps="/Repos";    fi                               # .(20615.01.2)
  if [ "${aDir/nodeapps/}" != "" ]; then                aApps="/nodeapps"; fi                               # .(10821.01.3 RAM).(21103.2 RAM ??)
  if [ "${aWebs}" == "FormR_U"   ]; then                aApps=""         ; fi                               # .(21111.03.1 RAM)

        sayMsg "setProjVars[ 1 ]  aOS:   '${aOS}', aWebs: ${aWebs}, aApps: '${aApps}', aVMs: '${aVMs}', aServer: '${aServer}'" -1 # 2
        sayMsg "setProjVars[ 2 ]  aDir: '${aDir}', aWebs: ${aWebs}, aDir: '${aDir}' match '${aVMs}/(.+)/webs/'" # 1 # 2

#       aVM=$(     echo "${aDir}"   | awk '{ sub( /webs.+/, ""); sub( /.+VMs/, ""); print $0   }' )
        aVM=$(     echo "${aDir}"   | awk '{ match( $0, /VMs\/(.+)(\/webs)/,   a ); print a[1] }' ); if [ "${aVM}" == "" ]; then
        aVM=$(     echo "${aDir}"   | awk '{ match( $0, /VMs\/(.+)/,           a ); print a[1] }' ); fi;

# if [ "${aVM}" == ""      ]; then aVM="???"; fi                                                            # .(30104.01.1 RAM If there are no VMs, there are no VMs)
  if [ "${aOS}" == "linux" ]; then aVM=${aServer:0:5}; fi

        sayMsg "setProjVars[ 5 ]  aVM:   '${aVM}', aWebs: ${aWebs}, aDir: '${aDir}/' match '${aVMs}/(.*)(/webs)?/'" -1 # 2

        aRoot=${aVMs}/${aVM}                     # or "" if linux
  if [ "${aOS}"  == "linux" ]; then aRoot=""; fi
#       aRoot="";  aDir="/webs/nodeapps/NuSvs/Main-dev04/server1"

        aPath=$(   echo "${aDir}"   | awk '{ print substr( $0, length( "'${aRoot}'" ) + 1 ) }' )          # .(10614.01.1 RAM Should be + 1)
#       aPath=$(   echo "${aDir}"   | awk '{ print length( "'${aRoot}'" ) }' )
#       aPath=${aDir/${aRoot}/}

        nLen=${#aRoot};  aDir1="'${aDir:0:${nLen}}' -- '${aDir:${nLen}}'"
        sayMsg "setProjVars[ 6 ]  aDir:  ${aDir} aRoot: '${aRoot}' (${#aRoot}), aPath: '${aPath}'"   -1 # 1

                                                                      aPath1="${aPath}"
  if [ "${aWebs}" == "SCN2"    ]; then aPath1="${aPath/nodeapps\//}"; aPath1="${aPath1/nodeapps/}"; fi
  if [ "${aWebs}" == "iCat"    ]; then aPath1="${aPath/icatapps\//}"; aPath1="${aPath1/icatapps/}"; fi
  if [ "${aWebs}" == "8020"    ]; then aPath1="${aPath/\/webs\//}";   aPath1="${aPath1/webs/}"; fi
# if [ "${aWebs}" == "8020_N"  ]; then aPath1="${aPath/\/webs\//}";   aPath1="${aPath1/webs/nodeapps}"; fi  # .(10821.01.4)
  if [ "${aWebs}" == "SCN2_U"  ]; then aPath1="${aPath/\/webs/}";     aPath1="${aPath1/\/nodeapps\//}"; fi
  if [ "${aWebs}" == "FormR_U" ]; then aPath1="${aPath/\/webs\//}";   aPath1="${aPath1/webs/}"; fi
  if [ "${aWebs}" == "FormR_I" ]; then aPath1="FormR${aPath}"; fi   # aPath1='{Project}/{Branch}/{Stage}/{App}' for split below
  if [ "${aWebs}" == "FormR_I" ]; then aPath1="FormR${aPath}"; fi   # aPath1='{Project}/{Branch}/{Stage}/{App}' for split below

        sayMsg "setProjVars[ 7 ]  aRoot: '${aRoot}' (${#aRoot}), aPath1: '${aPath1}'"  -1

#       aProj=$(   echo "${aDir}"   | awk '{ match( $0, /nodeapps\/(.*)\//,  a ); print a[1] }' )
#       aBranch=$( echo "${aDir}"   | awk '{ match( $0, /'${avMs}'\/(.*)\//, a ); print a[1] }' )

        aProject=$(echo "${aPath1}" | awk '{ split( $0, a, /\// ); print a[1] }' )
        aBranch=$( echo "${aPath1}" | awk '{ split( $0, a, /\// ); print a[2] }' )
        aStage=$(  echo "${aPath1}" | awk '{ split( $0, a, /\// ); print a[3] }' )
        aApp=$(    echo "${aPath1}" | awk '{ split( $0, a, /\// ); print a[4] }' )
        a5=$(      echo "${aPath1}" | awk '{ split( $0, a, /\// ); print a[5] }' )                        # .(10821.01.5)

  if [ "${aProject}" == "nodeapps" ]; then                                                                # .(10821.01.6 Beg)
        aProject=${aBranch}
        aBranch=${aStage}
        aStage=${aApp}
        aApp=${aApp}
        fi                                                                                                # .(10821.01.6 End)

   if [ "${aProject/_}" != "${aProject}" ]; then                                                          # .(30104.05.1 RAM Beg)
        aStage="$(    echo "${aProject}" | awk '{ split( $0, m, "_" ); print m[2] }' )"
        aProject="$(  echo "${aProject}" | awk '{ split( $0, m, "_" ); print m[1] }' )"
        if [ "${aStage}" == "" ]; then aStage=${aBranch}; aBranch=""; fi
        fi                                                                                                # .(30104.05.1 RAM End)

        sayMsg "setProjVars[ 8 ]  aProject: '${aProject}', aBranch: '${aBranch}', aStage: '${aStage}', aApp: '${aApp}'" -1

  if [ "${aBrch}"  != ""  ]; then aBranch=${aBrch}; fi

        sayMsg "setProjVars[ 9 ]  aProject: '${aProject}', aBranch: '${aBranch}', aStage: '${aStage}', aApp: '${aApp}'" -1

#       aDir="${aRoot}/webs${aApps}/${aProject}/${aBranch}"; # echo "aDir: ${aDir}"
        aProjDir="${aRoot}/webs${aApps}/${aProject}";        sayMsg "setProjVars[ 21]  aProjDir: ${aProjDir}"

 if [ "${aWebs}" == "FormR_I" ]; then
#       aProjDir="${aRoot}${aProject}";                      sayMsg "setProjVars[ 22]  aProjDir: ${aProjDir}"
        aProjDir="/C/WEBs/8020/IODD/FormR${aApps}";          sayMsg "setProjVars[ 23]  aProjDir: ${aProjDir}"
#       aProjDir="${aRoot}";                                 sayMsg "setProjVars[ 24]  aProjDir: ${aProjDir}"  # .(10614.02.1 RAM ??)
        fi

# if [  "${aProject}" == "nodeapps" ] || [ "${aProject}" == "" ]; then
  if [ "/${aProject}" == "${aApps}" ] || [ "${aProject}" == "" ]; then
#       aProjDir=${aProjDir/webs\//}; aProjDir=${aProjDir/nodeapps\//};

        sayMsg "You must be in a Project Repository folder: '${aProjDir}{Project}'" 2
        fi
        }  # eof setProjVars
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========

function  getCurRemote( ) {
#       sayMsg "getCurRemote[ 1 ]  ( '$1' )" 1 # 1
#       aRemote=$( git branch -vv | awk '/\*/ { split( $0, a, /\[/ ); split( a[2], a, /\// ); print a[1] }' )  ##.(21223.03.1)
#       aRemote=$( git remote show )                                                    ##.(21223.03.1).(30119.07.1)
        aRemote=$( git remote show | awk 'NR == 1' )                                    # .(30119.01.1 RAM Why is 'upstream' returned? Are any others?)
#       sayMsg "getCurRemote[ 2 ]  ( '${aRemote}' )" 2                                  ##.(21223.03.1)
        }
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========

function  getCurBranch( ) {
#       sayMsg "getBranch[ 1 ]  ( '$1' )" # 1
  if [ "$1" == "" ]; then aBranch=$( git branch | awk '/\*/ { print $2 }' ); return; fi
#       aBranch=$( git branch -vv | awk -v r=$1 '{ split( $0, a, /\[/ ); split( a[2], a, /\// ); print "a[1]: " a[1] ", " a[2]; if ( a[1] == r ) { split( a[2], a, /[:\]]/ ); print a[1]; exit } }' )
#       aBranch=$( git branch -vv | awk -v r=$1 '{ split( $0, a, /\[/ ); split( a[2], a, /\// ); if ( a[1] == r ) { split( a[2], a, /[:\]]/ ); print a[1]; exit } }' ) ##.(21223.03.2)
        aBranch=$( git status     | awk '{ print substr( $0, 11 ); exit }' )            # .(21223.03.2)
#       sayMsg "getBranch[ 2 ]  ( '${aBranch}' )" 2                                     ##.(21223.03.2)
        }
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========

function  shoGitRemotes1( ) {
        sayMsg "shoGitRemotes1[ 1 ]  ( '$1' )" # 1

#       ------------------------------------------

#       aDir="${aRoot}/webs/nodeapps/${aProject}/${aBranch}"; echo "aDir: ${aDir}"
# if [ ! -d "${aProjDir}" ]; then
#       echo ""; echo " ** Branch folder not found: '${aProjDir}'"; echo ""; exit
#       fi

        sayMsg "shoGitRemotes1[ 2 ]  cd ${aProjDir}/${aBranch}" # 1
  if [ ! -d ".git" ] || [ "${aBranch}" != "" ]; then

  if [ "${aBranch}" == "" ]; then
        sayMsg "You must be in a Repository folder: '${aProjDir}/{Repo}'" 2
        fi;  # fi;

        sayMsg "shoGitRemotes1[ 3 ]  cd ${aProjDir}/${aBranch}" # 1
# if [ ! -d ".git" ] || [ "${aBranch}" != "" ]; then
  if [   -d "${aProjDir}/${aBranch}" ]; then
        cd  ${aProjDir}/${aBranch}

      else
        sayMsg "There is no Branch folder, ${aBranch}" 2
        fi;
#       ------------------------------------------
        fi; # eif "${aBranch}" != ""

#       -------------------------------------------------------------------------
        sayMsg "shoGitRemotes1[ 4 ]  aOS: ${aOS}"

        sayMsg "" 3
  if [ "${aOS}" == "linux" ]; then
        echo "    Git Remotes for ${aServer}:/.../${aProject}/${aBranch}"
      else
        aSvr=${aVM}; if [ "${aWebs}" == "FormR" ]; then aSvr="FormR"; fi
        echo "    Git Remotes for ${aSvr}:/.../${aProject}/${aBranch} (${aServer})"
        fi
#       ------------------------------------------

        echo "    Remote Alias Name                         Repository URL"
#       echo "    -------------------------- -------  ---------------------------------------------"
        echo "    -------------------------------- -------  ---------------------------------------------"  # .(11127.02.1)

#       ------------------------------------------

#       mRemotes=$( git remote -v 2>&1 | awk '!/fatal:/' )
# if [ "${mRemotes}" != "" ]; then
#       echo "${aRemotes}" | awk '{ print "  "$0 }'
#       fi

        sayMsg "shoGitRemotes1[ 5 ]  cd: $( pwd )"
        mRemotes=$( bash -c '( git remote -v )' 2>&1 )  # So that no error message is disdplayed
#       mRemotes=$( bash -c '( git remote -v )' 2>&1 | sort -k1.47r)  # .(21128.05.1 RAM Sort)

#       mRemotes=$( git remote -v )

#       echo "\${?}: ${?}..."
#   if [[ ${?} -ne 0 ]]; then
#       echo "error"
#       sayMsg "  * Git is not initialized." 3
#       exit
#       fi

#       echo "\${mRemotes:0:5}: ${mRemotes:0:5}"
  if [ "${mRemotes:0:5}" == "fatal" ]; then
        sayMsg " ** Git Error." 3
        sayMsg "    ${mRemotes}." 3
        exit
        fi

  if [ "${mRemotes}" == "" ]; then
        sayMsg "  * No Remotes are defined for this Repository." 3
      else

    for aRemote in "${mRemotes[@]}"; do
#       echo "${aRemote}" | awk '{ printf "    %-25s  %7s  %s\n", $1, $3, $2; if ($3 == "(push)") { print "" } }'
        echo "${aRemote}" | awk '{ printf "    %-31s  %7s  %s\n", $1, $3, $2; if ($3 == "(push)") { print "" } }'
        done
        fi
#       ------------------------------------------

#       git remote -v; nErr=$?; echo "nErr: ${nErr}"   # 2>&1
# if ! test $nErr -eq 0
#     then
##      echo >&2 "command failed with exit status $ret"
#       echo >&2 "  ** Git is not initialised!"
#       exit 1
#     else
#       git remote -v | awk '{ print "  "$0 }'
#       fi
#       ------------------------------------------

#       echo "--"
     }  # eof shoGitRemotes1
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========

function shoGitRemotes2( ) {
        sayMsg "shoGitRemotes2[  1]  ( '$1' )"  # 1                                                         # gitr li re al
        aBranch=${1:34}

        sayMsg "showGitRemotes2[  2]  aBranch: '${aBranch}', '$( pwd )/${aBranch}'" # 1                     # .(10824.01.1 RAM ${aBranch} S.B ${aRepo})
 if [ "" == "${aBranch}" ]; then return; fi
 if [  ! -d "${aBranch}" ]; then return; fi

        sayMsg "showGirRemotes2[  3]  aBranch: '${aBranch}'"
#       echo "keys show remote ${aBranch}"

#       ------------------------------------------

  if [ "${aBranch}" != ".git" ]; then                                                                       # .(10824.01.2 if ".git" we are in "Repo Folder")
        cd ${aBranch}
    else                                                                                                    # .(10824.01.3)
        aBranch=''                                                                                          # .(10824.01.4)
        fi

#       -------------------------------------------------------------------------
        sayMsg "shoGitRemotes2[  4]  aOS: ${aOS}"

        sayMsg "" 3
  if [ "${aOS}" == "linux" ]; then
        echo "    Git Remotes for ${aServer}:/.../${aProject}/${aBranch}"
        else
        aSvr=${aVM}; if [ "${aWebs}" == "FormR" ]; then aSvr="FormR"; fi
        echo "    Git Remotes for ${aSvr}:/.../${aProject}/${aBranch} (${aServer})"
        fi
#       ------------------------------------------

  if [ "${bFirstTime}" != "0" ]; then
        echo "    -----------------------------------------------------------------------------------------"
        echo "    Remote Alias Name                         Repository URL / Branch"
        fi
#       echo "    -------------------------- -------  ---------------------------------------------"
        echo "    -------------------------------- -------  ---------------------------------------------"  # .(11127.02.2)

#       ------------------------------------------

        bFirstTime=0

#       mRemotes=$( git remote -v 2>&1 | awk '!/fatal:/' )
# if [ "${mRemotes}" != "" ]; then
#       echo "${aRemotes}" | awk '{ print "  "$0 }'
#       fi

        IFS=$'\n'
        mRemotes=( $( bash -c '( git remote -v )' 2>&1               ) )
#       mRemotes=( $( bash -c '( git remote -v )' 2>&1 | sort -k1.47 ) ) ##.(21128.05.2 RAM Sort)

#       mRemotes=$( git remote -v )

#       echo "\${?}: ${?}"
    if [ ${?} -ne 0 ]; then
        sayMsg "  * Git is not initialized." 3
      else
    if [ "${mRemotes}" == "" ]; then
        sayMsg "  * No Remotes are defined for this Repository." 3
      else
      for aRemote in "${mRemotes[@]}"; do     # sayMsg "aRemote1: ${aRemote}" 1
#       echo "${aRemote}" | awk            '{ printf "    %-25s  %7s  %s\n", $1, $3, $2 }'
#       echo "${aRemote}" | awk '/\(push\)/ { printf "    %-25s  %7s  %s\n", $1, $3, $2 }'
        echo "${aRemote}" | awk '/\(push\)/ { printf "    %-31s  %7s  %s\n", $1, $3, $2 }'                  # .(11127.02.3)

                aRemote=$( echo ${aRemote} | awk '/\(push\)/{ print $1 }' );   # sayMsg "aRemote2: ${aRemote}" 1
   if [ "${aRemote}" != "" ]; then
#       git branch -ra | awk -F'[/]' -v r="${aRemote}" '{ if ($1 == "  remotes") { aRemote = $2; aBranch = $3 } else { aBranch = $1 }; if (r == $2) { aHead = ""; if ( substr(aBranch,1,4) == "HEAD" ) { aHead = "HEAD "; aBranch = substr( aBranch, 9) }; printf "    %-25s  %7s  / %s\n", aRemote, aHead, aBranch } }'
        git branch -ra | awk -F'[/]' -v r="${aRemote}" '{ if ($1 == "  remotes") { aRemote = $2; aBranch = $3 } else { aBranch = $1 }; if (r == $2) { aHead = ""; if ( substr(aBranch,1,4) == "HEAD" ) { aHead = "HEAD "; aBranch = substr( aBranch, 9) }; printf "    %-31s  %7s  / %s\n", aRemote, aHead, aBranch } }'   # .(11127.02.4)
        fi
        done

#       git branch -ra | awk -F'[/]' '{ if ($1 == "  remotes") { aRemote = $2; aBranch = "  "$3 } else { aBranch = $1 }; printf "    %-25s  %5s  %s\n", aRemote, "", aBranch }'

        fi; fi
#       ------------------------------------------

        cd ..

#       git remote -v; nErr=$?; echo "nErr: ${nErr}"   # 2>&1
#  if ! test $nErr -eq 0
#       then
##      echo >&2 "command failed with exit status $ret"
#       echo >&2 "  ** Git is not initialised!"
#       exit 1
#     else
#       git remote -v | awk '{ print "    "$0 }'
#       fi
#       ------------------------------------------

        echo ""
     }  # eof shoGitRemotes2
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

function shoGitRemotes3( ) {                                                                                # .(60223.01.1 RAM End)
        sayMsg "shoGitRemotes3[  1]  ( '$1' )"  1                                                           # gitr li re al

        echo ""
     }  # eof shoGitRemotes3                                                                                # .(60223.01.1 RAM End)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#========================================================================================================== #  ===============================  #
#       GIT COMMANDS
#====== =================================================================================================== #  ===========

        sayMsg "gitR1[791]  aCmd:  '${aCmd}', aArg1: '${aArg1}', aArg2: '${aArg2}', aArg3: '${aArg3}', bGlobal: '${bGlobal}'" -1 # 2

#====== =================================================================================================== #  ===========
#       GIT INIT                                                                                            # .(20430.01.3 Beg RAM Added)
#====== =================================================================================================== #

  if [ "${aCmd}" == "Init" ]; then
        sayMsg "gitR1[798]  Git Init"

        echo ""
        echo "git init"

#       echo ""
        exit
     fi # eoc Init                                                                                          # .(20430.01.3 End)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========
#       GIT LIST VARS                                                                                       # .(20430.01.3 Beg RAM Added)
#====== =================================================================================================== #

  if [ "${aCmd}" == "List Vars" ]; then
        sayMsg "gitR1[813]  Git List Vars"
#       echo "git list vars"

        aAWK='
BEGIN{ }
  NR == 1 { aLast  = substr($0,1,3)  }
     {  if (aLast != substr($0,1,3)) { print ""; aLast = substr( $0,1,3) } }
     {  split( $0, m, "=" ); s = (substr(m[2], 1, 1) == "\"") ? "" : " "; printf "  %-28s = %s\n", m[1], s m[2]  }
END{ }
'
        echo ""
        echo "  Git Global Config Vars"
        echo "  ---------------------------- = ------------------------------------------------------------"
        git config --list --global | awk "${aAWK}"

    if [ -d ".git" ]; then

        echo ""
        echo "  Git Local Config Vars ($( pwd ))"
        echo "  ---------------------------- = ------------------------------------------------------------"
        git config --list --local  | awk "${aAWK}"
        fi

#       echo ""
        exit

     fi # eoc List Vars                                                                                     # .(20430.01.3 End)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========
#       GITR SET VAR                                                                                        # .(20501.02.3 Beg RAM Added)
#====== =================================================================================================== #

  if [ "${aCmd}" == "Set Var" ]; then
        sayMsg "gitR1[847]  Git Set Var"

#       echo -e "]n   git set var '${aArg1}' '${aArg2}'"
        git config --global --add "${aArg1}" "${aArg2}"
        echo -e "\n  ${aArg1} is now set globally to \"${aArg2}\""

#       echo ""
        ${aLstSp}; exit
     fi # eoc Set Var                                                                                       # .(20501.02.3 End)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========
#       GITR GET VAR                                                                                        # .(21128.06.3 Beg RAM Add Command)
#====== =================================================================================================== #

  if [ "${aCmd}" == "Get Var" ]; then
        sayMsg "gitR1[863]  Git Get Var"

#       echo -e "]n   git set var '${aArg1}' '${aArg2}'"
        aArg2=$( git config --global --get "${aArg1}" )
        echo -e "\n  ${aArg1}=${aArg2}"

        ${aLstSp}; exit
     fi # eoc Set Var                                                                                       # .(21128.06.3 RAM End)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========
#       CREATE REMOTE                                                                                       # .(20501.03.3 Beg RAM Added)
#====== =================================================================================================== #

  if [ "${aCmd}" ==  "Create Remote" ]; then
        sayMsg "gitR1[878]  Create Remote" 1
        sayMsg "gitR1[879]  aArg1: '${aArg1}', aArg2: '${aArg2}', aArg3: '${aArg3}', aArg4: '${aArg4}', bDoit: '${bDoit}', bDebug: '${bDebug}', bQuiet: '${bQuiet}'. bGlobal: '${bGlobal}'" 1

        echo ""
        echo "  git checkout -B '${aArg1}' '${aArg2}'"
#               git checkout -B "${aArg1}" "${aArg2}"

#       echo ""
        exit
     fi # eif Create Remote                                                                                 # .(20501.03.3 End)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========
#       CLONE                                                                                               # .(21027.01.4 RAM Beg Added Clone command)
#====== =================================================================================================== #
        sayMsg "gitR1[893]  ${aCmd}" # 1

  if [ "${aCmd}" ==  "Clone" ]; then
#       sayMsg       "Clone Command not implemented yet" 2

        aDoit=""; if [ "${bDoit}" == "1" ]; then aDoit="-doit"; fi                                          #
#       echo "    $( dirname $0 )/gitr_clone_u1.03.sh"        "${mARgs[0]}" "${aArg2}"    "${aArg3}" ${aDoit}
#       echo "    $( dirname $0 )/FRT23_gitR2_clone_p1.03.sh" "${mARgs[0]}" "${aArg2}"    "${aArg3}" ${aDoit}
#                "$( dirname $0 )/FRT23_gitR2_clone_p1.04.sh" "${mARgs[0]}" "${aArg2}"    "${aArg3}" ${aDoit} # .(21118.02.1 RAM Used this version)
                 "$( dirname $0 )/FRT23_gitR2_clone_p1.04.sh" "${mARgs[0]}" "${mARgs[1]}" "${aArg3}" ${aDoit} # .(21118.02.2 RAM Preserve RepoDir case)

        ${aLstSp}; exit
     fi # eoc Next Command                                                                                  # .(21027.01.4 End)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========

#       chkGitDir                                                                                           ##.(20429.07.3 RAM).(20623.13.1 RAM Beg Move from here to below)
#
#       setBranch $1; if [ "${aBranch}" != "" ]; then shift; fi
#       setBranch ${aArg1}
#
#       sayMsg "gitR1[915]  Begin GitR Commands"                                                            ##.(20623.13.1 RAM End Move from here to below)

#====== =================================================================================================== #  ===========
#        LIST ALL REMOTES                                                                                   # .(20623.13.13)
#====== =================================================================================================== # .(20623.13.2 RAM Beg Move to here from below)
#       sayMsg "gitR1[920]  List All Remotes" 1                                                             # .(20623.13.14)

  if [ "${aCmd}" ==  "List All Remotes" ]; then                                                             # .(20623.13.15)

#       ----------------------------------------------------------------------------
#       setProjVars

# if [ ! -d "${aProjDir}" ]; then
#       echo ""; echo " ** Project folder not found: '${aProjDir}'"; echo ""; exit
#    fi

#       echo "aProjDir: ${aProjDir}"
#       cd ${aProjDir};              # rdir "${aProjDir}"

  if [ -d ".git" ]; then
        shoGitRemotes2 "        4096  2021-06-11 12:43  ./.git"; exit;
        fi

        aDir=""
  if [ "${aDir}" == "" ]; then aDir="$( isDir 'repos'    1)"; fi
  if [ "${aDir}" == "" ]; then aDir="$( isDir 'nodeapps' 1)"; fi
  if [ "${aDir}" == "" ]; then
        sayMsg "You must be in a Repos or NodeApps folder" 2
      else
        aTS=$( date '+%y%m%d' ); aTS=${aTS:1}
        aDirF=$( pwd )

        aFile1="fr101_Remote-Repos_${aTS}.md"

        node  "$( dirname $0 )/api/gh2.njs" >"${aDirF}/${aFile1}"

        cat "${aDirF}/${aFile1}" | awk 'NR > 3'
#       chrome "${aDirF}/${aFile1}"

        aFile2="fr102_Local-Repos_${aTS}.md"
        "$( dirname $0 )/lstRemotes/lstRemotes_u2.sh"  "${aDir}"   >"${aDirF}/${aFile2}"

        echo ""                                                   >>"${aDirF}/${aFile2}"
        echo "#####  <u>Remote Repos</u>"                         >>"${aDirF}/${aFile2}"
        cat "${aDirF}/${aFile1}" | awk 'NR > 3'                   >>"${aDirF}/${aFile2}"
        echo ""                                                   >>"${aDirF}/${aFile2}"

        chrome "${aDirF}/${aFile2}"

        fi
        exit

#       rdir . | awk '/-dev|-test|-prod/'

        readarray -t    mFileList < <( rdir . -main   | awk 'NR > 3' | awk '!/-[dpt]/' ); sayMsg "For -main Repos"   1  # .(11125.01.1 RAM Was: Main)
    for aFileStat in "${mFileList[@]}"; do shoGitRemotes2 "${aFileStat}"; done

        readarray -t    mFileList < <( rdir . -master | awk 'NR > 3' | awk '!/-[dpt]/' ); sayMsg "For -master Repos" 1  # .(11125.01.2 RAM Was: Master)
    for aFileStat in "${mFileList[@]}"; do shoGitRemotes2 "${aFileStat}"; done

        readarray -t    mFileList < <( rdir "dev-"    | awk 'NR > 3' );                   sayMsg "For dev- Repos"    1  # .(11125.01.3 RAM Was: -dev)
    for aFileStat in "${mFileList[@]}"; do shoGitRemotes2 "${aFileStat}"; done

        readarray -t    mFileList < <( rdir "test-"   | awk 'NR > 3' );                   sayMsg "For test- Repos"   1  # .(11125.01.4 RAM Was: -test)
    for aFileStat in "${mFileList[@]}"; do shoGitRemotes2 "${aFileStat}"; done

        readarray -t    mFileList < <( rdir "prod-"   | awk 'NR > 3' );                   sayMsg "For prod- Repos"   1  # .(11125.01.5 RAM Was: -prod)
    for aFileStat in "${mFileList[@]}"; do shoGitRemotes2 "${aFileStat}"; done

        readarray -t    mFileList < <( rdir . docs-   | awk 'NR > 3' | awk '!/-[dpt]/' ); sayMsg "For docs- Repos"   1  # .(11125.01.6 RAM Added: docs-)
    for aFileStat in "${mFileList[@]}"; do shoGitRemotes2 "${aFileStat}"; done

        readarray -t    mFileList < <( rdir . tools-  | awk 'NR > 3' | awk '!/-[dpt]/' ); sayMsg "For tools- Repos"  1  # .(11125.01.7 RAM Added: tools-)
    for aFileStat in "${mFileList[@]}"; do shoGitRemotes2 "${aFileStat}"; done

     fi # eoc List All Remotes                                                                              # .(20623.13.16)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- # .(20623.13.2 RAM End Move to here from below)

#====== =================================================================================================== #  ===========

function getConfigFile() {                                                                                  # .(21205.04.1 RAM Beg)
#        echo "--- looking for '$1_gitR-config.sh' in $( pwd )"                                             # .(21205.03.4)

#   if [ -r "$( pwd )/$1_gitR-config.sh" ]; then                                                            ##.(21205.03.5)
    if [ -e          "$1_gitR-config.sh" ]; then                                                            # .(21205.03.5)
         mConfigFiles[1]="$1_gitR-config.sh"; aConfigFile="${mConfigFiles[1]}"; nCfg=1;                     # .(21205.03.6)
         aConfigDir="$( pwd )"
#        aProjName="$( echo "${aConfigFile%%_*}" | tr "[:lower:]" "[:upper:]" )"
         aProjName="${aConfigFile%%_*}"
         echo "--- found: mConfigFiles[${nCfg}]: '${mConfigFiles[${nCfg}]}'"
         return
         fi

         readarray -t mConfigFiles < <( find . -maxdepth 1 -name "*_gitR-config.sh" );                      # .(21205.03.7)
         nCfg=${#mConfigFiles[@]}

    if [ -d ".git"        ]; then aRepoDir="$( pwd )"; fi
    if [ "${nCfg}" == "0" ]; then return; fi
    if [ "${nCfg}" != "1" ]; then
         echo -e "\n  Pick a gitR Config File:"; i=0
         for aFile in "${mConfigFiles[@]}"; do i=$(( $i + 1 )); echo "    ${i}. ${aFile:2}"; done
#        echo "${mConfigFiles[@]}" | awk '{   print "    " $0 }'

         echo ""; read -p "    Enter the number of a gitr-config file: " aAnswer
         aAnswer=$( echo ${aAnswer} | awk '/^[1-9]+$/' );
         if [ "${aAnswer}" == "" ]; then echo ""; sayMsg "Please enter a number greater than 0." 2; fi
#        echo "";
         nCfg=${aAnswer}
         if [[ "${nCfg}" > "${#mConfigFiles[@]}" ]]; then sayMsg "Please enter a number between 1 and ${#mConfigFiles[@]}." 2; fi

         fi # eif Pick from lultiple multiple gitR config files

#        aRepoDir="$( pwd )"; if [ ! -d ".git" ]; then aRepoDir=""; fi
         aConfigFile="${mConfigFiles[$(( $nCfg - 1 ))]}"; aConfigFile="${aConfigFile:2}"
         aConfigDir="$( pwd )"
#        aProjName="$( echo "${aConfigFile%%_*}" | tr "[:lower:]" "[:upper:]" )"
         aProjName="${aConfigFile%%_*}"
 if [ "${aProjName}" == "" ]; then  aProjName="$(basename "${aConfigDir}" )"; fi                            # .(21206.05.1)

         } # eof getConfigFile
#        ----------------------------------------------------------------------

function setConfigFile() {                                                                                  # .(21212.02.2 RAM Put getConfigFile(s) into setConfigFile)

#   if [ -f "*_gitr-config.sh" ]; then echo "--- they exist"
#   for $( find . -maxdepth 1 -name "*_gitr-config.sh" ); do mConfigFiles+=${aFile}; done;
#       mConfigFiles=( $( find . -maxdepth 1 -name "*_gitr-config.sh" ) )

        aCurDir="$( pwd )";   # echo "-1- aCurDir: '${aCurDir}', aArg1: ${aArg1}, mARGs[0]: '${mARGs[0]}'"
#   if [ -d "${aCurDir}/.git" ] && [ "${mARGs[0]}" == "" ]; then mARGs[0]="$( basename "${aCurDir}" )"; fi  ##.(21206.04.1)
    if [ -d "${aCurDir}/.git" ];                            then mARGs[0]="$( basename "${aCurDir}" )"; fi  # .(21206.04.1 RAM Use RepoDir name if valid)
                              # echo "-2- aCurDir: '${aCurDir}', mARGs[0]: '${mARGs[0]}'"

        getConfigFile ${mARGs[0]}; if [ "${nCfg}" == "0" ]; then cd ..
        getConfigFile ${mARGs[0]}; if [ "${nCfg}" == "0" ]; then cd ..
        getConfigFile ${mARGs[0]}; if [ "${nCfg}" == "0" ]; then
#       aConfigFile=""
#       echo  -e "  * Can't find a gitR Config File"
        sayMsg sp "gitR1[1053]  Can't find a gitR Config File" 1
        fi; fi; fi

#   for aFile in $( ls -1 *_gitr-config.sh ); do mConfigFiles+=${aFile}; done; fi
#       readarray -t mConfigFiles < <( ls -1 *-gitr-config.sh )

        sayMsg "gitR1[1059]  Sparse Edit:  found ${#mConfigFiles[@]} config files;   aRepoDir: '${aRepoDir}'" -1
        sayMsg "gitR1[1060]  aConfigFile: '${aConfigFile}', aProjName: '${aProjName}', aConfigDir: '${aConfigDir}'" -1
        sayMsg "gitR1[1061]  nCfg: ${nCfg}; mConfigFiles: ${mConfigFiles[@]}" -1

   if [ "${aConfigFile}" != "" ]; then
        source "${aConfigDir}/${aConfigFile}"
   if [ "${aRepoDir}"    != "" ]; then
           aRepoDir="${aWebsDir}/${aRepoDir}"
        fi; fi                                                                                              # .(21205.04.1 RAM End)

        sayMsg "gitR1[1069]  nCfg: ${nCfg}; aConfigFile: '${aConfigFile}', aRepoDir: '${aRepoDir}'" -1

   if [ "${aRepoDir}"    != "" ]; then cdDir "${aRepoDir}"; fi                                              # .(21211.01.2 RAM Was cd ${aRepoDir})
   if [ "${aRepoDir}"    == "" ]; then cdDir "${aCurDir}";  fi                                              # .(21211.01.3)

        sayMsg "gitR1[1074]  aConfigFile: '${aConfigFile}', aProject: '${aProject}', aStage: '${aStage}', pwd: '$( pwd )' " -1

        } # eof setConfigFile                                                                               # .(21212.02.2)
#  ---------------------------------------------------------------------------------------

   function cdDir( ) {                                                                                      # .(21211.01.1 RAM Beg Write cdDir)
    if [ -d "$1" ]; then cd "$1"; return; fi
        sayMsg "The folder, '$1', does not exist." 2
        }                                                                                                   # .(21211.01.1 RAM End)
#  ---------------------------------------------------------------------------------------

#====== =================================================================================================== #  ===========

        chkGitDir                                                                                           # .(20429.07.3 RAM).(20623.13.3 RAM Beg Move to here from above)

#       sayMsg "[897]  aBranch: '${aBranch}', aArg1: '${aArg1}'" 1                                          ##.(21223.03.3)
#       setBranch $1; if [ "${aBranch}" != "" ]; then shift; fi
        setBranch ${aArg1}
#       sayMsg "[897]  aBranch: '${aBranch}', aArg1: '${aArg1}', aArg2: '${aArg2}'" 1                       ##.(21223.03.3)

#       sayMsg "gitR1[1094]  Begin GitR Commands: aCmd: ${aCmd}" 1                                          # .(20623.13.3 RAM End Move to here from above)

#====== =================================================================================================== #  ===========
#       ADD COMMIT                                                                                          #
#====== =================================================================================================== #

  if [ "${aCmd}" ==  "Add Commit" ]; then
        sayMsg "gitR1[1101]  Add Commit"

        echo ""
#       echo "git commit -a -m \"${aArg1}\""
              git add -A   >/dev/null 2>&1
              git commit -m  "${aArg1}"  | awk '/changed|nothing/ { print "  "$0 }'

#       echo ""
     fi # eif Add Commit
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========
#       PUSH                                                                                                #
#====== =================================================================================================== #
        sayMsg "gitR1[1115]  Push"

  if [ "${aCmd}" ==  "Push" ]; then

        echo ""                                                                                             # .(21223.03.4)
        git push | awk '/changed|Everything/ { print "   " $0 }'                                            # .(21223.03.5 Added space)

        ${aLstSp}  # echo ""                                                                                # .(21127.08.2)
     fi # eif Push
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========
#       PULL                                                                                                #
#====== =================================================================================================== #
#       sayMsg "gitR1[1129]  Pull (${aCmd})" 1

function shoLastCommit() {                                                                                  # .(21212.06.1 RAM Beg)
aAWKpgm3='
    /commit/ { c=substr( $2, 1, 6 ) }; /Author:/ { sub( / <.+/, "" ); a=$0 }; /Date:/ { d=$2" "$3" "$4" "$5 };
     /^    / { m=substr( $0, 5 ); exit }
END          { print "   "c ", " d ", " substr( a, 9) ", \"" m "\"" }'
         git log -1 | awk "${aAWKpgm3}"
         }                                                                                                  # .(21212.06.1 RAM Beg)

  if [ "${aCmd}" ==  "Pull" ]; then
        setProjVars
        echo ""

    if [ "${aArg1}" == "all"    ]; then aArg1="-all";  fi                                                   # .(21212.06.1)
#   if [ "${aArg1}" == "-all"   ]; then $0 sparse off; aArg1="-hard"; exit; fi                              ##.(21212.06.2)
    if [ "${aArg1}" == "-all"   ]; then git sparse-checkout disable; aArg1="-hard"; fi                      # .(21212.06.2 RAM Turn it off)

    if [ "${aArg1}" == "hard"   ]; then aArg1="--hard"; fi                                                  # .(21127.03.2)
    if [ "${aArg1}" == "-hard"  ]; then aArg1="--hard"; fi                                                  # .(21127.03.3)
    if [ "${aArg1}" == "--hard" ]; then                                                                     # .(21127.03.4 RAM Beg Added)
#       git diff
#       echo "git reset --hard"
        git reset --hard | awk '{ print "   " $0 }'
        bReset=1
     else
        bReset=0
        fi                                                                                                  # .(21127.03.5 RAM End)
        sayMsg "gitR1[1157]  pull aOS: '${aOS}', aProject: '${aProject}', aProjDir: '${aProjDir}'"  -1

#       git pull 2>&1 | awk '/changed|Already/ { print "   " $0 }'                                          ##.(21129.02.1)
        aResult="$( git pull 2>&1 | awk       '{ print "   " $0 }' )"                                       # .(21129.02.1 RAM Beg)
#       echo "${aResult}";                                                                                  # .(21206.05.2 RAM Move to below)
        bErr=$( echo "${aResult}" | awk '/Aborting/ { print 1; exit }' ); if [ "${bErr}" != "1" ]; then bErr=0; fi
        bOK=$(  echo "${aResult}" | awk '/Already/  { print 1; exit }' ); if [ "${bOK}"  != "1" ]; then bOK=0; fi
#       echo "   --- \$bErr: ${bErr}"; # exit
#       sayMsg "gitR1[1165]  bOK: '${bOK}', bReset: '${bReset}'" 1;

    if [ "${bErr}" == "1" ]; then
        echo "${aResult}"                                                                                   # .(21206.05.3)
        echo -e "\n * Pull failed. Run: gitr pull -hard, to force pull of all repository files."
        ${aLstSp}; exit
        fi                                                                                                  # .(21129.02.1 RAM End)

    if [ "${bOK}" == "1" ]; then                                                                            # .(21206.05.4 RAM Beg)
        echo "${aResult/.} for ${aProjName}";
        shoLastCommit
        fi                                                                                                  # .(21206.05.4 RAM End)

    if [ "${bOK}" == "0" ] || [ "${bReset}" == "1" ]; then                                                  # .(21129.03.1)
    if [ "${aOS}" != "windows" ] && [ "${aProject}" == "FRTools" ]; then                                    # .(21111.02.1 RAM Beg)

function setA() { chmod 755 "$1"; echo "$1"; }

        if [  -d  "../${aProjDir}" ]; then aProjDir="../${aProjDir}"; fi;                                   # .(21127.03.6)
#       chmod -R 755 "${aProjDir}" *.sh                                                                     ##.(21127.03.7)
#       chmod -R 755 "${aProjDir}"                                                                          # .(21127.03.7).(21129.03.3)

#       find ${aProjDir}/._2/bin -type f       -iname "*"    -exec chmod 755 {} \;                          ##.(21129.03.2)
 n=( $( find ${aProjDir}/._2/bin -type f  -not -iname "*.*"  | while read file; do setA "$file"; done ) )   # .(21129.03.2)
#       find ${aProjDir}         -type f       -iname "*.sh" -exec chmod 755 {} \;                          ##.(21129.03.3)
 m=( $( find ${aProjDir}         -type f       -iname "*.sh" | while read file; do setA "$file"; done ) )   # .(21129.03.3)

#       echo -e "\n * $(( ${#m[@]} + ${#m[@]} )) FRTools script permissions have been reset."               ##.(21129.02.4 RAM End).(21201.04.1)
        echo -e "\n * ${#m[@]} FRTools script permissions have been reset."                                 # .(21201.04.1)
        echo -e   " * ${#n[@]} FRTools bin script permissions have been reset."                             # .(21201.04.2).(21129.02.4 RAM End)

#     else                                                                                                  ##.(21111.02.1 RAM End).(21129.02.2)
#       git pull 2>&1 | awk '/changed|Already/ { print "   "$0 }'                                           ##.(21129.02.3)
#       git pull 2>&1 | awk '{ print "   "$0 }'                                                             ##.(21129.02.4)

        fi; fi;  # eif bOK, Windows & FRTools                                                               # .(21129.03.4)

        ${aLstSp}                                                                                           # .(21127.08.2)
     fi # eif Pull
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========
#       FETCH                                                                                               #
#====== =================================================================================================== #
        sayMsg "gitR1[1209]  Fetch"

  if [ "${aCmd}" ==  "Fetch" ]; then

        echo ""
        git fetch | awk '/->/'

#       echo ""
     fi # eif Fetch
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========
#       FETCH ALL                                                                                           #
#====== =================================================================================================== #
        sayMsg "gitR1[1223]  Fetch All"

  if [ "${aCmd}" ==  "Fetch All" ]; then

        echo ""
        git fetch all

#       echo ""
     fi # eif Fetch All
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========
#       ADD REMOTE                                                                                          #
#====== =================================================================================================== #
        sayMsg "gitR1[1237]  Add Remote"

  if [ "${aCmd}" ==  "Add Remote" ]; then
#       sayMsg       "Add Remote not implemented yet" 2

#       setProjVars "${aBranch}"
        echo ""
        echo "  git remote add \"${aArg1}\" \"${aArg2}\""                                                # .(11127.03.1 RAM S.B. {aRepo} {aURL})
                git remote add  "${aArg1}"   "${aArg2}"                                                  # .(11127.03.2 RAM S.B. {aRepo})

#       echo ""
     fi # eif Add Remote
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========
#       RENAME REMOTE                                                                                       #
#====== =================================================================================================== #
        sayMsg "gitR1[1254]  Rename Remote"

  if [ "${aCmd}" ==  "Rename Remote" ]; then

     if [ "${aArg2}" == "" ]; then aArg2=${aArg1}; aArg1=; fi

                                         getCurRemote; # sayMsg "aRemote: ${aRemote}" 2
        aGit_Remote_Old=${aArg1}; if [ "${aGit_Remote_Old}" == "" ]; then aGit_Remote_Old=${aRemote};   fi
        aGit_Remote_New=${aArg2}; if [ "${aGit_Remote_New}" == "" ]; then
        sayMsg "You must provide a new remote name" 2
        fi

        echo "  git  remote rename \"${aGit_Remote_Old}\" \"${aGit_Remote_New}\""
                git  remote rename  "${aGit_Remote_Old}"   "${aGit_Remote_New}"

#       echo ""
     fi # eif Rename Remotes
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========
#       DELETE REMOTE                                                                                       #  # .(11127.01.5)
#====== =================================================================================================== #
        sayMsg "gitR1[1276]  Delete Remote"                                                                 # .(11127.01.6)

  if [ "${aCmd}" ==  "Delete Remote" ]; then                                                                # .(11127.01.7)

#       setProjVars "${aBranch}"
        echo ""
        echo "  git remote remove \"${aArg1}\""                                                             # .(11127.03.2 RAM S.B. {aRepo})
                git remote remove  "${aArg1}"                                                               # .(11127.03.2 RAM S.B. {aRepo})

#       echo ""
     fi # eif Remove Remote                                                                                 # .(11127.01.8)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========
#       LIST REMOTES
#====== =================================================================================================== #
        sayMsg "gitR1[1292]  List Remotes"

  if [ "${aCmd}" ==  "List Remotes" ]; then

        sayMsg "aCmd3: ${aCmd3}, aBranch: ${aBranch}" -1
        setProjVars "${aBranch}"

        echo shoGitRemotes1 "$@"

#       echo ""
     fi # eif List Remotes
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========
#       LIST REMOTE BRANCHES                                                                                #
#====== =================================================================================================== #
        sayMsg "gitR1[1308]  List Remote Branches";

  if [ "${aCmd}" ==  "List Remote Branches" ]; then

        aBranch=${PWD##*/};
        setProjVars "${aBranch}"

        bLocal=0;  if [ "${aCmd3/lo/}"  != "${aCmd3}" ]; then bLocal=1;  fi   # true if removed, i.e. no equal
        bRemote=0; if [ "${aCmd3/re/}"  != "${aCmd3}" ]; then bRemote=1; fi;
                if [ "${bLocal}${bRemote}" == "00" ]; then bLocal=1; bRemote=1; fi
        sayMsg "List Branch: ${aBranch:1}, aCmd3: ${aCmd3}, bLocal: ${bLocal}, bRemote: ${bRemote}" # 2

  if [ "${bRemote}" == "1" ]; then
        cd ..
        shoGitRemotes2  "                                  ${aBranch}"
        cd ${aBranch}
        fi

  if [ "${bLocal}" == "1"  ]; then

        echo "    Git Local Branches for .../${aProject}/${aBranch}"
#       echo "    -------------------------- -------  ---------------------------------------------"
        echo "    -------------------------------- -------  ---------------------------------------------"  # .(11127.02.5)

#       git branch  | awk '{ printf "    %-25s  %7s  %s\n", "", "", $0 }'
        git branch  | awk '{ printf "    %-31s  %7s  %s\n", "", "", $0 }'                                   # .(11127.02.6)
        fi

#       sayMsg "List Remote Branches" 1; echo ""
#       echo "    Remote Alias Name                         Branch Name"
#       echo "    -------------------------- -------  ---------------------------------------------"
        echo "    -------------------------------- -------  ---------------------------------------------"  # .(11127.02.7)

#       git branch -ra | awk -F'[/]' '{ if ($1 == "  remotes") { aRemote = $2; aBranch = "  "$3 } else { aBranch = $1 }; printf "    %-25s  %5s  %s\n", aRemote, "", aBranch }'

#       echo ""
     fi # eoc List Remote Branches
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========
#       CHECKOUT BRANCH                                                                                     #
#====== =================================================================================================== #
        sayMsg "gitR1[1350]  Checkout Branch"

     if [ "${aCmd}" ==  "Checkout Branch" ]; then
        bDebug=1
#       setProjVars "${aBranch}"

     if [ "${aArg2}" == "" ]; then aArg2=${aArg1}; aArg1=; fi
                                                                  getCurRemote;                             # sayMsg "aRemote: ${aRemote}" 2
        aGit_Remote=${aArg1}; if [ "${aGit_Remote}" == "" ]; then aGit_Remote=${aRemote}; fi                # .(10822.01.1)

                                                                  getCurBranch ${aGit_Remote};              # sayMsg "aBranch: ${aBranch}" 2
        aGit_Branch=${aArg2}; if [ "${aGit_Branch}" == "" ]; then aGit_Branch=${aBranch}; fi

        sayMsg "Checkout Branch: ${aRemote} ${aBranch}" 2


#       echo ""
     fi # eif Checkout Branch
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========
#        LIST REMOTES ALL                                                                                   #
#====== =================================================================================================== #
#       sayMsg "gitR1[1373]  List Remotes All"                                                              ##.(20623.13.4 RAM Beg Move from here to above)
#
# if [ "${aCmd}" ==  "List Remotes All" ]; then
#
#       ----------------------------------------------------------------------------
#        setProjVars
#
# if [ ! -d "${aProjDir}" ]; then
#       echo ""; echo " ** Project folder not found: '${aProjDir}'"; echo ""; exit
#    fi
#
#       echo "aProjDir: ${aProjDir}"
#       cd ${aProjDir};              # rdir "${aProjDir}"
#
# if [ -d ".git" ]; then                shoGitRemotes2 "        4096  2021-06-11 12:43  ./.git"; exit; fi
#
#       rdir . | awk '/-dev|-test|-prod/'
#
#       readarray -t    mFileList < <( rdir . -main   | awk 'NR > 3' | awk '!/-[dpt]/' ); sayMsg "For -main Repos"   1  # .(11125.01.1 RAM Was: Main)
#   for aFileStat in "${mFileList[@]}"; do shoGitRemotes2 "${aFileStat}"; done
#
#       readarray -t    mFileList < <( rdir . -master | awk 'NR > 3' | awk '!/-[dpt]/' ); sayMsg "For -master Repos" 1  # .(11125.01.2 RAM Was: Master)
#   for aFileStat in "${mFileList[@]}"; do shoGitRemotes2 "${aFileStat}"; done
#
#       readarray -t    mFileList < <( rdir "dev-"    | awk 'NR > 3' );                   sayMsg "For dev- Repos"    1  # .(11125.01.3 RAM Was: -dev)
#   for aFileStat in "${mFileList[@]}"; do shoGitRemotes2 "${aFileStat}"; done
#
#       readarray -t    mFileList < <( rdir "test-"   | awk 'NR > 3' );                   sayMsg "For test- Repos"   1  # .(11125.01.4 RAM Was: -test)
#   for aFileStat in "${mFileList[@]}"; do shoGitRemotes2 "${aFileStat}"; done
#
#       readarray -t    mFileList < <( rdir "prod-"   | awk 'NR > 3' );                   sayMsg "For prod- Repos"   1  # .(11125.01.5 RAM Was: -prod)
#   for aFileStat in "${mFileList[@]}"; do shoGitRemotes2 "${aFileStat}"; done
#
#       readarray -t    mFileList < <( rdir . docs-   | awk 'NR > 3' | awk '!/-[dpt]/' ); sayMsg "For docs- Repos"   1  # .(11125.01.6 RAM Added: docs-)
#   for aFileStat in "${mFileList[@]}"; do shoGitRemotes2 "${aFileStat}"; done
#
#       readarray -t    mFileList < <( rdir . tools-  | awk 'NR > 3' | awk '!/-[dpt]/' ); sayMsg "For tools- Repos"  1  # .(11125.01.7 RAM Added: tools-)
#   for aFileStat in "${mFileList[@]}"; do shoGitRemotes2 "${aFileStat}"; done
#
#    fi # eoc List Remotes All                                                                              ##.(20623.13.4 RAM End Move from here to above)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========
#       LIST REMOTE COMMITS xx
#====== =================================================================================================== #
        sayMsg "gitR1[1418]  List Remote Commits xx"

  if [ "${aCmd}" ==  "List Remote Commits xx" ]; then

        aGit_Repo=${aProject}; if [ "${aProject}"  == "" ]; then aGit_Repo=nusvs; fi
        aGit_Host=$1;          if [ "${aGit_Host}" == "" ]; then aGit_Host=git-suzee-account; fi
        aGit_User=$2;          if [ "${aGit_User}" == "" ]; then aGit_User=suzeeparker;  fi

        echo ""
#       echo "    3: $3, 4: $4, 5: $5"
#       echo "    aGit_Repo: ${aGit_Repo}, aGit_Host: ${aGit_Host} aGit_User: ${aGit_User}"
#       echo "    git ls-remote git-suzee-key:suzeeparker/nusvs.git"
        echo "    git ls-remote ${aGit_Host}:${aGit_User}/${aGit_Repo}.git"
        echo ""
        echo "    Commit       Comment"
        echo "    -------  -------------------------------"
#                 git ls-remote ${aGit_Host}:${aGit_User}/${aGit_Repo}.git | awk '{ printf "    %7s  %s\n", substr($1,1,7), $2 }'

        aCmd="git ls-remote ${aGit_Host}:${aGit_User}/${aGit_Repo}.git";
        mResults=$( bash -c "( ${aCmd} )" 2>&1               );
#       mResults=$( bash -c "( ${aCmd} )" 2>&1 | sort -k1.47 ) # .(21128.05.3 RAM Sort)

# if [ ${?} -ne 0 ]; then
#       echo " ** Git Repo, ${aGit_Repo}, not found for Account, ${aGit_User}, using SSH_Key, ${aGit_Host}."
#     else

  if [ "${mResults:0:5}" == "fatal" ]; then
        sayMsg " ** Git Error." 3
        sayMsg "    ${mRemotes}." 3
        exit
        fi

#       sayMsg "gitR1[1450]  mResults: ${mResults}" 1
  if [ "${mResults}" == "" ]; then
          echo "  * No Commits found for Repo, ${aGit_Repo}, for Account, ${aGit_User}, using SSH_Key, ${SSH_Key}."
       else
    for aResult in "${mResults[@]}"; do
        echo "${aResult}" | awk '{ printf "    %7s  %s\n", substr($1,1,7), $2 }'
        done
        fi;

        echo ""
     fi # List Remote Commits
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========
#       LIST LOCAL/REMOTE COMMITS
#====== =================================================================================================== #
        sayMsg "gitR1[1466]  ${aCmd}, nDays: '${nDays}'"                                                                    # .(21122.04.0 nDays Not assigned yet)

  if [ "${aCmd}"  == "List All Commits"    ]; then aCmd="List Remote Commits"; bBoth=1; fi                                  # .(30108.01.1 RAM Beg)
  if [ "${bBoth}" == "1" ]; then

        gitr list commits local  -y ${nDays} ${aArg1} | awk 'NF > 0'            >gitr.@tmp
        gitr list commits remote -y ${nDays} ${aArg1} | awk 'NF > 0 && NR > 4' >>gitr.@tmp

        echo ""
        cat gitr.@tmp | awk 'NR < 2'
#       echo "    Local Dir/Remote Alias   Branch              Date    Time   Commit   Author            Commit Message"    ##.(30108.02.1)
#       echo "    -----------------------  ---------------  ----------------  -------  ----------------  --------------"    ##.(30108.01.2).(30108.02.1)
        echo "    LocalDir/RemoteAlias  Branch                 Date    Time   Commit   Author            Commit Message"    # .(30108.02.1)
#       echo "    --------------------  ------------------  ----------------  -------  ----------------  --------------"    ##.(30108.01.2).(30108.02.2)
#       echo "    -----------------------  ---------------  ----------------  -------  ----------------  -----------------------------------"   # .(11127.02.8)
#       echo "    -----------------------  ---------------  ----------------  -------  ----------------  -------------------------------------------------------"
        cat gitr.@tmp | awk 'NR > 4' | sort -k1.45
        exit
        fi                                                                                                                  # .(30108.01.1 RAM End)

  if [ "${aCmd}" ==  "List Local Commits"  ]; then aCmd="List Remote Commits"; fi                                           # .(20122.04.2)
  if [ "${aCmd}" ==  "List Remote Commits" ]; then

  if [ "${aCmd2/lo/}" == "${aCmd2}" ] && [ "${aCmd3/lo/}" == "${aCmd3}" ]; then bLocal=0; else bLocal=1; fi                 # .(10824.02.1 RAM)

     aDO="-y";  # aDO="-d"                                                                                 # .(21122.04.1 RAM Beg Change -Days option)
     if [ "${nDays}"     == ""   ]; then nDays=14;
     if [ "${aArg1:0:2}" == $aDO ]; then nDays=$aArg2; aArg1="$aArg3"; aArg2="$aArg4"; aArg3="$aArg5"; aArg4="$aArg6"; aArg5="$aArg7"; fi
     if [ "${aArg2:0:2}" == $aDO ]; then nDays=$aArg3;                 aArg2="$aArg4"; aArg3="$aArg5"; aArg4="$aArg6"; aArg5="$aArg7"; fi
     if [ "${aArg3:0:2}" == $aDO ]; then nDays=$aArg4;                                 aArg3="$aArg5"; aArg4="$aArg6"; aArg5="$aArg7"; fi
     if [ "${aArg4:0:2}" == $aDO ]; then nDays=$aArg5;                                                 aArg4="$aArg6"; aArg5="$aArg7"; fi
     if [ "${aArg5:0:2}" == $aDO ]; then nDays=$aArg6;                                                                 aArg5="$aArg7"; fi
     if [ "${aArg6:0:2}" == $aDO ]; then nDays=$aArg7;                                                                                 fi
                                                       fi;                                                                  # .(21122.04.1 RAM End)
     if [ "${nDays}"     == ""   ]; then nDays=14;     fi;                                                                  # .(21122.04.2 Added fi)
        setProjVars                                                                                                         # .(20122.01.1)
#       aStage=$(  echo "${aPath1}" | awk '{ n = split( $0, a, /\// ); print a[n] }' )                                      # .(20122.01.2)
        aStage=$(  echo "${aPath1}" | awk '{     split( $0, a, /\// ); print a[3] }' )                                      # .(20122.01.2 RAM Assumes path: "nodeapps/{Project}/{Stage}")

#       sayMsg "gitR1[1505]  nDays: '${nDays}', bLocal: '${bLocal}', aArg1: '${aArg1}', aArg2: '${aArg2}', aArg3: '${aArg3}', aArg4: '${aArg4}', bDoit: '${bDoit}', bDebug: '${bDebug}', bQuiet: '${bQuiet}'" 2
#       sayMsg "gitR1[1506]  aStage: ${aStage}; aPath1: '${aPath1}'" 2

        mResults=$( bash -c "( git branch )" 2>&1               ) # .(21128.05.4 RAM Sort)
#       mResults=$( bash -c "( git branch )" 2>&1 | sort -k1.47 ) ##.(21128.05.4 RAM Sort)

  if [ "${mResults:0:5}" == "fatal" ]; then
        sayMsg " ** Git Error." 3
        sayMsg "    ${mResults}." 3
        exit
        fi
                                                                  getCurRemote;                 #  sayMsg "[1253]  aRemote: ${aRemote}, aArg1: '${aArg1}'" 1
#       aGit_Remote=${aArg1}; if [ "${aGit_Remote}" == "" ]; then aGit_Remote=Bruce_FormR-test; fi                          ##.(10821.01.7)
#       aGit_Remote=${aArg1}; if [ "${aGit_Remote}" == "" ]; then aGit_Remote=$( git remote );  fi                          ##.(10821.01.7)
#       aGit_Remote=${aArg1}; if [ "${aGit_Remote}" == "" ]; then aGit_Remote=${aRemote};       fi                          ##.(10822.01.7).(21223.04.1)
                                                                  aGit_Remote=${aRemote}                                    # .(21223.04.1 RAM Arg1 can be a branch name only)
#       sayMsg "gitR1[1521]  aRemote: ${aGit_Remote}" 2
                                                                  getCurBranch ${aGit_Remote};  # sayMsg "aBranch: ${aBranch}" 2
#       aGit_Branch=${aArg2}; if [ "${aGit_Branch}" == "" ]; then aGit_Branch=${aBranch}; fi                                ##.(10822.01.8).(21223.04.2)
        aGit_Branch=${aArg1}; if [ "${aGit_Branch}" == "" ]; then aGit_Branch=${aBranch}; fi                                # .(21223.04.2)
#       aGit_Branch=${aArg2}; if [ "${aGit_Branch}" == "" ]; then aGit_Branch=$( git branch | awk '/\*/ { print $2 }' ); fi ##.(10821.01.8).(21223.04.2)
#       aGit_Branch=${aArg2}; if [ "${aGit_Branch}" == "" ]; then aGit_Branch=main; fi                                      ##.(10821.01.8)
#       sayMsg "gitR1[1527]  aGit-Branch: '${aGit_Branch}'; aGit-Remote: '${aGit_Remote}'" 1

#       sayMsg "gitR1[1529]  aPath: '${aGit_Remote}'" 1
        aPath=${aGit_Remote}; if [ "${aGit_Branch}" != "" ]; then aPath=${aPath}/${aGit_Branch}; fi;                        # Includes remote/)
#       sayMsg "gitR1[1531]  aPath: /remotes\/${aPath/\//\\/}/" 1

        aPath=$( git branch -va | awk '/remotes\/'${aPath/\//\\/}'/ { sub( /remotes\//, ""); print $1 }' )                  # .(21223.04.3)
#       sayMsg "gitR1[1534]  aPath: ${aPath}" 2

#    if [ "${aGit_Remote}" == "" ] && [ "${bLocal}" == "0" ] ; then bLocal=1;                                               ##.(10827.01.1 Beg RAM If no remote).(21223.04.4)
     if [ "${aPath}"       == "" ] && [ "${bLocal}" == "0" ] ; then bLocal=1;                                               # .(10827.01.1 Beg RAM If no remote).(21223.04.4)
           echo ""; echo "  * No Remotes are defined for this Branch, '${aGit_Branch}'."                                    # .(21223.04.5 RAM Was Repository)
           exit                                                                                                             # .(21223.04.6)
           fi                                                                                                               # .(10827.01.1 End)
     if [ "${bLocal}" == "1" ]                              ; then aPath="${aGit_Branch}"; fi                               ##.(10827.01.1)
#    if [ "${bLocal}" == "1" ] || [ "${aGit_Remote}" == "" ]; then aPath="${aGit_Branch}"; fi                               # .(10827.01.1 RAM If no remote)

        aSince=""; if [ "${nDays}" != "0" ]; then aSince="--since=\"${nDays} days ago\" "; fi
  if [ "${aSince}" == "" ]; then
        sayMsg sp "Commits for '${aPath}' since day 1" 1;
   else
        sayMsg sp "Commits for '${aPath}' since ${aSince:8}" 1; # echo ""  # 2b0a8aa 2021-06-01 Bruce Troutman Finished Hardening
     fi
#       echo "    git log '${aPath}' ${aSince}--date=format:'%Y-%m-%d %H:%M' --oneline --format=\"%h %ad %cn %s\" | sort -k1.9"; echo "" ##.(21223.03.4).(21223.04.7 RAM Sort it).(30104.01.6)

if [ "${bLocal}" == "1" ]; then

#       echo "    Local Dir                Branch              Date    Time   Commit   Author            Commit Message"    ##.(30108.02.3)
        echo "    Local Dir             Branch                 Date    Time   Commit   Author            Commit Message"    # .(30108.02.3)

#       aGit_Remote="${aStage} (local)"                                                                                     ##.(20122.01.3 RAM Was: "")
        aGit_Remote="${aStage}"                                                                                             # .(20122.01.3 RAM Was: "")
        if [ "${aStage}" == "" ]; then aGit_Remote="${aPath1}"; fi                                                          # .(30104.01.7)
        aLorR=" L"; aLorR_Name=" Local"                                                                                     # .(20122.01.3 RAM Added).(21223.03.5)
   else
        echo "    Remote Alias Name        Branch              Date    Time   Commit   Author            Commit Message"    ##.(30108.02.4)
        echo "    Remote Alias Name     Branch                 Date    Time   Commit   Author            Commit Message"    # .(30108.02.4)
#       aGit_Remote="${aGit_Remote} (remote)"                                                                               ##.(20122.01.4 RAM Added)
        aLorR=" R"; aLorR_Name="Remote"                                                                                     # .(20122.01.4 RAM Added).(21223.03.6)
     fi
#       echo "    -----------------  ---------------  ----------------  -------  ----------------  -----------------------------------"
#       echo "    -----------------------  ---------------  ----------------  -------  ----------------  -----------------------------------"   # .(11127.02.8).(30108.01.3)
#       echo "    -----------------------  ---------------  ----------------  -------  ----------------  --------------"    ##.(30108.01.3).(30108.02.5)
        echo "    --------------------  ------------------  ----------------  -------  ----------------  --------------"    # .(30108.01.3).(30108.02.5)

#       aRemote1=${aGit_Remote}; if [ "${#aRemote1}" -gt 23 ]; then aRemote1="${aRemote1:0:20}..."; fi                      ##.(21223.03.7).(30108.02.6)
#       aBranch1=${aGit_Branch}; if [ "${#aBranch1}" -gt 15 ]; then aBranch1="${aBranch1:0:12}..."; fi                      ##.(21223.03.8).(30108.02.7)
        aRemote1=${aGit_Remote}; if [ "${#aRemote1}" -gt 20 ]; then aRemote1="${aRemote1:0:17}..."; fi                      # .(21223.03.7).(30108.02.6)
        aBranch1=${aGit_Branch}; if [ "${#aBranch1}" -gt 18 ]; then aBranch1="${aBranch1:0:15}..."; fi                      # .(21223.03.8).(30108.02.7)

#       aPath=${aRemote1};       if [ "${aBranch1}"  !=  "" ]; then aPath=${aPath}/${aBranch1}; fi;                         ##.(21223.03.9)
        aBranch1=${aBranch1};    if [ "${aBranch1}"  ==  "" ]; then aBranch1="??"; fi;                                      # .(21223.03.10)
#       sayMsg "gitR1[1579]  aPath: ${aPath}" 2

#       aRemote="\"${aGit_Remote}\", \"${aGit_Branch}\", \$1, \$2, \$3, \$4"; sayMsg "aRemote: ${aRemote}" 1
#       aPrg="{ printf \"    %-18s %-15s %10s  %7s  %-17s %s\n\", \"${aGit_Remote}\", \"${aGit_Branch}\", \$2,         \$1, \$3, \$4 }";                   # sayMsg "aPrg: ${aPrg}" 2
#       aPrg="{ printf \"    %-18s %-15s %16s  %7s  %-17s %s\n\", \"${aGit_Remote}\", \"${aGit_Branch}\", \$2\" \"\$3, \$1, \$4, \$5 }";                   # sayMsg "aPrg: ${aPrg}" 2
#       aPrg="{ printf \"    %-18s %-15s %16s  %7s  %-17s %s\n\", \"${aGit_Remote}\", \"${aGit_Branch}\", \$2,    \$3, \$1, \$4, \$5 }";                     sayMsg "aPrg: ${aPrg}" 1
#       aPrg="{ printf \"    %-18s %-16s %16s  %7s  %-17s %s\n\", \"${aGit_Remote}\", \"${aGit_Branch}\", \$2,         \$1, \$3, \$4; n++; d=\$2 }";       # sayMsg "aPrg: ${aPrg}" 2
#       aPrg="{ printf \"    %-24s %-16s %16s  %7s  %-17s %s\n\", \"${aGit_Remote}\", \"${aGit_Branch}\", \$2,         \$1, \$3, \$4; n++; d=\$2 }";       # sayMsg "aPrg: ${aPrg}" 2   # .(11127.02.9)
#       aPrg="{ printf \" %s %-24s %-16s %16s  %7s  %-17s %s\n\", \"${aLorR}\", \"${aGit_Remote}\", \"${aGit_Branch}\",\$2, \$1, \$3, \$4; n++; d=\$2 }";  # sayMsg "aPrg: ${aPrg}" 2   ##.(11127.02.9).(20122.01.6).(21223.03.11)
#       aPrg="{ printf \" %s %-24s %-16s %16s  %7s  %-17s %s\n\", \"${aLorR}\", \"${aRemote1}\", \"${aBranch1}\", \$2, \$1, \$3, \$4; n++; d=\$2 }";       # sayMsg "aPrg: ${aPrg}" 2   ##.(11127.02.9).(20122.01.6).(21223.03.11).(21223.05.1)
#       aPrg="{ printf \" %s %-24s %-16s %16s  %7s  %-17s %s\n\", \"${aLorR}\", \"${aRemote1}\", \"${aBranch1}\", \$2, \$1, \$3, \$4; n++; }";             # sayMsg "aPrg: ${aPrg}" 2   ##.(11127.02.9).(20122.01.6).(21223.03.11).(21223.05.1 RAM Remove d=).(30108.02.8)
        aPrg="{ printf \" %s %-21s %-19s %16s  %7s  %-17s %s\n\", \"${aLorR}\", \"${aRemote1}\", \"${aBranch1}\", \$2, \$1, \$3, \$4; n++; }";             # sayMsg "aPrg: ${aPrg}" 2   # .(11127.02.9).(20122.01.6).(21223.03.11).(21223.05.1 RAM Remove d=).(30108.02.8)

#       aPrg="${aPrg} END { printf \"%3d Commits for '${aPath}' since '${aSince:8} days ago'\", n }";                           # sayMsg "aPrg: ${aPrg}" 2
#       aPrg="${aPrg} END { printf \"%3d Commits for '${aPath}' since %s\", n, d ? d : \"then\"   }";                           # sayMsg "aPrg: ${aPrg}" 2   ##.(21223.03.12)
#       aPrg="${aPrg} END { printf \"    %s Commits for %-19s since: %-20s\", n, \"'${aPath}'\", (d ? d : \"then\") }";         # sayMsg "aPrg: ${aPrg}" 2
#       aPrg="${aPrg} END { printf \"   %3d Commits for Branch, '${aBranch1}', since %s\", n, d ? d : \"then\"   }";            # sayMsg "aPrg: ${aPrg}" 2   ##.(21223.03.12)
        aPrg="${aPrg} END { printf \"         %3d Commits for ${aLorR_Name} Branch, since %s\", n, d ? d : \"sometime ago\" }"; # sayMsg "aPrg: ${aPrg}" 2   # .(21223.03.12 RAM Was then)
        aPrg="NR == 1 { d=\$2 }; ${aPrg}";                                                                                      # sayMsg "aPrg: ${aPrg}" 2   # .(21223.05.2)

#       git log ${aPath} -n 25                 --oneline --format="%h|%as|%cn|%s" | awk -F'[|]' '{ printf "    %7s  %10s  %-17s %s\n", $1, $2, $3, $4 }'
#       git log ${aPath} --since="2021-07-25"  --oneline --format="%h|%as|%cn|%s" | awk -F'[|]' '{ printf "    %7s  %10s  %-17s %s\n", $1, $2, $3, $4 }'
#       git log ${aPath} --since="20 days ago" --oneline --format="%h|%as|%cn|%s" | awk -F'[|]' '{ printf "    %7s  %10s  %-17s %s\n", $1, $2, $3, $4 }'
#       git log ${aPath} "${aSince}"           --oneline --format="%h|%as|%cn|%s" | awk -F'[|]' '{ printf "    %-15s %-15s %7s  %10s  %-17s %s\n", ${aRemote} }'
#       git log ${aPath} "${aSince}" --date=format:'%Y-%m-%d %H:%M' --oneline --format="%h|%ad|%cn|%s"

  if [ "${aSince}" == "" ]; then
#       git log ${aPath}             --date=format:'%Y-%m-%d %H:%M' --oneline --format="%h!%ad!%cn!%s" | awk -F'[!]' -e "${aPrg}"                ##.(21122.04.4 RAM Swap ! for |).(21128.05.5)
        git log ${aPath}             --date=format:'%Y-%m-%d %H:%M' --oneline --format="%h!%ad!%cn!%s" | awk -F'[!]' -e "${aPrg}" | sort -k1.45  # .(21122.04.4 RAM Swap ! for |).(21128.05.5)
    else
#       git log ${aPath} "${aSince}" --date=format:'%Y-%m-%d %H:%M' --oneline --format="%h!%ad!%cn!%s" | awk -F'[!]' -e "${aPrg}" | sort         ##.(21122.04.5).(21128.05.6)
        git log ${aPath} "${aSince}" --date=format:'%Y-%m-%d %H:%M' --oneline --format="%h!%ad!%cn!%s" | awk -F'[!]' -e "${aPrg}" | sort -k1.45  # .(21122.04.5).(21128.05.6)
     fi

#       mRecs=$( bash -c "( git log ${aPath} "${aSince}" --date=format:'%Y-%m-%d %H:%M' --oneline --format="%h|%ad|%cn|%s" )" )
#       echo "Count: ${mRecs[@]} \"${aPath}\" since ${aSince:8}"

        echo ""
     fi # eoc List Remote Commits
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========
#       COUNT REMOTE COMMITS
#====== =================================================================================================== #
        sayMsg "gitR1[1623]  Count Remote Commits";

  if [ "${aCmd}" ==  "Count Remote Commits" ]; then

  if [ "${aCmd3/al/}" != "${aCmd3}" ] || [ "${aCmd2}" == "co-al" ]; then
        echo ""; IFS=$'\n'
        mRemoteBranches=( $( gitr list branch remote | awk '$2 == "/" { print }' ) )
    for aRemoteBranch in "${mRemoteBranches[@]}"; do # sayMsg "aRemoteBranch: ${aRemoteBranch}" 1
        aRemote=$( echo ${aRemoteBranch} | awk '{ print $1 }' )
        aBranch=$( echo ${aRemoteBranch} | awk '{ print $3 }' )
        gitr list remote commits -d 0 ${aRemote} ${aBranch} | awk '/[0-9]+ Commits for/ { printf "%5d Commits for %-30s since %s %s\n", $1, $4, $6, $7 }'
        done
    else
        echo ""
        gitr list remote commits -d 0 ${aArg1} ${aArg2} ${aArg3} ${aArg4} ${aArg5} ${aArg6} | awk '/[0-9]+ Commits for/ { print "    "$0 }'
     fi
        echo ""
     fi # eoc Count Remote Commits
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========
#       COUNT LOCAL COMMITS                                                                                 #
#====== =================================================================================================== #
        sayMsg "gitR1[1646]  Count Local Commits";

  if [ "${aCmd}" ==  "Count Local Commits" ]; then

  if [ "${aCmd3/al/}" != "${aCmd3}" ] || [ "${aCmd2}" == "co-al" ]; then
        echo ""; IFS=$'\n'
        mRemoteBranches=( $( gitr list branch remote | awk '$2 == "/" { print }' ) )
    for aRemoteBranch in "${mRemoteBranches[@]}"; do # sayMsg "aRemoteBranch: ${aRemoteBranch}" 1
        aRemote=$( echo ${aRemoteBranch} | awk '{ print $1 }' )
        aBranch=$( echo ${aRemoteBranch} | awk '{ print $3 }' )
        gitr list local commits -d 0 ${aRemote} ${aBranch} | awk '/[0-9]+ Commits for/ { printf "%5d Commits for %-30s since %s %s\n", $1, $4, $6, $7 }'
        done
    else
        echo ""
        gitr list local commits -d 0 ${aArg1} ${aArg2} ${aArg3} ${aArg4} ${aArg5} ${aArg6} | awk '/[0-9]+ Commits for/ { print "    "$0 }'
     fi
        echo ""
     fi # eoc Count Local Commits
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========
#       SPARSE [REFRESH] ON | OFF [EDIT]                                                                    # .(21025.01.4 RAM Beg Add )
#====== =================================================================================================== #
        sayMsg "gitR1[1669]  aCmd: ${aCmd}, aCmd2: ${aCmd2}, aCmd3: ${aCmd3}," -1

  if [ "${aCmd}" ==  "Sparse" ]; then
#       sayMsg       "Sparse not implemented yet. aCmd2: ${aCmd2}, ${aArg1}" 2

  if [ "${aCmd2}" == "sp-ed"  ]; then                                                                       # .(21204.01.7 RAM Beg Add Sparse Edit)
     if [ "${aProject}" == "" ]; then
        sayMsg "Can't find a gitR config file to edit" 2
        fi
        aDebug=""; if [ "${bDebug}" == "1" ]; then echo ""; aDebug="-debug"; fi                             # .(21205.01.1 RAM Add -debug)
        gitr clone ${aProject} -edit "${aDebug}"                                                            # .(21205.01.2)
        fi                                                                                                  # .(21204.01.7 RAM End)

        bSay=0
  if [ "${aCmd2}" == "sp-of" ] || [ "${aCmd3}" == "sp-re-of" ]; then                                        # .(21204.01.8 RAM Beg Add Sparse Refresh On)
        git sparse-checkout disable
        if [ "$( git config --worktree core.sparsecheckout )" == "true" ]; then aOnOff="On"; else aOnOff="Off"; fi
        echo -e "\n  Git Sparse has been set to: ${aOnOff}"; bSay=1
        fi                                                                                                  # .(21204.01.8 RAM End)

  if [ "${aCmd2}" == "sp-on" ] || [ "${aCmd3}" == "sp-re-on" ]; then                                        # .(21204.01.9 RAM Beg Add Sparse Refresh Off)
        git config --worktree core.sparsecheckout true
        if [ "$( git config --worktree core.sparsecheckout )" == "true" ]; then aOnOff="On"; else aOnOff="Off"; fi
        echo -e "\n  Git Sparse has been set to: ${aOnOff}"; bSay=1
        git sparse-checkout reapply
        fi                                                                                                  # .(21204.01.9 RAM End)

  if [ "${aCmd2}" == "sp-re" ]; then                                                                        # .(21204.01.10 RAM Beg Add Sparse Edit)
        if [ "$( git config --worktree core.sparsecheckout )" == "true" ]; then aOnOff="On"; else aOnOff="Off"; fi
        if [ "${bSay}" == "0" ]; then echo -e "\n  Git sparse is now ${aOnOff}"; fi
        if [ "${aOnOff}" == "On" ]; then
        git sparse-checkout reapply; fi
        rss dirlist 2 3 | awk '{ print " " $0 }'
        fi                                                                                                  # .(21204.01.10 RAM End)

  if [ "${aCmd2}" == "sp-li" ]; then                                                                        # .(21026.01.3 RAM Beg Add Sparse List)
        if [ "$( git config --worktree core.sparsecheckout )" == "true" ]; then aOnOff="On"; else aOnOff="Off"; fi

        echo -e "\n  Repository Sparse Folders  (Sparse is: ${aOnOff})"
        echo  "  -------------------------------------------"
#       git sparse-checkout list 2>&1      | awk '{ print "    " $0 }'
        cat ./.git/info/sparse-checkout    | awk '{ printf "    %2d) %s\n", NR, $0 }'

    if [ "1" == "0" ]; then
        echo -e "\n  ${aConfigDir}/${aConfigFile}"
#       echo -e "\n  ${aConfigFile}"
        echo  "  ----------------------------------------------------------"
#       cat "${aConfigDir}/${aConfigFile}" | awk            '/    Apps/ { gsub( /[")]/, ""); print (i++) ") " substr( $0, 12 ) }'
        cat "${aConfigDir}/${aConfigFile}" | awk '/#/ { next }; / Apps\+/ { gsub( /[(+=")]/, "" ); sub( /^ +Apps +/, ""); printf "%2d) %s\n", i++, $0 }'
        fi

        fi # eif sparse list                                                                                # .(21026.01.3 End)

  if [ "${aArg1:0:2}" == "di" ]; then
        rss dirlist 1 3
        fi

        ${aLstSp}
     fi # eoc Next Command                                                                                  # .(21025.01.4 End)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========
#
#        BACKUP ${aRepoDir} FOLDER                                                                          # .(21204.02.4 RAM Beg Add Backup command)
#
#====== =================================================================================================== #  ===========
#       sayMsg "gitR1[1735]  aCmd: ${aCmd}" 1

  if [ "${aCmd}" == "Backup" ]; then
#       sayMsg      "Backup Command not implemented yet" 1

        cd "${aWebsDir}"
        sayMsg "gitR1[1741]  aWebsDir: ${aWebsDir}"; echo "aCurrDir: $( pwd )" -1
        sayMsg "gitR1[1742]  Using Gitr config file: ${aConfigFile}" -1
        sayMsg "gitR1[1743]  aArg1: ${aArg1}, aArg2: ${aArg2}" -1

                                           bZip=0; bCpy=1
        if [ "${aArg1}" == "-zip"  ]; then bZip=1; bCpy=0; fi
        if [ "${aArg2}" == "-zip"  ]; then bZip=1; bCpy=0; fi
        if [ "${aArg1}" == "-copy" ]; then bCpy=1; fi
        if [ "${aArg2}" == "-copy" ]; then bCpy=1; fi
#   -----------------------------------------------------------------

 if [ -d "${aRepoDir}/.git" ] && [ "${bCpy}" == "1" ]; then                     # .(21029.01.1 RAM Beg Copy repo to ${aRepoDir}_v${aTS})

    aTS=$( date '+%y%m%d.%H%M' ); aTS=${aTS:1}
    if [ ! -d "${aRepoDir}_v${aTS}" ]; then mkdir  "${aRepoDir}_v${aTS}"; fi    # .(21030.01.1 RAM Don't remove _)
    echo -e "\n  Backing up to '${aWebsDir}/${aRepoDir}_v${aTS}'"
#   cp -pr "${aRepoDir}"/*  "${aRepoDir}_v${aTS}";
    cp -pa "${aRepoDir}"/.  "${aRepoDir}_v${aTS}";
    fi                                                                          # .(21029.01.1 RAM End)
#   -----------------------------------------------------------------

 if [ -d "${aRepoDir}/.git" ] && [ "${bZip}" == "1" ]; then                     # .(21029.01.2 RAM Beg Zip repo to ${aRepoDir}_v${aTS}.zip)

    aTS=$( date '+%y%m%d.%H%M' ); aTS=${aTS:1}
    aZipFile="${aRepoDir}_v${aTS}.zip"                                          # .(21030.01.2 RAM Don't remove _)
    if [ -f "${aZipFile}" ]; then rm "${aZipFile}"; fi
    echo -e "\n  Ziping into '${aZipFile}'"
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
         fi                                                                                 # .(21127.08.3)
     fi
        ${aLstSp}
     fi # eoc Backup Command                                                                                # .(21204.02.4 RAM End)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========
#       NEXT COMMAND                                                                                        # .(ymmdd.nn.4 USR Beg Added NEXT command)
#====== =================================================================================================== #
        sayMsg "gitR1[1797]  ${aCmd}" # 1

  if [ "${aCmd}" ==  "Next Command" ]; then
        sayMsg       "Next Command not implemented yet" 2

        echo "    $( dirname $0 )/command_u1.01.sh" "${aArg1}" "${aArg2}" "${aArg3}"
#                "$( dirname $0 )/command_u1.01.sh" "${aArg1}" "${aArg2}" "${aArg3}"

        ${aLstSp}
     fi # eoc Next Command                                                                                  # .(ymmdd.nn.4 End)
#    -- --- ---------------  =  ------------------------------------------------------  #  ---------------- #

#====== =================================================================================================== #  ===========
#       END                                                                                                 #
#========================================================================================================== #  ===============================  #
