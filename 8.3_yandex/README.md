<h2></a>Основная часть</h2>
<ol dir="auto">
<li>Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает kibana.</li>
<li>При создании tasks рекомендую использовать модули: <code>get_url</code>, <code>template</code>, <code>yum</code>, <code>apt</code>.</li>
<li>Tasks должны: скачать нужной версии дистрибутив, выполнить распаковку в выбранную директорию, сгенерировать конфигурацию с параметрами.</li>

```
- name: Install Kibana
  hosts: kibana
  handlers:
    - name: restart Kibana
      become: true
      service:
        name: kibana
        state: restarted
  tasks:
    - name : install kibana rpm key
      rpm_key: key=https://artifacts.elastic.co/GPG-KEY-elasticsearch state=present
 
    - name: install kibana 7.x rpm repository
      yum_repository: name=elasticsearch-7.x state=present description="Elasticsearch repository for 7.x packages" baseurl=https://artifacts.elastic.co/packages/7.x/yum gpgcheck=true gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
      register: yum_repository_output
    - name: "Download Kibana's rpm"
      get_url:
        url: "https://artifacts.elastic.co/downloads/kibana/kibana-{{ elk_stack_version }}-x86_64.rpm"
        dest: "/tmp/kibana-{{ elk_stack_version }}-x86_64.rpm"
      register: download_kibana
      until: download_kibana is succeeded
    - name: Install Kibana
      become: true
      yum:
        name: "/tmp/kibana-{{ elk_stack_version }}-x86_64.rpm"
        state: present
    - name: Configure Kibana
      become: true
      template:
        src: kibana.yml.j2
        dest: /etc/kibana/kibana.yml
      notify: restart Kibana
```
<li>Приготовьте свой собственный inventory файл <code>prod.yml</code>.</li>

```
---
all:
  hosts:
    el-instance:
      ansible_host: "{{ elastic_ip }}"
    ki-instance:
      ansible_host: "{{ kibana_ip }}"
    
  vars:
    ansible_connection: ssh
    ansible_user: root
    ansible_password: *********
elasticsearch:
  hosts:
    el-instance:
kibana:
  hosts:
    ki-instance:
```
<li>Запустите <code>ansible-lint site.yml</code> и исправьте ошибки, если они есть.</li>
<li>Попробуйте запустить playbook на этом окружении с флагом <code>--check</code>.</li>

```
$ ansible-playbook -i inventory/prod/hosts.yml site.yml --check

PLAY [Install Java] ****************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [el-instance]
ok: [ki-instance]

TASK [Set facts for Java 11 vars] **************************************************************************************
ok: [el-instance]
ok: [ki-instance]

TASK [Upload .tar.gz file containing binaries from local storage] ******************************************************
ok: [ki-instance]
ok: [el-instance]

TASK [Ensure installation dir exists] **********************************************************************************
ok: [ki-instance]
ok: [el-instance]

TASK [Extract java in the installation directory] **********************************************************************
skipping: [ki-instance]
skipping: [el-instance]

TASK [Export environment variables] ************************************************************************************
ok: [ki-instance]
ok: [el-instance]

PLAY [Install Elasticsearch] *******************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [el-instance]

TASK [install elasticsearch rpm key] ***********************************************************************************
ok: [el-instance]

TASK [install elasticsearch 7.x rpm repository] ************************************************************************
ok: [el-instance]

TASK [Download Elasticsearch's rpm] ************************************************************************************
ok: [el-instance]

TASK [Install Elasticsearch] *******************************************************************************************
ok: [el-instance]

TASK [Configure Elasticsearch] *****************************************************************************************
ok: [el-instance]

PLAY [Install Kibana] **************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [ki-instance]

TASK [install kibana rpm key] ******************************************************************************************
ok: [ki-instance]

TASK [install kibana 7.x rpm repository] *******************************************************************************
changed: [ki-instance]

TASK [Download Kibana's rpm] *******************************************************************************************
ok: [ki-instance]

TASK [Install Kibana] **************************************************************************************************
ok: [ki-instance]

TASK [Configure Kibana] ************************************************************************************************
ok: [ki-instance]

PLAY RECAP *************************************************************************************************************
el-instance                : ok=11   changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
ki-instance                : ok=11   changed=1    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
```
<li>Запустите playbook на <code>prod.yml</code> окружении с флагом <code>--diff</code>. Убедитесь, что изменения на системе произведены.</li>

