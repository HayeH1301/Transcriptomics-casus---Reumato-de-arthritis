<p align="center">
  <img src="Assets/Afbeelding.jpg" alt="Afbeelding" width="600"/>
</p>

## Reumatoïde arthritis casus - Transcriptomics 
 Door: Haye Hoeksema
 
**Inleiding:**
Reumatoïde artritis (RA) is een systemische auto-immuunziekte die chronische ontsteking ontwaakt in de gewrichten. Pathologische veranderingen aan de structuur van het synoviaal stroma, dat zich bekleed aan de binnenkant van het gewricht kunnen hierdoor ontstaan. B-cellen, macrofagen, CD4<sup>+</sup>-cellen en verschillende onstekingsvormende cytokinen zoals Tumor Necrosis Factor (TNF) en Prostaglandine E2 (PGE2) komen bij deze patiënten veel voor in het gewrichtsslijmvlies wat kan lijden tot aanhoudende onsteking en zwelling. RA komt 3-5 keer vaker voor bij vrouwen dan bij mannen en is nog niet te genezen, maar wel te onderdrukken met NSAIDS (nonsteroidal anti-inflammatory drugs) en DMARDS (disease-modifying antirheumatic drugs). Voor onderdrukking van de symptomen wordt er wel zorgen gemaakt over de veiligheid, kosten en respons van de medicatie (Jiang et al., 2025; Singh et al., 2016; Yelin et al., 2017). Hierdoor zou meer informatie over het onstaan van de ziekte veel helpen om ooit genezing mogelijk te maken. 
Van vier mensen met RA en vier mensen zonder RA zijn er samples genomen van het gewrichtslijmvlies (synoviumbiopt), waarbij een Transcriptomics analyse is van uitgevoerd in R. Zo zal er gekeken worden naar verschillende  genen en pathways die (meer/minder) betrokken zijn bij RA vergeleken met gezonde mensen. 


**Refseq van NCBI in R toepassen**

<p align="left">
  <img src="Assets/Flowschema - Github pagina, qPCR.png" alt="Flowschema" width="600"/>
</p>

*Figuur 1: Flowschema van protocol voor dit onderzoek.*

Vier mensen met RA zijn postief getest op auto-antistoffen ACPA en CCP met een diagnose van >12 maanden en Vier mensen waren negatief (controle). Rauwe data van de samples was al verkregen en een kwaliteitscontrole was gedaan. Deze sequenties werden gemapped tegen het menselijk referentiegenoom "Homo_sapiens.GRCh38.dna.toplevel.fa.g" van ENSEMBL, door een index van de verkregen forward -en reverse reads van de samples te vormen. Deze gelijnde reads werden als .BAM bestanden opgeslagen en vervolgens gesorteerd tot één bestand *(Packages: "Rsubread", "Rsamtools")*. Van de gesorteerde BAM-bestanden was een matrix gevormd waarin de gemapte reads waren geteld en op kaart gebracht in een aangemaakt data-frame. Hierna werd de volledige sample-data in een count-matrix verkregen. Uit de count-matrix waren de genen met hun naam en counts apart gezet in een nieuw data-frame om daarna in een volcanoplot geplot te worden, waarin interessante levels van significantie en verhoging/verlaging van expressie te zien zijn (sig = <= 0.5, expressie >= 1.5 keer verhoogd/verlaagd). Als laatste werd een "GO enrichment" en "Gene testing" uitgevoerd via Gene Ontology, om de pathways van alle gemapte genen te weergeven en de relevante pathways met biologische significantie via kegg.jp (Kyoto Encyclopedia of Genes and Genomes) *(Packages: "Rsubread", "Rsamtools", "readr", "dplyr", "Goseq", "GO.db", TxDb.Hsapiens.UCSC.hg38.knownGene")*

**Verschillende genen omhoog-en omlaag-gereguleerd bij RA:**
Voor het onderzoeken van de expressie van RA, was er een Refseq uitgevoerd bij controle als behandelingssamples uitgevoerd en dit gemapt op het menselijk genoom. Hiervoor zijn p-waardes berekent (significant = 0.05) en als volgt een volcanoplot, gene enrichment, pathway enrichment en twee KEGG pathway-maps gevormd en onderzocht. Bij volcano plot was te zien dat het gen "IGHV3-53" het hoogst gereguleerd was in expressie met een log2 Fold Change van 11.43 met een ifcSE van 1.28 (p = 3.514037e-19 padj = 2.060776e-16, methode = Benjamini-Hochberg). Verder bevat het gen BCL2A1 een log2 Fold Change van 6.71 met een ifcSE 0.72 van ((p = 8.124928e-21, padj = 6.750123e-18, methode = Benjamini-Hochberg) figuur 2)). Voor de gene enrichment was te zien dat de meest voorkomende afkomst qua soort bioproces in de RA omhoog-gereguleerde genen "protein binding" is ((bijna verdubbeld in aantal vergeleken met het bioproces op plaats 2) figuur 3 )). Voor de pathway enrichment bestond de top 10 soorten meest up-gereguleerde genen uit alleen immunologische pathways, met GOBP_ADAPTIVE_IMMUNE_RESPONSE en GOBP_IMMUNOGLOBLIN_PRODUCTION als de koplopers (figuur 4). Er was een pathway gevonden op KEGG.jp die gebaseerd was op RA. Hierin was vooral een duidelijke up-regulatie (3X) bij de genen van de dendrietcel, wat genen van de zelf-reactieve th1 cel, twee genen bij de synoviumvervorming, een gen bij botresorptie, een gen bij ontsteking en vier van de zes genen bij infiltratie van ontstekingscellen. Bij de apoptose pathway was er 3x meer expressie aanwezig bij BCL2A1, IAP/XIAP, IP3R perforin als GZMB in de Granzyme B pathway (figuur 5,6).        

