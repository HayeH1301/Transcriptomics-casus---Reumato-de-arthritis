<p align="center">
  <img src="Assets/Afbeelding.jpg" alt="Afbeelding" width="600"/>
</p>

## Reumatoïde arthritis casus - Transcriptomics 
 Door: Haye Hoeksema
 
**Inleiding**
Reumatoïde artritis (RA) is een systemische auto-immuunziekte die chronische ontsteking ontwaakt in de gewrichten. Pathologische veranderingen aan de structuur van het synoviaal stroma, dat zich bekleed aan de binnenkant van het gewricht kunnen hierdoor ontstaan. B-cellen, macrofagen, CD4<sup>+</sup>-cellen en verschillende onstekingsvormende cytokinen zoals Tumor Necrosis Factor (TNF) en Prostaglandine E2 (PGE2) komen bij deze patiënten veel voor in het gewrichtsslijmvlies wat kan lijden tot aanhoudende onsteking en zwelling. RA komt 3-5 keer vaker voor bij vrouwen dan bij mannen en is nog niet te genezen, maar wel te onderdrukken met NSAIDS (nonsteroidal anti-inflammatory drugs) en DMARDS (disease-modifying antirheumatic drugs). Voor onderdrukking van de symptomen wordt er wel zorgen gemaakt over de veiligheid, kosten en respons van de medicatie (Jiang et al., 2025; Singh et al., 2016; Yelin et al., 2017). Hierdoor zou meer informatie over het onstaan van de ziekte veel helpen om ooit genezing mogelijk te maken. 
Van vier mensen met RA en vier mensen zonder RA zijn er samples genomen van het gewrichtslijmvlies (synoviumbiopt), waarbij een Transcriptomics analyse is van uitgevoerd in R. Zo zal er gekeken worden naar verschillende  genen en pathways die (meer/minder) betrokken zijn bij RA vergeleken met gezonde mensen. 


**Refseq van NCBI in R toepassen**

<p align="center">
  <img src="Assets/Flowschema - Github pagina, qPCR.png" alt="Flowschema" width="600"/>
</p>


Vier mensen met RA zijn postief getest op auto-antistoffen ACPA en CCP met een diagnose van >12 maanden. Vier mensen zonder RA (controle) waren hierop negatief getest. De samples waren al gesequenced en door een kwaliteitscontrole gegaan waarmee rauwe data-sequenties waren gevormd. Deze sequenties werden gemapped met het menselijk referentiegenoom "Homo_sapiens.GRCh38.dna.toplevel.fa.g" van ENSEMBL, door een index met index split te vormen en te lijnen op de verkregen forward -en reverse reads van de samples. Deze gelijnde reads werden als .BAM bestanden opgeslagen in de map "Reuma casus" en vervolgens gesorteerd tot één bestand *(Packages: "Rsubread", "Rsamtools")*. Van de gesorteerde BAM-bestanden was een matrix gevormd waarin het aantal met mensengenoom, gemapte reads was geteld en op kaart gebracht in een aangemaakt data-frame (*Packages: "Rsubread", "Rsamtools", "readr", "dplyr"*). Vervolgens werd er met de volledige sample-data gewerkt en was dit al in een count-matrix gevormd. Uit de count-matrix waren de genen met hun naam en counts apart gezet in een nieuw data-frame om daarna in een volcanoplot geplot te worden, waarin interessante levels van significantie en verhoging/verlaging van expressie te zien zijn (sig = <= 0.5, expressie >= 1.5 keer verhoogd/verlaagd). Als laatste werd een "Gene testing" uitgevoerd via Gene Ontology, om de pathways van alle gemapte genen te weergeven en werden de relevante pathways met biologische significantie via kegg.jp (Kyoto Encyclopedia of Genes and Genomes) opgezocht (*NOG PACKAGES TOEVOEGEN VAN LAATSTE STAPPEN*).  

*Packages nog met auteur van artikel en package version citeren!*


**Resultaten** (Belangrijkste wat in de titel verwerken)

**Conclusie** (wat concluderende zin van titel maken)



*"PACKAGES INFO VAN TOT NU TOE. NOG MOGELIJK, TOEKOMSTIGE PACKAGES TOEVOEGEN VOOR BIJ GENE TESTING ENZOVOORT (LATER EVEN KLEINE CITATIES VAN MAKEN EN ARTIKELEN IN ASSETS FOLDER DOEN)"*
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
