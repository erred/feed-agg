pkgname=feed-agg
pkgver=r10.342dbe1
pkgrel=1
pkgdesc='rss / atom feed aggregator'
arch=('x86_64')
url='https://github.com/seankhliao/feed-agg'
license=('MIT')
makedepends=('go')
backup=("etc/${pkgname}/conf.yaml")

pkgver(){
    # count commits
    printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
}

build(){
    cd "${startdir}"
    export CGO_ENABLED=0
    go build -trimpath -ldflags="-s -w" -modcacherw -o "${pkgname}" .
}

package() {
    cd "${startdir}"
    install -Dm755 "${pkgname}" "${pkgdir}/usr/bin/${pkgname}"
    install -Dm644 LICENSE "${pkgdir}/usr/share/${pkgname}/LICENSE"
    install -Dm644 conf.yaml "${pkgdir}/etc/${pkgname}/conf.yaml"
    install -Dm644 "${pkgname}.service" "${pkgdir}/usr/lib/systemd/system/${pkgname}.service"
}