```
$ ansible-playbook -i inventory/prod/prod.yml site.yml --diff

PLAY [Install Java] ****************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [el-instance]
ok: [ki-instance]

TASK [Set facts for Java 11 vars] **************************************************************************************
ok: [el-instance]
ok: [ki-instance]

TASK [Upload .tar.gz file containing binaries from local storage] ******************************************************
ok: [ki-instance]
ok: [el-instance]

TASK [Ensure installation dir exists] **********************************************************************************
ok: [ki-instance]
ok: [el-instance]

TASK [Extract java in the installation directory] **********************************************************************
skipping: [ki-instance]
skipping: [el-instance]

TASK [Export environment variables] ************************************************************************************
ok: [ki-instance]
ok: [el-instance]

PLAY [Install Elasticsearch] *******************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [el-instance]

TASK [install elasticsearch rpm key] ***********************************************************************************
ok: [el-instance]

TASK [install elasticsearch 7.x rpm repository] ************************************************************************
ok: [el-instance]

TASK [Download Elasticsearch's rpm] ************************************************************************************
ok: [el-instance]

TASK [Install Elasticsearch] *******************************************************************************************
ok: [el-instance]

TASK [Configure Elasticsearch] *****************************************************************************************
ok: [el-instance]

PLAY [Install Kibana] **************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [ki-instance]

TASK [install kibana rpm key] ******************************************************************************************
ok: [ki-instance]

TASK [install kibana 7.x rpm repository] *******************************************************************************
--- before: /etc/yum.repos.d/elasticsearch-7.x.repo
+++ after: /etc/yum.repos.d/elasticsearch-7.x.repo
@@ -2,6 +2,6 @@
 async = 1
 baseurl = https://artifacts.elastic.co/packages/7.x/yum
 gpgcheck = 1
-gpgkey = https://artifacts.elastic.co/GPG-KEY-elasticsearch
+gpgkey = https://artifacts.elastic.co/GPG-KEY-elasticsearch'
 name = Elasticsearch repository for 7.x packages


changed: [ki-instance]

TASK [Download Kibana's rpm] *******************************************************************************************
ok: [ki-instance]

TASK [Install Kibana] **************************************************************************************************
ok: [ki-instance]

TASK [Configure Kibana] ************************************************************************************************
ok: [ki-instance]

PLAY RECAP *************************************************************************************************************
el-instance                : ok=11   changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
ki-instance                : ok=11   changed=1    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
```
<li>Повторно запустите playbook с флагом <code>--diff</code> и убедитесь, что playbook идемпотентен.</li>

