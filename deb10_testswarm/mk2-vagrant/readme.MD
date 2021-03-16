mk2. спавн роя средствами vagrant+vagrant-libvirt

====установка vagrant+vagrant-libvirt====

apt-get build-dep vagrant ruby-libvirt

apt-get install qemu libvirt-daemon-system libvirt-clients ebtables dnsmasq-base

apt-get install libxslt-dev libxml2-dev libvirt-dev zlib1g-dev ruby-dev

gem install nokogiri -v 1.10.10

vagrant plugin install vagrant-libvirt

====/установка vagrant+vagrant-libvirt====


на kvmbr-debswarm запущен dnsmasq

./vagrant up
спавнит нужное количество нод из бокса debian10 в libvirt, подключает в мост kvmbr-debswarm
и вкидывает ssh-ключ.

дальше нодами рулим ansible`м
