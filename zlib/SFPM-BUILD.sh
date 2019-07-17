name=zlib
version=1.2.11
release=1
sources=(
    https://zlib.net/${name}-${version}.tar.xz
)
sha256sums=(
    4ff941449631ace0d4d203e3483be9dbc9da454084111f97ea0a2114e19bf066
)

prepare() {
    cd "${srcdir}/${name}-${version}"
}

build() {
    export CFLAGS=${sfpm_build_cflags}
    export LDFLAGS=${sfpm_build_ldflags}

    ./configure --prefix=${sfpm_build_prefix} \
        --enable-shared

    make -j$(sfpm_CPUS)
}

package() {
    make install DESTDIR=${pkgdir}
}
