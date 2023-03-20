for lin in {1..3}
do 
	echo $lin
	linode-cli linodes create --label Elev$lin --tag Elever --root_pass L4rsK4ggD4t4!
done