<p align="left">
  <img src="Assets/VolcanoplotWC.png" alt="Volcanoplot" width="600"/>
</p>

*Figuur 2: Volcanoplot voor het aantonen van omhoog-en omlaag-gereguleerde genen met bepaalde biologische-en/of statistische significantie (groen = biologisch significant, rood is biologsich als statistisch significant, grijs = geen van beide, negatieve log-waarde = omlaag-gereguleerd en vice versa).*

<p align="left">
  <img src="Assets/GO enrichment.png" alt="GO enrichment" width="700"/>
</p>

*Figuur 3: GO enrichment van algemene vertakkingen van bioproces-pathways die omhoog-gereguleerde expressie tonen bij RA (BP, p < 0.05).*

<p align="left">
  <img src="Assets/Pathway enrichment.png" alt="Pathway enrichment" width="700"/>
</p>

*Figuur 4: GO enrichment op specifieke pathways gebaseerd op de meest omhoog-gereguleerde genen bij RA (BP, p < 0.05).*

<p align="left">
  <img src="Assets/hsa05323.pathview.png" alt="hsa05323.pathview" width="700"/>
</p>

*Figuur 5: Beeld van laag, hoog-gereguleerde-en neutrale expressie (geen verhoging of verlaging) bij RA pathway (hsa05323, KEGG.jp, p <0.05).*

<p align="left">
  <img src="Assets/hsa04210+597.pathview.png" alt="hsa04210+597 pathview" width="700"/>
</p>

*Figuur 6: Beeld van laag, hoog-gereguleerde-en neutrale expressie (geen verhoging of verlaging) bij apoptose pathway (hsa04210+597, KEGG.jp, p <0.05).*

**Apoptose-pathway ook meer tot expressie:** 
Veel genen raken bij RA significant betrokken door omhoog of omlaag-regeguleerd te worden volgens de volcanoplot. Verder worden er verschillende, immunologische genen als pathways omhoog gereguleerd bij RA, waarop vooral eiwitbinding ontstaat. Naast de algemene RA pathway map in KEGG.jp, was er ook een statistische als biologische significantie bij de apoptose pathway map. Naast een verhoging van een paar genen betrokken bij ontsteking en beschadiging van de gewrichtsstructuur is er ook een significante, expressionele verhoging (3x) aan verschillende genen die betrokken zijn bij apoptose. Hierop kan verder volgense de resultaten aangeduidt worden dat geamplificeerde apoptose door het overwerkende immuunsysteem één van de grootste gevolgen is van RA. Wel lijkt het immuunsysteem ook terug te vechten door de up-regulatie van IL6 en BCL2A1. Deze genen staan bekend als switch die anti-als pro-inflammatoir werkt (IL6) en pro-en anti-apoptotisch kan werken *(Bronnen toevoegen voor deze lore)*.   


*"PACKAGES INFO VAN TOT NU TOE. NOG MOGELIJK, TOEKOMSTIGE PACKAGES TOEVOEGEN VOOR BIJ GENE TESTING ENZOVOORT (LATER EVEN KLEINE CITATIES VAN MAKEN EN ARTIKELEN IN ASSETS FOLDER DOEN)"* *Packages nog met auteur van artikel en package version citeren!* voor: "Goseq", "GO.db", TxDb.Hsapiens.UCSC.hg38.knownGene" library(limma)library(edgeR) library(msigdbr) 

#Citeer de package
> citation("Rsubread")
To cite package ‘Rsubread’ in publications use:

  Liao Y, Smyth GK and Shi W (2019). The R package Rsubread is easier, faster,
  cheaper and better for alignment and quantification of RNA sequencing reads.
  Nucleic Acids Research 47(8), e47.

