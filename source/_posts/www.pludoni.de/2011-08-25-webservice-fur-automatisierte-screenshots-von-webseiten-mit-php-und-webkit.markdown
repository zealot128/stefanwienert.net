---
title: ! '"Webservice" für automatisierte Screenshots von Webseiten mit PHP und Webkit'
date: 2011-08-25 17:48
comments: true
layout: post

categories: [pludoni, external, php]
---

*UPDATE*: Eine wesentlich schnellere Möglichkeit stellt wkhtmltoimage aus dem [wkhtmltopdf](https://code.google.com/p/wkhtmltopdf/)-Paket.

 Kürzlich kam das Problem auf, von bestimmten Websites automatisiert auf einem Server Bildschirmfotos anzufertigen. Die Gründe dafür sind vielfältig:

* Effiziente Vorbereitung für Tests einer gesamten Website
* Vorschau-Bilder für hinterlegte Links erstellen (wie bei Facebook oder Google+ bekannt)
* Screenshots von Social-Plugins (Facebook etc), um datenschutzkonform zu werden. Der User bekommt nur ein Bild vom Social-Plugin angezeigt, es wird keine Anfrage zum Server ausgeführt, und damit ist man datenschutzrechtlich auf der sicheren Seite. Alle Hinweise im Disclaimer sind eigentlich zu spät (http://dejure.org/gesetze/TMG/13.html)
 Eine bekannte Methode wäre, Firefox und einen X-Server zu installieren, um dann einen Screenshot des Desktops zu machen. Allerdings empfand ich diese Methode als unkomfortabel und instabil, weshalb ich mich nach einer anderen umsah.
 Gefunden habe ich Webkit2png, ein in Python geschriebenes Skript zum automatisierten Aufruf des Webkit-Browsers, der bekanntermaßen der Unterbau des Google Chrome und Apple Safaris ist. Neben ein paar Installationsschwierigkeiten läuft das ganze nun aber ausgezeichnet, wenn auch etwas langsam.
<h3>Installation</h3>
 Die Installation kurz beschrieben (für ein Debian-basiertes System)


```bash
apt-get install python-qt4 libqt4-webkit git-core xvfb
git clone https://github.com/AdamN/python-webkit2png
cd python-webkit2png
```


Das Tool kann nun von der Kommandozeile wie folgt gestartet werden:


```bash
./webkit2png.py -x 1024 768 -g 0 0 URL > AUSGABE.png
```

 Die Parameter 1024 768 beziehen sich auf die Größe des simulierten Graphikservers. Die Zahlen "-g 0 0" beziffern die Höhe und Breite des Browser-Fensters. "0" bedeutet hier Auto.

### Micro Webservice mit PHP
 Nun will man das ganze vielleicht noch mit einem PHP-Skript einwickeln, um es einfach abzurufen zu machen.

*  Man muss die Datei webkit2png.py in ein Verzeichnis mit dem zu schreibendem Skript legen
*  Die Datei "webkit2png.log" muss für den Webserver schreibbar sein:

```bash
touch webkit2png.log
chown www-data webkit2png.log
```

* Nun kann das PHP Skript erstellt werden:


```php
<?php
  if ($_GET["url"]) {
    $width = (int)$_GET["width"];
    $height = (int)$_GET["height"];
    $url = escapeshellarg($_GET["url"]);
    $cmd = "./webkit2png.py -x 1450 768 -g $width $height $url 2>&amp;1";
    header('Content-Type: image/png');
    passthru($cmd);
} else {  ?>
  <h2>Nutzung</h2>
  <form method="get">
   URL: <input type='text' name='url'/><br/>
   Breite des Browser Frames (0 = Auto): <input type='text' name='width' value='0'/><br/>
   Hoehe des Browser Frames (0 = Auto): <input type='text' name='width' value='0'/><br/>
   <input type='submit'/>
   Be patient, may take a while :)
  </form>
<?php } ?>
```

Voila, ein einfach anzusprechender Webservice, der uns Screenshots generiert und direkt anzeigt.

---
<i>Reposted from <a href='http://www.pludoni.de/node/1052' rel='canonical'>www.pludoni.de</a></i>
