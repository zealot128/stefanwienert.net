---
title: Stabile SSH-Verbindung von unterwegs
date: 2012-02-16 10:11
comments: true
layout: post

categories: [pludoni, external,inux]
---

{% img right /images/blog/train.jpg http://www.flickr.com/photos/cecco1965/438969886 Train %}

Dank moderner Kommunikationsmittel ist eine ICE-Fahrt heutzutage kein Grund mehr mit der Arbeit aufzuhören :). Insbesondere falls es Probleme am Server gibt, ist es wünschenswert, auf SSH-Ebene mit den Servern stabil zu kommunizieren.

Leider führt eine solche Fahrt auch mal durch ländliches Gebiet ohne gute Netzabdeckung, und eine stabile SSH-Verbindung ist dann nicht gegeben. Als Ergebnis friert die Shell ein, und man muss eine neue aufmachen. Ärgerlich, wenn man die soeben geöffnete Datei noch nicht gespeichert hat.

Allerdings gibt es da einige Tipps, die auf unixoiden Betriebssystemen (Linux, MacOS) leicht umzusetzen sind. Zum einen gibt es eine Einstellung in der SSH-Verbindung und zum anderen einige Punkte in der Arbeitsweise, die man beachten kann, um so trotzdem sinnvoll zu arbeiten.
<!-- more -->

### Einstellungen

Falls man noch keine ssh-Konfigurationsdatei hat, so kann man diese in seinem
Homeverzeichnis unter ```~/.ssh/config``` anlegen. Eine Konfiguration sieht
z.B. so aus:

``` bash
Host pl
  User xxxx
  Hostname pludoni.de
  ServerAliveInterval 60
```



Setzt z.B. einen Alias "pl" für den angegeben Nutzer zum Server. Wichtig ist die letzte Option. Sollte nun unser SSH-Client die Verbindung verlieren, so probiert er in 60 Sekunden einen Reconnect. Aufrufen dieser Einstellung und verbinden können wir uns dann mittels ssh pl.

### Arbeitsweise

Um bei einem Verlust der Verbindung die noch nicht gespeicherten Daten zu behalten, sollte man einen Terminal Multiplexer, wie screen, oder besser [tmux](http://tmux.sourceforge.net/) verwenden. Diese ermöglichen es, die Shell von der aktuellen Verbindung zu entkoppeln. Zusätzlich ermöglichen beide auch ein simultanes Login mehrer Nutzer und TMUX ist damit eines der Standardtools beim Remote Pair Programming.
Nach einer gewissen Einarbeitungszeit gewöhnt man sich daran nach dem Login auf dem Server immer eine tmux-Sitzung zu öffnen, bzw. fortzusetzen. Da die Tmux Konfiguration leider nicht immer ganz einfach ist, gibt es z.B. den sehr eleganten Wrapper [tmuxinator](https://github.com/aziz/tmuxinator) dafür.

Falls man nun beim Arbeiten mit Tmux einen Verbindungsabbruch erlebt, kann man nach einem Relogin sofort mittels "attach" die Sitzung fortsetzen.

Falls die SSH-Verbindung einfriert, kann man sich mittels spezieller Tastenkombinationen befreien: &lt;Enter> ~. &lt;Enter> beendet z.B. die aktuelle Sitzung.

(geschrieben aus einem ICE)

---
<i>Reposted from <a href='http://www.pludoni.de/node/1088' rel='canonical'>www.pludoni.de</a></i>
