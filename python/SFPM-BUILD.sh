name=python
version=3.7.2
release=1
license=(PSF)
depends=(
    "expat"
    "zlib"
)
sources=(
    https://www.python.org/ftp/python/${version}/Python-${version}.tar.xz
)

prepare() {
    export CFLAGS=${sfpm_build_cflags}
    export LDFLAGS=${sfpm_build_ldflags}

    cd "${srcdir}/Python-${version}"
    #pushd Modules
    #    sed -e 's|\#zlib|zlib|' Setup.dist > Setup.dist.tmp
    #    mv Setup.dist.tmp Setup.dist
    #    grep zlib Setup.dist
    #popd
}

build() {
    ./configure --prefix=${sfpm_build_prefix} \
        --enable-ipv6 \
        --enable-loadable-sqlite-extensions \
        --enable-profiling \
        --enable-shared \
        --with-dbmliborder=gdbm:ndbm \
        --with-pymalloc \
        --with-system-expat

    make -j$(sfpm_CPUS)
}

package() {
    make install DESTDIR=${pkgdir}

    ln -sf easy_install-3.7          "${pkgdir}/${sfpm_build_prefix}"/bin/easy_install
    ln -sf python3                   "${pkgdir}/${sfpm_build_prefix}"/bin/python
    ln -sf python3-config            "${pkgdir}/${sfpm_build_prefix}"/bin/python-config
    ln -sf idle3                     "${pkgdir}/${sfpm_build_prefix}"/bin/idle
    ln -sf pydoc3                    "${pkgdir}/${sfpm_build_prefix}"/bin/pydoc
    ln -sf pip3                      "${pkgdir}/${sfpm_build_prefix}"/bin/pip
    ln -sf python${python_basever}.1 "${pkgdir}/${sfpm_build_prefix}"/share/man/man1/python.1
}
