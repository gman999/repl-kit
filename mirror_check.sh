#!/bin/sh
# check_mirror.sh 20140701 gman
# DEPS wget, tor/torsocks
# determine integrity of AroundBlocks.info mirror compared to local copy
# add to iframe_output.html iframe if good, add to bad_sites if bad
# to use add full urls to $urls file.  periodic housekeeping of it is fine.
# Mirror site data is stored in /tmp since it can get sloppy.

# variables

store="${store:-/tmp}"            	# where the action is
master="${master:-/usr/local/www/nginx/aroundblocks.info}"  # master www site
urls=`cat $store/urls.txt`      	# this should be a text file in $store
sites="echo $urls | sed 's~http[s]*://~~g'"  # $urls without http/s
iframe_output="{iframe_output:-$master/mirror_status.html}"
tor="${tor:-/usr/local/bin/usewithtor}" # torsocks location
wget="${wget:-/usr/local/bin/wget --no-check-certificate -m -P $store $urls}"
now="`date "+%Y%m%d-%H:%M:%S`"

# check if $master is at least populated, if not a good copy

master_check ()  {

if [ ! -f $master/* ]; then
#        echo "The $master directory is empty.  Nothing to diff with."
	logger -s "The $master directory is empty.  Nothing to diff with."
        exit 1;
else
	logger -s "$master seems populated, at least"
fi
}

# wget each mirror site and put into /tmp/$urls

get_site () {

if [ *.onion ]; then
	$tor /usr/local/bin/wget --no-check-certificate -m -P $store $urls
else
	/usr/local/bin/wget --no-check-certificate -m -P $store $urls
fi
}

# diff the $master  and mirror and output diff to /tmp

diff_site ()  {
/usr/bin/diff -qr $master $store/$sites >$store/diff_$site
}

master_check; get_site; diff_site

# if there's content to diff_$site add to bad_sites.  If not, ignore

if [ ! -s "diff_$site" ]; then
	echo " $site" >>$store/bad_sites
        echo "<p> $site bad `date "+%Y%m%d-%H:%M:%S"` >>$store/bad_sites.txt
        logger -s "diff problem with $site"
	cat $store/notice  | mail -s "Problem with your AroundBlocks.info mirror" $admin

else
 	echo "$site good as of $now" >$iframe_output
	logger -s "$site good as of `date`."
fi

true
