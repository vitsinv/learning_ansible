# Домашнее задание к занятию "08.02 Работа с Playbook"

## Подготовка к выполнению
1. Создайте свой собственный (или используйте старый) публичный репозиторий на github с произвольным именем.
- <a href="https://github.com/vitsinv/learning_ansible">https://github.com/vitsinv/learning_ansible</a>
2. Скачайте [playbook](./playbook/) из репозитория с домашним заданием и перенесите его в свой репозиторий.

```
$ svn export https://github.com/netology-code/mn
t-homeworks/branches/MNT-7/08-ansible-02-playbook/playbook
A    playbook
A    playbook/.gitignore
A    playbook/group_vars
A    playbook/group_vars/all
A    playbook/group_vars/all/vars.yml
A    playbook/group_vars/elasticsearch
A    playbook/group_vars/elasticsearch/vars.yml
A    playbook/inventory
A    playbook/inventory/prod.yml
A    playbook/site.yml
A    playbook/templates
A    playbook/templates/elk.sh.j2
A    playbook/templates/jdk.sh.j2
Exported revision 124.
```
3. Подготовьте хосты в соотвтествии с группами из предподготовленного playbook. 
4. Скачайте дистрибутив [java](https://www.oracle.com/java/technologies/javase-jdk11-downloads.html) и положите его в директорию `playbook/files/`. 

## Основная часть
1. Приготовьте свой собственный inventory файл `prod.yml`.

    ```
    ---
    elasticsearch:
      hosts:
        elastic:
          ansible_connection: docker
    kibana:
      hosts:
        kibana:
          ansible_connection: docker
    ```
2. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает kibana.
    ```
    ---
    - name: Install Java
    hosts: all
      tasks:
        - name: Set facts for Java 11 vars
        set_fact:
            java_home: "/opt/jdk/{{ java_jdk_version }}"
        tags: java
        - name: Upload .tar.gz file containing binaries from local storage
        copy:
            src: "{{ java_oracle_jdk_package }}"
            dest: "/tmp/jdk-{{ java_jdk_version }}.tar.gz"
        register: download_java_binaries
        until: download_java_binaries is succeeded
        tags: java
        - name: Ensure installation dir exists
        file:
            state: directory
            path: "{{ java_home }}"
        tags: java
        - name: Extract java in the installation directory
        unarchive:
            copy: false
            src: "/tmp/jdk-{{ java_jdk_version }}.tar.gz"
            dest: "{{ java_home }}"
            extra_opts: [--strip-components=1]
            creates: "{{ java_home }}/bin/java"
        tags:
            - java
        - name: Export environment variables
        template:
            src: jdk.sh.j2
            dest: /etc/profile.d/jdk.sh
        tags: java
    - name: Install Elasticsearch
    hosts: elasticsearch
    tasks:
        - name: Upload tar.gz Elasticsearch from remote URL
        get_url:
            url: "https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-{{ elastic_version }}-linux-x86_64.tar.gz"
            dest: "/tmp/elasticsearch-{{ elastic_version }}-linux-x86_64.tar.gz"
            mode: 0755
            timeout: 60
            force: true
            validate_certs: false
        register: get_elastic
        until: get_elastic is succeeded
        tags: elastic
        - name: Create directrory for Elasticsearch
        file:
            state: directory
            path: "{{ elastic_home }}"
        tags: elastic
        - name: Extract Elasticsearch in the installation directory
        unarchive:
            copy: false
            src: "/tmp/elasticsearch-{{ elastic_version }}-linux-x86_64.tar.gz"
            dest: "{{ elastic_home }}"
            extra_opts: [--strip-components=1]
            creates: "{{ elastic_home }}/bin/elasticsearch"
        tags:
            - elastic
        - name: Set environment Elastic
        template:
            src: templates/elk.sh.j2
            dest: /etc/profile.d/elk.sh
        tags: elastic
    - name: Install kibana
    hosts: kibana
    tasks:
        - name: Upload tar.gz kibana from remote URL
        get_url:
            url: "https://artifacts.elastic.co/downloads/kibana/kibana-{{ kibana_version }}-linux-x86_64.tar.gz"
            dest: "/tmp/kibana-{{ kibana_version }}-linux-x86_64.tar.gz"
            mode: 0755
            timeout: 60
            force: true
            validate_certs: false
        register: get_kibana
        until: get_kibana is succeeded
        tags: kibana
        - name: Create directrory for kibana
        file:
            state: directory
            path: "{{ kibana_home }}"
        tags: kibana
        - name: Extract Kibana in the installation directory
        unarchive:
            copy: false
            src: "/tmp/kibana-{{ kibana_version }}-linux-x86_64.tar.gz"
            dest: "{{ kibana_home }}"
            extra_opts: [--strip-components=1]
            creates: "{{ kibana_home }}/bin/kibana"
        tags:
            - skip_ansible_lint
            - kibana
        - name: Set environment Kibana
        template:
            src: templates/kibana.sh.j2
            dest: /etc/profile.d/kibana.sh
        tags: kibana
    
    ```
3. При создании tasks рекомендую использовать модули: `get_url`, `template`, `unarchive`, `file`.
4. Tasks должны: скачать нужной версии дистрибутив, выполнить распаковку в выбранную директорию, сгенерировать конфигурацию с параметрами.
5. Запустите `ansible-lint site.yml` и исправьте ошибки, если они есть.
    ```
    $ ansible-lint site.yml -vvv
    Examining site.yml of type playbook
    ```
6. Попробуйте запустить playbook на этом окружении с флагом `--check`.
```
$ ansible-playbook -i inventory/prod.yml site.yml --check
[WARNING]: Found both group and host with same name: kibana

PLAY [Install Java] ****************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [elastic]
ok: [kibana]

TASK [Set facts for Java 11 vars] **************************************************************************************
ok: [elastic]
ok: [kibana]

TASK [Upload .tar.gz file containing binaries from local storage] ******************************************************
changed: [elastic]
changed: [kibana]

TASK [Ensure installation dir exists] **********************************************************************************
changed: [elastic]
changed: [kibana]

TASK [Extract java in the installation directory] **********************************************************************
An exception occurred during task execution. To see the full traceback, use -vvv. The error was: NoneType: None
fatal: [elastic]: FAILED! => {"changed": false, "msg": "dest '/opt/jdk/11.0.14' must be an existing dir"}
An exception occurred during task execution. To see the full traceback, use -vvv. The error was: NoneType: None
fatal: [kibana]: FAILED! => {"changed": false, "msg": "dest '/opt/jdk/11.0.14' must be an existing dir"}

PLAY RECAP *************************************************************************************************************
elastic                    : ok=4    changed=2    unreachable=0    failed=1    skipped=0    rescued=0    ignored=0
kibana                     : ok=4    changed=2    unreachable=0    failed=1    skipped=0    rescued=0    ignored=0
```
7. Запустите playbook на `prod.yml` окружении с флагом `--diff`. Убедитесь, что изменения на системе произведены.

```
$ ansible-playbook -i inventory/prod.yml site.yml --diff
[WARNING]: Found both group and host with same name: kibana

PLAY [Install Java] ****************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [elastic]
ok: [kibana]

TASK [Set facts for Java 11 vars] **************************************************************************************
ok: [elastic]
ok: [kibana]

TASK [Upload .tar.gz file containing binaries from local storage] ******************************************************
diff skipped: source file size is greater than 104448
changed: [kibana]
diff skipped: source file size is greater than 104448
changed: [elastic]

TASK [Ensure installation dir exists] **********************************************************************************
--- before
+++ after
@@ -1,4 +1,4 @@
 {
     "path": "/opt/jdk/11.0.14",
-    "state": "absent"
+    "state": "directory"
 }

changed: [kibana]
--- before
+++ after
@@ -1,4 +1,4 @@
 {
     "path": "/opt/jdk/11.0.14",
-    "state": "absent"
+    "state": "directory"
 }

changed: [elastic]

TASK [Extract java in the installation directory] **********************************************************************
changed: [kibana]
changed: [elastic]

TASK [Export environment variables] ************************************************************************************
--- before
+++ after: /home/vitsin/.ansible/tmp/ansible-local-22184sc_ea8bn/tmpk9d9ecdz/jdk.sh.j2
@@ -0,0 +1,5 @@
+# Warning: This file is Ansible Managed, manual changes will be overwritten on next playbook run.
+#!/usr/bin/env bash
+
+export JAVA_HOME=/opt/jdk/11.0.14
+export PATH=$PATH:$JAVA_HOME/bin
\ No newline at end of file

changed: [kibana]
--- before
+++ after: /home/vitsin/.ansible/tmp/ansible-local-22184sc_ea8bn/tmphbgax633/jdk.sh.j2
@@ -0,0 +1,5 @@
+# Warning: This file is Ansible Managed, manual changes will be overwritten on next playbook run.
+#!/usr/bin/env bash
+
+export JAVA_HOME=/opt/jdk/11.0.14
+export PATH=$PATH:$JAVA_HOME/bin
\ No newline at end of file

changed: [elastic]

PLAY [Install Elasticsearch] *******************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [elastic]

TASK [Upload tar.gz Elasticsearch from remote URL] *********************************************************************
changed: [elastic]

TASK [Create directrory for Elasticsearch] *****************************************************************************
--- before
+++ after
@@ -1,4 +1,4 @@
 {
     "path": "/opt/elastic/8.0.0",
-    "state": "absent"
+    "state": "directory"
 }

changed: [elastic]

TASK [Extract Elasticsearch in the installation directory] *************************************************************
changed: [elastic]

TASK [Set environment Elastic] *****************************************************************************************
--- before
+++ after: /home/vitsin/.ansible/tmp/ansible-local-22184sc_ea8bn/tmp7iz79cx3/elk.sh.j2
@@ -0,0 +1,5 @@
+# Warning: This file is Ansible Managed, manual changes will be overwritten on next playbook run.
+#!/usr/bin/env bash
+
+export ES_HOME=/opt/elastic/8.0.0
+export PATH=$PATH:$ES_HOME/bin
\ No newline at end of file

changed: [elastic]

PLAY [Install kibana] **************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [kibana]

TASK [Upload tar.gz kibana from remote URL] ****************************************************************************
changed: [kibana]

TASK [Create directrory for kibana] ************************************************************************************
--- before
+++ after
@@ -1,4 +1,4 @@
 {
     "path": "/opt/kibana/8.0.0",
-    "state": "absent"
+    "state": "directory"
 }

changed: [kibana]

TASK [Extract Kibana in the installation directory] ********************************************************************
changed: [kibana]

TASK [Set environment Kibana] ******************************************************************************************
--- before
+++ after: /home/vitsin/.ansible/tmp/ansible-local-22184sc_ea8bn/tmpdkaf2pa2/kibana.sh.j2
@@ -0,0 +1,5 @@
+# Warning: This file is Ansible Managed, manual changes will be overwritten on next playbook run.
+#!/usr/bin/env bash
+
+export KIBANA_HOME=/opt/kibana/8.0.0
+export PATH=$PATH:$KIBANA_HOME/bin

changed: [kibana]

PLAY RECAP *************************************************************************************************************
elastic                    : ok=11   changed=8    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
kibana                     : ok=11   changed=8    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
8. Повторно запустите playbook с флагом `--diff` и убедитесь, что playbook идемпотентен.

```
$ ansible-playbook -i inventory/prod.yml site.yml --diff
[WARNING]: Found both group and host with same name: kibana

PLAY [Install Java] ****************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [kibana]
ok: [elastic]

TASK [Set facts for Java 11 vars] **************************************************************************************
ok: [elastic]
ok: [kibana]

TASK [Upload .tar.gz file containing binaries from local storage] ******************************************************
ok: [elastic]
ok: [kibana]

TASK [Ensure installation dir exists] **********************************************************************************
ok: [kibana]
ok: [elastic]

TASK [Extract java in the installation directory] **********************************************************************
skipping: [elastic]
skipping: [kibana]

TASK [Export environment variables] ************************************************************************************
ok: [elastic]
ok: [kibana]

PLAY [Install Elasticsearch] *******************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [elastic]

TASK [Upload tar.gz Elasticsearch from remote URL] *********************************************************************
ok: [elastic]

TASK [Create directrory for Elasticsearch] *****************************************************************************
ok: [elastic]

TASK [Extract Elasticsearch in the installation directory] *************************************************************
skipping: [elastic]

TASK [Set environment Elastic] *****************************************************************************************
ok: [elastic]

PLAY [Install kibana] **************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [kibana]

TASK [Upload tar.gz kibana from remote URL] ****************************************************************************
ok: [kibana]

TASK [Create directrory for kibana] ************************************************************************************
ok: [kibana]

TASK [Extract Kibana in the installation directory] ********************************************************************
skipping: [kibana]

TASK [Set environment Kibana] ******************************************************************************************
ok: [kibana]

PLAY RECAP *************************************************************************************************************
elastic                    : ok=9    changed=0    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0
kibana                     : ok=9    changed=0    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0
```
9. Подготовьте README.md файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги.
<a href="https://github.com/vitsinv/learning_ansible/tree/master/8.2_playbook/playbook#readme">README.MD</a>
10. Готовый playbook выложите в свой репозиторий, в ответ предоставьте ссылку на него.
<a href="https://github.com/vitsinv/learning_ansible/blob/master/8.2_playbook/playbook/site.yml">Плейбук</a>

---
