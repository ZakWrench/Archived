#!/bin/bash -e

a=75
for i in *.jpeg; do
  new=$(printf "%01d.jpeg" "$a") #04 pad to length of 4
  mv -i -- "$i" "$new"
  let a=a+1
done
