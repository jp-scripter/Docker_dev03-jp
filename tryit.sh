#!/bin/bash

# docker run -d --name dummy -v myvol:/root alpine tail -f /dev/null
#        cp foo2.txt dummy:/root/foo2.txt  # no workie
# docker cp foo2.txt dummy:/root/foo2.txt

          nTest=$1; if [ "${nTest}" == "" ]; then nTest=1; fi 

# --------------------------------------------------------------------

  if [ "${nTest}" == "1" ]; then 
#       aLDir=data 
        aLDir= 
        aRDir=vol1
        aVolume=vol1
        aContainer=dummy
        aImage="alpine:latest"  
        fi   
# --------------------------------------------------------------------

  if [ "${nTest}" == "2" ]; then 
#       aLDir=data 
        aLDir=vol1 
        aRDir=vol2 
        aVolume=vol1    
        aContainer=dummy
        aImage="alpine:latest"  
        fi   
# --------------------------------------------------------------------

  if [ "${nTest}" == "3" ]; then 
#       aLDir=data 
        aLDir=vol2 
        aRDir=root/vol1 
        aVolume=vol2    
        aContainer=dummy
        aImage="alpine:latest"  
        fi   
# --------------------------------------------------------------------

  if [ "${nTest}" == "4" ]; then 
#       aLDir=data 
        aLDir=webs/vol2 
        aRDir=root 
        aVolume=root/vol1    
        aContainer=dummy
        aImage="alpine:latest"  
        fi   
# --------------------------------------------------------------------

  if [ "${nTest}" == "5a" ]; then 
#       aLDir=data 
        aLDir="FRApps" 
        aRDir="workspaces/FRApps"
        aVolume="FRApps"
        aContainer="FRApps_dev04-robin"
        aImage="alpine:latest"  
        fi   
# --------------------------------------------------------------------

  if [ "${nTest}" == "6a" ]; then 
#       aLDir=data 
        aLDir="FRApps_/dev04-robin" 
        aRDir="FRApps_/dev04-robin"
        aVolume="FRApps_dev04-robin"
        aContainer="FRApps_dev04-robin"
        aImage="alpine:latest"  
        fi   
# --------------------------------------------------------------------

  if [ "${nTest}" == "6b" ]; then 
#       aLDir=data 
        aLDir="FRApps_/dev04-robin" 
        aRDir="workspaces/FRApps_/dev04-robin"
        aVolume="workspaces/FRApps_dev04-robin"
        aContainer="FRApps_dev04-robin"
        aImage="alpine:latest"  
        fi   
# --------------------------------------------------------------------


  if [ "${nTest}" == "5" ]; then 
#       aLDir=data 
        aLDir="workspaces/FRApps_/dev04-robin" 
        aRDir="workspaces/FRApps_/dev04-robin"
        aVolume="FRApps_dev04-robin"
        aContainer="FRApps_dev04-robin"
        aImage="alpine:latest"  
        fi   
# --------------------------------------------------------------------

  if [ "${nTest}" == "8b" ]; then 
#       aLDir=data 
        aLDir="workspaces/FRApps" 
        aRDir="workspaces/FRApps"
        aVolume="workspaces/FRApps_dev04-robin"
        aContainer="FRApps_dev04-robin"
        aImage="alpine:latest"  
        fi   
# --------------------------------------------------------------------

  if [ "${nTest}" == "6" ]; then 
#       aLDir=data 
        aLDir="workspaces/FRApps" 
        aRDir="workspaces/FRApps"
        aVolume="FRApps_prod1-master"
        aContainer="FRApps_prod1-master"
        aImage="alpine:latest"  
        fi   
# --------------------------------------------------------------------

        isRunningImage=$(     docker ps -a                       | awk "/${aContainer}/ { print \$2}" );  echo -e "\nisRunningImage:               ${isRunningImage}" 
        isRunningContainer=$( docker ps -a --format "{{.Names}}" | awk "/${aContainer}/ { print }" );     echo      "isRunningContainer:           ${isRunningContainer}"  

