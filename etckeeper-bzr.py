#!/usr/bin/python
# bzr plugin that runs etckeeper pre-commit when necessary

from bzrlib.branch import Branch
from bzrlib.errors import BzrError, NotLocalUrl
import os
import subprocess

def etckeeper_precommit_hook(local, master, old_revno, old_revid, 
                           new_revno, new_revid, tree_delta, future_tree):
    if local is None:
        branch = master
    else:
        branch = local
    try:
        base = branch.bzrdir.root_transport.local_abspath(".")
    except NotLocalUrl:
        # No point in running etckeeper when committing to a remote branch
        return
    if not os.path.exists(os.path.join(base, ".etckeeper")):
        # Only run the commit hook when this is an etckeeper branch
        return
    ret = subprocess.call(["etckeeper", "pre-commit", base])
    if ret != 0:
        raise BzrError("etckeeper pre-commit failed")

Branch.hooks.install_hook('pre_commit', etckeeper_precommit_hook)
Branch.hooks.name_hook(etckeeper_precommit_hook, "etckeeper")
