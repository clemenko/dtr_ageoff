#!/bin/bash
###################################
# edit vars
###################################
set -e

#set variables
dtr_server=dtr.dockr.life
age=1
dryrun=yes
username=admin


######  NO MOAR EDITS #######
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
NORMAL=$(tput sgr0)

if [ $(uname)  == "Darwin" ]; then date_app=gdate; fi
if [ $(uname)  == "Linux" ]; then date_app=date; fi

todate=$($date_app '+%s')
age_date=$($date_app -d "$($date_app)-${age}days" '+%s')

function age_off (){
#get password
#read -sp 'password: ' password;
password=Pa22word

#get image list
image_list=$(curl -skX GET -u admin:$password "https://$dtr_server/api/v0/repositories/?pageSize=10&count=false" -H "accept: application/json" |jq -r '.repositories[] | "\(.namespace)/\(.name)"')

#image_list="admin/alpine"
for i in $image_list; do
  echo "-- $i --"
  tag_list=$(curl -skX GET -u admin:$password  "https://$dtr_server/api/v0/repositories/$i/tags?pageSize=10000&count=false&includeManifests=false" -H "accept: application/json" | jq -r '.[].name')

  if [ -z "$tag_list" ]; then echo No tags; 
  else
    for x in $tag_list; do
     echo -n $x" "
      echo -n $(curl -skX GET -u admin:Pa22word "https://dtr.dockr.life/api/v0/repositories/$i/tags/$x?pageSize=10&000count=false&includeManifests=false" -H 'accept: application/json' | jq -r '.[].createdAt')" "
      tag_date=$($date_app -d $(curl -skX GET -u admin:Pa22word "https://dtr.dockr.life/api/v0/repositories/$i/tags/$x?pageSize=10&000count=false&includeManifests=false" -H 'accept: application/json' | jq -r '.[].createdAt') '+%s')

      echo $tag_date
      echo $age_date
      if [[ $tagdate < $age_date ]]; then echo new enough; fi
      

      #date comparison

      if [ "$dryrun" == "no" ]; then
       echo "deleting all the things"
      fi

    done 
  fi
done
}

age_off





# ]clemenko:dtr_ageoff clemenko $ curl -skX GET -u admin:Pa22word 'https://dtr.dockr.life/api/v0/repositories/admin/flask_build/tags/latest?pageSize=10&000count=false&includeManifes=false' -H 'accept: application/json' | grep CVE
#      "CVE-2018-8740"
#      "CVE-2018-1000030"
#      "CVE-2018-10754"
#      "CVE-2016-9843",
#      "CVE-2016-9842",
#      "CVE-2016-9841",
#      "CVE-2016-9840"

#clemenko:dtr_ageoff clemenko $ curl -skX GET -u admin:Pa22word 'https://dtr.dockr.life/api/v0/repositories/admin/flask_build/tags/latest?pageSize=10&000count=false&includeManifests=false' -H 'accept: application/json' | jq '.[].vuln_summary'
#{
#  "namespace": "admin",
#  "reponame": "flask_build",
#  "tag": "latest",
#  "critical": 2,
#  "major": 5,
#  "minor": 0,
#  "last_scan_status": 6,
#  "check_completed_at": "2018-07-02T16:38:26.235343783Z",
#  "should_rescan": false,
#  "has_foreign_layers": false
#}