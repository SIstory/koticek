<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:dc="http://purl.org/dc/elements/1.1/"
  xmlns:iso="http://www.iso.org/ns/1.0"
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:html="http://www.w3.org/1999/xhtml"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns:teix="http://www.tei-c.org/ns/Examples"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:ncx="http://www.daisy.org/z3986/2005/ncx/"
  xmlns:m="http://www.w3.org/1998/Math/MathML"
  version="2.0" exclude-result-prefixes="#all"
  xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    
  <xsl:import href="../../tei-xsl-7.47.0/xml/tei/stylesheet/epub3/tei-to-epub3.xsl"/>
  
  <!-- uvozim nekatere svoje html pretvorbe, ki povozijo pretvorbe TEI konzorcija -->
  <xsl:import href="../html5-foundation6/myi18n.xsl"/>
  <xsl:import href="../html5-foundation6/bibliography.xsl"/>
  <xsl:import href="../html5-foundation6/titlePage.xsl"/>
  <xsl:import href="../html5-foundation6/my-html_core.xsl"/>
  <xsl:import href="../html5-foundation6/my-html_namesdates.xsl"/>
  <xsl:import href="../html5-foundation6/new-html_core.xsl"/>
  <xsl:import href="../html5-foundation6/divGen.xsl"/>
  
  <!-- Uvozim, kar je narejeno samo z ePub -->
  <xsl:import href="new-html_figures.xsl"/>

  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl" scope="stylesheet" type="stylesheet">
      <desc>
         <p>This software is dual-licensed:

1. Distributed under a Creative Commons Attribution-ShareAlike 3.0
Unported License http://creativecommons.org/licenses/by-sa/3.0/ 

2. http://www.opensource.org/licenses/BSD-2-Clause

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

* Redistributions of source code must retain the above copyright
notice, this list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright
notice, this list of conditions and the following disclaimer in the
documentation and/or other materials provided with the distribution.

