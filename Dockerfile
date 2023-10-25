FROM node:alpine3.18 as base

WORKDIR /app

COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]


#FROM base as prod
