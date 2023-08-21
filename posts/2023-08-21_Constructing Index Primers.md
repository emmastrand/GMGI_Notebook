# Constructing Index Primers 

For use in our Zymo Pico Methyl Seq protocol to prep Whole Genome Bisulfite Sequencing libraries. The goal is make unique unique dual indexes (UDI) for each sample. We are sequencing 140 samples on 2 NovaSeq runs (70 ea.). We can use 2 lanes and thus have 35 unique sets but to reduce the chance of samples getting mixed up in sequencing, I'd rather have 70 unique index pairs. 

### Resources 

Illumina information: https://knowledge.illumina.com/library-preparation/general/library-preparation-general-reference_material-list/000002344: There are a couple ways to index samples to give them a unique identifier (see below). We are using non-redundant dual index primers. Unique dual indexing is a known mitigation for filtering index-hopped reads seen in downstream analyses. 

![](https://298777846-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2FGM9W2DuBTgEXv1ClCm8H%2Fuploads%2Fgit-blob-00b3b29c9f0da2e89fea3792fae389344e364f25%2Fimage1.png?alt=media)

Shelly had previously contacted Zymo to ask about the compatible primers. See email exchange here: https://github.com/RobertsLab/resources/blob/master/protocols/Commercial_Protocols/ZymoResearch_PicoMethylseq_IndexAlternatives.pdf. 

There are 6 that come with the Zymo Pico Methyl Seq kit - Page 8 of this document: https://files.zymoresearch.com/protocols/_d5455_d5456_picomethylseq.pdf. 