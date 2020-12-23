FROM debian
RUN apt update
RUN apt install -y --force-yes cron procps nano mosquitto-clients
#VOLUME /home/kvm/docker/tools /srv
ENTRYPOINT /srv/telemetry.sh
ENV name deb10dcnode
