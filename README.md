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

Deploy to heroku
==================
To deploy the app to heroku, you must have a heroku account.

Install heroku gem

````
$ gem install heroku
````

Create an app on heroku if the app is not available on heroku

````
$ heroku create madlab --stack cedar
````
You can change madlab with your app name.

If the you have already had an app on heroku (git@heroku.com:madlab.git), goto the app folder and run the following command

````
$ git remote add heroku git@heroku.com:madlab.git
````

Run the following command whenever you want to deploy to heroku

````
$ git push heroku master #run this command on the first setup or when the code changed
````

Setup database

````
$ heroku run rake db:migrate #run this command on the first setup or when the database changed
$ heroku run rake db:seed #run this command on the first setup
````






