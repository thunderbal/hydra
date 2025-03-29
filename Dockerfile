FROM golang:latest AS build
ARG VERSION=v2.3.0
RUN useradd -Um build
USER build
WORKDIR /home/build/hydra
RUN git clone --branch ${VERSION} --single-branch --depth 1 https://github.com/ory/hydra.git $HOME/hydra
ENV CGO_ENABLED=0
RUN go mod download && go install -ldflags "-X github.com/ory/hydra/v2/driver/config.Version=${VERSION} -X github.com/ory/hydra/v2/driver/config.Date=`TZ=UTC date -u '+%Y-%m-%dT%H:%M:%SZ'` -X github.com/ory/hydra/v2/driver/config.Commit=`git rev-parse HEAD`" . && strip /go/bin/hydra

FROM scratch
COPY --from=build /go/bin/hydra /bin/hydra
ENTRYPOINT ["/bin/hydra"]
CMD ["help"]
EXPOSE 4444/tcp 4445/tcp
USER 1000:1000
WORKDIR /home/hydra
