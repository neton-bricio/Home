#!/bin/sh
#
# ~/.config/xfe/scripts/send_email
#
# Author: Alexandre Boleli Soares - 30/11/2014

files=$(echo "$@" | sed -e 's/\s/,/g')
claws-mail --compose "attachment='$files'"
