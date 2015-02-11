#!/bin/bash
set -e
# Any subsequent commands which fail will cause the shell script to exit immediately

# Reading options from install.config
FILENAME=install.config
while read option
do
    export $option
done < $FILENAME

ECHO="$ECHO_PATH"
FIND="$FIND_PATH"
AWK="$AWK_PATH"

MyUSER="root"
MyPASS="sushi"
MyHOST="localhost"


# $ECHO "-------------- APACHE USER INFO -----------------"

# read -e -p "Enter Apache User Name: " aUserName
# read -e -p "Enter Apache User Password: " aUserPass

# Create a new example user, setting up /var/www/example as their home dir.
# useradd -s /bin/bash -d /var/www/example -m $aUserName;

# Now add that user to the Apache group. On Ubuntu/Debian this group is usually
# called www-data, on CentOS it's usually apache.
# usermod -a -G www-data $aUserName;

# Set up a password for this user.
# passwd $aUserPass;

#login user  
# su - $aUserName  

# Start install
$ECHO "-----------------------------------------"
$ECHO "*"
$ECHO "Hello. This Script will setup a D7 Drupaldrop Installation in the current dir"
$ECHO "*"
$ECHO "-------------- BASIC INFO -----------------"

read -e -p "Enter Site Name: " siteName
read -e -p "Enter Site Directory Name: " dirName

$ECHO "-------------- DATABASE -----------------"
read -e -p "Enter Database Name: " dbName
read -e -p "Enter Database User: " dbUser
read -e -p "Enter Database Pass: " dbPass

$ECHO "CREATE DATABASE '$dbName' CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';"

mysql -u $MyUSER -h $MyHOST -p$MyPASS -Bse "CREATE DATABASE $dbName CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';"
mysql -u $MyUSER -h $MyHOST -p$MyPASS -Bse "CREATE USER '$dbUser'@'$MyHOST' IDENTIFIED BY '$dbPass';"
mysql -u $MyUSER -h $MyHOST -p$MyPASS -Bse "SET PASSWORD FOR '$dbUser'@'$MyHOST' = PASSWORD('$dbPass');"
mysql -u $MyUSER -h $MyHOST -p$MyPASS -Bse "GRANT ALL PRIVILEGES ON ${dbName}.* TO '$dbUser'@'$MyHOST' IDENTIFIED BY '$dbPass' WITH GRANT OPTION;"
mysql -u $MyUSER -h $MyHOST -p$MyPASS -Bse "FLUSH PRIVILEGES;"

$ECHO "Database $dbName was created with User $dbUser and Pass $dbPass" 

$ECHO "-------------- DRUPAL SETUP -----------------"
read -e -p "Enter Admin Username: " userName
read -e -p "Enter Admin Password: " userPass
read -e -p "Enter Admin E-Mail: " userMail
read -e -p "Site Locale (Format: de, en etc.): " siteLocale

$ECHO "-------------- MAKE DISTRIBUTION -----------------"

drush make drupaldrop.build -y

$ECHO "--------------INSTALLING DRUPALDROP -----------------" 

drush site-install -y drupaldrop --account-mail=$userMail --account-name=$userName --account-pass=$userPass --site-name=$siteName --site-mail=$userMail --locale=$siteLocale --db-url=mysql://$dbUser:$dbPass@$MyHOST:3306/$dbName  --db-su=$MyUSER --db-su-pw=$MyPASS install_configure_form.update_status_module='array(FALSE,FALSE)' --debug 

$ECHO "-------------- LOCALIZATION -----------------" 

drush dl drush_language -y
drush language-add $siteLocale -y
drush language-enable $siteLocale -y
drush language-default $siteLocale -y
drush l10n-update --languages=$siteLocale

$ECHO "-------------- CREATE PRIVATE FILES DIR -----------------" 

chmod 770 sites/default/files
mkdir -p sites/default/files/private
chmod 770 sites/default/files/private

$ECHO "-------------- CRON -----------------" 
drush cron
drush cc all

$ECHO "-------------- REBUILD PERMISSIONS -----------------" 
drush php-eval 'node_access_rebuild();'

$ECHO "-------------- YOUR NEW SITE -----------------" 

drush status

$ECHO "-------------- YOUR KEYS  -----------------" 
drush uli --uri=http://$MyHOST/$dirName

$ECHO "-------------- CLEANUP -----------------" 
rm –f INSTALL.mysql.txt INSTALL.pgsql.txt INSTALL.sqlite.txt INSTALL.txt LICENSE.txt MAINTAINERS.txt UPGRADE.txt README.txt install.config install.sh drupaldrop.build CHANGELOG.txt COPYRIGHT.txt