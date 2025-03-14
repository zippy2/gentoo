# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="User-friendly program to show you what is using up all your disk space"
HOMEPAGE="https://xdiskusage.sourceforge.net/"
SRC_URI="https://xdiskusage.sourceforge.net/${P}.tgz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~ppc x86"

RDEPEND="x11-libs/fltk:1="
BDEPEND="${RDEPEND}"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}"/${PN}-1.52-flags-order.patch
	"${FILESDIR}"/${PN}-1.52-pathbuf.patch
)

src_compile() {
	# override FLAGS set by configure
	emake CXXFLAGS="${CXXFLAGS}"
}

src_install() {
	dobin ${PN}
	doman ${PN}.1
	dodoc README
}
