<h1>Домашнее задание к занятию "09.03 CI\CD"</h1>
<h2>Подготовка к выполнению</h2>
<ol dir="auto">
<li>Создаём 2 VM в yandex cloud со следующими параметрами: 2CPU 4RAM Centos7(остальное по минимальным требованиям)</li>
<li>Прописываем в <a href="/netology-code/mnt-homeworks/blob/MNT-7/09-ci-03-cicd/infrastructure/inventory/cicd/hosts.yml">inventory</a> <a href="/netology-code/mnt-homeworks/blob/MNT-7/09-ci-03-cicd/infrastructure/site.yml">playbook'a</a> созданные хосты</li>
<li>Добавляем в <a href="/netology-code/mnt-homeworks/blob/MNT-7/09-ci-03-cicd/infrastructure/files">files</a> файл со своим публичным ключом (id_rsa.pub). Если ключ называется иначе - найдите таску в плейбуке, которая использует id_rsa.pub имя и исправьте на своё</li>
<li>Запускаем playbook, ожидаем успешного завершения</li>
<li>Проверяем готовность Sonarqube через <a href="http://localhost:9000" rel="nofollow">браузер</a></li>
<li>Заходим под admin\admin, меняем пароль на свой</li>
<li>Проверяем готовность Nexus через <a href="http://localhost:8081" rel="nofollow">бразуер</a></li>
<li>Подключаемся под admin\admin123, меняем пароль, сохраняем анонимный доступ</li>
</ol>
<h2>Знакомоство с SonarQube</h2>
<h3>Основная часть</h3>
<ol dir="auto">
<li>Создаём новый проект, название произвольное</li>
<li>Скачиваем пакет sonar-scanner, который нам предлагает скачать сам sonarqube</li>
<li>Делаем так, чтобы binary был доступен через вызов в shell (или меняем переменную PATH или любой другой удобный вам способ)</li>
<li>Проверяем <code>sonar-scanner --version</code>

```
$ sonar-scanner --version
INFO: Scanner configuration file: /home/sergey/Downloads/sonar-scanner-4.7.0.2747-linux/conf/sonar-scanner.properties
INFO: Project root configuration file: NONE
INFO: SonarScanner 4.7.0.2747
INFO: Java 11.0.14.1 Eclipse Adoptium (64-bit)
INFO: Linux 4.19.0-18-amd64 amd64
```
</li>
<li>Запускаем анализатор против кода из директории <a href="/netology-code/mnt-homeworks/blob/MNT-7/09-ci-03-cicd/example">example</a> с дополнительным ключом <code>-Dsonar.coverage.exclusions=fail.py</code>

