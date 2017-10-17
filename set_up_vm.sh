config::root_remote()
{
sudo sed -n '/prohibit-password/p' /etc/ssh/sshd_config | sed -i 's/prohibit-password/yes/g'  /etc/ssh/sshd_config
sudo service sshd restart
}

config::machine_name()
{
ip=$(ifconfig|grep 192.168.| cut -d' ' -f12|cut -d':' -f2)
nodename=$(hostname) 
nodename=$(echo $ip |sed  's/\./-/g').$nodename  
echo "$nodename" > /etc/hostname
sudo sysctl kernel.hostname=$nodename 
sudo sed -i "/127.0.0.1\tlocalhost/a 127.0.0.1\t$nodename" /etc/hosts  
sudo sed -i "/127.0.0.1\tlocalhost/i $ip\t$nodename" /etc/hosts
}

config::root_remote
config::machine_name
