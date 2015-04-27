#!/bin/sh
# vim:et:ft=sh:sts=2:sw=2
#
# Copyright 2008 Kate Ward. All Rights Reserved.
# Released under the LGPL (GNU Lesser General Public License)
#
# Author: kate.ward@forestent.com (Kate Ward)
#
# Example unit test for the mkdir command.
#
# There are times when an existing shell script needs to be tested. In this
# example, we will test several aspects of the the mkdir command, but the
# techniques could be used for any existing shell script.

#-----------------------------------------------------------------------------
# suite tests
#

unset TEST_VAR

TestMissingDirectoryCreation()
{
  ${mkdirCmd} "${testDir}" >${stdoutF} 2>${stderrF}
  rtrn=$?
  th_assertTrueWithNoOutput ${rtrn} "${stdoutF}" "${stderrF}"

  assertTrue 'directory missing' "[ -d '${testDir}' ]"
}

# load and run shUnit2
. ./downloads/shunit2-2.1.6/src/shunit2
