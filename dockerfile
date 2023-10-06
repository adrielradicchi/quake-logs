FROM ruby:alpine

RUN apk --update add build-base tzdata libxslt-dev libxml2-dev imagemagick

WORKDIR /app

COPY Gemfile Gemfile.lock ./

# Prevent bundler warnings; ensure that the bundler version executed is >= that which created Gemfile.lock
RUN gem install bundler

# Finish establishing our Ruby enviornment depending on the RAILS_ENV
RUN bundle install

# Copy the main application.
COPY . ./

ENV HOME=/app

RUN pwd

# CMD ["ruby", "bin/quake_logs.rb"]
ENTRYPOINT ["sh", "bin/start.sh"]