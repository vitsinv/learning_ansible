<h1>Описание playbook</h1>

<h2>Используются переменные:</h2>

 - версия явы
 - версия elk стека
 - ip хостов (elsticsearch, kibana, filebeat)

 <h2> Плейбук делает:</h2>
 
 - на все хосты ставит яву
 - на каждый из хостов ставит по одному компоненту стека:
   - устанавливает репозиторй + gpg-key
   - скачаивает в tmp
   - устанавливает
   - из templates настраивает окружение
