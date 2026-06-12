FROM alpine:latest
RUN apk add --no-cache oscam
RUN mkdir -p /config && echo -e "[webif]\nhttpport = 8888\nhttpallowed = 127.0.0.1,100.64.0.0-100.127.255.255,0.0.0.0-255.255.255.255" > /config/oscam.conf
CMD ["oscam", "-b", "-c", "/config"]
