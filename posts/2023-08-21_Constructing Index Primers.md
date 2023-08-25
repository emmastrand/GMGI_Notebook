# Constructing Index Primers 

Dual-indexed libraries add Index 1 (i7) and Index 2 (i5) sequences to generate uniquely tagged libraries. UD indexes have distinct, unrelated index sequences for the i5 and i7 Index Read. Indexes are 8 or 10 bases long. The goal is make unique unique dual indexes (UDI) for each sample. We are sequencing 140 samples on 2 NovaSeq runs (70 ea.). We can use 2 lanes and thus have 35 unique sets but to reduce the chance of samples getting mixed up in sequencing, I'd rather have 70 unique index pairs. For use in our Zymo Pico Methyl Seq protocol to prep Whole Genome Bisulfite Sequencing libraries. 

### Resources 

Illumina information: 
- https://knowledge.illumina.com/library-preparation/general/library-preparation-general-reference_material-list/000002344: There are a couple ways to index samples to give them a unique identifier (see below). We are using non-redundant dual index primers. Unique dual indexing is a known mitigation for filtering index-hopped reads seen in downstream analyses.   
- https://support-docs.illumina.com/SHARE/IndexAdapterPooling/Content/SHARE/IndexAdapterPooling/Intro_dtP.htm 

![](https://298777846-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FGM9W2DuBTgEXv1ClCm8H%2Fuploads%2Fgit-blob-00b3b29c9f0da2e89fea3792fae389344e364f25%2Fimage1.png?alt=media)

Shelly had previously contacted Zymo to ask about the compatible primers. See email exchange here: https://github.com/RobertsLab/resources/blob/master/protocols/Commercial_Protocols/ZymoResearch_PicoMethylseq_IndexAlternatives.pdf. 

There are 6 that come with the Zymo Pico Methyl Seq kit - Page 8 of this document: https://files.zymoresearch.com/protocols/_d5455_d5456_picomethylseq.pdf. Zymo doesn't sell more than that but we can order from any custom oligo vendor. The primers that come with the kit are based on Illumina TruSeq index primers:

![](https://github.com/emmastrand/GMGI_Notebook/blob/main/images/UDI%20oligo%20index%20primers.png?raw=true)

### Constructing our UDI (i5 and i7) primers 

I followed this information from Illumina for TruSeq UDI Indexes: https://support-docs.illumina.com/SHARE/AdapterSeq/Content/SHARE/AdapterSeq/TruSeq/UDIndexes.htm 

Index 1 (i7) Adapters: GATCGGAAGAGCACACGTCTGAACTCCAGTCAC--[i7]--ATCTCGTATGCCGTCTTCTGCTTG  
Index 2 (i5) Adapters: AATGATACGGCGACCACCGAGATCTACAC--[i5]--ACACTCTTTCCCTACACGACGCTCTTCCGATCT  

There's a difference between NovaSeq v1.0 and v1.5 reagents: https://knowledge.illumina.com/instrumentation/novaseq-6000/instrumentation-novaseq-6000-reference_material-list/000003717. This affects the i5 primer depending on what version you're using. 

There are 96 UDI pairs listed on Illumina docs above. Each pair has a unique 8 letter adapter that goes in place of the [i5] and [i7] above. 

### Ordering options 

[Illumina](https://emea.illumina.com/products/by-type/sequencing-kits/library-prep-kits/truseq-dna-pcr-free.html) 96 set (only alternative is 12 set) = $650  

[Zymo](https://www.zymoresearch.com/products/zymo-seq-udi-primer-sets) 96 set (only alternative is 12 set) = $495  
- 4-5 uses out of the 10 uL (2 uL per time)  

[IDT](https://www.idtdna.com/pages/products/next-generation-sequencing/workflow/xgen-ngs-library-preparation/ngs-adapters-indexing-primers) make our own = $68 per primer set (x 35 primers) $2,380  
