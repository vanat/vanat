#!/bin/bash
#
# In order to get the latest versions of the dependencies and to update the valet.lock file, 
# you should use the update command. This command is also aliased as upgrade as it does
# the same as upgrade does if you are thinking of apt-get or similar package managers.
#
# `valet update`
#
# This will resolve all dependencies of the project and write the exact versions into valet.lock.
#
# If you just want to update a few packages and not all, you can list them as such:
#
# `valet update vendor/package vendor/package2`

function update ()
{
	echo ""
}