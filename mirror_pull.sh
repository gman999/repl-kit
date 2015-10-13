#!/bin/sh
# mirror_pull.sh 20140721 gman
# DEPS wget, fetch
# mirror a remote site based on a change to the master site

# variables
master="${master:-			# master site to mirror
pull="${pull:-/usr/local/bin/wget}"	# method of pull wget|fetch|whatever
tor="${tor:-/usr/local/bin/usewithtor}"	# torsocks location
store="${store:-/tmp}"			# local store for remote mirror
mirror="${mirror:-/usr/local/www/mirror}"	# location of local mirror

# functions

is tor socks listening?  if not, and mirror is .onion, use tor2web.org

if it is, user can decide whether to access mirror over tor

grab the $mirror with wget|fetch then do store the checksum and keep the remote site to speed up differential pull
