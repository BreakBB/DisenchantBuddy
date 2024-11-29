#!/bin/sh

LATEST_GIT_TAG="$1"
CHANGELOG=$(jq --slurp --raw-input '.' < "CHANGELOG.md")

if [ "$LATEST_GIT_TAG" == *"-b"* ]; then
  RELEASE_TYPE="beta"
else
  RELEASE_TYPE="stable"
fi

echo "Uploading $RELEASE_TYPE $LATEST_GIT_TAG to Wago"

### WAGO Upload
# Docs: https://docs.wago.io/#introduction

WAGO_METADATA=$(cat <<-EOF
{
   "label": "$LATEST_GIT_TAG",
   "stability": "$RELEASE_TYPE",
   "changelog": $CHANGELOG,
   "supported_classic_patch": "1.15.5"
}
EOF
)

response=$(curl -sS \
    -o response.txt \
    -w "%{http_code}" \
    -H "authorization: Bearer $WAGO_API_TOKEN" \
    -H "accept: application/json" \
    -F "metadata=$WAGO_METADATA" \
    -F "file=@releases/$LATEST_GIT_TAG/DisenchantBuddy-$LATEST_GIT_TAG.zip" \
    "https://addons.wago.io/api/projects/56n9DdN9/version")

http_status=$(echo "$response" | tail -n1)

if [ "$http_status" -eq 201 ]; then
  echo "Wago upload successful"
else
  echo "Wago upload failed, HTTP-code: $http_status"
  cat response.txt
  exit 1
fi