#!/bin/bash
###################################
# edit vars
###################################
set -e

dtr_server=$1
age=$2
password=Pa22word
dryrun=no

BSD=true

######  NO MOAR EDITS #######
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
NORMAL=$(tput sgr0)

date=

#sudo -
# be able to start within any repo
#curl api | grep value for seeding the inital check

image_list=$(curl -skX GET -u admin:$password "https://dtr.dockr.life/api/v0/repositories/?pageSize=10&count=false" -H "accept: application/json" |jq -r '.repositories[] | "\(.namespace)/\(.name)"')


image_list="admin/alpine"
for i in $image_list; do
  echo "-- $i --"
  tag_list=$(curl -skX GET -u admin:$password  "https://dtr.dockr.life/api/v0/repositories/$i/tags?pageSize=10&000count=false&includeManifests=false" -H "accept: application/json" | jq -r '.[].name')
  for x in $tag_list; do
    echo -n $x" "
    curl -skX GET -u admin:$password  "https://dtr.dockr.life/api/v0/repositories/$i/tags/$x?pageSize=10&000count=false&includeManifests=false" -H "accept: application/json" | jq -r '.[].createdAt' | awk -F":" '{print $1}' | awk -F"T" '{print $1}'

    if [ "$BSD" = "true" ]; then
# for date comparison on a mac
    echo ""
   fi

  done
done


#date comparison


case "$1" in
        dryrun) dryrun;;
        *) echo "Usage: $0 {dryrun}" URL ; exit 1
esac
