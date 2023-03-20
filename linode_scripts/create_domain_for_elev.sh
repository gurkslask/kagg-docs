export domainres=$(linode-cli domains list |  awk 'FNR > 3 && FNR < 5 {print $2}')
# | awk 'FNR > 3 && FNR < 5 {print $2}'
echo $domainres

# linodes=$(linode-cli linodes list --tag Elever --text)
linode-cli linodes list --tag Elever --text > linodess.txt
# linodes=$(cat ./linodess.txt)

names=($(awk 'FNR > 1 {print $2}' ./linodess.txt))
ips=($(awk 'FNR > 1 {print $7}' ./linodess.txt))


# for i in {1..${#names[@]}}
l=${#names[@]}
for (( i=0; i<l; i++));
do
	echo linode-cli domains records-create $domainres --type A --name ${names[$i]}.larskaggdata.se --target ${ips[$i]}
	linode-cli domains records-create $domainres --type A --name ${names[$i]}.larskaggdata.se --target ${ips[$i]} --ttl_sec 300
done

rm linodess.txt
