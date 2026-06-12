FROM alpine:latest
RUN apk add --no-cache oscam
RUN mkdir -p /config && echo -e "[webif]\nhttpport = 8888\nhttpallow = 0.0.0.0-255.255.255.255" > /config/oscam.conf
CMD ["oscam", "-c", "/config", "-f"]