```
$ sonar-scanner \
ctKey=n>   -Dsonar.projectKey=netology-93 \
Dsonar.>   -Dsonar.sources=. \
sonar.h>   -Dsonar.host.url=http://51.250.67.88:9000 \
>   -Dsonar.login=27ec8b753de62e3c33489fda0469ff5faf66b071 \
>   -Dsonar.coverage.exclusions=fail.py
INFO: Scanner configuration file: /home/sergey/Downloads/sonar-scanner-4.7.0.2747-linux/conf/sonar-scanner.properties
INFO: Project root configuration file: NONE
INFO: SonarScanner 4.7.0.2747
INFO: Java 11.0.14.1 Eclipse Adoptium (64-bit)
INFO: Linux 4.19.0-18-amd64 amd64
INFO: User cache: /home/sergey/.sonar/cache
INFO: Scanner configuration file: /home/sergey/Downloads/sonar-scanner-4.7.0.2747-linux/conf/sonar-scanner.properties
INFO: Project root configuration file: NONE
INFO: Analyzing on SonarQube server 9.1.0
INFO: Default locale: "en_US", source code encoding: "UTF-8" (analysis is platform dependent)
INFO: Load global settings
INFO: Load global settings (done) | time=171ms
INFO: Server id: 9CFC3560-AX-yYc0zWmjA1HwaageJ
INFO: User cache: /home/sergey/.sonar/cache
INFO: Load/download plugins
INFO: Load plugins index
INFO: Load plugins index (done) | time=85ms
INFO: Load/download plugins (done) | time=186ms
INFO: Process project properties
INFO: Process project properties (done) | time=10ms
INFO: Execute project builders
INFO: Execute project builders (done) | time=2ms
INFO: Project key: netology-93
INFO: Base dir: /home/sergey/git/devops-netology/03-mnt-homeworks/09-ci-03-cicd/example
INFO: Working dir: /home/sergey/git/devops-netology/03-mnt-homeworks/09-ci-03-cicd/example/.scannerwork
INFO: Load project settings for component key: 'netology-93'
INFO: Load project settings for component key: 'netology-93' (done) | time=40ms
INFO: Load quality profiles
INFO: Load quality profiles (done) | time=103ms
INFO: Load active rules
INFO: Load active rules (done) | time=2407ms
INFO: Indexing files...
INFO: Project configuration:
INFO:   Excluded sources for coverage: fail.py
INFO: 1 file indexed
INFO: 0 files ignored because of scm ignore settings
INFO: Quality profile for py: Sonar way
INFO: ------------- Run sensors on module netology-93
INFO: Load metrics repository
INFO: Load metrics repository (done) | time=55ms
INFO: Sensor Python Sensor [python]
WARN: Your code is analyzed as compatible with python 2 and 3 by default. This will prevent the detection of issues specific to python 2 or python 3. You can get a more precise analysis by setting a python version in your configuration via the parameter "sonar.python.version"
INFO: Starting global symbols computation
INFO: 1 source file to be analyzed
INFO: Load project repositories
INFO: Load project repositories (done) | time=40ms
INFO: 1/1 source file has been analyzed
INFO: Starting rules execution
INFO: 1 source file to be analyzed
INFO: 1/1 source file has been analyzed
INFO: Sensor Python Sensor [python] (done) | time=955ms
INFO: Sensor Cobertura Sensor for Python coverage [python]
INFO: Sensor Cobertura Sensor for Python coverage [python] (done) | time=10ms
INFO: Sensor PythonXUnitSensor [python]
INFO: Sensor PythonXUnitSensor [python] (done) | time=1ms
INFO: Sensor CSS Rules [cssfamily]
INFO: No CSS, PHP, HTML or VueJS files are found in the project. CSS analysis is skipped.
INFO: Sensor CSS Rules [cssfamily] (done) | time=1ms
INFO: Sensor JaCoCo XML Report Importer [jacoco]
INFO: 'sonar.coverage.jacoco.xmlReportPaths' is not defined. Using default locations: target/site/jacoco/jacoco.xml,target/site/jacoco-it/jacoco.xml,build/reports/jacoco/test/jacocoTestReport.xml
INFO: No report imported, no coverage information will be imported by JaCoCo XML Report Importer
INFO: Sensor JaCoCo XML Report Importer [jacoco] (done) | time=4ms
INFO: Sensor C# Project Type Information [csharp]
INFO: Sensor C# Project Type Information [csharp] (done) | time=1ms
INFO: Sensor C# Analysis Log [csharp]
INFO: Sensor C# Analysis Log [csharp] (done) | time=17ms
INFO: Sensor C# Properties [csharp]
INFO: Sensor C# Properties [csharp] (done) | time=1ms
INFO: Sensor JavaXmlSensor [java]
INFO: Sensor JavaXmlSensor [java] (done) | time=1ms
INFO: Sensor HTML [web]
INFO: Sensor HTML [web] (done) | time=4ms
INFO: Sensor VB.NET Project Type Information [vbnet]
INFO: Sensor VB.NET Project Type Information [vbnet] (done) | time=1ms
INFO: Sensor VB.NET Analysis Log [vbnet]
INFO: Sensor VB.NET Analysis Log [vbnet] (done) | time=17ms
INFO: Sensor VB.NET Properties [vbnet]
INFO: Sensor VB.NET Properties [vbnet] (done) | time=1ms
INFO: ------------- Run sensors on project
INFO: Sensor Zero Coverage Sensor
INFO: Sensor Zero Coverage Sensor (done) | time=0ms
INFO: SCM Publisher SCM provider for this project is: git
INFO: SCM Publisher 1 source file to be analyzed
INFO: SCM Publisher 1/1 source file have been analyzed (done) | time=230ms
INFO: CPD Executor Calculating CPD for 1 file
INFO: CPD Executor CPD calculation finished (done) | time=9ms
INFO: Analysis report generated in 104ms, dir size=103.1 kB
INFO: Analysis report compressed in 46ms, zip size=14.3 kB
INFO: Analysis report uploaded in 74ms
INFO: ANALYSIS SUCCESSFUL, you can browse http://51.250.67.88:9000/dashboard?id=netology-93
INFO: Note that you will be able to access the updated dashboard once the server has processed the submitted analysis report
INFO: More about the report processing at http://51.250.67.88:9000/api/ce/task?id=AX-yv5jPWmjA1Hwaaljl
INFO: Analysis total time: 6.525 s
INFO: ------------------------------------------------------------------------
INFO: EXECUTION SUCCESS
INFO: ------------------------------------------------------------------------
INFO: Total time: 8.165s
INFO: Final Memory: 8M/30M
INFO: ------------------------------------------------------------------------

```
</li>
<li>Смотрим результат в интерфейсе
![sonar_interface](files/sonar_interface.jpg)
</li>

