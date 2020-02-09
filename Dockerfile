FROM ruby:2.6.5-alpine

RUN gem install bundler -v '2.1.4'

RUN apk update && apk add build-base nodejs postgresql-dev bash chromium

# Install Yarn
ENV PATH=/root/.yarn/bin:$PATH

RUN apk add --virtual build-yarn curl && \
    touch ~/.bashrc && \
    curl -o- -L https://yarnpkg.com/install.sh | sh && \
    apk del build-yarn

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock package.json ./
RUN bundle install --binstubs 

COPY . . 

LABEL maintainer="Alex Saunders <acsauk@gmail.com>"
