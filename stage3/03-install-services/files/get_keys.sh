#!/bin/bash

USERS=()
USERS+=(aguscerone)
USERS+=(Federicoayala10)
USERS+=(nachocarballeda)
USERS+=(pamoreno)
USERS+=(tulku)
USERS+=(xcancerberox)
USERS+=(yagui)

if nc -dzw3 8.8.8.8 443 || nc -zw3 sentrisense.com 80 ; then
    if [ ! -e "/home/example_user/.ssh/authorized_keys" ] ; then
        mkdir -p "/home/example_user/.ssh" 2> /dev/null
        for user in ${USERS[@]} ; do
            echo ${user}
            curl -L https://github.com/${user}.keys >> "/home/example_user/.ssh/authorized_keys"
        done
    fi
fi
