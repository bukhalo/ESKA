#!/bin/bash

USER=""
PASS=""
SERVER=""
PING_HOST=""
PING_PORT=""

run() {
  nc -G 2 -v $PING_HOST $PING_PORT &> /dev/null
  if [ $? -eq 0 ]
  then
    run
  else
    /Library/Application\ Support/Checkpoint/Endpoint\ Connect/command_line disconnect
    /Library/Application\ Support/Checkpoint/Endpoint\ Connect/command_line connect -s $SERVER -u $USER -p $PASS
    run
  fi
}

run