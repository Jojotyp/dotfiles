# Server information
## Apache
```sudo apt install apache2```

start/stop/status/restart
```
systemctl start apache2
systemctl stop apache2
systemctl status apache2
systemctl restart apache2
```

configure with PHP
```sudo a2enmod php[VERSION]```

### configure for Symfony project
create virtual host
```sudo nano /etc/apache2/sites-available/symfony.conf```

enable site and Apache rewrite mode
```
sudo a2ensite symfony.conf
sudo a2enmod rewrite
sudo systemctl restart apache2
```

edit hosts file by adding domain for server ip (example)
here myproject.local has to be the same as ServerName in symfony.conf!
```
sudo nano /etc/hosts

127.0.0.1 myproject.local
```

set ownership of folder to www-data
```sudo chown -R www-data:www-data /path/to/project```

```sudo systemctl restart apache2```

open browser
```http://myproject.local```
