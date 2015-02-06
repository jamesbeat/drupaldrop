# drupaldrop – quick local Drupal setup for OSX

## What?

This is a version controlled [Drupal 7](http://www.drupal.org) installation profile that can be installed on your local Machine.

## Why?

Because boring and repeating tasks should be handled by computers. No need to manually download stuff, install modules and fiddle with permissions – just get a coffee and pick up your keys when the script has run. You can even clone the git repo and add your own set of modules, themes etc. So you always have an up to date package that helps you get a customized drupal site up and running in 3 Minutes.

## How?

Using [drush](http://www.drush.org/), [xampp](https://www.apachefriends.org/index.html) and the command line terminal. (See *Preparations* for detailed Info)

Assuming you already have XAMPP and drush setup and running:

1. Create a new directory for the site in your local *Sites* folder
2. Copy *drupaldrop.build*, *install.sh* and *install-example.config* in that folder
3. Rename *install-example.config* to *install.config* and edit the settings inside this file to match your system environment.
4. Open up Terminal and enable Root User: `$sudo -s`
5. cd to the Site directory (for exammple `cd Sites/sitename`)
6. run the command `sh install.sh`
7. You will be asked to enter some basic credentials, keep your MySQL root username and password ready.
8. The install script now creates a new MySQL user, Database, downloads latest Drupal core, builds an installation profile from this repo, downloads modules and translations, sets up basic content types and roles, enables a starter theme and logs you into the site. 
9. Enjoy!

> Disclaimer: Use this at your own risk. Running shell scripts can potentially do some serious damage to your system.
> Take the time and read through the install.sh file to see what it does exactly.

---

## Preparations

### Install XAMPP

1. Install [XAMPP](https://www.apachefriends.org/index.html) on your local machine
2. Make XAMPP a bit more secure, so only you cann access its databases
 
  in Terminal type:
  `$ sudo /Applications/XAMPP/xamppfiles/xampp security`
  and follow the instructions in the command line prompt

3. You might want to change the default XAMPP *htdocs* dir to your *sites* directory:

  Open *httpd.conf* and change 
 
 ```
  DocumentRoot "/Applications/XAMPP/xamppfiles/htdocs"
    <Directory "/Applications/XAMPP/xamppfiles/htdocs">
 ```
 
  to
 
 ```
  DocumentRoot "/Users/{USERNAME}/Sites"
  <Directory "/Users/{USERNAME}/Sites">
  ```
 
  *replacing {USERNAME} with your user*
 
  Copy folder *XAMPP/htdocs/xampp* to your *Sites* Folder so you can still access ist content.
  
  Typing *localhost* in your browser should now list all directories inside your *Sites* folder


---

### Install Drush

1. First install Composer globally. Open terminal and type:

 ```
$ curl -sS https://getcomposer.org/installer | php
$ mv composer.phar /usr/local/bin/composer
```

2. Now you need to tell terminal, where to look for the composer binaries.
	To do this, navigate to your root folder: 
	
	`$ cd` and enter `$ sudo nano .bash_profile`

	This file tells terminal which binaries to use for the commands you enter.

	paste following line inside the file
	
	`export PATH="$HOME/.composer/vendor/bin:$PATH"`
	
	enter *Ctrl O* and Enter to save the file and *Ctrl X* to quit the editor.

 Restart terminal to be sure the file takes effect.



3. Now you can use Composer to intall drush:

 ```
$ composer global require drush/drush:7.*
```

 If you want, you can always update compaser and drush by entering

 ```
$ composer global update
```

4. To get Drush up and running properly, you need to tell it which *php* and *mysql* binaries to use. These should be the ones that ship with XAMPP, because the ones used per default don't work in every case.

 To do this, open *.bash_profile once again  

 `$ sudo nano .bash_profile`

 and paste the following lines inside the file:


 ```
alias drush="$HOME/.composer/vendor/bin/drush"
alias php="/Applications/XAMPP/xamppfiles/bin/php"
alias mysql="/Applications/XAMPP/xamppfiles/bin/mysql"
PATH=$HOME/.composer/vendor/bin:$PATH
PATH=/Applications/XAMPP/xamppfiles/bin:$PATH
export DRUSH_PHP="/Applications/XAMPP/xamppfiles/bin/php"
export PATH
```
 
 Doing this simply adds the path to the XAMPP binaries to the $PATH variable and tells terminal which binaries to use if you execute drush, php and mysql commands from the console.

 enter *Ctrl O* and Enter to save the file and *Ctrl X* to quit the editor.

 Restart terminal to be sure the file takes effect.


---

## Make it yours

You definately will want to change some of the settings of this thing to suit your needs.
Start by cloning this repo and make changes to the following files:

*drupaldrop.make* This is the makefile that tells the installer, which modules and themes to include

*drupaldrop.info* This is the file that tells the installer, which modules and themes to enable.

*drupaldrop.info* This file sets up some basic drupal setings like user roles and content types.

*themes/drop* This is a minimal theme based on *basic* theme, making use of *SASS* and *Bourbon Neat*



