ARG APP=feed-agg

FROM golang:alpine AS build
ENV CGO_ENABLED=0
WORKDIR /workspace
COPY . .
RUN go build  -trimpath -ldflags="-s -w" -o /usr/local/bin/${APP}

FROM gcr.io/distroless/static
COPY --from=build /usr/local/bin/${APP} /bin/${APP}
ENTRYPOINT ["/bin/${APP}"]
