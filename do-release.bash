#!/usr/bin/env bash

# A tiny helper to release the binary under the dist branch.

docker build -t 'xnbd-client-static' .
docker cp xnbd-client-static /xnbd-client-static .
git checkout origin/dist -b dist
git add xnbd-client-static
git commit -am "Bumped new release."
git push origin dist
git checkout master
