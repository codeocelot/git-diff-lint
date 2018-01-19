#!/bin/bash 

DIFF=$(git diff --name-only --diff-filter=ACMRTUXB $(git merge-base HEAD stage) | grep '\.py$')

echo $DIFF 

if [ -n "$DIFF" ]
then
  echo "uh"
  ERRORS=$(pycodestyle $DIFF)
  OUT=$?
  if [ $OUT ]
  then
    echo $ERRORS
  fi
  exit $OUT
else 
  exit 0
fi 

