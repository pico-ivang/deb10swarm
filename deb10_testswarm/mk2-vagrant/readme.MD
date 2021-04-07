Предполагается, что у вас уже есть libvirt.
Если еще нет - идите ставьте.

Вообще, правильно - скачать Vagrant актуальной версии с сайта разрабов.
И установить его естественным для вашей хостовой оси способом.
Он там, по идее, сам все, что нужно, прочпокает.


Если хотите других ощущений - попробуйте вот чего:
Этот вариант сработал как-то однажды. Но все следующие разы разбивался об зависимости nokogiri.
И сам vagrant становится из репы старый. 
Короч, вариант "скачать с сайта" - самый правильный.


mk2. спавн роя средствами vagrant+vagrant-libvirt

====установка vagrant+vagrant-libvirt====

apt-get build-dep vagrant ruby-libvirt

apt-get install qemu libvirt-daemon-system libvirt-clients ebtables dnsmasq-base

apt-get install libxslt-dev libxml2-dev libvirt-dev zlib1g-dev ruby-dev

gem install nokogiri --platform=ruby

vagrant plugin install vagrant-libvirt

====/установка vagrant+vagrant-libvirt====
