#!/bin/bash
#
# The require command adds new packages to the valet.json file from the current directory. 
# If no file exists one will be created on the fly.
#
# `valet require`
#
# After adding/changing the requirements, the modified requirements will be installed or updated.
#
# If you do not want to choose requirements interactively, you can just pass them to the command.
#
# `valet require vendor/package:2.* vendor/package2:dev-master`
#
# If you do not specify a package, valet will prompt you to search for a package, 
# and given results, provide a list of matches to require.

function require ()
{
	echo ""
}
