FROM ruby:3.0

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY src/ ./src
COPY ./var/rinha/source.rinha.json /var/rinha/source.rinha.json

CMD ["ruby", "src/exec.rb"]