FROM ubuntu:focal

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Copenhagen

RUN apt-get update && apt-get upgrade -yq
RUN apt-get install inotify-tools composer php-cli -yq

COPY entrypoint /usr/local/bin/entrypoint

ENTRYPOINT ["entrypoint"]
