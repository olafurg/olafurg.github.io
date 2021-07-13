---
title: Nokkur grunnatriði fyrir öryggi á netinu
slug: nokkur-grunnatridi
date: 2020-02-09 20:00 UTC
author: Ólafur Guðmundsson
published: true
---

Það eru nokkur atriði sem eru hálfgerð grundvallaratriði fyrir alla að hafa í huga þegar kemur að öryggi á netinu. Þetta er tilraun tl að lýsa þeim helstu gróflega og af hverju þau eru mikilvæg.

1. [Einkvæm lykilorð](#unique-passwords)
1. [Lykilorðastjóri](#password-manager)
1. [Fjölþátta auðkenning](#mfa)
1. [Efastu um allt](#scepticism)

## Einkvæm lykilorð <a name="unique-passwords">
Það er algjör nauðsyn nú til dags að nota einkvæm lykilorð _(e. unique passwords)_ fyrir hverja þjónustu. Aldrei endurnota lykilorð. Það er svo algengt að síður séu hakkaðar og gagnagrunnar að leka út á opið Internetið. Og því miður geyma ekki allar vefsíður lykilorð á öruggan hátt (þ.a. ekki sé hægt að lesa þau með berum augum).

Lykilorð eiga að vera dulkóðuð á þannig hátt að það sé nánast ógerlegt að finna út hvað upprunalega lykilorðið er. Hins vegar eru margar síður sem gera það ekki nógu vel og jafnvel vista lykilorðin óbreytt og læsileg hverjum sem hefur aðgang í gagnagrunninn.

Sem dæmi: Ef þú færð tölvupóst frá einhverrri þjónustu og lykilorðið þitt er sent með í læsilegum texta - þá er þjónustan engan veginn að vista lykilorðin á öruggan hátt. Hættan er því þessi:

1. Segjum að þú notir sama lykilorðið á tveimur þjónustum; einni sem geymir það á óöruggan hátt og annarri sem gerir það almennilega, en er þér mjög mikilvæg, t.d. Facebook eða Gmail.
1. Fyrri þjónustan er hökkuð og gagnagrunnurinn lekur á netið, ásamt lykilorðum í læsilegum texta.
1. Óprúttnir aðilar fara beint í svona gagnagrunna og nota notandanafnið þitt og lykilorðið og prófa það á alls konar öðrum þjónustum til að athuga hvort eitthvað virkar. Svokallað [credential stuffing](https://en.wikipedia.org/wiki/Credential_stuffing).
1. Þar sem þú ert að nota þetta lykilorð á annarri þjónustu líka (t.d. Facebook/Gmail) þá mun þetta virka þar og viðkomandi aðilar hafa þá yfirtekið þann aðgang.

Passaðu því að endurnýta aldrei lykilorð. Hljómar einfalt að segja en erfitt að gera? Eina leiðin til að þetta sé raunhæft er að nota lykilorðastjóra. 👇

## Lykilorðastjóri <a name="password-manager">
Mjög mikilvægt atriði til að auka öryggi á netinu er að nota lykilorðastjóra _(e. password manager)_. Það getur hljómað flókið fyrir fólk sem hefur aldrei notað slíkt en er í raun sáraeinfalt.

Það sem hann gerir er að þegar þú ert að skrá þig inn á nýja þjónustu þá ferðu í lykilorðastjórann og lætur hann búa til langt, einstakt lykilorð (30 eða fleiri stafa blanda af stöfum, táknum og tölum) og þú notar það til að skrá þig inn ("copy/paste" eða "autofill"). Lykilorðastjórinn man svo að þetta sé lykilorðið þitt fyrir þessa viðkomandi þjónustu og þú þarft aldrei nokkurn tímann að vita hvað það er.

Það eru margir möguleikar, eftir því hversu langt þú vilt ganga í örygginu, en þessar lausnir eru meðal þeirra vinsælli:

* [1Password](https://1password.com/)
* [Bitwarden](https://bitwarden.com/)
* [LastPass](https://www.lastpass.com/)
* [Dashlane](https://www.dashlane.com/)
* [KeePassXC](https://keepassxc.org/)

Ég yrði líklega sáttur með hvaða tól af þessu sem er. KeePassXC er helst fyrir þau sem eru mjög tæknileg eða paranoid og sætta sig við að hafa ekki sync í símann. Ég er hins vegar ekki þar og myndi velja eitt af hinum. Ég notaði LastPass í mörg ár, Bitwarden núna, og er sáttur við bæði. Eins er 1Password mjög vinsælt og notendavænt. Skiptir ekki öllu máli hvað af þessu þið veljið, öll eru góð.

_Fyrir þá sem hafa mikinn áhuga á þessu bendi ég á Podcast þátt frá [The Privacy, Security, & OSINT Show](https://www.inteltechniques.com/podcast.html): [Password Managers Revisited](https://soundcloud.com/user-98066669/150-password-managers-revisited)_

Og fyrir lykilorðastjórann er algjört lykilatriði (sem og fyrir aðrar þjónustur en hér er það engin afsökun) að vera með fjölþátta auðkenni (MFA/2FA). Sjá næsta lið hér fyrir neðan.

## Fjölþátta auðkenning <a name="mfa">
Fjölþátta auðkenning er á ensku kölluð _multifactor authentication_ eða _two-factor authentication_, oft skammsett sem MFA eða 2FA. Það sem hún gerir er að bæta við auka lagi af öryggi ofan á þetta hefðbundna _notandanafn + lykilorð_ sem flestir nota. Þetta auka lag getur verið t.d. tímabundinn kóði í appi, af auðkenniskubbi (ekki ósvipað og bankarnir gáfu út fyrir hér áður fyrr), eða SMS (ekki eins öruggt).

Ef þú ert með MFA virkjað þá myndir þú innskrá þig svona:

1. Skrá inn notandanafn og lykilorð og smella á innskrá
1. Þjónustan biður þig núna um auka kóða, sem þú færð í MFA appinu.
1. Opna MFA appið í símanum og finna kóðann fyrir viðkomandi þjónustu (endurnýjast á ca 20-30 sekúndum). Nú eða bíða eftir SMS með kóðanum ef þú ert með SMS virkjað.
1. Stimpla inn kóðann á síðuna í þartilgerðan reit og staðfesta.
1. Innskráð(ur)

Þetta gerir það að verkum að þó einhver myndi ná að komast yfir notandanafn og lykilorð hjá þér, nú eða bara giska rétt á það, þá kæmist viðkomandi ekki inn á reikninginn þinn þar sem viðkomandi hefur ekki aðgang að símanum þínum að auki. Lykilorðið virkar því sem fyrsti þáttur auðkenningar (1st factor) og tímabundni kóðinn (one time password eða OTP) sem annar þáttur (2nd factor).

Ég nota og mæli með [Authy](https://authy.com/download/) en það eru auðvitað fleiri; t.d. [Google Authenticator](https://support.google.com/accounts/answer/1066447?co=GENIE.Platform%3DiOS&hl=en) eða [Microsoft Authenticator](https://www.microsoft.com/en-us/p/microsoft-authenticator/9nblgggzmcj6).

## Efastu um allt <a name="scepticism">
Að lokum er mikilvægt að vera með hæfilegt magn af efasemdum þegar maður er á netinu. Ekki trúa öllu sem þú lest. Ekki smella á neitt sem lítur eitthvað furðulega út. Tölvupóstur, Facebook færsla, vefborði á vefsíðu eða hvað sem er. Yfirleitt er hægt að sjá eitthvað furðulegt þegar hættur eru annars vegar og oft betra að loka vafraglugganum eða henda tölvupóstinum frekar en taka sénsinn.

