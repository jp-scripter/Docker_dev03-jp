#!/bin/bash

function addUser( ) {
         aUNo=$1; aUsr=$2; aGrp=$3; aPwd=$4; aJSHs="/workspaces/._/JSHs" 
  if [ -d /home/${aUsr} ]; then return; fi        
         useradd  -rm -s /bin/bash -d /home/${aUsr} -g ${aGrp} -G sudo -u ${aUNo} ${aUsr}
  if [ "${aUsr}" == "nimda" ]; then groupadd -g 1001 nimda; fi
         echo "${aUsr}:${aPwd}"          | chpasswd
         mkdir                            /home/${aUsr}/.ssh
         cp -p "${aJSHs}/.profile"        /home/${aUsr}
         cp -p "${aJSHs}/authorized_keys" /home/${aUsr}/.ssh
         chmod 700 -R                     /home/${aUsr}/.ssh && chown ${aUsr} -R /home/${aUsr}
         }
# -------------------------------------------------------------------------------------

                          addUser 1001 $1 root  "formR!2345";
  if [ "$2" != "" ]; then addUser 1002 $2 nimda "formR!2345"; fi
  if [ "$3" != "" ]; then addUser 1003 $3 nimda "formR!2345"; fi
  
  if [ ! -d "/home/._0/bin" ]; then mkdir -p "/home/._0/bin"; chown nimda "/home/._0/"; chmod 755 "/home/._0/"; fi 

# rm    "._/JSHs/.profile"
# rm    "._/JSHs/authorized_keys"
# rm -r "._/"
