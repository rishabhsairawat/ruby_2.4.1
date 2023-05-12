FROM ubuntu:18.04

# Setting timezone to IST
ENV TZ=Asia/Kolkata
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# skip installing gem documentation
RUN set -eux; \
	mkdir -p /usr/local/etc; \
	{ \
		echo 'install: --no-document'; \
		echo 'update: --no-document'; \
	} >> /usr/local/etc/gemrc

# Install necessary packages
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
    imagemagick \
    java-common \
    ghostscript \
    libcurl4-openssl-dev \
    libffi-dev \
    libgeos-dev \
    libmagickwand-dev \
    libmysqlclient-dev \
    libpq-dev \
    libreadline-dev \
    libssl-dev \
    libmagic-dev \
    nano \
    nodejs \
    nginx \
    pkg-config \
    postgresql-client \
    python-dev \
    supervisor \
    swig \
    tzdata \
    unzip \
    vim \
    wget \
    zlib1g-dev

# Download and extract Ruby 2.4.1
RUN curl -L https://cache.ruby-lang.org/pub/ruby/2.4/ruby-2.4.1.tar.gz | tar xz
WORKDIR ruby-2.4.1

# Configure, build, and install Ruby
RUN ./configure && make && make install

# Download AWS CLI
WORKDIR /tmp/
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"  && \
    unzip awscliv2.zip > aws_cli.log && \
    bash aws/install > aws_cli.log && \
    rm -rf *

# Clean up
WORKDIR /
RUN rm -rf ruby-2.4.1
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Bundler related configs
ENV BUNDLER_VERSION=1.17.3
RUN gem install bundler --version "$BUNDLER_VERSION"
ENV GEM_HOME=/usr/local/bundle
ENV BUNDLE_PATH=/usr/local/bundle BUNDLE_BIN=/usr/local/bundle/bin \
    BUNDLE_SILENCE_ROOT_WARNING=1 BUNDLE_APP_CONFIG=/usr/local/bundle
ENV PATH=/usr/local/bundle/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Adjust permissions of a few directories for running "gem install" as an arbitrary user
RUN mkdir -p "$GEM_HOME" "$BUNDLE_BIN" && chmod 777 "$GEM_HOME" "$BUNDLE_BIN"

CMD ["/bin/bash"]
