Installing imagick, exif & bcmath extensions on Azure WordPress On Linux Web App
===

* As mentioned in this below document, some features such as Kudu site extensions are not available yet.

**https://docs.microsoft.com/en-us/azure/app-service/containers/app-service-linux-intro#limitations**

* We can enable the PHP extension for Windows Web Apps configure via ini settings but for the Linux Web Apps the modifications outside of the /home directory will not be persistent after a system reboot.

* There is a way we can do this easily by building a custom image from Azure Open Sourced docker file and add the required extensions with docker-php-ext-install.

* Custom docker containers provide you more control on the docker image itself and can modify it with new modules or extensions when your app needs these changes. 

**Install Imagemagick Extension:**

In order to install the ImageMagick extension first we need to install the ImageMagick lib modules

```
apk update
RUN apk add --update --no-cache autoconf g++ imagemagick-dev libtool make pcre-dev
RUN apk add --update --no-cache imagemagick-libs
```
**Install exif Extension:**

We can enable this extension with 'docker-php-ext-install' since it will install all the dependencies and correct the configure options automatically. 
```
RUN docker-php-ext-install exif
```
**Install bcmath Extension:**
```
RUN docker-php-ext-install bcmath
```

**Enabling the installed Extensions:**

* SSH into the container
* Go to `/home/site` directory
* Create a directory called `ext` (i.e. mkdir ext)
* Copy all the installed extenstensions to `ext` folder
* All the installed extensions should be in `/usr/local/lib/php/extensions/no-debug-non-zts-20........`
* For example `cp /usr/local/lib/php/extensions/no-debug-non-zts-20173818/imagick.so /home/site/ext/imagick.so`
* Create a directory called `ini` (i.e. mkdir ini)
* Change working directory to `ini`
* Create a `extensions.ini` file and add the configuration `extension=/home/site/ext/imagick.so` to it

**Add Application Settings to load the Extensions:**

* Go to App Service
* Select configration of the App
* Under Application settings section, press the `+ Add new setting`
* Add an App Setting with the Name `PHP_INI_SCAN_DIR`and set the vlue to `/usr/local/etc/php/conf.d:/home/site/ini`

**Restart the Web App and check the phpinfo page. It should return a imagick module section**

**We can enable all the below extensions in the same way**

```
RUN docker-php-ext-install soap
RUN docker-php-ext-install ftp
RUN docker-php-ext-install xsl
RUN docker-php-ext-install bcmath
RUN docker-php-ext-install calendar
RUN docker-php-ext-install ctype
RUN docker-php-ext-install dba
RUN docker-php-ext-install dom
RUN docker-php-ext-install zip
RUN docker-php-ext-install session
RUN docker-php-ext-install ldap
RUN docker-php-ext-install json
RUN docker-php-ext-install hash
RUN docker-php-ext-install sockets
RUN docker-php-ext-install pdo
RUN docker-php-ext-install mbstring
RUN docker-php-ext-install tokenizer
RUN docker-php-ext-install pgsql
RUN docker-php-ext-install pdo_pgsql
RUN docker-php-ext-install pdo_mysql 
RUN docker-php-ext-install pdo_sqlite
RUN docker-php-ext-install intl
RUN docker-php-ext-install mcrypt
RUN docker-php-ext-install mysqli
RUN docker-php-ext-install imap
RUN docker-php-ext-install gd
RUN docker-php-ext-install curl
RUN docker-php-ext-install exif
RUN docker-php-ext-install fileinfo
RUN docker-php-ext-install gettext
RUN docker-php-ext-install iconv
RUN docker-php-ext-install interbase
RUN docker-php-ext-install pdo_firebird
RUN docker-php-ext-install opcache
RUN docker-php-ext-install phar
RUN docker-php-ext-install posix
RUN docker-php-ext-install pspell
RUN docker-php-ext-install recode
RUN docker-php-ext-install shmop
RUN docker-php-ext-install simplexml
RUN docker-php-ext-install snmp
RUN docker-php-ext-install sysvmsg
RUN docker-php-ext-install sysvsem
RUN docker-php-ext-install sysvshm
RUN docker-php-ext-install tidy
RUN docker-php-ext-install wddx
RUN docker-php-ext-install xml
RUN docker-php-ext-install xmlrpc
RUN docker-php-ext-install xmlwriter 
```