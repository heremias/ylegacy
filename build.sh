#Config composer
composer config -g allow-plugins.composer/installers true
composer config -g allow-plugins.drupal/core-composer-scaffold true
composer config -g allow-plugins.drupal/core-project-message true
composer config -g allow-plugins.oomphinc/composer-installers-extender true
#composer global require consolidation/cgr
#Run composer create project by Drupal verion, could be set to latest
composer create-project drupal/recommended-project:9.4.4 drupal


#Link Drush
ln -s /root/.composer/vendor/bin/drush /usr/local/bin/drush

#Configure Drush
#composer global require drush/drush
cd drupal
#rm -rf vendor/bin/drush
#cgr drush/drush
composer global update

#Run composer (note. composer is running as root, no composer in prod )
composer install --no-interaction
composer require drush/drush

#set permissions file system
chmod 777 web/sites/default

#cd web
#Drush Self install base Drupal on SQLite
drush site-install -y --db-url=sqlite://../drupal.sqlite

#.htaccess
mv /var/www/.htaccess /var/www/drupal/web

#Drupal permissions
chmod -R g+rw /var/www/drupal
chown -R :www-data /var/www/drupal
chmod -R 775 /var/www/drupal/drupal.sqlite
cd /var/www/drupal/web/sites/default
chmod 777 -R files
cd /var/www/drupal

#Drupal Login
drush uli

