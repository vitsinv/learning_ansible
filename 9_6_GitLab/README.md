<h1>Домашнее задание к занятию "09.06 Gitlab"</h1>
<h2 dir="auto">Подготовка к выполнению</h2>
<ol dir="auto">
<li>Необходимо <a href="https://about.gitlab.com/free-trial/" rel="nofollow">зарегистрироваться</a></li>
<li>Создайте свой новый проект</li>
<li>Создайте новый репозиторий в gitlab, наполните его <a href="/netology-code/mnt-homeworks/blob/MNT-7/09-ci-06-gitlab/repository">файлами</a></li>
<li>Проект должен быть публичным, остальные настройки по желанию</li>
</ol>

- <a href=https://gitlab.com/home_vitsinv/net96>Репозиторий на гитлаб</a>

<h2 dir="auto">Основная часть</h2>
<h3 dir="auto">DevOps</h3>
<p dir="auto">В репозитории содержится код проекта на python. Проект - RESTful API сервис. Ваша задача автоматизировать сборку образа с выполнением python-скрипта:</p>
<ol dir="auto">
<li>Образ собирается на основе <a href="https://hub.docker.com/_/centos?tab=tags&amp;page=1&amp;ordering=last_updated" rel="nofollow">centos:7</a></li>
<li>Python версии не ниже 3.7</li>
<li>Установлены зависимости: <code>flask</code> <code>flask-jsonpify</code> <code>flask-restful</code></li>
<li>Создана директория <code>/python_api</code></li>
<li>Скрипт из репозитория размещён в /python_api</li>
<li>Точка вызова: запуск скрипта</li>
<li>Если сборка происходит на ветке <code>master</code>: Образ должен пушится в docker registry вашего gitlab <code>python-api:latest</code>, иначе этот шаг нужно пропустить</li>
</ol>

- <a href=https://gitlab.com/home_vitsinv/net96/-/blob/main/dockerfile>Dockerfile</a>
- <a href=https://gitlab.com/home_vitsinv/net96/-/blob/main/python-api.py>python-api</a>
- <a href=https://gitlab.com/home_vitsinv/net96/-/blob/main/.gitlab-ci.yml>.gitlab-ci.yml</a>

<h3 dir="auto">Product Owner</h3>
<p dir="auto">Вашему проекту нужна бизнесовая доработка: необходимо поменять JSON ответа на вызов метода GET <code>/rest/api/get_info</code>, необходимо создать Issue в котором указать:</p>
<ol dir="auto">
<li>Какой метод необходимо исправить</li>
<li>Текст с <code>{ "message": "Already started" }</code> на <code>{ "message": "Running"}</code></li>
<li>Issue поставить label: feature</li>
</ol>

- <a href=files/issue.jpg>скриншот созданного issue</a>
- <a href=https://gitlab.com/home_vitsinv/net96/-/issues/1>ссылка на issue</a>

<h3 dir="auto">Developer</h3>
<p dir="auto">Вам пришел новый Issue на доработку, вам необходимо:</p>
<ol dir="auto">
<li>Создать отдельную ветку, связанную с этим issue</li>
<li>Внести изменения по тексту из задания</li>
<li>Подготовить Merge Requst, влить необходимые изменения в <code>master</code>, проверить, что сборка прошла успешно</li>

- <a href=files/merge.jpg>скриншот merge request</a>
- <a href="https://gitlab.com/home_vitsinv/net96/-/merge_requests/1/diffs?commit_id=abf1963d4cf2ee741e6be3b4aed6419c3bd55bee">ссылка на коммит</a>
</ol>

<h3 dir="auto">Tester</h3>
<p dir="auto">Разработчики выполнили новый Issue, необходимо проверить валидность изменений:</p>
<ol dir="auto">
<li>Поднять докер-контейнер с образом <code>python-api:latest</code> и проверить возврат метода на корректность</li>
<li>Закрыть Issue с комментарием об успешности прохождения, указав желаемый результат и фактически достигнутый</li>
</ol>

<h2 dir="auto">Итог</h2>
<p dir="auto">После успешного прохождения всех ролей - отправьте ссылку на ваш проект в гитлаб, как решение домашнего задания</p>

<a href=https://gitlab.com/home_vitsinv/net96/-/tree/main>GitLab</a>