#!/bin/sh

rm_hostnm=${1}
f_keys=authorized_keys

if [ "${1}" = "" ]; then
  echo input argsment.
  echo ${0} {delete key hostname}
  exit -1
fi

sed -i "/${rm_hostnm}/d" ~/.ssh/${f_keys}

exit 0
