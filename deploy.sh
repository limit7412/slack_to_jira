#!/bin/bash

stg=${1}
[ "$stg" = "" ] && stg="dev"

region="ap-northeast-1"
container="slack_to_jira_$stg"

docker run --name $container -d $container /bin/sh
docker cp $container:/work/bootstrap .
docker rm $container

sls deploy --stage $stg