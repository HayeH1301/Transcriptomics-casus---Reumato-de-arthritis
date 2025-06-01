setwd("C:/Users/hayeh/OneDrive - NHL Stenden/Documents/Reuma casus/count_matrix/")  

getwd()

install.packages('BiocManager')
library(BiocManager)
BiocManager::install('Rsubread')
library(Rsubread)

#Splitten van referentiegenoom
buildindex(
  basename = 'Homo_sapiens.GRCh38.dna.toplevel.fa.gz',
  reference = 'Homo_sapiens.GRCh38.dna.toplevel.fa.gz',
  memory = 10000,
  indexSplit = TRUE)

# alignen van samples 
align.contr19 <- align(index = "C:/Users/hoeks_072/Documents/Reuma casus/Homo_sapiens.GRCh38.dna.toplevel.fa.gz", readfile1 = "SRR4785819_1_subset40k.fastq",
                       readfile2 = "SRR4785819_2_subset40k.fastq", output_file = "contr19.BAM")

align.contr20 <- align(index = "C:/Users/hoeks_072/Documents/Reuma casus/Homo_sapiens.GRCh38.dna.toplevel.fa.gz", readfile1 = "SRR4785820_1_subset40k.fastq",
                       readfile2 = "SRR4785820_2_subset40k.fastq", output_file = "contr20.BAM")

align.contr28 <- align(index = "C:/Users/hoeks_072/Documents/Reuma casus/Homo_sapiens.GRCh38.dna.toplevel.fa.gz", readfile1 = "SRR4785828_1_subset40k.fastq",
                       readfile2 = "SRR4785828_2_subset40k.fastq", output_file = "contr28.BAM")

align.contr31 <- align(index = "C:/Users/hoeks_072/Documents/Reuma casus/Homo_sapiens.GRCh38.dna.toplevel.fa.gz", readfile1 = "SRR4785831_1_subset40k.fastq",
                       readfile2 = "SRR4785831_2_subset40k.fastq", output_file = "contr31.BAM")

align.samp79 <- align(index = "C:/Users/hoeks_072/Documents/Reuma casus/Homo_sapiens.GRCh38.dna.toplevel.fa.gz", readfile1 = "SRR4785979_1_subset40k.fastq",
                      readfile2 = "SRR4785979_2_subset40k.fastq", output_file = "samp79.BAM")

align.samp80 <- align(index = "C:/Users/hoeks_072/Documents/Reuma casus/Homo_sapiens.GRCh38.dna.toplevel.fa.gz", readfile1 = "SRR4785980_1_subset40k.fastq",
                      readfile2 = "SRR4785980_2_subset40k.fastq", output_file = "samp80.BAM")

align.samp86 <- align(index = "C:/Users/hoeks_072/Documents/Reuma casus/Homo_sapiens.GRCh38.dna.toplevel.fa.gz", readfile1 = "SRR4785986_1_subset40k.fastq",
                      readfile2 = "SRR4785986_2_subset40k.fastq", output_file = "samp86.BAM")

align.samp88 <- align(index = "C:/Users/hoeks_072/Documents/Reuma casus/Homo_sapiens.GRCh38.dna.toplevel.fa.gz", readfile1 = "SRR4785988_1_subset40k.fastq",
                      readfile2 = "SRR4785988_2_subset40k.fastq", output_file = "samp88.BAM")

# Laad Rsamtools voor sorteren en indexeren
BiocManager::install('Rsamtools')
library(Rsamtools)

# Bestandsnamen van de monsters
samples <- c('contr19','contr20','contr31','samp79','samp80','samp86','samp88')

# Voor elk monster: sorteer en indexeer de BAM-file
# Sorteer BAM-bestanden
lapply(samples, function(s) {sortBam(file = paste0(s, '.BAM'), destination = paste0(s, '.sorted'))
})

lapply(samples, function(s) {indexBam(file = paste0(s, '.sorted.BAM'), destination = paste0(s, '.sorted'))
})

library(readr)
library(dplyr)
library(Rsamtools)
library(Rsubread)

allsamples <- c("contr19.BAM", "contr20.BAM", "contr28.BAM", "contr31.BAM", "contr31.BAM", "samp79.BAM", "samp80.BAM", "samp86.BAM", "samp88.BAM")

count_matrix <- featureCounts(
  files = allsamples,
  annot.ext = "C:/Users/hoeks_072/Documents/Reuma casus/Homo_sapiens.GRCh38.114.gtf.gz",
  isPairedEnd = TRUE,
  isGTFAnnotationFile = TRUE,
  GTF.attrType = "gene_id",
  useMetaFeatures = TRUE
)

head(count_matrix$annotation)
head(count_matrix$counts)

# Bekijk eerst de structuur van het object
str(count_matrix)

# Haal alleen de matrix met tellingen eruit
counts <- count_matrix$counts

colnames(counts) <- c("GeneID", 'contr19', 'contr20', "contr28", "contr31", "samp79", "samp80", "samp86", "samp88", )


rownames(counts) <- counts[, 1]

# Voer je eigen code in. 

