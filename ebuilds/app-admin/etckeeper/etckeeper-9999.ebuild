# Copyright
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# Do not use this ebuild for versions 0.6 and below
inherit eutils bash-completion git
EGIT_REPO_URI="git://git.kitenet.net/"
HOMEPAGE="http://kitenet.net/~joey/code/etckeeper/"
DESCRIPTION="etc-keeper provides a tool for revision-controlling permissioned dirs"

IUSE="paludis bash-completion apt"
KEYWORDS="~x86 ~amd64"

DEPEND="${DEPEND}
		>=dev-util/git-1.5.3.4
		paludis? (sys-apps/paludis)
		bash-completion? (app-shells/bash-completion)
		=sys-devel/metastore-9999"

RDEPEND="${DEPEND}"

src_install() {
	dodir /etc/etckeeper || die

	if use paludis; then
		echo > etckeeper-commit_changes <<PREMERGE
#!/bin/sh
etckeeper pre-all-emerge "::AUTO::"
PREMERGE
		echo > etckeeper-commit_installed_changes <<POSTMERGE
#!/bin/sh
etckeeper post-each-emerge "::AUTO::"
POSTMERGE
		exeinto /usr/share/paludis/hooks/install_all_pre
			doexe etckeeper-commit_changes
		exeinto /usr/share/paludis/hooks/install_post
			doexe etckeeper-commit_installed_changes
	fi

	insinto /etc/etckeeper/
		doins init.d
		doins pre-commit.d
		doins pre-all-merge.d
		doins post-all-merge.d

	exeinto /usr/bin
		doexe etckeeper

	doman etckeeper.1.gentoo etckeeper.1

	exeinto /etc/etckeeper/
		for i in init.d/* pre-commit.d/*; do
			doexe $i
		done

	insinto /etc/etckeeper
		doins etckeeper.conf
		doins package_managed_dirs

	dobashcompletion bash_completion etckeeper

	dodoc README
	dodoc TODO
}

pkg_postinst() {
	elog "Please do not report bugs with this program"
	elog "on the Gentoo bugzilla. Bugs with etckeeper"
	elog "itself or the apt bindings may be addressed"
	elog "to Joey Hess via joey at kitenet dot net."
	elog "Bugs with the Paludis hooks may be addressed"
	elog "to Alex Elsayed via eternaleye at gmail dot"
	elog "com. But I did touch it last. ~Alex"
}