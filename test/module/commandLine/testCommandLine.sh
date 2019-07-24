#! /bin/bash

# to run this script: cd to its location and call it (no args)
# optionally:
# testCommandLine.sh &> bashTest_$(date +%F).txt

# This test assumes that BioLockJ has been installed
# and that the (as a result) the biolockj script directory
# is on the $PATH, as we expect it to be for users.

check_it(){
	echo "-"
	# we don't expect anything in the .err files
	errSize=$(du ${id}.err | cut -f 1)
	[ $errSize -gt 0 ] && echo "$(du -h ${id}.err)"
	# compare the .out files to previous run
	hasDiff=$(diff ${id}.out expected/${id}.out)
	[ ${#hasDiff} -gt 0 ] && echo "oh no! examine $id !" && echo $hasDiff
	[ ${#hasDiff} -eq 0 ] && echo "$id --> just as expected."
}

id=test_01
biolockj_args baz 1> ${id}.out 2>${id}.err
check_it




id=test_10
biolockj_args -r --pass bar baz 1> ${id}.out 2>${id}.err
check_it

id=test_11
biolockj_args -r baz 1> ${id}.out 2>${id}.err
check_it

