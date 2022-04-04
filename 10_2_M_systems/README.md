<h2 dir="auto"></a>Обязательные задания</h2>
<ol dir="auto">
<li>
<p dir="auto">Опишите основные плюсы и минусы pull и push систем мониторинга.</p>
<p>

- В случае использования PULL модели мы рассчитываем, что система мониторинга будет сама опрашивать агентов и собирать данных. Таким образом, мы рассчитываем использовать следующие достоинства этой модели:
  - Мы сами определяем список источников и метрик
  - Также сами определяем частоту запросов и их наполняемость
  - Упрощенная схема деплоя агентов. Легче масштабировать
  - В связи с использованием HTTP запросов, можно в любое время выполнить любой запрос к агенту и получить данные любым инструментом, поддерживающим HTTP. 
  - При использовании Proxy можно разнести отдельно и саму систему мониторинга и агентов.

- PUSH модель характеризуется обратным механизмом работы. Агент сам определяет, что, кому и когда отправлять. Плюсы такой модели:
  - Проще настраивать отправку данных в несколько систем.
  - Настройка частоты и наполеннности передачи производится на самом клиенте.
  - Выше производительность за счет использования UDP.

При выборе модели стоит учитывать, что в завимости от требований к использованию системы мониторинга плюсы могут оказаться минусами.
Например, в случае применения PULL модели мы не получим никаких данных, пока не подключим к системе агентов и не выберем те данные, что нам нужны. В PUSH модели же, мы сразу начнем получать ворох данных, причем, каждого агента придется настраивать отдельно.
Также использование PUSH модели предполагает более интенсивную нагрузку на сеть, так как, вне зависимости от самой системы мониторинга, будет отправлять данные в сеть.
<li>
<p dir="auto">Какие из ниже перечисленных систем относятся к push модели, а какие к pull? А может есть гибридные?</p>
<ul dir="auto">
<li>Prometheus</li>
- Позволяет использовать обе модели
<li>TICK</li>
- Push
<li>Zabbix</li>
- Также позволяет использовать обе модели
<li>VictoriaMetrics</li>
- И снова гибрид
<li>Nagios</li>
- И push и pull модели
</ul>
</li>
<li>
<p dir="auto">Склонируйте себе <a href="https://github.com/influxdata/sandbox/tree/master">репозиторий</a> и запустите TICK-стэк,
используя технологии docker и docker-compose.</p>
</li>
</ol>
<p>В виде решения на это упражнение приведите выводы команд с вашего компьютера (виртуальной машины):</p>

- curl http://localhost:8086/ping

```
$ curl http://localhost:8086/ping -v
*   Trying 127.0.0.1:8086...
* TCP_NODELAY set
* Connected to localhost (127.0.0.1) port 8086 (#0)
> GET /ping HTTP/1.1
> Host: localhost:8086
> User-Agent: curl/7.68.0
> Accept: */*
>
* Mark bundle as not supporting multiuse
< HTTP/1.1 204 No Content
< Content-Type: application/json
< Request-Id: be703ada-b353-11ec-8198-0242ac120003
< X-Influxdb-Build: OSS
< X-Influxdb-Version: 1.8.10
< X-Request-Id: be703ada-b353-11ec-8198-0242ac120003
< Date: Sun, 03 Apr 2022 13:41:20 GMT
<
* Connection #0 to host localhost left intact
```
- curl http://localhost:8888

```
$ curl http://localhost:8888 -v
*   Trying 127.0.0.1:8888...
* TCP_NODELAY set
* Connected to localhost (127.0.0.1) port 8888 (#0)
> GET / HTTP/1.1
> Host: localhost:8888
> User-Agent: curl/7.68.0
> Accept: */*
>
* Mark bundle as not supporting multiuse
< HTTP/1.1 200 OK
< Accept-Ranges: bytes
< Cache-Control: public, max-age=3600
< Content-Length: 336
< Content-Security-Policy: script-src 'self'; object-src 'self'
< Content-Type: text/html; charset=utf-8
< Etag: "3362220244"
< Last-Modified: Tue, 22 Mar 2022 20:02:44 GMT
< Vary: Accept-Encoding
< X-Chronograf-Version: 1.9.4
< X-Content-Type-Options: nosniff
< X-Frame-Options: SAMEORIGIN
< X-Xss-Protection: 1; mode=block
< Date: Sun, 03 Apr 2022 13:43:43 GMT
<
* Connection #0 to host localhost left intact
<!DOCTYPE html><html><head><meta http-equiv="Content-type" content="text/html; charset=utf-8"><title>Chronograf</title><link rel="icon shortcut" href="/favicon.fa749080.ico"><link rel="stylesheet" href="/src.9cea3e4e.css"></head><body> <div id="react-root" data-basepath=""></div> <script src="/src.a969287c.js"></script> </body></html>16:43:43
```

- curl http://localhost:9092/kapacitor/v1/ping

