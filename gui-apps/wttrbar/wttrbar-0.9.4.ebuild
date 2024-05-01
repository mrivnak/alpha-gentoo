EAPI=8

CRATES="
    addr2line@0.21.0
    adler@1.0.2
    android-tzdata@0.1.1
    android_system_properties@0.1.5
    anstream@0.6.12
    anstyle@1.0.6
    anstyle-parse@0.2.3
    anstyle-query@1.0.2
    anstyle-wincon@3.0.2
    autocfg@1.1.0
    backtrace@0.3.69
    base64@0.21.7
    bitflags@1.3.2
    bumpalo@3.15.3
    bytes@1.5.0
    cc@1.0.88
    cfg-if@1.0.0
    chrono@0.4.34
    clap@4.5.1
    clap_builder@4.5.1
    clap_derive@4.5.0
    clap_lex@0.7.0
    colorchoice@1.0.0
    core-foundation@0.9.4
    core-foundation-sys@0.8.6
    encoding_rs@0.8.33
    equivalent@1.0.1
    fnv@1.0.7
    form_urlencoded@1.2.1
    futures-channel@0.3.30
    futures-core@0.3.30
    futures-io@0.3.30
    futures-sink@0.3.30
    futures-task@0.3.30
    futures-util@0.3.30
    getrandom@0.2.12
    gimli@0.28.1
    h2@0.3.24
    hashbrown@0.14.3
    heck@0.4.1
    hermit-abi@0.3.8
    http@0.2.11
    http-body@0.4.6
    httparse@1.8.0
    httpdate@1.0.3
    hyper@0.14.28
    hyper-rustls@0.24.2
    iana-time-zone@0.1.60
    iana-time-zone-haiku@0.1.2
    idna@0.5.0
    indexmap@2.2.3
    ipnet@2.9.0
    itoa@1.0.10
    js-sys@0.3.68
    libc@0.2.153
    log@0.4.20
    memchr@2.7.1
    mime@0.3.17
    miniz_oxide@0.7.2
    mio@0.8.10
    num-traits@0.2.18
    num_cpus@1.16.0
    object@0.32.2
    once_cell@1.19.0
    percent-encoding@2.3.1
    pin-project-lite@0.2.13
    pin-utils@0.1.0
    proc-macro2@1.0.78
    quote@1.0.35
    reqwest@0.11.24
    ring@0.17.8
    rustc-demangle@0.1.23
    rustls@0.21.10
    rustls-pemfile@1.0.4
    rustls-webpki@0.101.7
    ryu@1.0.17
    sct@0.7.1
    serde@1.0.197
    serde_derive@1.0.197
    serde_json@1.0.114
    serde_urlencoded@0.7.1
    slab@0.4.9
    socket2@0.5.6
    spin@0.9.8
    strsim@0.11.0
    syn@2.0.51
    sync_wrapper@0.1.2
    system-configuration@0.5.1
    system-configuration-sys@0.5.0
    tinyvec@1.6.0
    tinyvec_macros@0.1.1
    tokio@1.36.0
    tokio-rustls@0.24.1
    tokio-util@0.7.10
    tower-service@0.3.2
    tracing@0.1.40
    tracing-core@0.1.32
    try-lock@0.2.5
    unicode-bidi@0.3.15
    unicode-ident@1.0.12
    unicode-normalization@0.1.23
    untrusted@0.9.0
    url@2.5.0
    utf8parse@0.2.1
    want@0.3.1
    wasi@0.11.0+wasi-snapshot-preview1
    wasm-bindgen@0.2.91
    wasm-bindgen-backend@0.2.91
    wasm-bindgen-futures@0.4.41
    wasm-bindgen-macro@0.2.91
    wasm-bindgen-macro-support@0.2.91
    wasm-bindgen-shared@0.2.91
    web-sys@0.3.68
    webpki-roots@0.25.4
    windows-core@0.52.0
    windows-sys@0.48.0
    windows-sys@0.52.0
    windows-targets@0.48.5
    windows-targets@0.52.3
    windows_aarch64_gnullvm@0.48.5
    windows_aarch64_gnullvm@0.52.3
    windows_aarch64_msvc@0.48.5
    windows_aarch64_msvc@0.52.3
    windows_i686_gnu@0.48.5
    windows_i686_gnu@0.52.3
    windows_i686_msvc@0.48.5
    windows_i686_msvc@0.52.3
    windows_x86_64_gnu@0.48.5
    windows_x86_64_gnu@0.52.3
    windows_x86_64_gnullvm@0.48.5
    windows_x86_64_gnullvm@0.52.3
    windows_x86_64_msvc@0.48.5
    windows_x86_64_msvc@0.52.3
    winreg@0.50.0
"

inherit cargo

DESCRIPTION="Custom module for showing the weather in Waybar, using the great wttr.in"
HOMEPAGE="https://github.com/bjesus/wttrbar"
SRC_URI="
    https://github.com/bjesus/wttrbar/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
    ${CARGO_CRATE_URIS}
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

BDEPEND=">=virtual/rust-1.65"

src_configure() {
    cargo_src_configure
}

src_install() {
    cargo_src_install
    dodoc README.md
}

