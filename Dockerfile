FROM ruby:3.2.2
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN bundle install
COPY . .
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3000"]
