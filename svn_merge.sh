#!/bin/bash
usage() {
	echo "Usage: svn_merge  -c version";
	echo "Usage: svn_merge  -r fromVersion(excluded):toVersion(included)";
	exit 1
}

if [ "$#" -ne "2" ]; then
	usage
fi
svn_repository='/home/wafht/dev/nuomi';
dist_branch='prod'
cd "$svn_repository" && svn up; cd "$svn_repository/branches/$dist_branch"
if [ $? ]; then
	case $1 in
		-c)
		  svn merge ../../trunk/ -c $2;; 
		-r)
		  svn merge ../../trunk/ -r $2;;
		*) 
		  usage
		 ;;
	esac
fi

if [ $? ]; then
  	svn up && svn ci -m'merge from trunk'
fi

