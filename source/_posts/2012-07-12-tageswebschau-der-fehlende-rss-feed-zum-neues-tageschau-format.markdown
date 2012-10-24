---
layout: post
title: "Tageswebschau: Der fehlende RSS-Feed zum neues Tageschau Format"
date: 2012-07-12 12:47
comments: true
categories: [ruby, german]
---

Der eine oder andere mag es mitbekommen haben: Die Tagesschau hat neuerdings eine Sendung ["Tageswebschau"](http://www.radiobremen.de/unternehmen/aktuell/tageswebschau110.html), in der Werktags kurz auf neue Memes und Netzpolitik eingegangen wird. Ich finde das Format recht interessant.
Allerdings hat die Redaktion es "vergessen" einen entsprechenden RSS-Feed bereitzustellen, weswegen ich mich kurzerhand entschloss, einen eigenen zu bauen. Das Video liegt im MP4 Format in verschiedenen Qualitätsstufen vor, welche ich jeweils als einzelnen Feed bereitstelle:

* [MP4 - Hohe Qualität (etwa 40-50MB je Folge) ](http://feeds.stefanwienert.de/tageswebschau-mp4-high.xml)
* [MP4 - Mittlere Qualität (etwa 25MB je Folge) ](http://feeds.stefanwienert.de/tageswebschau-mp4-medium.xml)
* [MP4 - Geringe Qualität (etwa 3MB je Folge) ](http://feeds.stefanwienert.de/tageswebschau-mp4-low.xml)
* [iPhone MP4 - Geringe Qualität (alle Qualitätsstufen enthalten) ](http://feeds.stefanwienert.de/tageswebschau-iphone.xml)


Für die Programmierinteressierten: Das Ganze ist ein halbstündiger Cronjob der ein Rubyscript aufruft, welches mittels Nokogiri, open-uri und json die Infos zusammenschaufelt.