counts <- read.table("count_matrix.txt")

head(counts)

treatment <- c("control", "control", "control", "control", "RA", "RA", "RA", "RA")
treatment_table <- data.frame(treatment)
rownames(treatment_table) <- c('SRR4785819', 'SRR4785820', 'SRR4785828', 'SRR4785831', 'SRR4785979', 'SRR4785980', 'SRR4785986', 'SRR4785988')

BiocManager::install('DESeq2')
BiocManager::install('KEGGREST')
library(DESeq2)
library(KEGGREST)

# Maak DESeqDataSet aan
dds <- DESeqDataSetFromMatrix(countData = round(counts),
                              colData = treatment_table,
                              design = ~ treatment)

# Voer analyse uit
dds <- DESeq(dds)
resultaten <- results(dds)

# Resultaten opslaan in een bestand
#Bij het opslaan van je tabel kan je opnieuw je pad instellen met `setwd()` of het gehele pad waar je de tabel wilt opslaan opgeven in de code.

write.table(resultaten, file = 'Resultaten.csv', row.names = TRUE, col.names = TRUE)

sum(resultaten$padj < 0.05 & resultaten$log2FoldChange > 1, na.rm = TRUE)
sum(resultaten$padj < 0.05 & resultaten$log2FoldChange < -1, na.rm = TRUE)

hoogste_fold_change <- resultaten[order(resultaten$log2FoldChange, decreasing = TRUE), ]
laagste_fold_change <- resultaten[order(resultaten$log2FoldChange, decreasing = FALSE), ]
laagste_p_waarde <- resultaten[order(resultaten$padj, decreasing = FALSE), ]

head(laagste_p_waarde)

if (!requireNamespace("EnhancedVolcano", quietly = TRUE)) {
  BiocManager::install("EnhancedVolcano")
}
library(EnhancedVolcano)

EnhancedVolcano(resultaten,
                lab = rownames(resultaten),
                x = 'log2FoldChange',
                y = 'padj')

# Alternatieve plot zonder p-waarde cutoff (alle genen zichtbaar)
EnhancedVolcano(resultaten,
                lab = rownames(resultaten),
                x = 'log2FoldChange',
                y = 'padj',
                pCutoff = 0)

dev.copy(png, 'VolcanoplotWC.png', 
         width = 8,
         height = 10,
         units = 'in',
         res = 500)
dev.off()

if (!requireNamespace("pathview", quietly = TRUE)) {
  BiocManager::install("pathview")
}
library(pathview)

resultaten[1] <- NULL
resultaten[2:5] <- NULL

pathview(
  gene.data = resultaten,
  pathway.id = "05323",  
  species = "hsa",          
  gene.idtype = "KEGG",     
  limit = list(gene = 5)    
)

# Laad de resultaten opnieuw in als data frame
resultaten <- read.table("ResultatenWC3.csv", header = TRUE, row.names = 1)

BiocManager::install("org.Hs.eg.db")
BiocManager::install("AnnotationDbi")
library(org.Hs.eg.db)
library(AnnotationDbi)

# Voeg ENTREZ ID-kolom toe
resultaten$ENTREZID <- mapIds(
  org.Hs.eg.db,
  keys = rownames(resultaten),   # de SYMBOLS staan in rownames
  column = "ENTREZID",
  keytype = "SYMBOL",
  multiVals = "first"
)

resultaten_clean <- na.omit(resultaten)

gene_vector <- setNames(resultaten_clean$log2FoldChange, resultaten_clean$ENTREZID)

library(pathview)

pathview(
  gene.data = gene_vector,
  pathway.id = "05323",  # Bijvoorbeeld: IL-17 signaling pathway (relevant voor RA)
  species = "hsa",
  gene.idtype = "ENTREZ",
  limit = list(gene = 3),
  low = list(gene = "green"), 
  mid = list(gene = "gray"),
  high = list(gene = "red")
)

#Gene ontology

#GO enrichement


BiocManager::install("TxDb.Hsapiens.UCSC.hg38.knownGene")

# Laad libraries
library(goseq)
library(org.Hs.eg.db)
library(GO.db)
library(TxDb.Hsapiens.UCSC.hg38.knownGene)

#Resultaten inladen
resultaten <- read.table("Resultaten.csv", header = TRUE, row.names = 1)

#Voeg ENTREZ ID's toe
entrez_ids <- mapIds(
  org.Hs.eg.db,
  keys = rownames(resultaten),
  column = "ENTREZID",
  keytype = "SYMBOL",
  multiVals = "first"
)

resultaten$ENTREZID <- entrez_ids
resultaten <- na.omit(resultaten)

#Maak de binaire genvector (1 = DE, 0 = niet-DE)
genen <- as.integer(resultaten$padj < 0.05 & !is.na(resultaten$padj))
names(genen) <- resultaten$ENTREZID
genen <- na.omit(genen)

# Haal genlengtes op via TxDb voor hg38
txdb <- TxDb.Hsapiens.UCSC.hg38.knownGene
gene_lengths <- transcriptLengths(
  txdb,
  with.cds_len = TRUE,
  with.utr5_len = TRUE,
  with.utr3_len = TRUE
)

