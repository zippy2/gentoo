# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gap-pkg

DESCRIPTION="GAP implementation of SHA256 and HMAC for the Jupyter kernel"
SRC_URI="https://github.com/gap-packages/${PN}/releases/download/v${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~riscv"

DEPEND="sci-mathematics/gap:="
RDEPEND="${DEPEND}"

gap-pkg_enable_tests
