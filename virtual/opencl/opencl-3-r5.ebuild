# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit multilib-build

DESCRIPTION="Virtual for OpenCL API"
SLOT="0"
KEYWORDS="amd64 arm64 ~loong ppc64 ~riscv x86"

RDEPEND="
	>=dev-libs/opencl-icd-loader-2023.02.06[${MULTILIB_USEDEP}]
"

pkg_postinst() {
	elog
	elog "In order to take advantage of OpenCL you will need a runtime for your hardware."
	elog "Currently included in Gentoo are:"
	elog
	elog " * open:"
	elog "    - dev-libs/intel-compute-runtime - integrated Intel GPUs from Gen12 onwards. 64-bit only;"
	elog "    - dev-libs/intel-compute-runtime:legacy - integrated Intel GPUs from Gen8 up to Gen11. 64-bit only;"
	elog "    - dev-libs/pocl - to run OpenCL programs on your CPU, if you do not have a supported GPU;"
	elog "    - dev-libs/rocm-opencl-runtime - AMD GPUs supported by the amdgpu kernel driver. 64-bit only;"
	elog "    - media-libs/mesa[opencl] - some older AMD GPUs; see [1]. 32-bit support;"
	elog
	elog " * proprietary:"
	elog "    - dev-libs/amdgpu-pro-opencl - AMD Polaris GPUs. 32-bit support;"
	elog "    - dev-util/intel-ocl-sdk - Intel CPUs (*not* GPUs). 64-bit only;"
	elog "    - x11-drivers/nvidia-drivers - Nvidia GPUs; specific package versions"
	elog "      required for older devices [2]. 32-bit support."
	elog
	elog " [1] https://dri.freedesktop.org/wiki/GalliumCompute/"
	elog " [2] https://www.nvidia.com/en-us/drivers/unix/legacy-gpu/"
	elog
}
