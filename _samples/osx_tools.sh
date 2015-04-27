#!/bin/bash

case $( uname -s ) in
    Darwin )
		# We have a Mac
		case $( uname -r ) in
            0.1 )
				# March 16, 1999	Mac OS X DP	0.1 is contrived (for sorting and identification) as this identified itself simply as Mac OS 10.0
				;;
			0.2	)
				# November 10, 1999	Mac OS X DP2	
				;;
            1.0 )
				# February 2000	Mac OS X DP3	
				;;
			1.1	)
				# April 5, 2000	Mac OS X DP4	
				;;
            1.2.1 )
				# November 15, 2000	Mac OS X Public Beta	Code named "Kodiak"
				;;
            1.3.1 )
				# April 13, 2001	Mac OS X v10.0	First commercial release of Darwin
				;;
			1.3.1 )
				# June 21, 2001	Mac OS X v10.0.4	All releases of "Cheetah" (10.0–10.0.4) had the same version of Darwin
				;;
			1.4.1 )
				# October 2, 2001	Mac OS X v10.1	Performance improvements to "boot time, real-time 
				# threads, thread management, cache flushing, and preemption handling," 
				# support for SMB network file system, Wget replaced with cURL.[15]
				;;
            5.1 )
				# November 12, 2001	Mac OS X v10.1.1	Change in numbering scheme to match Mac OS X build numbering scheme 
				# (e.g., Mac OS X v10.1 contains build numbers starting with 5 so Mac OS X v10.1.1 
				# is now based on Darwin 5.1; i.e., 10.1 means 5 so 10.1.1 means 5.1, etc.)
				;;
			5.5 )
				# June 5, 2002	Mac OS X v10.1.5	Last release of "Puma"
				;;
			6.0.1 )
				# September 23, 2002	Mac OS X v10.2 (Darwin 6.0.2)	GCC upgraded from 2 to 3.1, IPv6 and IPSec support, 
				# mDNSResponder service discovery daemon (Rendezvous), addition of CUPS, Ruby, and Python, journaling support in HFS+ 
				# (Darwin 6.2), application profiles ("pre-heat files") for faster program launching.[16]
				;;
            6.8 )
				# October 3, 2003	Mac OS X v10.2.8	Last release of "Jaguar"
				;;
            7.0 )
				# October 24, 2003	Mac OS X v10.3	BSD layer synchronized with FreeBSD 5, automatic file defragmentation, 
				# hot-file clustering, and optional case sensitivity in HFS+, bash instead of tcsh as default shell, 
				# read-only NTFS support (Darwin 7.9).[17]
				;;
			7.9 )
				# April 15, 2005	Mac OS X v10.3.9	Last release of "Panther"
				;;
			8.0 )
				# April 29, 2005	Mac OS X v10.4 Mac OS X for Apple TV (Darwin 8.8.2)	Stable kernel programming interface, 
				# finer-grained kernel locking, 64-bit BSD layer, launchd service management framework, extended file attributes, 
				# access control lists, commands such as cp and mv updated to preserve extended attributes and resource forks.[18]
				;;
			8.11 )
				# November 14, 2007	Mac OS X v10.4.11	Last release of "Tiger"
				;;
			9.0 )
				# October 26, 2007	iPhone OS 1 (Darwin 9.0.0d1) Mac OS X v10.5	Full POSIX compliance, improved hierarchical process scheduling model, 
				# dynamically allocated swap files, dynamic resource limits (for files and processes), process sandboxing, 
				# address space layout randomization, DTrace tracing framework, file system events daemon, directory hard links, 
				# Apache 1.3 and PHP 4 updated to Apache 2.2 and PHP 5, read-only ZFS support.[19] First Darwin core used for iPhone devices.
				;;
			9.8 )
				# August 5, 2009	Mac OS X v10.5.8	Last release of "Leopard" 10.0	August 28, 2009	iOS 4 and Mac OS X v10.6	
				# End of official support for PowerPC architecture (although several fat binaries, such as Kernel, still contain PPC images); 
				# 64-bit kernel and drivers, libdispatch task parallelization framework, OpenCL heterogeneous computing framework, 
				# support for blocks in C, transparent file compression in HFS+.[20]
				;;
			10.8 )
				# June 23, 2011	Mac OS X v10.6.8	Last release of "Snow Leopard"
				;;
            11.0.0 )
				# July 20, 2011	iOS 5[21] and Mac OS X v10.7	XNU no longer supports PPC binaries (fat binary only for i386, x86_64). 
				# XNU requires an x86_64 processor, except for iOS which is ARM based. Improved sandboxing of applications
				;;
			11.4.2 )
				# October 4, 2012	Mac OS X v10.7.5	Last release of "Lion", supplemental
				;;
            12.0.0 )
				# February 16, 2012	OS X v10.8	Code named "Mountain Lion"; the word "Mac" has been dropped from the name
				;;
			12.6.0 )
				# January 27, 2015	OS X v10.8.5	Last release of "Mountain Lion" with Security Update 2015-001
				;;
			13.0.0 )
				# June 11, 2013	iOS 6 and OS X v10.9	OS X v. 10.9 is code named "Mavericks"
				;;
			14.0.0 )
				# September 18, 2014	iOS 7, iOS 8 and OS X v10.10	OS X v. 10.10 is code named "Yosemite"
				;;
		esac
        ;;
    Linux )
		# We have a Linux system
		;;
    Unix )
		# We have a UNIX system
		;;
esac
