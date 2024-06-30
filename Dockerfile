ARG RUBY_VERSION
FROM ruby:$RUBY_VERSION-slim

VOLUME /workspace
WORKDIR /workspace

ARG PKG_VERSION
ARG GEM_HOST

RUN apt-get update && apt-get install -y curl gnupg2 && \
    curl https://cli-assets.heroku.com/install-ubuntu.sh | sh && \
    curl -O http://host.docker.internal/heroku-app-info-$PKG_VERSION.gem && \
    gem install heroku-app-info-$PKG_VERSION.gem && \
    rm heroku-app-info-$PKG_VERSION.gem

ENTRYPOINT ["heroku-app-info"]
