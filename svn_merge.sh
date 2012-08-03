#!/bin/bash
usage() {
	echo "Usage: svn_merge  -c comma seperated versions";
	echo "Usage: svn_merge  -r fromVersion(excluded):toVersion(included)";
	exit 1
}

if [ "$#" -ne "2" ]; then
	usage
fi

dist_branch='prod'
cd "$svn_repository" && svn up; cd "$svn_repository/branches/$dist_branch"
if [ $? ]; then
	case $1 in
		-c)
		  svn merge ../../trunk/ -c `echo $2| sed 's/,/ -c /g'`;; 
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

