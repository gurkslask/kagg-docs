export domainres=$(linode-cli domains list |  awk 'FNR > 3 && FNR < 5 {print $2}')
# | awk 'FNR > 3 && FNR < 5 {print $2}'
echo $domainres

linode-cli domains records-list $domainres --text > scr_subdomains.txt


while read p; do
	# echo "$p"
	namn=$(echo $p | awk '{print $3}') #namn
	if [[ $namn =~ .*Elev.* ]]; then
		id=$(echo $p | awk '{print $1}') #id
		linode-cli domains records-delete $domainres $id
	fi
done <scr_subdomains.txt
rm scr_subdomains.txt

# linodes=$(linode-cli linodes list --tag Elever --text)
#linode-cli linodes list --tag Elever --text > linodess.txt
# linodes=$(cat ./linodess.txt)

#names=($(awk 'FNR > 1 {print $2}' ./linodess.txt))
#ips=($(awk 'FNR > 1 {print $7}' ./linodess.txt))


# for i in {1..${#names[@]}}
#l=${#names[@]}
#for (( i=0; i<l; i++));
#do
	#echo linode-cli domains records-create $domainres --type A --name ${names[$i]}.larskaggdata.se --target ${ips[$i]}
	#linode-cli domains records-create $domainres --type A --name ${names[$i]}.larskaggdata.se --target ${ips[$i]}
#done
