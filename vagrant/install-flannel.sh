sysctl net.bridge.bridge-nf-call-iptables=1

# for kubernetes v1.7+
# kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
curl -o https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
perl -ne 'print; print "$1- --iface enp0s8\n" if /(\s*)- --kube-subnet-mgr/;' kube-flannel.yml | kubectl apply -f -
