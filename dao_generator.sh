#!/bin/bash

function capitalize
{
   words=`echo "$*" | sed -r 's/_/ /g'`
   for x in $words
   do
      echo -n ${x:0:1} | tr '[a-z]' '[A-Z]' | xargs echo -n
      echo -n ${x:1} | tr '[A-Z]' '[a-z]' | xargs echo -n
   done
}

function deCapitalize
{
	x="$*"
	echo -n ${x:0:1} | tr '[A-Z]' '[a-z]' | xargs echo -n
        echo -n ${x:1} | xargs echo -n
}

view="public static final String VIEW =\""
table=`capitalize $1`
insert_start='@SQL("insert into '"$1("

fields=`echo "desc $1" |  mysql -A -uroot -pnothing -h10.3.25.157 niux_test --default-character-set=utf8 | grep -v -P '^Field\s' | awk '{print $1}'`   

for field in $fields; do
	view="$view $field,"
done
view=`echo "$view\";" | sed -r 's/(.*),/\1 /g'` 
echo $view
echo
echo
echo
for field in $fields; do
	if [ "$field" == "id" ];then
		continue;
	fi
	insert_start="$insert_start $field,"	
done
insert_start=`echo "$insert_start" | sed -r 's/(.*),/\1/g'` 
insert_start="$insert_start) values ("
for field in $fields; do
	if [ "$field" == "id" ];then
		continue;
	fi
	attr=`capitalize $field`
	dc=`deCapitalize $attr`
	insert_start="$insert_start"":a.""$dc, "	
done
insert_start=`echo "$insert_start" | sed -r 's/(.*),/\1/g'` 
insert_end=")\")"
echo $insert_start$insert_end
echo "@ReturnGeneratedKeys" 
echo "public long insert(@SQLParam(\"a\") $table a); "

echo
echo
echo

update="@SQL(\"update $1 set "
for field in $fields; do
	if [ "$field" != "id" ];then
		attr=`capitalize $field`
		dc=`deCapitalize $attr`
		update="$update $field = :a.$dc, "
	fi
done

update=`echo "$update" | sed -r 's/(.*),/\1 /g'` 
echo -n  $update
echo " where id = :a.id\")"
echo "public int update(@SQLParam(\"a\") $table a); "
