# makan.io

[![CircleCI](https://circleci.com/gh/anonoz/makan.io.svg?style=svg)](https://circleci.com/gh/anonoz/makan.io) [![Code Climate](https://codeclimate.com/github/anonoz/makan.io/badges/gpa.svg)](https://codeclimate.com/github/anonoz/makan.io)

## Requirements

- Ruby 2.4.0
- Postgresql 9.4

## Setting up

```sh
# for osx: make sure these are installed
brew install imagemagick

# for ubuntu:
sudo apt-get install imagemagick libmagickwand-dev

# clone this repo
git clone git@bitbucket.org:makanio/makanio.git makan

# osx: go into postgres and create the db users
psql
  create role makanio with password 'makanio' login createdb;
  create role makaniotest with password 'makaniotest' login createdb;
  \q
# in linux, may need to run `sudo su postgres` before psql

# go into repo and install dependencies
cd makan
bundle install --jobs 3
# see: https://robots.thoughtbot.com/parallel-gem-installing-using-bundler

# create databases
rake db:create

# migrate to test dev db
rake db:migrate

# rspec to test test db
rspec

# start server and start developing!
rails s
```
