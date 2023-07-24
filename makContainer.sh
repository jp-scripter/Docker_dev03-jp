#!/bin/bash


   if [ "$1" == "run" ]; then aCmd=run; shift; else aCmd=mak; fi  
   if [ "$2" == "run" ]; then aCmd=run; fi  

# Set Variables.  Must be run from Repository root folder 
   
   aTag="1.07";     if [ "$1" != "" ]; then aTag="$1"; fi 

   aImgFile="fr231d-ub20_frapps_dev03.image:${aTag}"
   aHost=${aImgFile:0:11}

#  aVols="FRApps:/workspaces/FRApps"  
#  aVols="/workspaces/FRApps:FRApps"  # docker run -v /Inside:/Outside
   aLVol="FRApps";  aRVol="/workspaces/FRApps";  aLDir="$( pwd )/";  echo "  aVols: ${aLDir}${aLVol}:${aRVol}"; # exit  
   aLVol="FRApps2"; aRVol="/workspaces/FRApps";  aLDir="";           echo "  aVols: ${aLDir}${aLVol}:${aRVol}"; # exit  
   aLVol="FRApps5"; aRVol="/workspaces/FRApps5"; aLDir="$( pwd )/";  echo "  aVols: ${aLDir}${aLVol}:${aRVol}"; # exit  


   aPorts="22:22"; aPorts="${aPorts/:/->}"; # echo -e "\naPorts: '${aPorts}'\n"; exit  

  if [ "${aCmd}" == "mak" ]; then # ------------------------------------------------------------------------

#  aCfgFile="~/.ssh/config"
   aCfgFile="~/.ssh/config-dkr.ssh"
   aKeyFile="~/.ssh/FRApps.Admin@fr231d-nimda_u230716_key"

#  Set Permissions on {aKeyFile} to 700 
#  chmod 700 ${aKeyFile}
   cp -p "$( pwd )/._/${aKeyFile:2}"* ~/.ssh 

#  Update {aCfgFile} with {aKeyFile} if it exists and has no SSH config alias for fr231d-nimda_key
if [ ! -f "$HOME/.ssh/config"  ] || [ "" == "$( grep "fr231d-nimda_key" "$HOME/.ssh/config" )" ]; then 
   cat "._/.ssh/config-mt.ssh" | awk 'NR < 13 { sub( /{KeyFile}/, "'${aKeyFile}'" ); print }' >>"$HOME/.ssh/config" 
   fi 
   cat "._/.ssh/config-mt.ssh" | awk         '{ sub( /{KeyFile}/, "'${aKeyFile}'" ); print }'  >"$HOME/${aCfgFile:2}"

#  Build Docker Image file  
   cp "DockerFile_u${aTag}" "Dockerfile" 
   echo ""; docker build . -t "${aImgFile}"; echo ""  
   aID="$(  docker images  --format "{{.ID}} {{.Repository}}:{{.Tag}}" | awk "/${aImgFile}/ { print \$1 }" )"
   echo "Built Image File:  ${aImgFile}  ${aID:0:12}"

   fi # ----------------------------------------------------------------------------------------------------

#  Remove Docker container if running  
   aID="$(  docker ps | awk "/${aImgFile}/ { print \$1 }" )"; if [ "${aID}" == "" ]; then   # Sometimes IMAGE is ImageID
   aID="$(  docker ps | awk "/${aPorts}/   { print \$1 }" )"; fi                            #  .. so let's try to find PORTS 
   if [ "${aID}" != "" ]; then docker rm -f "${aID}" >/dev/null; 
   echo "Removed Container: ${aImgFile}  ${aID}"; fi 
 
#  Run Docker Image file and Run it 
#  aID="$(  docker run --rm -d -h ${aHost} -p 22:22/tcp -v $( pwd )/${aVols} "${aImgFile}" )"
#  aID="$(  docker run --rm -d -h ${aHost} -p 22:22/tcp -v "$(  pwd )"/${aLDir}:${aRDir} "${aImgFile}" )"
   aID="$(  docker run --rm -d -h ${aHost} -p 22:22/tcp -v  "${aLDir}"${aLVol}:${aRVol} "${aImgFile}" )"

   echo "Running Container: ${aImgFile}  ${aID:0:12}"
   echo " # docker run --rm -d -h ${aHost} -p 22:22/tcp -v '\${aLDir}'${aLVol}:${aRVol} '${aImgFile}'"  #  docker run --rm -d -p 22:22/tcp -v $( pwd ):/workspaces/FRApps2 "${aImgFile}" 
