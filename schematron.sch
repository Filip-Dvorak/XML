<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron"
    xmlns:ks="urn:vse:dvof01:kalendarSoutezi"
    queryBinding="xslt2">
    <sch:ns uri="urn:vse:dvof01:kalendarSoutezi" prefix="ks"/>
    
    <sch:pattern id="CasZahajeniPoOtevreni">
        <sch:rule context="ks:kalendar_soutezi/ks:soutez">
            <sch:assert test="xs:time(ks:harmonogram/ks:cas_zahajeni_souteze) &gt; xs:time(ks:harmonogram/ks:cas_otevreni_salu)">
                Čas zahájení soutěže musí být později než čas otevření sálu.
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="CasKonecPoZahajeni">
        <sch:rule context="ks:kalendar_soutezi/ks:soutez">
            <sch:assert test="xs:time(ks:harmonogram/ks:cas_konce_souteze) &gt; xs:time(ks:harmonogram/ks:cas_zahajeni_souteze)">
                Čas konce soutěže musí být pozdějí než čas zahájení.
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="TerminPrihlaseniPredTerminemSouteze">
        <sch:rule context="ks:kalendar_soutezi/ks:soutez">
            <sch:let name="termin_prihlaseni_date" value="substring(ks:termin_prihlaseni, 1, 10)"/>
            <sch:let name="datum_date" value="ks:datum"/>
            <sch:assert test="$termin_prihlaseni_date &lt; $datum_date">
                Čas přihlášení musí být před časem zahájení soutěže.
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="JenParyZeSeznamu">
        <sch:rule context="ks:prihlasene_pary/ks:par_id">
            <sch:assert test="//ks:pary/ks:par[@id=current()]" >Jen páry se seznamu se můžou účastnit soutěží.</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="Spravnatrida">
        <sch:rule context="ks:prihlasene_pary/ks:par_id">
            <sch:let name="typ" value="../../@typ"></sch:let>
            <sch:let name="trida" value="//ks:pary/ks:par[@id=current()]/ks:trida"></sch:let>
            <sch:assert test="(../../ks:vykonostni_trida = $trida and not($typ = 'liga')) or ($typ = 'liga')" >Soutěže se mohou účastnit jen páry se odpovídající třídou.</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="datumNarozeni">
        <sch:rule context="ks:par">
            <sch:assert test="(xs:date(current-date()) &gt; xs:date(ks:partner/ks:datum_narozeni)) and (xs:date(current-date()) &gt; xs:date(ks:partnerka/ks:datum_narozeni))">
                Datum narození nesmí být v budoucnosti
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
</sch:schema>

