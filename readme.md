# Dtr Age Off

The purpose of this script is to scrape DTR for older images. The one caveat is that the repository must have Tag Immutability turned off. 

OR use the container version. 
```
docker run --rm -it -e USERNAME=admin -e age=90 -e DTR_SERVER=dtr.dockr.life -e DELETE=no clemenko/dtr_ageoff
```

Example:
```
clemenko:dtr_ageoff clemenko $ docker run --rm -it -e USERNAME=admin -e age=90 -e DTR_SERVER=dtr.dockr.life -e DELETE=no clemenko/dtr_ageoff
------------------------------------------------------------------
 Welcome to the DTR Age Off Scanner.
 Checking: dtr.dockr.life as admin for images older than 90 days.
 password: 
------------------------------------------------------------------
  andy/alpine [no tags]
  admin/alpine:latest 2018-01-09 [delete] 
  admin/alpine_build:latest 2018-01-09 [delete] 
  admin/flask:alpine 2018-01-09 [delete] 
  admin/flask:latest 2018-05-02  [ok] 
  admin/flask_build:latest 2018-05-02  [ok] 
  admin/flask_build:alpine 2018-01-09 [delete] 
  admin/nginx:latest 2017-01-24 [delete] 
------------------------------------------------------------------
```

## Requirements
    - jq
    - curl
    - coreutils (for gdate)

## Install

### Linux
```
apt update; apt install -y jq curl
```

or

```
yum install -y epel-release
yum install -y curl jq
```

### Mac
```
brew install jq curl coreutils
```

## Run
Edit the script for the following variables:

- dtr_server=dtr.dockr.life #server url, https is implied. 
- age=90 #days
- delete=no #actaully delete the tags
- username=admin #must be an administrative username

When `delete=no` in the top of ths script this is the typical output:

```
clemenko:dtr_ageoff clemenko $ ./dtr_ageoff.sh 
 Welcome to the DTR Age Off Scanner.
 Checking for images older than 90 days.
 password: 
  andy/alpine [no tags]
  admin/alpine:latest 2018-01-09 [delete] 
  admin/alpine_build:latest 2018-01-09 [delete] 
  admin/flask:latest 2018-05-02  [ok] 
  admin/flask:alpine 2018-01-09 [delete] 
  admin/flask_build:latest 2018-05-02  [ok] 
  admin/flask_build:alpine 2018-01-09 [delete] 
  admin/nginx:latest 2017-01-24 [delete] 
```

When `delete=yes` this is what you should see:

```
clemenko:dtr_ageoff clemenko $ ./dtr_ageoff.sh 
 Welcome to the DTR Age Off Scanner.
 Checking for images older than 90 days.
     -- DELETE FUNCTION IS ON --
      -- ctrl-c to break --  
 password: 
  andy/alpine [no tags]
  admin/alpine:latest 2018-01-09 [delete] 
  admin/alpine_build:latest 2018-01-09 [delete] 
  admin/flask:latest 2018-05-02  [ok] 
  admin/flask:alpine 2018-01-09 [delete] 
  admin/flask_build:latest 2018-05-02  [ok] 
  admin/flask_build:alpine 2018-01-09 [delete] 
  admin/nginx:latest 2017-01-24 [delete] 
```
