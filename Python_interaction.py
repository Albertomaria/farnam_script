#import package
from Bio import Seq
from itertools import product
import string
import pandas as pd
import numpy as np
from itertools import chain
import re
import seaborn as sns
import random

#def functions
def extend_ambiguous_dna(seq):
    d = Seq.IUPAC.IUPACData.ambiguous_dna_values
    seq = seq.upper()
    seq = seq.replace("U","T")
    r = []
    for i in product(*[d[j] for j in seq]):
        r.append("".join(i))
    return r

def shuffle_string(string):
    chars = list(string)
    random.shuffle(chars)
    return ''.join(chars)

#import database	
df = pd.read_csv('Liana/protein_motif.csv')
df = df.replace(np.nan, '', regex=True)
df = df.replace(["KKNWWDNNNUKNNUUNUNNH","GNNNNNNNNNNNUGUA"], ["",""]) 
df = df.set_index('X5')

utr = pd.read_csv('Liana/UTR_human.csv')
utr = utr.set_index('Ensembl_ID')

cntr = pd.read_csv('Liana/UTR_human_cntr.csv')
cntr = cntr.set_index('Ensembl_ID')

#create results table
utr_gene = utr.index.tolist()
rbp_gene = df.index.tolist()
results = pd.DataFrame(index=utr_gene, columns=rbp_gene)
results = results.fillna(0)

results_shuffle_m = pd.DataFrame(index=utr_gene, columns=rbp_gene)
results_shuffle_m = results_shuffle_m.fillna(0)

results_shuffle_sd = pd.DataFrame(index=utr_gene, columns=rbp_gene)
results_shuffle_sd = results_shuffle_sd.fillna(0)

cntr_gene = cntr.index.tolist()
rbp_gene = df.index.tolist()
results_cntr = pd.DataFrame(index=cntr_gene, columns=rbp_gene)
results_cntr = results_cntr.fillna(0)
results_cntr.head()

#dictionary of motives
ind = ["1","2","3","4","5","6","7","8","9","10"]
motif_dict = dict()
for r in rbp_gene:
        rbp_name = list()
        for i in ind:
            rna = df.loc[r,i]
            if rna != "":
                try:
                    rbp_name.append(extend_ambiguous_dna(rna))
                except:continue
        rbp_name = list(chain(*rbp_name))
        motif_dict[r]= rbp_name
		
#results CAM_genes
ind = ["1","2","3","4","5","6","7","8","9","10"]
UTR_len = dict()
n_motif = dict()
for u in utr_gene:
    UTR_len[u] = len(utr.loc[u,'3UTR'])
    seq = utr.loc[u,'3UTR']
    for r in rbp_gene:
        rbp_name = list()
        for i in ind:
            rna = df.loc[r,i]
            if rna != "":
                try:
                    rbp_name.append(extend_ambiguous_dna(rna))
                except:continue
        rbp_name = list(chain(*rbp_name))
        count = 0
        n_motif [r] = len(rbp_name)
        for mre in rbp_name:
            n = seq.count(mre)
            count += n
        results.loc[u,r] = count
results.to_csv('Liana/Rusults_RBP_CAM_genes_interactions.csv', sep='\t', encoding='utf-8')

#results CNTR_genes		
ind = ["1","2","3","4","5","6","7","8","9","10"]
for u in cntr_gene: #u is the gene  name
    seq = cntr.loc[u,'3UTR'] #take 3UTR seq and make in seq object
    for r in rbp_gene: #r is the RBP name
        rbp_name = list()
        for i in ind:
            rna = df.loc[r,i] #take RBP motif seq and make in rna object
            if rna != "":
                try:
                    rbp_name.append(extend_ambiguous_dna(rna))
                except:continue
        rbp_name = list(chain(*rbp_name)) #generate list of all possible RBP motif
        count = 0
        for mre in rbp_name:
            try:
                n = seq.count(mre)
                #print (n)
            except:continue
            count += n
        results_cntr.loc[u,r] = count
results_cntr.to_csv('Liana/Rusults_RBP_CNTR_genes_interactions.csv', sep='\t', encoding='utf-8')
		
#results mean and sd for 500 repetitions	
for u in utr_gene: #u is the gene  name
    seq = utr.loc[u,'3UTR'] #take 3UTR seq and make in seq object
    for k in motif_dict.keys():
        motives = motif_dict[k]
        num = list()
        s = 0
        while s <= 500:
            n = 0
            for motif in motives:
                r = shuffle_string(seq).count(motif)
                n += r
            num.append(n)
            s += 1
        m = np.mean(num)
        sd = np.std(num)
        results_shuffle_m.loc[u,k] = m
        results_shuffle_sd.loc[u,k] = sd
results_shuffle_m.to_csv('Liana/Rusults_shuffle_mean.csv', sep='\t', encoding='utf-8')
results_shuffle_sd.to_csv('Liana/Rusults_shuffle_sd.csv', sep='\t', encoding='utf-8')
