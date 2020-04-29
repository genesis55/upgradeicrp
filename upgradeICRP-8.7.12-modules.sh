#!/usr/bin/env bash
# Upgrade ICRP to 8.7.12

# SYNTAX: upgradeICRP-8.7.12.sh <version number>

if [ -z ${1+x} ]; then
  echo "SYNTAX: updateICRP-8.7.12-modules.sh <version number>"
  exit
fi

version_number=$1
dir="icrp"$version_number

echo ""
echo "* cd $dir"
cd $dir
echo `pwd`

echo ""
echo "* Upgrading 8.7.12 Modules"
echo "composer require drupal/twig_tweak:^1.10 drupal/embed:^1.3 drupal/entity:^1.0 drupal/entity_embed:^1.0 drupal/extlink:^1.3"
php -d memory_limit=-1 /usr/local/bin/composer require drupal/twig_tweak:^1.10 drupal/embed:^1.3 drupal/entity:^1.0 drupal/entity_embed:^1.0 drupal/extlink:^1.3

echo "composer require drupal/crop:^2.0 drupal/devel:^2.1 drupal/ds:^3.5 drupal/ds_extras:^3.5 drupal/ds_switch_view_mode:^3.5 drupal/editor_advanced_link:^1.6"
php -d memory_limit=-1 /usr/local/bin/composer require drupal/crop:^2.0 drupal/devel:^2.1 drupal/ds:^3.5 drupal/ds_extras:^3.5 drupal/ds_switch_view_mode:^3.5 drupal/editor_advanced_link:^1.6

echo "composer require drupal/email_registration:^1.0"
php -d memory_limit=-1 /usr/local/bin/composer  require drupal/email_registration:^1.0

echo "composer require drupal/focal_point:^1.2 drupal/fontawesome:^2.15 drupal/honeypot:^1.30 drupal/linkit:^5.0-beta10@beta drupal/metatag:^1.11"
php -d memory_limit=-1 /usr/local/bin/composer require drupal/focal_point:^1.4 drupal/fontawesome:^2.15 drupal/honeypot:^1.30 drupal/linkit:^5.0-beta10@beta drupal/metatag:^1.13

echo "composer require drupal/panelizer:^4.2 drupal/pathauto:^1.6 drupal/redirect:^1.5 drupal/rules:^3.0-alpha5@alpha drupal/search_exclude:^1.2 drupal/token:^1.7"
#php -d memory_limit=-1 /usr/local/bin/composer require drupal/panelizer:^4.2 drupal/pathauto:^1.6 drupal/redirect:^1.5 drupal/rules:^3.0-alpha5@alpha drupal/search_exclude:^1.2 drupal/token:^1.6
php -d memory_limit=-1 /usr/local/bin/composer require drupal/panelizer:^4.2 drupal/pathauto:^1.6 drupal/redirect:^1.5 drupal/rules:^3.0-alpha5@alpha drupal/search_exclude:^1.2

echo "composer require drupal/typed_data:^1.0-alpha4@alpha drupal/video_embed_field:^2.2 drupal/webform:^5.8 drupal/webform_views:^5.0-alpha7@alpha drupal/webform_ui:^5.8"
php -d memory_limit=-1 /usr/local/bin/composer require drupal/typed_data:^1.0-alpha4@alpha drupal/video_embed_field:^2.2 drupal/webform:^5.8 drupal/webform_views:^5.0-alpha7@alpha drupal/webform_ui:^5.8

echo "* Manually update drupal/token:^1.6 or drupal/token:^1.7"
_token_info

echo "* drush status"
drush status
drush cr

echo ""
echo "* Finished"
echo ""
echo "Now run upgradeICRP-8.8.x.sh $version_number"
echo ""
