<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:ks="urn:vse:dvof01:kalendarSoutezi" exclude-result-prefixes="ks" version="2.0">
    <xsl:output method="html" version="5" encoding="UTF-8"/>
    <xsl:output method="html" version="5" name="html5"/>

    <!-- Root xml -->
    <xsl:template match="/">
            <xsl:apply-templates/>
    </xsl:template>

    <!-- Hlavni stranka kalendare -->
    <xsl:template match="ks:kalendar_soutezi">
        <html>
            <head>
                <title>Kalendář soutěží</title>
                <style>
                    body {
                        font-family: Arial, sans-serif;
                    }
                    h1 {
                        color: navy;
                    }
                    table {
                        border-collapse: collapse;
                        width: 100%;
                    }
                    th,
                    td {
                        border: 1px solid #dddddd;
                        text-align: left;
                        padding: 8px;
                    }
                    th {
                        background-color: #f2f2f2;
                    }
                    a {
                        text-decoration: none;
                        color: blue;
                    }
                    a:hover {
                        text-decoration: underline;
                    }</style>
            </head>
            <body>
                <h1>Kalendář soutěží</h1>
                <table>
                    <thead>
                        <tr>
                            <th>Soutěž</th>
                            <th>Datum</th>
                            <th>Místo konání</th>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:apply-templates select="ks:soutez"/>
                    </tbody>
                </table>
            </body>
        </html>
    </xsl:template>


    <!-- Vytvoření jednotlivých záznamů pro každou soutěž  -->
    <xsl:template match="ks:soutez">
        <xsl:variable name="detailSouteze" select="concat(generate-id(), '.html')"/>
        <tr>
            <td>
                <a href="{$detailSouteze}">
                    <xsl:value-of select="ks:nazev"/>
                </a>
            </td>
            <td>
                <xsl:value-of select="format-date(ks:datum,'[D]. [M]. [Y]')"/>
            </td>
            <td>
                <xsl:value-of select="concat(ks:adresa/ks:lokace,' - ', ks:adresa/ks:mesto)"/>
            </td>
        </tr>
        
        <!-- Vygenerovani html souboru pro každou soutěž -->
        <xsl:result-document href="{$detailSouteze}" format="html5">
            <html>
                <head>
                    <title>
                        <xsl:value-of select="ks:nazev"/>
                    </title>
                    <style>
                        body {
                            font-family: Arial, sans-serif;
                        }
                        h2 {
                            color: #006400;
                        }
                        table {
                            border-collapse: collapse;
                            width: 100%;
                        }
                        th,
                        td {
                            border: 1px solid #dddddd;
                            text-align: left;
                            padding: 8px;
                        }
                        th {
                            background-color: #f2f2f2;
                        }
                        strong {
                            color: #800000;
                        }
                        ul {
                            list-style-type: none;
                        }
                        .porota ul{ 
                                list-style: circle;
                        }
                    </style>
                </head>
                <body>
                    <h2>
                        <xsl:value-of select="ks:nazev"/>
                    </h2>
                    <table>
                        <tr>
                            <th>Datum</th>
                            <td>
                                <strong><xsl:value-of select="format-date(ks:datum, '[D]. [M]. [Y]')"/></strong>
                            </td>
                        </tr>
                        <tr>
                            <th>Adresa</th>
                            <td>
                                <strong><xsl:value-of
                                    select="concat(ks:adresa/ks:lokace, ', ', ks:adresa/ks:ulice, ' ', ks:adresa/ks:cislo_popisne, ', ', ks:adresa/ks:mesto, ' ', ks:adresa/ks:psc)"
                                /></strong>
                            </td>
                        </tr>
                        <tr>
                            <th>Harmonogram</th>
                            <td>
                                <ul>
                                    <li>
                                        <strong>Otevření sálu: </strong>
                                        <xsl:value-of
                                            select="format-time(ks:harmonogram/ks:cas_otevreni_salu,'[H01]:[m01]')"/>
                                    </li>
                                    <li>
                                        <strong>Zahájení soutěže: </strong>
                                        <xsl:value-of
                                            select="format-time(ks:harmonogram/ks:cas_zahajeni_souteze,'[H01]:[m01]')"/>
                                    </li>
                                    <li>
                                        <strong>Konec soutěže: </strong>
                                        <xsl:value-of
                                            select="format-time(ks:harmonogram/ks:cas_konce_souteze,'[H01]:[m01]')"/>
                                    </li>
                                </ul>
                            </td>
                        </tr>
                        <tr>
                            <th>Termín přihlášení</th>
                            <td>
                                <strong><i><xsl:value-of select="format-dateTime(ks:termin_prihlaseni,' [M]. [D]. [Y],  [H01]:[m01] ')"/></i></strong>
                            </td>
                        </tr>
                        <tr>
                            <th>Porota</th>
                            <td>
                                <ul>
                                    <xsl:apply-templates select="ks:porota/ks:porotce"/>
                                </ul>
                            </td>
                        </tr>
                        <tr>
                            <th>Kategorie</th>
                            <td>
                                <ul>
                                    <xsl:apply-templates select="ks:kategorie"/>
                                </ul>
                            </td>
                        </tr>
                    </table>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>

    <!-- Sekce poroty -->
    <xsl:template match="ks:porotce">
        <div class="porota">
            <ul>
                <li>
                    <xsl:value-of select="ks:jmeno"/> <xsl:text> </xsl:text> <xsl:value-of select="ks:prijmeni"/> <xsl:text> - </xsl:text> <xsl:value-of select="ks:mesto"/>
                </li>
            </ul>
        </div>
    </xsl:template>

    <!-- Sekce kategorii-->
    <xsl:template match="ks:kategorie">
        <li>
            <strong>Typ: </strong>
            <xsl:value-of select="@typ"/>
            <strong>Věková kategorie: </strong>
            <xsl:value-of select="ks:vekova_kategorie"/>
            <strong>Třída: </strong>
            <xsl:value-of select="ks:vykonostni_trida"/>
            <strong>Disciplina: </strong>
            <xsl:value-of select="ks:disciplina"/>
            <table>
                <thead>
                    <tr>
                        <th>Partner</th>
                        <th>Partnerka</th>
                        <th>Klub</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <xsl:apply-templates select="ks:prihlasene_pary/ks:par_id"/>
                </tbody>
            </table>
        </li>
    </xsl:template>

    <!-- Zaplnění tabulek kategorii soutěžícími s koresponudjícím par_id -->
    <xsl:template match="ks:par_id">
        <xsl:variable name="par_id" select="."/>
        <xsl:variable name="par" select="//ks:pary/ks:par[@id = $par_id]"/>
        <tr>
            <td>
                <xsl:value-of select="$par/ks:partner/ks:jmeno"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="$par/ks:partner/ks:prijmeni"/>
            </td>
            <td>
                <xsl:value-of select="$par/ks:partnerka/ks:jmeno"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="$par/ks:partnerka/ks:prijmeni"/>
            </td>
            <td>
                <xsl:value-of select="$par/ks:klub"/>
            </td>
            <td>
                <a href="{concat('detail_', $par_id, '.html')}">Detail</a>
            </td>
        </tr>
        
        <!-- Vygenerovaní html dokumentu pro každý pár -->
        <xsl:result-document href="{concat('detail_', $par_id, '.html')}" format="html5">
            <html lang="cs">
            <head>
                <title>Detail</title>
                
                <style>.home-container {
                    width: 100%;
                    display: flex;
                    min-height: 100vh;
                    align-items: center;
                    flex-direction: column;
                    justify-content: center;
                    }
                    .home-container1 {
                    top: 30%;
                    right: 25%;
                    width: 483px;
                    height: 849px;
                    display: flex;
                    position: absolute;
                    align-self: center;
                    align-items: center;
                    flex-direction: column;
                    justify-content: center;
                    }
                    .home-image {
                    top: 0px;
                    left: 0px;
                    right: 0px;
                    width: 200px;
                    position: absolute;
                    object-fit: cover;
                    margin-left: auto;
                    margin-right: auto;
                    margin-bottom: auto;
                    }
                    .home-text {
                    padding-bottom: 5px;
                    }
                    .home-text1 {
                    padding-bottom: 5px;
                    }
                    .home-text2 {
                    padding-bottom: 5px;
                    }
                    .home-container2 {
                    top: 30%;
                    left: 25%;
                    width: 483px;
                    height: 849px;
                    display: flex;
                    position: absolute;
                    align-self: center;
                    align-items: center;
                    flex-direction: column;
                    justify-content: center;
                    }
                    .home-image1 {
                    top: 0px;
                    left: 0px;
                    right: 0px;
                    width: 200px;
                    position: absolute;
                    object-fit: cover;
                    margin-left: auto;
                    margin-right: auto;
                    margin-bottom: auto;
                    }
                    .home-text3 {
                    padding-bottom: 5px;
                    }
                    .home-text4 {
                    padding-bottom: 5px;
                    }
                    .home-text5 {
                    padding-bottom: 5px;
                    }
                </style>
            </head>
            <body>
                
                <div class="home-container">
                    <div class="home-con tainer1">
                        <img
                            src="{$par/ks:partnerka/ks:foto/@src}"
                            alt="image"
                            class="home-image"
                        />
                        <span class="home-text"><xsl:value-of select="$par/ks:partnerka/ks:jmeno"/></span>
                        <span class="home-text1"><xsl:value-of select="$par/ks:partnerka/ks:prijmeni"/></span>
                        <span class="home-text2"><xsl:value-of select="$par/ks:partnerka/ks:email"/></span>
                    </div>
                    <div class="home-container2">
                        <img
                            src="{$par/ks:partner/ks:foto/@src}"
                            alt="image"
                            class="home-image1"
                        />
                        <span class="home-text3"><xsl:value-of select="$par/ks:partner/ks:jmeno"/></span>
                        <span class="home-text4"><xsl:value-of select="$par/ks:partner/ks:prijmeni"/></span>
                        <span class="home-text5"><xsl:value-of select="$par/ks:partner/ks:email"/></span>
                    </div>
                </div>
            </body>
            </html>
        </xsl:result-document>
    </xsl:template>

</xsl:stylesheet>
