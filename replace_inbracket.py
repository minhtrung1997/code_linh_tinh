# Importing module
import sys, os, re
from pathlib import Path

# Input string
file_p = sys.argv[1]
prefix = Path(file_p).stem
wkdir = os.path.dirname(file_p)
with open (file_p, 'r') as my_file:
    my_text = my_file.read()

# \(.*?\) ==> it is a regular expression for finding
# the pattern for brackets containing some content
string=re.sub("\<.*?\>","<strain>",my_text)
  
# Output string
print(string, file=open(f'{prefix}_new.nwk','w'))