#!/usr/bin/env python
# Interactive git checkout.

import os
import sys
import subprocess
import unittest

from collections import namedtuple
from StringIO import StringIO
from subprocess import call


DETACHED_HEAD_BRANCH_NAME = '(no branch) - detached HEAD'


# Keep data about branches.
BranchesInfo = namedtuple('BranchesInfo', [
        'all_branches',  # list of strings
        'current_branch',  # string
        'current_index',  # number
        ])


def get_git_branches():
    "Returns git branch output."
    command = ['git', 'branch', '--no-color']
    return subprocess.check_output(command)


def git_checkout(branch):
    "Returns git checkout output."
    command = ['git', 'checkout', branch]
    return subprocess.check_output(command)


def branches_menu(branches_info):
    "Returns a simple menu as string."
    s = StringIO()
    s.write('\nCurrent branch: %s\n\n' % branches_info.current_branch)
    for i, branch in enumerate(branches_info.all_branches):
        s.write('%s  %s\n' % (i, branch))
    return s.getvalue()


def parse_git_branches(output):
    "Returns an instance of BranchesInfo class."
    all_branches = []
    current_branch = ''
    current_index = -1
    i = -1
    for line in output.splitlines():
        parts = line.split()
        if not parts:
            continue  # skip empty lines
        i += 1
        if line == '* (no branch)':  # detached HEAD
            current_index = i
            current_branch = DETACHED_HEAD_BRANCH_NAME
            all_branches.append(DETACHED_HEAD_BRANCH_NAME)
            continue

        all_branches.append(parts[-1])
        if parts[0] == '*':
            current_index = i
            current_branch = parts[-1]

    return BranchesInfo(all_branches, current_branch, current_index)


class TestParseGitBranches(unittest.TestCase):

    def test_normal_output(self):
        output = 'master\n  test\n* new-features\n'
        b = parse_git_branches(output)
        self.assertEqual(b.current_branch, 'new-features')
        self.assertEqual(b.current_index, 2)
        self.assertEqual(b.all_branches[0], 'master')
        self.assertEqual(b.all_branches[1], 'test')
        self.assertEqual(b.all_branches[2], 'new-features')

    def test_detached_head(self):
        output = '* (no branch)\n  master\n'
        b = parse_git_branches(output)
        self.assertEqual(b.current_branch, DETACHED_HEAD_BRANCH_NAME)
        self.assertEqual(b.current_index, 0)
        self.assertEqual(b.all_branches[0], DETACHED_HEAD_BRANCH_NAME )
        self.assertEqual(b.all_branches[1], 'master')


class TestBranchesMenu(unittest.TestCase):

    def test_menu(self):
        all_branches = ['master', 'docs', 'test']
        b = BranchesInfo(all_branches, 'docs', 1)
        self.assertEqual(branches_menu(b), '''
Current branch: docs

0  master
1  docs
2  test
''')


def runTests():
    all_test_cases = [TestParseGitBranches, TestBranchesMenu]
    loader = unittest.TestLoader()
    all_suites = [loader.loadTestsFromTestCase(t) for t in all_test_cases]
    all_tests = unittest.TestSuite(all_suites)
    result = unittest.TextTestRunner().run(all_tests)
    if result.wasSuccessful():
        return 0
    return 1


def main(args):
    program_args = args[1:]

    if '--test' in program_args:
        return runTests()

    if len(program_args) > 0:
        return call(['git', 'checkout'] + program_args)

    output = get_git_branches()
    branches_info = parse_git_branches(output)
    print(branches_menu(branches_info))
    try:
        choice = raw_input('Select a branch by number: ')
        branch = branches_info.all_branches[int(choice)]
        print(git_checkout(branch))
    except KeyboardInterrupt:
        print('\nCanceled.')
    except:
        print('Invalid input. Checkout fail.')
        return 1
    return 0


if __name__ == '__main__':
    sys.exit(main(sys.argv))
