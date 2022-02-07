#!/bin/bash

hlist_dc=$(docker ps -aq)
for start in $list_dc 
do
docker start $start
done
ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass
for stop in $list_dc
do 
docker stop $stop
done
