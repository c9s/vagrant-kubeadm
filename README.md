# Kubeadm-ready Vagrant

## Setting up

```
vagrant plugin install vagrant-hostmanger
```

### Vagrant Up

```
vagrant up
```

### Vagrant Up Nodes separately

```
vagrant up master
vagrant up node-1
vagrant up node-1
```

### Connecting to the nodes

```
vagrant ssh master
vagrant ssh node-1
```


## Trouble Shooting


1. For people encounterred the follow issue:

```
The machine with the name 'default' was not found configured for this Vagrant
environment.
```

Run the following command to prune the status:

```
vagrant global-status --prune
```
