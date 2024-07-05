#!/bin/env python

from os import makedirs
from os.path import exists
from sys import argv

blank_yaml='''---

...
# vim: set filetype=yaml:
'''

def put_blank_group_vars(d):
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

def main():
    for v in argv[1:]:
        put_blank_group_vars(f'group_vars/{v}')

main()
