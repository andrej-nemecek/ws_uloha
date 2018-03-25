#!/bin/bash

#osetrenie ci je zadana  cesta k suboru
if [ -z ${1} ]
then 
   echo Skus este raz spolu s cestou k suboru
   exit 1
else
   subor=$( tail -n +3 $1 ) #vynechavam prve dva riadky
fi

IFS=$'\n' #nastavujem separator na novy riadok
for riadok in $subor
do
   obsadenost=$( echo $riadok | cut -d ' ' -f7 | tr -d '%' ) #vyberam z riadka len obsadenost
   if [ $obsadenost -gt 75 ]
   then
      echo $riadok
   fi
done

