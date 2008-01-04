# Copyright
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils git
EGIT_REPO_URI="git://git.hardeman.nu/"
EGIT_PROJECT="metastore.git"
HOMEPAGE="http://david.hardeman.nu/software.php"
DESCRIPTION="metastore is a metadata tracker for git"

IUSE=""
KEYWORDS="~x86 ~amd64"

DEPEND="${DEPEND}
		sys-apps/attr"

RDEPEND="${DEPEND}"

src_install() {
	emake || die "make failed"
	emake install DESTDIR=${D} || die "make install failed"
	exeinto /usr/bin
		doexe examples/git-metapull git-metapull
		doexe examples/pre-commit pre-commit
}

pkg_postinst() {
	true
}