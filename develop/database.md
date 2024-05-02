# Database management
## MariaDB
Information from: ```https://phoenixnap.com/kb/how-to-create-mariadb-user-grant-privileges```

Note: ommit '' from commands (here to show input of desired information)

start service
```systemctl start mariadb```

stop service
```systemctl stop mariadb```

status service
```systemctl status mariadb```

---

access MariaDB server
```sudo mysql -u root```

show databases
```SHOW DATABASES;```

create database
```CREATE DATABASE 'DB_NAME';```

create user
```CREATE USER 'USER_NAME'@localhost IDENTIFIED BY 'PASSWORD';```

drop user
```DROP USER 'USER_NAME'@localhost;```

show users
```SELECT User FROM mysql.user;```

set privileges
all db:
```GRANT ALL PRIVILEGES ON *.* TO 'USER_NAME'@localhost IDENTIFIED BY 'PASSWORD';```

specific db:
```GRANT ALL PRIVILEGES ON 'DB_NAME'.* TO 'USER_NAME'@localhost;```

then: ```FLUSH PRIVILEGES;```

show privileges
```SHOW GRANTS FOR 'USER_NAME'@localhost;```


