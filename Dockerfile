FROM ruby:2.5.7
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /bulltein-board
WORKDIR /bulltein-board
COPY Gemfile /bulltein-board/Gemfile
COPY Gemfile.lock /bulltein-board/Gemfile.lock
RUN bundle install
COPY . /bulltein-board