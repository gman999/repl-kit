#!/bin/sh

URL="https://aroundblocks.info"
SITE="aroundblocks.info"
BASE="/tmp/base"
STORE="/tmp" 	# parent base directory for everything
ADMIN="mirroradmin@test.com"
ALERT="george@queair.net"
OOPS="$STORE/sorry_message"

# check if /tmp/base is at least populated, if not a good copy

base_check ()  {
if [ ! -f $BASE/* ]; then
        echo "The $BASE directory is empty.  Nothing to diff with."
	logger -s "The $BASE directory is empty.  Nothing to diff with."
        exit 1;

else
	logger -s "$BASE seems populated, at least"
fi
}

# wget the mirror site and put into /tmp/$URL

get_site ()  {
/usr/local/bin/wget --no-check-certificate -m -P $STORE $URL
	}

# diff the clean copy and mirror and output diff to /tmp

diff_site ()  {
/usr/bin/diff -qr $BASE $STORE/$SITE >$STORE/diff_$SITE
	}

base_check; get_site; diff_site

# if there's content to diff_$SITE, notify.  If not, ignore

if [ ! -s "diff_$SITE" ]; then
        echo "$SITE bad as of `date`" >>/home/gman/mirror_status.html
        logger -s "diff problem with $SITE"
	cat $OOPS | mail -s "Problem with your AroundBlocks.info mirror" $ADMIN

else

 	echo "$SITE good as of `date`" >>/home/gman/mirror_status.html
	logger -s "$SITE good as of `date`."

fi
