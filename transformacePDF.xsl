<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:ks="urn:vse:dvof01:kalendarSoutezi">
    
    <!-- Define variables for colors -->
    <xsl:variable name="lightGrey">#D3D3D3</xsl:variable>
    <xsl:variable name="darkGrey">#A9A9A9</xsl:variable>
    
    <!-- Root template -->
    <xsl:template match="/">
        <fo:root language="cs">
            <fo:layout-master-set>
                <fo:simple-page-master master-name="page" page-height="11in" page-width="8.5in"
                    margin-top="0.5in" margin-bottom="0.5in" margin-left="0.5in"
                    margin-right="0.5in">
                    <fo:region-body margin-top="0.5in" margin-bottom="0.5in"/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            <fo:page-sequence master-reference="page">
                <fo:flow flow-name="xsl-region-body">
                    <!-- Call template to generate content -->
                    <xsl:call-template name="generateContent"/>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>
    
    <!-- Template to generate content -->
    <xsl:template name="generateContent">
        <fo:block font-size="16pt" font-weight="bold" text-align="center" margin-bottom="20pt">
            <xsl:text>Kalendář soutěží</xsl:text>
        </fo:block>
        <xsl:apply-templates select="//ks:soutez"/>
    </xsl:template>
    
    <!-- Template to process each competition -->
    <xsl:template match="ks:soutez">
        <fo:block margin-top="30pt" font-family="Arial Unicode MS">
            <fo:block font-size="14pt" font-weight="bold">
                <xsl:value-of select="ks:nazev"/>
            </fo:block>
            <fo:block font-size="12pt">
                <xsl:text>Datum: </xsl:text>
                <xsl:value-of select="ks:datum"/>
            </fo:block>
            <fo:block font-size="12pt">
                <xsl:text>Místo: </xsl:text>
                <xsl:value-of select="ks:adresa/ks:lokace"/>
                <xsl:text>, </xsl:text>
                <xsl:value-of select="ks:adresa/ks:ulice"/>
                <xsl:text>, </xsl:text>
                <xsl:value-of select="ks:adresa/ks:mesto"/>
                <xsl:text>, </xsl:text>
                <xsl:value-of select="ks:adresa/ks:psc"/>
            </fo:block>
            <fo:block font-size="12pt">
                <xsl:text>Začátek: </xsl:text>
                <xsl:value-of select="ks:harmonogram/ks:cas_zahajeni_souteze"/>
            </fo:block>
            <fo:block font-size="12pt">
                <xsl:text>Konec: </xsl:text>
                <xsl:value-of select="ks:harmonogram/ks:cas_konce_souteze"/>
            </fo:block>
            <fo:block font-size="12pt">
                <xsl:text>Termín pro přihlášení: </xsl:text>
                <xsl:value-of select="ks:termin_prihlaseni"/>
            </fo:block>
            <fo:block font-size="12pt">
                <xsl:text>Porota: </xsl:text>
                <xsl:for-each select="ks:porota/ks:porotce">
                    <xsl:value-of select="concat(ks:jmeno, ' ', ks:prijmeni)"/>
                    <xsl:if test="position() != last()">
                        <xsl:text>, </xsl:text>
                    </xsl:if>
                </xsl:for-each>
            </fo:block>
            <!-- Continue with additional details as needed -->
        </fo:block>
    </xsl:template>
    
</xsl:stylesheet>