```
$ ansible-playbook -i inventory/prod/prod.yml site.yml --diff

PLAY [Install Java] ****************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [ki-instance]
ok: [el-instance]

TASK [Set facts for Java 11 vars] **************************************************************************************
ok: [el-instance]
ok: [ki-instance]

TASK [Upload .tar.gz file containing binaries from local storage] ******************************************************
ok: [ki-instance]
ok: [el-instance]

TASK [Ensure installation dir exists] **********************************************************************************
ok: [ki-instance]
ok: [el-instance]

TASK [Extract java in the installation directory] **********************************************************************
skipping: [ki-instance]
skipping: [el-instance]

TASK [Export environment variables] ************************************************************************************
ok: [ki-instance]
ok: [el-instance]

PLAY [Install Elasticsearch] *******************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [el-instance]

TASK [install elasticsearch rpm key] ***********************************************************************************
ok: [el-instance]

TASK [install elasticsearch 7.x rpm repository] ************************************************************************
ok: [el-instance]

TASK [Download Elasticsearch's rpm] ************************************************************************************
ok: [el-instance]

TASK [Install Elasticsearch] *******************************************************************************************
ok: [el-instance]

TASK [Configure Elasticsearch] *****************************************************************************************
ok: [el-instance]

PLAY [Install Kibana] **************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [ki-instance]

TASK [install kibana rpm key] ******************************************************************************************
ok: [ki-instance]

TASK [install kibana 7.x rpm repository] *******************************************************************************
ok: [ki-instance]

TASK [Download Kibana's rpm] *******************************************************************************************
ok: [ki-instance]

TASK [Install Kibana] **************************************************************************************************
ok: [ki-instance]

TASK [Configure Kibana] ************************************************************************************************
ok: [ki-instance]

PLAY RECAP *************************************************************************************************************
el-instance                : ok=11   changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
ki-instance                : ok=11   changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
```
<li>Проделайте шаги с 1 до 8 для создания ещё одного play, который устанавливает и настраивает filebeat.</li>

```
$ ansible-playbook -i inventory/prod/prod.yml site.yml

PLAY [Install Java] ****************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [el-instance]
ok: [ki-instance]
ok: [fb-instance]

TASK [Set facts for Java 11 vars] **************************************************************************************
ok: [el-instance]
ok: [ki-instance]
ok: [fb-instance]

TASK [Upload .tar.gz file containing binaries from local storage] ******************************************************
ok: [ki-instance]
ok: [fb-instance]
ok: [el-instance]

TASK [Ensure installation dir exists] **********************************************************************************
ok: [ki-instance]
ok: [fb-instance]
ok: [el-instance]

TASK [Extract java in the installation directory] **********************************************************************
skipping: [ki-instance]
skipping: [el-instance]
skipping: [fb-instance]

TASK [Export environment variables] ************************************************************************************
ok: [ki-instance]
ok: [fb-instance]
ok: [el-instance]

PLAY [Install Elasticsearch] *******************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [el-instance]

TASK [install elasticsearch rpm key] ***********************************************************************************
ok: [el-instance]

TASK [install elasticsearch 7.x rpm repository] ************************************************************************
ok: [el-instance]

TASK [Download Elasticsearch's rpm] ************************************************************************************
ok: [el-instance]

TASK [Install Elasticsearch] *******************************************************************************************
ok: [el-instance]

TASK [Configure Elasticsearch] *****************************************************************************************
ok: [el-instance]

PLAY [Install Kibana] **************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [ki-instance]

TASK [install kibana rpm key] ******************************************************************************************
ok: [ki-instance]

TASK [install kibana 7.x rpm repository] *******************************************************************************
ok: [ki-instance]

TASK [Download Kibana's rpm] *******************************************************************************************
ok: [ki-instance]

TASK [Install Kibana] **************************************************************************************************
ok: [ki-instance]

TASK [Configure Kibana] ************************************************************************************************
ok: [ki-instance]

PLAY [Install Filebeat] ************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [fb-instance]

TASK [install elastic rpm key] *****************************************************************************************
ok: [fb-instance]

TASK [install filebeat 7.x rpm repository] *****************************************************************************
ok: [fb-instance]

TASK [Download filebeat's rpm] *****************************************************************************************
changed: [fb-instance]

TASK [Install Filebeat] ************************************************************************************************
changed: [fb-instance]

TASK [Configure Filebeat] **********************************************************************************************
changed: [fb-instance]

RUNNING HANDLER [restart Filebeat] *************************************************************************************
changed: [fb-instance]

PLAY RECAP *************************************************************************************************************
el-instance                : ok=11   changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
fb-instance                : ok=12   changed=4    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
ki-instance                : ok=11   changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
```
<li>Подготовьте README.md файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги.</li>
<li>Готовый playbook выложите в свой репозиторий, в ответ предоставьте ссылку на него.</li>
</ol>
