FROM golang:1.16-alpine as builder
WORKDIR /go/src
COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -v -o snsall

FROM gcr.io/cloud-builders/gcloud:latest
WORKDIR /go/src
COPY . .

COPY --from=builder /go/src/snsall /snsall
ENTRYPOINT ["/snsall"]
