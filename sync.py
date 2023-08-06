import subprocess
import json
import os
from typing import Dict

with open('map.json') as f:
    map: Dict[str, str] = json.load(f)

for dst, src in map.items():
    if src.startswith('~'):
        src = src.replace('~', os.environ.get("HOME"), 1)
    subprocess.run(['rsync', '-r', src, dst])
