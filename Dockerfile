FROM golang:alpine as builder

# change workdir, build and install
WORKDIR /go/src/github.com/FantaBlade/frontd

# Copy the local package files to the container's workspace.
COPY . /go/src/github.com/FantaBlade/frontd

RUN go get . \
    && go install

FROM alpine:latest

# Give /etc/hosts file priority
RUN  echo "hosts: files dns" > /etc/nsswitch.conf

WORKDIR /go/bin

COPY --from=builder /go/bin .

# Run the frontd command by default when the container starts.
ENTRYPOINT ["/go/bin/frontd"]

EXPOSE 4043
