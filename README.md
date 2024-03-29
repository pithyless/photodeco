Photodeco
=========

## Setup Local Development

### Install PostgreSQL

    brew install postgresql

### Get RVM (http://rvm.beginrescueend.com/)

    bash < <(curl -s https://rvm.beginrescueend.com/install/rvm)

### Append RVM function to your .bash_profile

    user$ echo '[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function' >> ~/.bash_profile

### Reload .bash_profile

    source .bash_profile

### Check if any dependencies need to be installed on your system

    rvm notes

### Get Ruby 1.9.2

    rvm install 1.9.2

### First time setup

Grab the source

    git clone git@github.com:pithyless/photodeco.git
    
Fetch all dependencies

    cd photodeco
    bundle install

On Linux an additional step is required:

    sudo apt-get install libpq-dev

Setup up your databases

    rake db:create:all
    rake db:migrate:all
    rake db:test:prepare


### Start hacking

Run the localhost rails server and specs:

    guard

Make changes in small, self-contained commits. Use branches for bigger projects.
    
    git commit -m 'small and useful commit'

## Deploy to production

Check for any changes

    git pull

Run the test suite

    rake spec

Push to GitHub

    git pull
    git push

Politely ask the server to redeploy :)

    cap deploy:migrations

## Profit!

TODO: Work in progress