```
$ curl http://localhost:9092/kapacitor/v1/ping -v
*   Trying 127.0.0.1:9092...
* TCP_NODELAY set
* Connected to localhost (127.0.0.1) port 9092 (#0)
> GET /kapacitor/v1/ping HTTP/1.1
> Host: localhost:9092
> User-Agent: curl/7.68.0
> Accept: */*
>
* Mark bundle as not supporting multiuse
< HTTP/1.1 204 No Content
< Content-Type: application/json; charset=utf-8
< Request-Id: 4f79d396-b354-11ec-81ca-000000000000
< X-Kapacitor-Version: 1.6.4
< Date: Sun, 03 Apr 2022 13:45:23 GMT
<
* Connection #0 to host localhost left intact
```

<p dir="auto">А также скриншот веб-интерфейса ПО chronograf (<code>http://localhost:8888</code>).</p>

<a href="https://github.com/vitsinv/learning_ansible/blob/master/10_2_M_systems/images/chronograf.JPG">Скриншот Chronograf</a>

<p dir="auto">P.S.: если при запуске некоторые контейнеры будут падать с ошибкой - проставьте им режим <code>Z</code>, например
<code>./data:/var/lib:Z</code></p>
<ol start="4" dir="auto">
<li>
<p dir="auto">Перейдите в веб-интерфейс Chronograf (<code>http://localhost:8888</code>) и откройте вкладку <code>Data explorer</code>.</p>
<ul dir="auto">
<li>Нажмите на кнопку <code>Add a query</code></li>
<li>Изучите вывод интерфейса и выберите БД <code>telegraf.autogen</code></li>
<li>В <code>measurments</code> выберите mem-&gt;host-&gt;telegraf_container_id , а в <code>fields</code> выберите used_percent.
Внизу появится график утилизации оперативной памяти в контейнере telegraf.</li>
<li>Вверху вы можете увидеть запрос, аналогичный SQL-синтаксису.
Поэкспериментируйте с запросом, попробуйте изменить группировку и интервал наблюдений.</li>
</ul>
</li>
</ol>
<p dir="auto">Для выполнения задания приведите скриншот с отображением метрик утилизации места на диске
(disk-&gt;host-&gt;telegraf_container_id) из веб-интерфейса.</p>
<ol start="5" dir="auto">
<a href="https://github.com/vitsinv/learning_ansible/blob/master/10_2_M_systems/images/disk.JPG">Метрики disk</a>

<li>Изучите список <a href="https://github.com/influxdata/telegraf/tree/master/plugins/inputs">telegraf inputs</a>.
Добавьте в конфигурацию telegraf следующий плагин - <a href="https://github.com/influxdata/telegraf/tree/master/plugins/inputs/docker">docker</a>:</li>
</ol>
<div class="snippet-clipboard-content position-relative overflow-auto" data-snippet-clipboard-copy-content="[[inputs.docker]]
  endpoint = &quot;unix:///var/run/docker.sock&quot;"><pre><code>[[inputs.docker]]
  endpoint = "unix:///var/run/docker.sock"
</code></pre></div>
<p dir="auto">Дополнительно вам может потребоваться донастройка контейнера telegraf в <code>docker-compose.yml</code> дополнительного volume и
режима privileged:</p>
<div class="snippet-clipboard-content position-relative overflow-auto" data-snippet-clipboard-copy-content="  telegraf:
    image: telegraf:1.4.0
    privileged: true
    volumes:
      - ./etc/telegraf.conf:/etc/telegraf/telegraf.conf:Z
      - /var/run/docker.sock:/var/run/docker.sock:Z
    links:
      - influxdb
    ports:
      - &quot;8092:8092/udp&quot;
      - &quot;8094:8094&quot;
      - &quot;8125:8125/udp&quot;"><pre><code>  telegraf:
    image: telegraf:1.4.0
    privileged: true
    volumes:
      - ./etc/telegraf.conf:/etc/telegraf/telegraf.conf:Z
      - /var/run/docker.sock:/var/run/docker.sock:Z
    links:
      - influxdb
    ports:
      - "8092:8092/udp"
      - "8094:8094"
      - "8125:8125/udp"
</code></pre></div>
<p dir="auto">После настройке перезапустите telegraf, обновите веб интерфейс и приведите скриншотом список <code>measurments</code> в
веб-интерфейсе базы telegraf.autogen . Там должны появиться метрики, связанные с docker.</p>

Вроде "донастроил":
- <a href="https://github.com/vitsinv/learning_ansible/blob/master/10_2_M_systems/images/telegraf.JPG">telegraf.conf</a>
- <a href="https://github.com/vitsinv/learning_ansible/blob/master/10_2_M_systems/images/docker-compose.JPG">docker-compose.yml</a>
- <a href="https://github.com/vitsinv/learning_ansible/blob/master/10_2_M_systems/images/docker.JPG">Порты пробросились</a>
- <a href="https://github.com/vitsinv/learning_ansible/blob/master/10_2_M_systems/images/metrics.JPG">Метрики docker отсутствуют</a>
