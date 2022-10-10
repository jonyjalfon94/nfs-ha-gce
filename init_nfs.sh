apt-get update -y
apt-get install drbd-utils -y
cat > /etc/drbd.d/nfs01.res <<EOF
resource nfs-vol01 {
 protocol C;
 meta-disk internal;
 device /dev/drbd0;
 disk   /dev/sdb;
 handlers {
  split-brain "/usr/lib/drbd/notify-split-brain.sh root";
 }
 net {
  allow-two-primaries no;
  after-sb-0pri discard-zero-changes;
  after-sb-1pri discard-secondary;
  after-sb-2pri disconnect;
  rr-conflict disconnect;
 }
 disk {
  on-io-error detach;
 }
 syncer {
  verify-alg sha1;
 }
 on demo-nfs-server-1 {
  address  10.0.0.4:7790;
 }
 on demo-nfs-server-2 {
  address  10.0.0.5:7790;
 }
}
EOF
drbdadm create-md nfs-vol01
drbdadm up nfs-vol01

# apt-get install nfs-kernel-server pacemaker crmsh -y
# mkdir /nfsshare
# chown nobody:nogroup /nfsshare
# chmod 755 /nfsshare
# echo "/nfsshare    10.0.0.0/17(rw,sync,no_subtree_check)" >> /etc/exports
# systemctl restart nfs-server