FROM ubuntu:focal

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Copenhagen

RUN apt-get update && apt-get upgrade -yq
RUN apt-get install inotify-tools -yq

COPY entrypoint /usr/local/bin/entrypoint

WORKDIR ${DIR}

ENTRYPOINT ["entrypoint"]
