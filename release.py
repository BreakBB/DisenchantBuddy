#!/usr/bin/env python3

import fileinput
import subprocess
import sys

if not len(sys.argv) > 1:
    print('Needs new version number provided as argument')
    exit()

version = sys.argv[1]

if version[0] == "v":
    print('Please omit the "v" prefix. The script will add it')
    exit()

tocs = ['DisenchantBuddy_Vanilla.toc', 'DisenchantBuddy_TBC.toc', 'DisenchantBuddy_Wrath.toc', 'DisenchantBuddy_Cata.toc', 'DisenchantBuddy_Mists.toc',
        'DisenchantBuddy_Camelot.toc', 'DisenchantBuddy_Forever.toc']

for toc in tocs:
    with fileinput.FileInput(toc, inplace=True) as file:
        for line in file:
            if line[:10] == '## Version':
                print('## Version: ' + version)
            elif line[:8] == '## Title':
                print('## Title: Disenchant Buddy v' + version)
            else:
                print(line, end='')

with fileinput.FileInput('README.md', inplace=True) as file:
    for line in file:
        if line[:20] == '[![Downloads Latest]':
            print(
                '[![Downloads Latest](https://img.shields.io/github/downloads/BreakBB/DisenchantBuddy/v' + version + '/total.svg)](https://github.com/BreakBB/DisenchantBuddy/releases/latest)')
        else:
            print(line, end='')

subprocess.run(['git', 'add', 'README.md'])
subprocess.run(['git', 'add', '*.toc'])
subprocess.run(['git', 'commit', '-mchore: bump version to v' + version])
subprocess.run(['git', 'tag', 'v' + version])
