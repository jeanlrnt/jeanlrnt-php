FROM php:8.1-fpm
WORKDIR /var/www/html
STOPSIGNAL SIGQUIT
EXPOSE 9000
ARG TIMEZONE
LABEL maintainer="Jean LAURENT <jeanz.laurent@gmail.com>"
RUN curl -1sLf 'https://dl.cloudsmith.io/public/symfony/stable/setup.deb.sh' | bash
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions
RUN apt-get update && apt-get install -y openssl git libzip-dev unzip wget libicu-dev libfreetype6-dev libjpeg62-turbo-dev libpng-dev bash-completion symfony-cli libpq-dev npm
RUN install-php-extensions @composer
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp
RUN touch ${PHP_INI_DIR}/conf.d/max.ini && echo "max_execution_time = 120;" >> ${PHP_INI_DIR}/conf.d/max.ini
RUN touch ${PHP_INI_DIR}/conf.d/uploads.ini && echo "upload_max_filesize = 50M;" >> ${PHP_INI_DIR}/conf.d/uploads.ini
RUN ln -snf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && echo ${TIMEZONE} > /etc/timezone
RUN printf '[PHP]\ndate.timezone = "%s"\n', ${TIMEZONE} > ${PHP_INI_DIR}/conf.d/php.ini
RUN install-php-extensions http zip intl gd mysqli pdo_pgsql pdo pdo_mysql pgsql
RUN docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN pecl install apcu && docker-php-ext-enable apcu
RUN docker-php-ext-configure opcache --enable-opcache && docker-php-ext-install opcache
RUN { echo 'opcache.memory_consumption=128'; echo 'opcache.interned_strings_buffer=8'; echo 'opcache.max_accelerated_files=4000'; echo 'opcache.revalidate_freq=0'; echo 'opcache.fast_shutdown=1'; echo 'opcache.enable_cli=1'; } > ${PHP_INI_DIR}/conf.d/opcache-recommended.ini
RUN echo "realpath_cache_size = 4096k;" > ${PHP_INI_DIR}/conf.d/php.ini
RUN pecl install xdebug
RUN docker-php-ext-enable xdebug
RUN echo "error_reporting = E_ALL" >> ${PHP_INI_DIR}/conf.d/docker-php-ext-xdebug.ini
RUN echo "display_startup_errors = On" >> ${PHP_INI_DIR}/conf.d/docker-php-ext-xdebug.ini
RUN echo "display_errors = On" >> ${PHP_INI_DIR}/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.mode = debug" >> ${PHP_INI_DIR}/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.discover_client_host=true" >> ${PHP_INI_DIR}/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.idekey=\"PHPSTORM\"" >> ${PHP_INI_DIR}/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.client_port=9001" >> ${PHP_INI_DIR}/conf.d/docker-php-ext-xdebug.ini
RUN touch ${PHP_INI_DIR}/conf.d/max.ini && echo "max_execution_time = 120;" >> ${PHP_INI_DIR}/conf.d/max.ini
ENV COMPOSER_ALLOW_SUPERUSER=1
