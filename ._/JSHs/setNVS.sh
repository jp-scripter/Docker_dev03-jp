#!/bin/bash
  
  aVer=18; if [ "$1" != "" ]; then aVer=18; fi 

  export NVS_HOME="/home/._0/.nvs"
# mkdir -p "$NVS_HOME"  &&  chown nimda -R /home/._0
  git clone https://github.com/jasongin/nvs       "$NVS_HOME" 
  . "$NVS_HOME/nvs.sh" install   
     chmod 777 -R "$NVS_HOME"
     echo ""; ls -la; echo ""  
    "$NVS_HOME/nvs.sh" add "${aVer}/x64"       
    "$NVS_HOME/nvs.sh" use node/${aVer}
 