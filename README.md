Setup environment
==================

Install gems

````
$ bundle install
````

Create database

````
$ rake db:create
````

Run migrations

````
$ rake db:migrate
````

Import seed data

````
$ rake db:seed
````

Start the development solr server for support messaging system

````
$ rake sunspot:solr:run
````