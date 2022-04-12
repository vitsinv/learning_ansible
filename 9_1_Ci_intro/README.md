
<h1>Домашнее задание к занятию "09.01 Жизненный цикл ПО"</h1>
<h2 dir="auto"><a id="user-content-подготовка-к-выполнению" class="anchor" aria-hidden="true" href="#подготовка-к-выполнению"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M7.775 3.275a.75.75 0 001.06 1.06l1.25-1.25a2 2 0 112.83 2.83l-2.5 2.5a2 2 0 01-2.83 0 .75.75 0 00-1.06 1.06 3.5 3.5 0 004.95 0l2.5-2.5a3.5 3.5 0 00-4.95-4.95l-1.25 1.25zm-4.69 9.64a2 2 0 010-2.83l2.5-2.5a2 2 0 012.83 0 .75.75 0 001.06-1.06 3.5 3.5 0 00-4.95 0l-2.5 2.5a3.5 3.5 0 004.95 4.95l1.25-1.25a.75.75 0 00-1.06-1.06l-1.25 1.25a2 2 0 01-2.83 0z"></path></svg></a>Подготовка к выполнению</h2>
<ol dir="auto">
<li>Получить бесплатную <a href="https://www.atlassian.com/ru/software/jira/free" rel="nofollow">JIRA</a></li>
<li>Настроить её для своей "команды разработки"</li>
<li>Создать доски kanban и scrum</li>
</ol>
<h2 dir="auto"><a id="user-content-основная-часть" class="anchor" aria-hidden="true" href="#основная-часть"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M7.775 3.275a.75.75 0 001.06 1.06l1.25-1.25a2 2 0 112.83 2.83l-2.5 2.5a2 2 0 01-2.83 0 .75.75 0 00-1.06 1.06 3.5 3.5 0 004.95 0l2.5-2.5a3.5 3.5 0 00-4.95-4.95l-1.25 1.25zm-4.69 9.64a2 2 0 010-2.83l2.5-2.5a2 2 0 012.83 0 .75.75 0 001.06-1.06 3.5 3.5 0 00-4.95 0l-2.5 2.5a3.5 3.5 0 004.95 4.95l1.25-1.25a.75.75 0 00-1.06-1.06l-1.25 1.25a2 2 0 01-2.83 0z"></path></svg></a>Основная часть</h2>
<p dir="auto">В рамках основной части необходимо создать собственные workflow для двух типов задач: bug и остальные типы задач. Задачи типа bug должны проходить следующий жизненный цикл:</p>
<ol dir="auto">
<li>Open -&gt; On reproduce</li>
<li>On reproduce -&gt; Open, Done reproduce</li>
<li>Done reproduce -&gt; On fix</li>
<li>On fix -&gt; On reproduce, Done fix</li>
<li>Done fix -&gt; On test</li>
<li>On test -&gt; On fix, Done</li>
<li>Done -&gt; Closed, Open</li>
</ol>
<p dir="auto">Остальные задачи должны проходить по упрощённому workflow:</p>
<ol dir="auto">
<li>Open -&gt; On develop</li>
<li>On develop -&gt; Open, Done develop</li>
<li>Done develop -&gt; On test</li>
<li>On test -&gt; On develop, Done</li>
<li>Done -&gt; Closed, Open</li>
</ol>
<p dir="auto">Создать задачу с типом bug, попытаться провести его по всему workflow до Done. Создать задачу с типом epic, к ней привязать несколько задач с типом task, провести их по всему workflow до Done. При проведении обеих задач по статусам использовать kanban. Вернуть задачи в статус Open.
Перейти в scrum, запланировать новый спринт, состоящий из задач эпика и одного бага, стартовать спринт, провести задачи до состояния Closed. Закрыть спринт.</p>
<p dir="auto">Если всё отработало в рамках ожидания - выгрузить схемы workflow для импорта в XML. Файлы с workflow приложить к решению задания.</p>

- <a href=All_Workflow.xml>All</a>
- <a href=Bug_Workflow.xml>Bug</a>
<hr>
<h3 dir="auto"><a id="user-content-как-оформить-дз" class="anchor" aria-hidden="true" href="#как-оформить-дз"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M7.775 3.275a.75.75 0 001.06 1.06l1.25-1.25a2 2 0 112.83 2.83l-2.5 2.5a2 2 0 01-2.83 0 .75.75 0 00-1.06 1.06 3.5 3.5 0 004.95 0l2.5-2.5a3.5 3.5 0 00-4.95-4.95l-1.25 1.25zm-4.69 9.64a2 2 0 010-2.83l2.5-2.5a2 2 0 012.83 0 .75.75 0 001.06-1.06 3.5 3.5 0 00-4.95 0l-2.5 2.5a3.5 3.5 0 004.95 4.95l1.25-1.25a.75.75 0 00-1.06-1.06l-1.25 1.25a2 2 0 01-2.83 0z"></path></svg></a>Как оформить ДЗ?</h3>
<p dir="auto">Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.</p>
