#!/usr/bin/env python3
import argparse
import logging
import os, os.path
import sys
from fuzzyfinder import fuzzyfinder

USAGE = '''
    %(prog)s [options] --add <command> ...
    %(prog)s [options] --search <pattern>
    %(prog)s [options] --edit
    %(prog)s [options] -h'''

FAVORITES_FILE_NAME= ".favorite_commands"

def get_file_name():
    name = os.path.join(os.getenv('HOME'), FAVORITES_FILE_NAME)
    logging.debug('Using favorites file ' + name)

def action_add(command):
   command_str = ' '.join(command)
   command_str = command_str.replace('\n', ' ')
   with open(get_file_name(), 'a', encoding='utf-8') as f:
       lines = f.readlines()
       if command_str in lines:
           logging.info('Command already in list: ' + command_str)
           return
       f.write(command_str + '\n')
       logging.debug('Command added: ' + command_str)

def action search(pattern):
   with open(get_file_name(), 'r', encoding='utf-8') as f:
       lines = f.readlines()



def create_parser():
    parser = argparse.ArgumentParser(
                description='FavoriteCommands: tool to store your favorite shell commands and fuzzy search for them',
                usage=USAGE,
                add_help=False)
    action_args = parser.add_argument_group('Actions')
    exclusive_action_args = action_args.add_mutually_exclusive_group()
    other_args = parser.add_argument_group('Other arguments')
    exclusive_action_args.add_argument(
        '-a', '--add', nargs='+', help='add command to favorites list')
    exclusive_action_args.add_argument(
        '-s', '--search', action='store', help='fuzzy search favorites list for specified substring and print all matches')
    exclusive_action_args.add_argument(
        '-e', '--edit', action='store_true', help='open favorites list in default editor')
    other_args.add_argument(
        '-v', '--verbose', action='count', help='increase verbosity')
    other_args.add_argument(
        '-h', '--help', action='help', help='show this help message and exit')
    return parser

def parse_args(args):
        args = dict((k, v)
            for k, v in vars(create_parser().parse_args(args)).items()
                if v)
        return args

def main(argv):
    logging.basicConfig(format='%(levelname)s: %(message)s', level=logging.INFO)

    try:
        args = parse_args(argv)
    except Exception as exc:
        logging.exception(exc)
        return 1

    try:
        if args.get('verbose', 0) > 0:
            logging.getLogger().setLevel(logging.DEBUG)
        if 'add' in args:
            action_add(args['add'])
        elif 'search' in args:
            action_search(args['search'])
        elif 'edit' in args:
            action_edit()
    except Exception as exc:
        if logging.getLogger().getEffectiveLevel() == logging.DEBUG:
            logging.exception(exc)
        else:
            logging.error(str(exc))
        return 2

if __name__ == '__main__':
    sys.exit(main(sys.argv))
