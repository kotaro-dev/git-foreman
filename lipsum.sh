#!/bin/sh

fsize=1000
oflnm=lipsum.txt

while [ "${1}" != "" ]
do
  if [ "${1}" = "-c" ]; then
    fsize=${2}
  elif [ "${1}" = "-o" ]; then
    oflnm=${2}
  else
    echo file size : -c {size} \(byte\)
    echo output file nm : -o {output file name}
    echo --- default value ---
    echo output file size : ${fsize} \(byte\)
    echo output file name : ${oflnm}
  fi

  shift
  shift
done


tr -dc a-z1-4 </dev/urandom | tr 1-2 ' \n' | awk 'length==0 || length>50' | tr 3-4 ' ' | sed 's/^ *//' | cat -s | sed 's/ / /g' |fmt | head -c ${fsize} > ${oflnm}

exit

