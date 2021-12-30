#!/bin/bash -eu

REF_NAME="$1"

if [ "$REF_NAME" = "master" ]; then
  LATEST_VERSION=$(npx semver --include-prerelease $(git tag -l 'v*') | tail -n 1)
elif echo "$REF_NAME" | grep -q release/; then
  MINOR_VERSION=$(echo "$REF_NAME" | awk -F/ '{ print $2 }')
  LATEST_VERSION=$(npx semver -r "$MINOR_VERSION.x" --include-prerelease $(git tag -l 'v*') | tail -n 1)
fi

if [ -z "$LATEST_VERSION" ]; then
  exit 1
fi

GET_CHANGES_CMD="git log --format=format:%s v$LATEST_VERSION..HEAD"

BREAKING_CHANGES="$($GET_CHANGES_CMD | egrep -i '^(breaking|major):' || true)"
ADDED_FEATURES="$($GET_CHANGES_CMD | egrep -i '^(feature|feat|added):' || true)"
FIXES="$($GET_CHANGES_CMD | egrep -i '^(fix|fixed|patch|patched|bug):' || true)"

if [ ! -z "$BREAKING_CHANGES" ]; then
  INCREMENT=major
elif [ ! -z "$ADDED_FEATURES" ]; then
  INCREMENT=minor
elif [ ! -z "$FIXES" ]; then
  INCREMENT=patch
else
  exit 1
fi

echo "v$(npx semver --increment $INCREMENT $LATEST_VERSION)"
