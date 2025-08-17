FROM ruby:3.2

WORKDIR /srv/jekyll

# Install Node.js and Jekyll dependencies
RUN apt-get update && \
    apt-get install -y nodejs npm build-essential && \
    gem install bundler && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy Gemfile and install gems first (for better Docker layer caching)
COPY Gemfile ./
RUN bundle install

# Copy the rest of the project
COPY . .

# Build Jekyll site
RUN bundle exec jekyll build

EXPOSE 4000

CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0", "--livereload", "--force_polling"]
