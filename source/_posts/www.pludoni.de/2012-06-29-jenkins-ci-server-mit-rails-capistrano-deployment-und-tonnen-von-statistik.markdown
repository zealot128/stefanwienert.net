---
title: Jenkins CI-Server mit Rails, Capistrano deployment und Tonnen von Statistik
date: 2012-06-29 19:38
comments: true
layout: post

categories: [pludoni, external]
---

{% img left /images/jenkins.png %}
Mit einem immer größer werdenden Team kommen neue Probleme auf:


* Tests werden nicht immer ausgeführt, weil grad "keine Zeit dafür ist". Dann schlagen Tests mitunter fehl
* Interessante Code-Statistiken und Dokumentationen werden seltener generiert und werden so schneller out-of-date
* Trotz einer Versionsverwaltung gibt es ab und an Konflikte
* Jedes Teammitglied soll selbst deployen können. Dabei soll aber sichergestellt, das kein Stand eines anderen überschrieben wird.

Es muss also ein Continuous Integration (CI) Server her!
Die beste Wahl, wenn man nach einer erweiterbaren OpenSource self-Hosting Variante sucht, ist anscheinend <a href="http://jenkins-ci.org/">Jenkins</a>, das durch seine vielfältigen Plugins hervorsticht.

Unsere Hauptprojekte basieren auf Ruby bzw. Rails, d.h. es gibt keinen eigentlichen Build-Prozess. Allerdings möchten wir folgende Tasks automatisieren:


* Ausführung aller Tests, inkl. der langsamen Browsertests (System/Integrationstests)
* Generation von Code-Statistiken, Testabdeckung, Dokumentation
* Deployment im Erfolgsfall ins Livesystem mittels eines schon vorhandenen Capistrano-Skriptes
*  Das Ganze soll dann möglichst mittels Jabber steuerbar sein (Als Jabber-Server verwenden wir <a href="http://www.igniterealtime.org/projects/openfire/">OpenFire</a>).

Nach etwa 1.5 Arbeitstagen steht das Ganze nun. Wie wir da vorgegangen sind, möchte ich kurz skizzieren.


###Installation


Auf einem Debian/Ubuntusystem muss lediglich die Paketquelle eingetragen werden, und dann kann das ganze über apt-get installiert werden. Die gesamte Prozedur haben wir hier beschrieben:

<a href="https://github.com/pludoni/railsTemplate">github.com/pludoni/railsTemplate</a>

Dort wird auch gleich beschrieben, wie man Ruby mittels RVM installiert und alle anderen, möglicherweise notwendigen, Programme.


###Konfiguration


Nach der Installation läuft Jenkins auf Port 8080 des Servers. Anfangs braucht man noch kein Login, welches man aber so schnell wie möglich unter Configuration/Security einrichten sollte.

Dann kann man auch schon Plugins über das Konfigurationsmenü installieren. Wenn anfangs die "Available Plugin"-Liste leer sein sollte, dann kann man im Tab "Advanced" unten rechts auf "Check Now" klicken.

Hier ein paar interessante Plugins


* Jenkins GIT plugin
* HTML Publisher plugin – damit lassen sich sehr leicht komplette generierte html-Ordner speichern und archivieren für die es kein eigenes Plugin gibt, z.B. für simple-cov, yarddoc, Rails-Best-Practices Ergebnisse
* Jenkins Jabber notifier plugin – Damit erscheint ein Jabber Bot in einem Konferenzraum unserer Wahl, der auf Knopfdruck Builds starten kann

* Jenkins instant-messaging plugin – Vorbedingung für Jabber Plugin
* Nach der Installation unter Configure noch die Zugangsdaten zum Jabberaccount, sowie den Konferenzraum, angeben


* Green Balls – erfolgreiche Builds werden bei Jenkins "blau" dargestellt. Damit werden sie "Grün", was für uns intuitiver ist.
* Simple Theme Plugin – hiermit kann man ein eigenes css/js angeben und so das Styling von Jenkins verbessern

* Ein guter Platz für das CSS ist der userContent-Ordner im Jenkins Homeverzeichnis (/var/lib/jenkins/userContent), der automatisch von außen erreichbar ist
* Unser aktuelles Theme ist <a href="https://github.com/pludoni/pludoni-jenkins-theme">hier</a> verfügbar


