name=expat
_major=2
_minor=2
_patch=6
version=${_major}.${_minor}.${_patch}
release=1
sources=(
    https://github.com/libexpat/libexpat/archive/R_${_major}_${_minor}_${_patch}.tar.gz
)
sha256sums=(
    574499cba22a599393e28d99ecfa1e7fc85be7d6651d543045244d5b561cb7ff
)

prepare() {
    cd "${srcdir}/lib${name}-R_${_major}_${_minor}_${_patch}/${name}"
    sed -e 's|@false||g' < doc/Makefile.am > doc/Makefile.am
    ./buildconf.sh
}

build() {
    export CFLAGS=${sfpm_build_cflags}
    export LDFLAGS=${sfpm_build_ldflags}

    ./configure --prefix=${sfpm_build_prefix} \
        --enable-shared \
        --disable-static \
        --without-docbook

    make -j$(sfpm_CPUS)
}

package() {
    make install DESTDIR=${pkgdir}
}
