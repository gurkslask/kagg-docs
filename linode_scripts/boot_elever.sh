for lin in $(cat lin.txt | awk '(NR>1){print $1}')
do 
	echo $lin
	linode-cli linodes boot $lin
done
