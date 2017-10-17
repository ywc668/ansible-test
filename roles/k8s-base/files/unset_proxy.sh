rm -f /etc/profile.d/proxy.sh
proxies=( http_proxy 
  https_proxy 
  ftp_proxy 
  HTTP_PROXY 
  HTTPS_PROXY 
  FTP_PROXY )
for prox in ${proxies[@]} ; do
  unset $prox
  sed -i "/^$prox/ d" /etc/environment
done
