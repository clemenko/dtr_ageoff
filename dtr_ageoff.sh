#!/bin/bash
#this script is to query DTR for images that are older than X days.
###################################
# edit vars
###################################
set -e

#set variables
dtr_server="dtr.dockr.life" #server url. https is implied.
age="90" #days
delete="no" #actaully delete the tags
username="admin" #must be an administrative username

######  NO MOAR EDITS #######
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
NORMAL=$(tput sgr0)

if [ "$(uname)"  == "Darwin" ]; then date_app="gdate"; fi
if [ "$(uname)"  == "Linux" ]; then date_app="date"; fi

age_date=$($date_app -d "$($date_app)-${age}days" '+%s')

MANIFEST_HEADER='application/vnd.docker.distribution.manifest.list.v2+json,application/vnd.docker.distribution.manifest.v2+json,application/vnd.docker.plugin.v1+json'

function age_off (){
echo " Welcome to the DTR Age Off Scanner."
echo " Checking for images older than $RED$age$NORMAL days."

#delete warning
if [ "$delete" == "yes" ]; then
  echo "$RED     -- DELETE FUNCTION IS ON --$NORMAL"
  echo "$GREEN      -- ctrl-c to break --  $NORMAL"
  sleep 5
fi

#get password
read -rsp ' password: ' password;
echo ""

#get image list
image_list=$(curl -skX GET -u "$username:$password" "https://$dtr_server/api/v0/repositories/?pageSize=10000&count=false" -H "accept: application/json" |jq -r '.repositories[] | "\(.namespace)/\(.name)"')

#exit if no repos
if [ -z "$image_list" ]; then echo "${RED}No repositories...$NORMAL"; exit; fi

for image in $image_list; do
  #gen tag list
  tag_list=$(curl -skX GET -u "$username:$password"  "https://$dtr_server/api/v0/repositories/$image/tags?pageSize=10000&count=false&includeManifests=false" -H "accept: application/json" | jq -r '.[].name')

  #get token for DTR pull context
  TOKEN=$(curl -skX GET -u "$username:$password" "https://$dtr_server/auth/token?service=$dtr_server&scope=repository:$image:pull" | jq -r '.token')

  if [ -z "$tag_list" ]; then echo "  $image ${GREEN}[no tags]$NORMAL";
  else
    for tag in $tag_list; do
      #get digest
      IMAGE_DIGEST=$(curl -skX GET "https://$dtr_server/v2/$image/manifests/$tag" -H "Authorization: BEARER ${TOKEN}" -H "Accept: ${MANIFEST_HEADER}" | jq -r '.config.digest')

      #get plain text date
      tag_clean_date=$(curl -sLkX GET "https://$dtr_server/v2/$image/blobs/$IMAGE_DIGEST"  -H "Authorization: BEARER ${TOKEN}" -H "Accept: ${MANIFEST_HEADER}" | jq -r '.created')

      #convert to epoch
      tag_date=$($date_app -d "$tag_clean_date" '+%s' )

      #epoch math
      if [[ $tag_date < $age_date ]]; then
        echo -n "  $image:$tag $(echo "$tag_clean_date" | awk -FT '{print $1}')"
        if [ "$delete" == "yes" ]; then
          #delete
          curl -skX DELETE -u "$username:$password" "https://$dtr_server/api/v0/repositories/$image/tags/$tag" -H "accept: application/json"
        fi
        echo "$RED [delete] $NORMAL"
      else
        echo "  $image:$tag $(echo "$tag_clean_date" | awk -FT '{print $1}') $GREEN [ok] $NORMAL"
      fi
    done
  fi
done
}

age_off
