# Copyright 2022 Michael Rivnak

EAPI=8

MY_PN=${PN/-bin/}
MY_P=${MY_PN}-${PV/_/-}
MY_PV=$(ver_cut 1-2)

DESCRIPTION="Dart SDK"
HOMEPAGE="https://dart.dev/"
LICENSE="BSD-3"

BASE_SRC_URI="https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.3/sdk"
SRC_URI="
	x86? ( ${BASE_SRC_URI}/dartsdk-linux-ia32-release.zip )
	amd64? ( ${BASE_SRC_URI}/dartsdk-linux-x64-release.zip )
	arm? ( ${BASE_SRC_URI}/dartsdk-linux-arm-release.zip )
	arm64? ( ${BASE_SRC_URI}/dartsdk-linux-arm64-release.zip )
"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm ~arm64"
IUSE=""
 
DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="app-arch/unzip"

S="${WORKDIR}/dart-sdk"

src_install() {
	insinto "/usr/$(get_libdir)/${MY_P}/"
	doins -r ./include
	doins -r ./lib

	exeinto "/usr/$(get_libdir)/${MY_P}/bin"
    for bin in dart dartaotruntime;
    do
        doexe "bin/${bin}"
        dosym "../$(get_libdir)/${MY_P}/bin/${bin}" "/usr/bin/${bin}"
    done
}