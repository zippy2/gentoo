# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
LUA_COMPAT=( lua5-1 )

WX_GTK_VER="3.2-gtk3"
inherit cmake flag-o-matic lua-single wxwidgets

DESCRIPTION="Fork of OpenSceneGraph for the FlightGear project."
HOMEPAGE="https://gitlab.com/flightgear/openscenegraph"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/flightgear/openscenegraph.git"
	EGIT_BRANCH="next"
else
	SRC_URI="https://gitlab.com/flightgear/openscenegraph/-/archive/release/2024-build/openscenegraph-release-2024-build.tar.bz2"
	KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~x86"
fi

LICENSE="wxWinLL-3 LGPL-2.1"
SLOT="0/162" # NOTE: CHECK WHEN BUMPING! Subslot is SOVERSION
IUSE="
	curl debug doc egl examples fltk fox gdal gif glut jpeg las lua osgapps png
	sdl sdl2 svg tiff vnc wxwidgets xrandr +zlib
"

REQUIRED_USE="
	lua? ( ${LUA_REQUIRED_USE} )
	sdl2? ( sdl )
"

# TODO: FBX, GTA, NVTT, OpenVRML, Performer
BDEPEND="
	app-arch/unzip
	virtual/pkgconfig
	doc? ( app-text/doxygen[dot] )
"
RDEPEND="
	!dev-games/openscenegraph
	dev-libs/glib:2
	media-libs/fontconfig
	media-libs/mesa[egl(+)?]
	virtual/glu
	virtual/opengl
	x11-libs/libSM
	x11-libs/libXext
	curl? ( net-misc/curl )
	examples? (
		fltk? ( x11-libs/fltk:1=[opengl] )
		fox? ( x11-libs/fox:1.6[opengl] )
		glut? ( media-libs/freeglut )
		sdl2? ( media-libs/libsdl2 )
		wxwidgets? ( x11-libs/wxGTK:${WX_GTK_VER}[opengl,X] )
	)
	gdal? ( sci-libs/gdal:= )
	gif? ( media-libs/giflib:= )
	jpeg? ( media-libs/libjpeg-turbo:= )
	las? ( >=sci-geosciences/liblas-1.8.0 )
	lua? ( ${LUA_DEPS} )
	png? ( media-libs/libpng:0= )
	sdl? ( media-libs/libsdl )
	svg? (
		gnome-base/librsvg:2
		x11-libs/cairo
	)
	tiff? ( media-libs/tiff:= )
	media-libs/freetype:2
	vnc? ( net-libs/libvncserver )
	xrandr? ( x11-libs/libXrandr )
	zlib? ( sys-libs/zlib )
"
DEPEND="${RDEPEND}
	dev-libs/boost
	x11-base/xorg-proto
"

PATCHES=(
	"${FILESDIR}"/openscenegraph-3.6.3-cmake.patch
	"${FILESDIR}"/openscenegraph-3.6.3-docdir.patch
	"${FILESDIR}"/openscenegraph-3.6.5-cmake_lua_version.patch
)

pkg_setup() {
	use lua && lua-single_pkg_setup
}

src_configure() {
	if use examples && use wxwidgets; then
		setup-wxwidgets unicode
	fi

	local libdir=$(get_libdir)
	local mycmakeargs=(
		$(cmake_use_find_package curl CURL)
		$(cmake_use_find_package egl EGL)
		$(cmake_use_find_package gdal GDAL)
		$(cmake_use_find_package gif GIFLIB)
		$(cmake_use_find_package jpeg JPEG)
		$(cmake_use_find_package las LIBLAS)
		$(cmake_use_find_package lua Lua)
		$(cmake_use_find_package png PNG)
		$(cmake_use_find_package sdl SDL)
		$(cmake_use_find_package sdl2 SDL2)
		$(cmake_use_find_package svg RSVG)
		$(cmake_use_find_package tiff TIFF)
		$(cmake_use_find_package vnc LibVNCServer)
		$(cmake_use_find_package zlib ZLIB)
		-DBUILD_DOCUMENTATION=$(usex doc)
		-DBUILD_OSG_APPLICATIONS=$(usex osgapps)
		-DBUILD_OSG_EXAMPLES=$(usex examples)
		-DCMAKE_DISABLE_FIND_PACKAGE_ASIO=ON
		-DCMAKE_DISABLE_FIND_PACKAGE_DirectInput=ON
		-DCMAKE_DISABLE_FIND_PACKAGE_DirectShow=ON
		-DCMAKE_DISABLE_FIND_PACKAGE_FBX=ON
		-DCMAKE_DISABLE_FIND_PACKAGE_GTA=ON
		-DCMAKE_DISABLE_FIND_PACKAGE_GtkGl=ON
		-DCMAKE_DISABLE_FIND_PACKAGE_NVTT=ON
		-DCMAKE_DISABLE_FIND_PACKAGE_ZeroConf=ON
		-DCMAKE_DISABLE_FIND_PACKAGE_ilmbase=ON
		-DDYNAMIC_OPENSCENEGRAPH=ON
		-DLIB_POSTFIX=${libdir/lib}
		-DOPENGL_PROFILE=GL2 #GL1 GL2 GL3 GLES1 GLES3 GLES3
		-DOSGVIEWER_USE_XRANDR=$(usex xrandr)
		-DOSG_USE_LOCAL_LUA_SOURCE=OFF
	)

	if use examples; then
		mycmakeargs+=(
			$(cmake_use_find_package fltk FLTK)
			$(cmake_use_find_package fox FOX)
			$(cmake_use_find_package glut GLUT)
			$(cmake_use_find_package wxwidgets wxWidgets)
		)
	fi

	if use lua; then
		mycmakeargs+=(
			-DLUA_VERSION="$(lua_get_version)"
		)
	fi

	cmake_src_configure
}

src_compile() {
	cmake_src_compile
	use doc && cmake_src_compile doc_openscenegraph doc_openthreads
}
