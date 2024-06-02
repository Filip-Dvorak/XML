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
    <xsl:variable name="table.width">80%</xsl:variable>
    
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
            
            <!-- Content for separate page (obsah) -->
            <fo:page-sequence master-reference="a4" font-family="Calibri">
                <fo:static-content flow-name="xsl-region-before">
                    <fo:block font-size="12pt" text-align="right" margin-bottom="10pt">Soutěže</fo:block>
                </fo:static-content>
                <fo:flow flow-name="xsl-region-body">
                    <fo:block font-size="30pt" text-align="center" margin-bottom="10pt">Kalendář soutěží</fo:block>
                    <fo:block font-size="16pt" text-align="left" margin-bottom="20pt">Obsah</fo:block>
                    <!-- Generate links for each soutěž -->
                    <xsl:apply-templates select="//ks:soutez" mode="content" />
                </fo:flow>
            </fo:page-sequence>
            <!-- Content for separate pages for each soutěž -->
            <xsl:apply-templates select="//ks:soutez" mode="soutez" />
        </fo:root>
    </xsl:template>
        
    <!-- Template for generating separate pages for each soutěž -->
    <xsl:template match="ks:soutez" mode="soutez">
        <fo:page-sequence master-reference="a4" font-family="Calibri">
            <xsl:attribute name="id">
                <xsl:value-of select="concat('soutez_', position())"/>
            </xsl:attribute>
            <fo:static-content flow-name="xsl-region-before">
                <fo:block font-size="12pt" text-align="right" margin-bottom="10pt">Soutěže</fo:block>
            </fo:static-content>
            <fo:static-content flow-name="xsl-region-after">
                <fo:block font-size="10pt" text-align="center" margin-top="10pt">
                    <fo:page-number/>
                </fo:block>
            </fo:static-content>
            <fo:flow flow-name="xsl-region-body">
                <fo:block font-size="20pt" text-align="center" margin-bottom="20pt">
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
                        <fo:table-column column-width="35%"/>
                        <fo:table-column column-width="35%"/>
                        <fo:table-column column-width="40%"/>
                        <fo:table-header>
                            <fo:table-row>
                                
                                <fo:table-cell padding="5pt" border-width="1pt" border-style="solid" border-color="black" font-weight="bold">
                                    <fo:block>Partner</fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="5pt" border-width="1pt" border-style="solid" border-color="black" font-weight="bold">
                                    <fo:block>Partnerka</fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="5pt" border-width="1pt" border-style="solid" border-color="black" font-weight="bold">
                                    <fo:block>Fotky</fo:block>
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
                                            <fo:block><xsl:value-of select="ks:partner/ks:jmeno" /> <xsl:text> </xsl:text> <xsl:value-of select="ks:partner/ks:prijmeni"/></fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell padding="5pt" border-width="1pt" border-style="solid" border-color="black">
                                            <fo:block><xsl:value-of select="ks:partnerka/ks:jmeno" /> <xsl:text> </xsl:text> <xsl:value-of select="ks:partnerka/ks:prijmeni"/></fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell padding="5pt" border-width="1pt" border-style="solid" border-color="black">
                                            <fo:block> 
                                                <xsl:apply-templates select="ks:partner/ks:foto"></xsl:apply-templates>  
                                                <xsl:apply-templates select="ks:partnerka/ks:foto"></xsl:apply-templates>
                                            </fo:block>
                                        </fo:table-cell>
                                        
                                        
                                    </fo:table-row>
                                </xsl:for-each>
                            </xsl:for-each>
                        </fo:table-body>
                    </fo:table>
                </fo:block>
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>
    
    <xsl:template match="ks:partner/ks:foto">
        <fo:external-graphic src="url('{@src}')" content-width="80px" content-height="80px" padding-right="10px"/>
    </xsl:template>
    
    <xsl:template match="ks:partnerka/ks:foto">
        <fo:external-graphic src="url('{@src}')" content-width="80px" content-height="80px"/>
    </xsl:template>
    
    <!-- Template for generating links in the content -->
    <xsl:template match="ks:soutez" mode="content">
        <fo:block margin-bottom="10pt" font-weight="600" margin-left="5pt" text-align="justify" text-align-last="justify">
            <fo:basic-link internal-destination="{concat('soutez_', position())}">
                <xsl:value-of select="ks:nazev"/>
                <fo:leader leader-pattern="dots"/>
                <fo:page-number-citation ref-id="{concat('soutez_', position())}"/>
            </fo:basic-link>
        </fo:block>
    </xsl:template>
    
</xsl:stylesheet>
