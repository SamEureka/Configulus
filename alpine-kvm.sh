#!/bin/bash

echo "This script is going to install KVM. What user do you want to have access?"
read -p 'username: ' KVM_USER
echo " You can add aditional users later with: adduser <username> libvirt"
echo " ...is $KVM_USER the one you want to add?"
read -p '(y)es / (n)o: ' ANSWER

case $ANSWER in
  y | yes | Y | YES | 1 | Yes)
    echo "Cool! Let's do this!";;
  n | no | N | NO | 0 | No)
    echo "Exiting, try running the script again."
    exit 1;;    
  *)
    echo "Answer not understood, try 'y' or 'n'. exiting."
    exit 1;;
esac

sudo -s -- <<EOL
apk add libvirt-daemon qemu-img qemu-system-x86_64 qemu-system-arm qemu-system-aarch64 qemu-modules qemu-openrc dbus polkit
rc-update add libvirtd
rc-update add dbus
rc-update add libvirt-guests
rc-service libvirt-guests start
echo "qemu/libvirt installed and openrc services added"
addgroup $KVM_USER libvirt
addgroup $KVM_USER kvm
addgroup $KVM_USER qemu
echo "User ${KVM_USER} added to the correct groups"
modprobe tun
echo "tun" >> /etc/modules-load.d/tun.conf
cat /etc/modules | grep tun || echo tun >> /etc/modules
echo "tun module loaded and added to /etc/modules"
mkdir -p /etc/polkit-1/localauthority/50-local.d/
cat << EPOL >> /etc/polkit-1/localauthority/50-local.d/50-libvirt-ssh-remote-access-policy.pkla
[Remote libvirt SSH access]
 Identity=unix-group:libvirt
 Action=org.libvirt.unix.manage
 ResultAny=yes
 ResultInactive=yes
 ResultActive=yes
EPOL
echo "Polkit ssh access configured"
cat << ENET >> /etc/network/interfaces
        bridge-stp 0
        post-up ip -6 a flush dev br0; sysctl -w net.ipv6.conf.br0.disable_ipv6=1
ENET
echo "added ipv6 stuff"
echo "------------- END OF LINE --------------"
EOL

