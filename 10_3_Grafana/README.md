<h1>Домашнее задание к занятию "10.03. Grafana"</h1>
<h2>Задание повышенной сложности</h2>
<p data-sourcepos="5:1-6:132" dir="auto"><strong>В части задания 1</strong> не используйте директорию <a href="/netology-code/mnt-homeworks/blob/MNT-7/10-monitoring-03-grafana/help">help</a> для сборки проекта, самостоятельно разверните grafana, где в
роли источника данных будет выступать prometheus, а сборщиком данных node-exporter:</p>
<ul data-sourcepos="7:1-10:0" dir="auto">
<li data-sourcepos="7:1-7:9">grafana</li>
<li data-sourcepos="8:1-8:19">prometheus-server</li>
<li data-sourcepos="9:1-10:0">prometheus node-exporter</li>
</ul>
<p data-sourcepos="11:1-11:172" dir="auto">За дополнительными материалами, вы можете обратиться в официальную документацию grafana и prometheus.</p>
<p data-sourcepos="13:1-14:75" dir="auto">В решении к домашнему заданию приведите также все конфигурации/скрипты/манифесты, которые вы
использовали в процессе решения задания.</p>

<h3>Конфигурация prometheus</h3>

- prometheus.yml 
  - в jobs перечислены: 
    - node_exporter (127.0.0.1:9100)
    - windows_exporter (192.168.62.25:9182)
    - snmp_exporter (192.168.62.56:9116)
  - Alertmanager (localhost:9093) принимает файлы правил по маске *.rules.yml
  
```
# my global config
global:
  scrape_interval:     15s # Set the scrape interval to every 15 seconds. Default is every 1 minute.
  evaluation_interval: 15s # Evaluate rules every 15 seconds. The default is every 1 minute.
  # scrape_timeout is set to the global default (10s).

# Alertmanager configuration
alerting:
  alertmanagers:
  - static_configs:
    - targets:
       - localhost:9093

# Load rules once and periodically evaluate them according to the global 'evaluation_interval'.
rule_files:
  - "*.rules.yml"
  
# A scrape configuration containing exactly one endpoint to scrape:
# Here it's Prometheus itself.
scrape_configs:
  # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
  - job_name: 'Prometheus'

    # metrics_path defaults to '/metrics'

  - job_name: 'Prometheus'

    # metrics_path defaults to '/metrics'
    # scheme defaults to 'http'.

    static_configs:
    - targets:
      - 127.0.0.1:9100

  - job_name: SUN
    basic_auth:
      username: 'тут секретный логин'
      password: 'не менее секреный пароль'
    static_configs:
    - targets:
      - 192.168.62.25:9182

  - job_name: mikrotik_msk
    scrape_interval: 120s
    scrape_timeout: 90s
    static_configs:
      - targets:
        - 192.168.62.50  # SNMP device.
    metrics_path: /snmp
    params:
      module: [dev_msk]
    relabel_configs:
      - source_labels: [__address__]
        target_label: __param_target
      - source_labels: [__param_target]
        target_label: instance
      - target_label: __address__
        replacement: 192.168.62.56:9116      
```

- alertmanager.yml
  - отправляет алерты телеграм-боту (prometheus_bot) на адрес http://127.0.0.1:9087
```

route:
  group_by: ['alertname']
  group_wait: 30s
  group_interval: 5m
  repeat_interval: 1h
  receiver: 'prometheus_bot'
receivers:
  - name: prometheus_bot
    webhook_configs:
    - send_resolved: True
      url: http://127.0.0.1:9087/alert/<ID чата Telegram>
inhibit_rules:
  - source_match:
      severity: 'critical'
    target_match:
      severity: 'warning'
    equal: ['alertname', 'dev', 'instance']
```

- system.rules.yml (правила алертинга для системных ресурсов windows серверов)
```
 groups:
   - name: windows_servers
     rules:
# Свободное место на диске
     - alert: 'Заканчивается место на диске'
       expr: windows_logical_disk_write_latency_seconds_total > 1 and ceil(100.0 * (windows_logical_disk_free_bytes / w$       for: 0m
       labels:
         severity: "critical"
       annotations:
         summary:
           "{{ $labels.job }}: На диске {{ $labels.volume }} осталось {{ $value }}% свободного места."
# Загруженность RAM
     - alert: 'Высокая загруженность RAM'
       expr: 100.0 * (windows_cs_physical_memory_bytes - windows_os_physical_memory_free_bytes) / windows_cs_physical_m$       for: 3m
       labels:
         severity: "critical"
       annotations:
         summary: "RAM на {{ $labels.job }} загружена на {{ $value | humanize }}%."
# Загруженность CPU
     - alert: 'Высокая загрузка CPU'
       expr: 100 * (1 - avg by(job)(irate(windows_cpu_time_total{mode='idle'}[5m]))) > 70
       for: 3m
       labels:
```

- exporter.rules.yml (отдельное правило для мониторинга доступности windows_exporter)
```
groups:
  - name: windows_servers
    rules:
      - alert: PrometheusTargetMissing
        expr: up == 0
        for: 0m
        labels:
          severity: critical
        annotations:
          summary: "Потеряна связь с {{ $labels.job }}. Сервис exporter на {{ $labels.instance }} недоступен."
          description: "\n VALUE = {{ $value }}\n LABELS = {{ $labels }}"
```
- скриншоты node_exporter и dashboards
  - node_exporter

  - Dashboard node_exporter

  - Dashboard windows_exporter

  - Dashboard snmp_exporter

<p data-sourcepos="16:1-17:63" dir="auto"><strong>В части задания 3</strong> вы должны самостоятельно завести удобный для вас канал нотификации, например Telegram или Email
и отправить туда тестовые события.</p>
<p data-sourcepos="19:1-19:131" dir="auto">В решении приведите скриншоты тестовых событий из каналов нотификаций.</p>

- скриншот чата telegram



