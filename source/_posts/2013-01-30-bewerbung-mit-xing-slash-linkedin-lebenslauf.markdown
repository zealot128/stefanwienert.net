---
layout: post
title: "Bewerbung mit XING / Linkedin Lebenslauf"
date: 2013-01-30 14:18
comments: true
categories: [ruby,empfehlungsbund,pludoni,german]
---
*Erstmalig veröffentlicht im [pludoni developer-Blog](http://www.pludoni.de/node/1110)*

{% img right /images/cv-2.jpg %}

<!-- Vorstellung des Features -->
Vor ein paar Tagen haben wir ein neues Feature am
[Empfehlungsbund](http://www.empfehlungsbund.de) freigeschaltet: Bewerbung und
Lebenslaufgenerierung mit sozialen Netzwerken, namentlich Xing und Linkedin.

Dabei können sich Bewerber bei der Bewerbung auf Stellen aus ITsax.de,
ITmitte.de, MINTsax.de, ... mit ihrem Xing/Linkedin-Profil bewerben.  Nach
Zustimmung generieren wir on-the-fly einen Lebenslauf und füllen das
Bewerbungsformular mit den Stammdaten aus.

**Das Ganze ist auch ohne eine Bewerbung möglich**. Unter [empfehlungsbund.de/cv](http://www.empfehlungsbund.de/cv) kann mit einem Klick der eigene Lebenslauf angezeigt werden. (Dabei speichern wir ausdrücklich keinerlei Daten des Lebenslaufs &ndash; erst Recht nicht das PDF selbst).

{% img /images/cv-1.png %}

## Warum das Ganze?

Wer kennt das nicht? In der Bewerbungsphase ist man damit beschäftigt, seinen Lebenslauf auf den neusten Stand zu bringen, möglicherweise das Ganze noch bei XING/Linkedin zu hinterlegen und schlussendlich individuelle Anschreiben zu erstellen.

Immer mehr Leute haben einen exzellent gepflegte Profile auf XING/Linkedin. Warum also die Daten nur da lassen? Bevor man anfängt nun per Copy-und-Paste das Ganze in einen eigenen Lebenslauf zu gießen, wäre es da nicht schöner, nur mit einem Knopfdruck den Lebenslauf zu generieren? Wir denke ja, mal sehen was die Bewerber so denken :).


## Umsetzung

Die Bewerbung wird durch den Empfehlungsbund, eine Ruby-on-Rails-Anwendung realisiert.
Darum konnten wir die erstklassige Rails-Bibliothek Omniauth, mit xing und
linkedin-Plugins, benutzen. Man muss den Plugins nur die anzufordernden Rechte und ggf. zu holende Daten mit übergeben:

```ruby
# config/initializers/omniauth.rb
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :linkedin, "apikey", "secret",
    scope: "r_basicprofile r_fullprofile r_contactinfo r_emailaddress",
    fields: %w[formatted-name associations certifications courses date-of-birth
      educations email-address honors twitter-accounts interests headline
      languages:(language,proficiency)
      volunteer:(volunteer-experiences:(role,organization,cause,description,start-date,end-date))
      main-address member-url-resources
      patents:(title,summary,date,url)
      phone-numbers picture-url positions
      publications:(title,date,summary,publisher,url)
      recommendations-received:(recommendation-type,recommendation-text,recommender:(formatted-name,headline,picture-url))
      public-profile-url skills specialties
      summary picture-urls::(original)
  ]
  provider :xing, "apikey", "secret"
end
```

Wie man oben sehen kann, muss man beim Linkedin-Plugin mit angeben, welche Felder man benötigt. Insbesondere volunteer und recommendations bedurfte einiger Try-and-error's, da die Dokumentation in einigen Stellen vage blieb.

Xing war da deutlich pflegeleichter, allerdings ist hier die Anmeldung einer App komplizierter, da sie bei XING einen Freischaltprozess inklusive Zusendung eines Tokens per Post beinhaltet.

Beide Plugins senden nun Ihre Daten an eine gemeinsame URL, in dem ein Adapter die verschiedenen Profilfelder in ein einheitliches Format übersetzt.  Danach wird mithilfe von WickedPDF und wkhtmltopdf ein PDF generiert.

## Ausblick
Dank Omniauth können natürlich auch weitere soziale Netzwerke angebunden
werden. Wir hatten das Ganze auch für Facebook probiert. Allerdings gibt es
(für Normalnutzer) keine Möglichkeit, die Telefonnummer oder Adresse aus der
API abzufragen. Damit ist das Ganze für eine Bewerbung relativ witzlos.

Außer Linkedin und XING fielen uns auch keine (im deutschen Markt agierende) soziale Netzwerke ein, die genügend Daten für einen Lebenslauf erfassen. Vielleicht wird es in ferner Zukunft ja mal einen Weibo-CV geben ... :)

## Unser Fazit

Insgesamt sind wir recht zufrieden mit dem aktuellen Lebenslauf-Export. Trotz stellenweise sehr unterschiedlichen Formaten wird ein einheitliches PDF generiert. Wenn man das Ganze während einer Bewerbung verwendet, so werden ebenfalls die Stammdaten ausgefüllt.

Jetzt bleibt nur abzuwarten, wie das Ganze bei Bewerbern und Personalern ankommt. Hauptziel ist natürlich eine Verbesserung der "Application-Experience" ;).
