

```
vagrant plugin install vagrant-hostmanger
vagrant up master
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
