#!/usr/bin/env bash

curl -sSLf https://api.github.com/repos/aws/aws-sam-cli/releases/latest  | jq -r '.tag_name' | sed 's/[^0-9\.]//g'
