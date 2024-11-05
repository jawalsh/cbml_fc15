<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:cbml="http://www.cbml.org/ns/1.0" exclude-result-prefixes="xs" xpath-default-namespace="http://www.tei-c.org/ns/1.0" version="2.0">
  <xsl:output method="xml" encoding="utf-8" version="1.0" indent="yes" standalone="no" media-type="text/html" omit-xml-declaration="no" doctype-system="about:legacy-compat"/>
  <xsl:param name="iiif_base" select="'https://images.biblicon.org/iiif/3/'"/>
  <xsl:param name="panel_width" select="'30rem'"/>
  <xsl:template match="xsl:stylesheet">
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="/">
    <xsl:call-template name="docInfo"/>
    <xsl:call-template name="get-doctitle"/>
    <xsl:apply-templates select="/TEI/text"/>
  </xsl:template>
  <xsl:template name="get-doctitle">
    <xsl:result-document href="#htmlTitle">
      <xsl:value-of select="normalize-space(/TEI/teiHeader[1]/fileDesc[1]/titleStmt[1]/title[1])"/>
    </xsl:result-document>
  </xsl:template>
  <xsl:template match="/TEI/text">
    <xsl:result-document href="#teiText">
      <xsl:apply-templates/>
    </xsl:result-document>
  </xsl:template>
  <xsl:template name="docInfo">
    <xsl:result-document href="#teiDocInfo">
      <h1>
        <xsl:value-of select="/TEI/teiHeader[1]/fileDesc[1]/titleStmt[1]/title[1]"/>
      </h1>
      <p>Edited by
                <xsl:for-each select="/TEI/teiHeader[1]/fileDesc[1]/titleStmt[1]/editor"><xsl:value-of select="normalize-space(.)"/></xsl:for-each>
            </p>
      <div>
        <h2>source information</h2>
        <xsl:apply-templates select="/TEI/teiHeader[1]/fileDesc[1]/sourceDesc[1]"/>
      </div>
    </xsl:result-document>
  </xsl:template>
  <xsl:template match="sourceDesc">
    <ul>
      <li>
        <span>title: </span>
        <xsl:value-of select="normalize-space(biblStruct/monogr/title)"/>
        <xsl:if test="biblStruct/monogr/imprint/biblScope[@unit = 'issue']">
          <xsl:value-of select="concat(' #', normalize-space(biblStruct/monogr/imprint/biblScope[@unit = 'issue']))"/>
        </xsl:if>
      </li>
      <xsl:if test="biblStruct/monogr/imprint/date/@when">
        <li>
          <span>date: </span>
          <xsl:call-template name="print-human-date">
            <xsl:with-param name="date" select="biblStruct/monogr/imprint/date/@when"/>
          </xsl:call-template>
        </li>
      </xsl:if>
      <li>
        <span>publisher: </span>
        <xsl:value-of select="biblStruct/monogr/imprint/publisher"/>
      </li>
    </ul>
  </xsl:template>
  <xsl:template name="print-human-date">
    <xsl:param name="date"/>
    <xsl:if test="string-length($date) = 10">
      <xsl:call-template name="date-get-day">
        <xsl:with-param name="date" select="$date"/>
      </xsl:call-template>
      <xsl:value-of select="' '"/>
    </xsl:if>
    <xsl:if test="(string-length($date) = 10) or (string-length($date) = 7)">
      <xsl:call-template name="date-get-month">
        <xsl:with-param name="date" select="$date"/>
      </xsl:call-template>
      <xsl:value-of select="' '"/>
    </xsl:if>
    <xsl:call-template name="date-get-year">
      <xsl:with-param name="date" select="$date"/>
    </xsl:call-template>
  </xsl:template>
  <xsl:template name="date-get-year">
    <xsl:param name="date"/>
    <xsl:value-of select="substring($date, 1, 4)"/>
  </xsl:template>
  <xsl:template name="date-get-month">
    <xsl:param name="date"/>
    <xsl:param name="month" select="substring($date, 6, 2)"/>
    <xsl:choose>
      <xsl:when test="$month = '01'">
        <xsl:value-of select="'January'"/>
      </xsl:when>
      <xsl:when test="$month = '02'">
        <xsl:value-of select="'February'"/>
      </xsl:when>
      <xsl:when test="$month = '03'">
        <xsl:value-of select="'March'"/>
      </xsl:when>
      <xsl:when test="$month = '04'">
        <xsl:value-of select="'April'"/>
      </xsl:when>
      <xsl:when test="$month = '05'">
        <xsl:value-of select="'May'"/>
      </xsl:when>
      <xsl:when test="$month = '06'">
        <xsl:value-of select="'June'"/>
      </xsl:when>
      <xsl:when test="$month = '07'">
        <xsl:value-of select="'July'"/>
      </xsl:when>
      <xsl:when test="$month = '08'">
        <xsl:value-of select="'August'"/>
      </xsl:when>
      <xsl:when test="$month = '09'">
        <xsl:value-of select="'September'"/>
      </xsl:when>
      <xsl:when test="$month = '10'">
        <xsl:value-of select="'October'"/>
      </xsl:when>
      <xsl:when test="$month = '11'">
        <xsl:value-of select="'November'"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="'December'"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="date-get-day">
    <xsl:param name="date"/>
    <xsl:param name="day" select="substring($date, 9, 2)"/>
    <xsl:choose>
      <xsl:when test="substring($day,1,1) = '0'">
        <xsl:value-of select="substring($day, 2, 1)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$day"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="*">
    <xsl:element name="span">
      <xsl:call-template name="add-class"/>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:element>
  </xsl:template>
  <!-- block elements -->
  <xsl:template match="div|p|head|fw">
    <xsl:element name="div">
      <xsl:call-template name="add-class"/>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="fw[@type='pageNum']">
	  <button type="button" class="btn btn-outline-dark">
		  <xsl:attribute name="style">
			  <xsl:choose>
				  <xsl:when test="@place = 'right'">
					  <xsl:value-of select="'float:right;'"/>
				  </xsl:when>
			  </xsl:choose>
		  </xsl:attribute>
		<xsl:apply-templates/>
	  </button>
  </xsl:template>


  <xsl:template match="fw[@place = 'top']">
	  <xsl:element name="div">
		  <div class="card" style="{concat('width: ',$panel_width,';')}">
			  <div class="card-body">
				  <h5>
		  			  <xsl:call-template name="add-class">
						  <xsl:with-param name="class" select="'card-title'"/>
					  </xsl:call-template>
					  <xsl:apply-templates select="@* | node()"/>
				  </h5>
				  <div class="card-text">
					  <xsl:value-of select="'[running header]'"/>
				  </div>
			  </div>
		  </div>
	  </xsl:element>
  </xsl:template>

  <xsl:template match="cbml:panel">
	  <div class="panel">
		  <div class="card" style="{concat('width: ',$panel_width,';')}">
      <xsl:apply-templates select="@facs" mode="card-img"/>
      <div class="card-body">
        <xsl:apply-templates select="@* | node()"/>
      </div>
    </div>
    </div>
  </xsl:template>
  <xsl:template match="sound|byline|cbml:caption|cbml:balloon">
	  <div>
		  <xsl:call-template name="add-class">
			  <xsl:with-param name="class">
				  <xsl:choose>
					  <xsl:when test="local-name() = 'sound'">
				  <xsl:value-of select="'alert alert-danger'"/>
			  </xsl:when>
			  <xsl:when test="local-name() = 'caption' or local-name() = 'byline'">
				  <xsl:value-of select="'alert alert-warning'"/>
			  </xsl:when>
			  <xsl:when test="local-name() = 'balloon'">
				  <xsl:value-of select="'alert alert-light'"/>
			  </xsl:when>
		  </xsl:choose>

			  </xsl:with-param>
		  </xsl:call-template>
		    <xsl:if test="@who">
        <div>
          <xsl:apply-templates select="@who"/>
        </div>
      </xsl:if>

		  <xsl:apply-templates/>
	  </div>
  </xsl:template>
  <xsl:template match="cbml:blalloon">
    <div>
      <xsl:call-template name="add-class">
        <xsl:with-param name="class">
          <xsl:choose>
            <xsl:when test="local-name()='caption' or local-name()='byline'">
              <xsl:value-of select="'text-bg-warning'"/>
            </xsl:when>
	    <xsl:when test="local-name()='sound'">
              <xsl:value-of select="'text-bg-info'"/>
	    </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="''"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:with-param>
      </xsl:call-template>
      <xsl:if test="@who">
        <div>
          <xsl:apply-templates select="@who"/>
        </div>
      </xsl:if>
      <div>
        <xsl:apply-templates select="node()"/>
      </div>
    </div>
  </xsl:template>
  <xsl:template match="@who">
    <xsl:param name="person-id" select="substring-after(., '#')"/>
    <strong>
      <xsl:call-template name="add-class">
        <xsl:with-param name="class" select="'who'"/>
      </xsl:call-template>
      <xsl:value-of select="/TEI/teiHeader/profileDesc/particDesc/listPerson/person[@xml:id = $person-id]/name"/>
    </strong>
  </xsl:template>
  <xsl:template match="cbml:panel/@facs" mode="card-img">
    <xsl:param name="zone-id" select="(substring-after(., '#'))"/>
    <a>
      <xsl:attribute name="href">
        <xsl:apply-templates select="/TEI/facsimile/surface/zone[@xml:id = $zone-id]" mode="zone-link">
          <xsl:with-param name="size" select="'1200,'"/>
        </xsl:apply-templates>
      </xsl:attribute>
      <img class="card-img-top">
        <xsl:attribute name="src">
          <xsl:apply-templates select="/TEI/facsimile/surface/zone[@xml:id = $zone-id]" mode="zone-link">
            <xsl:with-param name="size">
              <xsl:value-of select="'500,'"/>
            </xsl:with-param>
          </xsl:apply-templates>
        </xsl:attribute>
      </img>
    </a>
  </xsl:template>
  <xsl:template match="pb">
    <xsl:param name="facs-id" select="(substring-after(@facs, '#'))"/>
    <div class="pb">
    <figure class="figure">
      <a>
        <xsl:attribute name="href">
          <xsl:apply-templates select="/TEI/facsimile/surface[@xml:id = $facs-id]/graphic" mode="page-link">
            <xsl:with-param name="size" select="'1200,'"/>
          </xsl:apply-templates>
        </xsl:attribute>
        <img class="figure-img img-fluid">
          <xsl:attribute name="src">
            <xsl:apply-templates select="/TEI/facsimile/surface[@xml:id = $facs-id]/graphic" mode="page-link">
              <xsl:with-param name="size">
                <xsl:value-of select="'400,'"/>
              </xsl:with-param>
            </xsl:apply-templates>
          </xsl:attribute>
        </img>
      </a>
    </figure>
	</div>
  </xsl:template>
  <xsl:template match="graphic" mode="page-link">
    <xsl:param name="filename" select="@url"/>
    <xsl:param name="size"/>
    <xsl:value-of select="concat($iiif_base, $filename, '/full/', $size, '/0/', 'default.jpg')"/>
  </xsl:template>
  <xsl:template match="zone" mode="zone-link">
    <xsl:param name="ulx" select="@ulx"/>
    <xsl:param name="uly" select="@uly"/>
    <xsl:param name="lrx" select="@lrx"/>
    <xsl:param name="lry" select="@lry"/>
    <xsl:param name="w" select="$lrx - $ulx"/>
    <xsl:param name="h" select="$lry - $uly"/>
    <xsl:param name="filename" select="preceding-sibling::graphic/@url"/>
    <xsl:param name="size"/>
    <xsl:value-of select="concat($iiif_base, $filename, '/', $ulx, ',', $uly, ',', $w, ',', $h, '/', $size, '/0/', 'default.jpg')"/>
  </xsl:template>
  <xsl:template match="@*"/>
  <xsl:template match="lb">
    <br/>
  </xsl:template>
  <xsl:template name="add-class">
    <xsl:param name="class"/>
    <xsl:attribute name="class">
      <xsl:value-of select="concat(local-name(.), ' ')"/>
      <xsl:if test="@type">
        <xsl:value-of select="concat(@type, ' ')"/>
      </xsl:if>
      <xsl:if test="@place">
        <xsl:value-of select="concat(@place, ' ')"/>
      </xsl:if>
      <xsl:if test="$class != ''">
        <xsl:value-of select="concat($class, ' ')"/>
      </xsl:if>
      <xsl:if test="@rendition">
        <xsl:call-template name="renditionToClassNames">
          <xsl:with-param name="string" select="@rendition"/>
        </xsl:call-template>
      </xsl:if>
    </xsl:attribute>
  </xsl:template>
  <xsl:template name="renditionToClassNames">
    <xsl:param name="string"/>
    <xsl:param name="delimiter" select="' '"/>
    <xsl:choose>
      <xsl:when test="$delimiter and contains($string, $delimiter)">
        <xsl:value-of select="substring-after(substring-before($string, $delimiter), '#')"/>
        <xsl:value-of select="' '"/>
        <xsl:call-template name="renditionToClassNames">
          <xsl:with-param name="string" select="substring-after($string, $delimiter)"/>
          <xsl:with-param name="delimiter" select="$delimiter"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="substring-after($string, '#')"/>
        <xsl:value-of select="' '"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
