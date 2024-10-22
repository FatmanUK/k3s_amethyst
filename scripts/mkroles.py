#!/bin/env python

from os import makedirs
from os.path import exists
from sys import argv

# Find unused empty YAML files:
# ag -l -G .*yml '\-\-\-\n\n...\n# vim: set filetype=yaml' . | sort

blank_yaml='''---

...
# vim: set filetype=yaml
'''

def put_role_subdir(d):
    try:
        makedirs(d)
    except:
        pass

    fname = f'{d}/main.yml'

    counter = 1
    while exists(fname):
        fname = f'{d}/main.yml.{counter}'
        counter = counter + 1

    f = open(fname, 'w')
    f.write(blank_yaml)
    f.close()

def put_blank_role(d):
    put_role_subdir(f'{d}/tasks')
    put_role_subdir(f'{d}/defaults')
    # wait, we don't need main.yml in templates :p
    #put_role_subdir(f'{d}/templates')
    try:
        makedirs(f'{d}/templates')
    except:
        pass

def main():
    for v in argv[1:]:
        put_blank_role(f'roles/{v}')

main()
