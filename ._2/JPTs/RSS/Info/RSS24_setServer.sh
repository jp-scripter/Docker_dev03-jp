#!/bin/bash

function Help() {
   if [ "$1" != "" ]; then echo -e "* $1"; fi
   echo -e "\n  setServer {Cc}{SNo}{s} {OSvn} {Name} {Stage}\n"
   echo -e "            {cc}                                         : Customer Code, e.g. sc"
   echo -e "                {SNo}                                    : Server Number, e.g. 005"
   echo -e "                     {s}                                 : Stage Letter: ptdfn"
   echo -e "                         {OSvn}                          : OS Code and Version, e.g. ub20"
   echo -e "                               {Name}                    : Server Name, e.g. PHP-Node"
   echo -e "                                      {Stage}            : Stage, e.g. Prod1 or Dev03"
   echo -e "                                              {IPAddr}   : IPAddress (Optional)"
   echo -e ""
   exit
   }

function chkArg() {
   aArg=$( echo "$1" | awk $2 ); if [ "${aArg}" == "" ]; then Help "$3"; exit; fi
   if [ "${3:8:9}" == "Server Co" ]; then aSCno=${aArg}; fi
   if [ "${3:8:9}" == "OS Code &" ]; then aOSvn=${aArg}; fi
   if [ "${3:8:9}" == "Server Na" ]; then aName=${aArg}; fi
   if [ "${3:8:9}" == "Stage. Mu" ]; then aStag=${aArg}; fi
   }


if [ "$1" == "" ]; then Help "Usage:"; fi
if [ "$4" == "" ]; then Help "Please enter four parameters."; fi

   chkArg "$1" '/^[a-z]{2}[0-9]{3}[ptdfn]$/'         "Invalid Server Code. Must have 2 lowercase letters followed by a 3 digit number and a stage letter."
   chkArg "$2" '/^[a-z]{2}[0-9]{2}$/'                "Invalid OS Code & Version. Must have 2 lowercase letters followed by a 2 digit number."
   chkArg "$3" '/^[A-Z][A-Za-z0-9]{3,12}$/'          "Invalid Server Name. Must start with a Capital Letter followed by 3 to 12 chars."
   chkArg "$4" '/^Prod[0-9]|Test[0-9]|Dev[0-9]{2}$/' "Invalid Stage. Must be: ProdN, TestN or DevNN."

   if ( ipconfig &> /dev/null ); then aIPAddr=$( ipconfig   | awk '/IPv4 / { aIP=$0 }; END{ print substr( aIP, 40 ) }' ); fi
   if ( ifconfig &> /dev/null ); then aIPAddr=$( ifconfig   | awk '/inet / { aIP=$2 }; END{ print substr( aIP,  6 ) }' ); fi
   if ( ip       &> /dev/null ); then aIPAddr=$( ip address | awk '/inet / { aIP=$2 }; END{ print substr( aIP,  0, index( aIP, "/") - 1 ) }' ); fi

   THE_SERVER="${aSCno}-${aOSvn}_${aName}-${aStag} (${aIPAddr})"

   echo "${THE_SERVER}"
