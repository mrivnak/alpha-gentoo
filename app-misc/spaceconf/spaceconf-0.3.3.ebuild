EAPI=8

CRATES="
    aho-corasick@1.1.3
    android-tzdata@0.1.1
    android_system_properties@0.1.5
    anstream@0.6.13
    anstyle@1.0.6
    anstyle-parse@0.2.3
    anstyle-query@1.0.2
    anstyle-wincon@3.0.2
    autocfg@1.2.0
    bitflags@1.3.2
    bitflags@2.5.0
    block-buffer@0.10.4
    bstr@1.9.1
    bumpalo@3.16.0
    cc@1.0.96
    cfg-if@1.0.0
    chrono@0.4.38
    chrono-tz@0.8.6
    chrono-tz-build@0.2.1
    clap@4.5.4
    clap_builder@4.5.2
    clap_derive@4.5.4
    clap_lex@0.7.0
    colorchoice@1.0.0
    core-foundation-sys@0.8.6
    cpufeatures@0.2.12
    crossbeam-deque@0.8.5
    crossbeam-epoch@0.9.18
    crossbeam-utils@0.8.19
    crypto-common@0.1.6
    deunicode@1.4.4
    digest@0.10.7
    dirs@4.0.0
    dirs@5.0.1
    dirs-sys@0.3.7
    dirs-sys@0.4.1
    env_filter@0.1.0
    env_logger@0.11.3
    errno@0.3.9
    fastrand@2.1.0
    generic-array@0.14.7
    getrandom@0.2.14
    globset@0.4.14
    globwalk@0.8.1
    heck@0.5.0
    hermit-abi@0.3.9
    hostname@0.4.0
    humansize@2.1.3
    humantime@2.1.0
    iana-time-zone@0.1.60
    iana-time-zone-haiku@0.1.2
    ignore@0.4.22
    itoa@1.0.11
    js-sys@0.3.69
    lazy_static@1.4.0
    libc@0.2.154
    libm@0.2.8
    libredox@0.1.3
    linux-raw-sys@0.4.13
    log@0.4.21
    memchr@2.7.2
    num-traits@0.2.18
    num_cpus@1.16.0
    once_cell@1.19.0
    option-ext@0.2.0
    parse-zoneinfo@0.3.1
    percent-encoding@2.3.1
    pest@2.7.10
    pest_derive@2.7.10
    pest_generator@2.7.10
    pest_meta@2.7.10
    phf@0.11.2
    phf_codegen@0.11.2
    phf_generator@0.11.2
    phf_shared@0.11.2
    ppv-lite86@0.2.17
    proc-macro2@1.0.81
    quote@1.0.36
    rand@0.8.5
    rand_chacha@0.3.1
    rand_core@0.6.4
    redox_users@0.4.5
    regex@1.10.4
    regex-automata@0.4.6
    regex-syntax@0.8.3
    resolve-path@0.1.0
    rustix@0.38.34
    ryu@1.0.17
    same-file@1.0.6
    serde@1.0.199
    serde_derive@1.0.199
    serde_json@1.0.116
    sha2@0.10.8
    siphasher@0.3.11
    slug@0.1.5
    strsim@0.11.1
    syn@2.0.60
    tempfile@3.10.1
    tera@1.19.1
    thiserror@1.0.59
    thiserror-impl@1.0.59
    typenum@1.17.0
    ucd-trie@0.1.6
    unic-char-property@0.9.0
    unic-char-range@0.9.0
    unic-common@0.9.0
    unic-segment@0.9.0
    unic-ucd-segment@0.9.0
    unic-ucd-version@0.9.0
    unicode-ident@1.0.12
    utf8parse@0.2.1
    uuid@1.8.0
    version_check@0.9.4
    walkdir@2.5.0
    wasi@0.11.0+wasi-snapshot-preview1
    wasm-bindgen@0.2.92
    wasm-bindgen-backend@0.2.92
    wasm-bindgen-macro@0.2.92
    wasm-bindgen-macro-support@0.2.92
    wasm-bindgen-shared@0.2.92
    winapi@0.3.9
    winapi-i686-pc-windows-gnu@0.4.0
    winapi-util@0.1.8
    winapi-x86_64-pc-windows-gnu@0.4.0
    windows@0.52.0
    windows-core@0.52.0
    windows-sys@0.48.0
    windows-sys@0.52.0
    windows-targets@0.48.5
    windows-targets@0.52.5
    windows_aarch64_gnullvm@0.48.5
    windows_aarch64_gnullvm@0.52.5
    windows_aarch64_msvc@0.48.5
    windows_aarch64_msvc@0.52.5
    windows_i686_gnu@0.48.5
    windows_i686_gnu@0.52.5
    windows_i686_gnullvm@0.52.5
    windows_i686_msvc@0.48.5
    windows_i686_msvc@0.52.5
    windows_x86_64_gnu@0.48.5
    windows_x86_64_gnu@0.52.5
    windows_x86_64_gnullvm@0.48.5
    windows_x86_64_gnullvm@0.52.5
    windows_x86_64_msvc@0.48.5
    windows_x86_64_msvc@0.52.5
"

inherit cargo

DESCRIPTION="Simple configuration manager for dotfiles and system configuration files"
HOMEPAGE="https://github.com/mrivnak/spaceconf"
SRC_URI="
    https://github.com/mrivnak/spaceconf/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
    ${CARGO_CRATE_URIS}
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

BDEPEND=">=virtual/rust-1.65"

src_install() {
    cargo_src_install
    dodoc README.md
}
