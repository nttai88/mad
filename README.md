Setup environment
==================

Install gems

````
$ bundle install
````

Create database

````
$ bundle exec rake db:create
````

Run migrations

````
$ bundle exec rake db:migrate
````

Import seed data

````
$ bundle exec rake db:seed
````

Start the development solr server for support messaging system

````
$ rake sunspot:solr:run
````

Run tests
===========

Copy a scheme from development DB to test DB

````
$ bundle exec rake db:test:prepare
````

Run tests

````
$ bundle exec rake spec
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

If you have already had an app on heroku (git@heroku.com:madlab.git), go to the app folder and run the following command

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

How to use Amazon S3 for storage in development mode
==================

Add unix variables

````
$ export S3_KEY=AKIAJTQFZ4U56OEW33WQ
$ export S3_SECRET=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
$ export S3_BUCKET=madlab.development
````

Change s3 config on /config/environments/development.rb

````ruby
  config.s3_backend = true
````

## Git Flow

[To install Git Flow](https://github.com/nvie/gitflow)

Read more at [A successful Git branching model](http://nvie.com/posts/a-successful-git-branching-model/). 

## Git Flow Init

If you try to list features:

`git flow feature` 

and get "fatal: Not a gitflow-enabled repo yet. Please run 'git flow init' first." 
Go ahead and run as directed. You'll be presented with a few options. Here's the output.

    Which branch should be used for bringing forth production releases?
       - cleanup_views
       - develop
       - master
    Branch name for production releases: [master] 

    Which branch should be used for integration of the "next release"?
       - cleanup_views
       - develop
    Branch name for "next release" development: [develop] 

    How to name your supporting branch prefixes?
    Feature branches? [feature/] 
    Release branches? [release/] 
    Hotfix branches? [hotfix/] 
    Support branches? [support/] 
    Version tag prefix? [] 

    Now if you run:
 
    `git flow feature`

    You should see: 

    No feature branches exist.

    You can start a new feature branch:

        git flow feature start <name> [<base>]

## Features

To list, start or finish a feature:

`git flow feature`

`git flow feature start <feature_name> [<base>]`

`git flow feature finish <feature_name>`

For feature branches, the "base" arg must be a commit on develop.

## Hotfixes

To list, start or finish a hotfix:

`git flow hotfix`

`git flow hotfix start <hotfix_name> [<base>]`
  
`git flow hotfix finish <hotfix_name>`

For hotfix branches, the "base" arg must be a commit on master.

## Following Git Flow Manually

### Creating a New Feature:

When creating new features start with the develop branch.

`> git checkout -b new_feature develop`

Work on the new feature and commit changes as usual.

### Finishing a New Feature

`> git checkout develop`

`> git merge --no-ff new_feature`

Delete the feature branch

`> git branch -d new_feature`

`> git push origin develop`

The --no-ff flag causes the merge to always create a new commit object, even if the merge could be performed with a fast-forward. This avoids losing information about the historical existence of a feature branch and groups together all commits that together added the feature.

### Creating a Hotfix

When creating a hotfix, start with the master branch.

`> git checkout -b new_hotfix master`

Work on the hotfix and commit changes as usual.

### Finishing a Hotfix

First deal with master.

`> git checkout master`

`> git merge --no-ff new_hotix`

Next include the fix in develop.

`> git checkout develop`

`> git merge --no-ff new_hotfix`

Then remove the hotfix branch

`> git branch -d new_hotfix`
