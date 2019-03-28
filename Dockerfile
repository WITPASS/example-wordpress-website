FROM witline/wordpress-5.1.1-php7.3-apache

# Copy themes and plugins from the repository to a fixed place inside the container image.
# The themes and plugins will be processed by the our wordpress-custom-entrypoint.sh script,
#   when the container starts.
COPY themes /usr/src/themes/
COPY plugins /usr/src/plugins/ 