This software is provided by the copyright holders and contributors
"as is" and any express or implied warranties, including, but not
limited to, the implied warranties of merchantability and fitness for
a particular purpose are disclaimed. In no event shall the copyright
holder or contributors be liable for any direct, indirect, incidental,
special, exemplary, or consequential damages (including, but not
limited to, procurement of substitute goods or services; loss of use,
data, or profits; or business interruption) however caused and on any
theory of liability, whether in contract, strict liability, or tort
(including negligence or otherwise) arising in any way out of the use
of this software, even if advised of the possibility of such damage.
</p>
         <p>Author: See AUTHORS</p>
         <p>Author: Andrej Pančur</p>
         
         <p>Copyright: 2013, TEI Consortium</p>
      </desc>
   </doc>
  
  <xsl:output method="xml" encoding="utf-8" doctype-system="" indent="no" omit-xml-declaration="yes"/>
  
  <!-- EPUB NASTAVITVE -->
  <!-- Če določimo naslovnico v titlePage/@fasc, potem ni potrebno, da dodamo coverimage parameter.
       Če pa tega ne storimo, lahko tukaj dodamo samo ime datoteke naslovnice (ne pot) in 
       moramo zato sliko shraniti v istem direktoriju kot titlepage.html
  -->
  <xsl:param name="coverimage"></xsl:param>
  <!-- css datoteke daj v direktorij, ki je relativno na XSLT in ne na XML -->
  <xsl:param name="cssFile">css/sistory/main.css</xsl:param>
  <xsl:param name="cssPrintFile"></xsl:param>
  <xsl:param name="cssSecondaryFile"></xsl:param>
  
  <xsl:param name="documentationLanguage">sl</xsl:param>
  <xsl:param name="directory">epub</xsl:param>
  
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl" class="figures" type="string">
    <desc>Directory specification to put before names of graphics files,
      unless they start with "./" Vse slike so v ePub shranjene v direktoriju Pictures (Prevzeto še ne deluje, ker avtomatično pretvori Pictures/Charts/ime_datoteke</desc>
  </doc>
  <!--<xsl:param name="graphicsPrefix">Pictures/</xsl:param>-->
  
  <xsl:param name="splitLevel">0</xsl:param>
  <xsl:param name="STDOUT">false</xsl:param>
  <xsl:param name="tocDepth">5</xsl:param>
  <xsl:param name="tocFront">false</xsl:param>
  <xsl:param name="autoToc">false</xsl:param>
  
  <xsl:param name="useIDs">true</xsl:param>
  
  <xsl:param name="institution"></xsl:param>
  <xsl:param name="footnoteBackLink">true</xsl:param>
  <xsl:param name="generateParagraphIDs">true</xsl:param>
  <xsl:param name="numberBackHeadings"></xsl:param>
  <xsl:param name="numberFigures">true</xsl:param>
  <xsl:param name="numberFrontTables">true</xsl:param>
  <xsl:param name="numberHeadings">true</xsl:param>
  <xsl:param name="numberParagraphs">true</xsl:param>
  <xsl:param name="numberTables">true</xsl:param>
  
  <!-- SIstory HTML param nastavitve: prilagodim za potrebe ePub izdaje:
       Tam, kjer te parametre uporabljajo XSLT stili iz ../html5-foundation6-chs/ , jih moram prilagoditi za uporabo v ePub -->
  <!-- uporabni parametri: -->
  <!-- za divGen[@type='teiHeader']: če je $element-gloss-teiHeader true,
        se izpišejo gloss imena za elemente, drugače je name() elementa -->
  <xsl:param name="element-gloss-teiHeader">true</xsl:param>
  <!-- za divGen[@type='teiHeader']: določi se jezik izpisa za gloss elementa, lahko samo za:
         - sl
         - en
    -->
  <xsl:param name="element-gloss-teiHeader-lang">sl</xsl:param>
  <!-- za tei:listPerson[@type='data'] | tei:listOrg[@type='data'] | tei:listEvent[@type='data']:
        če je $element-gloss-namesdates true,
        se izpišejo gloss imena za elemente, drugače je name() elementa -->
  <xsl:param name="element-gloss-namesdates">true</xsl:param>
  <!-- za tei:listPerson[@type='data'] | tei:listOrg[@type='data'] | tei:listEvent[@type='data']:
         določi se jezik izpisa za gloss elementa, lahko samo za:
         - sl
         - en
    -->
  <xsl:param name="element-gloss-namesdates-lang">sl</xsl:param>
  <!-- če procesiramo teiCorpus: možnost, da odstranimo nadaljno procesiranje tei:TEI,
         saj se lahko pojavijo problemi (različne sezname (npr. slik, tabel ipd.) dela v celotnem korpusu in ne samo znotraj enega tei:TEI).
         V tem primeru posamezne tei:TEI procesiramo ločeno.
         Vrednost true, če želimo procesirati.
    -->
  <xsl:param name="processing-TEI-from-teiCorpus"></xsl:param>
  <!-- naslednji parametri imajo isto pri teiCorpus funkcijo kot divGen pri TEI -->
  <!-- če hočemo, da procesira teiHeader od teiCorpusa (podobno kot divGen[@type='teiHeader']) -->
  <xsl:param name="write-teiCorpus-teiHeader">true</xsl:param>
  <!-- če hočemo procesirati kolofon in cip pri teiCorpus (podobno kot divGen[@type='cip']) -->
  <xsl:param name="write-teiCorpus-cip">true</xsl:param>
  <!-- če hočemo procesirati kazalo vsebine tei:TEI vključenih v teiCorpus (podobno kot divGen[@type='toc'][@xml:id='titleAuthor')  -->
  <xsl:param name="write-teiCorpus-toc_titleAuthor">true</xsl:param>
  
  <!-- izklopljeni parametri -->
  <xsl:param name="path-general"></xsl:param>
  <xsl:param name="chapterAsSIstoryPublications">false</xsl:param>
  <xsl:param name="title-bar-sticky">false</xsl:param>
  <xsl:param name="languages-locale">false</xsl:param>
  <xsl:param name="languages-locale-primary"></xsl:param>
  <xsl:param name="description"></xsl:param>
  <xsl:param name="keywords"></xsl:param>
  <xsl:param name="title"></xsl:param>
  <xsl:param name="HTML5_declaracion"></xsl:param>
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>izklopljeni sistory html template</desc>
    <param name="chapterID"></param>
  </doc>
  <xsl:template name="sistoryPath">
    <xsl:param name="chapterID"/>
  </xsl:template>
  
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>Dodano za procesiranje naslovov poglavij v mojih kazalih (vzel iz ../html5-foundation6-chs/header.xsl)</desc>
  </doc>
  <xsl:template match="tei:head" mode="chapters-head">
    <xsl:apply-templates mode="chapters-head"/>
  </xsl:template>
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc></desc>
  </doc>
  <xsl:template match="tei:note" mode="chapters-head">
    <!-- ne procesirmar -->
  </xsl:template>
  
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>[html] Generate a page using simple layout : izdela index.html</desc>
  </doc>
  <xsl:template name="pageLayoutSimple">
    <html>
      <xsl:call-template name="addLangAtt"/>
      <xsl:variable name="pagetitle">
        <xsl:sequence select="tei:generateTitle(.)"/>
      </xsl:variable>
      <xsl:sequence select="tei:htmlHead($pagetitle,3)"/>
      <body class="simple" id="TOP">
        <xsl:copy-of select="tei:text/tei:body/@unload"/>
        <xsl:copy-of select="tei:text/tei:body/@onunload"/>
        <xsl:call-template name="bodyMicroData"/>
        <xsl:call-template name="bodyJavascriptHook"/>
        <xsl:call-template name="bodyHook"/>
        <xsl:if test="not(tei:text/tei:front/tei:titlePage)">
          <div class="stdheader autogenerated">
            <xsl:call-template name="stdheader">
              <xsl:with-param name="title">
                <xsl:sequence select="tei:generateTitle(.)"/>
              </xsl:with-param>
            </xsl:call-template>
          </div>
        </xsl:if>
        <xsl:comment>TEI  front matter </xsl:comment>
        <xsl:apply-templates select="tei:text/tei:front"/>
        <!-- odstranim možnost izdelave kazala na takoj prvi strani -->
        <!--<xsl:if test="$autoToc='true' and (descendant::tei:div or descendant::tei:div1) and not(descendant::tei:divGen[@type='toc'])">
          <h2>
            <xsl:sequence select="tei:i18n('tocWords')"/>
          </h2>
          <xsl:call-template name="mainTOC"/>
        </xsl:if>-->
        <xsl:choose>
          <xsl:when test="tei:text/tei:group">
            <xsl:apply-templates select="tei:text/tei:group"/>
          </xsl:when>
          <xsl:when test="tei:match(@rend,'multicol')">
            <table>
              <tr>
                <xsl:apply-templates select="tei:text/tei:body"/>
              </tr>
            </table>
          </xsl:when>
          <xsl:otherwise>
            <xsl:comment>TEI body matter </xsl:comment>
            <xsl:call-template name="startHook"/>
            <xsl:variable name="ident">
              <xsl:apply-templates mode="ident" select="."/>
            </xsl:variable>
            <xsl:apply-templates select="tei:text/tei:body"/>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:comment>TEI back matter </xsl:comment>
        <xsl:apply-templates select="tei:text/tei:back"/>
        <xsl:call-template name="printNotes"/>
        <xsl:call-template name="htmlFileBottom"/>
        <xsl:call-template name="bodyEndHook"/>
      </body>
    </html>
  </xsl:template>
  
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>[epub] Override of top-level template. This does most of
      the work: performing the normal transformation, fixing the links to graphics files so that they are
      all relative, creating the extra output files, etc: 
      Spremembe v procesiranju toc.ncx</desc>
  </doc>
  <xsl:template name="processTEI">
    <xsl:variable name="stage1">
      <xsl:apply-templates mode="preflight"/>
    </xsl:variable>
    <xsl:for-each select="$stage1">
      <xsl:call-template name="processTEIHook"/>
      <xsl:variable name="coverImageOutside">
        <xsl:choose>
          <xsl:when test="/tei:TEI/tei:text/tei:front/tei:titlePage[@facs]">
            <xsl:for-each select="/tei:TEI/tei:text/tei:front/tei:titlePage[@facs][1]">
              <xsl:for-each select="id(substring(@facs,2))">
                <xsl:choose>
                  <xsl:when test="count(tei:graphic)=1">
                    <xsl:value-of select="tei:graphic/@url"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="tei:graphic[2]/@url"/>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:for-each>
            </xsl:for-each>
          </xsl:when>
          <xsl:when test="not($coverimage='')">
            <xsl:value-of select="tokenize($coverimage,'/')[last()]"/>
          </xsl:when>
        </xsl:choose>
      </xsl:variable>
      <xsl:variable name="coverImageInside">
        <xsl:choose>
          <xsl:when test="/tei:TEI/tei:text/tei:front/tei:titlePage[@facs]">
            <xsl:for-each select="/tei:TEI/tei:text/tei:front/tei:titlePage[@facs][1]">
              <xsl:for-each select="id(substring(@facs,2))">
                <xsl:value-of select="tei:graphic[1]/@url"/>
              </xsl:for-each>
            </xsl:for-each>
          </xsl:when>
          <xsl:when test="not($coverimage='')">
            <xsl:value-of select="tokenize($coverimage,'/')[last()]"/>
          </xsl:when>
        </xsl:choose>
      </xsl:variable>
      <xsl:choose>
        <xsl:when test="$splitLevel='-1'">
          <xsl:apply-templates/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates mode="split"/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:for-each select="*">
        <xsl:variable name="TOC">
          <TOC xmlns="http://www.w3.org/1999/xhtml">
            <xsl:call-template name="mainTOC"/>
          </TOC>
        </xsl:variable>
        <!--
	      <xsl:result-document href="/tmp/TOC">
	        <xsl:copy-of select="$TOC"/>
	      </xsl:result-document>
        -->
        <xsl:for-each select="tokenize($javascriptFiles,',')">
          <xsl:variable name="file" select="normalize-space(.)"/>
          <xsl:variable name="name" select="tokenize($file,'/')[last()]"/>
          <xsl:if test="$verbose='true'">
            <xsl:message>write Javascript file <xsl:value-of select="$name"/></xsl:message>
          </xsl:if>
          <xsl:result-document method="text" href="{concat($directory,'/OPS/',$name)}">
            <xsl:for-each select="unparsed-text($file)">
              <xsl:copy-of select="."/>
            </xsl:for-each>
          </xsl:result-document>
        </xsl:for-each>
        <xsl:if test="$verbose='true'">
          <xsl:message>write file OPS/stylesheet.css</xsl:message>
        </xsl:if>
        <xsl:result-document method="text" href="{concat($directory,'/OPS/stylesheet.css')}">
          <xsl:if test="not($cssFile='')">
            <xsl:if test="$verbose='true'">
              <xsl:message>reading file <xsl:value-of select="$cssFile"/></xsl:message>
            </xsl:if>
            <xsl:for-each select="tokenize(unparsed-text($cssFile),     '\r?\n')">
              <xsl:call-template name="purgeCSS"/>
            </xsl:for-each>
          </xsl:if>
          <xsl:if test="not($cssSecondaryFile='')">
            <xsl:if test="$verbose='true'">
              <xsl:message>reading secondary file <xsl:value-of select="$cssSecondaryFile"/></xsl:message>
            </xsl:if>
            <xsl:for-each select="tokenize(unparsed-text($cssSecondaryFile),       '\r?\n')">
              <xsl:call-template name="purgeCSS"/>
            </xsl:for-each>
          </xsl:if>
          <xsl:if test="$odd='true'">
            <xsl:if test="$verbose='true'">
              <xsl:message>reading file <xsl:value-of select="$cssODDFile"/></xsl:message>
            </xsl:if>
            <xsl:for-each select="tokenize(unparsed-text($cssODDFile),         '\r?\n')">
              <xsl:call-template name="purgeCSS"/>
            </xsl:for-each>
          </xsl:if>
          <xsl:if test="$odd='true'">
            <xsl:if test="$verbose='true'">
              <xsl:message>reading file <xsl:value-of select="$cssODDFile"/></xsl:message>
            </xsl:if>
            <xsl:for-each select="tokenize(unparsed-text($cssODDFile),         '\r?\n')">
              <xsl:call-template name="purgeCSS"/>
            </xsl:for-each>
          </xsl:if>
          <xsl:if test="$filePerPage='true'">
            <xsl:text>body { width: </xsl:text>
            <xsl:value-of select="number($viewPortWidth)-100"/>
            <xsl:text>px;
 height: </xsl:text>
            <xsl:value-of select="$viewPortHeight"/>
            <xsl:text>px;
}
img.fullpage {
position: absolute;
height: </xsl:text>
            <xsl:value-of select="$viewPortHeight"/>
            <xsl:text>px; left:0px; top:0px;}
</xsl:text>
          </xsl:if>
        </xsl:result-document>
        <xsl:if test="$verbose='true'">
          <xsl:message>write file OPS/print.css</xsl:message>
        </xsl:if>
        <xsl:result-document method="text" href="{concat($directory,'/OPS/print.css')}">
          <xsl:if test="$verbose='true'">
            <xsl:message>reading file <xsl:value-of select="$cssPrintFile"/></xsl:message>
          </xsl:if>
          <xsl:for-each select="tokenize(unparsed-text($cssPrintFile),     '\r?\n')">
            <xsl:call-template name="purgeCSS"/>
          </xsl:for-each>
        </xsl:result-document>
        <xsl:if test="$verbose='true'">
          <xsl:message>write file mimetype</xsl:message>
        </xsl:if>
        <xsl:result-document method="text" href="{concat($directory,'/mimetype')}">
          <xsl:value-of select="$epubMimetype"/>
        </xsl:result-document>
        <xsl:if test="$verbose='true'">
          <xsl:message>write file META-INF/container.xml</xsl:message>
        </xsl:if>
        <xsl:result-document doctype-public=""
			     doctype-system="" 
			     method="xml" href="{concat($directory,'/META-INF/container.xml')}">
          <container xmlns="urn:oasis:names:tc:opendocument:xmlns:container" version="1.0">
            <rootfiles>
              <rootfile full-path="OPS/package.opf" media-type="application/oebps-package+xml"/>
            </rootfiles>
          </container>
        </xsl:result-document>
        <xsl:if test="$verbose='true'">
          <xsl:message>write file OPS/package.opf</xsl:message>
        </xsl:if>
        <xsl:variable name="A">
          <xsl:sequence select="tei:generateAuthor(.)"/>
        </xsl:variable>
        <xsl:variable name="printA">
          <xsl:analyze-string select="$A" regex="([^,]+), ([^,]+), (.+)">
            <xsl:matching-substring>
              <xsl:value-of select="regex-group(1)"/>
              <xsl:text>, </xsl:text>
              <xsl:value-of select="regex-group(2)"/>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
              <xsl:value-of select="."/>
            </xsl:non-matching-substring>
          </xsl:analyze-string>
        </xsl:variable>
	      <xsl:result-document href="{concat($directory,'/OPS/package.opf')}" method="xml" indent="yes">
          <package xmlns="http://www.idpf.org/2007/opf" unique-identifier="pub-id" version="{$opfPackageVersion}">
            <xsl:call-template name="opfmetadata">
              <xsl:with-param name="author" select="$A"/>
              <xsl:with-param name="printAuthor" select="$printA"/>
              <xsl:with-param name="coverImageOutside" select="$coverImageOutside"/>
            </xsl:call-template>
            <manifest>
              <!-- deal with intricacies of overlay files -->
              <xsl:variable name="TL" select="key('Timeline',1)"/>
              <xsl:if test="$mediaoverlay='true' and key('Timeline',1)">
                <xsl:if test="$verbose='true'">
                  <xsl:message>write file SMIL files</xsl:message>
                </xsl:if>
                <xsl:for-each select="key('Timeline',1)">
                  <xsl:variable name="TLnumber">
                    <xsl:number level="any"/>
                  </xsl:variable>
                  <xsl:variable name="audio">
                    <xsl:text>media/audio</xsl:text>
                    <xsl:number level="any"/>
                    <xsl:text>.</xsl:text>
                    <xsl:value-of select="tokenize(@corresp,'\.')[last()]"/>
                  </xsl:variable>
                  <item id="timeline-audio{$TLnumber}" href="{$audio}">
                    <xsl:attribute name="media-type">
                      <xsl:choose>
                        <xsl:when test="contains($audio,'.m4a')">audio/m4a</xsl:when>
                        <xsl:otherwise>audio/m4a</xsl:otherwise>
                      </xsl:choose>
                    </xsl:attribute>
                  </item>
                  <xsl:for-each select="key('PB',1)">
                    <xsl:variable name="page">
                      <xsl:value-of select="generate-id()"/>
                    </xsl:variable>
                    <xsl:variable name="target">
                      <xsl:apply-templates select="." mode="ident"/>
                    </xsl:variable>
                    <xsl:if test="count(key('objectOnPage',$page))&gt;0">
                      <item id="{$target}-audio" href="{$target}-overlay.smil" media-type="application/smil+xml"/>
                      <xsl:result-document href="{concat($directory,'/OPS/',$target,'-overlay.smil')}" method="xml">
                        <smil xmlns="http://www.w3.org/ns/SMIL" version="3.0" profile="http://www.ipdf.org/epub/30/profile/content/">
                          <body>
                            <xsl:for-each select="key('objectOnPage',$page)">
                              <xsl:variable name="object" select="@xml:id"/>
                              <xsl:for-each select="$TL">
                                <xsl:for-each select="key('Object',$object)">
                                  <par id="{@xml:id}">
                                    <text src="{$target}.html{@corresp}"/>
                                    <audio src="{$audio}" clipBegin="{@from}{../@unit}" clipEnd="{@to}{../@unit}"/>
                                  </par>
                                </xsl:for-each>
                              </xsl:for-each>
                            </xsl:for-each>
                          </body>
                        </smil>
                      </xsl:result-document>
                    </xsl:if>
                  </xsl:for-each>
                </xsl:for-each>
              </xsl:if>
              <xsl:if test="not($coverImageOutside='')">
                <item href="{$coverImageOutside}" id="cover-image" properties="cover-image" media-type="image/jpeg"/>
              </xsl:if>
              <xsl:for-each select="tokenize($javascriptFiles,',')">
                <xsl:variable name="name" select="tokenize(normalize-space(.),'/')[last()]"/>
                <item href="{$name}" id="javascript{position()}" media-type="text/javascript"/>
              </xsl:for-each>
              <item id="css" href="stylesheet.css" media-type="text/css"/>
              <item id="print.css" href="print.css" media-type="text/css"/>
              <item href="titlepage.html" id="titlepage" media-type="application/xhtml+xml"/>
              <xsl:if test="$filePerPage='true'">
                <item href="titlepageverso.html" id="titlepageverso" media-type="application/xhtml+xml"/>
              </xsl:if>
              <!-- Odstranim procesiranje titlePage v titlepage{N}.html,
                   ker imajo sistory objave to prikazano v index.html,
                   pri čemer je možen samo eden titlePage
              -->
              <!--<xsl:for-each select="tei:text/tei:front/tei:titlePage">
                <xsl:variable name="N" select="position()"/>
                <item href="titlepage{$N}.html" id="titlepage{$N}" media-type="application/xhtml+xml"/>
              </xsl:for-each>-->
              <item href="titlepageback.html" id="titlepageback" media-type="application/xhtml+xml"/>
              <item id="toc" properties="nav" href="epubtoc.html" media-type="application/xhtml+xml"/>
              <item id="start" href="index.html" media-type="application/xhtml+xml">
		            <xsl:call-template name="epub-start-properties"/>
	            </item>
              <!-- dodam za divGen v front -->
              <xsl:for-each select="tei:text/tei:front/tei:divGen[not(@type='search')][not(@type='teiHeader')]">
                <item href="{@xml:id}.html" id="{@xml:id}" media-type="application/xhtml+xml"/>
              </xsl:for-each>
              <xsl:choose>
                <xsl:when test="$filePerPage='true'">
                  <xsl:for-each select="key('PB',1)">
                    <xsl:variable name="target">
                      <xsl:apply-templates select="." mode="ident"/>
                    </xsl:variable>
                    <xsl:if test="@facs">
                      <xsl:variable name="facstarget">
                        <xsl:apply-templates select="." mode="ident"/>
                        <xsl:text>-facs.html</xsl:text>
                      </xsl:variable>
                      <item href="{$facstarget}" media-type="application/xhtml+xml">
                        <xsl:attribute name="id">
                          <xsl:text>pagefacs</xsl:text>
                          <xsl:number level="any"/>
                        </xsl:attribute>
                      </item>
                    </xsl:if>
                    <item href="{$target}.html" media-type="application/xhtml+xml">
                      <xsl:if test="$mediaoverlay='true'  and key('Timeline',1)">
                        <xsl:attribute name="media-overlay">
                          <xsl:value-of select="$target"/>
                          <xsl:text>-audio</xsl:text>
                        </xsl:attribute>
                      </xsl:if>
                      <xsl:attribute name="id">
                        <xsl:text>page</xsl:text>
                        <xsl:number level="any"/>
                      </xsl:attribute>
                    </item>
                  </xsl:for-each>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:for-each select="$TOC/html:TOC/html:ul/html:li">
                    <xsl:choose>
                      <xsl:when test="not(html:a)"/>
                      <xsl:when test="starts-with(html:a/@href,'#')"/>
                      <xsl:otherwise>
                        <item href="{html:a[1]/@href}" media-type="application/xhtml+xml">
			                    <xsl:if test="contains(@class,'contains-mathml')">
			                      <xsl:attribute name="properties">mathml</xsl:attribute>
			                    </xsl:if>
                          <xsl:attribute name="id">
                            <xsl:text>section</xsl:text>
                            <xsl:number count="html:li" level="any"/>
                          </xsl:attribute>
                        </item>
                      </xsl:otherwise>
                    </xsl:choose>
                    <xsl:if test="html:ul">
                      <xsl:for-each select="html:ul//html:li[html:a          and          not(contains(html:a/@href,'#'))]">
                        <item href="{html:a[1]/@href}" media-type="application/xhtml+xml">
                          <xsl:attribute name="id">
                            <xsl:text>section</xsl:text>
                            <xsl:number count="html:li" level="any"/>
                          </xsl:attribute>
                        </item>
                      </xsl:for-each>
                    </xsl:if>
                  </xsl:for-each>
                </xsl:otherwise>
              </xsl:choose>
              <!-- dodam za divGen v back -->
              <xsl:for-each select="tei:text/tei:back/tei:divGen">
                <item href="{@xml:id}.html" id="{@xml:id}" media-type="application/xhtml+xml"/>
              </xsl:for-each>
              <!-- images -->
              <xsl:for-each select="key('GRAPHICS',1)">
                <xsl:variable name="img" select="@url|@facs"/>
                <xsl:if test="not($img=$coverImageOutside)">
                  <xsl:variable name="ID">
                    <xsl:number level="any"/>
                  </xsl:variable>
                  <item href="{$img}" id="image-{$ID}" media-type="{tei:generateMimeType($img,@mimeType)}"/>
                </xsl:if>
              </xsl:for-each>
              <!-- page images -->
              <xsl:for-each select="key('PBGRAPHICS',1)">
		            <xsl:choose>
		              <xsl:when test="tei:match(@rend,'none')"/>
		              <xsl:otherwise>
                    <xsl:variable name="img" select="@facs"/>
                    <xsl:variable name="ID">
                      <xsl:number level="any"/>
                    </xsl:variable>
                    <item href="{$img}" id="pbimage-{$ID}" media-type="{tei:generateMimeType($img,@mimeType)}"/>
		              </xsl:otherwise>
		          </xsl:choose>
              </xsl:for-each>
	            <xsl:for-each select="tokenize($extraGraphicsFiles,',')">
                <item href="{.}" id="graphic-{.}" media-type="{tei:generateMimeType(.,'')}"/>
	            </xsl:for-each>
              <item id="ncx" href="toc.ncx" media-type="application/x-dtbncx+xml"/>
              <xsl:call-template name="epubManifestHook"/>
            </manifest>
            <spine toc="ncx">
              <itemref idref="titlepage" linear="yes"/>
              <xsl:if test="$filePerPage='true'">
                <itemref idref="titlepageverso" linear="yes"/>
              </xsl:if>
              <!--<xsl:for-each select="tei:text/tei:front/tei:titlePage">
                <xsl:variable name="N" select="position()"/>
                <itemref idref="titlepage{$N}" linear="yes"/>
              </xsl:for-each>-->
              <itemref idref="start" linear="yes"/>
              <!-- dodam za divGen v front -->
              <xsl:for-each select="tei:text/tei:front/tei:divGen[not(@type='search')][not(@type='teiHeader')]">
                <itemref idref="{@xml:id}" linear="yes"/>
              </xsl:for-each>
              <xsl:choose>
                <xsl:when test="$filePerPage='true'">
                  <xsl:for-each select="key('PB',1)">
                    <xsl:if test="@facs">
                      <itemref>
                        <xsl:attribute name="idref">
                          <xsl:text>pagefacs</xsl:text>
                          <xsl:number level="any"/>
                        </xsl:attribute>
                        <xsl:attribute name="linear">yes</xsl:attribute>
                      </itemref>
                    </xsl:if>
                    <itemref>
                      <xsl:attribute name="idref">
                        <xsl:text>page</xsl:text>
                        <xsl:number level="any"/>
                      </xsl:attribute>
                      <xsl:attribute name="linear">yes</xsl:attribute>
                    </itemref>
                  </xsl:for-each>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:for-each select="$TOC/html:TOC/html:ul/html:li">
                    <xsl:choose>
                      <xsl:when test="not(html:a)"/>
                      <xsl:when test="starts-with(html:a/@href,'#')"/>
                      <xsl:otherwise>
                        <itemref>
                          <xsl:attribute name="idref">
                            <xsl:text>section</xsl:text>
                            <xsl:number count="html:li" level="any"/>
                          </xsl:attribute>
                          <xsl:attribute name="linear">yes</xsl:attribute>
                        </itemref>
                      </xsl:otherwise>
                    </xsl:choose>
                    <xsl:if test="html:ul">
                      <xsl:for-each select="html:ul//html:li[html:a and not(contains(html:a/@href,'#'))]">
                        <itemref>
                          <xsl:attribute name="idref">
                            <xsl:text>section</xsl:text>
                            <xsl:number count="html:li" level="any"/>
                          </xsl:attribute>
                          <xsl:attribute name="linear">yes</xsl:attribute>
                        </itemref>
                      </xsl:for-each>
                    </xsl:if>
                  </xsl:for-each>
                </xsl:otherwise>
              </xsl:choose>
              <!-- dodam za divGen v back -->
              <xsl:for-each select="tei:text/tei:back/tei:divGen">
                <itemref idref="{@xml:id}" linear="yes"/>
              </xsl:for-each>
              <itemref idref="titlepageback">
                <xsl:attribute name="linear">
                  <xsl:choose>
                    <xsl:when test="$filePerPage='true'">yes</xsl:when>
                    <!-- dodam, da prikaže tudi takrat, ko je vkopljen divGen za teiHeader -->
                    <xsl:when test="//tei:divGen[@type='teiHeader']">yes</xsl:when>
                    <xsl:otherwise>no</xsl:otherwise>
                  </xsl:choose>
                </xsl:attribute>
              </itemref>
              <xsl:call-template name="epubSpineHook"/>
            </spine>
            <guide>
              <reference type="text" href="titlepage.html" title="Cover"/>
              <reference type="text" title="Start" href="index.html"/>
              <!-- dodam za divGen v front -->
              <xsl:for-each select="tei:text/tei:front/tei:divGen[not(@type='search')][not(@type='teiHeader')]">
                <reference type="text" title="{tei:head}" href="{@xml:id}.html"/>
              </xsl:for-each>
              <xsl:choose>
                <xsl:when test="$filePerPage='true'">
		            </xsl:when>
                <xsl:otherwise>
                  <xsl:for-each select="$TOC/html:TOC/html:ul/html:li">
		                <xsl:if test="html:a and not (starts-with(html:a[1]/@href,'#'))">
                      <reference type="text" href="{html:a[1]/@href}">
                        <xsl:attribute name="title">
                          <xsl:value-of select="normalize-space(html:a[1])"/>
                        </xsl:attribute>
                      </reference>
                    </xsl:if>
                    <xsl:if test="contains(parent::html:ul/@class,'group')">
                      <xsl:for-each select="html:ul//html:li">
                        <xsl:choose>
                          <xsl:when test="not(html:a)"/>
                          <xsl:when test="contains(html:a/@href,'#')"/>
                          <xsl:otherwise>
                            <reference type="text" href="{html:a/@href}">
                              <xsl:attribute name="title">
                                <xsl:value-of select="normalize-space(html:a[1])"/>
                              </xsl:attribute>
                            </reference>
                          </xsl:otherwise>
                        </xsl:choose>
                      </xsl:for-each>
                    </xsl:if>
                  </xsl:for-each>
                </xsl:otherwise>
              </xsl:choose>
              <!-- dodam za divGen v back -->
              <xsl:for-each select="tei:text/tei:back/tei:divGen">
                <reference type="text" title="{tei:head}" href="{@xml:id}.html"/>
              </xsl:for-each>
              <reference href="titlepageback.html" type="text" title="About this book"/>
            </guide>
          </package>
        </xsl:result-document>
        <xsl:if test="$verbose='true'">
          <xsl:message>write file OPS/titlepage.html</xsl:message>
        </xsl:if>
        <xsl:result-document href="{concat($directory,'/OPS/titlepage.html')}" method="xml">
          <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
            <head>
              <xsl:call-template name="metaHTML">
                <xsl:with-param name="title">Title page</xsl:with-param>
              </xsl:call-template>
              <title>Title page</title>
              <style type="text/css" title="override_css">
		              @page {padding: 0pt; margin:0pt}
		               body { text-align: center; padding:0pt; margin: 0pt; }
	            </style>
            </head>
            <body>
              <xsl:choose>
                <xsl:when test="$coverImageInside=''">
                  <div class="EpubCoverPage">
                    <xsl:sequence select="tei:generateTitle(.)"/>
                  </div>
                </xsl:when>
                <xsl:otherwise>
                  <div>
                    <img width="{$viewPortWidth}" height="{$viewPortHeight}" alt="cover picture" src="{$coverImageInside}"/>
                  </div>
                </xsl:otherwise>
              </xsl:choose>
            </body>
          </html>
        </xsl:result-document>
        
        <!--<xsl:for-each select="tei:text/tei:front/tei:titlePage">
          <xsl:variable name="N" select="position()"/>
          <xsl:if test="$verbose='true'">
            <xsl:message>write file OPS/titlepage<xsl:value-of select="$N"/>.html</xsl:message>
          </xsl:if>
          <xsl:result-document href="{concat($directory,'/OPS/titlepage',$N,'.html')}" method="xml">
            <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
              <head>
                <xsl:call-template name="metaHTML">
                  <xsl:with-param name="title">Title page</xsl:with-param>
                </xsl:call-template>
                <xsl:call-template name="linkCSS">
		              <xsl:with-param name="file">stylesheet.css</xsl:with-param>
		            </xsl:call-template>
                <title>Title page</title>
              </head>
              <body>
                <div class="titlePage">
                  <xsl:apply-templates/>
                </div>
              </body>
            </html>
          </xsl:result-document>
        </xsl:for-each>-->
        <xsl:if test="$filePerPage='true'">
          <xsl:if test="$verbose='true'">
            <xsl:message>write file OPS/titlepageverso.html</xsl:message>
          </xsl:if>
          <xsl:result-document href="{concat($directory,'/OPS/titlepageverso.html')}" method="xml">
            <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
              <head>
                <xsl:call-template name="metaHTML">
                  <xsl:with-param name="title">title page verso</xsl:with-param>
                </xsl:call-template>
                <title>title page verso</title>
              </head>
              <body>
                <p/>
              </body>
            </html>
          </xsl:result-document>
        </xsl:if>
        <!-- titlepageback.html, ki je avtomatično prisoten v ePub, ki se procesira iz TEI,
             bo namesto delov teiHeader vseboval mojo celotno HTML pretvorbo za teiHeader.
             VEdno se to izpiše, v ePub pa prikaže samo takrat, ko je prikazan tudi v HTML publikaciji
        -->
        <xsl:if test="$verbose='true'">
          <xsl:message>write file OPS/titlepageback.html</xsl:message>
        </xsl:if>
        <xsl:result-document href="{concat($directory,'/OPS/titlepageback.html')}" method="xml">
          <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
            <head>
              <xsl:call-template name="metaHTML">
                <!--<xsl:with-param name="title">About this book</xsl:with-param>-->
                <xsl:with-param name="title">TEI Header</xsl:with-param>
              </xsl:call-template>
              <!-- dodam css -->
              <xsl:call-template name="linkCSS">
                <xsl:with-param name="file">stylesheet.css</xsl:with-param>
              </xsl:call-template>
              <!--<title>About this book</title>-->
              <title>TEI Header</title>
            </head>
            <body>
              <!-- odstranil v spodnjem div oblikovanje style="text-align: left; font-size: larger" -->
              <div>
                <h2>TEI Header</h2>
                <!--<h2>Information about this book</h2>
                <xsl:for-each select="/*/tei:teiHeader/tei:fileDesc">
                  <xsl:apply-templates mode="metadata"/>
                </xsl:for-each>
                <xsl:for-each select="/*/tei:teiHeader/tei:encodingDesc">
                  <xsl:apply-templates mode="metadata"/>
                </xsl:for-each>-->
                <xsl:apply-templates select="ancestor-or-self::tei:TEI/tei:teiHeader"/>
              </div>
            </body>
          </html>
        </xsl:result-document>
        <xsl:if test="$verbose='true'">
          <xsl:message>write file OPS/toc.ncx</xsl:message>
        </xsl:if>
        <xsl:result-document href="{concat($directory,'/OPS/toc.ncx')}" method="xml">
          <ncx xmlns="http://www.daisy.org/z3986/2005/ncx/" version="2005-1">
            <head>
              <meta name="dtb:uid">
                <xsl:attribute name="content">
                  <xsl:call-template name="generateID"/>
                </xsl:attribute>
              </meta>
              <meta name="dtb:totalPageCount" content="0"/>
              <meta name="dtb:maxPageNumber" content="0"/>
            </head>
            <docTitle>
              <text>
                <xsl:sequence select="tei:generateSimpleTitle(.)"/>
              </text>
            </docTitle>
            <navMap>
              <xsl:variable name="navPoints">
                <navPoint>
                  <navLabel>
                    <text>[Cover]</text>
                  </navLabel>
                  <content src="titlepage.html"/>
                </navPoint>
                <!--<xsl:for-each select="tei:text/tei:front/tei:titlePage[1]">
                  <xsl:variable name="N" select="position()"/>
                  <navPoint>
                    <navLabel>
                      <text>[Title page]</text>
                    </navLabel>
                    <content src="titlepage{$N}.html"/>
                  </navPoint>
                </xsl:for-each>-->
                <!-- dodam za divGen v front -->
                <xsl:for-each select="tei:text/tei:front/tei:divGen[not(@type='search')][not(@type='teiHeader')]">
                  <navPoint>
                    <navLabel>
                      <text>
                        <xsl:value-of select="tei:head"/>
                      </text>
                    </navLabel>
                    <content src="{@xml:id}.html"/>
                  </navPoint>
                </xsl:for-each>
                <xsl:choose>
                  <xsl:when test="not($TOC/html:TOC/html:ul[@class='toc toc_body']/html:li)">
                    <xsl:for-each select="$TOC/html:TOC/html:ul[@class='toc toc_front']">
                      <xsl:apply-templates select="html:li"/>
                    </xsl:for-each>
                    <navPoint>
                      <navLabel>
                        <text>[The book]</text>
                      </navLabel>
                      <content src="index.html"/>
                    </navPoint>
                    <xsl:for-each select="$TOC/html:TOC/html:ul[contains(@class,'group')]">
                      <xsl:apply-templates select=".//html:li[not(contains(html:a/@href,'#'))]"/>
                    </xsl:for-each>
                    <xsl:for-each select="$TOC/html:TOC/html:ul[@class='toc toc_back']">
                      <xsl:apply-templates select="html:li"/>
                    </xsl:for-each>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:for-each select="$TOC/html:TOC/html:ul">
                      <xsl:apply-templates select="html:li"/>
                    </xsl:for-each>
                  </xsl:otherwise>
                </xsl:choose>
                <!-- dodam za divGen v back -->
                <xsl:for-each select="tei:text/tei:back/tei:divGen">
                  <navPoint>
                    <navLabel>
                      <text>
                        <xsl:value-of select="tei:head"/>
                      </text>
                    </navLabel>
                    <content src="{@xml:id}.html"/>
                  </navPoint>
                </xsl:for-each>
                <navPoint>
                  <navLabel>
                    <!--<text>[About this book]</text>-->
                    <text>[TEI Header]</text>
                  </navLabel>
                  <content src="titlepageback.html"/>
                </navPoint>
              </xsl:variable>
              <xsl:for-each select="$navPoints/ncx:navPoint">
                <xsl:variable name="pos" select="position()"/>
                <navPoint id="navPoint-{$pos}" playOrder="{$pos}">
                  <xsl:copy-of select="*"/>
                </navPoint>
              </xsl:for-each>
            </navMap>
          </ncx>
        </xsl:result-document>
        <xsl:if test="$filePerPage='true'">
          <xsl:if test="$verbose='true'">
            <xsl:message>write file META-INF/com.apple.ibooks.display-options.xml</xsl:message>
          </xsl:if>
          <xsl:result-document href="{concat($directory,'/META-INF/com.apple.ibooks.display-options.xml')}">
            <display_options xmlns="">
              <platform name="*">
                <option name="fixed-layout">true</option>
              </platform>
            </display_options>
          </xsl:result-document>
        </xsl:if>
        <xsl:if test="$debug='true'">
          <xsl:message>write file OPS/epubtoc.html</xsl:message>
        </xsl:if>
        <!-- To bom moral spremeniti, ker se lahko zgodi, da bom tudi jaz iz divGen gereriral toc.html:
             - sem spremenil ime dokumenta iz toc.html v epubtoc.html
        -->
        <xsl:result-document href="{concat($directory,'/OPS/epubtoc.html')}" method="xml" doctype-system="">
          <html xmlns="http://www.w3.org/1999/xhtml" xmlns:epub="http://www.idpf.org/2007/ops">
            <head>
              <title>
                <xsl:sequence select="tei:generateSimpleTitle(.)"/>
              </title>
                <xsl:call-template name="linkCSS">
		              <xsl:with-param name="file">stylesheet.css</xsl:with-param>
		            </xsl:call-template>
            </head>
            <body>
              <section class="TableOfContents">
                <header>
                  <h1>Contents</h1>
                </header>
                <nav xmlns:epub="http://www.idpf.org/2007/ops" epub:type="toc" id="toc">
                  <ol>
                    <!-- dodam za divGen v front -->
                    <xsl:for-each select="tei:text/tei:front/tei:divGen[not(@type='search')][not(@type='teiHeader')]">
                      <li>
                        <a href="{@xml:id}.html">
                          <xsl:value-of select="tei:head"/>
                        </a>
                      </li>
                    </xsl:for-each>
                    <xsl:for-each select="$TOC/html:TOC/html:ul/html:li">
                      <xsl:choose>
                        <xsl:when test="not(html:a)"/>
                        <xsl:when test="starts-with(html:a/@href,'#')"/>
                        <xsl:when test="contains(@class,'headless')"/>
                        <xsl:otherwise>
                          <li>
                            <a href="{html:a/@href}">
                              <xsl:value-of select="html:span[@class='headingNumber']"/>
                              <xsl:value-of select="normalize-space(html:a[1])"/>
                            </a>
                          </li>
                        </xsl:otherwise>
                      </xsl:choose>
                    </xsl:for-each>
                    <!-- dodam za divGen v back -->
                    <xsl:for-each select="tei:text/tei:back/tei:divGen">
                      <li>
                        <a href="{@xml:id}.html">
                          <xsl:value-of select="tei:head"/>
                        </a>
                      </li>
                    </xsl:for-each>
                    <li>
                      <a href="titlepageback.html">[About this book]</a>
                    </li>
                  </ol>
                </nav>
                <nav xmlns:epub="http://www.idpf.org/2007/ops" epub:type="landmarks" id="guide">
                  <h2>Guide</h2>
                  <ol>
                    <li>
                      <a epub:type="titlepage" href="titlepage.html">[Title page]</a>
                    </li>
                    <li>
                      <a epub:type="bodymatter" href="index.html">[The book]</a>
                    </li>
                    <li>
                      <a epub:type="colophon" href="titlepageback.html">[About this book]</a>
                    </li>
                  </ol>
                </nav>
              </section>
            </body>
          </html>
        </xsl:result-document>
      </xsl:for-each>
    </xsl:for-each>
    <xsl:call-template name="getgraphics"/>
  </xsl:template>
  
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>Izbrani divGen, ki so primerni za ePub (npr. ne procesiram search in teiHeader,
      ki ga v ePub vedno dodam nakoncu))</desc>
  </doc>
  <xsl:template match="tei:divGen">
    <xsl:if test=".[@type='cip' or @type='toc' or @type='index']">
      <xsl:variable name="Name" select="@xml:id"/>
      <xsl:if test="$verbose='true'">
        <xsl:message>write file OPS/<xsl:value-of select="$Name"/>.html</xsl:message>
      </xsl:if>
      <xsl:result-document href="{concat($directory,'/OPS/',$Name,'.html')}" method="xml">
        <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
          <head>
            <xsl:call-template name="metaHTML">
              <xsl:with-param name="title" select="tei:head"/>
            </xsl:call-template>
            <xsl:call-template name="linkCSS">
              <xsl:with-param name="file">stylesheet.css</xsl:with-param>
            </xsl:call-template>
            <title>
              <xsl:value-of select="tei:head"/>
            </title>
          </head>
          <body>
            <div class="teidivgen">
              <h1 class="maintitle">
                <span class="head">
                  <xsl:value-of select="tei:head"/>
                </span>
              </h1>
              <!-- kolofon CIP -->
              <xsl:if test="self::tei:divGen[@type='cip']">
                <xsl:apply-templates select="ancestor::tei:TEI/tei:teiHeader/tei:fileDesc" mode="kolofon"/>
              </xsl:if>
              <!-- kazalo vsebine toc -->
              <xsl:if test="self::tei:divGen[@type='toc'][@xml:id='toc'] | self::tei:divGen[@type='toc'][tokenize(@xml:id,'-')[last()]='toc']">
                <xsl:call-template name="mainTOC"/>
              </xsl:if>
              <!-- kazalo slik -->
              <xsl:if test="self::tei:divGen[@type='toc'][@xml:id='images'] | self::tei:divGen[@type='toc'][tokenize(@xml:id,'-')[last()]='images']">
                <xsl:call-template name="images">
                  <xsl:with-param name="thisLanguage"/>
                </xsl:call-template>
              </xsl:if>
              <!-- kazalo grafikonov -->
              <xsl:if test="self::tei:divGen[@type='toc'][@xml:id='charts'] | self::tei:divGen[@type='toc'][tokenize(@xml:id,'-')[last()]='charts']">
                <xsl:call-template name="charts">
                  <xsl:with-param name="thisLanguage"/>
                </xsl:call-template>
              </xsl:if>
              <!-- kazalo tabel -->
              <xsl:if test="self::tei:divGen[@type='toc'][@xml:id='tables'] | self::tei:divGen[@type='toc'][tokenize(@xml:id,'-')[last()]='tables']">
                <xsl:call-template name="tables">
                  <xsl:with-param name="thisLanguage"/>
                </xsl:call-template>
              </xsl:if>
              <!-- kazalo vsebine toc, ki izpiše samo glavne naslove poglavij, skupaj z imeni avtorjev poglavij -->
              <xsl:if test="self::tei:divGen[@type='toc'][@xml:id='titleAuthor'] | self::tei:divGen[@type='toc'][tokenize(@xml:id,'-')[last()]='titleAuthor']">
                <xsl:call-template name="TOC-title-author"/>
              </xsl:if>
              <!-- kazalo vsebine toc, ki izpiše samo naslove poglavij, kjer ima div atributa type in xml:id -->
              <xsl:if test="self::tei:divGen[@type='toc'][@xml:id='titleType'] | self::tei:divGen[@type='toc'][tokenize(@xml:id,'-')[last()]='titleType']">
                <xsl:call-template name="TOC-title-type"/>
              </xsl:if>
              <!-- seznam (indeks) oseb -->
              <xsl:if test="self::tei:divGen[@type='index'][@xml:id='persons'] | self::tei:divGen[@type='index'][tokenize(@xml:id,'-')[last()]='persons']">
                <xsl:call-template name="persons"/>
              </xsl:if>
              <!-- seznam (indeks) krajev -->
              <xsl:if test="self::tei:divGen[@type='index'][@xml:id='places'] | self::tei:divGen[@type='index'][tokenize(@xml:id,'-')[last()]='places']">
                <xsl:call-template name="places"/>
              </xsl:if>
              <!-- seznam (indeks) organizacij -->
              <xsl:if test="self::tei:divGen[@type='index'][@xml:id='organizations'] | self::tei:divGen[@type='index'][tokenize(@xml:id,'-')[last()]='organizations']">
                <xsl:call-template name="organizations"/>
              </xsl:if>
            </div>
          </body>
        </html>
      </xsl:result-document>
    </xsl:if>
  </xsl:template>
  
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>Vzamem iz ../../Stylesheets-dev/epub3/tei-to-epub3.xsl</desc>
    <param name="author"/>
    <param name="printAuthor"/>
    <param name="coverImageOutside"/>
  </doc>
  <xsl:template name="opfmetadata">
    <xsl:param name="author"/>
    <xsl:param name="printAuthor"/>
    <xsl:param name="coverImageOutside"/>
    <xsl:attribute name="prefix">
      <xsl:text>rendition: http://www.idpf.org/vocab/rendition#</xsl:text>
    </xsl:attribute>
    <metadata xmlns="http://www.idpf.org/2007/opf" xmlns:dc="http://purl.org/dc/elements/1.1/"
      xmlns:dcterms="http://purl.org/dc/terms/"
      xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:opf="http://www.idpf.org/2007/opf">
      <dc:title id="title">
        <xsl:sequence select="tei:generateSimpleTitle(.)"/>
      </dc:title>
      <xsl:choose>
        <xsl:when test="$filePerPage = 'true'">
          <meta property="rendition:layout">pre-paginated</meta>
          <meta property="rendition:orientation">auto</meta>
          <meta property="rendition:spread">both</meta>
        </xsl:when>
        <xsl:otherwise>
          <meta property="rendition:layout">reflowable</meta>
          <meta property="rendition:spread">auto</meta>
        </xsl:otherwise>
      </xsl:choose>
      <meta refines="#title" property="title-type">main</meta>
      <dc:creator id="creator">
        <xsl:sequence
          select="
          if ($printAuthor != '') then
          $printAuthor
          else
          'not recorded'"
        />
      </dc:creator>
      <!-- odstranim , ker prikaže še nezaželene elemente znotraj meta -->
      <!--<meta refines="#creator" property="file-as">
        <xsl:sequence
          select="
          if ($author != '') then
          $author
          else
          'not recorded'"
        />
      </meta>-->
      <meta refines="#creator" property="role" scheme="marc:relators">aut</meta>
      <dc:language>
        <xsl:call-template name="generateLanguage"/>
      </dc:language>
      <xsl:call-template name="generateSubject"/>
      <dc:identifier id="pub-id">
        <xsl:call-template name="generateID"/>
      </dc:identifier>
      <meta refines="#pub-id" property="identifier-type" scheme="onix:codelist5">15</meta>
      <dc:description>
        <xsl:sequence select="tei:generateSimpleTitle(.)"/>
        <xsl:text> / </xsl:text>
        <xsl:value-of select="$author"/>
      </dc:description>
      <dc:publisher>
        <xsl:sequence select="tei:generatePublisher(., $publisher)"/>
      </dc:publisher>
      <xsl:for-each select="tei:teiHeader/tei:profileDesc/tei:creation/tei:date[@notAfter]">
        <dc:date id="creation">
          <xsl:value-of select="@notAfter"/>
        </dc:date>
      </xsl:for-each>
      <xsl:for-each select="tei:teiHeader/tei:fileDesc/tei:sourceDesc//tei:date[@when][1]">
        <dc:date id="original-publication">
          <xsl:value-of select="@when"/>
        </dc:date>
      </xsl:for-each>
      <dc:date id="epub-publication">
        <xsl:sequence select="replace(tei:generateDate(.)[1], '[^0-9\-]+', '')"/>
      </dc:date>
      <dc:rights>
        <xsl:call-template name="generateLicence"/>
      </dc:rights>
      <xsl:if test="not($coverImageOutside = '')">
        <meta name="cover" content="cover-image"/>
      </xsl:if>
      <meta property="dcterms:modified">
        <xsl:sequence select="tei:whatsTheDate()"/>
      </meta>
    </metadata>
  </xsl:template>
  
 
  
</xsl:stylesheet>
