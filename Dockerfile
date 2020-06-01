FROM ubuntu:focal

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Copenhagen

RUN apt-get update && apt-get upgrade -yq
RUN apt-get install inotify-tools composer php-cli -yq
RUN mkdir -p /var/www/html
RUN { \
        echo "#!/usr/bin/env bash"; \
        echo "set -e"; \
        echo "composer install --no-dev"; \
        echo "php artisan migrate --force"; \
        echo "php artisan db:seed --force"; \
        echo "while inotifywait -e close_write composer.lock;"; \
        echo "do"; \
        echo "composer install --no-dev"; \
        echo "php artisan migrate --force"; \
        echo "php artisan db:seed --force"; \
        echo "done"; \
        echo "exec apache2ctl -DFOREGROUND \"\$@\""; \
    } > /usr/local/bin/entrypoint \
    && chmod a+rx /usr/local/bin/entrypoint \
    && apt-get -yq clean autoclean && apt-get -yq autoremove \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html

ENTRYPOINT ["entrypoint"]
