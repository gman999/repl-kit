#!/bin/sh
# 20140701
# determine integrity of AroundBlocks.info mirror compared to local copy
# add to mirrors.html file if good, add to bad_sites if bad

store="${store:-/tmp}"
base="$store/base"
#oops="$store/sorry_message"
#url="${url:-http://dhppldk4qfqssn4x.onion}"
url="${url:-http://ljqw3pmt7wgt653a.onion}"
#urls="urls.txt"
#site="${site:-dhppldk4qfqssn4x.onion"}
site="${site:-ljqw3pmt7wgt653a.onion}"
#sites="sites.txt"
tor="/usr/local/bin/usewithtor"
admin="${admin:-george@queair.net"}
alert="$alert:-george@queair.net"}

# check if /tmp/base is at least populated, if not a good copy

base_check ()  {

if [ ! -f $base/* ]; then
#        echo "The $base directory is empty.  Nothing to diff with."
	logger -s "The $base directory is empty.  Nothing to diff with."
        exit 1;
else
	logger -s "$base seems populated, at least"
fi
}

# wget the mirror site and put into /tmp/$url

get_site () {

if [ *.onion ]; then
	$tor /usr/local/bin/wget --no-check-certificate -m -P $store $url

else

	/usr/local/bin/wget --no-check-certificate -m -P $store $url
fi
}

# diff the clean copy and mirror and output diff to /tmp

diff_site ()  {
/usr/bin/diff -qr $base $store/$site >$store/diff_$site
}

base_check; get_site; diff_site

# if there's content to diff_$site add to bad_sites.  If not, ignore

if [ ! -s "diff_$site" ]; then
	echo " $site" >>$store/bad_sites
#        echo "<p> $site bad as of `date`" >>/usr/local/www/blocks/index.html
        logger -s "diff problem with $site"
#	cat $oops $store/diff_$site >$store/notice
#	cat $store/notice  | mail -s "Problem with your AroundBlocks.info mirror" $admin

else
 	echo "$site good as of `date`" >/usr/local/www/blocks/index.html
	logger -s "$site good as of `date`."
fi

true
