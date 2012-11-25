---
title: ! 'Umzug ins neue Büro '
date: 2012-11-05 16:48
comments: true
layout: post

categories: [pludoni, external, german, server]
---
<em><i><a href='http://www.pludoni.de/node/1105' rel='canonical'>Original im pludoni-Team Blog erschienen</a></i></em>

 Im August sind wir in unser neues Büro in die Lohrmannstraße gezogen. Neue Technik, Server, Möbel und ein VDSL-Anschluss sind nun ideale Vorraussetzungen für eine Zusammenarbeit im Team. 
 Natürlich gab es dann auch einiges aufzubauen: Tische, Schränke, Stühle sowie natürlich - die Technik. Nagelneue Desktoprechner, Docking-Stations, 27 Zoll Monitore, Netzwerktechnik, NAS und ein neuer Server samt unterbrechungsfreier Stromversorgung ließen die Augen der gestandenen ITler höherschlagen. 

{% img right http://pics.stefanwienert.de/photos/medium/2012-07-30/20120731_110130.jpg?1343804598 %}

###Server und Netzwerk

 Insbesondere für unseren IT'ler Martin war es eine Freude, den Server und die Netzwerkstruktur einzurichten. Einige individuelle Anforderungen haben das Ganze etwas herausfordernder gestaltet: 

* Nutzerauthentifikation soll mit LDAP stattfinden
* Alle Homelaufwerke sollen auf dem NAS liegen, d.h. beim Anmelden wird das Home-Laufwerk der Nutzer on-the-fly gemountet
* Jeder Nutzer soll sich also prinzipiell an jedem der Computer anmelden können. Diese Virtualisierung der Arbeitsplätze ist ein wichtiger Punkt, da in unserem Team die Leute auch viel aus dem Home-Office arbeiten können bzw. Studenten nur Teilzeit im Büro sind.
* Während der ersten Wochen hatten wir noch kein (Festnetz)-Internet im Büro und mussten uns auf UMTS und Tethering beschränken. Das hat das Herunterladen von Linux-Distributionen und (Windows)-Updates extrem erschwert. Dafür haben wir uns dann ein lokales Ubuntu-Repository aufgebaut. Mitterweile liegt aber schon VDSL an, sodass das ganze kein Problem mehr ist.
 Neben der Nutzerverwaltung sollte der Büroserver auch folgende Dienste übernehmen: 

* Continuous Integration Server (virtualisiert) mit Jenkins
* zentrale Remote Desktop Installationen für verschiedene Windowsvarianten (XP mit IE6,7 z.B.) mit Virtualbox
* Source-Code-Management Server (Gitlab)
* Entwicklungsserver, an dem die Entwickler mit SSH/tmux auch Remote-Pairing betreiben können.
* Bugtracker (redmine)
* Jabber-Server und Chaträume (Hubot darf hier natürlich nicht fehlen)


{% img right http://pics.stefanwienert.de/photos/medium/2012-08-05/20120806_193043.jpg?1344320828 %}

###Nutzung

 Wir Entwickler erhoffen uns von dem Büro eine bessere Zusammenarbeit und persönlichere Kommunikation. Nachwievor nutzen viele der Entwickler und Werkstudenten die Home-Office Angebote. Trotzdem treffen wir uns gerne im Büro, um dort über die neusten Weiterentwicklungen und anstehende Software-Designs zu beratschlagen. Insbesondere das Training der Praktikanten ist nun deutlich effektiver, als dies über Remote Pairing möglich war. Auch gemeinsame Mittagessen und Austausch über neuste Internet-Memes fehlen natürlich nicht :). 

{% img right http://pics.stefanwienert.de/photos/medium/2012-06-29/20120630_151702.jpg?1341087087 %}

