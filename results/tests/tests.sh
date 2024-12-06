#!/bin/bash

while ! timeout 1 bash -c "echo > /dev/tcp/poll/80"; do
    sleep 1
done

curl -sS -X POST --data "vote=b" http://poll > /dev/null
sleep 10

if phantomjs render.js http://results | grep -q '1 vote'; then
  echo -e "\\e[42m------------"
  echo -e "\\e[92mTests passed"
  echo -e "\\e[42m------------"
  exit 0
else
  echo -e "\\e[41m------------"
  echo -e "\\e[91mTests failed"
  echo -e "\\e[41m------------"
  exit 1
fi

