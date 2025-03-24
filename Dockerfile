# -------- Build Stage --------
FROM golang:1.24.1-bookworm AS builder

ARG VERSION=dev
ENV CGO_ENABLED=0 \
    GOOS=linux

WORKDIR /app
COPY . .

RUN go mod download

RUN go build -tags "netgo osusergo" \
  -ldflags="-s -w -X 'main.VERSION=${VERSION}' -extldflags=-static" \
  -o supervisord

# -------- Final Stage --------
FROM scratch AS final

COPY --from=builder --chmod=755 /app/supervisord /usr/local/bin/supervisord
ENTRYPOINT ["supervisord"]
