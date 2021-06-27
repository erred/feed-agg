FROM golang:alpine AS build
ARG CGO_ENABLED=0
ARG GOPROXY=https://proxy.golang.org,direct
ARG GOMODCACHE=/go/pkg/mod
ARG GOCACHE=/root/.cache/go-build
WORKDIR /workspace
COPY . .
RUN go build -trimpath -ldflags='-s -w' -o /bin/feed-agg

FROM gcr.io/distroless/static
COPY conf.yaml /etc/feed-agg/conf.yaml
COPY --from=build /bin/feed-agg /bin/feed-agg
ENTRYPOINT ["/bin/feed-agg"]
