# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg-utils

DESCRIPTION="A panel plug-in for acpi, lm-sensors and hddtemp sensors"
HOMEPAGE="
	https://docs.xfce.org/panel-plugins/xfce4-sensors-plugin/start
	https://gitlab.xfce.org/panel-plugins/xfce4-sensors-plugin/
"
SRC_URI="https://archive.xfce.org/src/panel-plugins/${PN}/${PV%.*}/${P}.tar.bz2"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 ~riscv x86"
IUSE="+acpi hddtemp libnotify lm-sensors video_cards_nvidia"
REQUIRED_USE="|| ( hddtemp lm-sensors acpi )"

DEPEND="
	>=x11-libs/gtk+-3.22.0:3
	>=xfce-base/libxfce4ui-4.16.0:=
	>=xfce-base/libxfce4util-4.17.2:=
	>=xfce-base/xfce4-panel-4.16.0:=
	hddtemp? (
		app-admin/hddtemp
		|| (
			net-analyzer/openbsd-netcat
			net-analyzer/netcat
		)
	)
	libnotify? ( >=x11-libs/libnotify-0.7:= )
	lm-sensors? ( >=sys-apps/lm-sensors-3.1.0:= )
	video_cards_nvidia? ( x11-drivers/nvidia-drivers[tools,static-libs] )
"
RDEPEND="
	${DEPEND}
"
BDEPEND="
	>=sys-devel/gettext-0.19.8
	virtual/pkgconfig
"

src_configure() {
	local myconf=(
		--libexecdir="${EPREFIX}"/usr/$(get_libdir)
		$(use_enable lm-sensors libsensors)
		$(use_enable hddtemp)
		$(use_enable hddtemp netcat)
		$(use_enable acpi procacpi)
		$(use_enable acpi sysfsacpi)
		$(use_enable video_cards_nvidia xnvctrl)
		$(use_enable libnotify notification)
		--disable-pathchecks
	)

	econf "${myconf[@]}"
}

src_install() {
	default
	find "${D}" -name '*.la' -delete || die
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
