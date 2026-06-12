FROM alpine:latest
RUN apk add --no-cache oscam
CMD ["oscam", "-b", "-r", "2", "-c", "/config"]
