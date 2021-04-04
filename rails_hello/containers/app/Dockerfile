FROM ruby:2.7.1-alpine3.12

ENV TZ=Asia/Tokyo \
  RAILS_ENV=production \
  RAILS_SERVE_STATIC_FILES=false

RUN mkdir /rails_hello

WORKDIR /rails_hello

RUN apk add --no-cache build-base libxml2-dev libxslt-dev \
  tzdata ca-certificates mysql-dev mysql-client \
  imagemagick imagemagick-dev imagemagick-c++ && \
  mkdir -p /rails_hello/tmp/sockets && \
  mkdir -p /rails_hello/tmp/pids && \
  gem install bundler

ADD Gemfile /rails_hello/Gemfile
ADD Gemfile.lock /rails_hello/Gemfile.lock
# RUN bundle config set deployment 'true' && \
RUN bundle config set without 'test development' && \
  bundle install

ADD . /rails_hello

CMD bundle exec puma -C config/puma.rb
