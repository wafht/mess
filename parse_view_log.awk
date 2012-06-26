cat /root/user_view_row_statistic.log | awk -F'-' '{if($2>=1){ $2=$2-1};if($3==0){$3=1} city_row_count[$1" "$2*24+$3]++;city_count[$1]++} END{ for(e in city_row_count) {city=split(e,a," "); print city_count[a[1]], e,city_row_count[e],city_count[a[1]],city_row_count[e]/city_count[a[1]] }}'  | sort -n -t' ' --key=1,3 | awk '{$1="";print $0}'

