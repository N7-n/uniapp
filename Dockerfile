FROM ruby:2.6.6

ENV APP_ROOT /app

WORKDIR $APP_ROOT

RUN apt-get update -qq && \
    apt-get install -y default-mysql-client tzdata cron less

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs

RUN npm install npm@latest -g
RUN npm install --global yarn

COPY Gemfile /$APP_ROOT/Gemfile
COPY Gemfile.lock /$APP_ROOT/Gemfile.lock

RUN gem install bundler:2.3.7
RUN bundle install

ADD . $APP_ROOT

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]