# drupaldrop

## What?

This is a version controlled Drupal 7 installation profile that can be installed on your local Machine using Drush

##Preparations

###Install XAMPP

http://localhost/xampp/index.php

### Run Security
in Terminal type:

sudo /Applications/XAMPP/xamppfiles/xampp security

Open httpd.conf and change 
*DocumentRoot "/Applications/XAMPP/xamppfiles/htdocs"*
*<Directory "/Applications/XAMPP/xamppfiles/htdocs">*

to

*DocumentRoot "/Users/{USERNAME}/Sites"*
*<Directory "/Users/{USERNAME}/Sites">*

(replacing {USERNAME})

Copy folder XAMPP/htdocs/xampp to your Sites Folder

Add *Listen 8080* to enable access via mobile device

/Applications/XAMPP/xamppfiles/xampp security


###Install Drush

alias drush="/Users/Basti/.composer/vendor/bin/drush"
alias php="/Applications/XAMPP/xamppfiles/bin/php"
alias mysql="/Applications/XAMPP/xamppfiles/bin/mysql"

PATH=$HOME/.composer/vendor/bin:$PATH
PATH=/Applications/XAMPP/xamppfiles/bin:$PATH

export PGHOST=localhost
export DRUSH_PHP="/Applications/XAMPP/xamppfiles/bin/php"
export PATH


## Usage

Create a new directory for the site
Copy *drupaldrop.build*, *install.sh* and *install-example.config* in that folder
Rename *install-example.config* to *install.config* and edit the settings to match your system environment.

Open up Terminal and enable Root User: *sudo -s*
cd to the Site directory
run sh install.sh

Get a coffe 




