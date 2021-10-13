FROM golang:1.13
ADD . /usr/src/whereabouts
RUN mkdir -p $GOPATH/src/github.com/georgenicoll/whereabouts
WORKDIR $GOPATH/src/github.com/georgenicoll/whereabouts
COPY . .
RUN ./hack/build-go.sh

FROM alpine:latest
LABEL org.opencontainers.image.source https://github.com/georgenicoll/whereabouts
COPY --from=0 /go/src/github.com/georgenicoll/whereabouts/bin/whereabouts .
COPY --from=0 /go/src/github.com/georgenicoll/whereabouts/bin/ip-reconciler .
COPY script/install-cni.sh .
CMD ["/install-cni.sh"]
