ARG ALPINE_VERSION=latest
ARG GOLANG_VERSION=1.12.5

FROM golang:${GOLANG_VERSION}-alpine as builder
MAINTAINER Marco Pantaleoni <marco.pantaleoni@gmail.com>

ENV LANG=C.UTF-8

RUN apk -U add --no-cache \
    ca-certificates wget curl git \
  && rm -rf /var/cache/apk/*
WORKDIR /go/src/github.com/panta/gohttpserver
ADD . /go/src/github.com/panta/gohttpserver/
RUN go get -v
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags '-X main.VERSION=docker' -o gohttpserver


FROM alpine:${ALPINE_VERSION}
MAINTAINER Marco Pantaleoni <marco.pantaleoni@gmail.com>
# FROM debian:stretch
# RUN apt-get update && apt-get install -y ca-certificates
ENV LANG=C.UTF-8
RUN apk -U add ca-certificates \
  && rm -rf /var/cache/apk/*
WORKDIR /app
RUN mkdir -p /app/public
VOLUME /app/public
ADD assets ./assets
COPY --from=builder /go/src/github.com/panta/gohttpserver/gohttpserver .
EXPOSE 8000
ENTRYPOINT [ "/app/gohttpserver", "--root=/app/public" ]
CMD []
