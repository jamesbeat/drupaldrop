#!/bin/bash
set -e
# Any subsequent commands which fail will cause the shell script to exit immediately

# Reading options from install.config
FILENAME=install.config
while read option
do
    export $option
done < $FILENAME

DRUSH="$DRUSH_PATH"
ECHO_PATH="$ECHO_PATH"
FIND_PATH="$FIND_PATH"
AWK_PATH="$AWK_PATH"
MYSQL_PATH="$MYSQL_PATH"

# Start install
clear

$ECHO "Hello. This Script will setup a D7 Installation"
$ECHO "--------------BASIC INFO-----------------"

read -e -p "Enter Site Name: " siteName
read -e -p "Enter Directory(relative to /websites): " rootDir

$ECHO "--------------DATABASE-----------------"
read -e -p "Enter Database Name: " dbName
read -e -p "Enter Database User: " dbUser
read -e -p "Enter Database Pass: " dbPass

$MYSQL mysql -u $MyUSER -h $MyHOST -p$MyPASS -Bse "CREATE DATABASE $dbName CHARACTER SET utf8 COLLATE utf8_general_ci;"
$MYSQL mysql -u $MyUSER -h $MyHOST -p$MyPASS -Bse "CREATE USER '$dbUser'@'$MyHOST' IDENTIFIED BY '$dbPass';"
$MYSQL mysql -u $MyUSER -h $MyHOST -p$MyPASS -Bse "SET PASSWORD FOR '$dbUser'@'$MyHOST' = PASSWORD('$dbPass');"
$MYSQL mysql -u $MyUSER -h $MyHOST -p$MyPASS -Bse "GRANT ALL PRIVILEGES ON ${dbName}.* TO '$dbUser'@'$MyHOST' IDENTIFIED BY '$dbPass' WITH GRANT OPTION;"
# $MYSQL mysql -u $MyUSER -h $MyHOST -p$MyPASS -Bse "GRANT ALL PRIVILEGES ON *.* TO '$dbUser'@'$MyHOST' IDENTIFIED BY '$dbPass' WITH GRANT OPTION;"
$MYSQL mysql -u $MyUSER -h $MyHOST -p$MyPASS -Bse "FLUSH PRIVILEGES;"

$ECHO "Database $dbName was created with User $dbUser and Pass $dbPass" 

$ECHO "--------------DRUPAL SETUP-----------------"
read -e -p "Enter Admin Username: " userName
read -e -p "Enter Admin Password: " userPass
read -e -p "Enter Admin E-Mail: " userMail
read -e -p "Site Locale (Format: de, en etc.): " siteLocale

$ECHO "--------------MAKE DISTRIBUTION-----------------"
cd
cd $httpDir
cd $rootDir

sudo $DRUSH make drupaldrop.build -y

read -e -p "Enter Admin Username: " userName
read -e -p "Enter Admin Password: " userPass
read -e -p "Enter Admin E-Mail: " userMail
read -e -p "Site Locale (Format: de, en etc.): " siteLocale

$ECHO "--------------INSTALLING DRUPALDROP -----------------" 

cd
cd $httpDir
cd $rootDir

sudo $DRUSH site-install -y drupaldrop --account-mail=$userMail --account-name=$userName --account-pass=$userPass --site-name=$siteName --site-mail=$userMail --locale=$siteLocale --db-url=mysql://$dbUser:$dbPass@$MyHOST:3306/$dbName install_configure_form.update_status_module='array(FALSE,FALSE)' --db-su=root --db-su-pw=sushi --debug 

