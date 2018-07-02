#!/bin/bash
###################################
# edit vars
###################################
set -e

#set variables
dtr_server=dtr.dockr.life
age=180
dryrun=yes
username=admin


######  NO MOAR EDITS #######
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
NORMAL=$(tput sgr0)

date=

#sudo -
# be able to start within any repo
#curl api | grep value for seeding the inital check


function age_off (){
#get password
read -sp 'password: ' password;



image_list=$(curl -skX GET -u admin:$password "https://$dtr_server/api/v0/repositories/?pageSize=10&count=false" -H "accept: application/json" |jq -r '.repositories[] | "\(.namespace)/\(.name)"')


#image_list="admin/alpine"
for i in $image_list; do
  echo "-- $i --"
  tag_list=$(curl -skX GET -u admin:$password  "https://$dtr_server/api/v0/repositories/$i/tags?pageSize=10&000count=false&includeManifests=false" -H "accept: application/json" | jq -r '.[].name')
  for x in $tag_list; do
    echo -n $x" "
    curl -skX GET -u admin:$password  "https://$dtr_server/api/v0/repositories/$i/tags/$x?pageSize=10&000count=false&includeManifests=false" -H "accept: application/json" | jq -r '.[].createdAt' | awk -F":" '{print $1}' | awk -F"T" '{print $1}'

    #date comparison

    if [ "$dryrun" == "no" ]; then
      echo "deleting all the things"
    fi

  done
done
}

#date comparison
