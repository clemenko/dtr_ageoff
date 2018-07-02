#!/bin/bash
dryrun=no

while getopts ":da:url:user:" opt; do
  case $opt in
    d )
      dryrun=yes
      echo "dryrun : $dryrun" >&2 ;;
    a )
      age=$OPTARG
      echo "age : $age" >&2 ;;
    url )
      url=$OPTARG
      echo "url : $OPTARG" >&2 ;;
    user )
      username=$OPTARG
      echo "username : $OPTARG" >&2 ;;
    \? )
      echo "Usage:"
      echo "  $0 -d             Dryrun"
      echo "  $0 -a             Age in Days"
      echo "  $0 -h             Help"
      echo "  $0 -url           DTR's URL"
      echo "  $0 -user             DTR Admin Username"
      echo ""
      echo "  Typical : $0 -d -a 180 -u admin -url dtr.dockr.life"
      ;;
  esac
done
