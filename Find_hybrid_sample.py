#!/usr/bin/env python3

from pathlib import Path
import sys, os, subprocess
import glob
import pandas as pd
import datetime, time
from Bio import SeqIO
import matplotlib.pyplot as plt
import json
import re

def round_seconds(obj: datetime.datetime) -> datetime.datetime:
    if obj.microsecond >= 500_000:
        obj += datetime.timedelta(seconds=1)
    return obj.replace(microsecond=0)

def run_cmd(cmd, logfile=None, mode="-a", protect_log=True):
    start = round_seconds(datetime.datetime.now())
    if logfile is not None:
        if not protect_log:
            if os.path.exists(logfile):
                os.remove(logfile)
        cmd = cmd + f"2>&1| tee {mode} {logfile}"

    print (f"\n[{start}] {cmd}\n")
    outscreen = subprocess.check_output(cmd, shell=True).decode("utf-8").split("\n")[0]
    end =  round_seconds(datetime.datetime.now())
    duration = end - start
    if logfile is not None:
        with open(logfile, "a") as f:
            comment = f"""
            #################################################
            >>>CMD:  {cmd}
            >>>START: {start}
            >>>END: {end}
            >>>DURATION: {duration}
            #################################################
            """
            print (comment,file=f)
    return outscreen
def draw_histogram(df,colname,namesave):
    plt.hist(df[colname].dropna(), bins=100,alpha=0.75)
    plt.savefig(f'{namesave}.png')

######### USAGE: python Find_hybrid_sample.py {table_illumina} {table_nanopre}  #######
table_illumina = pd.read_csv(sys.argv[1], header=0)
table_nanopre = pd.read_csv(sys.argv[2], header=0)

table_hybrid = pd.merge(table_illumina,table_nanopre,on='Sample Accession', how='inner')

table_hybrid.to_csv(f'Hybrid_table.csv', index = False)
list_hybrid = list(table_hybrid['Sample Accession'])
with open(f'Hybrid_list.txt', 'w') as f:
    for item in list_hybrid:
        f.write("%s\n" % item)

table_filter = table_hybrid[table_hybrid["Library Strategy_x"].str.contains("WG")]
draw_histogram(table_filter,'Total Bases_x','illumina_hybrid')
draw_histogram(table_filter,'Total Bases_y','nanopore_hybrid')
plt.show()