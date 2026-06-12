FROM docker.io/linuxserver/oscam:latest
RUN sed -i 's/httpallow.*/httpallow = 0.0.0.0-255.255.255.255/g' /defaults/oscam.conf || true
EXPOSE 8888
