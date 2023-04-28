# Ruby 2.4.1 Docker Image

This Docker image is based on Ubuntu 18.04 and includes Ruby 2.4.1 along with the following packages:

- build-essential
- curl
- git
- imagemagick
- java-common
- ghostscript
- libcurl4-openssl-dev
- libffi-dev
- libgeos-dev
- libmagickwand-dev
- libmysqlclient-dev
- libpq-dev
- libreadline-dev
- libssl-dev
- libmagic-dev
- nano
- nodejs
- nginx
- pkg-config
- postgresql-client
- python-dev
- swig
- tzdata
- unzip
- vim
- wget
- zlib1g-dev
- aws cli

## Notes

- The `aws cli` package is included in this image, but you will need to configure it with your own AWS credentials before you can use it.
- The `nginx` package is included in this image, but you will need to configure it with your own nginx configuration files before you can use it.
- Timezone has been set to IST.