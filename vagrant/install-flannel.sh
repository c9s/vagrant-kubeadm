# for kubernetes v1.7+
# kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
# kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/v0.9.1/Documentation/kube-flannel.yml
curl -s https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml > kube-flannel.yml
perl -ne 'print; print "$1- --iface=enp0s8\n" if /(\s*)- --kube-subnet-mgr/;' kube-flannel.yml | kubectl apply -f -
