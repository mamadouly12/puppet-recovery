#!/bin/sh
# Usage: sh svnpurge repository-whole-path max-rev-to-backup
#

[ $# -lt 2 ] && {
        echo Usage: $0 repository-whole-path max-rev-to-backup
        exit 1
}

ARCHIVE_UPTO=$2
REPONAME=$1

ARCHIVE_FROM=`expr $ARCHIVE_UPTO + 1`
#il est possible à ce niveau de faire un backup du DEPOT; à vous de voir
OLD_UUID=`svnlook uuid ${REPONAME}`
bash gen-empty-revs.sh ${ARCHIVE_UPTO} ${OLD_UUID} > gen-dump
svnadmin dump ${REPONAME} -r $ARCHIVE_FROM:HEAD --deltas >> gen-dump
rm -rf ${REPONAME}
svnadmin create ${REPONAME}
svnadmin load --force-uuid ${REPONAME} < gen-dump
