FROM golang:1.9-alpine as build
RUN apk add --no-cache ca-certificates tzdata git

COPY . /go/src/standup-slackbot
WORKDIR /go/src/standup-slackbot
RUN go get -v
RUN CGO_ENABLED=0 GOOS=linux go build -v -o standup-slackbot .

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=build /go/src/standup-slackbot/standup-slackbot .
CMD ["./standup-slackbot"]
