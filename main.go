package main

import (
	"flag"
	"log"
	"net/http"
)

func main() {
	var configPath string
	flag.StringVar(&configPath, "c", "/etc/feed-agg.yaml", "path to config")
	flag.Parse()

	config, err := NewConfig(configPath)
	if err != nil {
		log.Fatal(err)
	}

	app, err := NewApp(config)
	if err != nil {
		log.Fatal(err)
	}

	mux := http.NewServeMux()
	mux.Handle("/", app)
	log.Fatal(http.ListenAndServe("127.0.0.1:28003", mux))
}