* AnsiColor – Damit werden farbige Konsolenausgaben ebenfalls farbig im Interface dargestellt (rspec, capistrano-colors)
* Brakeman Plugin – sammelt Statistiken über potenzielle Sicherheitsprobleme der Rails Anwendung mittels des brakeman Gems
* Jenkins ruby metrics plugin – Leider etwas veraltet und nicht mehr sinnvoll mit Ruby 1.9 nutzbar. Allerdings kann mit etwas Anpassung das Plugin benutzt werden, um Test Coverage Statistiken zu sammeln und bei Unterschreitung eines gewissen Prozentsatzes zu warnen sowie um einige Standard-Code-Statistiken darzustellen (LOCs, methods per class etc)
* Rvm – Ruby Version Manager
* Jenkins Wall Display Master Project – Eine Spezielle, Wall-Monitor optimierte Ansicht, die sehr visuell darstellt, ob Tests aller Projekte noch erfolgreich sind

###Konfiguration der Rails Anwendung


Um die diversen Statistiken zu generieren, sind auch auf der Railsseite einige Anpassungen notwendig. Diese sind unter <a href="https://github.com/pludoni/railsTemplate#necessary-gems">https://github.com/pludoni/railsTemplate#necessary-gems</a> aufgeführt.


###Installation des Rails-Templates


Das fertige <a href="https://raw.github.com/pludoni/railsTemplate/master/config.xml">Railstemplate</a> kann nun in den Jenkins-Ordner kopiert nach ```/var/lib/jenkins/jobs/RailsTemplate/config.xml```.

Danach kann dieses "Projekt" als Basis für einen neuen Job im Jenkins gewählt werden. Dann sind nur noch wenige Anpassungen notwendig:

* Git Pfad, RVM Version
* Jabber-Raum

**Was macht das Template?**

Prinzipiell ist es nur eine Hintereinanderausführung dieser Shellkommandos:

```bash
gem install bundler
bundle install
# Make sure, the ci-box has a development and test database
bundle exec rake db:migrate
bundle exec rake db:test:prepare
# running ci-reporter will generate some xml-reports in JUnit Format, which jenkins understands
bundle exec rake ci:setup:rspec spec

# Brakeman
bash -l -c 'rvm use 1.9.3 &&
  gem install brakeman --no-ri --no-rdoc &&
  brakeman -o brakeman-output.tabs --no-progress --separate-models'

# Documentation
bundle exec yardoc

mkdir -p rpb
# always return 0 = true; rbp will return the number of errors instead, which will fail the build
bundle exec rails_best_practices -f html  --silent --output-file rpb/index.html || true
# if everything went right until here, ship it!
bundle exec cap deploy
```

###Zusammenfassender Ablauf des Build Prozesses

{% img right /images/jenkins-preview.png %}

1. Jenkins checkt den letzten Stand des master-Branches aus dem Git-Repository aus
2. Wir bereiten Rails vor, mittels: bundle install, rake db:migrate, rake db:test:prepare
3. Specs werden mittels des CI-Reporters ausgeführt. Dieser generiert xml-Files, die Jenkins verwenden kann. Dadurch erhalten wir direkt im Jenkins eine detailierte Übersicht über fehlgeschlagene Tests
  * Gleichzeitig läuft SimpleCov mit und generiert – neben dem HTML – auch Ergebnisse im RCov-Format. Dieses Format kann später das RCov Plugin verwenden
4. yarddoc generiert die aktuellste Dokumentation
5. brakeman generiert Sicherheitstipps zur Anwendung
5. Rails-Best-Practices generiert Informationen zur Code-Qualität und Verbesserungsvorschläge
5. cap deploy wird ausgeführt, und so der letzte Stand auf den Live-Server gepackt
5. Die verschiedenen Publisher sammeln die Ergebnisse ein
5. Der Bot meldet den Erfolg an den Chat


Das ganze kann aus dem Chat mittels "!build Empfehlungsbund" angestoßen werden.

Damit haben wir nun einen Build-Prozess, mit dem wir sehr zufrieden sind. Wir werden in nächster Zeit alle wichtigen Projekte darauf umstellen. Jenkins scheint stabil und effizient seinen Job zu machen. Die Vielzahl an Plugins sind ein besonderer Bonuspunkt, da sie quasi garantieren, dass wir auch in Zukunft andere Projekte recht leicht mit Jenkins integrieren können.

---
<i>Reposted from <a href='http://www.pludoni.de/node/1098' rel='canonical'>www.pludoni.de</a></i>
