import sys, os
import pandas as pd

blast_file = sys.argv[1]
wkdir = os.path.dirname(os.path.realpath(blast_file))
print ("[Report] Thong ke cac ket qua BLAST")
df_blast = pd.read_csv(blast_file, sep='\t', low_memory=False, header=None)
df_blast.columns = ['#ID', 'sacc', 'stitle', 'staxids', 'pident', 'qcovs', 'evalue', 'bitscore']
df_blast['staxids'] = [str(i) for  i in df_blast['staxids']]
df_top_blast = df_blast.drop_duplicates(subset=['#ID'])
df_top_blast['#ID'] = [str(i) for i in df_top_blast['#ID']]
df_top_blast.to_csv(f'{wkdir}/Top_hit_blast.tsv',sep ='\t')

# stitle
