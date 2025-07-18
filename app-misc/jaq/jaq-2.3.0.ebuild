# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Autogenerated by pycargoebuild 0.15.0

EAPI=8

CRATES="
	aho-corasick@1.1.3
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	arbitrary@1.4.1
	autocfg@1.5.0
	base64@0.22.1
	bitflags@2.9.1
	bumpalo@3.14.0
	cc@1.2.29
	cfg-if@1.0.1
	chrono@0.4.41
	clipboard-win@5.4.0
	codesnake@0.2.1
	console_log@1.0.0
	core-foundation-sys@0.8.7
	dirs-sys@0.5.0
	dirs@6.0.0
	dyn-clone@1.0.19
	env_logger@0.10.2
	equivalent@1.0.2
	errno@0.3.13
	error-code@3.3.2
	fastrand@2.3.0
	fd-lock@4.0.4
	foldhash@0.1.5
	getrandom@0.2.16
	getrandom@0.3.3
	hashbrown@0.15.4
	hermit-abi@0.5.2
	hifijson@0.2.2
	iana-time-zone-haiku@0.1.2
	iana-time-zone@0.1.63
	indexmap@2.10.0
	is-terminal@0.4.16
	itoa@1.0.15
	js-sys@0.3.77
	libc@0.2.174
	libm@0.2.15
	libmimalloc-sys@0.1.43
	libredox@0.1.4
	linux-raw-sys@0.9.4
	log@0.4.27
	memchr@2.7.5
	memmap2@0.9.5
	mimalloc@0.1.47
	nix@0.27.1
	num-traits@0.2.19
	once_cell@1.20.3
	option-ext@0.2.0
	proc-macro2@1.0.95
	quote@1.0.40
	r-efi@5.3.0
	redox_users@0.5.0
	regex-lite@0.1.6
	rustix@1.0.7
	rustversion@1.0.21
	rustyline@13.0.0
	ryu@1.0.20
	serde@1.0.219
	serde_derive@1.0.219
	serde_json@1.0.140
	shlex@1.3.0
	syn@2.0.104
	tempfile@3.20.0
	thiserror-impl@2.0.12
	thiserror@2.0.12
	typed-arena@2.0.2
	unicode-ident@1.0.18
	unicode-segmentation@1.12.0
	unicode-width@0.1.14
	urlencoding@2.1.3
	utf8parse@0.2.2
	wasi@0.11.1+wasi-snapshot-preview1
	wasi@0.14.2+wasi-0.2.4
	wasm-bindgen-backend@0.2.100
	wasm-bindgen-macro-support@0.2.100
	wasm-bindgen-macro@0.2.100
	wasm-bindgen-shared@0.2.100
	wasm-bindgen@0.2.100
	web-sys@0.3.77
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-core@0.61.2
	windows-implement@0.60.0
	windows-interface@0.59.1
	windows-link@0.1.3
	windows-result@0.3.4
	windows-strings@0.4.2
	windows-sys@0.59.0
	windows-targets@0.52.6
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.52.6
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_msvc@0.52.6
	wit-bindgen-rt@0.39.0
	yansi@1.0.1
"

#RUST_MIN_VER="1.66.0"
inherit cargo

DESCRIPTION="Just another JSON query tool"
HOMEPAGE="https://github.com/01mf02/jaq"
SRC_URI="
	https://github.com/01mf02/jaq/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="MIT"
# Dependent crate licenses
LICENSE+="
	MIT Unicode-3.0 ZLIB
	|| ( Apache-2.0 Boost-1.0 )
"
SLOT="0"
KEYWORDS="~amd64"

QA_FLAGS_IGNORED="usr/bin/jaq"
QA_PRESTRIPPED="usr/bin/jaq"

DOCS=(
	README.md
	examples/
)

src_install() {
	pushd "${S}/jaq" >/dev/null || die
	cargo_src_install
	popd >/dev/null || die

	default
}
