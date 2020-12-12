FROM golang:1.15-alpine3.12 as build
WORKDIR /go/src/rtlamr-collect
RUN go mod init && go get github.com/bemasher/rtlamr@v0.9.2
COPY . .
RUN go install -v ./...

FROM alpine:3.12
ENV RTLAMR_FORMAT=json
COPY --from=build /go/bin/rtlamr /go/bin/rtlamr-collect /
CMD ["/bin/sh", "-c", "/rtlamr | /rtlamr-collect"]
