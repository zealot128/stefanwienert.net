---
title: Codeanalyse mit dem PHP Messdetector (phpmd)
date: 2011-03-21 12:10
comments: true
layout: post

categories: [pludoni, external,php]
---
 Um einen groben Überblick über die Codequalität zu erhalten, verwenden wir den PHP Messdetector. Dieser lässt sich per PHP PEAR recht leicht installieren, wie hier beschrieben.

 Von der Kommandozeile lässt sich dieser nun recht leicht ausführen (Hier am Beispiel des Usermoduls von Drupal 5). Als erstes die Länge des Codes (```codesize```)


```bash
# USAGE: phpmd files (text|xml|html) (unused|codesize|design|naming)
$ phpmd modules/user/user.module text codesize
modules/user/user.module:141 The function user_load() has a Cyclomatic Complexity of 10.
modules/user/user.module:210 The function user_save() has a Cyclomatic Complexity of 54.
modules/user/user.module:210 The function user_save() has an NPath complexity of 164166.
modules/user/user.module:210 Avoid really long methods.
modules/user/user.module:617 The function user_user() has a Cyclomatic Complexity of 13.
modules/user/user.module:690 Avoid really long methods.
```


 Hieran sieht man schön, dass die user_save Funktion alles andere als leicht wartbarer Code ist. Die *Cyclomatischen Komplexität* von 11, also der Anzahl an möglichen Entscheidungspunkten (if, while, for) innerhalb dieser Funktion ist eindeutig zu hoch.

 Neben ```codesize``` gibt es noch ```design```, ```naming``` und ```unused``` innerhalb des Standard-Regelsatzes. Diese sind auf der [PHPMD](http://phpmd.org/)-Seite sehr gut beschrieben.
 Die Tests können natürlich keine exakte Aussage machen, ob die Qualität des Codes nun "gut" oder "schlecht" ist, aber sie geben einen sehr guten Anhaltspunkt für mögliche Refaktorisierungen.

---
<i>Reposted from <a href='http://www.pludoni.de/node/1036' rel='canonical'>www.pludoni.de</a></i>
