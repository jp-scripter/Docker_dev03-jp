#!/bin/bash

  if [ ! -d "/home/._0/bin"           ]; then mkdir -p "/home/._0/bin"; chown nimda "/home/._0/"; chmod 755 "/home/._0/";  fi

# if [ ! -d "/home/nimda"             ]; then cp -r "._/.ssh/.profile" /home/nimda;
#                                             cp -r "._/.ssh/FRApps.Docker@fr231d_nimda_a230716_key.pub" /home/nimda/.ssh/.; fi
# if [ ! -d "/home/robin"             ]; then cp -r "._/.ssh/.profile" /home/robin;
#                                             cp -r "._/.ssh/FRApps.Docker@fr231d_robin_a230716_key.pub" /home/robin/.ssh/.; fi

# if [ ! -d "/workspaces/FRTools/._2" ]; then mkdir "/workspaces/FRTools/_.2"; fi
# if [ ! -d "/workspaces/FRTools/._2" ]; then cp -r  ._2/*  /workspaces/FRTools/._2; fi

#        cd "/workspaces/FRTools"  # /workspaces/FRTools/._2
#        aDir="/workspaces/FRTools/._2"
         aDir="/workspaces/._2"

  if [ ! -L "/home/._0/bin/rss"     ]; then   ln -s "${aDir}/JPTs/RSS/RSS01_Main1.sh"             "/home/._0/bin/rss";     fi
  if [ ! -L "/home/._0/bin/rdir"    ]; then   ln -s "${aDir}/JPTs/RSS/FileList/RSS21_FileList.sh" "/home/._0/bin/rdir";    fi
  if [ ! -L "/home/._0/bin/dirlist" ]; then   ln -s "${aDir}/JPTs/RSS/DirList/RSS22_DirList.sh"   "/home/._0/bin/dirlist"; fi
  if [ ! -L "/home/._0/bin/info"    ]; then   ln -s "${aDir}/JPTs/RSS/Info/RSS23_Info.sh"         "/home/._0/bin/info";    fi
  if [ ! -L "/home/._0/bin/jpt"     ]; then   ln -s "${aDir}/JPTs/JPT00_Main0.sh"                 "/home/._0/bin/jpt";     fi
  if [ ! -L "/home/._0/bin/frt"     ]; then   ln -s "${aDir}/FRTs/FRT01_Main0.sh"                 "/home/._0/bin/frt";     fi
  if [ ! -L "/home/._0/bin/gitr"    ]; then   ln -s "${aDir}/FRTs/gitR/FRT22_gitR1.sh"            "/home/._0/bin/gitr";    fi
  if [ ! -L "/home/._0/bin/keys"    ]; then   ln -s "${aDir}/FRTs/keyS/FRT21_keyS1.sh"            "/home/._0/bin/keys";    fi
# if [ ! -L "/home/._0/lnbin/dokr"  ]; then   ln -s "${aDir}/FRTs/dokR/FRT24_dokR1.sh"            "/home/._0/bin/dokr";    fi
# if [ ! -L "/home/._0/bin/dr"      ]; then   ln -s "${aDir}/FRTs/dokR/FRT24_dokR1.sh"            "/home/._0/bin/dr";      fi
# if [ ! -L "/home/._0/bin/dokr"    ]; then   ln -s "${aDir}/FRTs/dokR/FRT24_dokR1_p1.02.sh"      "/home/._0/bin/dokr";    fi
# if [ ! -L "/home/._0/bin/dr"      ]; then   ln -s "${aDir}/FRTs/dokR/FRT24_dokR1_p1.02.sh"      "/home/._0/bin/dr";      fi
# if [ ! -L "/home/._0/bin/dokr"    ]; then if [ -L "${aDir}/FRTs/dokR/dokr" ]; then           rm "${aDir}/FRTs/dokR/dokr"; fi
#                                             ln -s "${aDir}/FRTs/dokR/FRT24_dokR1.sh"            "${aDir}/FRTs/dokR/dokr";
#                                             ln -s "${aDir}/FRTs/dokR/dokr"                      "/home/._0/bin/dokr";    fi
#
# if [ ! -L "/home/._0/bin/dr"      ]; then if [ -L "${aDir}/FRTs/dokR/dr" ]; then             rm "${aDir}/FRTs/dokR/dr";   fi
#                                             ln -s "${aDir}/FRTs/dokR/FRT24_dokR1.sh"            "${aDir}/FRTs/dokR/dr";
#                                             ln -s "${aDir}/FRTs/dokR/dr"                        "/home/._0/bin/dr";      fi

# PATH="$PATH:/home/._0/bin"; export PATH

  chmod 755 -R "/home/._0/bin"
  chmod 755 -R "${aDir}"
