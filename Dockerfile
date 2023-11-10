FROM node:alpine3.18 as base_ui

WORKDIR /app

COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

#FROM base as prod

FROM mcr.microsoft.com/playwright:v1.39.0-jammy as test_ui
WORKDIR /app

COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh
RUN sed -i.bak "1 s/.*/#!\/bin\/bash/" /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
