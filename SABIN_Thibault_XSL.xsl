<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="1.0">
    
    <!-- Déclaration du fichier de sortie -->
    <xsl:output method="text" encoding="UTF-8"/>
    
    <!-- Variables pour stocker des informations -->
    <xsl:variable name="title" select="//tei:titleStmt/tei:title"/>
    <xsl:variable name="author" select="//tei:titleStmt/tei:author"/>
    <xsl:variable name="date" select="//tei:publicationStmt/tei:date"/>
    <xsl:variable name="document_description" select="//tei:msContents/tei:p"/>
    <xsl:variable name="compiler" select="//tei:respStmt/tei:name"/>
    
    <!-- Règle pour le document racine -->
    <xsl:template match="/">
        <!-- Début du document LaTeX -->
        <xsl:text>\documentclass[12pt,a4paper]{article}</xsl:text>
        <xsl:text>&#xa;\usepackage[utf8]{inputenc}</xsl:text>
        <xsl:text>&#xa;\usepackage[T1]{fontenc}</xsl:text>
        <xsl:text>&#xa;\usepackage[french]{babel}</xsl:text>
        <xsl:text>&#xa;\usepackage{hyperref}</xsl:text>
        <xsl:text>&#xa;\hypersetup{</xsl:text>
        <xsl:text>&#xa;colorlinks=true,</xsl:text>
        <xsl:text>&#xa;linkcolor=blue,</xsl:text>
        <xsl:text>&#xa;filecolor=magenta,</xsl:text>
        <xsl:text>&#xa;urlcolor=cyan</xsl:text>
        <xsl:text>&#xa;}</xsl:text>
        <xsl:text>&#xa;\usepackage{graphicx}</xsl:text>
        <xsl:text>&#xa;\usepackage{fancyhdr}</xsl:text>
        <xsl:text>&#xa;\usepackage{geometry}</xsl:text>
        <xsl:text>&#xa;\geometry{a4paper, margin=2.5cm}</xsl:text>
        <xsl:text>&#xa;\pagestyle{fancy}</xsl:text>
        <xsl:text>&#xa;\title{</xsl:text><xsl:value-of select="$title"/><xsl:text>}</xsl:text>
        <xsl:text>&#xa;\author{</xsl:text><xsl:value-of select="$author"/><xsl:text>}</xsl:text>
        <xsl:text>&#xa;\date{</xsl:text><xsl:value-of select="$date"/><xsl:text>}</xsl:text>
        <xsl:text>&#xa;&#xa;\begin{document}</xsl:text>
        
        <!-- Page de titre -->
        <xsl:text>&#xa;&#xa;% Page de titre</xsl:text>
        <xsl:text>&#xa;\begin{titlepage}</xsl:text>
        <xsl:text>&#xa;\centering</xsl:text>
        <xsl:text>&#xa;\vspace*{1cm}</xsl:text>
        <xsl:text>&#xa;{\huge\bfseries </xsl:text><xsl:value-of select="$title"/><xsl:text>\\}</xsl:text>
        <xsl:text>&#xa;\vspace{1.5cm}</xsl:text>
        <xsl:text>&#xa;{\Large </xsl:text><xsl:value-of select="$author"/><xsl:text>\\}</xsl:text>
        <xsl:text>&#xa;\vspace{0.5cm}</xsl:text>
        <xsl:text>&#xa;{\large Document original daté du </xsl:text>
        <xsl:choose>
            <xsl:when test="//tei:correspAction[@type='sent']/tei:date/@when">
                <xsl:value-of select="//tei:correspAction[@type='sent']/tei:date/@when"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$date"/>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:text>\\}</xsl:text>
        <xsl:text>&#xa;\vspace{1cm}</xsl:text>
        
        <!-- Description du document -->
        <xsl:text>&#xa;% Informations supplémentaires</xsl:text>
        <xsl:text>&#xa;\begin{minipage}{0.9\textwidth}</xsl:text>
        <xsl:text>&#xa;\begin{center}</xsl:text>
        <xsl:text>&#xa;\large\textbf{Description du document:}\\</xsl:text>
        <xsl:text>&#xa;\vspace{0.3cm}</xsl:text>
        <xsl:text>&#xa;\normalsize </xsl:text>
        <xsl:choose>
            <xsl:when test="$document_description">
                <xsl:value-of select="$document_description"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>Transcription d'un document historique</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:text>&#xa;\end{center}</xsl:text>
        <xsl:text>&#xa;\end{minipage}</xsl:text> 
        <xsl:text>&#xa;\vfill</xsl:text>
        
        <!-- Informations sur le compilateur -->
        <xsl:text>&#xa;% Compiler informations</xsl:text>
        <xsl:if test="$compiler">
            <xsl:text>&#xa;{\large Compilé par: </xsl:text>
            <xsl:value-of select="$compiler"/>
            <xsl:text>\\}</xsl:text>
        </xsl:if>
        <xsl:text>&#xa;{\large Date de compilation: </xsl:text>
        <xsl:value-of select="$date"/>
        <xsl:text>\\}</xsl:text>
        <xsl:text>&#xa;\vfill</xsl:text>
        <xsl:text>&#xa;\end{titlepage}</xsl:text>
        
        <!-- Table des matières -->
        <xsl:text>&#xa;&#xa;\tableofcontents</xsl:text>
        <xsl:text>&#xa;&#xa;\newpage</xsl:text>
        
        <!-- Appel des templates pour les différentes sections -->
        <xsl:apply-templates select="//tei:text"/>
        
        <!-- Fin du document LaTeX -->
        <xsl:text>&#xa;&#xa;\end{document}</xsl:text>
    </xsl:template>
    
    <!-- Règle pour le corps du texte -->
    <xsl:template match="tei:text">
        <xsl:apply-templates select="tei:front"/>
        <xsl:apply-templates select="tei:body"/>
        <xsl:apply-templates select="tei:back"/>
    </xsl:template>
    
    <!-- Règle pour la section front -->
    <xsl:template match="tei:front">
        <xsl:text>&#xa;&#xa;\section{En-tête}</xsl:text>
        <xsl:apply-templates select="tei:head"/>
    </xsl:template>
    
    <!-- Règle pour la section head -->
    <xsl:template match="tei:head">
        <!-- Application du template pour la figure -->
        <xsl:apply-templates select="tei:figure"/>
        
        <!-- Centrer les informations d'en-tête -->
        <xsl:text>&#xa;&#xa;\begin{center}</xsl:text>
        
        <!-- Nom de la société -->
        <xsl:if test="tei:persName">
            <xsl:text>&#xa;\textbf{\large </xsl:text>
            <xsl:value-of select="tei:persName"/>
            <xsl:text>}</xsl:text>
        </xsl:if>
        
        <!-- Adresse de la société -->
        <xsl:if test="tei:address">
            <xsl:for-each select="tei:address/tei:addrLine">
                <xsl:text>&#xa;\\</xsl:text>
                <xsl:value-of select="."/>
            </xsl:for-each>
        </xsl:if>
        
        <!-- Numéros de téléphone de la société -->
        <xsl:if test="tei:num[@type='phoneNumber']">
            <xsl:text>&#xa;</xsl:text>
            <xsl:value-of select="tei:num[@type='phoneNumber']"/>
        </xsl:if>
        
        <!-- Information télégraphique de la société -->
        <xsl:if test="tei:num[@type='telegraphicAddress']">
            <xsl:text>&#xa;</xsl:text>
            <xsl:value-of select="tei:num[@type='telegraphicAddress']"/>
        </xsl:if>
        
        <xsl:text>&#xa;\end{center}</xsl:text>
        
        <!-- Liste des lieux avec un espacement avant et retour à la ligne pour chaque lieu -->
        <xsl:if test="tei:listPlace">
            <xsl:text>&#xa;&#xa;</xsl:text>
            <xsl:apply-templates select="tei:listPlace"/>
        </xsl:if>
    </xsl:template>
    
    <!-- Règle pour les figures -->
    <xsl:template match="tei:figure">
        <xsl:text>&#xa;Figure: </xsl:text>
        <xsl:value-of select="tei:figDesc"/>
        <xsl:text>&#xa;</xsl:text>
    </xsl:template>
    
    <!-- Règle pour les listes de lieux -->
    <xsl:template match="tei:listPlace">
        <xsl:for-each select="tei:place/tei:settlement">
            <xsl:text>&#xa;- </xsl:text>
            <xsl:value-of select="tei:address/tei:addrLine[1]"/>
            <xsl:if test="tei:address/tei:addrLine[2]">
                <xsl:text>, </xsl:text>
                <xsl:value-of select="tei:address/tei:addrLine[2]"/>
            </xsl:if>
            <xsl:if test="tei:address/tei:num">
                <xsl:text> (</xsl:text>
                <xsl:value-of select="tei:address/tei:num"/>
                <xsl:text>)</xsl:text>
            </xsl:if>
            <xsl:text>\\</xsl:text> <!-- Ajoute un retour à la ligne après chaque élément -->
        </xsl:for-each>
    </xsl:template>
    
    <!-- Règle pour le corps du texte -->
    <xsl:template match="tei:body">
        <xsl:text>&#xa;&#xa;\section{Corps du texte}</xsl:text>
        <xsl:apply-templates select="tei:opener"/>
        <xsl:apply-templates select="tei:p|tei:note"/>
    </xsl:template>
    
    <!-- Règle pour l'ouverture -->
    <xsl:template match="tei:opener">
        <!-- Date, lieu, adresse alignés à droite -->
        <xsl:text>&#xa;&#xa;\begin{flushright}</xsl:text>
        <xsl:if test="tei:dateline/tei:placeName">
            <xsl:value-of select="tei:dateline/tei:placeName"/>
            <xsl:text>, </xsl:text>
        </xsl:if>
        <xsl:if test="tei:dateline/tei:date">
            <xsl:value-of select="tei:dateline/tei:date"/>
            <xsl:text>&#xa;&#xa;</xsl:text>
        </xsl:if>
        <xsl:if test="tei:address/tei:persName">
            <xsl:value-of select="tei:address/tei:persName"/>
        </xsl:if>
        <xsl:for-each select="tei:address/tei:addrLine">
            <xsl:text>&#xa;&#xa;</xsl:text>
            <xsl:value-of select="."/>
        </xsl:for-each>
        <xsl:text>&#xa;&#xa;\end{flushright}</xsl:text>
        
        <!-- Salutation -->
        <xsl:text>&#xa;&#xa;</xsl:text>
        <xsl:if test="tei:salute">
            <xsl:value-of select="tei:salute"/>
        </xsl:if>
        <xsl:text>&#xa;&#xa;</xsl:text>
        
    </xsl:template>
    
    <!-- Suppression du traitement spécifique de dateline car il est intégré dans opener -->
    <xsl:template match="tei:dateline">
        <!-- Template vide pour éviter le double traitement -->
    </xsl:template>
    
    <!-- Suppression du traitement spécifique de la note "DIRECTION" -->
    <xsl:template match="tei:note[tei:p='DIRECTION']">
        <!-- Template vide pour supprimer cette note -->
    </xsl:template>
    
    <!-- Règle pour les paragraphes -->
    <xsl:template match="tei:p">
        <xsl:apply-templates/>
        <!-- Règle pour les notes de bas de page -->
        <xsl:variable name="currentPosition" select="position()"/>
        <xsl:for-each select="following-sibling::tei:note[@place='margin'][not(tei:p='DIRECTION')][1]">
            <xsl:if test="count(preceding-sibling::tei:p) = $currentPosition">
                <xsl:text>\footnote{</xsl:text>
                <xsl:for-each select="tei:p">
                    <xsl:value-of select="."/>
                    <xsl:if test="position() != last()">
                        <xsl:text>. </xsl:text>
                    </xsl:if>
                </xsl:for-each>
                <xsl:text>}</xsl:text>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    
    <!-- Règle pour ne pas traiter la note "DIRECTION" -->
    <xsl:template match="tei:note[@place='margin'][not(tei:p='DIRECTION')]">
        <!-- Règle vide, le traitement est effectué dans le template pour tei:p -->
    </xsl:template>
    
    <!-- Règle pour la section back -->
    <xsl:template match="tei:back">
        <xsl:text>&#xa;&#xa;\section{Formule de politesse}</xsl:text>
        <xsl:apply-templates select="tei:closer"/>
    </xsl:template>
    
    <!-- Règle pour la clôture -->
    <xsl:template match="tei:closer">
        <xsl:apply-templates select="tei:salute"/>
        <xsl:apply-templates select="tei:signed"/>
    </xsl:template>
    
    <!-- Règle pour la signature -->
    <xsl:template match="tei:signed">
        <xsl:text>&#xa;&#xa;\begin{flushright}</xsl:text>
        <xsl:choose>
            <xsl:when test="tei:name">
                <xsl:text>&#xa;\textit{</xsl:text>
                <xsl:value-of select="tei:name"/>
                <xsl:text>}</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>&#xa;\textit{</xsl:text>
                <xsl:value-of select="."/>
                <xsl:text>}</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:text>&#xa;\end{flushright}</xsl:text>
    </xsl:template>
    
</xsl:stylesheet>