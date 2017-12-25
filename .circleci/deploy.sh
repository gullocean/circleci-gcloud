#!/bin/sh

sudo su -

if [ -z "$1" ]; then echo "Deploy branch not provided"; exit 1; fi
if [ -z "$2" ]; then echo "Commit hash not provided"; exit 1; fi

DEPLOYDIR=/opt/blog-ui/
BRANCH=$1
COMMIT=$2
REMOTE=origin

cd $DEPLOYDIR

echo "Deploying branch $BRANCH at $COMMIT..."

echo "Updating source..."
git checkout -f $BRANCH
git pull $REMOTE $BRANCH
git reset --hard $COMMIT

echo "Installing dependencies..."

yarn install
bower install --allow-root

echo "Staring build..."
if [ "${BRANCH}" == "develop" ]; then yarn dev; fi
if [ "${BRANCH}" == "staging" ]; then yarn staging; fi
if [ "${BRANCH}" == "feature/README" ]; then yarn prod; fi

exit 0
