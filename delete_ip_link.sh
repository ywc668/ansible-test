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
    link_keep=(' lo' ' enp0s3' ' enp0s8' ' docker0')
    utils::array_contains link_keep "$LINK"
    if [ $? -eq 1 ]; then
      echo "delete $LINK"
      ip link delete $LINK
    fi
  done < iplinks.txt
  rm iplinks.txt
}

system::delete_iplinks
