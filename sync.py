import subprocess
import json
import os
from typing import Dict, List


def run_cmd(cmd: List[str]) -> None:
    subprocess.run(cmd, check=True, text=True)


with open('map.json') as f:
    map: Dict[str, str] = json.load(f)

for dst, src in map.items():
    if src.startswith('~'):
        src = src.replace('~', os.environ.get("HOME"), 1)
    run_cmd(['rsync', '-r', src, dst])
