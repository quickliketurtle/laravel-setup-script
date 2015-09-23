#!/bin/bash

echo "Lets's Get Started"

# Create new laravel Project
echo -n "Create a new Laravel app? [yes|no] : "
read -e laravel
if [[ $laravel == "yes" ]]
    then
        echo -n "What is the name of the app? : "
        read appname
        laravel new $appname
        cd $appname
        php artisan key:generate
fi

# Update app/bootstrap/start.php with env function
echo -n "Set up Development Environment? [yes|no] "
read -e development
if [[ $development == "yes" ]]
    then
        mv .env.example .env
fi

echo -n "Need a Git Repository [yes|no] : "
read -e git
if [[ $git == 'yes' ]]
    then
        echo Initializing Git
        git init
        git add .
        git commit -m "initial commit"
fi

echo -n "Add this Repo to Github? [yes|no]: "
read -e github
if [[ $github == 'yes' ]]
    then
        echo -n "What is your github username? "
        read githubUsername
        curl -u "$githubUsername" https://api.github.com/user/repos -d "{\"name\":\"$appname\"}"

        git remote add origin git@github.com:$githubUsername/$appname.git
        git push origin master
fi

echo "You're All Set, Now get coding!"
