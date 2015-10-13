#!/bin/sh
# tar_site.sh 20140721 gman
# DEPS none
# create a tarball of www site and dump to some place with SHA256 checksum into iframe

# variables
#wwwroot="${wwwroot:-/usr/local/www/site}" 	# site's www directory
#storeroot="${storeroot:-/usr/local/www/storage}" # location for dumping zip file
storeroot="${storeroot:-/tmp}"
site_tarball="${site_tarball:-site.tar.gz}"		# output zip file name
tar="${tar:-tar zcf $storeroot/$site_tarball $wwwroot}"	# gzip command
checksum="${checksum:-/bin/sha256}"			# define checksum
iframe_output="${iframe_output:-$wwwroot/tar_frame.html}"	# iframe output html file

# clean-up old

rm $storeroot/$site_tarball $wwwroot/$iframe_output;

$tar $wwwroot/;

# output iframe html to www page

echo "<a href="$storeroot/$site_tarball">aroundblocks.tar.gz</a><p>" >$iframe_output;

# add the SHA256 checksum to the iframe

$checksum $storeroot/$site_tarball | cut -d " " -f 1,4 >>$iframe_output;

true
