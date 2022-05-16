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
<p dir="auto"><a target="_blank" rel="noopener noreferrer" href="https://github.com/vitsinv/learning_ansible/blob/master/10_4_ELK/files/dockerps.JPG"><img src="https://github.com/vitsinv/learning_ansible/blob/master/10_4_ELK/files/dockerps.JPG" alt="docker ps" style="max-width: 100%;"></a></p>
</li>
<li>
<p dir="auto">скриншот интерфейса kibana</p>
<p dir="auto"><a target="_blank" rel="noopener noreferrer" href="https://github.com/vitsinv/learning_ansible/blob/master/10_4_ELK/files/kibana.JPG"><img src="https://github.com/vitsinv/learning_ansible/blob/master/10_4_ELK/files/kibana.JPG" alt="kibana" style="max-width: 100%;"></a></p>
</li>
<li>
<p dir="auto">docker-compose манифест (если вы не использовали директорию help)</p>
<ul dir="auto">

- Докер-Манифест

```
version: '3.6'

volumes:
  es_hot_data:
  es_warm_data:

networks:
  elk:
    driver: bridge

services:
  es-hot:
    image: elasticsearch:7.17.2
    container_name: es-hot
    environment:
      - node.name=es-hot
      - node.roles=master,data_hot,data_content
      - cluster.name=es-docker-cluster
      - cluster.initial_master_nodes=es-hot,es-warm
      - discovery.seed_hosts=es-warm
      - bootstrap.memory_lock=true
      - "ES_JAVA_OPTS=-Xms256m -Xmx256m"
    ulimits:
      memlock:
        soft: -1
        hard: -1
    volumes:
      - es_hot_data:/usr/share/elasticsearch/data
    expose:
      - "9300"
      - "9200"
    ports:
      - "9200:9200"
      - "9300:9300"
    networks:
      - elk
  es-warm:
    image: elasticsearch:7.17.2
    container_name: es-warm
    environment:
      - node.name=es-warm
      - node.roles=data_warm,data_content
      - cluster.name=es-docker-cluster
      - cluster.initial_master_nodes=es-hot,es-warm
      - discovery.seed_hosts=es-hot
      - bootstrap.memory_lock=true
      - "ES_JAVA_OPTS=-Xms256m -Xmx256m"
    ulimits:
      memlock:
        soft: -1
        hard: -1
    volumes:
      - es_warm_data:/usr/share/elasticsearch/data
    expose:
      - "9300"
      - "9200"
    ports:
      - "9201:9200"
      - "9301:9300"
    networks:
      - elk
    depends_on:
      - es-hot

  logstash:
    image: logstash:7.17.2
    container_name: logstash
    volumes:
      - ./logstash/pipeline:/usr/share/logstash/pipeline
      - "./logstash/jvm.options:/usr/share/logstash/config/jvm.options"
    expose:
      - "5044"
      - "12345"
      - "9600"
    ports:
      - "5044:5044"
      - "9600:9600"
      - "12345:12345"
    networks:
      - elk

  kibana:
    image: kibana:7.17.2
    container_name: kibana
    environment:
      - "SERVER_NAME=kibana"
      - "SERVER_HOST=0.0.0.0"
      - "ELASTICSEARCH_HOSTS=http://es-hot:9200"
      - "NODE_OPTIONS=--max-old-space-size=400"
    expose:
      - "5601"
    ports:
      - "5601:5601"
    networks:
      - elk

  filebeat:
    image: elastic/filebeat:7.17.2
    container_name: filebeat
    user: root
    privileged: true
    command:
      - "--strict.perms=false"
    volumes:
      - "./filebeat/filebeat.docker.yml:/usr/share/filebeat/filebeat.yml:ro"
      - "/var/run/docker.sock:/var/run/docker.sock:Z"
    networks:
      - elk
    depends_on:
      - logstash

  json_sender:
    image: pycontribs/alpine:latest
    container_name: json_sender
    volumes:
      - ./json_sender/gather_metrics.py:/opt/gather_metrics.py
    entrypoint: python3 /opt/gather_metrics.py logstash 12345
    networks:
      - elk
    depends_on:
      - logstash

  some_application:
    image: pycontribs/alpine:latest
    container_name: some_app
    volumes:
      - ../help/pinger/run.py:/opt/run.py:Z
    entrypoint: python3 /opt/run.py
    networks:
      - elk
    depends_on:
      - logstash
```
</ul>
</li>
<li>
<p dir="auto">ваши yml конфигурации для стека (если вы не использовали директорию help)</p>
<ul dir="auto">

