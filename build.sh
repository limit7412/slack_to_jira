#!/bin/bash

stg=$1
[ "$stg" = "" ] && stg="dev"

rm -rf ./bootstrap
pub get || exit 1

dart2native ./src/main.dart -o ./bootstrap &&
sudo chmod 755 ./bootstrap || exit 1

zip slack_to_jira ./bootstrap