#!/usr/bin/env bash
# Create and upgrade ICRP from to 8.8.x

# SYNTAX: createICRP <version number>

if [ -z ${1+x} ]; then
  echo "SYNTAX: createICRP <version number>"
  exit
fi

version_number=$1
dir="icrp"$version_number



if [ -d "/github/$dir" ]; then
  echo "The directory /github/$dir already exists.  Please move or delete and try again."
  echo ""
  exit
fi
echo ""
echo "<Creating $dir>"

echo ""
echo "* git clone https://github.com/CBIIT/icrp $dir"
git clone https://github.com/CBIIT/icrp $dir -v --progress

echo ""
echo "* cd $dir"
cd $dir
echo `pwd`
echo "Checkout branch ss-2501_Drupal_8.8_Upgrade_8.6.13 825d72ac6eb1eb93ee820d908b50afab156fb5f1"
echo "This is the initial Site. Drupal 8.6.13"
git checkout -b ss-2501_Drupal_8.8_Upgrade 825d72ac6eb1eb93ee820d908b50afab156fb5f1 --progress
git log -n1

echo ""
echo "* composer install"
composer install
composer install

echo ""
echo "*cp settings.php and services.yml to sites/default directory."
echo "cp -p ../drupal_assets/settings.php sites/default"
cp -p ../drupal_assets/settings.php sites/default
echo "cp -p ../drupal_assets/services.yml sites/default"
cp -p ../drupal_assets/services.yml sites/default

echo ""
echo "<Load Database>"
echo "* drush sql-cli < ../drupal_assets/database-8.6.13.sql"
# Works
#drush sql-cli < ../drupal_assets/database-8.6.13.sql
# Production Database
drush sql-cli < ../drupal_assets/icrp-2.4.2-20200110-sanitized.sql

echo ""
echo "* Changing {DATABASE_NAME} in settings.php"
echo "sed -i.bak 's/{DATABASE_NAME}/$dir/g' sites/default/settings.php"
sed -i.bak "s/{DATABASE_NAME}/$dir/g" sites/default/settings.php
tail -n13 sites/default/settings.php

echo ""
echo "* drush cset extlink.settings extlink_exclude 'http://icrp4:8888' -y"
drush cset extlink.settings extlink_exclude "http://$dir:8888" -y

echo "* drush status"
drush status
drush cr

echo "* Check to see if there are any missing modules"
drush en module_missing_message_fixer -y
echo "* drush mmmfl"
drush mmmfl
echo "* drush mmmff --all"
drush mmmff --all

echo "*Remove examples module"
echo "drush pm-uninstall examples -y"
drush pm-uninstall examples -y

echo " Remove views_data_export patch then run composer require views_data_export"
sed -i.bak "s/{DATABASE_NAME}/$dir/g" composer.json
echo ""
php -d memory_limit=-1 /usr/local/bin/composer require drupal/views_data_export

echo " Change Appearance Theme to NONE"
echo ""

echo ""
echo "* Finished"
echo ""
echo "Now run ./upgradeICRP-8.7.12.sh $version_number"
echo ""

cd /Applications/Firefox.app/Contents/MacOS
./firefox "http://$dir:8888"
