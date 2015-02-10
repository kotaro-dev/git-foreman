#!/bin/sh

## set ssh key for auto login to remote git repository

# step 1 : make ssh key. 

# don't overwite mix
# echo n|ssh-keygen -t rsa -b 2048 -f ~/.ssh/id_rsa -N "" -q

if [ ! -e $HOME/.ssh/id_rsa ]; then
  ssh-keygen -t rsa -b 2048 -f ~/.ssh/id_rsa -N "" -q
fi 

ssh_user=core
ssh_host=gstcore130

if [ "${1}" != "" ]; then
  ssh_user=${1}
fi

if [ "${2}" != "" ]; then
  ssh_host=${2}
fi

# need input passwd 
ssh ${ssh_user}@${ssh_host} 'cat >> ~/.ssh/authorized_keys' < ~/.ssh/id_rsa.pub

exit
