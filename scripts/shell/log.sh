#!/bin/sh

# Clean up logs for jobot.  Keep both the last log and the symlink to it.

source .log.conf
cd $JOBOT_LOG

for i in `/bin/ls`
  do
    if [ "`pwd -P`/$i" != "`readlink jobot.log`" ] && [ "$i" != "jobot.log" ]; then
      rm $i
      echo "$i has been deleted"
    fi
  done
