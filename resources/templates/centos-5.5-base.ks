## i386 kickstart config installation

#key d6dbc277d6578dc2

# Install OS instead of upgrade
text
install
# Use CDROM installation media
# cdrom

# Network information
#network --device eth0 --bootproto dhcp
network --bootproto {{bootproto|text}} --hostname {{hostname|text}}

# Repository Location
url --url=http://192.168.56.1/pxe/dist/centos-5.5

#Root password
#rootpw --iscrypted $1$rB3lJzDT$PmMFJJiLgVPbnvJF6UZ1x/
rootpw {{rootpw|passwd}}

# Firewall configuration
firewall --disabled

# SELinux configuration
selinux --disabled

# System authorization information
authconfig --enableshadow --enablemd5

### Language Specification
lang en_US
langsupport en_US

# System keyboard
keyboard us

# System timezone
timezone --utc Europe/Rome

# System bootloader configuration
bootloader --location=mbr --driveorder=sda

# Clear the Master Boot Record
zerombr

# Partition clearing information
clearpart --all --initlabel

# Disk partitioning information
part swap --asprimary --fstype="swap" --size=3000 --bytes-per-inode=4096
part / --asprimary --fstype="ext3" --grow --size=1 --bytes-per-inode=4096
#part /boot --fstype ext3 --size=200
#part pv.1 --size=20000 --grow 
#volgroup VolGroup00 --pesize=32768 pv.1
#logvol swap --fstype swap --name=LogVol01 --vgname=VolGroup00 --size=384 --grow --maxsize=768
#logvol / --fstype ext3 --name=LogVol00 --vgname=VolGroup00 --size=1024 --grow

# Run the Setup Agent on first boot
firstboot --disable

# Installation logging level
logging info

reboot

%packages --nobase --excludedocs
## groups
#@base
#@core
-anacron
-autofs
-yum-updatesd
-wireless-tools
-irda-utils
-nfs-utils
-NetworkManager

## editors
emacs-nox

## Webserver
#httpd

## Mail
fetchmail

## Compilers
#gcc
#gcc-c++

## Web
#curl
#wget
openssl

## Compression
#bzip2
#unzip
#zip

## Other
#ntp

%post
#chvt 3
#chvt 1