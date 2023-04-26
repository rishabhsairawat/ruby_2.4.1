# Ruby 2.4.1 Docker Image

This Docker image is based on Ubuntu 18.04 and includes Ruby 2.4.1 along with the following packages:

- build-essential
- libssl-dev
- libreadline-dev
- zlib1g-dev
- curl
- libpq-dev
- libmysqlclient-dev
- nano
- nodejs
- vim
- postgresql-client
- unzip
- nginx
- tzdata
- libgeos-dev
- git
- aws cli

## Notes

- The `aws cli` package is included in this image, but you will need to configure it with your own AWS credentials before you can use it.
- The `nginx` package is included in this image, but you will need to configure it with your own nginx configuration files before you can use it.
- Timezone has been set to IST.