<h1>Домашнее задание к занятию "10.01. Зачем и что нужно мониторить"</h1>
<h2 dir="auto">Обязательные задания</h2>
<ol dir="auto">
<li>
<p dir="auto">Вас пригласили настроить мониторинг на проект. На онбординге вам рассказали, что проект представляет из себя
платформу для вычислений с выдачей текстовых отчетов, которые сохраняются на диск. Взаимодействие с платформой
осуществляется по протоколу http. Также вам отметили, что вычисления загружают ЦПУ. Какой минимальный набор метрик вы
выведите в мониторинг и почему?</p>

```
- Уровень hardware (В одном блоке собираем информацию по работе системы и использованию сети):
  - Загрузка СPU
  - Операции I/O
  - Свободное место на дисковой системе хостов платформы
  - Загрузка RAM.
  - Нагрузка на сетевые интерфейсы.
  - Проверка доступности всех хостов платформы по сети

- Уровень applcation:
  - Доступность по http.
  - Время выполнения операций. 
```

</li>
<li>
<p dir="auto">Менеджер продукта посмотрев на ваши метрики сказал, что ему непонятно что такое RAM/inodes/CPUla. Также он сказал,
что хочет понимать, насколько мы выполняем свои обязанности перед клиентами и какое качество обслуживания. Что вы
можете ему предложить?</p>

```
- Разъяснения МЕНЕДЖЕРУ:
  - RAM, CPU - Отвечают за выполнение операций приложения "на лету", с минимальным временем ожидания. 
  - inodes - Показывают нагрузку на файловую систему.

- Предложения - Ввести дополнительные метрики:
  - % успешно созданных отчетов
  - Среднее время выдачи отчета
```
</li>
<li>
<p>Вашей DevOps команде в этом году не выделили финансирование на построение системы сбора логов. Разработчики в свою
очередь хотят видеть все ошибки, которые выдают их приложения. Какое решение вы можете предпринять в этой ситуации,
чтобы разработчики получали ошибки приложения?</p>

```
- Поднять ELK и предоставить доступ разрабам в кибану.
(бесплатность этого решения весьма условна, так как поднимая сервис, мы вешаем на девопс еще одно решение, которое надо мониторить и поддерживать, да и разрабы не факт, что смогут безь вопросов и уточнений сразу разобраться. Таким образом, нам надо учитывать оплачиваемые человекочасы в бюджете. Но для бизнеса мы получаем бесплатное приложение.)
- Автоматизировать копирование логфайлов в отдельный (возможно, файловый) ресурс и предоставить к нему доступ разработчикам. Не уверен, что от этого отношения DevOps и разработчиков улучшатся. Но это будет бесплатно :)
```

</li>
<li>
<p dir="auto">Вы, как опытный SRE, сделали мониторинг, куда вывели отображения выполнения SLA=99% по http кодам ответов.
Вычисляете этот параметр по следующей формуле: summ_2xx_requests/summ_all_requests. Данный параметр не поднимается выше
70%, но при этом в вашей системе нет кодов ответа 5xx и 4xx. Где у вас ошибка?
</p>

```
- Редиректы и информационнные сообщения (3xx и 1xx) тоже занимают место, поэтому долдны быть учтены в формуле
```
</li>