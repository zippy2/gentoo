# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

MY_PN="${PN/PEAR-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Creating passwords with PHP"
HOMEPAGE="https://pear.php.net/package/Text_Password"
SRC_URI="http://download.pear.php.net/package/${MY_P}.tgz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~hppa ppc64 ~sparc x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*"
DEPEND="test? (	${RDEPEND} dev-php/phpunit )"

S="${WORKDIR}/${MY_P}"

src_install() {
	insinto /usr/share/php
	doins -r Text
}

src_test() {
	phpunit tests/ || die 'test suite failed'
}
