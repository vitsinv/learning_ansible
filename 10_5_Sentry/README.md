<H1>Домашнее задание к занятию "10.05. Sentry"</h1>
<h2 dir="auto">Задание 1</h2>
<p dir="auto">Так как self-hosted Sentry довольно требовательная к ресурсам система, мы будем использовать Free cloud аккаунт.</p>
<p dir="auto">Free cloud account имеет следующие ограничения:</p>
<ul dir="auto">
<li>5 000 errors</li>
<li>10 000 transactions</li>
<li>1 GB attachments</li>
</ul>
<p dir="auto">Для подключения Free cloud account:</p>
<ul dir="auto">
<li>зайдите на sentry.io</li>
<li>нажжмите "Try for free"</li>
<li>используйте авторизацию через ваш github-account</li>
<li>далее следуйте инструкциям</li>
</ul>
<p dir="auto">Для выполнения задания - пришлите скриншот меню Projects.</p>

- <a href=https://github.com/vitsinv/learning_ansible/blob/master/10_5_Sentry/files/projects.JPG>Скриншот projects</a>

<h2 dir="auto">>Задание 2</h2>
<p dir="auto">Создайте python проект и нажмите <code>Generate sample event</code> для генерации тестового события.</p>
<p dir="auto">Изучите информацию, представленную в событии.</p>
<p dir="auto">Перейдите в список событий проекта, выберите созданное вами и нажмите <code>Resolved</code>.</p>
<p dir="auto">Для выполнения задание предоставьте скриншот <code>Stack trace</code> из этого события

- <a href=https://github.com/vitsinv/learning_ansible/blob/master/10_5_Sentry/files/stacktrace.JPG>скриншот stacktrace</a>

 и список событий проекта, после нажатия <code>Resolved</code>.</p>

- <a href=https://github.com/vitsinv/learning_ansible/blob/master/10_5_Sentry/files/issues.JPG>скриншот списка событий</a> 

<h2 dir="auto">Задание 3</h2>
<p dir="auto">Перейдите в создание правил алёртинга.</p>
<p dir="auto">Выберите проект и создайте дефолтное правило алёртинга, без настройки полей.</p>
<p dir="auto">Снова сгенерируйте событие <code>Generate sample event</code>.</p>
<p dir="auto">Если всё было выполнено правильно - через некоторое время, вам на почту, привязанную к github аккаунту придёт
оповещение о произошедшем событии.</p>
<p dir="auto">Если сообщение не пришло - проверьте настройки аккаунта Sentry (например привязанную почту), что у вас не было
<code>sample issue</code> до того как вы его сгенерировали и то, что правило алёртинга выставлено по дефолту (во всех полях all).
Также проверьте проект в котором вы создаёте событие, возможно алёрт привязан к другому.</p>
<p dir="auto">Для выполнения задания - пришлите скриншот тела сообщения из оповещения на почте.</p>

- <a href=https://github.com/vitsinv/learning_ansible/blob/master/10_5_Sentry/files/email.JPG>скриншот письма</a>
