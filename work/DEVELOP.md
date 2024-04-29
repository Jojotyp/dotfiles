# General
## Search
### multi-line search regex
find all text from string1 to string2 even across multiple lines:
```
^.*string1[\s\S]+?string2
^.*string1[\s\S]+?string2[\s\S]+?string3
^.*string1[\s\S]+?string2[\s\S]+?string3[\s\S]+?string4
^.*string1[\s\S]+?string2[\s\S]+?string3[\s\S]+?string4[\s\S]+?string5
```


---


# PHP
## Switch version
### Command line
PHP version and path to cli php version
```
php -v
which php
```

in ~/.bash_profile edit PATH variable for wanted version (CLI php usage) i.e.:
```
export PATH="/usr/local/opt/php@8.1/bin:$PATH"
export PATH="/usr/local/opt/php@8.1/sbin:$PATH"
```

## MAMP
## php.ini
find php.ini file in use:
```
php --ini
```

path 7.4.9 php.ini (CLI):
```
~/Applications/MAMP/bin/php/php7.4.9/conf/php.ini
```

php.ini (Server)
- open MAMP -> PHP -> Open template\
or:
- open MAMP -> File (Mac) -> open Template -> PHP (php.ini) -> select version
- relevant php.ini can be in php version folder (different to MAMP -> File ...)!

adjust memory_limit:
- go to php.ini -> memory_limit = ... (i.e. 1024M)

## to get current memory limit
```
php -i | grep "memory_limit"
```

## MAMP error logs dir
```
/Applications/MAMP/logs
```

## general
get time
```
public function getCurrDateAndTime() {
    $currDateAndTime = date('Y-m-d h:i:s');
    return $currDateAndTime;
}
```

$_GET (superglobal): get associative array of variables from URL (example: firstname: "Hannes", lastname: "Johann")
```
https://example.com/?firstname=Hannes&lastname=Johann
```


## Composer
"Composer is a tool for dependency management in PHP. It allows you to declare the libraries your project depends on 
and it will manage (install/update) them for you."

- packages are managed on per-project basis and installed into dir "vendor" (default)
  - this makes it a *dependancy manager*, not a *package manager*
  - composer will find needed dependancies of specified packages without the developer having to declare them
- composer.json
  - is the file for the dependencies
  - should be in project root dir
  - "require" key inside this file specifies the packages the project depends on
    ```
      ...
      "require": {
        "php": ">=7.3",
        "phpoffice/phpword": "^1.1",
      },
      ...
      ```
  - default package repository: ```Packagist.org```


## phpDocumentor
Installation globally to get executable ```phpDocumentor``` command

Download .phar
```
https://phpdoc.org/phpDocumentor.phar
```

move to /usr/local/bin -> make it executable (and change the group to admin)
```
mv PATH_DOWNLOAD_DIR/phpDocumentor.phar
chmode +x phpDocumentor.phar
chgrp admin phpDocumentor.phar
```

consider making an alias: phpdoc="phpDocumentor"

parse PARSING_DIR and output into OUTPUT_DIR (when installing as .phar "run" is needed, otherwise omit)
```
phpDocumentor run -d PARSING_DIR -f PARSING_SPECIFIC_FILE -t OUTPUT_DIR
```


---


# Symfony
## MVC - Model, View, Controller
- Model: Database
  - Doctrine
- View: Display (for the User)
  - Twig (HTML) Template-Engine
- Controller: Business Logic
  - Workflow control: pulls data from Model and renders View
  - Routing

## Twig
### dump (i.e.)
```
<d>{{ dump(constant('Namespace\\Of\\File\\Class::CLASS_VAR')) }}</d>
```

### Where do variables come from?
- usually passed from Controller or parts of Application
  - check Controller
    - render method
      ```php
      return $this->render('example.html.twig', [
          'variable_name' => $variable_value
      ]);
      ```
    - part of Response object
  - check whether set in Twig template itself
    ```twig
    {% set variable_name = 'value' %}
    ```
  - check whether set in parent template
  - check whether set in included template
    - include, embed, import tags
  - special variable?
    - i.e. "data" in context of form rendering -> form object passed from Controller to template contains data attribute
      - example: access special variable "data" for all form fields
      ```twig
      {% for field in form %}
          {% set field_data = field.vars.data %}
      {% endfor %}
      ```
  - check global variables
    - config.yml or services.yml
    ```yml
    twig:
        globals:
            variable_name: 'value'
    ```
  - check custom extensions and filters

## Routing
### Example Parameter conversion for multiple uuids
```php
/**
* @Symfony\Component\Routing\Annotation\Route("/{uuid}/export-word/{processing_activity_uuid}", name="app_gdpr_processing_activity_export_word", methods={"GET","POST"}, options={"expose":true}, defaults={"processing_activity_uuid":null})
* @Sensio\Bundle\FrameworkExtraBundle\Configuration\ParamConverter("processingActivity", options={"mapping": {"processing_activity_uuid": "uuid"}})
* @Sensio\Bundle\FrameworkExtraBundle\Configuration\Security("is_granted('ACL_SEE', location) and (is_granted('APP_GDPR_PROCESSING_ACTIVITY_VIEW') or is_granted('APP_GDPR_PROCESSING_ACTIVITY_EDIT'))")
*/
public function exportWord(CompanyLocation $location, ProcessingActivity $processingActivity = null, ProcessingActivityService $service = null)
```