- filebeat.docker.yml

```
filebeat.inputs:
- type: log
  enabled: false
  paths:
    - /var/log/*.log
- type: log
  enabled: false
  paths:
    - /var/log/host/*.log
- type: filestream
  enabled: false
  paths:
    - /var/log/*.log

filebeat.config:
  modules:
    path: ${path.config}/modules.d/*.yml
    reload.enabled: false

filebeat.autodiscover:
  providers:
    - type: docker
      hints.enabled: true

processors:
- add_docker_metadata:
    host: "unix:///var/run/docker.sock"

- decode_json_fields:
    fields: ["message"]
    target: "json"
    overwrite_keys: true

output.logstash:
  hosts: 'logstash:5044'

logging.level: info
logging.to_files: true
logging.files:
  path: /var/log/filebeat
  name: filebeat
  keepfiles: 7
  permissions: 0644
```
- simple_config/conf

```
input {
    beats {
        port => 5044
        client_inactivity_timeout => 9000
    }
    tcp {
        port => 12345
        codec => json
    }
}

output {
    if [container][name] == "some_app" {
        elasticsearch {
            hosts => ["es-hot:9200"]
            index => "logstash-%{+YYYY.MM.dd}" 
        }
    }
    else if [@metadata][beat] == "filebeat" {
        elasticsearch {
            hosts => ["es-hot:9200"]
            index => "%{[@metadata][beat]}-%{[@metadata][version]}" 
        }
    }
    else {
        elasticsearch {
            hosts => ["es-hot:9200"]
            index => "json_sender-%{+YYYY.MM.dd}" 
        }
    }
}
```
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
<p dir="auto"><a target="_blank" rel="noopener noreferrer" href="https://github.com/vitsinv/learning_ansible/blob/master/10_4_ELK/files/patterns1.JPG"><img src="https://github.com/vitsinv/learning_ansible/blob/master/10_4_ELK/files/patterns1.JPG" style="max-width: 100%;"></a></p>
<h3 dir="auto"><a id="user-content-данные-логи-должны-порождать-индекс-logstash--в-elasticsearc" class="anchor" aria-hidden="true" href="#данные-логи-должны-порождать-индекс-logstash--в-elasticsearc"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M7.775 3.275a.75.75 0 001.06 1.06l1.25-1.25a2 2 0 112.83 2.83l-2.5 2.5a2 2 0 01-2.83 0 .75.75 0 00-1.06 1.06 3.5 3.5 0 004.95 0l2.5-2.5a3.5 3.5 0 00-4.95-4.95l-1.25 1.25zm-4.69 9.64a2 2 0 010-2.83l2.5-2.5a2 2 0 012.83 0 .75.75 0 001.06-1.06 3.5 3.5 0 00-4.95 0l-2.5 2.5a3.5 3.5 0 004.95 4.95l1.25-1.25a.75.75 0 00-1.06-1.06l-1.25 1.25a2 2 0 01-2.83 0z"></path></svg></a>Данные логи должны порождать индекс logstash-* в elasticsearc</h3>
<p dir="auto"><a target="_blank" rel="noopener noreferrer" href="https://github.com/vitsinv/learning_ansible/blob/master/10_4_ELK/files/patterns.JPG"><img src="https://github.com/vitsinv/learning_ansible/blob/master/10_4_ELK/files/patterns.JPG" style="max-width: 100%;"></a></p>
</article>
