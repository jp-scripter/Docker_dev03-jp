#!/bin/bash

# Set Variables.  Must be run from Repository root folder 

   aTag="1.06";     if [ "$1" != "" ]; then aTag="$1"; fi 

   aImgFile="fr231d-ub20_frapps_dev03.image:${aTag}"
   aHost=${aImgFile:0:11}

   ./makContainer.sh ${aTag} run 
   