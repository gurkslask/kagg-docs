for lin in {11..17}
do 
	echo $lin
	linode-cli linodes create --label Elev$lin --tag Elever --root_pass L4rsK4ggD4t4!
done
