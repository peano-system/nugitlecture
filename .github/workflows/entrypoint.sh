#!/bin/bash
set -eux

res=`curl -H "Authorization: token $GITHUB_TOKEN" -X POST https://api.github.com/repos/peano-system/nugitlecture/releases \
-d "
{
  \"tag_name\": \"v$GITHUB_SHA\",
  \"target_commitish\": \"$GITHUB_SHA\",
  \"name\": \"v$GITHUB_SHA\",
  \"draft\": false,
  \"prerelease\": false
}"`

# extract release id
rel_id=`echo ${res} | python3 -c 'import json,sys;print(json.load(sys.stdin)["id"])'`

# upload built pdf
curl -H "Authorization: token $GITHUB_TOKEN" -X POST https://uploads.github.com/repos/peano-sytem/nugitlecture/releases/${rel_id}/assets?name=main.pdf\
  --header 'Content-Type: application/pdf'\
  --upload-file main.pdf
