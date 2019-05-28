#!/usr/bin/env python
# -*- coding: utf-8 -*-

import argparse
import os
import subprocess
import sys
import shutil
import xml.dom.minidom


def format_file(xml_name):
    try:
        xml_actual = xml.dom.minidom.parse(xml_name)
    except Exception as e:
        print('could not read %s (%s)' % (xml_name, e))
        return 1

    def sort_key(node):
        if node.nodeType != xml.dom.Node.ELEMENT_NODE:
            return ''
        name = filter(lambda n: n.nodeName == 'name',
                      node.childNodes)[0].childNodes[0].nodeValue
        return name
    # class nodes order in instrumenter output is unstable,
    # so we sort classes here
    xml_actual.documentElement.childNodes[:] = \
            filter(lambda n: n.nodeType == xml.dom.Node.ELEMENT_NODE,
                   xml_actual.documentElement.childNodes)

    actual = xml_actual.toprettyxml(indent='  ')

    try:
        open(xml_name, 'w').write(actual)
    except Exception as e:
        print('could not write %s (%s)' % (xml_name, e))
        return 1
    return 0

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument(
        'xml_path',
        help='The path to the instrumentation output.')
    args = parser.parse_args()

    err_code = format_file(args.xml_path)
    return err_code

if __name__ == '__main__':
    sys.exit(main())
