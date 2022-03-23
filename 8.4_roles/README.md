<h1>Домашнее задание к занятию "8.4 Работа с Roles"</h1>
<h2 dir="auto"><a id="user-content-подготовка-к-выполнению" class="anchor" aria-hidden="true" href="#подготовка-к-выполнению"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M7.775 3.275a.75.75 0 001.06 1.06l1.25-1.25a2 2 0 112.83 2.83l-2.5 2.5a2 2 0 01-2.83 0 .75.75 0 00-1.06 1.06 3.5 3.5 0 004.95 0l2.5-2.5a3.5 3.5 0 00-4.95-4.95l-1.25 1.25zm-4.69 9.64a2 2 0 010-2.83l2.5-2.5a2 2 0 012.83 0 .75.75 0 001.06-1.06 3.5 3.5 0 00-4.95 0l-2.5 2.5a3.5 3.5 0 004.95 4.95l1.25-1.25a.75.75 0 00-1.06-1.06l-1.25 1.25a2 2 0 01-2.83 0z"></path></svg></a>Подготовка к выполнению</h2>
<ol dir="auto">
<li>Создайте два пустых публичных репозитория в любом своём проекте: kibana-role и filebeat-role.</li>
<li>Добавьте публичную часть своего ключа к своему профилю в github.</li>
</ol>
<h2 dir="auto">Основная часть</h2>
<p dir="auto">Наша основная цель - разбить наш playbook на отдельные roles. Задача: сделать roles для elastic, kibana, filebeat и написать playbook для использования этих ролей. Ожидаемый результат: существуют два ваших репозитория с roles и один репозиторий с playbook.</p>
<ol dir="auto">
<li>Создать в старой версии playbook файл <code>requirements.yml</code> и заполнить его следующим содержимым:
<div class="highlight highlight-source-yaml position-relative overflow-auto" data-snippet-clipboard-copy-content="---
  - src: git@github.com:netology-code/mnt-homeworks-ansible.git
    scm: git
    version: &quot;2.1.4&quot;
    name: elastic "><pre>---
  - <span class="pl-ent">src</span>: <span class="pl-s">git@github.com:netology-code/mnt-homeworks-ansible.git</span>
    <span class="pl-ent">scm</span>: <span class="pl-s">git</span>
    <span class="pl-ent">version</span>: <span class="pl-s"><span class="pl-pds">"</span>2.1.4<span class="pl-pds">"</span></span>
    <span class="pl-ent">name</span>: <span class="pl-s">elastic </span></pre></div>
</li>
<li>При помощи <code>ansible-galaxy</code> скачать себе эту роль.</li>

```
$ ansible-galaxy install -r requirements.yml
Starting galaxy role install process
The authenticity of host 'github.com (140.82.121.4)' can't be established.
ECDSA key fingerprint is SHA256:p2QAMXNIC1TJYWeIOttrVc98/R1BUFWu3/LiyKgUfQM.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
- extracting elasticx to /home/vitsin/.ansible/roles/elasticx
- elasticx (2.1.4) was installed successfully
```
<li>Создать новый каталог с ролью при помощи <code>ansible-galaxy role init kibana-role</code>.</li>

```
$ ansible-galaxy role init kibana-role --force
- Role kibana-role was created successfully
```
<li>На основе tasks из старого playbook заполните новую role. Разнесите переменные между <code>vars</code> и <code>default</code>.</li>
<li>Перенести нужные шаблоны конфигов в <code>templates</code>.</li>
<li>Создать новый каталог с ролью при помощи <code>ansible-galaxy role init filebeat-role</code>.</li>
<li>На основе tasks из старого playbook заполните новую role. Разнесите переменные между <code>vars</code> и <code>default</code>.</li>
<li>Перенести нужные шаблоны конфигов в <code>templates</code>.</li>
<li>Описать в <code>README.md</code> обе роли и их параметры.</li>
<li>Выложите все roles в репозитории. Проставьте тэги, используя семантическую нумерацию.</li>
<li>Добавьте roles в <code>requirements.yml</code> в playbook.</li>
<li>Переработайте playbook на использование roles.</li>
<li>Выложите playbook в репозиторий.</li>
<li>В ответ приведите ссылки на оба репозитория с roles и одну ссылку на репозиторий с playbook.</li>

- <a href="https://github.com/vitsinv/kibana-role">Репозиторий для роли kibana</a>
- <a href="https://github.com/vitsinv/filebeat-role">Репозиторий для роли filebeat</a>
- <a href="https://github.com/vitsinv/learning_ansible/tree/master/8.4_roles/playbook">playbook</a>
</ol>
<h2 dir="auto"><a id="user-content-необязательная-часть" class="anchor" aria-hidden="true" href="#необязательная-часть"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M7.775 3.275a.75.75 0 001.06 1.06l1.25-1.25a2 2 0 112.83 2.83l-2.5 2.5a2 2 0 01-2.83 0 .75.75 0 00-1.06 1.06 3.5 3.5 0 004.95 0l2.5-2.5a3.5 3.5 0 00-4.95-4.95l-1.25 1.25zm-4.69 9.64a2 2 0 010-2.83l2.5-2.5a2 2 0 012.83 0 .75.75 0 001.06-1.06 3.5 3.5 0 00-4.95 0l-2.5 2.5a3.5 3.5 0 004.95 4.95l1.25-1.25a.75.75 0 00-1.06-1.06l-1.25 1.25a2 2 0 01-2.83 0z"></path></svg></a>Необязательная часть</h2>
<ol dir="auto">
<li>Проделайте схожие манипуляции для создания роли logstash.</li>
<li>Создайте дополнительный набор tasks, который позволяет обновлять стек ELK.</li>
<li>Убедитесь в работоспособности своего стека: установите logstash на свой хост с elasticsearch, настройте конфиги logstash и filebeat так, чтобы они взаимодействовали друг с другом и elasticsearch корректно.</li>
<li>Выложите logstash-role в репозиторий. В ответ приведите ссылку.</li>
</ol>
<hr>
<h3 dir="auto">Как оформить ДЗ?</h3>
<p dir="auto">Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.</p>
