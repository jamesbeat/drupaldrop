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
ECHO="$ECHO_PATH"
FIND="$FIND_PATH"
AWK="$AWK_PATH"
MySQL="$MySQL_PATH"
MyUSER="root"
MyPASS="sushi"
MyHOST="localhost"

# Start install
$ECHO "-----------------------------------------"
$ECHO "*"
$ECHO "Hello. This Script will setup a D7 Drupaldrop Installation in the current dir"
$ECHO "*"
$ECHO "--------------BASIC INFO-----------------"

read -e -p "Enter Site Name: " siteName

$ECHO "--------------DATABASE-----------------"
read -e -p "Enter Database Name: " dbName
read -e -p "Enter Database User: " dbUser
read -e -p "Enter Database Pass: " dbPass

$MySQL mysql -u $MyUSER -h $MyHOST -p$MyPASS -Bse "CREATE DATABASE $dbName CHARACTER SET utf8 COLLATE utf8_general_ci;"
$MySQL mysql -u $MyUSER -h $MyHOST -p$MyPASS -Bse "CREATE USER '$dbUser'@'$MyHOST' IDENTIFIED BY '$dbPass';"
$MySQL mysql -u $MyUSER -h $MyHOST -p$MyPASS -Bse "SET PASSWORD FOR '$dbUser'@'$MyHOST' = PASSWORD('$dbPass');"
$MySQL mysql -u $MyUSER -h $MyHOST -p$MyPASS -Bse "GRANT ALL PRIVILEGES ON ${dbName}.* TO '$dbUser'@'$MyHOST' IDENTIFIED BY '$dbPass' WITH GRANT OPTION;"
$MySQL mysql -u $MyUSER -h $MyHOST -p$MyPASS -Bse "FLUSH PRIVILEGES;"

$ECHO "Database $dbName was created with User $dbUser and Pass $dbPass" 

$ECHO "--------------DRUPAL SETUP-----------------"
read -e -p "Enter Admin Username: " userName
read -e -p "Enter Admin Password: " userPass
read -e -p "Enter Admin E-Mail: " userMail
read -e -p "Site Locale (Format: de, en etc.): " siteLocale

$ECHO "--------------MAKE DISTRIBUTION-----------------"

$DRUSH make drupaldrop.build -y

$ECHO "--------------INSTALLING DRUPALDROP -----------------" 

$DRUSH site-install -y drupaldrop --account-mail=$userMail --account-name=$userName --account-pass=$userPass --site-name=$siteName --site-mail=$userMail --locale=$siteLocale --db-url=mysql://$dbUser:$dbPass@$MyHOST:3306/$dbName install_configure_form.update_status_module='array(FALSE,FALSE)' --debug 

