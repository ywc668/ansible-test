KUBECONFIG=/etc/kubernetes/admin.conf

echo $(grep -o 'certificate-authority-data: [^ ,]\+' $KUBECONFIG  | awk '{print $2}') | base64 --decode > admin-server.crt
echo $(grep -o 'client-key-data: [^ ,]\+' $KUBECONFIG  | awk '{print $2}') | base64 --decode > admin-client.key
echo $(grep -o 'client-certificate-data: [^ ,]\+' $KUBECONFIG  | awk '{print $2}') | base64 --decode > admin-client.crt

SERVER_CERT_DATA="$(sed ':a;N;$!ba;s/\n/\\\\n/g;s,/,\\\/,g' admin-server.crt)"
echo $SERVER_CERT_DATA
CLIENT_KEY_DATA="$(sed ':a;N;$!ba;s/\n/\\\\n/g;s,/,\\\/,g' admin-client.key)"
echo $CLIENT_KEY_DATA
CLIENT_CERT_DATA="$(sed ':a;N;$!ba;s/\n/\\\\n/g;s,/,\\\/,g' admin-client.crt)"
echo $CLIENT_CERT_DATA

#sed -e "s/SERVER_CERTIFICATE/$SERVER_CERT_DATA/g" update_k8s_endpoint_template.sql
sed -e "s/SERVER_CERTIFICATE/$SERVER_CERT_DATA/g; s/CLIENT_KEY/$CLIENT_KEY_DATA/g; s/CLIENT_CERTIFICATE/$CLIENT_CERT_DATA/g"  update_k8s_endpoint_template.sql > update_k8s_endpoint.sql
#sed -i "s/^*server_certificate=/server_certificate=$SERVER_CERT_DATA/1" $SQL_UPDATE_FILE
