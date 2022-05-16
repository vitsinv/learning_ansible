<h1>Домашнее задание к занятию "10.04. ELK"</h1>
  
</details>  
<h2 dir="auto"><a id="user-content-задание-1" class="anchor" aria-hidden="true" href="#задание-1"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M7.775 3.275a.75.75 0 001.06 1.06l1.25-1.25a2 2 0 112.83 2.83l-2.5 2.5a2 2 0 01-2.83 0 .75.75 0 00-1.06 1.06 3.5 3.5 0 004.95 0l2.5-2.5a3.5 3.5 0 00-4.95-4.95l-1.25 1.25zm-4.69 9.64a2 2 0 010-2.83l2.5-2.5a2 2 0 012.83 0 .75.75 0 001.06-1.06 3.5 3.5 0 00-4.95 0l-2.5 2.5a3.5 3.5 0 004.95 4.95l1.25-1.25a.75.75 0 00-1.06-1.06l-1.25 1.25a2 2 0 01-2.83 0z"></path></svg></a>Задание 1</h2>
<details><summary>.</summary>
<p dir="auto">Вам необходимо поднять в докере:</p>
<ul dir="auto">
<li>elasticsearch(hot и warm ноды)</li>
<li>logstash</li>
<li>kibana</li>
<li>filebeat</li>
</ul>
<p dir="auto">и связать их между собой.</p>
<p dir="auto">Logstash следует сконфигурировать для приёма по tcp json сообщений.</p>
<p dir="auto">Filebeat следует сконфигурировать для отправки логов docker вашей системы в logstash.</p>
<p dir="auto">В директории <a href="/run0ut/devops-netology/blob/main/03-mnt-homeworks/10-monitoring-04-elk/help">help</a> находится манифест docker-compose и конфигурации filebeat/logstash для быстрого
выполнения данного задания.</p>
<p dir="auto">Результатом выполнения данного задания должны быть:</p>
<ul dir="auto">
<li>скриншот <code>docker ps</code> через 5 минут после старта всех контейнеров (их должно быть 5)</li>
<li>скриншот интерфейса kibana</li>
<li>docker-compose манифест (если вы не использовали директорию help)</li>
<li>ваши yml конфигурации для стека (если вы не использовали директорию help)</li>
</ul>
</details>  
<p dir="auto">Результатом выполнения данного задания должны быть:</p>
<ul dir="auto">
<li>
<p dir="auto">скриншот <code>docker ps</code> через 5 минут после старта всех контейнеров (их должно быть 5)</p>
<p dir="auto"><a target="_blank" rel="noopener noreferrer" href="/vitsinv/learning_ansible/blob/main/10_4_ELK/files/dockerps.jpg"><img src="/vitsinv/learning_ansible/blob/main/10_4_ELK/files/dockerps.jpg" alt="docker ps" style="max-width: 100%;"></a></p>
</li>
<li>
<p dir="auto">скриншот интерфейса kibana</p>
<p dir="auto"><a target="_blank" rel="noopener noreferrer" href="/vitsinv/learning_ansible/blob/main/10_4_ELK/files/kibana.jpg"><img src="/vitsinv/learning_ansible/blob/main/10_4_ELK/files/kibana.jpg" alt="kibana" style="max-width: 100%;"></a></p>
</li>
<li>
<p dir="auto">docker-compose манифест (если вы не использовали директорию help)</p>
<ul dir="auto">
<li><a href="/vitsinv/learning_ansible/blob/main/10_4_ELK/stack/docker-compose.yml">docker-compose.yml</a></li>
</ul>
</li>
<li>
<p dir="auto">ваши yml конфигурации для стека (если вы не использовали директорию help)</p>
<ul dir="auto">
<li><a href="/vitsinv/learning_ansible/blob/main/10_4_ELK/stack/filebeat/filebeat.docker.yml">filebeat.docker.yml</a></li>
<li><a href="/vitsinv/learning_ansible/blob/main/10_4_ELK/pipeline/simple_config.conf">simple_config.conf</a></li>
</ul>
</li>
</ul>
<h2 dir="auto"><a id="user-content-задание-2" class="anchor" aria-hidden="true" href="#задание-2"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M7.775 3.275a.75.75 0 001.06 1.06l1.25-1.25a2 2 0 112.83 2.83l-2.5 2.5a2 2 0 01-2.83 0 .75.75 0 00-1.06 1.06 3.5 3.5 0 004.95 0l2.5-2.5a3.5 3.5 0 00-4.95-4.95l-1.25 1.25zm-4.69 9.64a2 2 0 010-2.83l2.5-2.5a2 2 0 012.83 0 .75.75 0 001.06-1.06 3.5 3.5 0 00-4.95 0l-2.5 2.5a3.5 3.5 0 004.95 4.95l1.25-1.25a.75.75 0 00-1.06-1.06l-1.25 1.25a2 2 0 01-2.83 0z"></path></svg></a>Задание 2</h2>
<details><summary>.</summary>
<p dir="auto">Перейдите в меню <a href="http://localhost:5601/app/management/kibana/indexPatterns/create" rel="nofollow">создания index-patterns  в kibana</a>
и создайте несколько index-patterns из имеющихся.</p>
<p dir="auto">Перейдите в меню просмотра логов в kibana (Discover) и самостоятельно изучите как отображаются логи и как производить
поиск по логам.</p>
<p dir="auto">В манифесте директории help также приведенно dummy приложение, которое генерирует рандомные события в stdout контейнера.
Данные логи должны порождать индекс logstash-* в elasticsearch. Если данного индекса нет - воспользуйтесь советами
и источниками из раздела "Дополнительные ссылки" данного ДЗ.</p>
</details>  
<h3 dir="auto"><a id="user-content-создайте-несколько-index-patterns-из-имеющихся" class="anchor" aria-hidden="true" href="#создайте-несколько-index-patterns-из-имеющихся"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M7.775 3.275a.75.75 0 001.06 1.06l1.25-1.25a2 2 0 112.83 2.83l-2.5 2.5a2 2 0 01-2.83 0 .75.75 0 00-1.06 1.06 3.5 3.5 0 004.95 0l2.5-2.5a3.5 3.5 0 00-4.95-4.95l-1.25 1.25zm-4.69 9.64a2 2 0 010-2.83l2.5-2.5a2 2 0 012.83 0 .75.75 0 001.06-1.06 3.5 3.5 0 00-4.95 0l-2.5 2.5a3.5 3.5 0 004.95 4.95l1.25-1.25a.75.75 0 00-1.06-1.06l-1.25 1.25a2 2 0 01-2.83 0z"></path></svg></a>создайте несколько index-patterns из имеющихся</h3>
<p dir="auto"><a target="_blank" rel="noopener noreferrer" href="/vitsinv/learning_ansible/blob/main/10_4_ELK/files/pattern1.jpg"><img src="/vitsinv/learning_ansible/blob/main/10_4_ELK/files/pattern1.jpg" alt="G" style="max-width: 100%;"></a></p>
<h3 dir="auto"><a id="user-content-данные-логи-должны-порождать-индекс-logstash--в-elasticsearc" class="anchor" aria-hidden="true" href="#данные-логи-должны-порождать-индекс-logstash--в-elasticsearc"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M7.775 3.275a.75.75 0 001.06 1.06l1.25-1.25a2 2 0 112.83 2.83l-2.5 2.5a2 2 0 01-2.83 0 .75.75 0 00-1.06 1.06 3.5 3.5 0 004.95 0l2.5-2.5a3.5 3.5 0 00-4.95-4.95l-1.25 1.25zm-4.69 9.64a2 2 0 010-2.83l2.5-2.5a2 2 0 012.83 0 .75.75 0 001.06-1.06 3.5 3.5 0 00-4.95 0l-2.5 2.5a3.5 3.5 0 004.95 4.95l1.25-1.25a.75.75 0 00-1.06-1.06l-1.25 1.25a2 2 0 01-2.83 0z"></path></svg></a>Данные логи должны порождать индекс logstash-* в elasticsearc</h3>
<p dir="auto"><a target="_blank" rel="noopener noreferrer" href="/vitsinv/learning_ansible/blob/main/10_4_ELK/files/pattern.jpg"><img src="/vitsinv/learning_ansible/blob/main/10_4_ELK/files/pattern.jpg" alt="G" style="max-width: 100%;"></a></p>
</article>
