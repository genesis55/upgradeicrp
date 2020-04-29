#!/usr/bin/env bash
# Upgrade ICRP 8.6.13 to a working FullCalendar

# SYNTAX: upgradeICRP-8.6.13-fullcalendar.sh <version number>

if [ -z ${1+x} ]; then
  echo "SYNTAX: updateICRP-8.6.13-fullcalendar.sh <version number>"
  exit
fi

version_number=$1
dir="icrp"$version_number

echo ""
echo "* cd $dir"
cd $dir
echo `pwd`

#echo "Checkout branch ss-2501_Drupal_8.8_Upgrade 4fb8cc07df39c653767a7b73c298b19b141472ba"
#echo "This is the initial Site. Drupal 8.6.13 with the FullCalendar fix"
#git checkout -b ss-2501_Drupal_8.8_Upgrade_8.6.13_fullcalendar 4fb8cc07df39c653767a7b73c298b19b141472ba --progress
#git log -n1

#echo ""
#echo "* composer install"
#composer install
echo "*Require Upgrade fullcalendar"
echo "composer require drupal/fullcalendar drupal/fullcalendar_options drupal/fullcalendar_legend"
composer require drupal/fullcalendar drupal/fullcalendar_options drupal/fullcalendar_legend

echo "drush sql-query ''delete from config where name like 'fullcalendar%'"
drush sql-query "delete from config where name like 'fullcalendar%'"

echo "drush pm-enable fullcalendar fullcalendar_options fullcalendar_legend -y"
drush pm-enable fullcalendar fullcalendar_options fullcalendar_legend -y

echo "* drush status"
drush status
drush cr

echo ""
echo "* Finished"
echo ""
echo "Now run upgradeICRP-8.7.12.sh $version_number"
echo ""
