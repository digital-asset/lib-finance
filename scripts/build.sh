#!/bin/bash

cd `dirname $0`
cd ..

DIRS=("daml-model"
      "daml-trigger"
      )

function cleanDars {
  for dr in ${DIRS[@]}
  do 
    rm -f $dr/.dist
  done
}

function buildDars {
  for dr in ${DIRS[@]}
  do
    echo "building dar in $dr"
    cd $dr
    daml build
    cd ..
  done
}

function updateVersion {
  if [ "$1" == "" ]; then
    echo "please provide the new version"
    exit 1
  fi
  for dr in ${DIRS[@]}
  do
    cat $dr/daml.yaml | sed -E "s/^(sdk-version:).*/\\1 $1/" > tmp.yml
    mv tmp.yml $dr/daml.yaml
  done
}

case $1 in

  update-version)
    updateVersion $2
    ;;
  build-dars)
    cleanDars
    buildDars
    ;;
  *)
    echo "builder <command>"
    echo "  commands are:"
    echo "    build-dars - builds the dars"
    echo "    update-version <version> - changes the sdk version number"
    ;;
esac
