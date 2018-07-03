# Dtr Age Off

The purpose of this script is to scrape DTR for older images. The one caveat is that the repository must have Tag Immutability turned

## Requirements
    - jq
    - curl
    - coreutils (for gdate)

## Install

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
