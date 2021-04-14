package main

import (
	"context"
	_ "embed"
	"fmt"
	"net/http"
	"strings"
	"text/template"
	"time"
)

var (
	//go:embed feed.tpl
	feedTemplateRaw string

	//go:embed index.tpl
	indexTemplateRaw string

	feedTemplate  = template.Must(template.New("feed").Parse(feedTemplateRaw))
	indexTemplate = template.Must(template.New("index").Parse(indexTemplateRaw))
)

type App struct {
	feeds map[string]struct{}
	store Storer
}

func NewApp(c Config, dataDir string) (*App, error) {
	store, err := NewSQLite(context.Background(), dataDir, c.Feeds)
	if err != nil {
		return nil, err
	}

	a := &App{
		feeds: make(map[string]struct{}),
		store: store,
	}

	type UP struct {
		r time.Duration
		u string
	}
	// url: refresh
	upstreams := make(map[string]UP)

	for feedID, feedConf := range c.Feeds {
		a.feeds[feedID] = struct{}{}
		for id, u := range feedConf.URLs {
			up, ok := upstreams[id]
			if ok {
				if up.r.Seconds() < feedConf.refresh.Seconds() {
					continue
				}
			}
			upstreams[id] = UP{feedConf.refresh, u}
		}
	}

	for id, up := range upstreams {
		RunFeedUpdater(id, up.u, up.r, a.store)
	}

	return a, nil
}

func (a *App) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	ctx := r.Context()

	if r.URL.Path == "/" {
		indexTemplate.Execute(w, a.feeds)
		return
	}

	segs := strings.Split(r.URL.Path[1:], ".")
	if len(segs) != 2 {
		w.WriteHeader(http.StatusBadRequest)
		return
	}
	feedID, format := segs[0], segs[1]

	_, ok := a.feeds[feedID]
	if !ok {
		w.WriteHeader(http.StatusNotFound)
		return
	}

	feed, err := a.store.GetFeed(ctx, feedID)
	if err != nil {
		fmt.Println(err)
		w.WriteHeader(http.StatusInternalServerError)
		return
	}

	switch format {
	case "rss":
		feed.WriteAtom(w)
	case "atom":
		feed.WriteAtom(w)
	case "json":
		feed.WriteJSON(w)
	case "html":
		feedTemplate.Execute(w, feed)
	default:
		w.WriteHeader(http.StatusBadRequest)
	}
}
