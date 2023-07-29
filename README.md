# jeanlrnt/php
jeanlrnt/php is a Docker image based on Debian with PHP 8 and Apache 2.4. It is intended to be used as a base image 
for PHP applications. It is available on Docker Hub as jeanlrnt/php.
This image is based on the official PHP image (phpX.X-fpm), but with some additional extensions installed and some configuration

Several PHP extensions are installed by default:
- intl 
- gd
- http
- mysqli
- pdo
- pdo_pgsql 
- pdo_mysql 
- pgsql
- zip
- composer@latest

This table shows the PHP versions available for each tag:

| Tag    | PHP Version | Debian Version |
|--------|-------------| -------------- |
| latest | 8.2         | Buster |
| 8.2    | 8.2         | Buster |
| 8.1    | 8.1         | Buster |
| 8      | 8.2         | Buster |

## Install and Setup

Install Docker on your machine.
Then, either run the pre-built image we’ve provided on Docker Hub, or build the image yourself from the source code.

### Run the Pre-built Image

Pull the image from Docker Hub:
```bash
docker pull jeanlrnt/php:latest
```

Run the image:
```bash
docker run -d -p 80:80 jeanlrnt/php:latest
```

### Build the Image Yourself

Clone this repository:
```bash
git clone
```

Build the image:
```bash
docker build -t jeanlrnt/php:latest .
```

Run the image:
```bash
docker run -d -p 80:80 jeanlrnt/php:latest
```

# Usage
## Running a PHP Script
To run a PHP script, you can use the built-in PHP server:
```bash
docker run -d -p 80:80 -v /path/to/php/script:/var/www/html jeanlrnt/php:latest
```

## Running a PHP Application
To run a PHP application, you can use the built-in PHP server:
```bash
docker run -d -p 80:80 -v /path/to/php/application:/var/www/html jeanlrnt/php:latest
```

# Working Together
Include information such as:

GitHub Issues: For any bug reports or feature requests, please post to GitHub Issues.
Pull Requests: All pull requests are welcome, preferably on a separate branch. Please rebase your branch to the current master.

## Maintainers
Maintained by [jeanlrnt](github.com/jeanlrnt)


# License Information
This project is licensed under the terms of the Apache 2.0 open source license. Please refer to LICENSE for the full terms.

As with all Docker images, these may contain other software which may be under other licenses (such as Bash, etc. from the base distribution, along with any direct or indirect dependencies of the primary software being contained). It is the image user’s responsibility to ensure that any use of this image complies with any relevant licenses for all software contained within.
