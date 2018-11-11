FROM golang:alpine as build

RUN apk --no-cache add tzdata git make build-base
RUN go get github.com/golang/dep/cmd/dep
COPY Gopkg.lock Gopkg.toml /go/src/github.com/nshttpd/mikrotik-exporter/
WORKDIR /go/src/github.com/nshttpd/mikrotik-exporter

RUN dep ensure -vendor-only

COPY . /go/src/github.com/nshttpd/mikrotik-exporter/

RUN make build

FROM alpine:latest as production
RUN apk add --no-cache tzdata
COPY --from=build /go/src/github.com/nshttpd/mikrotik-exporter/mikrotik-exporter /app/

EXPOSE 9436

COPY scripts/start.sh /app/

RUN chmod 755 /app/*

ENTRYPOINT ["/app/start.sh"]
