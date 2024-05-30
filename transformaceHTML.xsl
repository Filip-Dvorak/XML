<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:ks="urn:vse:dvof01:kalendarSoutezi" exclude-result-prefixes="ks" version="2.0">
    <xsl:output method="html" version="5" encoding="UTF-8"/>
    <xsl:output method="html" version="5" name="html5"/>

    <!-- Identity template: copy all elements and attributes to the output -->
    <xsl:template match="/">
            <xsl:apply-templates/>
    </xsl:template>

    <!-- Transform ks:kalendar_soutezi element into HTML -->
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

    <!-- Transform ks:soutez element into HTML table row with a link to detail page -->
    <xsl:template match="ks:soutez">
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

    <!-- Transform ks:soutez element into HTML table row with a link to detail page -->
    <xsl:template match="ks:soutez">
        <xsl:variable name="detailSouteze" select="concat(generate-id(), '.html')"/>
        <tr>
            <td>
                <a href="{$detailSouteze}">
                    <xsl:value-of select="ks:nazev"/>
                </a>
            </td>
            <td>
                <xsl:value-of select="ks:datum"/>
            </td>
            <td>
                <xsl:value-of select="concat(ks:adresa/ks:lokace,' - ', ks:adresa/ks:mesto)"/>
            </td>
        </tr>
        <!-- Generate separate HTML file for detailed information -->
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
                                <strong><xsl:value-of select="ks:datum"/></strong>
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
                                            select="ks:harmonogram/ks:cas_otevreni_salu"/>
                                    </li>
                                    <li>
                                        <strong>Zahájení soutěže: </strong>
                                        <xsl:value-of
                                            select="ks:harmonogram/ks:cas_zahajeni_souteze"/>
                                    </li>
                                    <li>
                                        <strong>Konec soutěže: </strong>
                                        <xsl:value-of
                                            select="ks:harmonogram/ks:cas_konce_souteze"/>
                                    </li>
                                </ul>
                            </td>
                        </tr>
                        <tr>
                            <th>Termín přihlášení</th>
                            <td>
                                <strong><i><xsl:value-of select="ks:termin_prihlaseni"/></i></strong>
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

    <!-- Transform ks:porotce element into HTML list item -->
    <xsl:template match="ks:porotce">
        <div class="porota">
            <ul>
                <li>
                    <xsl:value-of select="ks:jmeno"/> <xsl:text> </xsl:text> <xsl:value-of select="ks:prijmeni"/> <xsl:text> - </xsl:text> <xsl:value-of select="ks:mesto"/>
                </li>
            </ul>
        </div>
    </xsl:template>

    <!-- Transform ks:kategorie element into HTML list item -->
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

    <!-- Transform ks:par_id element into HTML table row -->
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
                <!-- Link to detail page -->
                <a href="{concat('detail_', $par_id, '.html')}">Detail</a>
            </td>
        </tr>
        <!-- Generate separate HTML file for each pair -->
        <xsl:result-document href="{concat('detail_', $par_id, '.html')}" format="html5">
            <html>
                <head>
                    <title>Detail páru</title>
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
                    </style>
                </head>
                <body>
                    <h2>Detail páru</h2>
                    <table>
                        <tr>
                            <th>Partner</th>
                            <th>Partnerka</th>
                            <th>Klub</th>
                        </tr>
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
                        </tr>
                    </table>
                    <img src="{$par/ks:partner/ks:foto/@src}"></img>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>

</xsl:stylesheet>
