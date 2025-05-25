<?xml version="1.0" encoding="UTF-8"?><!-- deklaration -->
<!-- Kod för transformation av (TEI) XML till HTML. -->
<!-- deklaration, namnutrymmen -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:html="http://www.w3.org/1999/xhtml" exclude-result-prefixes="xs tei html" version="2.0"><!-- namnutrymmen ska inte synas i html -->
    <xsl:output method="html"/><!-- bli html -->
    <xsl:template match="tei:TEI"><!-- xsl matchas med rotelementet i tei -->
        <!-- html struktur -->
        <html lang="sv">
            <head>
                <meta charset="UTF-8"/><!-- teckenkodning -->
                <title> Digitaliserad version av "Fosterländsk sång vid Götha Canals öpnande" </title>
                <!-- Externa CSS-filer -->
                <!-- Bootstrap 5.3.2 -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
                    rel="stylesheet"
                    integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
                    crossorigin="anonymous">
                </link>
                <!-- egen CSS-fil -->
                <link rel="stylesheet" href="assets/css/main.css"/>
            </head>
            <body class="page-sangtext">
                <a href="#sangtext" class="skip-link">Hoppa till huvudinnehåll</a>
                <header>
                    <h1>
                        <xsl:apply-templates select="//tei:titleStmt/tei:title"
                        /><!-- h1elementet fylls med title från tei-->
                    </h1>
                </header>
                <nav aria-label="Huvudnavigering"><!-- Navigeringsmeny. Aria-label för att underlätta navigering för tekniska hjälpmedel -->
                    <a href="index.html">Om projektet</a> | 
                    <a href="sanghafte.html">Sånghäfte</a> | 
                    <a href="sangtext.html">Sångtext</a> | 
                    <a href="historia.html">Historia</a> | 
                    <a href="begrepp.html">Begrepp</a>
                </nav>
                <!-- värdet i (main) ska representera textens huvudsakliga innehåll -->
                <main id="sangtext">
                    <article><!-- Article, för att skapa en fristående del -->
                        <div class="container">
                            <!-- div element med @facs attribut i tei blir separata divelement i html -->
                            <xsl:for-each select="//tei:div[@facs]">
                                <xsl:variable name="facs" select="@facs"/>
                                <div>
                                    <xsl:apply-templates/>
                                </div>
                            </xsl:for-each>
                        </div>
                        <div class="button-container">
                            <button onclick="window.print()" aria-label="Skriv ut sidan">Skriv ut texten</button><!--utskriftsknapp -->
                        </div>
                    </article>
                </main>
                <footer><!-- innehåller upphovsrättsinformation och länk till licens -->
                    <div class="footer-row">
                        <div class="footer-content">
                            <div class="copyright_logos">
                                <a href="https://creativecommons.org/licenses/by/4.0/legalcode">
                                    <img src="assets/img/logos/cc.svg" class="copyright_logo"
                                        alt="Creative Commons License"/>
                                    <img src="assets/img/logos/by.svg" class="copyright_logo"
                                        alt="Attribution 4.0 International"/>
                                </a>
                            </div>
                            <div class="copyright_text"> 2025 Marie Gyll, Jessica Hultengren,
                                Susanne Landén och Magdalena af Trolle. </div>
                        </div>
                    </div>
                </footer>
            </body>
        </html>
    </xsl:template>
    <!-- Raderna nedan leder till att den metadata vi inte vill ska visas inte skrivs över till HTML. -->
    <xsl:template match="tei:teiHeader"/><!-- Döljer teiHeaderelementet pga att den inte innehåller några instruktioner -->
    <xsl:template match="tei:front//*"/><!-- Döljer front-elementets underliggande element. -->
    <xsl:template match="tei:note[@type='tryckeri']"/><!-- Döljer elementet pga att den inte innehåller några instruktioner --> 
    <xsl:template match="tei:head"><!-- tei head ska vara h2 -->
        <h2>
            <xsl:apply-templates/>
        </h2>
    </xsl:template>
    <xsl:template match="tei:p"><!-- tei p ska vara html p -->
        <p>
            <xsl:apply-templates/>
        </p> 
    </xsl:template>
    <xsl:template match="tei:lg"><!-- tei lg ska vara html p -->
        <p>
            <xsl:apply-templates/>
        </p> 
    </xsl:template>
    <xsl:template match="tei:lb"><!-- tei lb ska vara html br -->
        <br/>
    </xsl:template>
    <xsl:template match="tei:l"><!-- tei l ska vara html br -->
        <xsl:apply-templates/>
        <br/>
    </xsl:template>
    <xsl:template match="text()"><!-- textnoder utom element i XML till HTML -->
        <xsl:value-of select="."/>
    </xsl:template>
    <xsl:template match="tei:metamark[@place]"><!-- tei metamark med attribut @place ska vara html span med specificerad css och textsträng Sid. -->
        <span style="position:absolute ; left:-3em">
            Sid.
            <xsl:apply-templates/>
        </span>
    </xsl:template>
</xsl:stylesheet>