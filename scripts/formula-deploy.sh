#!/bin/bash -x

# Deploys a new homebrew formula file to golift/homebrew-tap.
# Requires SSH credentials in ssh-agent to work.
# Run by Travis-CI when a new release is created on GitHub.

source .metadata.sh

if [ -z "$VERSION" ]; then
  VERSION=$TRAVIS_TAG
fi
VERSION=$(echo $VERSION|tr -d v)

make ${BINARY}.rb VERSION=$VERSION

if [ -z "$VERSION" ]; then
  VERSION=$(grep -E '^\s+url\s+"' ${BINARY}.rb | cut -d/ -f7 | cut -d. -f1,2,3)
fi

rm -rf homebrew-mugs
git config --global user.email "${BINARY}@auto.releaser"
git config --global user.name "${BINARY}-auto-releaser"
git clone git@github.com:golift/homebrew-mugs.git

cp ${BINARY}.rb homebrew-mugs/Formula
pushd homebrew-mugs
git commit -m "Update ${BINARY} on Release: ${VERSION}-${ITERATION}" Formula/${BINARY}.rb
git push
popd