<li>Исправляем ошибки, которые он выявил(включая warnings)</li>
<li>Запускаем анализатор повторно - проверяем, что QG пройдены успешно</li>
<li>Делаем скриншот успешного прохождения анализа, прикладываем к решению ДЗ</li>
</ol>
<h2 dir="auto"><a id="user-content-знакомство-с-nexus" class="anchor" aria-hidden="true" href="#знакомство-с-nexus"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M7.775 3.275a.75.75 0 001.06 1.06l1.25-1.25a2 2 0 112.83 2.83l-2.5 2.5a2 2 0 01-2.83 0 .75.75 0 00-1.06 1.06 3.5 3.5 0 004.95 0l2.5-2.5a3.5 3.5 0 00-4.95-4.95l-1.25 1.25zm-4.69 9.64a2 2 0 010-2.83l2.5-2.5a2 2 0 012.83 0 .75.75 0 001.06-1.06 3.5 3.5 0 00-4.95 0l-2.5 2.5a3.5 3.5 0 004.95 4.95l1.25-1.25a.75.75 0 00-1.06-1.06l-1.25 1.25a2 2 0 01-2.83 0z"></path></svg></a>Знакомство с Nexus</h2>
<h3 dir="auto"><a id="user-content-основная-часть-1" class="anchor" aria-hidden="true" href="#основная-часть-1"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M7.775 3.275a.75.75 0 001.06 1.06l1.25-1.25a2 2 0 112.83 2.83l-2.5 2.5a2 2 0 01-2.83 0 .75.75 0 00-1.06 1.06 3.5 3.5 0 004.95 0l2.5-2.5a3.5 3.5 0 00-4.95-4.95l-1.25 1.25zm-4.69 9.64a2 2 0 010-2.83l2.5-2.5a2 2 0 012.83 0 .75.75 0 001.06-1.06 3.5 3.5 0 00-4.95 0l-2.5 2.5a3.5 3.5 0 004.95 4.95l1.25-1.25a.75.75 0 00-1.06-1.06l-1.25 1.25a2 2 0 01-2.83 0z"></path></svg></a>Основная часть</h3>
<ol dir="auto">
<li>В репозиторий <code>maven-public</code> загружаем артефакт с GAV параметрами:
<ol dir="auto">
<li>groupId: netology</li>
<li>artifactId: java</li>
<li>version: 8_282</li>
<li>classifier: distrib</li>
<li>type: tar.gz</li>
</ol>
</li>
<li>В него же загружаем такой же артефакт, но с version: 8_102</li>
<li>Проверяем, что все файлы загрузились успешно</li>
<li>В ответе присылаем файл <code>maven-metadata.xml</code> для этого артефекта</li>
</ol>
<h3 dir="auto"><a id="user-content-знакомство-с-maven" class="anchor" aria-hidden="true" href="#знакомство-с-maven"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M7.775 3.275a.75.75 0 001.06 1.06l1.25-1.25a2 2 0 112.83 2.83l-2.5 2.5a2 2 0 01-2.83 0 .75.75 0 00-1.06 1.06 3.5 3.5 0 004.95 0l2.5-2.5a3.5 3.5 0 00-4.95-4.95l-1.25 1.25zm-4.69 9.64a2 2 0 010-2.83l2.5-2.5a2 2 0 012.83 0 .75.75 0 001.06-1.06 3.5 3.5 0 00-4.95 0l-2.5 2.5a3.5 3.5 0 004.95 4.95l1.25-1.25a.75.75 0 00-1.06-1.06l-1.25 1.25a2 2 0 01-2.83 0z"></path></svg></a>Знакомство с Maven</h3>
<h3 dir="auto"><a id="user-content-подготовка-к-выполнению-1" class="anchor" aria-hidden="true" href="#подготовка-к-выполнению-1"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M7.775 3.275a.75.75 0 001.06 1.06l1.25-1.25a2 2 0 112.83 2.83l-2.5 2.5a2 2 0 01-2.83 0 .75.75 0 00-1.06 1.06 3.5 3.5 0 004.95 0l2.5-2.5a3.5 3.5 0 00-4.95-4.95l-1.25 1.25zm-4.69 9.64a2 2 0 010-2.83l2.5-2.5a2 2 0 012.83 0 .75.75 0 001.06-1.06 3.5 3.5 0 00-4.95 0l-2.5 2.5a3.5 3.5 0 004.95 4.95l1.25-1.25a.75.75 0 00-1.06-1.06l-1.25 1.25a2 2 0 01-2.83 0z"></path></svg></a>Подготовка к выполнению</h3>
<ol dir="auto">
<li>Скачиваем дистрибутив с <a href="https://maven.apache.org/download.cgi" rel="nofollow">maven</a></li>
<li>Разархивируем, делаем так, чтобы binary был доступен через вызов в shell (или меняем переменную PATH или любой другой удобный вам способ)</li>
<li>Удаляем из <code>apache-maven-&lt;version&gt;/conf/settings.xml</code> упоминание о правиле, отвергающем http соединение( раздел mirrors-&gt;id: my-repository-http-unblocker)</li>
<li>Проверяем <code>mvn --version</code></li>
<li>Забираем директорию <a href="/netology-code/mnt-homeworks/blob/MNT-7/09-ci-03-cicd/mvn">mvn</a> с pom</li>
</ol>
<h3 dir="auto"><a id="user-content-основная-часть-2" class="anchor" aria-hidden="true" href="#основная-часть-2"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M7.775 3.275a.75.75 0 001.06 1.06l1.25-1.25a2 2 0 112.83 2.83l-2.5 2.5a2 2 0 01-2.83 0 .75.75 0 00-1.06 1.06 3.5 3.5 0 004.95 0l2.5-2.5a3.5 3.5 0 00-4.95-4.95l-1.25 1.25zm-4.69 9.64a2 2 0 010-2.83l2.5-2.5a2 2 0 012.83 0 .75.75 0 001.06-1.06 3.5 3.5 0 00-4.95 0l-2.5 2.5a3.5 3.5 0 004.95 4.95l1.25-1.25a.75.75 0 00-1.06-1.06l-1.25 1.25a2 2 0 01-2.83 0z"></path></svg></a>Основная часть</h3>
<ol dir="auto">
<li>Меняем в <code>pom.xml</code> блок с зависимостями под наш артефакт из первого пункта задания для Nexus (java с версией 8_282)</li>
<li>Запускаем команду <code>mvn package</code> в директории с <code>pom.xml</code>, ожидаем успешного окончания</li>
<li>Проверяем директорию <code>~/.m2/repository/</code>, находим наш артефакт</li>
<li>В ответе присылаем исправленный файл <code>pom.xml</code></li>
</ol>
<hr>
<h3 dir="auto"><a id="user-content-как-оформить-дз" class="anchor" aria-hidden="true" href="#как-оформить-дз"><svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M7.775 3.275a.75.75 0 001.06 1.06l1.25-1.25a2 2 0 112.83 2.83l-2.5 2.5a2 2 0 01-2.83 0 .75.75 0 00-1.06 1.06 3.5 3.5 0 004.95 0l2.5-2.5a3.5 3.5 0 00-4.95-4.95l-1.25 1.25zm-4.69 9.64a2 2 0 010-2.83l2.5-2.5a2 2 0 012.83 0 .75.75 0 001.06-1.06 3.5 3.5 0 00-4.95 0l-2.5 2.5a3.5 3.5 0 004.95 4.95l1.25-1.25a.75.75 0 00-1.06-1.06l-1.25 1.25a2 2 0 01-2.83 0z"></path></svg></a>Как оформить ДЗ?</h3>
<p dir="auto">Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.</p>
