#!/usr/bin/env python3

import subprocess
import sys

# define the tags that should be shown and their order
commit_keys_and_header = (
    ('feature', '## New Features\n\n'),
    ('fix', '## General Fixes\n\n'),
    ('locale', '## Localization Fixes\n\n'),
)


def is_python_36():
    return sys.version_info.major == 3 and sys.version_info.minor >= 6


def get_commit_changelog():
    last_tag = get_last_git_tag()
    git_log = get_chronological_git_log(last_tag)
    categories = get_sorted_categories(git_log)

    return get_changelog_string(categories)


def get_last_git_tag():
    # get the tag this changelog is meant for
    latest_tag = subprocess.run(
        ["git", "describe", "--tags", "--abbrev=0", "HEAD"],
        **({"stdout": subprocess.PIPE, "stderr": subprocess.PIPE} if is_python_36() else {"capture_output": True, })
    ).stdout.decode().strip('\n')

    if "-b" in latest_tag:
        # If the latest tag is a beta release, get the previous tag
        return subprocess.run(
            ["git", "describe", "--tags", "--abbrev=0", f"{latest_tag}^"],
            **({"stdout": subprocess.PIPE, "stderr": subprocess.PIPE} if is_python_36() else {"capture_output": True, })
        ).stdout.decode().strip('\n')
    else:
        # If the latest tag is a stable release, get the previous non-beta tag
        return subprocess.run(
            ["git", "describe", "--tags", "--abbrev=0", "--exclude", "*-b*", "HEAD^"],
            **({"stdout": subprocess.PIPE, "stderr": subprocess.PIPE} if is_python_36() else {"capture_output": True, })
        ).stdout.decode().strip('\n')


def get_chronological_git_log(last_tag):
    # get array of the first line of the commit messages since last tag
    git_log = subprocess.run(
        ["git", "log", "--pretty=format:%s", f"{last_tag}..HEAD"],
        **({"stdout": subprocess.PIPE, "stderr": subprocess.PIPE} if is_python_36() else {"capture_output": True, })
    ).stdout.decode().split('\n')

    # reverse it so it's chronological
    git_log.reverse()
    return git_log


def get_sorted_categories(git_log):
    categories = {}
    for key_header in commit_keys_and_header:
        categories[key_header[0]] = []

    for line in git_log:
        for key in categories.keys():
            if line.startswith(f'[{key}]'):
                line = line.replace(f'[{key}]', '').strip()
                categories[key].append(line)
            elif line.startswith(f'[{key.capitalize()}]'):
                line = line.replace(f'[{key.capitalize()}]', '').strip()
                categories[key].append(line)

    for key in categories.keys():
        categories[key].sort()

    return categories


def get_changelog_string(categories):
    changelog = ''
    for key_header in commit_keys_and_header:
        key = key_header[0]
        if len(categories[key]) > 0:
            header = key_header[1]
            changelog += header
            for line in categories[key]:
                changelog += f'* {line}\n'.replace('\\[', '[')
            changelog += '\n'

    return changelog


if __name__ == "__main__":
    print(get_commit_changelog())