if [ "${isRunningContainer}" == "${aContainer}" ]; then docker rm -f ${aContainer} >/dev/null 2>&1;       echo      "  Removed  Container:         ${aContainer}"; fi 
#f [ "${isRunningImage}"     != ""              ]; then docker rm -f ${aContainer}; fi 
                                                        #  echo "aVolume: /${aVolume/\//\\\/}/"; exit  
        isRunningVolume=$(    docker volume ls                    | awk "/ ${aVolume/\//\\\/}/ { print \$2}" );   echo      "isRunningVolume:              ${isRunningVolume}"  
if [ "${isRunningVolume}"    == ""              ]; then        
                              docker volume create  ${aVolume}  >/dev/null 2>&1;                          echo      "  Creating Volume:            ${aVolume}"                # harmless if run when it exists 
        fi 
                                              echo "  Creating Container:         ${aContainer}" #  using Image: ${aImage}"
                                              echo "      with Local Host Folder: ${aLDir}"
                                              echo "      with Container Folder:  ${aRDir}"
  if [ "${aRDir}" == "${aVolume}" ]; then 
        docker run    --name ${aContainer}  -v /$(pwd)/${aLDir}:/${aVolume}                                -dit  "${aImage}"  >/dev/null            # keeps running
     else     
#       docker run    --name ${aContainer}  -v /$(pwd)/${aLDir}:/${aVolume}         "${aImage}"  >/dev/null            # creates local folder: ${aLDir}, and container folder: ${aVolume}
#       docker run    --name ${aContainer}  -v /$(pwd)/${aLDir}:/${aVolume}   -d    "${aImage}"   tail -f /dev/null    # stops running
        docker run    --name ${aContainer}  -v /$(pwd)/${aLDir}:/${aVolume} -v /$(pwd)/${aRDir}:/${aRDir}  -dit  "${aImage}"  >/dev/null            # keeps running
#       docker run    --name ${aContainer}  -v /$(pwd)/${aLDir}:/${aVolume}   -it   "${aImage}"                        # opens console 
        fi 
        echo ""

        if [ "${aLDir}" != "" ]; then aLDir="/${aLDir}"; fi 
        if [ "${aRDir}" != "" ]; then aRDir="/${aRDir}"; fi 

function prtStatus( ) {
         aStatus="Didn't try to copy to "; if [ "$1" != "xx" ]; then 
         aStatus="Successfully copied to"; if [ "$1" != "0"  ]; then aStatus="failed to copy to     "; fi; fi 
         echo "${aStatus} $2"; # echo ""  
         }

#            echo "4: '$(pwd)${aRDir}'"
         docker cp foo.txt   ${aContainer}:/${aVolume}/foo1.txt  >/dev/null 2>&1;  prtStatus "$?" "${aContainer}:/${aVolume}/foo1.txt"
                cp foo.txt             "$(pwd)${aLDir}/foo2.txt" >/dev/null 2>&1;  prtStatus "$?"           "\$(pwd}${aLDir}/foo2.txt"
         docker cp foo.txt      ${aContainer}:${aRDir}/foo3.txt  >/dev/null 2>&1;  prtStatus "$?"    "${aContainer}:${aRDir}/foo3.txt"
                    if [ -d "$(pwd)${aRDir}" ]; then     
                cp foo.txt             "$(pwd)${aRDir}/foo4.txt" >/dev/null 2>&1;  prtStatus "$?"           "\$(pwd}${aRDir}/foo4.txt"; 
                else                                                               prtStatus "xx"           "\$(pwd}${aRDir}/foo4.txt"; fi 


exit 

isRunningImage:               alpine:latest
isRunningContainer:           dummy
  Removed Container:          dummy
isRunningVolume:
  Creating Volume:            vol2
  Creating Container:         dummy
      with Local Host Folder: vol1
      with Container Folder:  vol2

Successfully copied 1.54kB to dummy:/vol2/foo3.txt
Successfully copied 1.54kB to $(pwd}/vol1/foo4.txt
Successfully copied 1.54kB to dummy:/root/foo5.txt
Successfully copied 1.54kB to $(pwd}/root/foo6.txt


