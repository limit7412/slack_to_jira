#!/bin/bash

region="ap-northeast-1"
container="slack_to_jira_local"

docker run --name $container -d $container /bin/sh
docker cp $container:/work/bootstrap .
docker rm $container

zip slack_to_jira ./bootstrap