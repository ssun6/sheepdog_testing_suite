#! /bin/bash

# to run this script: cd to its location and call it (no args)
# optional:
# rm test*.err; rm test*.out
# testCommandLine.sh &> NOT_IN_GIT_testCommandLine$(date +%F).txt

# This test assumes that BioLockJ has been installed
# and that the (as a result) the biolockj script directory
# is on the $PATH, as we expect it to be for users.

export BIOLOCKJ_TEST_MODE="anything"

check_it(){
	echo "-"
	# we don't expect anything in the .err files
	errSize=$(du ${id}.err | cut -f 1)
	[ $errSize -gt 0 ] && echo "$(du -h ${id}.err)"
	[ $errSize -eq 0 ] && rm ${id}.err
	# compare the .out files to previous run
	hasDiff=$(diff ${id}.out expected/${id}.out)
	[ ${#hasDiff} -gt 0 ] && echo "oh no! examine $id !" && echo $hasDiff
	[ ${#hasDiff} -eq 0 ] && echo "$id --> just as expected."
}

id=test_00
biolockj_args 1> ${id}.out 2>${id}.err
check_it


id=test_01_v
biolockj_args -v 1> ${id}.out 2>${id}.err
check_it

id=test_01_version
biolockj_args --version 1> ${id}.out 2>${id}.err
check_it


id=test_02_h
biolockj_args -h 1> ${id}.out 2>${id}.err
check_it

id=test_02_help
biolockj_args --help 1> ${id}.out 2>${id}.err
check_it


id=test_03_typo
biolockj_args -f 1> ${id}.out 2>${id}.err
check_it

id=test_03_typos
biolockj_args -fh 1> ${id}.out 2>${id}.err
check_it

id=test_03_longTypo
biolockj_args --aBadParam 1> ${id}.out 2>${id}.err
check_it


id=test_05_basic
biolockj_args example.properties 1> ${id}.out 2>${id}.err
check_it


id=test_6_r
biolockj_args -r example.properties 1> ${id}.out 2>${id}.err
check_it

id=test_6_restart
biolockj_args --restart example.properties 1> ${id}.out 2>${id}.err
check_it


id=test_10
biolockj_args -r --pass bar baz 1> ${id}.out 2>${id}.err
check_it

id=test_11
biolockj_args -r baz 1> ${id}.out 2>${id}.err
check_it

