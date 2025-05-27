<p align="center">
  <img src="Assets/Afbeelding.jpg" alt="Afbeelding" width="600"/>
</p>

## Reumatoïde arthritis casus - Transcriptomics 
 Door: Haye Hoeksema
 
**Inleiding**
Reumatoïde artritis (RA) is een systemische auto-immuunziekte die chronische ontsteking ontwaakt in de gewrichten. Pathologische veranderingen aan de structuur van het synoviaal stroma, dat zich bekleed aan de binnenkant van het gewricht. B-cellen, macrofagen, CD4<sup>+</sup>-cellen en verschillende onstekingsvormende cytokinen zoals Tumor Necrosis Factor (TNF) en Prostaglandine E2 (PGE2) komen bij deze patiënten veel voor in het gewrichtsslijmvlies wat kan lijden tot aanhoudende onsteking en zwelling. RA komt 3-5 keer vaker voor bij vrouwen dan bij mannen en is nog niet te genezen, maar wel te onderdrukken met NSAIDS (nonsteroidal anti-inflammatory drugs) en DMARDS (disease-modifying antirheumatic drugs). Voor onderdrukking van de symptomen wordt er wel zorgen gemaakt over de veiligheid, kosten en respons van de medicatie (Jiang et al., 2025; Singh et al., 2016; Yelin et al., 2017). Hierdoor zou meer informatie over het onstaan van de ziekte veel helpen om ooit genezing mogelijk te maken. 
Van vier mensen met RA en vier mensen zonder RA zijn er samples genomen van het gewrichtslijmvlies (synoviumbiopt), waarbij een Transcriptomics analyse is van uitgevoerd in R. Zo zal er gekeken worden naar verschillende  genen en pathways die (meer/minder) betrokken zijn bij RA vergeleken met gezonde mensen. 


**Refseq van NCBI in R toepassen**
Vier mensen met RA zijn postief getest op auto-antistoffen ACPA en CCP met een diagnose van >12 maanden. Vier mensen zonder RA (controle) waren hierop negatief getest. De samples waren al gesequenced en door een kwaliteitscontrole gegaan waarmee rauwe datasequenties waren gevormd. Deze sequenties werden gemapped met het menselijk referentiegenoom "Homo_sapiens.GRCh38.dna.toplevel.fa.g" van ENSEMBL, door een index met index split te vormen en te lijnen op de verkregen forward -en reverse reads van de samples. Deze gelijnde reads werden als .BAM bestanden opgeslagen in de map "Reuma casus" en vervolgens gesorteerd tot één bestand *(Packages: "Rsubread", "Rsamtools")*. Van de gesorteerde BAM-bestanden was een matrix gevormd waarin het aantal met mensengenoom, gemapte reads was geteld en op kaart gebracht in een aangemaakt data-frame (*Packages: "Rsubread", "Rsamtools", "readr", "dplyr"*). Vervolgens werd er met de volledige sample-data gewerkt en was dit al in een count-matrix gevormd. Uit de count-matrix waren de genen met hun naam en counts apart gezet in een nieuw data-frame om daarna in een volcanoplot geplot te worden, waarin interessante levels van significantie en verhoging/verlaging van expressie te zien zijn (sig = <= 0.5, expressie >= 1.5 keer verhoogd/verlaagd). Als laatste werd een "Gene testing" uitgevoerd via Gene Ontology, om de pathways van alle gemapte genen te weergeven en werden de relevante pathways met biologische significantie via kegg.jp (Kyoto Encyclopedia of Genes and Genomes) opgezocht (*NOG PACKAGES TOEVOEGEN VAN LAATSTE STAPPEN*).  


**Resultaten** (Belangrijkste wat in de titel verwerken)

**Conclusie** (wat concluderende zin van titel maken)
