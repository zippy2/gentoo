# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYPI_PN=${PN/-/.}
PYTHON_COMPAT=( python3_{11..14} pypy3_11 )

inherit distutils-r1 pypi

DESCRIPTION="Basic inter-process locks"
HOMEPAGE="
	https://github.com/zopefoundation/zc.lockfile/
	https://pypi.org/project/zc.lockfile/
"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 hppa ~loong ~m68k ~mips ppc ppc64 ~riscv ~s390 sparc x86"
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="
	test? (
		dev-python/zope-testing[${PYTHON_USEDEP}]
	)
"

DOCS=( CHANGES.rst README.rst )

distutils_enable_tests unittest

python_prepare_all() {
	# rdep is only needed for namespace
	sed -i -e '/install_requires.*setuptools/d' setup.py || die
	# do not install README into site-packages
	sed -e '/^    include_package_data/d' -i setup.py || die

	distutils-r1_python_prepare_all
}

python_test() {
	"${EPYTHON}" -m unittest zc.lockfile.tests -v || die
}
