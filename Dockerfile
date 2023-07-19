  FROM ubuntu:20.04
                                                                           
  RUN  apt update && apt install openssh-server sudo -y                       
  RUN  service ssh start                                                      
  EXPOSE 22 

  RUN  apt install nodejs -y
  RUN  apt install nano -y
  RUN  apt install curl -y
  RUN  apt install npm -y
  RUN  apt install git -y

  ENV  Hostname fr231d-ub20 
# COPY "._/.ssh/hostname" /etc/hostname
# RUN  tail -n 1 /etc/hosts | awk '{ print $1 "  fr231d-ub20" }' >>/etc/hosts
# RUN  echo                                     "fr231d-ub20"     >/etc/hostname

# RUN  groupadd nimda 
# RUN  useradd  -rm -s /bin/bash -d /home/nimda  -g sudo  -G nimda -u 1001 nimda   
  RUN  useradd  -rm -s /bin/bash -d /home/nimda  -g root  -G sudo  -u 1001 nimda   
  RUN  groupadd -g 1001 nimda 
  RUN  echo 'nimda:formR!2345'     | chpasswd 
  RUN  mkdir                        /home/nimda/.ssh   
  COPY "._/.ssh/.profile"           /home/nimda 
  COPY "._/.ssh/authorized_keys"    /home/nimda/.ssh 
  RUN  chmod 700                    /home/nimda/.ssh && chown nimda -R /home/nimda

  RUN  useradd  -rm -s /bin/bash -d /home/bruce  -g nimda -G sudo -u 1002 bruce -d /home/bruce  
  RUN  echo 'bruce:formR!2345'     | chpasswd 
  RUN  mkdir                        /home/bruce/.ssh  
  COPY "._/.ssh/.profile"           /home/bruce 
  COPY "._/.ssh/authorized_keys"    /home/bruce/.ssh  
  RUN  chmod 700                    /home/bruce/.ssh && chown nimda -R /home/bruce

  RUN  useradd  -rm -s /bin/bash -d /home/robin  -g nimda -G sudo -u 1003 robin   
  RUN  echo 'robin:Fmr.ram231'     | chpasswd  
  RUN  mkdir                        /home/robin/.ssh  
  COPY "._/.ssh/.profile"           /home/robin 
  COPY "._/.ssh/authorized_keys"    /home/robin/.ssh  
  RUN  chmod 700                    /home/robin/.ssh && chown nimda -R /home/robin

  ENV NVS_HOME="/home/._0/.nvs"
  RUN mkdir -p "$NVS_HOME" && chown nimda -R /home/._0
  RUN git clone https://github.com/jasongin/nvs "$NVS_HOME" 
  RUN . "$NVS_HOME/nvs.sh" install && chmod 755 "$NVS_HOME/nvs.sh"
  RUN   "$NVS_HOME/nvs.sh" add "18/x64"      && "$NVS_HOME/nvs.sh" use 18 

  RUN  mkdir          "/workspaces"
# RUN  chown nimda -R "/workspaces" && chgrp nimda -R "/workspaces" 
# RUN  chmod 777   -R "/workspaces" 
  
# USER nimda

# RUN  mkdir  -p      "/workspaces/FRApps/"
  COPY client1        "/workspaces/FRApps/client1"
# RUN  chmod 777   -R "/workspaces/FRApps/client1" 
  RUN  chown nimda -R "/workspaces/FRApps/client1" && chgrp nimda -R "/workspaces/FRApps/client1" 
  RUN  cd             "/workspaces/FRApps/client1" && npm install 
                                                              
# RUN  mkdir  -p      "/workspaces/FRApps/server1"
  COPY server1        "/workspaces/FRApps/server1"
  RUN  chown nimda -R "/workspaces/FRApps/server1" && chgrp nimda -R "/workspaces/FRApps/server1" 
  RUN  cd             "/workspaces/FRApps/server1" && npm install 

  COPY server2        "/workspaces/FRApps/server2"
  RUN  chown nimda -R "/workspaces/FRApps/server2" && chgrp nimda -R "/workspaces/FRApps/server2" 
  RUN  cd             "/workspaces/FRApps/server2" && npm install 

  COPY server3        "/workspaces/FRApps/server3"
  RUN  chown nimda -R "/workspaces/FRApps/server3" && chgrp nimda -R "/workspaces/FRApps/server3" 
  RUN  cd             "/workspaces/FRApps/server3" && npm install 

# RUN  mkdir  -p      "/workspaces/FRTools/"
  COPY ._2            "/workspaces/FRTools/._2"
  RUN  chmod 755      "/workspaces/FRTools/._2/FRTs/FRT98_setFRTs.sh" 
  RUN                 "/workspaces/FRTools/._2/FRTs/FRT98_setFRTs.sh" 

# RUN  chown nimda -R "/workspaces" 
# RUN  chgrp nimda -R "/workspaces" 

  CMD ["/usr/sbin/sshd","-D"]           