#!/bin/bash

                                  aDir="$HOME/.config"
if [ "${OSTYPE:0:6}" == "darwin" ]; then aDir="$HOME/Library/Application Support"; fi 
if [ "${OSTYPE:0:4}" == "msys"   ]; then aDir="$APPDATA"; fi

  aSettingsFile="${aDir}/Code/User/settings.json"
  aTmpFile="${aSettingsFile/.json/.tmp/}"
  aTmpFile="./settings.tmp"

  cat "${aSettingsFile}" | awk '/^}/ { print ""; exit}; { print }' >"${aTmpFile}"
# cat "${aTmpFile}"
# echo -e "\n---------------------------------------" 

# --------------------------------------------------------------

  function setIt( ) {

 #   echo "\$1: '$1', \$2: '$2'" 

     aAwkScr='BEGIN{ bFound = 0 }

/"'$1'"/ {                                          #print NR ". " $0
         if (0 < index( $0, "[" )) {                  
                  sub( /: *\[(.+)\],/, ": '$2'," ); } #print "found [: " $0 }
           else { sub( /: *"(.+)",/,   ": '$2'," ); } #print "found  : " $0 }
#        print "** " $0; 
         print; bFound = 1; next 
         }

  /^}/ { exit }
#      { print NR ". --" $0 }
       { print }

END{ if (bFound == 0) {  
#        print NR ". --    \"'$1'\": '$2'" 
         print "    \"'$1'\": '$2',"
         }  
 #       print (NR+1) ". --}"
         print "}"  
     }'        

# echo -e "\n---------------------------------------" 
# echo -e "\n${aAwkScr}"
# echo -e "---------------------------------------\n" 

#     cat "${aTmpFile}" | awk '/'$1'/ { sub( /: *"(.+)"/, ": \"'$2'\"" ); print; next }; { print }' 
  
      cat "${aTmpFile}" | awk "${aAwkScr}" >"${aTmpFile}1" 
      mv  "${aTmpFile}1" "${aTmpFile}" 
  if [ -f "${aTmpFile}1" ]; then rm "${aTmpFile}1"; fi
      }
# ---------------------------------------------------------------

  # setIt "foo" '\"goo\"'     
  # setIt "docker.images.groupBy" '\"foo\"'  
  # setIt "docker.images.description" '[ \"whatever\", \"foo\" ]' 
  # setIt "docker.images.descripti"   '[ \"whatever\", \"foo2\" ]' 

    setIt "docker.containers.groupBy"         '\"Image\"'
    setIt "docker.containers.label"           '\"ContainerId\"'
    setIt "docker.containers.description"   '[ \"Status\", \"ContainerName\" ]'
    setIt "docker.containers.sortBy"          '\"CreatedTime\"'
 #  setIt "" 
    setIt "docker.images.groupBy"             '\"RepositoryName\"'
    setIt "docker.images.description"       '[ \"CreatedTime\", \"Size\",\"Tag\" ]'
    setIt "docker.images.label"               '\"ImageId\"'
    setIt "docker.images.sortBy"              '\"CreatedTime\"'
 
#   setIt "remote.SSH.configFile"             '\"/Users/robin/.ssh/config\"'
    setIt "remote.SSH.configFile"             '\"/Users/robin/Repos/Docker_/dev03-jps/._/.ssh/config-dkr.ssh\"'

#   echo -e "---------------------------------------" 
#   cat "${aTmpFile}" 
#   echo -e "\n---------------------------------------" 

    cp  "${aTmpFile}"  "${aSettingsFile}" 
    cat "${aSettingsFile}"  
    echo -e "\n---------------------------------------" 
