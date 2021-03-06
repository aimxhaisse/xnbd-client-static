#!/usr/bin/env bash

set -e

# A tiny helper to release the binary under the dist branch.

docker build -t 'xnbd-client-static' .
git branch -D dist
git fetch
git checkout origin/dist -b dist
docker run --name xnbd-client-static xnbd-client-static /bin/true
docker cp xnbd-client-static:/xnbd-client-static bin
docker cp xnbd-client-static:/xnbd-client-static-stripped bin
git add bin/xnbd-client-static*
git commit -am "Bumped new release."
git push origin dist
git checkout master