## Forms
TODO: JS interaction - How exactly?

### Options
#### property_path
https://symfonycasts.com/blog/property_path
Useful when an object should be able to edit another object's property. Defaults to the field name.
i.e. StudyPatient form edits Patient (lastname):
```
...
'property_path' => 'patient.lastname',
...
```

## Command Line Symfony
## Start console for project in command line:
```
./bin/console ...
```

### List all php versions (and for Symfony selected)
```
symfony local:php:list
```

### Bundle Informationen zu keys & values für config files (./app/config/)
```
./bin/console config:dump-reference BUNDLE
```


### Show services of container x (hier z.B. markdown)
```
./bin/console debug:container markdown
```


### Parameters list
#### for config files
```
./bin/console debug:container --parameters
```

### Clear Doctrine Cache
```
./bin/console doctrine:cache:clear CACHE-NAME
```


---


# studioMed+

## Update studioMED+ project
```
./update.sh
```

## exclude folders for indexing (faster search)
- upload
- var
- vendor (except composer, studio201, studiomedplus)
- web


## Structure
app >(?) src > core >(?) user-backend


## TODO: _ini_get() und set angucken (i.e. for: ini_get('session.cookie_lifetime'); @ini_set('session.cookie_lifetime', 0);)


## MandantBundle file usage
- configure needed (overridden) folders/files in MandantBundle/Resources/config -> config.yml/routing.yml/services.yml


## Forms
### Form Types
When editing a field:
- care about FormHelper (changeFormFieldOptions) -> overrides the options set for a field!!!


## Twig
- {{ forms.panel_header(...) }}
  - for panels
  - i.e.: 
- {{ localforms.print_formpanels(form[FORM_NAME]) }}
  - i.e.: {{ localforms.print_formpanels(form[StudyMasterdataType]) }}

## Services




## Create dummy data
Command overview
```
php bin/console studiomed

php bin/console help studiomed:init
```
DO NOT use ```studiomed:migrate``` but rather ```studiomed:init```

i.e.: to create a Patient + StudyPatient of certain study
```
php bin/console studiomed:init:patient AMOUNT --studyuuid=STUDY_UUID
```


## Templates
create, edit, delete code templates for forms
```
project/app_dev.php/de/profile/templateentity/
```


## Testing
### Codeception
- create ```codeception.config.json``` from ```codeception.config.json.dist```
- update contents of ```codeception.config.json```
```yaml
{
   "testUrl": "local-host-url.fto", # i.e. http://studiomedplus-demo.fto/
   "adminName": "userName",
   "adminPassword": "password",
   "modeName": "TestModeratorFTO",
   "modePassword": "TestModeratorFTO",
   "investName": "TestInvestigatorFTO",
   "investPassword": "TestInvestigatorFTO",
   "monitorClass": "principalInvestigator",
   "otherStaffClass": "subInvestigatorFTO",
   "acl": "false",
   "clincfilterPatient": "true"
}
```

- include correct paths in ```codeception.yml```

open browser window for tests: ```acceptance.suite.yml```
```yaml
chromeOptions:
    args: ['disable-infobars', '--ignore-certificate-errors']
```

open headless browser: ```acceptance.suite.yml```
```yaml
chromeOptions:
    args: ['disable-infobars', 'headless', '--ignore-certificate-errors']
```

---

# s201

## Debugging
### env
#### dev
- SF toolbar
- profiler
- way less caching
- error messages (red screen)

#### prod
as if in production
- a lot of caching
- error messages simply error code

### Clear cache (mind env)
```
rm -rf var/cache/dev
rm -rf var/cache/prod

./bin/console cache:clear --env=dev
./bin/console cache:clear --env=prod
```

### Assetic
#### allow dynamic changes of js & css
Symfony 3.4
```
php -d memory_limit=-1 bin/console assetic:watch --env=dev
```

Symfony 4.x
```
yarn encore dev --watch
```
or
```
yarn watch
```

#### force changes of js & css (web folder)
Symfony 3.4
```
php bin/console assetic:dump && php bin/console assets:install web
```

Symfony 4/6
```
yarn encore dev --watch
```

... zur Not auch mal Browsercache löschen!

### Clear Browsercache
browser settings

### Log files
```
var/logs
```

## Create (generate) template entities/forms
```PROJECT/de/profile/templateentity```
```PROJECT/de/profile/formularelement```

