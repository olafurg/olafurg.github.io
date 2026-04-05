---
title: Grunnöryggi tölvupósts — SPF, DKIM og DMARC
slug: grunnoryggi-tolvuposts
date: 2026-04-04 20:00 UTC
author: Ólafur Guðmundsson
lang: is
tags: email, dns, security
draft: true
---

Það er lítið mál að setja upp tölvupóst fyrir lénið sitt með t.d. Microsoft 365 eða Google Workspace en það vantar oft að klára nokkrar grunnstillingar til að gera uppsetninguna örugga. Vandamálið er þetta: án réttra stillinga getur hver sem er þóst vera hver sem er. Og ef þitt lén er ekki rétt stillt geta óprúttnir aðilar misnotað það og orsakað að réttmætur póstur frá þér komist ekki til skila eða komið þér á ruslpóstlista. Þetta er oft ástæðan fyrir svindlpóstum _(e. phishing)_, fölsuðum sendundum _(e. spoofing)_ og öðru rusli sem við könnumst við.

Til þess að setja upp grunnvörn gegn þessu öllu þarf þrjár DNS færslur: **SPF**, **DKIM** og **DMARC**. Þær vinna saman og hver og ein einungis virkilega gagnleg þegar hinar eru líka til staðar.

1. [SPF — Hver má senda?](#spf)
1. [DKIM — Er innihaldið óbreytt?](#dkim)
1. [DMARC — Hvað á að gera ef eitthvað fer úrskeiðis?](#dmarc)
1. [Hvernig þetta vinnur saman](#saman)
1. [Bónus: MTA-STS, TLS-RPT og BIMI](#bonus)

## SPF — Hver má senda? <a name="spf"></a>

SPF stendur fyrir _Sender Policy Framework_. DNS-færsluna sem segir heiminum hvaða netþjónar hafa leyfi til að senda tölvupóst fyrir hönd lénsins þíns.

Segjum að lénið þitt sé `fyrirtaeki.is`. Þú setur inn TXT-færslu á lénið sem lítur einhvern veginn svona út:

```
v=spf1 include:_spf.google.com include:spf.protection.outlook.com -all
```

Þetta segir: „Tölvupóstur frá `fyrirtaeki.is` kemur annað hvort frá Google eða Microsoft þjónum. Allt annað er falsað."

Þegar einhver fær tölvupóst sem segist koma frá `fyrirtaeki.is` þá athugar póstþjónninn hjá móttakandanum SPF-færsluna og ber saman við netfangið sem sendi póstinn. Ef það passar ekki er líklega eitthvað að.

**Algengar gryfjur:**

- SPF athugar aðeins `envelope from` sendandann (svokallað `MAIL FROM` í SMTP), ekki `From:` hausinn sem notandinn sér. Þannig ein og sér er SPF ekki alveg nóg.
- Það mega hámark vera 10 DNS-uppflettingar í SPF færslunni. Ef þú ert með margar þjónustur sem senda póst fyrir þig (markaðstól, þjónustuborð, o.s.frv.) er auðvelt að fara yfir þetta hámark og þá hættir SPF að virka.

## DKIM — Er innihaldið óbreytt? <a name="dkim"></a>


DKIM stendur fyrir [_DomainKeys Identified Mail_](https://en.wikipedia.org/wiki/DomainKeys_Identified_Mail) og snýst um stafræna undirritun. Þegar tölvupóstur er sendur frá þínum þjóni er bætt við hann sérstökum haus _(e. header)_ sem inniheldur stafræna undirritun á ákveðnum hlutum póstsins.

Opinberi lykillinn _(e. public key)_ til að staðfesta undirritunina er birtur sem DNS-færsla á léninu. Þannig getur póstþjónn móttakandans athugað hvort:

1. Pósturinn kom virkilega frá aðila sem hefur aðgang að einkalyklinum _(e. private key)_ fyrir lénið.
2. Innihald póstsins hafi nokkuð verið breytt á leiðinni _(e. integrity)_.

DNS-færslan lítur nokkurn veginn svona út og er sett á `selector._domainkey.fyrirtaeki.is`:

```
v=DKIM1; k=rsa; p=MIIBIjANBgkqh...langur lykill hér
```

DKIM er frábært en segir ekkert um hvað á að *gera* ef undirritun vantar eða er ógild. Þar kemur DMARC inn í myndina.

## DMARC — Hvað á að gera ef eitthvað fer úrskeiðis? <a name="dmarc"></a>

DMARC stendur fyrir _Domain-based Message Authentication, Reporting and Conformance_. Þetta er lagið sem tengir SPF og DKIM saman og bætir við tveim mikilvægum pörtum:

1. **Stefnu _(e. policy)_** — hvað á móttakandinn að gera við póst sem fellur á prófunum? Þrír möguleikar:
    - `none` — ekki gera neitt sérstakt, bara senda mér skýrslur (gott til að byrja með).
    - `quarantine` — setja í ruslpóst _(e. spam/junk)_.
    - `reject` — hafna póstinum alfarið.

2. **Skýrslugerð _(e. reporting)_** — DMARC biður móttakendur um að senda þér skýrslur um hvað gerðist við póst frá léninu þínu. Þannig sérðu hvort einhver er að falsa póst frá þér og getur lagað vandamál.

DNS-færslan er sett á `_dmarc.fyrirtaeki.is` og lítur svona út:

```
v=DMARC1; p=reject; rua=mailto:dmarc-reports@fyrirtaeki.is; pct=100
```

**Mikilvægt:** DMARC athugar svokallað _alignment_ — þ.e. hvort lénið sem SPF eða DKIM staðfesta passi við `From:` hausinn sem notandinn sér. Þetta er lykilatriðið sem SPF ein og sér nær ekki til.

## Hvernig þetta vinnur saman <a name="saman"></a>

Þegar tölvupóstur berst frá `fyrirtaeki.is` gerist eftirfarandi hjá móttakandanum:

1. Póstþjónninn athugar **SPF** — kom þessi póstur frá leyfilegum þjóni?
2. Póstþjónninn athugar **DKIM** — er gild stafræn undirritun til staðar?
3. Póstþjónninn athugar **DMARC** — passar SPF eða DKIM við `From:` lénið? Ef ekki, hvað segir reglan?

Til að standast DMARC þarf pósturinn að standast **annað hvort** SPF eða DKIM, *og* viðkomandi þarf að vera í _alignment_ við `From:` lénið. Þannig þarf ekki bæði að virka, en betra er að hafa hvort tveggja rétt stillt til að vera viss.

Góð nálgun er að byrja á reglunni `p=none` til að safna skýrslum og sjá hvernig tölvupósturinn þinn lítur út utanfrá, laga það sem þarf að laga, hækka svo í `quarantine` og að lokum `reject`.

## Bónus: BIMI, MTA-STS og TLS-RPT <a name="bonus"></a>

Þessar þrjár viðbótarstillingar tel ég sem bónus. Þær eru oft ónauðsynlegar en geta verið gagnlegar fyrir einhverja.

**BIMI** _(Brand Indicators for Message Identification)_ — gerir þér kleift að birta merki fyrirtækisins þíns við hliðina á tölvupóstinum í innhólfi móttakandans. Þetta krefst þess að DMARC sé á `quarantine` eða `reject`, þannig grunnatriðin þurfa að vera í lagi áður en hægt er að nýta sér þetta. Gott fyrir vörumerkjaútlit og eykur traust hjá viðtakendum.

**MTA-STS** _(Mail Transfer Agent Strict Transport Security)_ — krefst þess að tölvupóstur sé sendur yfir dulkóðaða tengingu (TLS) milli póstþjóna. Án þessa getur verið að póstur sé sendur ódulkóðaður milli þjóna þó báðir styðji TLS, vegna svokallaðra _downgrade attacks_. Ef þú vilt tryggja að enginn geti hlustað á póstinn á leiðinni er þetta mikilvægt.

**TLS-RPT** _(TLS Reporting)_ — vinnur með MTA-STS og sendir þér skýrslur um TLS-tengingar við póstþjóninn þinn. Ef eitthvað er að dulkóðuninni eða einhver er að reyna eitthvað þá sérðu það í skýrslunum.

---

Flest þessara atriða snúa að DNS-færslum sem eru birtar opinberlega og leiðbeina öðrum póstþjónum um hvernig eigi að meðhöndla tölvupóst frá léninu þínu. Ef þú ert í vafa um stöðu lénsins þíns þá eru til góð tól eins og [MXToolbox](https://mxtoolbox.com/) og [Dmarcian](https://dmarcian.com/) sem geta athugað hvernig þessu er háttað hjá þér. Sömuleiðis bjóða margir tölvupóstveitendur upp á auðveldar leiðbeiningar til að setja þetta upp, svo það er yfirleitt ekki eins flókið og það kann að hljóma.

Yfirlit um uppsetningu á þessum stillingum fyrir mismunandi þjónustuaðila er t.d. hér: [DMARC.wiki](https://dmarc.wiki/)

Takk fyrir lesturinn.
