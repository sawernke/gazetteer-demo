<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs t" version="2.0">
    
    <!-- ================================================================== 
       Copyright 2013 New York University
       
       This file is part of the Syriac Reference Portal Places Application.
       
       The Syriac Reference Portal Places Application is free software: 
       you can redistribute it and/or modify it under the terms of the GNU 
       General Public License as published by the Free Software Foundation, 
       either version 3 of the License, or (at your option) any later 
       version.
       
       The Syriac Reference Portal Places Application is distributed in 
       the hope that it will be useful, but WITHOUT ANY WARRANTY; without 
       even the implied warranty of MERCHANTABILITY or FITNESS FOR A 
       PARTICULAR PURPOSE.  See the GNU General Public License for more 
       details.
       
       You should have received a copy of the GNU General Public License
       along with the Syriac Reference Portal Places Application.  If not,
       see (http://www.gnu.org/licenses/).
       
       ================================================================== --> 
    
    <!-- ================================================================== 
       link-icons.xsl
       
       This XSLT is meant to be called from placepage.xsl in order to 
       generate "chicklet" link icons to e.g. Pleiades and Wikipedia. 
       
       parameters:
       
       code by: 
        + Tom Elliott (http://www.paregorios.org) 
          for the Institute for the Study of the Ancient World, New York
          University, under contract to Vanderbilt University for the
          NEH-funded Syriac Reference Portal project.
       code ammended by:
        + Winona Salesky for use with eXist-db
          
       funding provided by:
        + National Endowment for the Humanities (http://www.neh.gov). Any 
          views, findings, conclusions, or recommendations expressed in 
          this code do not necessarily reflect those of the National 
          Endowment for the Humanities.
       
       ================================================================== -->  
    
    <!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
     template: name=link-icons
     emit the link icons div and its contents
     ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++  -->
    <xsl:template name="link-icons">
        <xsl:variable name="resource-uri" select="//t:idno[contains(.,$base-uri)][1]"/>
        <xsl:variable name="id" select="tokenize(replace($resource-uri[1],'/tei',''),'/')[last()]"/>
        <xsl:variable name="link-title">
            <xsl:choose>
                <xsl:when test="//t:place">
                    <xsl:value-of select="//t:place/t:placeName[@xml:lang='en'][1]"/>
                </xsl:when>
                <xsl:when test="//t:person">
                    <xsl:value-of select="//t:person/t:persName[@xml:lang='en'][1]"/>
                </xsl:when>
            </xsl:choose>
        </xsl:variable>
        <div id="link-icons" class="col-md-4 text-right">
            <!-- Pleiades links -->
            <xsl:for-each select="//descendant::t:idno[contains(.,'pleiades')]">
                <a href="{normalize-space(.)}">
                    <img src="$app-root/resources/img/circle-pi-25.png" alt="Image of the Greek letter pi in blue; small icon of the Pleiades project" title="click to view {link-title} in Pleiades"/>
                </a>
            </xsl:for-each>
            <!-- Wikipedia links -->
            <xsl:for-each select="//descendant::t:idno[contains(.,'wikipedia')]">
                <xsl:variable name="get-title">
                    <xsl:value-of select="replace(tokenize(.,'/')[last()],'_',' ')"/>
                </xsl:variable>
                <a href="{normalize-space(.)}">
                    <img src="$app-root/resources/img/Wikipedia-25.png" alt="The Wikipedia icon" title="click to view {$get-title} in Wikipedia"/>
                </a>
            </xsl:for-each>
            
            <!-- Google map links 
            <xsl:for-each select="//descendant::t:location[@type='gps']/t:geo">
                <a href="https://maps.google.com/maps?f=q&amp;hl=en&amp;z=4&amp;q=http://syriaca.org/place/{$id}/atom">
                    <img src="/exist/apps/srophe/resources/img/gmaps-25.png" alt="The Google Maps icon" title="click to view {$link-title} on Google Maps"/>
                </a>
            </xsl:for-each>
            -->
            
            <!-- TEI source link -->
            <a href="{$resource-uri}/tei" rel="alternate" type="application/tei+xml">
                <img src="$app-root/resources/img/tei-25.png" alt="The Text Encoding Initiative icon" title="click to view the TEI XML source data for this place"/>
            </a>
            <!-- NOTE: need to restructure geo? or just add atom to persons? -->
            <!-- Atom format link -->
            <a href="{$resource-uri}/atom" rel="alternate" type="application/atom+xml">
                <img src="$app-root/resources/img/atom-25.png" alt="The Atom format icon" title="click to view this data in Atom XML format"/>
            </a>
            <!-- Print link -->
            <a href="javascript:window.print();">
                <img src="$app-root/resources/img/icons-print.png" alt="The Print format icon" title="click to send this page to the printer"/>
            </a>
        </div>
    </xsl:template>
    
    <!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
     template: name=link-icons-text
     emit the link icons div and its contents as a bulleted list
     ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
    <xsl:template name="link-icons-text">
        <xsl:variable name="resource-id" select="tokenize(replace(//t:idno[contains(.,$base-uri)][1],'/tei',''),'/')[last()]"/>
        <xsl:variable name="resource-uri">
            <xsl:choose>
                <xsl:when test="//t:place">
                    <xsl:value-of select="concat('/place/',$resource-id)"/>
                </xsl:when>
                <xsl:when test="//t:person">
                    <xsl:value-of select="concat('/persons/',$resource-id)"/>
                </xsl:when>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="link-title">
            <xsl:choose>
                <xsl:when test="//t:place">
                    <xsl:value-of select="//t:place/t:placeName[@xml:lang='en'][1]"/>
                </xsl:when>
                <xsl:when test="//t:person">
                    <xsl:value-of select="//t:person/t:persName[@xml:lang='en'][1]"/>
                </xsl:when>
            </xsl:choose>
        </xsl:variable>
        <div id="see-also" class="well">
            <h3>See Also</h3>
            <ul>
                <xsl:for-each select="t:idno[contains(.,'csc.org.il')]">
                    <li>
                        <a href="{normalize-space(.)}"> "<xsl:value-of select="substring-before(substring-after(normalize-space(.),'sK='),'&amp;sT=')"/>" in the Comprehensive Bibliography on Syriac Christianity</a>
                    </li>
                </xsl:for-each>
                <!--NOTE: TEMPORARY for demonstration -->
                <xsl:for-each select="//t:idno[contains(.,'www.epigraphy.ca')]">
                    <li>
                        <a href="{normalize-space(.)}">1 Inscription from Mosul at the Canadian Centre for Epigraphic Documents</a>
                    </li>
                </xsl:for-each>
                <!-- WorldCat Identities -->
                <xsl:for-each select="t:idno[contains(.,'http://worldcat.org/identities')]">
                    <li>
                        <a href="{normalize-space(.)}"> "<xsl:value-of select="substring-after(.,'http://worldcat.org/identities/')"/>" in WorldCat Identities</a>
                    </li>
                </xsl:for-each>
                <!-- VIAF -->
                <xsl:for-each select="t:idno[contains(.,'http://viaf.org/')]">
                    <li>
                        <a href="{normalize-space(.)}">VIAF</a>
                    </li>
                </xsl:for-each>
                <!-- Pleiades links -->
                <xsl:for-each select="t:idno[contains(.,'pleiades')]">
                    <li>
                        <a href="{normalize-space(.)}">
                            <img src="$app-root/resources/img/circle-pi-25.png" alt="Image of the Greek letter pi in blue; small icon of the Pleiades project" title="click to view {$link-title} in Pleiades"/> View in Pleiades</a>
                    </li>
                </xsl:for-each>
                <!-- Google map links 
                <xsl:for-each select="t:location[@type='gps']/t:geo">
                    <li>
                        <xsl:variable name="geoRef">
                            <xsl:variable name="coords" select="tokenize(normalize-space(.), '\s+')"/>
                            <xsl:value-of select="$coords[2]"/>
                            <xsl:text>, </xsl:text>
                            <xsl:value-of select="$coords[1]"/>
                        </xsl:variable>
                        <a href="https://maps.google.com/maps?f=q&amp;hl=en&amp;z=4&amp;q=http://syriaca.org/place/{$resource-id}/atom">
                            <img src="/exist/apps/srophe/resources/img/gmaps-25.png" alt="The Google Maps icon" title="click to view {$link-title} on Google Maps"/> View in Google Maps</a>
                    </li>
                </xsl:for-each>
                -->
                
                <!-- TEI source link -->
                <li>
                    <a href="{$resource-uri}/tei" rel="alternate" type="application/tei+xml">
                        <img src="$app-root/resources/img/tei-25.png" alt="The Text Encoding Initiative icon" title="click to view the TEI XML source data for this place"/> TEI XML source data</a>
                </li>
                <!-- Atom format link -->
                <li>
                    <a href="{$resource-uri}/atom" rel="alternate" type="application/atom+xml">
                        <img src="$app-root/resources/img/atom-25.png" alt="The Atom format icon" title="click to view this data in Atom XML format"/> ATOM XML format
                    </a>
                </li>
                <!-- Wikipedia links -->
                <xsl:for-each select="t:idno[contains(.,'wikipedia')]">
                    <xsl:variable name="get-title">
                        <xsl:value-of select="replace(tokenize(.,'/')[last()],'_',' ')"/>
                    </xsl:variable>
                    <li>
                        <a href="{.}">
                            <img src="$app-root/resources/img/Wikipedia-25.png" alt="The Wikipedia icon" title="click to view {$link-title} in Wikipedia"/> "<xsl:value-of select="$get-title"/>" in Wikipedia</a>
                    </li>
                </xsl:for-each>
            </ul>
        </div>
    </xsl:template>
    <xsl:template name="link-icons-list">
        <xsl:param name="title"/>
        <xsl:variable name="resource-uri" select="replace(//t:idno[contains(.,$base-uri)][1],'/tei','')"/>
        <xsl:variable name="id" select="tokenize($resource-uri,'/')[last()]"/>
        <div id="see-also" class="well">
            <h3>See Also</h3>
            <ul>
                <xsl:for-each select="//t:idno[contains(.,'csc.org.il')]">
                    <li>
                        <a href="{normalize-space(.)}"> "
                            <xsl:value-of select="substring-before(substring-after(normalize-space(.),'sK='),'&amp;sT=')"/>" in the Comprehensive Bibliography on Syriac Christianity</a>
                    </li>
                </xsl:for-each>
                <!-- WorldCat Identities -->
                <xsl:for-each select="//t:idno[contains(.,'http://worldcat.org/identities')]">
                    <li>
                        <a href="{normalize-space(.)}"> "<xsl:value-of select="substring-after(.,'http://worldcat.org/identities/')"/>" in WorldCat Identities</a>
                    </li>
                </xsl:for-each>
                <!-- VIAF -->
                <xsl:for-each select="//t:idno[contains(.,'http://viaf.org/')]">
                    <li>
                        <a href="{normalize-space(.)}">VIAF</a>
                    </li>
                </xsl:for-each>
                <!-- Pleiades links -->
                <xsl:for-each select="//t:idno[contains(.,'pleiades')]">
                    <li>
                        <a href="{normalize-space(.)}">
                            <img src="$app-root/resources/img/circle-pi-25.png" alt="Image of the Greek letter pi in blue; small icon of the Pleiades project" title="click to view {$title} in Pleiades"/> View in Pleiades</a>
                    </li>
                </xsl:for-each>
                <!-- Google map links -->
                <!--
                <xsl:for-each select="//t:location[@type='gps']/t:geo">
                    <li>
                        <xsl:variable name="geoRef">
                            <xsl:variable name="coords" select="tokenize(normalize-space(.), '\s+')"/>
                            <xsl:value-of select="$coords[2]"/>
                            <xsl:text>, </xsl:text>
                            <xsl:value-of select="$coords[1]"/>
                        </xsl:variable>
                        <a href="https://maps.google.com/maps?f=q&amp;hl=en&amp;z=4&amp;q=http://syriaca.org/place/{$id}/atom">
                            <img src="/exist/apps/srophe/resources/img/gmaps-25.png" alt="The Google Maps icon" title="click to view {$title} on Google Maps"/> View in Google Maps</a>
                    </li>
                </xsl:for-each>
                -->
                
                <!-- TEI source link -->
                <li>
                    <a href="{$resource-uri}/tei" rel="alternate" type="application/tei+xml">
                        <img src="$app-root/resources/img/tei-25.png" alt="The Text Encoding Initiative icon" title="click to view the TEI XML source data for this place"/> TEI XML source data</a>
                </li>
                <!-- Atom format link -->
                <li>
                    <a href="{$resource-uri}/atom" rel="alternate" type="application/atom+xml">
                        <img src="$app-root/resources/img/atom-25.png" alt="The Atom format icon" title="click to view this data in Atom XML format"/> ATOM XML format
                    </a>
                </li>   
                <!-- Wikipedia links -->
                <xsl:for-each select="//t:idno[contains(.,'wikipedia')]">
                    <xsl:variable name="get-title">
                        <xsl:value-of select="replace(tokenize(.,'/')[last()],'_',' ')"/>
                    </xsl:variable>
                    <li>
                        <a href="{.}">
                            <img src="$app-root/resources/img/Wikipedia-25.png" alt="The Wikipedia icon" title="click to view {$get-title} in Wikipedia"/> "<xsl:value-of select="$get-title"/>" in Wikipedia</a>
                    </li>
                </xsl:for-each>
            </ul>
        </div>
    </xsl:template>
</xsl:stylesheet>