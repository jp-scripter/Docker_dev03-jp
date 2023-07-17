  FROM ubuntu:20.04
                                                                           
  RUN  useradd - s /bin/bash -g root  -G sudo -u 1001 nimda -d /home/nimda -rm 
  RUN  groupadd -g 1001 nimda 
  RUN  echo 'nimda:formR!1234'  | chpasswd 
  COPY "._/.ssh/.profile"                                         /home/nimda 
  RUN  "._/.ssh/FRApps.Docker@fr231d_nimda_a230716_key.pub"      >/home/nimda/.ssh/authorized_keys

  RUN  useradd  -s /bin/bash -g nimda -G sudo -u 1002 robin -d    /home/robin -rm   
  RUN  echo 'robin:fmr.ram231'  | chpasswd  
  COPY "._/.ssh/.profile"                                         /home/robin 
# RUN  cat "._/.ssh/FRApps.Docker@fr231d_robin_a230716_key.pub" >>/home/robin/.ssh/authorized_keys

  RUN  mkdir         "/workspaces"
  RUN  chown nimda   "/workspaces" 
  RUN  chgrp nimda   "/workspaces" 
  RUN  mkdir         "/workspaces/FRTools"
  COPY ._2/*         "/workspaces/FRTools/._2"

  RUN apt update && apt install openssh-server sudo -y                       
  RUN service ssh start                                                      
  EXPOSE 22                                                                  

# RUN ._/setFRTs.sh 

  CMD ["/usr/sbin/sshd","-D"]           