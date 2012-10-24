---
title: Frameworkunabhängige Fehlerberichtung mit PHP und Redmine
date: 2012-02-08 11:07
comments: true
layout: post

categories: [pludoni, external,php,rails, german]
---

<img src='/images/blog/redmine.png' alt='Redmine Logo' class='right'/>
Webanwendungen sind Software, und damit prinzipbedingt fehlerbehaftet. Wenn nun ein Fehler bei einem Nutzer bzw. Kunden auftritt, wäre es wünschenswert, wenn wir als Entwickler zumindest davon erfahren. Für unsere Ruby on Rails-Anwendungen (z.B. [Empfehlungsbund.de](http://www.empfehlungsbund.de)) nutzen wir seit einiger Zeit den Service von *Airbrake*, die ein leicht zu installierendes Plugin anbieten. Nun suchten wir für PHP etwas ähnliches. Da wir aber mittlerweile sehr viele PHP-Anwendungen hatten, kam die Motivation auf:


* Ähnliches auch für PHP umzusetzen
* die Fehler-Benachrichtigung an unser eigenes System zu melden, um unabhängig von externen Dienstleistern zu sein.
* Das Ganze in einen Workflow zu bringen, sodass Fehler nicht vergessen werden
<!-- more -->


### Nutzung von Redmine als Bug-API-Server

Intern nutzen wir bereits den Bugtracker *Redmine* (der übrigens auch auf Ruby on Rails basiert), der uns durch die vielen Features, inklusive z.B. einer Zeiterfassung, einer API zum automatischen Anlegen von Tickets und Android Apps (*RedMinerDroid*) überzeugt hat.

Glücklicherweise gibt es bereits ein Plugin für Redmine – [Redmine Airbrake Server](https://github.com/milgner/redmine_airbrake_server), dass aus dem Bugtracker auch einen Airbrake-Bug-Server macht. Letztendlich sieht es so aus, dass ein Fehler ein Ticket im Bugtracker erzeugt, bzw. ein bestehendes aktualisiert, wenn ein Fehler wieder aufgetreten ist. Das ganze funktioniert sehr gut, auch wenn man natürlich Abstriche beim Informationsgehalt und der Aufbereitung machen muss, der bei kommerziellen Services wie Airbrake oder Newrelic natürlich besser ist. Nichtsdestotrotz bleibt man über den Status der Anwendung auf dem Laufenden, und erhält die notwendigen Informationen (Stacktrace, Fehlerdokument, URL und Session-Parameter)

###	Umbau der Client-Bibliotheken

Da dieses Plugin die Airbrake-API emuliert, lassen sich die dafür geeigneten Plugins meist relativ leicht so umbauen, dass sie nun stattdessen zum Bugtracker funken. Für das Rails-Plugin ist dies bereits auf der Githubseite des Airbrake Redmine Plugins dokumentiert. Für *PHP* haben wir das so gelöst:


* Download der [Airbrake-Notifer-PHP-Bibliothek](https://github.com/geoloqi/php-airbrake-notifier)
* ca. Zeile 190 in der ```Services/Airbrake.php``` die URL anpassen:


``` php
$url = "http://mybugtracker.domain.de/notifier_api/v2/notices";
```
* an geeigneter Stelle im Programmcode der eigenen Webanwendung(z.B. neues Modul, Klasse etc.) wiefolgt aufrufen:


``` php
<?php
require_once ‘php-airbrake-notifier/Services/Airbrake.php’;
$api_key = <<<DOC
---
:project: bugs
:tracker: Fehler
:api_key:            # Hier den E-Mail API Key aus dem Redmine
:assigned_to: admin  # Nutzer an den das zugewiesen wird
:login: api          # Nutzer, von dem das Ticket kommt
:reopen_strategy: production
DOC;
Services_Airbrake::installHandlers($api_key, 'production', 'curl');
```



Fertig :) Ab nun trudeln alle Mails als Tickets ein. Wenn Redmine richtig konfiguriert ist, dann bekommen alle Projektbeobachter Mails, sobald neue Tickets angelegt werden, bzw. Fehler auftraten.

---
<i>Reposted from <a href='http://www.pludoni.de/node/1086' rel='canonical'>www.pludoni.de</a></i>
