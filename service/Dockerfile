FROM ruby:alpine
RUN apk update && apk add build-base

ENV APP_HOME /service
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

COPY Gemfile $APP_HOME
RUN bundle install

COPY service.rb $APP_HOME/service.rb
CMD ruby $APP_HOME/service.rb
