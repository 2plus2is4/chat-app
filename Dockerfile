FROM ruby:2.6.0

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /chat
WORKDIR /chat

COPY Gemfile /chat/Gemfile
COPY Gemfile.lock /chat/Gemfile.lock

RUN bundle install

COPY . /chat


CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3000"]