#!/bin/bash

set -e

sudo mkdir -p /usr/local/quaiche 2> /dev/null || true
sudo cp -r lib/* /usr/local/quaiche/.

cp -r ui/NextBuses.wdgt ~/Desktop/.
