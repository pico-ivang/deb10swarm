mk1. вариант работы с роем в ручном режиме.

хост - linux+libvirt

на хосте сделан сетевой мост kvmbr-debswarm
на него запущен dnsmasq с конфигом ./dnsmasq.conf

ip_forward=1
на основной сетевой карте iptables -j MASQUERADE

вручную сделана эталонная vm deb10template с необходимым набором (ssh-ключи, пакеты и т.д.)
если что-то надо подправить - нужно удалить рой, в этой vm внести изменения и сделать новый рой.

при помощи
./spawn_deb10_custom_node.sh
сделана vm ansible, чтоб оттуда рулить роем.

./spawn_deb10_many_nodes.sh
использует ./spawn_deb10_1node.sh и ./set_node_hostname.sh
чтобы спавнить новые ноды

./deb10swarm-start.sh
запуск сначала сетевой части (dnsmasq и masquerade), а потом поочередный запуск нод роя, начиная с управляющей ноды ansible

./shutdown_all_deb10nodes.sh
для выключения роя.

./destroy_all_deb10nodes.sh
для удаления роя
