mk3 - вариант, когда vagrant не устанавливается на хост, а работает из docker-образа vagrant-libvirt c dockerhub

для провижынга libvirt на хосте, 
сработает
ЕСЛИ
1.  docker network для этого всего на хосте можно воткнуть в eth0 (т.е. если это имя не занято). 
И внутри контейнера тоже сетевой интерфейс появляется как eth0.
(иначе не срабатывает сеть. - либо vm ее не видит, либо vagrant в docker не может подтвердить запуск ssh и ждет-ждет-ждет)

(вероятно, можно отбрить второе путем отключения перевтыка своего ключа vagrant`ом в vm)

2. и на хосте и в контейнере есть одинаковый путь /deb10 с ключом для ssh
(иначе либо vagrant up не стартует, не видя путь для sync_folder, либо libvirt не может подключить отсутствующий у нехо путь на хостовой машине
(а это можно отбрить отказом от sync_folder в пользу явного указания ключа в этом конфиге, типа provision shell echo "ssh_rsa тыры-пыры" >> /root/.ssh/id_rsa
