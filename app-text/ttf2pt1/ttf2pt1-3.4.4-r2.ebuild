# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="True Type Font to Postscript Type 1 Converter"
HOMEPAGE="https://ttf2pt1.sourceforge.net/"
SRC_URI="https://downloads.sourceforge.net/ttf2pt1/${P}.tgz"

LICENSE="ttf2pt1"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"

DEPEND=">=media-libs/freetype-2.5.1:2"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}"/${P}-Makefile.patch
	"${FILESDIR}"/${P}-LDFLAGS.patch
	"${FILESDIR}"/${PN}-3.4.0-man-pages.diff
	"${FILESDIR}"/${P}-freetype.patch
	"${FILESDIR}"/${P}-clang16.patch
)

src_prepare() {
	default

	sed -i \
		-e "/^CC=/ { s:gcc:$(tc-getCC): }" \
		-e "/^CFLAGS_SYS=/ { s:-O.*$:${CFLAGS}: }" \
		-e "/^LIBS_FT=/ { s:-L/usr/lib:-L${ESYSROOT}/usr/$(get_libdir): }" \
		-e "s:-I/usr/include/freetype2 -I/usr/include:$($(tc-getPKG_CONFIG) --cflags freetype2):" \
		-e "s:-L/usr/lib -lfreetype:$($(tc-getPKG_CONFIG) --libs freetype2):" \
		-e "/^LIBXDIR =/ { s:libexec:$(get_libdir): }" \
		-e "/chown/d" \
		-e "/chgrp/d" \
		-e "/chmod/d" \
		Makefile || die
}

src_install() {
	emake INSTDIR="${ED}"/usr install
	dodir /usr/share/doc/${PF}

	pushd "${ED}"/usr/share/ttf2pt1 > /dev/null || die
	rm -r app other || die
	mv [A-Z]* ../doc/${PF} || die
	popd > /dev/null || die
}
