# Kickstart file to build the appliance operating
# system for fedora.
# This is based on the work at http://www.thincrust.net
text
lang C
keyboard us
timezone US/Eastern
auth --useshadow --enablemd5
selinux --disabled
firewall --disabled
network --bootproto=dhcp --device=eth0 --onboot=on
network --hostname=prova123
services --enabled=network
url --url http://10.1.1.1/fedora12

# Uncomment the next line
# to make the root password be thincrust
# By default the root password is emptied
rootpw delco123

#
# Partition Information. Change this as necessary
# This information is used by appliance-tools but
# not by the livecd tools.
#
clearpart --all --initlabel
part swap --size 2048
part / --size 4000 --fstype ext3
part /backup --size 500 --grow  --fstype ext3
zerombr

#
# Repositories
#
#repo --name=rawhide --mirrorlist=http://mirrors.fedoraproject.org/mirrorlist?repo=rawhide&arch=i386
#repo --name=fedora --mirrorlist=http://mirrors.fedoraproject.org/mirrorlist?repo=fedora-14&arch=i386
#repo --name=updates --mirrorlist=http://mirrors.fedoraproject.org/mirrorlist?repo=updates-released-f14&arch=i386
#repo --name=updates-testing --mirrorlist=http://mirrors.fedoraproject.org/mirrorlist?repo=updates-testing-f14&arch=i386

#
# Add all the packages after the base packages
#
%packages --excludedocs --nobase
bash
kernel
grub
e2fsprogs
passwd
policycoreutils
chkconfig
rootfiles
yum
vim-minimal
emacs
acpid
#needed to disable selinux
lokkit

#Allow for dhcp access
dhclient
iputils

#
# Packages to Remove
#

# no need for kudzu if the hardware doesn't change
-kudzu
-prelink
-setserial
-ed

# Remove the authconfig pieces
-authconfig
-rhpl
-wireless-tools

# Remove the kbd bits
-kbd
-usermode

# these are all kind of overkill but get pulled in by mkinitrd ordering
-mkinitrd
-kpartx
-dmraid
-mdadm
-lvm2
-tar

# selinux toolchain of policycoreutils, libsemanage, ustr
-policycoreutils
-checkpolicy
-selinux-policy*
-libselinux-python
-libselinux

# Things it would be nice to loose
-fedora-logos
-generic-logos
-fedora-release-notes
%end

#
# Add custom post scripts after the base post.
#
%post

%end

bootloader --timeout=1 --append="acpi=force selinux=0" --location=mbr
reboot