<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:html="http://www.w3.org/1999/xhtml"
   xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:teidocx="http://www.tei-c.org/ns/teidocx/1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
   exclude-result-prefixes="tei html teidocx xs" version="2.0">

   <xsl:import href="../sistory/html5-foundation6/to.xsl"/>

   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl" scope="stylesheet" type="stylesheet">
      <desc>
         <p>TEI stylesheet for making HTML5 output (Zurb Foundation 6
            http://foundation.zurb.com/sites/docs/).</p>
         <p>This software is dual-licensed: 1. Distributed under a Creative Commons
            Attribution-ShareAlike 3.0 Unported License
            http://creativecommons.org/licenses/by-sa/3.0/ 2.
            http://www.opensource.org/licenses/BSD-2-Clause Redistribution and use in source and
            binary forms, with or without modification, are permitted provided that the following
            conditions are met: * Redistributions of source code must retain the above copyright
            notice, this list of conditions and the following disclaimer. * Redistributions in
            binary form must reproduce the above copyright notice, this list of conditions and the
            following disclaimer in the documentation and/or other materials provided with the
            distribution. This software is provided by the copyright holders and contributors "as
            is" and any express or implied warranties, including, but not limited to, the implied
            warranties of merchantability and fitness for a particular purpose are disclaimed. In no
            event shall the copyright holder or contributors be liable for any direct, indirect,
            incidental, special, exemplary, or consequential damages (including, but not limited to,
            procurement of substitute goods or services; loss of use, data, or profits; or business
            interruption) however caused and on any theory of liability, whether in contract, strict
            liability, or tort (including negligence or otherwise) arising in any way out of the use
            of this software, even if advised of the possibility of such damage. </p>
         <p>Mihael Ojsteršek, Institute for Contemporary History</p>
         <p>Copyright: 2013, TEI Consortium</p>
      </desc>
   </doc>

   <!-- Uredi parametre v skladu z dodatnimi zahtevami za pretvorbo te publikacije: -->
   <!-- https://www2.sistory.si/publikacije/ -->
   <!-- ../../../  -->
   <xsl:param name="path-general">https://www2.sistory.si/publikacije/</xsl:param>

   <!-- Iz datoteke ../../../../publikacije-XSLT/sistory/html5-foundation6-chs/to.xsl -->
   <xsl:param name="outputDir">docs/</xsl:param>

   <xsl:param name="homeLabel">Raziskovalni kotiček</xsl:param>
   <xsl:param name="homeURL">https://www.inz.si</xsl:param>

   <xsl:param name="splitLevel">1</xsl:param>

   <!-- Iz datoteke ../../../../publikacije-XSLT/sistory/html5-foundation6-chs/my-html_param.xsl -->
   <xsl:param name="title-bar-sticky">false</xsl:param>

   <!-- odstranim pri spodnjih param true -->
   <xsl:param name="numberFigures"/>
   <xsl:param name="numberFrontTables"/>
   <xsl:param name="numberHeadings"/>
   <xsl:param name="numberParagraphs"/>
   <xsl:param name="numberTables"/>

   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Ne procesiram štetja besed v kolofonu</desc>
   </doc>
   <xsl:template name="countWords"/>

   <!-- V html/head izpisani metapodatki -->
   <xsl:param name="description">Raziskovalni kotiček Inštituta za novejšo zgodovino</xsl:param>
   <xsl:param name="keywords"/>
   <xsl:param name="title">Raziskovalni kotiček Inštituta za novejšo zgodovino</xsl:param>


   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Novo ime za front front/div</desc>
      <param name="thisLanguage"/>
   </doc>
   <xsl:template name="nav-front-head">
      <xsl:param name="thisLanguage"/>
      <xsl:text>Predgovor</xsl:text>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Procesiranje specifilnih vsebinskih sklopov - callout</desc>
   </doc>
   <xsl:template match="tei:p[@rend='bluebox']">
      <div id="{@xml:id}" class="callout primary">
         <xsl:apply-templates/>
      </div>
   </xsl:template>


   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Novo ime za glavno vsebino (glavna navigacija)</desc>
      <param name="thisLanguage"/>
   </doc>
   <xsl:template name="nav-body-head">
      <xsl:param name="thisLanguage"/>
      <xsl:text>Gradivo</xsl:text>
   </xsl:template>

   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Novo ime za priloge</desc>
      <param name="thisLanguage"/>
   </doc>
   <xsl:template name="nav-appendix-head">
      <xsl:param name="thisLanguage"/>
      <xsl:text>Razstava</xsl:text>
   </xsl:template>


   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc/>
   </doc>
   <xsl:template match="tei:note[@type = 'accesability']">
      <div class="callout alert">
         <p>
            <xsl:value-of select="."/>
         </p>
      </div>
   </xsl:template>

   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc/>
   </doc>
   <xsl:template match="tei:figure[@type = 'razstava-PDF']">
      <embed src="{tei:graphic/@url}" type="application/pdf" height="1400" width="100%"/>
   </xsl:template>


   <xsldoc:doc xmlns:xsldoc="http://www.oxygenxml.com/ns/doc/xsl">
      <xsldoc:desc>V css in javascript Hook dodam imageViewer</xsldoc:desc>
   </xsldoc:doc>
   <xsl:template name="cssHook">
      <xsl:if test="$title-bar-sticky = 'true'">
         <xsl:value-of select="concat($path-general,'themes/css/foundation/6/sistory-sticky_title_bar.css')"/>
      </xsl:if>
      <link href="https://cdnjs.cloudflare.com/ajax/libs/foundicons/3.0.0/foundation-icons.min.css" rel="stylesheet" type="text/css" />
      <link href="{concat($path-general,'themes/plugin/TipueSearch/6.1/tipuesearch/css/normalize.css')}" rel="stylesheet" type="text/css" />
      <link href="{concat($path-general,'themes/css/plugin/TipueSearch/6.1/my-tipuesearch.css')}"  rel="stylesheet" type="text/css" />
      <!-- dodan imageViewer -->
      <link href="{concat($path-general,'themes/plugin/ImageViewer/1.1.3/imageviewer.css')}"  rel="stylesheet" type="text/css" />
   </xsl:template>
   <xsldoc:doc xmlns:xsldoc="http://www.oxygenxml.com/ns/doc/xsl">
      <xsldoc:desc>[html] Hook where extra Javascript functions can be defined</xsldoc:desc>
   </xsldoc:doc>
   <xsl:template name="javascriptHook">
      <script src="{concat($path-general,'themes/foundation/6/js/vendor/jquery.js')}"></script>
      <!-- za highcharts -->
      <xsl:if test="//tei:figure[@type = 'chart'][tei:graphic[@mimeType = 'application/javascript']]">
         <xsl:variable name="jsfile" select="//tei:figure[@type = 'chart'][tei:graphic[@mimeType = 'application/javascript']][1]/tei:graphic[@mimeType = 'application/javascript']/@url"/>
         <xsl:variable name="chart-jsfile" select="document($jsfile)/html/body/script[1]/@src"/>
         <script src="{$chart-jsfile[1]}"></script>
      </xsl:if>
      <!-- za back-to-top in highcharts je drugače potrebno dati jquery, vendar sedaj ne rabim dodajati jquery kodo,
         ker je že vsebovana zgoraj -->
      <!-- dodan imageViewer -->
      <script src="{concat($path-general,'themes/plugin/ImageViewer/1.1.3/imageviewer.js')}"></script>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Slike, ki imajo vključeno možnost povečanja slike z imageviewer</desc>
   </doc>
   <xsl:template match="tei:figure[@rend='imageviewer']">
      <figure id="{@xml:id}">
         <img class="imageviewer" style="height:600px;" src="{tei:graphic[contains(@url,'normal')]/@url}" data-high-res-src="{tei:graphic[1]/@url}" alt="{normalize-space(tei:head)}"/>
         <figcaption>
            <xsl:value-of select="normalize-space(tei:head)"/>
         </figcaption>
      </figure>
      <br/>
      <br/>
   </xsl:template>

   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Posebno oblikovanje za slike z intervjuji
         https://foundation.zurb.com/sites/docs/media-object.html</desc>
   </doc>
   <xsl:template match="tei:figure[@rend = 'interview']">
      <div class="media-object" id="{@xml:id}">
         <div class="media-object-section">
            <div class="thumbnail">
               <img class="imageviewer" src="{tei:graphic[contains(@url,'thumb')]/@url}"
                  data-high-res-src="{tei:graphic[not(contains(@url,'thumb'))]/@url}"/>
            </div>
         </div>
         <div class="media-object-section">
            <xsl:apply-templates select="*[not(self::tei:graphic)]"/>
         </div>
      </div>
   </xsl:template>

   <xsldoc:doc xmlns:xsldoc="http://www.oxygenxml.com/ns/doc/xsl">
      <xsldoc:desc>Dodam zaključni javascript za ImageViewer</xsldoc:desc>
   </xsldoc:doc>
   <xsl:template name="bodyEndHook">
      <script type="text/javascript">
        $(function () {
            var viewer = ImageViewer();
            $('.imageviewer').click(function () {
                var imgSrc = this.src,
                highResolutionImage = $(this).data('high-res-src');
                viewer.show(imgSrc, highResolutionImage);
            });
        });</script>
      <script src="{concat($path-general,'themes/foundation/6/js/vendor/what-input.js')}"/>
      <script src="{concat($path-general,'themes/foundation/6/js/vendor/foundation.min.js')}"/>
      <script src="{concat($path-general,'themes/foundation/6/js/app.js')}"/>
      <!-- back-to-top -->
      <script src="{concat($path-general,'themes/js/plugin/back-to-top/back-to-top.js')}"/>
   </xsl:template>

</xsl:stylesheet>
