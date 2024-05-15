# PHP init
## Download PHP
newest stable release (apache2)
```apt install php-common libapache2-mod-php php-cli```

for apache2 information see ~/.dotfiles/develop/server.md

## PHP information
currently configured PHP information (lists tons of information; also see phpinfo())
```php -i```

show PHP version
```php -v```

## Modules
install modules
```
php[VERSION]-[MODULE]
```
i.e.
```sudo apt install php8.1 php8.1-cli php8.1-fpm php8.1-mysql php8.1-xml php8.1-mbstring```

list modules of specified PHP version
```php -m```

specific module information
```php -m | grep [MODULE]```

### Modules usually needed
- cli
- fpm
- imagick
- mbstring
- xml

