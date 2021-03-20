FROM ruby:2.7.1-alpine3.12

RUN apk add --update-cache --no-cache tzdata libxml2-dev curl-dev \
  make gcc libc-dev g++ linux-headers \
  mysql-dev mysql-client nodejs git yarn && \
  rm -rf /var/lib/apt/lists/*

RUN mkdir /rails_hello

WORKDIR /rails_hello

ADD Gemfile /rails_hello/Gemfile
ADD Gemfile.lock /rails_hello/Gemfile.lock

RUN gem install bundle && \
  bundle install

RUN rm -rf /usr/local/bundle/cache/* /workdir/vendor/bundle/cache/*

ADD . /rails_hello
