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
    libssl-dev \
    libreadline-dev \
    zlib1g-dev \
    curl \
    libpq-dev \
    libmysqlclient-dev \
    nano \
    nodejs \
    vim \
    postgresql-client \
    unzip \
    nginx \
    tzdata \
    libgeos-dev \
    git

# Download and extract Ruby 2.4.1
RUN curl -L https://cache.ruby-lang.org/pub/ruby/2.4/ruby-2.4.1.tar.gz | tar xz
WORKDIR ruby-2.4.1

# Configure, build, and install Ruby
RUN ./configure && make && make install

# Download AWS CLI
WORKDIR /tmp/
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"  && \
    echo "unzipping aws cli" && \
    unzip awscliv2.zip > aws_cli.log && \
    echo "installing aws cli" && \
    bash aws/install > aws_cli.log && \
    rm -rf *

# Clean up
WORKDIR /
RUN rm -rf ruby-2.4.1
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Don't create ".bundle" in all our apps
ENV GEM_HOME /usr/local/bundle
ENV BUNDLE_SILENCE_ROOT_WARNING=1 \
	BUNDLE_APP_CONFIG="$GEM_HOME"
ENV BUNDLE_BIN /usr/local/bundle/bin   
ENV PATH $GEM_HOME/bin:$PATH

# Adjust permissions of a few directories for running "gem install" as an arbitrary user
RUN mkdir -p "$GEM_HOME" && chmod 1777 "$GEM_HOME"

CMD ["/bin/bash"]