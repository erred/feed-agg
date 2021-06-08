FROM golang:alpine AS build
ENV CGO_ENABLED=0
WORKDIR /workspace
COPY . .
RUN go build -trimpath -ldflags='-s -w' -o /bin/feed-agg

FROM gcr.io/distroless/static
COPY conf.yaml /etc/feed-agg/conf.yaml
COPY --from=build /bin/feed-agg /bin/feed-agg
ENTRYPOINT ["/bin/feed-agg"]
