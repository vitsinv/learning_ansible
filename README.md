<H1><a>Домашнее задание к занятию "08.01 Введение в Ansible"</a></H1>
<H2><a>Подготовка к выполнению</a></H2>

<li>Установите ansible версии 2.10 или выше.</li>

```
$ ansible --version
ansible [core 2.12.2]
  config file = /etc/ansible/ansible.cfg
  configured module search path = ['/home/vitsin/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/local/lib/python3.8/dist-packages/ansible
  ansible collection location = /home/vitsin/.ansible/collections:/usr/share/ansible/collections
  executable location = /usr/local/bin/ansible
  python version = 3.8.10 (default, Nov 26 2021, 20:14:08) [GCC 9.3.0]
  jinja version = 3.0.1
  libyaml = True
```

<li>Создайте свой собственный публичный репозиторий на github с произвольным именем.</li>
<a href="https://github.com/vitsinv/learning_ansible">https://github.com/vitsinv/learning_ansible</a>

<li>Скачайте <a href="/netology-code/mnt-homeworks/blob/MNT-7/08-ansible-01-base/playbook">playbook</a> из репозитория с домашним заданием и перенесите его в свой репозиторий.</li>

```
vitsin@FinDir:/mnt/c/Users/vitsin/learning_ansible$ svn export 'https://github.com/netology-code/mnt-homeworks/branches/MNT-7/08-ansible-01-base/playbook'
A    playbook
A    playbook/README.md
A    playbook/group_vars
A    playbook/group_vars/all
A    playbook/group_vars/all/examp.yml
A    playbook/group_vars/deb
A    playbook/group_vars/deb/examp.yml
A    playbook/group_vars/el
A    playbook/group_vars/el/examp.yml
A    playbook/inventory
A    playbook/inventory/prod.yml
A    playbook/inventory/test.yml
A    playbook/site.yml
Exported revision 124.
14:20:35 vitsin@FinDir:/mnt/c/Users/vitsin/learning_ansible$ ls
playbook
```
</ol>
</a>Основная часть</h2>
<ol dir="auto">
<li>Попробуйте запустить playbook на окружении из <code>test.yml</code>, зафиксируйте какое значение имеет факт <code>some_fact</code> для указанного хоста при выполнении playbook'a.</li>

```
$ ansible-playbook -i inventory/test.yml site.yml

PLAY [Print os facts] **************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [localhost]

TASK [Print OS] ********************************************************************************************************
ok: [localhost] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ******************************************************************************************************
ok: [localhost] => {
    "msg": 12
}

PLAY RECAP *************************************************************************************************************
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
<li>Найдите файл с переменными (group_vars) в котором задаётся найденное в первом пункте значение и поменяйте его на 'all default fact'.</li>

```
$ cat group_vars/all/examp.yml
---
  some_fact: "all default fact"
```

```
$ ansible-playbook -i inventory/test.yml site.yml

PLAY [Print os facts] **************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [localhost]

TASK [Print OS] ********************************************************************************************************
ok: [localhost] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ******************************************************************************************************
ok: [localhost] => {
    "msg": "all default fact"
}

PLAY RECAP *************************************************************************************************************
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
<li>Воспользуйтесь подготовленным (используется <code>docker</code>) или создайте собственное окружение для проведения дальнейших испытаний.</li>

```
$ docker ps
CONTAINER ID   IMAGE           COMMAND       CREATED         STATUS          PORTS     NAMES
0924c8a74dfe   ubuntu:latest   "bash"        2 minutes ago   Up 39 seconds             ubuntu
01e5f1ae3940   centos:7        "/bin/bash"   6 minutes ago   Up 4 minutes              centos7
```
<li>Проведите запуск playbook на окружении из <code>prod.yml</code>. Зафиксируйте полученные значения <code>some_fact</code> для каждого из <code>managed host</code>.</li>

```
$ ansible-playbook -i inventory/prod.yml site.yml

PLAY [Print os facts] **************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] ********************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ******************************************************************************************************
ok: [centos7] => {
    "msg": "el"
}
ok: [ubuntu] => {
    "msg": "deb"
}

PLAY RECAP *************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
<li>Добавьте факты в <code>group_vars</code> каждой из групп хостов так, чтобы для <code>some_fact</code> получились следующие значения: для <code>deb</code> - 'deb default fact', для <code>el</code> - 'el default fact'.</li>

```
vitsin@FinDir:/mnt/c/Users/vitsin/learning_ansible/playbook$ cat group_vars/deb/examp.yml ;echo ""
---
  some_fact: "deb default fact"

17:20:48 vitsin@FinDir:/mnt/c/Users/vitsin/learning_ansible/playbook$ cat group_vars/el/examp.yml ;echo ""
---
  some_fact: "el default fact"
```

<li>Повторите запуск playbook на окружении <code>prod.yml</code>. Убедитесь, что выдаются корректные значения для всех хостов.</li>

```
TASK [Print fact] ******************************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}
```
<li>При помощи <code>ansible-vault</code> зашифруйте факты в <code>group_vars/deb</code> и <code>group_vars/el</code> с паролем <code>netology</code>.</li>

```
$ ansible-vault encrypt group_vars/deb/examp.yml
New Vault password:
Confirm New Vault password:
Encryption successful
$ ansible-vault encrypt group_vars/el/examp.yml
New Vault password:
Confirm New Vault password:
Encryption successful
```

<li>Запустите playbook на окружении <code>prod.yml</code>. При запуске <code>ansible</code> должен запросить у вас пароль. Убедитесь в работоспособности.</li>

```
$ ansible-playbook -i inventory/prod.yml site.yml --
ask-vault-pass
Vault password:

PLAY [Print os facts] **************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [centos7]
ok: [ubuntu]

TASK [Print OS] ********************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ******************************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}

PLAY RECAP *************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
<li>Посмотрите при помощи <code>ansible-doc</code> список плагинов для подключения. Выберите подходящий для работы на <code>control node</code>.</li>

- local
<li>В <code>prod.yml</code> добавьте новую группу хостов с именем  <code>local</code>, в ней разместите localhost с необходимым типом подключения.</li>

```
$ cat inventory/prod.yml
---
  el:
    hosts:
      centos7:
        ansible_connection: docker
  deb:
    hosts:
      ubuntu:
        ansible_connection: docker
  local:
    hosts:
      localhost:
        ansible_connection: local
```
<li>Запустите playbook на окружении <code>prod.yml</code>. При запуске <code>ansible</code> должен запросить у вас пароль. Убедитесь что факты <code>some_fact</code> для каждого из хостов определены из верных <code>group_vars</code>.</li>
- Поскольку localhost не подходит ни к centos7 ни к ubuntu, то <code>some_fact</code> он возьмет из <code>all</code>:

```
$ cat group_vars/all/examp.yml
---
  some_fact: "all default fact"
```

```
$ ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass
Vault password:

PLAY [Print os facts] **************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [localhost]
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] ********************************************************************************************************
ok: [localhost] => {
    "msg": "Ubuntu"
}
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ******************************************************************************************************
ok: [localhost] => {
    "msg": "all default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}
ok: [centos7] => {
    "msg": "el default fact"
}

PLAY RECAP *************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

<li>Заполните <code>README.md</code> ответами на вопросы. Сделайте <code>git push</code> в ветку <code>master</code>. В ответе отправьте ссылку на ваш открытый репозиторий с изменённым <code>playbook</code> и заполненным <code>README.md</code>.</li>
<a href="https://github.com/vitsinv/learning_ansible/blob/master/%D0%9E%D0%B1%D1%8F%D0%B7%D0%B0%D1%82%D0%B5%D0%BB%D1%8C%D0%BD%D0%BE%D0%B5/playbook/README.md">README.MD<a>
</ol>
<h2 dir="auto"><a id="user-content-необязательная-часть" class="anchor" aria-hidden="true" href="#необязательная-часть"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M7.775 3.275a.75.75 0 001.06 1.06l1.25-1.25a2 2 0 112.83 2.83l-2.5 2.5a2 2 0 01-2.83 0 .75.75 0 00-1.06 1.06 3.5 3.5 0 004.95 0l2.5-2.5a3.5 3.5 0 00-4.95-4.95l-1.25 1.25zm-4.69 9.64a2 2 0 010-2.83l2.5-2.5a2 2 0 012.83 0 .75.75 0 001.06-1.06 3.5 3.5 0 00-4.95 0l-2.5 2.5a3.5 3.5 0 004.95 4.95l1.25-1.25a.75.75 0 00-1.06-1.06l-1.25 1.25a2 2 0 01-2.83 0z"></path></svg></a>Необязательная часть</h2>
<ol dir="auto">
<li>При помощи <code>ansible-vault</code> расшифруйте все зашифрованные файлы с переменными.</li>
<li>Зашифруйте отдельное значение <code>PaSSw0rd</code> для переменной <code>some_fact</code> паролем <code>netology</code>. Добавьте полученное значение в <code>group_vars/all/exmp.yml</code>.</li>
<li>Запустите <code>playbook</code>, убедитесь, что для нужных хостов применился новый <code>fact</code>.</li>
<li>Добавьте новую группу хостов <code>fedora</code>, самостоятельно придумайте для неё переменную. В качестве образа можно использовать <a href="https://hub.docker.com/r/pycontribs/fedora" rel="nofollow">этот</a>.</li>
<li>Напишите скрипт на bash: автоматизируйте поднятие необходимых контейнеров, запуск ansible-playbook и остановку контейнеров.</li>
<li>Все изменения должны быть зафиксированы и отправлены в вашей личный репозиторий.</li>
</ol>
<hr>
<h3 dir="auto"><a id="user-content-как-оформить-дз" class="anchor" aria-hidden="true" href="#как-оформить-дз"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M7.775 3.275a.75.75 0 001.06 1.06l1.25-1.25a2 2 0 112.83 2.83l-2.5 2.5a2 2 0 01-2.83 0 .75.75 0 00-1.06 1.06 3.5 3.5 0 004.95 0l2.5-2.5a3.5 3.5 0 00-4.95-4.95l-1.25 1.25zm-4.69 9.64a2 2 0 010-2.83l2.5-2.5a2 2 0 012.83 0 .75.75 0 001.06-1.06 3.5 3.5 0 00-4.95 0l-2.5 2.5a3.5 3.5 0 004.95 4.95l1.25-1.25a.75.75 0 00-1.06-1.06l-1.25 1.25a2 2 0 01-2.83 0z"></path></svg></a>Как оформить ДЗ?</h3>
<p dir="auto">Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.</p>
