package main

import (
	"context"
	"flag"
	"os"
	"os/signal"
	"syscall"

	"go.seankhliao.com/w/v16/webserver"
	"k8s.io/klog/klogr"
)

func main() {
	var addr, data, configPath string
	var wo webserver.Options
	wo.InitFlags(flag.CommandLine)
	flag.StringVar(&addr, "addr", "127.0.0.1:28003", "address to listen on")
	flag.StringVar(&data, "data", "/var/lib/feed-agg", "path to data dir")
	flag.StringVar(&configPath, "c", "/etc/feed-agg/conf.yaml", "path to config")
	flag.Parse()

	ctx := context.Background()
	ctx, _ = signal.NotifyContext(ctx, syscall.SIGINT, syscall.SIGTERM)

	l := klogr.New()

	config, err := NewConfig(configPath)
	if err != nil {
		l.Error(err, "config")
		os.Exit(1)
	}

	a, err := NewApp(config, data)
	if err != nil {
		l.Error(err, "app")
		os.Exit(1)
	}

	a.l = l
	wo.Logger = l
	wo.Handler = a

	webserver.New(ctx, &wo).Run(ctx)
}
