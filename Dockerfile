FROM golang:1.22 AS builder

WORKDIR /app

COPY go.mod ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 go build -o /app/cscs-example .

FROM gcr.io/distroless/static-debian12:nonroot

COPY --from=builder /app/cscs-example /cscs-example

ENTRYPOINT ["/cscs-example"]
