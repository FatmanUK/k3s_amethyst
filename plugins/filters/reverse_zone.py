from __future__ import (absolute_import, division, print_function)
__metaclass__ = type

def reverse_zone(ip4_with_prefix):
    ''' Must be IPv4 with a CIDR prefix '''
    # confusingly, prefixes are suffixed to the address
    ip4 = None
    prefix = None
    try:
        arr = ip4_with_prefix.split('/')
        ip4 = arr[0]
        prefix = arr[1]
        if len(arr) != 2:
            raise exception('oh no!')
    except:
        return ''
    ip4_arr = None
    try:
        ip4_arr = ip4.split('.')
        if len(ip4_arr) != 4:
            raise exception('oh no!')
        for c in range(4):
            n = int(ip4_arr[c])
            if (n < 0) or (n > 255) or (str(n) != ip4_arr[c]):
                raise exception('oh no!')
    except:
        return ''
    # reverse octets
    itmp = ip4_arr[3]
    ip4_arr[3] = ip4_arr[0]
    ip4_arr[0] = itmp
    itmp = ip4_arr[2]
    ip4_arr[2] = ip4_arr[1]
    ip4_arr[1] = itmp
    # reverse zones are classful by design
    # seems no-one thought to redesign them
    if int(prefix) <= 24:
        ip4_arr.pop(0)
    if int(prefix) <= 16:
        ip4_arr.pop(0)
    if int(prefix) <= 8:
        ip4_arr.pop(0)
    ip4_arr.append('in-addr.arpa')
    return '.'.join(ip4_arr)

class FilterModule(object):
    def filters(self):
        return {
            'reverse_zone': reverse_zone,
        }
