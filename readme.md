# makan.io

This web app will serve as the online food delivery platform of Running Man Food Delivery.

## Requirements

- Ruby 2.2.0
- Postgresql 9.4

## Setting up

```sh
# for osx: make sure these are installed
brew install imagemagick

# for ubuntu:
sudo apt-get install imagemagick libmagickwand-dev

# clone this repo
git clone git@bitbucket.org:makanio/makanio.git makan

# go into postgres and create the db users
psql
  create role makanio with password 'makanio';
  create role makaniotest with password 'makaniotest';
  alter role makanio with createdb;
  alter role makaniotest with createdb;
  \q

# go into repo and install dependencies
cd makan
bundle install --jobs 7
# see: https://robots.thoughtbot.com/parallel-gem-installing-using-bundler

# create database (not tested yet)
rake db:create # for development
rake db:create RAILS_ENV=test

# migrate to test dev db
rake db:migrate

# rspec to test test db
rspec

# start server and start developing!
rails s
```
