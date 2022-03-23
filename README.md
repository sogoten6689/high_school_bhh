# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation
    * rails generate migration UserTestsTable*

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# Heroku
##  View logs 
* heroku login
* heroku logs
* heroku run db:migrate

## migrattion

* rails db:create
* rails db:migrate
* rails db:seed
roll back
* rails db:migrate Version=0
* rake db:migrate VERSION=0.

# reset db
* rails db:reset db:migrate db:seed

# command pending

* bundle exec rake rails:update:bin

# webpack
* heroku buildpacks
* rake assets:precompile RAILS_ENV=production
* bundle exec bin/webpack-dev-server
* rake assets:precompile

# reset last commit
* git reset HEAD~    
