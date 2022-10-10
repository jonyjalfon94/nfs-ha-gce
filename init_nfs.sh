apt-get update -y
apt-get install nfs-kernel-server -y
mkdir /nfsshare
chown nobody:nogroup /nfsshare
chmod 755 /nfsshare
echo "/nfsshare    10.0.0.0/17(rw,sync,no_subtree_check)" >> /etc/exports
systemctl restart nfs-server