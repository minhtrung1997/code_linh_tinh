#!/usr/bin/env python3

import sys, os, subprocess
import glob
import pandas as pd
import datetime, time

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
# translation function and NNN codon table as a dict object


with open(sys.argv[1], 'r') as f:
    seqs = [line.rstrip() for line in f]
print(seqs)
for seq in seqs:
    cmd = f"""echo {seq} > nucl.txt && transeq -sequence nucl.txt -outseq aa.txt && echo $(awk '(NR>1)' aa.txt | tr '\n' ' ' | tr -d ' ') >> amino_acid.txt \
            && rm nucl.txt aa.txt \
            && cat amino_acid.txt """
    run_cmd(cmd)
cmd = 'cp amino_acid.txt translation_result.txt && rm amino_acid.txt'
run_cmd(cmd)
