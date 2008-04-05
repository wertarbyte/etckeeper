#!/usr/bin/python
# Bazaar plugin that runs etckeeper pre-commit when necessary

"""Runs etckeeper pre-commit when necessary."""

from bzrlib.mutabletree import MutableTree
from bzrlib.errors import BzrError, NotLocalUrl
import os
import subprocess

def etckeeper_startcommit_hook(tree):
    if not os.path.exists(tree.abspath(".etckeeper")):
        # Only run the commit hook when this is an etckeeper branch
        return
    ret = subprocess.call(["etckeeper", "pre-commit", tree.abspath(".")])
    if ret != 0:
        raise BzrError("etckeeper pre-commit failed")

MutableTree.hooks.install_hook('start_commit', etckeeper_startcommit_hook)
MutableTree.hooks.name_hook(etckeeper_startcommit_hook, "etckeeper")

if __name__ == "__main__":
    from distutils.core import setup
    setup(name="bzr-etckeeper", 
          package_dir={"bzrlib.plugins.etckeeper":__file__},
          py_modules=["bzrlib.plugins.etckeeper"])
