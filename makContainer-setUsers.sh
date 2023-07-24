#!/bin/bash

function addUser( ) {
  aUNo=$1; aUsr=$2; aGrp=$3; aPwd=$4
  useradd  -rm -s /bin/bash -d /home/${aUsr}  -g ${aGrp}  -G sudo  -u ${aUNo} ${aUsr}
  if [ "${aUsr} == "nimda" ]; then groupadd -g 1001 nimda; fi
  echo "${aUsr}:${aPwd}"         | chpasswd
  mkdir                           /home/${aUsr}/.ssh
  cp -p "._/JSHs/.profile"        /home/${aUsr}
  cp -p "._/JSHs/authorized_keys" /home/${aUsr}/.ssh
  chmod 700 -R                    /home/${aUsr}/.ssh && chown ${aUsr} -R /home/${aUsr}
  }
# -------------------------------------------------------------------------------------

  addUser 1001 nimda root  "formR!2345'
  addUser 1002 bruce nimda "formR!2345'
  addUser 1003 robin nimda "formR!2345'

  rm "._/JSHs/.profile"
  rm "._/JSHs/authorized_keys"






  if [ "${aUsr} == "nimda" ]; then aGrp="root"; aUno=1001; else aGrp="nimda"; fi
  if [ "${aUsr} == "bruce" ]; then aGrp="root"; aUno=1002; fi
  if [ "${aUsr} == "robin" ]; then aGrp="root"; aUno=1002; fi


 aID="$(  docker ps | awk "/${aImgFile}/ { print \$1 }" )";

 "/var/lib/docker/volumes/FRApps2/_data"







# RUN  groupadd nimda
# RUN  useradd  -rm -s /bin/bash -d /home/nimda  -g sudo  -G nimda -u 1001 nimda
  RUN  useradd  -rm -s /bin/bash -d /home/nimda  -g root  -G sudo  -u 1001 nimda
  RUN  groupadd -g 1001 nimda
  RUN  echo 'nimda:formR!2345'     | chpasswd
  RUN  mkdir                        /home/nimda/.ssh
  COPY "._/.ssh/.profile"           /home/nimda
  COPY "._/.ssh/authorized_keys"    /home/nimda/.ssh
  RUN  chmod 700 -R                 /home/nimda/.ssh && chown nimda -R /home/nimda

  RUN  useradd  -rm -s /bin/bash -d /home/bruce  -g nimda -G sudo -u 1002 bruce -d /home/bruce
  RUN  echo 'bruce:formR!2345'     | chpasswd
  RUN  mkdir                        /home/bruce/.ssh
  COPY "._/.ssh/.profile"           /home/bruce
  COPY "._/.ssh/authorized_keys"    /home/bruce/.ssh
  RUN  chmod 700 -R                 /home/bruce/.ssh && chown bruce -R /home/bruce

  RUN  useradd  -rm -s /bin/bash -d /home/robin  -g nimda -G sudo -u 1003 robin
  RUN  echo 'robin:Fmr.ram231'     | chpasswd
  RUN  mkdir                        /home/robin/.ssh
  COPY "._/.ssh/.profile"           /home/robin
  COPY "._/.ssh/authorized_keys"    /home/robin/.ssh
  RUN  chmod 700 -R                 /home/robin/.ssh && chown robin -R /home/robin


