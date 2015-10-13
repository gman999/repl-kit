#!/bin/sh
# zip_site.sh 20140709 gman
# DEPS zip
# create zip file of www site and dump to some place with SHA256 checksum into iframe

# variables
#wwwroot="${wwwroot:-/usr/local/www/site}" 		# site's www directory
#storeroot="${storeroot:-/usr/local/www/storage}"	# location for dumping zip file
storeroot="${storeroot:-/tmp}"
site_zip="${site_zip:-website.zip}"			# output zip file name
zip="${zip:-/usr/local/bin/zip -r $storeroot/$site_zip $wwwroot}"  # zip command
checksum="${checksum:-/bin/sha256}"			# define checksum
iframe_output="${iframe_output:-$wwwroot/zip_frame.html}" # iframe output html file

# clean-up old

rm $storeroot/$site_zip $wwwroot/$iframe_output;

$zip $wwwroot/;

# output iframe html to www page

echo "<a href="$storeroot/$site_zip">website.zip</a><p>" >$iframe_output;

# add the SHA256 checksum to the iframe

$checksum $storeroot/$site_zip | cut -d " " -f 1,4 >>$iframe_output;

true
