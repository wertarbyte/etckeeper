#!/usr/bin/python
# Bazaar plugin that runs etckeeper pre-commit when necessary

"""Runs etckeeper pre-commit when necessary."""

import bzrlib
from bzrlib.mutabletree import MutableTree
from bzrlib.errors import BzrError, NotLocalUrl
import os
import subprocess

if not (hasattr(MutableTree, "hooks") and "start_commit" in MutableTree.hooks):
    raise "Version of Bazaar installed does not support required hooks."

def etckeeper_startcommit_hook(tree):
    abspath = getattr(tree, "abspath", None)
    if abspath is None or not os.path.exists(abspath(".etckeeper")):
        # Only run the commit hook when this is an etckeeper branch
        return
    ret = subprocess.call(["etckeeper", "pre-commit", abspath(".")])
    if ret != 0:
        raise BzrError("etckeeper pre-commit failed")

install_named_hook = getattr(MutableTree.hooks, 'install_named_hook', None)
if install_named_hook is not None:
    install_named_hook('start_commit', etckeeper_startcommit_hook, 'etckeeper')
else:
    MutableTree.hooks.install_hook('start_commit', etckeeper_startcommit_hook)
    MutableTree.hooks.name_hook(etckeeper_startcommit_hook, "etckeeper")

if __name__ == "__main__":
    from distutils.core import setup
    setup(name="bzr-etckeeper", 
          packages=["bzrlib.plugins.etckeeper"],
          package_dir={"bzrlib.plugins.etckeeper":"etckeeper-bzr"})
