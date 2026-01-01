# syntax=docker/dockerfile:1

# Use the Ruby version from .ruby-version
FROM ruby:3.4.4-slim AS base

# Install system dependencies
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    git \
    libxml2-dev \
    libxslt1-dev \
    curl \
    nodejs \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Configure Bundler
ENV BUNDLE_PATH=/usr/local/bundle
ENV BUNDLE_BIN=/usr/local/bundle/bin
ENV PATH="${BUNDLE_BIN}:${PATH}"

# Install bundler and gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy project files
COPY . .

# Expose Middleman and LiveReload ports
EXPOSE 4567 35729

# Start Middleman server
CMD ["bundle", "exec", "middleman", "server", "--bind-address", "0.0.0.0"]
