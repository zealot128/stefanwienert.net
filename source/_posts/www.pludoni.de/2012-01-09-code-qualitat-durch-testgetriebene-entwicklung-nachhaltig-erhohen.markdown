---
title: Code-Qualität durch Testgetriebene Entwicklung nachhaltig erhöhen
date: 2012-01-09 18:57
comments: true
layout: post

categories: [pludoni, external, personal, tdd, rails]
---
Im letzten Jahr schrieb ich meine Diplomarbeit bei der pludoni GmbH. Dabei stand die Entwicklungsmethode "Testgetriebene Softwareentwicklung (TDD)" im Vordergrund und wurde auf die Tauglichkeit zum Einsatz in der Firma untersucht. Insbesondere hatten wir die Vermutung, dass sie eine effektive Möglichkeit zur Steigerung unserer (internen) Qualität, d.h. der Code-Qualität und langfristig effizientere Entwicklung sei.
<!-- more -->

##Ergebnisse

 Im Rahmen der Arbeit habe ich einen Prototypen eines Stellenportals in Ruby on Rails (3) testgetrieben entwickelt. Am Ende stellten wir dann fest, dass die qualitativen Kennzahlen, z.B. Komplexität, Anzahl der Codesmells, Testabdeckung deutlich gegenüber früheren Rails-Projekten verbessert wurden.
 Ein Großteil der Arbeit konnte in das neue, gemeinsame Portal <a href="http://www.empfehlungsbund.de/">Empfehlungsbund.de</a> übernommen werden und befindet sich damit in Produktion. Somit war die Arbeit ein Erfolg. Dem stimmten auch meine Prüfer zu :).
 Details sind in der Arbeit zu finden: <a href="https://github.com/zealot128/Diplomarbeit---Testgetriebene-Softwareentwicklung-von-...-Ruby-on-Rails/blob/master/pdf/current.pdf">current.pdf</a>.
 Als Literatur zu empfehlen sind die Bücher:

* Test-Driven-Development by example, von Kent Beck,
* Rails Test Prescription, von Noel Rappin,
* RSpec Book, von David Chelimsky,
* <a href="http://jamesshore.com/Agile-Book/">Agile Book, James Shore</a>, das sogar größtenteils online verfügbar ist.
 sowie zahlloser, exzellenter Internetquellen.

##Ausblick

 Durch die prototypische Entwicklung konnten wir viel Wissen über verschiedene Testmethoden, insb. Rails, Cucumber, Selenium und Capybara, aber auch über unterschiedliche Rubygems und 3rd-Party-Librarys (thinking Sphinx, Geo-Suche, Javascript, Rails 3.1) in die Firma bringen.
 Nach der Arbeit und damit dem Ende meines Studiums habe ich nun meine Vollzeittätigkeit bei der pludoni GmbH als Entwickler begonnen.

---
<i>Reposted from <a href='http://www.pludoni.de/node/1062' rel='canonical'>www.pludoni.de</a></i>
