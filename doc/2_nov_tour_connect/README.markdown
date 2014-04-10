TourConnect
=========

This code is based on Rails 3.1.0

Prerequisites
-------------
* bundler

**Note - TourConnect is using mongo, don't forget to start your mongo database server.**

    $ sudo mongod

Production Environment
----------------------
    $ git clone git@github.com:devfu/tour-connect.git
    $ cd tour-connect
    $ bundle install
    $ rake db:seed

Development / Test Environment
------------------------------
    $ git clone git@github.com:devfu/tour-connect.git
    $ cd tour-connect
    $ bundle install --without production staging ci
    $ rake db:seed

Tests
-----

Tests are written using factory girl, rspec, cucumber and capybara. Factories are located in **spec/factories.rb**. Model specs are located in **spec/models**. Integration specs are in **spec/requests** and **features/**.

To run the test suite:

    $ bundle exec rspec spec/ && bundle exec cucumber features/

Deployment
----------

*staging*

The staging server is hosted by heroku

    $ git push heroku # => deploy latest code
