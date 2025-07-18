# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="A logging replacement for Python"
HOMEPAGE="
	https://logbook.readthedocs.io/en/stable/
	https://github.com/getlogbook/logbook/
	https://pypi.org/project/Logbook/
"
SRC_URI="
	https://github.com/getlogbook/logbook/archive/${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~riscv x86"

BDEPEND="
	test? (
		app-arch/brotli[${PYTHON_USEDEP},python]
		>=dev-python/execnet-1.0.9[${PYTHON_USEDEP}]
		dev-python/jinja2[${PYTHON_USEDEP}]
		dev-python/pip[${PYTHON_USEDEP}]
		dev-python/pytest-rerunfailures[${PYTHON_USEDEP}]
		dev-python/pyzmq[${PYTHON_USEDEP}]
		>=dev-python/sqlalchemy-1.4[${PYTHON_USEDEP}]
	)
"
distutils_enable_tests pytest
distutils_enable_sphinx docs

python_configure_all() {
	export DISABLE_LOGBOOK_CEXT=1
}

python_test() {
	local EPYTEST_DESELECT=(
		# Delete test file requiring local connection to redis server
		tests/test_queues.py
	)

	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	epytest -p rerunfailures
}
