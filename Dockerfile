ARG RUBY_VERSION
FROM ruby:$RUBY_VERSION-slim

VOLUME /workspace
WORKDIR /workspace

ARG GEM_HOST
ARG PKG_VERSION

RUN apt-get update && apt-get install -y curl gnupg2 && \
    curl https://cli-assets.heroku.com/install-ubuntu.sh | sh && \
    curl -O http://$GEM_HOST/downloads/heroku-app-info-$PKG_VERSION.gem && \
    gem install heroku-app-info-$PKG_VERSION.gem && \
    rm heroku-app-info-$PKG_VERSION.gem

ENTRYPOINT ["heroku-app-info"]
