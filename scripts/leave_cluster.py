#!/bin/env python

import os
import modules.helpers as mh

def main():
    script = os.path.basename(__file__)
    env = script[script.find('_')+1:script.rfind('.')]
    #print(script)
    #print(env)
    # wants_vault should default false
    mh.playbook(
        env=env,
        hosts='all',
        action=script[0:len(script)-len(env)-len('.py')-len('_')],
    )

if __name__ == '__main__':
    main()
