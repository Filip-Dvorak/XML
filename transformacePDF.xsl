<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:ks="urn:vse:dvof01:kalendarSoutezi"
    exclude-result-prefixes="xs ks"
    version="2.0">
    
    <xsl:output method="xml"/>
    
    <!-- Define variables for margins and column widths -->
    <xsl:variable name="page.width">210mm</xsl:variable>
    <xsl:variable name="page.height">297mm</xsl:variable>
    <xsl:variable name="table.width">100%</xsl:variable>
    
    <!-- Define the layout for the page -->
    <xsl:template match="/">
        <fo:root>
            <fo:layout-master-set>
                <fo:simple-page-master master-name="a4" page-width="{$page.width}" page-height="{$page.height}" margin="15mm">
                    <fo:region-body margin-bottom="15mm" margin-top="15mm"/>
                    <fo:region-before extent="10mm"/>
                    <fo:region-after extent="10mm"/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            <fo:page-sequence master-reference="a4" font-family="Calibri">
                <fo:static-content flow-name="xsl-region-before">
                    <fo:block font-size="12pt" text-align="right" margin-bottom="10pt">Soutěže</fo:block>
                </fo:static-content>
                <fo:static-content flow-name="xsl-region-after">
                    <fo:block font-size="10pt" text-align="center" margin-top="10pt">
                        <fo:page-number/>
                    </fo:block>
                </fo:static-content>
                <fo:flow flow-name="xsl-region-body">
                    <fo:block font-size="20pt" text-align="center" margin-bottom="20pt">Kalendář soutěží</fo:block>
                    <!-- Iterate over each soutěž element -->
                    <xsl:apply-templates select="//ks:soutez" />
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>
    
    <!-- Define template for soutěž elements -->
    <xsl:template match="ks:soutez">
        <fo:block margin-top="20pt">
            <fo:block font-size="16pt" font-weight="bold">
                <xsl:value-of select="ks:nazev" />
            </fo:block>
            <fo:block margin-top="10pt">
                Datum: <xsl:value-of select="ks:datum" />
            </fo:block>
            <fo:block>
                Adresa: <xsl:value-of select="ks:adresa/ks:lokace" />, <xsl:value-of select="ks:adresa/ks:ulice" /> <xsl:value-of select="ks:adresa/ks:cislo_popisne" />, <xsl:value-of select="ks:adresa/ks:mesto" /> <xsl:value-of select="ks:adresa/ks:psc" />
            </fo:block>
            <fo:block>
                Termín přihlášení: <xsl:value-of select="ks:termin_prihlaseni" />
            </fo:block>
            <fo:block margin-top="10pt">
                <fo:table table-layout="fixed" width="{$table.width}" border-collapse="collapse">
                    <fo:table-column column-width="15%"/>
                    <fo:table-column column-width="35%"/>
                    <fo:table-column column-width="50%"/>
                    <fo:table-header>
                        <fo:table-row>
                            <fo:table-cell padding="5pt" border-width="1pt" border-style="solid" border-color="black" font-weight="bold">
                                <fo:block>ID</fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding="5pt" border-width="1pt" border-style="solid" border-color="black" font-weight="bold">
                                <fo:block>Jméno</fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding="5pt" border-width="1pt" border-style="solid" border-color="black" font-weight="bold">
                                <fo:block>Příjmení</fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </fo:table-header>
                    <fo:table-body>
                        <!-- Iterate over each participant in the category -->
                        <xsl:for-each select="ks:kategorie/ks:prihlasene_pary/ks:par_id">
                            <xsl:variable name="par_id" select="." />
                            <xsl:for-each select="//ks:pary/ks:par[@id = $par_id]">
                                <fo:table-row>
                                    <fo:table-cell padding="5pt" border-width="1pt" border-style="solid" border-color="black">
                                        <fo:block><xsl:value-of select="ks:partner/ks:idt" /></fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell padding="5pt" border-width="1pt" border-style="solid" border-color="black">
                                        <fo:block><xsl:value-of select="ks:partner/ks:jmeno" /></fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell padding="5pt" border-width="1pt" border-style="solid" border-color="black">
                                        <fo:block><xsl:value-of select="ks:partner/ks:prijmeni" /></fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                            </xsl:for-each>
                        </xsl:for-each>
                    </fo:table-body>
                </fo:table>
            </fo:block>
        </fo:block>
    </xsl:template>
    
</xsl:stylesheet>
