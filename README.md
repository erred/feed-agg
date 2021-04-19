# feed-agg

A basic rss / atom feed aggregator,
hosted on [feed-agg.seankhliao.com](https://feed-agg.seankhliao.com)

[![License](https://img.shields.io/github/license/seankhliao/feed-agg.svg?style=flat-square)](LICENSE)
[![Go Reference](https://pkg.go.dev/badge/go.seankhliao.com/feed-agg.svg)](https://pkg.go.dev/go.seankhliao.com/feed-agg)
![Version](https://img.shields.io/github/v/tag/seankhliao/feed-agg?sort=semver&style=flat-square)

## build / install

Go:

```sh
git clone https://github.com/seankhliao/feed-agg
cd feed-agg
go build

# or

go install go.seankhliao.com/feed-agg@latest
```

Docker

```sh
git clone https://github.com/seankhliao/feed-agg
cd feed-agg
docker build -t name/of/image .
```

Arch

```sh
git clone https://github.com/seankhliao/feed-agg
cd feed-agg
makepkg
pacman -U feed-agg.r*.zst
```

## Run

See [conf.yaml](conf.yaml) for example config.
A systemd service is also available (and packaged with Arch).

```txt
Usage of feed-agg:
  -addr string
            address to listen on (default "127.0.0.1:28003")
  -c string
            path to config (default "/etc/feed-agg/conf.yaml")
  -data string
            path to data dir (default "/var/lib/feed-agg")
```
