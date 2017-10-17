utils::array_contains()
{
    local array="$1[@]"
    local seeking=$2
    local in=1
    for element in "${!array}"; do
        if [[ $element == $seeking ]]; then
            in=0
            break
        fi
    done
    return $in
}


system::delete_iplinks()
{
  ip link | awk 'NR % 2 != 0' > iplinks.txt
  while read line; do
    LINK="$(echo "$line" | grep -o -P '(?<=:).*(?=:)')"
    link_keep=(' lo' ' enp0s3' 'enp0s8' ' docker0' ' tap0')
    utils::array_contains link_keep "$LINK"
    if [ $? -eq 1 ]; then
      echo "delete $LINK"
      ip link delete $LINK
    fi
  done < iplinks.txt
  rm iplinks.txt
}

kubeadm reset
systemctl stop kubelet.service
docker ps -aq|xargs -I '{}' docker stop {}
docker ps -aq|xargs -I '{}' docker rm {}
df |grep /var/lib/kubelet|awk '{ print $6 }'|xargs -I '{}' umount {}
rm -rf /var/lib/kubelet && rm -rf /etc/kubernetes/ && rm -rf /var/lib/etcd
rm -rf /var/lib/cni
#ip link del cni0
system::delete_iplinks
