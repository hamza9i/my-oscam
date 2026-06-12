FROM alpine:latest
RUN apk add --no-cache oscam
RUN mkdir -p /config && echo -e "[webif]\nhttpport = 8888\nhttpallowed = 127.0.0.1,0.0.0.0-255.255.255.255\n\n[cccam]\nport = 12000\nversion = 2.3.2\nreshare = 1" > /config/oscam.conf
RUN echo -e "[account]\nuser = mybox\npwd = 12345\ngroup = 1" > /config/oscam.user
CMD ["oscam", "-c", "/config"]
