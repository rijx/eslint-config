#!/bin/bash -eu

VERSION="$1"

LATEST_VERSION=$(npx semver --include-prerelease $(git tag -l 'v*') $VERSION | tail -n 1)

if [ "$VERSION" = "$LATEST_VERSION" ]; then
  echo "Not creating release branch for latest version"
  exit
fi

BRANCH_NAME="$(npx semver $VERSION | awk -F. '{ print "release/" $1 "." $2 }')"

if [ ! -z "$(git ls-remote --heads origin | grep refs/heads/$BRANCH_NAME)" ]; then
  exit
fi

git push origin "HEAD:refs/heads/$BRANCH_NAME"
