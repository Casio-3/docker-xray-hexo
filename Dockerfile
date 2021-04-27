FROM golang
LABEL maintainer="Casio3 <0298lll@gmail.com>"

RUN mkdir -p /var/webhook \
    && touch /var/webhook/hooks.json \
    && go get github.com/adnanh/webhook

WORKDIR /var/webhook

ENTRYPOINT /go/bin/webhook -hooks /var/webhook/hooks.json -verbose