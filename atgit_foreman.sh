#!/bin/sh

###-------------------------------------###
### git clone : use git protocol 
### if you want to use http(https) protocol, you need ssh-key
### should be configure .ssh/config before use this shell.
### git clone {user}@{host}:{path}/{git repo}
# 
# $0 {git remote} {workspace} 
# $0 {git remote host} {sleep} {mode} {fsize} {commit file} 
# $0 {git remote host} -w {sleep} -m {mode} -s {fsize} -f {commit file} -l {limit count} -o {git workspace}
###-------------------------------------###

if [ "${1}" = "" ]; then
  echo ${0} {git repository}
  echo please set your git repogitory.
  exit -1
fi

###-------------------------------------###
# default value

fnm_ext=${0##*/}
fnm=${fnm_ext%.*}
ext=${fnm_ext##*.}
txt=txt
newfile=${fnm}.${txt}

# wait time
sheep_cnt=30
cmt_mode=0
fsize=1000

lmt=100
ctrl_f=0

ghost=${1}

repo_nm=${ghost##*/}
wkspace=${repo_nm%.*}

###-------------------------------------###
# plain args

## sleep time
if [ "${2}" != "" ]; then
  sheep_cnt=${2}

  ## commit mode
  if [ "${3}" != "" ]; then
    cmt_mode=${3}

    ## fsize
    if [ "${4}" != "" ]; then
      fsize=${4}

      ## commit file name
      if [ "${5}" != "" ]; then
        newfile=${5}
        fnm=${newfile%.*}
        ext=${newfile##*.}
      fi
    fi
  fi
fi

###-------------------------------------###
# complex args

shift
while [ "${1}" != "" ]
do
  if [ "$1" = "-w" ]; then
    sheep_cnt=${2}
  elif [ "$1" = "-m" ]; then
    cmt_mode=${2}
  elif [ "$1" = "-s" ]; then
    fsize=${2}
  elif [ "$1" = "-f" ]; then
    newfile=${2}
    fnm=${newfile%.*}
    ext=${newfile##*.}
  elif [ "$1" = "-l" ]; then
    lmt=${2}
    ctrl_f=1
  elif [ "$1" = "-o" ]; then
    wkspace="${2}"
  else
    echo error arg : ${1}
    # exit 1
  fi

  shift
  shift
done

###-------------------------------------###
# pre setting - clone
# git clone ${ghost}
git clone ${ghost} ${wkspace}
cd ${wkspace}

###-------------------------------------###
# loop push new file
rikishi=${fnm}.pause
sloth=${fnm}.break

tm=0
f_seq=0
msg="commit from auto git test shell."

while [ ${tm} -le ${lmt} ]
do

  if [ -e ${rikishi} ]; then
    echo "i find the ${rikishi}!"
    echo "pause until Enter key."
    mv ${rikishi} ${rikishi}.a
    read -p pause
  fi

  if [ -e ${sloth} ]; then
    echo "i find the ${sloth}!"
    echo "emagency stop the job."
    mv ${sloth} ${sloth}.a
    exit 9
  fi

  git pull ${ghost}

  ### git commit mode
  if [ ${cmt_mode} = 1 ]; then
    # file cnt ans sequense
    f_seq=`expr ${f_seq} + 1`
    newfile=${fnm}_${f_seq}.${txt}
  fi

  ### make new file
  ./lipsum.sh -o ${newfile} -c ${fsize}

  git add ${newfile}
  git commit -m "${msg}"

  git push origin master

  if [ ${ctrl_f} -ne 0 ]; then
    #control
    tm=`expr $tm + 1`
  fi

  #wait
  sleep ${sheep_cnt}

done

exit 0

