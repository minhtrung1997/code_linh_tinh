#!/usr/bin/env python3

import os, sys
from openpyxl import load_workbook
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
# def len_df(df,colname,query):
#     return len(df[df[colname] == query])
def check_query_in_df(df,colname,query):
    return df[colname].str.contains(query).sum()
def draw_histogram(df,colname):
    plt.hist(df[colname].dropna(), bins=100)
    plt.savefig(f'{sys.argv[2]}.png')
    plt.show()

# workbook = load_workbook(filename="C:\\Users\\DELL\\Documents\\BAOCAOTHANG.xlsx")
# sheet = workbook.active
### USAGE python histogram_dungluong.py <table> <histogram>
table = pd.read_csv(sys.argv[1],header=0)
table_filter = table[table["Library Strategy"].str.contains("WG")]
draw_histogram(table_filter,'Total Bases')

