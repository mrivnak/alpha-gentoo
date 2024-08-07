# Copyright 2024 Mike Rivnak

EAPI=8

inherit edo

DESCRIPTION="A small, secure Wayland screenlocker"
HOMEPAGE="https://codeberg.org/ifreund/waylock"
SRC_URI="
	https://codeberg.org/ifreund/waylock/releases/download/v${PV}/${P}.tar.gz
	https://codeberg.org/ifreund/zig-wayland/archive/v0.2.0.tar.gz -> zig-wayland-0.2.0.tar.gz
	https://codeberg.org/ifreund/zig-xkbcommon/archive/v0.2.0.tar.gz -> zig-xkbcommon-0.2.0.tar.gz
"

LICENSE="GPL-3.0-or-later"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="doc"

EZIG_MIN="0.13"
EZIG_MAX_EXCLUSIVE="0.14"

DEPEND="
	dev-libs/wayland
	media-libs/mesa
	sys-libs/pam
	x11-libs/libxkbcommon
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-lang/zig:${EZIG_MIN}
	dev-libs/wayland-protocols
	dev-python/zonpy
    doc? ( app-test/scdoc )
"

# see https://github.com/ziglang/zig/issues/3382
# For now, Zig Build System doesn't support CFLAGS/LDFLAGS/etc.
QA_FLAGS_IGNORED="usr/bin/river*"

# Set the EZIG environment variable.
zig-set_EZIG() {
	[[ -n ${EZIG} ]] && return

	if [[ -n ${EZIG_OVERWRITE} ]]; then
		export EZIG="${EZIG_OVERWRITE}"
		return
	fi

	local candidates candidate selected selected_ver

	candidates=$(compgen -c zig-)

	for candidate in ${candidates}; do
		if [[ ! ${candidate} =~ zig(-bin)?-([.0-9]+) ]]; then
			continue
		fi

		local ver
		if (( ${#BASH_REMATCH[@]} == 3 )); then
			ver="${BASH_REMATCH[2]}"
		else
			ver="${BASH_REMATCH[1]}"
		fi

		if [[ -n ${EZIG_EXACT_VER} ]]; then
			ver_test "${ver}" -ne "${EZIG_EXACT_VER}" && continue

			selected="${candidate}"
			selected_ver="${ver}"
			break
		fi

		if [[ -n ${EZIG_MIN} ]] \
			  && ver_test "${ver}" -lt "${EZIG_MIN}"; then
			# Candidate does not satisfy EZIG_MIN condition.
			continue
		fi

		if [[ -n ${EZIG_MAX_EXCLUSIVE} ]] \
			  && ver_test "${ver}" -ge "${EZIG_MAX_EXCLUSIVE}"; then
			# Candidate does not satisfy EZIG_MAX_EXCLUSIVE condition.
			continue
		fi

		if [[ -n ${selected_ver} ]] \
			  && ver_test "${selected_ver}" -gt "${ver}"; then
			# Candidate is older than the currently selected candidate.
			continue
		fi

		selected="${candidate}"
		selected_ver="${ver}"
	done

	if [[ -z ${selected} ]]; then
		die "Could not find (suitable) zig installation in PATH"
	fi

	export EZIG="${selected}"
	export EZIG_VER="${ver}"
}

# Invoke zig with the optionally provided arguments.
ezig() {
	zig-set_EZIG
	if ([ -n "${ZIG_MCPU}" ]); then
		TARGET_CPU="-Dtarget-cpu=${ZIG_MCPU}"
	fi
	if ([ -n "${ZIG_TARGET}" ]); then
		TARGET="-Dtarget=${ZIG_TARGET}"
	fi
	edo "${EZIG}" $TARGET_CPU "${@}"
}

src_unpack() {
	cd "${DISTDIR}"
	tar -xf ${P}.tar.gz -C "${WORKDIR}" || die
	mkdir -p ${WORKDIR}/deps
	python ${FILESDIR}/extract_deps.py ${WORKDIR}/${P}/build.zig.zon ${WORKDIR}/deps || die
}

src_compile() {
	mkdir -p output
	# River only has a single build/install target so we just install to a temporary directory
	# and then move the files to the correct location in src_install
	DESTDIR="output" ezig build --system ${WORKDIR}/deps/ install --prefix /usr -Doptimize=ReleaseSafe --verbose || die
}


src_install() {
	exeinto /usr/bin
	doexe output/usr/bin/waylock

	dodoc README.md

	if use doc; then
		insinto /usr/share/man/man1
		doins output/usr/share/man/man1/waylock.1
	fi
}

