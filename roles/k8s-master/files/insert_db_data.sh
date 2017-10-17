./extract_kube_cert.sh

CONFIG_DB="$(kubectl get pod -n autoshift | grep config-db | awk '{print $1}')"
files=(autoshift-schema.sql \
    autoshift-data.sql \
    update_k8s_endpoint.sql)
for file in ${files[@]} ; do
    kUBECONFIG=/etc/kubernetes/admin.conf kubectl cp $file autoshift/$CONFIG_DB:/
    KUBECONFIG=/etc/kubernetes/admin.conf kubectl exec $CONFIG_DB -n autoshift -- bash -c "mysql -uroot -proot < /$file"
done
