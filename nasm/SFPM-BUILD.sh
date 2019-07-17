name=nasm
version=2.14.02
release=1
sources=(
    https://www.nasm.us/pub/nasm/releasebuilds/${version}/${name}-${version}.tar.xz
    #https://www.nasm.us/pub/nasm/releasebuilds/${version}/${name}-${version}.tar.xz
)
sha256sums=(
    e24ade3e928f7253aa8c14aa44726d1edf3f98643f87c9d72ec1df44b26be8f5
    #b1fd69e1251c2172464107a69d2d3e9bfab541209670de02c7bb6e90dbfe5bbf
)

prepare() {
    cd "${srcdir}/${name}-${version}"
}

build() {
    export CFLAGS=${sfpm_build_cflags}
    export LDFLAGS=${sfpm_build_ldflags}
    ./configure --prefix=${sfpm_build_prefix} \
        --enable-lto \
        --enable-sections \
        --enable-sanitizer
    make -j4
}

package() {
    make install DESTDIR=${pkgdir}
}

package_nasm-rdf() {
    make install_rdf DESTDIR=${pkgdir}
}
