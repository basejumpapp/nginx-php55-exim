#!/bin/bash

# get ec2 public hostname
cat /etc/issue | grep Amazon
if [ -e /etc/issue ]; then
    ISSUE=$(cat /etc/issue | grep Amazon)
    if [ -z "$ISSUE" ]; then
        # not amazon - just use the IP address
        PUBLIC_HOSTNAME=$(hostname -I | cut -f1 -d' ')
    else
        # is amazon
        PUBLIC_HOSTNAME=$(curl -q http://169.254.169.254/latest/meta-data/public-hostname 2>/dev/null)
    fi
fi;


# modify exim.conf
SRC_FILE="/etc/exim/exim.conf"
TMP_FILE="/tmp/exim.conf"
SED_LINE='s!@@HOSTNAME@@!'${PUBLIC_HOSTNAME}'!g'
/bin/cp $SRC_FILE $TMP_FILE
cat $TMP_FILE | sed -e "$SED_LINE" > $SRC_FILE

# start exim
/usr/sbin/exim -bdf -q1h
