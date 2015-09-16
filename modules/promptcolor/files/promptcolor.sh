#!/bin/sh
name=$(head -1 /etc/hostname)
case $name in
        ???D*) sed -i 's/[0-9]\{2\}\;[0-9]\{2\}m/01\;32m/1' /etc/skel/.bashrc ;;
        ???Q*) sed -i 's/[0-9]\{2\}\;[0-9]\{2\}m/01\;33m/1' /etc/skel/.bashrc ;;
        ???P*) sed -i 's/[0-9]\{2\}\;[0-9]\{2\}m/01\;31m/1' /etc/skel/.bashrc ;;
        *) sed -i 's/[0-9]\{2\}\;[0-9]\{2\}m/01\;34m/1' /etc/skel/.bashrc ;;
esac
find /home -maxdepth 2 -type f -name .bashrc -exec sh -c 'cat /etc/skel/.bashrc >{}' \;
exit 0