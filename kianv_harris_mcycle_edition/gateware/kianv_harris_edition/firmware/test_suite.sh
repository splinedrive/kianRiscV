#!/bin/bash
while IFS= read -r line
do
#  echo "$line"
  ./gen_test.sh $line
  pushd ..
  ./sim.sh +test=$line
  popd
  //read -n 1 k <&1
done <<< $(ls -1 *.S)
