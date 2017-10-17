SSHPASS=102040
USERNAME=vagrant
NODE_IPS=$(tail -n +4 hosts)
MASTER_IP=$(awk 'NR==2' hosts)

config::ssh_for_one()
{
IP=$1
echo $IP
sshpass -p vagrant scp set_up_vm.sh vagrant@$IP:/home/vagrant/
echo "file copied"
sshpass -p vagrant ssh vagrant@$IP "cd /home/vagrant && chmod +x set_up_vm.sh && sudo bash set_up_vm.sh"
echo "file executed"
#sshpass -p vagrant ssh vagrant@$IP "sudo echo -e "$2\n$2" | sudo passwd root"
echo "change passwd $2"
sshpass -p $2 ssh-copy-id -i /root/.ssh/id_rsa.pub root@$IP
echo "set up no passwd"
}

config::delete_ip_link_for_one()
{
IP=$1
sshpass -p 102040 scp delete_ip_link.sh root@$IP:/home/vagrant/
sshpass -p 102040 ssh root@$IP "cd /home/vagrant && chmod +x delete_ip_link.sh && sudo bash delete_ip_link.sh"
}

config::delete_ip_link()
{
config::delete_ip_link_for_one $MASTER_IP
for IP in ${NODE_IPS// / };do
  config::delete_ip_link_for_one $IP
done

}

route::add_on_master()
{
n=1
for IP in ${NODE_IPS// / };do
  sshpass -p 102040 ssh root@$MASTER_IP "ip route add 12.12.$n.0/24 via $IP"
  echo "$n"
  echo "$IP"
  n=$((n+1))
done
}

route::add_on_node()
{
for IP in ${NODE_IPS// / };do
  n=1
  for IP_ADD in ${NODE_IPS// / };do
    if [ $IP != $IP_ADD ]; then
      sshpass -p 102040 ssh root@$IP "ip route add 12.12.$n.0/24 via $IP_ADD"
    fi
    n=$((n+1))
  done
done
for IP in ${NODE_IPS// / };do
  sshpass -p 102040 ssh root@$IP "ip route add 12.12.0.0/24 via $MASTER_IP"
  n=$((n+1))
done
}

config::ssh()
{
config::ssh_for_one $MASTER_IP $SSHPASS
for IP in ${NODE_IPS// / };do
  config::ssh_for_one $IP $SSHPASS
done
}

config::select_flannel()
{
CLUSTER_IPS=$(echo $MASTER_IP | awk -F '.' '{print $1"."$2"."$3".*"}')
sed -e "s/MASTER_IP/$MASTER_IP/g;s/CLUSTER_IPS/$CLUSTER_IPS/g;s/FLANNEL/true/g;s/WEAVE/false/g" group_vars/main-template.yml > group_vars/main.yml
}

config::select_weave()
{
CLUSTER_IPS=$(echo $MASTER_IP | awk -F '.' '{print $1"."$2"."$3".*"}')
sed -e "s/MASTER_IP/$MASTER_IP/g;s/CLUSTER_IPS/$CLUSTER_IPS/g;s/FLANNEL/false/g;s/WEAVE/true/g" group_vars/main-template.yml > group_vars/main.yml
}

config::select_kubenet()
{
CLUSTER_IPS=$(echo $MASTER_IP | awk -F '.' '{print $1"."$2"."$3".*"}')
sed -e "s/MASTER_IP/$MASTER_IP/g;s/CLUSTER_IPS/$CLUSTER_IPS/g;s/FLANNEL/false/g;s/WEAVE/false/g" group_vars/main-template.yml > group_vars/main.yml
route::add_on_master
route::add_on_node
}

config::first_time()
{
config::ssh
config::delete_ip_link
echo "first time"
}

config::normal()
{
config::delete_ip_link
echo "normal"
}

while true; do
    read -p "Fist time install?(y/n)" yn
    case $yn in
        [Yy]* ) config::first_time; break;;
        [Nn]* ) config::normal; break;;
        [Cancel]* ) exit;;
        * ) echo "Please answer.";;
    esac
done

while true; do
    read -p "Please select network plugin.(flannel[f]/weave[w]/kubenet[k])" fwk
    case $fwk in
        [f]* ) config::select_flannel; break;;
        [w]* ) config::select_weave; break;;
        [k]* ) config::select_kubenet; break;;
        [Cancel]* ) exit;;
        * ) echo "Please select network plugin.";;
    esac        
done

ansible-playbook -i hosts main.yml -v
