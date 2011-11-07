#!/bin/bash

set -e

sudo mkdir /usr/local/quaiche || true
sudo cp -r lib/* /usr/local/quaiche/.

cp -r ui/NextBuses.wdgt ~/Desktop/.
