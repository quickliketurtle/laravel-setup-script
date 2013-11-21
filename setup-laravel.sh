#!/bin/bash

echo "Lets's Get Started"

echo -n "Create a new Laravel app? [yes/no] : "
read laravel
if [[ $laravel == "yes" ]]
    then
        echo -n "What is the name of the app? : "
        read appname
        composer create-project laravel/laravel $appname --prefer-dist
        cd $appname
fi

# Install and Configure Way/Generators Package
echo Add Way///Generators to $appname
sed -i '8 a\ "require-dev" : { "way/generators": "dev-master" },' composer.json
composer update
sed -i "115 a\ 'Way\\\Generators\\\GeneratorsServiceProvider'," app/config/app.php

# TODO Update app/bootstrap/start.php with env function

echo -n "What is the name of the database for this app? : "
read -e database

echo Creating MySQL database
mysql -uroot -p -e"CREATE DATABASE $database"

echo Updating database configuration file
sed -i "s/'database'  => 'database',/'database'  => '$database',/g" app/config/database.php

echo -n "Do you need a users table? [yes|no] : "
read -e userstable

if [[ $userstable = 'yes' ]]
    then
        php artisan generate:migration create_users_table --fields="username:string:unique, email:string:unique, password:string"

        echo Migrating the database
        php artisan migrate
fi

echo Initializing Git
git init
git add .
git commit -m "initial commit"
