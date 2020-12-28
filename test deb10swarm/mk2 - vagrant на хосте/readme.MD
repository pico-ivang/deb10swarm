mk2. спавн роя средствами vagrant+vagrant-libvirt

на kvmbr-debswarm запущен dnsmasq

./vagrant up
спавнит нужное количество нод из бокса debian10 в libvirt, подключает в мост kvmbr-debswarm
и вкидывает ssh-ключ.

дальше нодами рулим ansible`м
