#!/bin/bash
exec 1> >(logger -s -t $(basename $0)) 2>&1

count=0
while sleep 5; do
  resp=$(curl -H "Accept: application/json" -H "Contenet-Type: application/json" localhost:8081/status | jq '.res')
#  echo $resp >> final.txt
  if [ $resp -eq 255 ]
  then
    count=$((count+1))
  else
    count=0
  fi
#  echo $count >> final.txt
  if [ $count -ge 3 ]
  then
    echo "n3-spectro-status: spectrometer lost connection, reboot"
    sudo reboot
  fi
done
