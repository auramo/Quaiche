#!/bin/bash

set -e

sudo mkdir -p /usr/local/quaiche 2> /dev/null || true
sudo cp -r lib/* /usr/local/quaiche/.
sudo cp run_content_provider.sh /usr/local/quaiche/.

cp -r ui/NextBuses.wdgt ~/Desktop/.
