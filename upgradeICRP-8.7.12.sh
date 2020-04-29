#!/usr/bin/env bash
# Upgrade ICRP to 8.7.12

# SYNTAX: upgradeICRP-8.7.12.sh <version number>

if [ -z ${1+x} ]; then
  echo "SYNTAX: updateICRP-8.7.12 <version number>"
  exit
fi

version_number=$1
dir="icrp"$version_number

echo ""
echo "* cd $dir"
cd $dir
echo `pwd`

echo ""
echo "* Changing 8.6.13 to 8.7.12"
echo "sed -i.bak 's/8.6.13/8.7.12/g' composer.json"
sed -i.bak "s/8.6.13/8.7.12/g" composer.json

echo ""
echo "* composer upgrade --with-dependencies"
composer upgrade drupal/core --with-dependencies

echo "* drush status"
drush status
drush cr

echo ""
echo "* Finished"
echo ""
echo "Now run ./upgradeICRP-8.7.12-modules.sh $version_number"
echo ""
