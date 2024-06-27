mkdir -p /home/vagrant/.ssh && chmod 700 /home/vagrant/.ssh
echo $SSH_PUBLIC_KEY >> /home/vagrant/.ssh/authorized_keys
chown -R vagrant:vagrant /home/vagrant/.ssh
chmod 400 /home/vagrant/.ssh/authorized_keys
