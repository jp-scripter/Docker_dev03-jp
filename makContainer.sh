#!/bin/bash

# Set Variables.  Must be run from Repository root folder 
   aTag=$1; if [ "${aTag}" == "" ]; then aTag="1.05"; fi 

   aImgFile="fr231d-ub20_frapps_dev03.image:${aTag}"

#  aCfgFile="$HOME/.ssh/config"
   aCfgFile="._/.ssh/config-dkr.ssh"
   aKeyFile="$( pwd )/._/.ssh/FRApps.Admin@fr231d-nimda_u230716_key"

#  Set Permissions on {aKeyFile} to 700 
   chmod 700 ${aKeyFile}

#  Update {aCfgFile} with {aKeyFile} if it exists and has no SSH config alias for fr231d-nimda_key
if [ ! -f "${aCfgFile}" ] || [ "" != "$( grep "fr231d-nimda_key" "${aCfgFile}" )" ]; then 
#  cat "._/.ssh/config-mt.ssh" | awk 'NR < 10 { sub( /{KeyFile}/, "'${aKeyFile}'" ); print }' >>"${aCfgFile}" 
   cat "._/.ssh/config-mt.ssh" | awk         '{ sub( /{KeyFile}/, "'${aKeyFile}'" ); print }'  >"${aCfgFile}"
   fi; 

#  Remove running Docker container id running  
   aID="$( docker ps | awk "/${aImgFile}/ { print \$1 }" )"
   if [ "${aID}" != "" ]; then docker rm -f "${aID}"; fi 

#  Build Docker Image file and Run it 
   docker build . -t "${aImgFile}"  
   docker run --rm -d -p 22:22/tcp "${aImgFile}"