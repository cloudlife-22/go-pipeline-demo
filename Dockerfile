FROM golang:1.20 AS build
ARG VERSION=dev
WORKDIR /go/src/app
COPY main.go .
RUN go build -o main -ldflags=-X=main.version=${VERSION} main.go

FROM gcr.io/distroless/static-debian11
COPY --from=build /go/src/app/main /go/bin/main
ENV PATH="/go/bin:${PATH}"
CMD ["main"]