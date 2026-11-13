#!/usr/bin/env python3

import fileinput
import shutil
import subprocess
import sys

if not len(sys.argv) > 1:
    print('Needs new version number provided as argument')
    exit()

version = sys.argv[1]

if not shutil.which('git-cliff'):
    print('git-cliff is needed to generate the changelog. See https://git-cliff.org/docs/installation')
    exit()

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

changelogString = subprocess.run(
    ['git-cliff', '--latest', '--tag', 'v' + version, '--ignore-tags=-b'],
    capture_output=True, text=True, check=True
).stdout

print('######### START CHANGELOG')
print('# Disenchant Buddy v' + version + '\n\n' + changelogString)
print('######### END CHANGELOG')

subprocess.run(['git', 'add', 'README.md'])
subprocess.run(['git', 'add', '*.toc'])
subprocess.run(['git', 'commit', '-mchore: bump version to v' + version])
subprocess.run(['git', 'tag', 'v' + version])