# Bereken totale lengte
gene_lengths$tot_length <- gene_lengths$cds_len + gene_lengths$utr5_len + gene_lengths$utr3_len

# Gemiddelde lengte per gen (ENTREZ ID)
length_vector <- tapply(gene_lengths$tot_length, gene_lengths$gene_id, mean)

#Zorg dat genen overeenkomen in beide objecten
common_ids <- intersect(names(genen), names(length_vector))
genen <- genen[common_ids]
bias_vector <- length_vector[common_ids]

#Bereken probability weighting function (PWF)
pwf <- nullp(genen, bias.data = bias_vector)

#uitleg over deze plot
#houd rekenening meer dat genen die langer zijn meer reads hebben en corrigeert dat in de GO enrichment
#xas: is lengte van de genen.
#yas: hoeveel van de lange genen in expressie zijn in %

#Voer GO-enrichment analyse uit
# Maak eigen GO-annotatie
gene2go <- AnnotationDbi::select(
  org.Hs.eg.db,
  keys = keys(org.Hs.eg.db, keytype = "ENTREZID"),
  columns = c("ENTREZID", "GO"),
  keytype = "ENTREZID"
)
gene2go <- na.omit(gene2go)
gene2cat <- split(gene2go$GO, gene2go$ENTREZID)

# GO enrichment analyse met eigen annotatie
GO.wall <- goseq(pwf, gene2cat = gene2cat, use_genes_without_cat = TRUE)


#Filter op significant verrijkte GO-termen (p < 0.05)
GO.sig <- GO.wall[GO.wall$over_represented_pvalue < 0.05, ]

#Voeg GO-term beschrijvingen toe
GO.sig$term <- Term(GO.sig$category)

# 💾 12. Sla op als CSV-bestand
write.csv(GO.sig, "GO_enrichment_significant.csv", row.names = FALSE)

#Bekijk de top GO-termen
head(GO.sig[, c("term", "over_represented_pvalue", "numDEInCat", "numInCat")])

#voor een plot. van de top 10 sig over_represented_pvalue.
library(ggplot2)
# Sorteer op p-waarde (laagste bovenaan)
GO.sig.sorted <- GO.sig[order(GO.sig$over_represented_pvalue), ]

# Pak de top 10 meest significante termen
top_terms <- head(GO.sig.sorted, 10)

# Zet termen als factor met juiste volgorde (voor mooie y-as)
top_terms$term <- factor(top_terms$term, levels = rev(top_terms$term))

# Plot
ggplot(top_terms, aes(x = term, y = -log10(over_represented_pvalue))) +
  geom_bar(stat = "identity", fill = "salmon") +
  coord_flip() +
  labs(
    title = "Top 10 meest verrijkte bioprocessen (RA tegen controle)",
    x = "GO-term",
    y = "-log10(p-waarde)"
  ) +
  theme_minimal(base_size = 12)

#-----------------Gene testing 

#installeer de package
BiocManager::install("limma")
BiocManager::install("edgeR")
BiocManager::install("msigdbr")   

#laad in de package
library(limma)
library(edgeR)
library(msigdbr)
library(DESeq2)
library(KEGGREST)
library(ggplot2)
library(dplyr)

#Sub-collectie kiezen met pathways). 
msig_go_bp <- msigdbr(species = "Homo sapiens", collection = "C5", subcollection = "BP")


#Lijst voor SYMBOL
gene_sets <- split(msig_go_bp$gene_symbol, msig_go_bp$gs_name)

#Haal ruwe counts
dge <- DGEList(counts = counts(dds), genes = rownames(dds))

#Normaliseer
dge <- calcNormFactors(dge)

# Matrix vormen 
group <- dds$treatment
design <- model.matrix(~ group)

# Transformeer met voom naar lineare model
v <- voom(dge, design, plot = TRUE)

#Genen met elkaar rangschikken
camera_results <- camera(v$E, index = gene_sets, design = design, contrast = 2)

#Toon topverrijkte pathways
head(camera_results[order(camera_results$PValue), ])

#Filter op p < 0.05
camera_sig <- camera_results[camera_results$PValue < 0.05, ]

#sla op bestand
write.csv(camera_sig, "pathway_enrichment.csv")

#Vector met top 10 expressies van genen
top_terms <- head(camera_sig[order(camera_sig$PValue), ], 10)

#geef rownames
top_terms$gs_name <- rownames(top_terms)

#word als "up" als het DE van 1 heeft
top_terms$Direction_num <- ifelse(top_terms$Direction == "Up", 1, -1)

#Plot maken
Path.ENRICH <- ggplot(top_terms, aes(x = reorder(gs_name, -Direction_num * log10(PValue)),
                            y = -log10(PValue),
                            fill = Direction)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  labs(x = "Genenset (GO term)",
       y = "-log10(p-waarde)",
       title = "GO-MF (opgereguleerd)") +
  theme_minimal() + scale_fill_manual(values = c("salmon"))

#Plot
Path.ENRICH
