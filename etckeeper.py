#!/usr/bin/python
# bzr plugin that runs etckeeper pre-commit when necessary

from bzrlib.branch import Branch
from bzrlib.errors import BzrError
import os
import subprocess

def branch_pre_commit_hook(local, master, old_revno, old_revid, 
                           new_revno, new_revid, tree_delta, future_tree):
    if local is None:
        branch = master
    else:
        branch = local
    base = branch.bzrdir.root_transport.local_abspath(".")
    if not os.path.exists(os.path.join(base, ".etckeeper")):
        return
    ret = subprocess.call(["etckeeper", "pre-commit", base])
    if ret != 0:
        raise BzrError("etckeeper pre-commit failed")

Branch.hooks.install_hook('pre_commit', branch_pre_commit_hook)
Branch.hooks.name_hook(branch_pre_commit_hook, "shell-hooks")