A BibTeX entry for LaTeX users is

  @Article{,
    title = {The {R} package {Rsubread} is easier, faster, cheaper and better for alignment and quantification of {RNA} sequencing reads},
    author = {Yang Liao and Gordon K. Smyth and Wei Shi},
    journal = {Nucleic Acids Research},
    year = {2019},
    volume = {47},
    issue = {8},
    pages = {e47},
    doi = {10.1093/nar/gkz114},
  }
> #Citeer de package
> citation("Rsamtools")
To cite package ‘Rsamtools’ in publications use:

  Morgan M, Pagès H, Obenchain V, Hayden N (2024). _Rsamtools: Binary alignment
  (BAM), FASTA, variant call (BCF), and tabix file import_.
  doi:10.18129/B9.bioc.Rsamtools <https://doi.org/10.18129/B9.bioc.Rsamtools>, R
  package version 2.22.0, <https://bioconductor.org/packages/Rsamtools>.

A BibTeX entry for LaTeX users is

  @Manual{,
    title = {Rsamtools: Binary alignment (BAM), FASTA, variant call (BCF), and tabix
file import},
    author = {Martin Morgan and Hervé Pagès and Valerie Obenchain and Nathaniel Hayden},
    year = {2024},
    note = {R package version 2.22.0},
    url = {https://bioconductor.org/packages/Rsamtools},
    doi = {10.18129/B9.bioc.Rsamtools},
  }
> #Citeer de package
> citation("DESeq2")
To cite package ‘DESeq2’ in publications use:

  Love, M.I., Huber, W., Anders, S. Moderated estimation of fold change and
  dispersion for RNA-seq data with DESeq2 Genome Biology 15(12):550 (2014)

A BibTeX entry for LaTeX users is

  @Article{,
    title = {Moderated estimation of fold change and dispersion for RNA-seq data with DESeq2},
    author = {Michael I. Love and Wolfgang Huber and Simon Anders},
    year = {2014},
    journal = {Genome Biology},
    doi = {10.1186/s13059-014-0550-8},
    volume = {15},
    issue = {12},
    pages = {550},
  }
> #Citeer de package
> citation("KEGGREST")
To cite package ‘KEGGREST’ in publications use:

  Tenenbaum D, Maintainer B (2024). _KEGGREST: Client-side REST access to the Kyoto
  Encyclopedia of Genes and Genomes (KEGG)_. doi:10.18129/B9.bioc.KEGGREST
  <https://doi.org/10.18129/B9.bioc.KEGGREST>, R package version 1.46.0,
  <https://bioconductor.org/packages/KEGGREST>.

A BibTeX entry for LaTeX users is

  @Manual{,
    title = {KEGGREST: Client-side REST access to the Kyoto Encyclopedia of Genes and
Genomes (KEGG)},
    author = {Dan Tenenbaum and Bioconductor Package Maintainer},
    year = {2024},
    note = {R package version 1.46.0},
    url = {https://bioconductor.org/packages/KEGGREST},
    doi = {10.18129/B9.bioc.KEGGREST},
  }
> #Citeer de package
> citation("EnhancedVolcano")
To cite package ‘EnhancedVolcano’ in publications use:

  Blighe K, Rana S, Lewis M (2024). _EnhancedVolcano: Publication-ready volcano
  plots with enhanced colouring and labeling_. doi:10.18129/B9.bioc.EnhancedVolcano
  <https://doi.org/10.18129/B9.bioc.EnhancedVolcano>, R package version 1.24.0,
  <https://bioconductor.org/packages/EnhancedVolcano>.

A BibTeX entry for LaTeX users is

  @Manual{,
    title = {EnhancedVolcano: Publication-ready volcano plots with enhanced colouring and
labeling},
    author = {Kevin Blighe and Sharmila Rana and Myles Lewis},
    year = {2024},
    note = {R package version 1.24.0},
    url = {https://bioconductor.org/packages/EnhancedVolcano},
    doi = {10.18129/B9.bioc.EnhancedVolcano},
  }
> #Citeer de package
> citation("pathview")
To cite pathview:

  Luo, W. and Brouwer C., Pathview: an R/Bioconductor package for pathway-based data
  integration and visualization. Bioinformatics, 2013, 29(14): 1830-1831, doi:
  10.1093/bioinformatics/btt285

A BibTeX entry for LaTeX users is

  @Article{,
    author = {{Luo} and {Weijun} and {Brouwer} and {Cory}},
    title = {Pathview: an R/Bioconductor package for pathway-based data integration and visualization},
    journal = {Bioinformatics},
    year = {2013},
    doi = {10.1093/bioinformatics/btt285},
    volume = {29},
    number = {14},
    pages = {1830-1831},
  }
