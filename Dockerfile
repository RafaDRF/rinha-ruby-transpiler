FROM ruby:3.0

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY exec.rb ./
COPY interpreter.rb ./
COPY ./var/ast.json /var/ast.json

CMD ["ruby", "exec.rb"]