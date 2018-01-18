#!/bin/bash
#
# The install command reads the valet.json file from the current directory,
# resolves the dependencies, and installs them into vendor.
#
# `valet install`
#
# If there is a valet.lock file in the current directory, it will use the exact 
# versions from there instead of resolving them. This ensures that everyone using 
# the library will get the same versions of the dependencies.
#
# If there is no valet.lock file, Composer will create one after dependency resolution.

function my_install ()
{
	echo "my_"
}