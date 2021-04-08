FROM ruby:2.7.1-alpine3.12

ENV TZ=Asia/Tokyo \
  RAILS_ENV=production \
  RAILS_SERVE_STATIC_FILES=false

ARG RAILS_MASTER_KEY
ENV RAILS_MASTER_KEY ${RAILS_MASTER_KEY}

RUN apk add --no-cache build-base libxml2-dev libxslt-dev \
  tzdata ca-certificates mysql-dev mysql-client \
  imagemagick imagemagick-dev imagemagick-c++ && \
  gem install bundler

WORKDIR /rails_hello

RUN mkdir -p tmp/sockets

ADD Gemfile /rails_hello/Gemfile
ADD Gemfile.lock /rails_hello/Gemfile.lock
# RUN bundle config set deployment 'true' && \
RUN bundle config set without 'test development' && \
  bundle install

RUN bundle exec rails assets:precompile

ADD . /rails_hello

CMD bundle exec puma -C config/puma.rb
