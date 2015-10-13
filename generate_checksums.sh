#!/bin/sh

touch CHECKSUMS;

/bin/sha256 cull_bad.sh mirror_check.sh mirror_pull.sh tar_site.sh zip_site.sh  >>CHECKSUMS
