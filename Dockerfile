FROM alpine
RUN apk update && apk add mosquitto-clients
COPY mqtt_sensors_net/ /srv/

