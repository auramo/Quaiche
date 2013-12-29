#!/usr/bin/env bash

# I run ruby via rvm, and the rvm settings are in my .profile. Therefore I need to source it here:
. $HOME/.profile
# Your environment might vary, ust make sure your Ruby has the required environment and can be found
# The tweaks should be done in this script

# install.sh copies the quaiche ruby code here:
ruby /usr/local/quaiche/content_provider.rb
