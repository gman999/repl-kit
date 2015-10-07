#repl-kit
repl-kit is a suite of simple POSIX-compliant shell scripts for maintaining static mirrors for software distribution.

"Master" refers to the main software repository, while "mirror" refers to the hosts which replicate the master.

The master site can confirm the integrity of the offered mirrors, and list them in a simple HTML frame when verified. The mirror sites can update the local software repository as needed. repl-kit (should be) fully portable to any free Unix-like operating system, and is also capable of dwelling in the world of Tor hidden services.

The files are structured so that only the initial "variables" section needs to be edited.  Since these scripts were developed on OpenBSD, the default paths reflect that operating system.  Other possible changes include adjusting the actual pull application.  By default wget(1), but other options include fetch, curl or rsync, not to mention external scripts from Perl or Python.

The files are built to be run from cron(8) to ease the maintainance from the perspective of both the master site and mirror administrators.

The scripts include:

check_mirror.sh
Check the status of the mirror[s], outputting the valid mirrors to an iframe ready for html display with a time stamp.

mirror_pull.sh
Check the master site, and pull if necessary.

cull_bad.sh
Remove lines over 30 days old in the bad_sites.txt file.

tar_site.sh
Create a tarball of master for ease of remote replication, outputting href link and SHA256 checksum to an iframe.

zip_site.sh
Create a zip file of master for ease of remote replication, outputting href link and SHA256 checksum to an iframe.

Files

CHECKSUMS
This file is included with the files for verifying the cryptographic signatures of the scripts.

Variables

$wwwroot
The location of the main document root for the web server, for either the mirror or the master.

$master
The master copy of the web site being mirrored.

$store
A temporary location where the mirror and master web site content is stored, along with other files.

$urls
A text file containing a list of the mirror web sites.

$sites
The $urls file without the prepending http[s]:// for labeling purposes.

$iframe_output
The file to which iframe data is output, which requires the iframe to be a component of a web site's respective page.

$pull
A tool such as wget or fetch to pull a remote web site's data for diff(1) comparison.

$checksum
The tool to create checksum signatures on files.  SHA256 is used as default, but this can be replaced as per needs.

Diagram Overview

$master ? -->$mirror
Is/are the mirror[s] valid?  If so, output to html.