- Serialisieren: in .json umwandeln, damit andere Entwickler gleichen Code generieren können
- Wiederherstellen: ?
- Entity generieren: erstellt die Entity basierend auf templates/System/Skeleton/EntitySkeleton/*
- Form generieren: erstellt die Form basierend auf templates/System/Skeleton/Form.php.twig
- CRUDController generieren: erstellt den Controller basierend auf templates/System/Skeleton/Controller.tpl.php
- Speichern: sichert die Entity für erneute Nutzung oder zum copy/paste

## GIT
### pull data from git (daily)
```
./updateDev.sh
```

### merge local with remote or resolve conflicts on git pull/updateDev.sh
#### useful for differences between local files and remote files
1. go to bundle dir (conflicted) i.e.: ./vendor/studiomedplus/documentsbundle/StudioMedPlus/DocumentsBundle
2. execute commands:
```
git stash save
git pull
git stash pop
```
-> either everything saved or conflicts created by GIT
3. find file (marked red) -> GIT -> Resolve Conflict

### merge local with remote manually
1. git origin changes (simply loads, does not update anything yet)
```
git fetch origin
```

2. save local changes to .bak (backup)
```
cp path/to/file.extension path/to/file.extension.bak
```

3. get the current remote file into local system ("--" separates the branch from the file)
```
git checkout origin/master -- path/to/file
```

4. Compare changes (PhpStorm)
right-click in project files on target file -> Compare with...

## Create User with Admin Role (maybe regard README.md)
create User
```
php bin/console fos:user:create USERNAME <YOUR EMAIL>
```

add ROLE_ADMIN and ROLE_SYSTEM_ADMIN
```
php bin/console fos:user:promote admin ROLE_ADMIN
php bin/console fos:user:promote admin ROLE_SYSTEM_ADMIN
```


---


# PhpStorm
## Shortcuts
search
```
cmd+shift+f
```

format file / selection
```
alt+cmd+l
```


---


# Server
## Server start
```
/Applications/MAMP/bin/php/php7.4.9/bin/php bin/console server:run
```

---

# Database
## general
change password for a user
```
php bin/console fos:user:change-password user password
```

## Doctrine
### fix ERROR: "this is incompatible with sql_mode=only_full_group_by"
```
SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
```
in phpMyAdmin -> SQL -> Go

### Create database (braucht Entity dir in ./src/AppBundle/)
```
./bin/console doctrine:database:create
```

### Create table
#### preview of query to update db schema (correct fields)
```
./bin/console doctrine:schema:update --dump-sql
```
#### query to update db schema (correct fields)
```
./bin/console doctrine:schema:update --force
```

#### other way -> create file first (using Doctrine/Migration) in app/DoctrineMigrations
#### then (after checking file) -> implement
```
./bin/console doctrine:migrations:diff

./bin/console doctrine:migrations:migrate
```

### doctrine console query
```
./bin/console doctrine:query:sql 'QUERY'
```

### doctrine drop database
```
./bin/console doctrine:database:drop --force
```


### Doctrine Caching (config.yml)
```
# Doctrine Cache Configuration
doctrine_cache:
    providers:
        my_markdown_cache:
            type: file_system
            file_system:
                directory: /tmp/doctrine_cache
```

### Create fake dummy data (Alice Faker Function: doctrine-fixtures-bundle)
#### siehe: ./src/AppBundle/DataFixtures/ORM
```
./bin/console doctrine:fixtures:load
```

## MySQL
### start MySQL monitor
```
mysql -u root -p DATABASE_NAME
```

### current database (CLI)
```
SELECT DATABASE();
```

### databases that MySQL server hosts (and permission to see them)
```
SHOW DATABASES;
```

### use specific database
```
USE database_name;
```

### ERROR 2002 (HY000): Can't connect to local MySQL server through socket '/tmp/mysql.sock' (2)
either create symlink to /tmp/mysql.sock from MAMP
```
cd /tmp
ln -s /Applications/MAMP/tmp/mysql/mysql.sock ./mysql.sock
```

or specify path
```
mysql -u username -p --socket=/Applications/MAMP/tmp/mysql/mysql.sock
```

## phpMyAdmin
dump .sql file (db data) into db
```
/Applications/MAMP/Library/bin/mysql -u user -p database < file
```
-> usually something like:
```
/Applications/MAMP/Library/bin/mysql -u root -p studiomedplus_apst < Downloads/studiomedplus_apst.sql
```

---

# PROJECT SETUP (general)
## git clone repo

## change NODE_OPTIONS
```export NODE_OPTIONS=--openssl-legacy-provider```

export option settings can be checked with ```export``` in CLI


---

# CODE
## Debugging
```js
_debugSeparators: function (msg = '', level = 'log', sep = '#', count = 100, above = true, below = true) {
    // Validate the logging level
    if (!['debug', 'log', 'info', 'warn', 'error'].includes(level)) {
        console.warn(`Invalid logging level "${level}" in _debugSeparators fnc. Using "log" by default.`);
        level = 'log';
    }

    // Create a string consisting of 'count' number of 'sep' characters
    const separatorLine = new Array(count + 1).join(sep);

    // Function to print according to the level
    const print = (message) => console[level](message);

    // Print separator line above the message if 'above' is true
    if (above) {
        print(separatorLine);
    }

    // Print the message if it is not an empty string
    if (msg !== '') {
        print(msg);
    }

    // Print separator line below the message if 'below' is true
    if (below) {
        print(separatorLine);
    }
}
```
