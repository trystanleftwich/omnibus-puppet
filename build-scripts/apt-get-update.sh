#!/bin/bash

# Make sure that apt-get updates itself (if this is a system
# that uses apt-get).  The current bento boxes from opscode will
# have outdated indexes and break when trying to find packages
# whose versions do not exist any more.
[[ -f /usr/bin/apt-get ]] && /usr/bin/apt-get update

exit 0
