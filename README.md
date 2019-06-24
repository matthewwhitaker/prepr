# Prepr

This is a site for users to store recipes to use later, and discover new recipes posted by other users.

## Application structure

The program is made up of:
* Model - Ruby with [PostgreSQL](https://www.postgresql.org/) database. These can be found in the `lib` directory, with database migration files in the `db` directory.
* Controller - Ruby with [Sinatra](http://sinatrarb.com/) framework. This can be found in the `app.rb` file in the root directory.
* View - erb, HTML & CSS. These can be found in the `views` directory. The site has a primary template - `application.html.erb` which handles the navbar, scripts and messages to the user - with other components yielded within this template.

## Testing

Unit testing is handled in [Rspec](https://rspec.info/), with feature testing in [Capybara](https://github.com/teamcapybara/capybara).

Test coverage is measured using [Simplecov](https://github.com/colszowka/simplecov).

Once the application is set up (see below), tests can be run using the command `rspec` from the terminal. Test coverage will automatically be generated and presented.

Code quality is tested using the [Rubocop](https://github.com/rubocop-hq/rubocop) linter.

## How to set up the application

Before running the application a few short set-up steps are required.

### Set up the databases

You'll need to have PostgreSQL installed. If you have Homebrew, you can do this by running `brew install postgresql` from the terminal. Start PostgreSQL by running `brew services start postgresql`.

In the terminal use the command `psql` to start interacting with PostgreSQL.

To set up the databases for development and testing environments run these commands in the terminal window you have open:
* `CREATE DATABASE prepr;`
* `CREATE DATABASE prepr_test;`

Before running the application, set up the development database. Connect to it by running `\c prepr;`. Next run the contents of the files in the `db/migrations` directory. If there's more than one, run them in order (e.g. '01_...', then '02_...').

All done - the tables for the test database will be set up automatically during testing.

### Install gems

From a terminal in the root directory run `gem install bundler` to install bundler, if you don't have it already. Then run `bundle install` to install the necessary gems.

That's it - ready to run the application.

## Running the application

From the root directory use the terminal command `rackup` to run the application locally, and visit [`http://localhost:9292`](http://localhost:9292) in a browser.

## User stories

Work on this project is still on-going, here's the user stories I'm focusing on.

### Completed:

* `As a user, so that I can choose a recipe to cook, I want to see all recipes on the homepage`
* `As a user, so that I can remember a recipe for future, I want to add a new recipe to the site`
* `As a user, so that I can update a recipe for future, I want to edit a recipe I previously added`
* `As a user, so that I don't see recipes I don't want any more, I want to be able to delete a recipe I previously added`
* `As a user, so that I can post recipes as me, I want to register with my username`
* `As a developer, so I am securing information, I want to encrypt user passwords`
* `As a developer, so that users can't edit each others recipes, I want them to be logged in before editing content`
* `As a developer, so that users register with the right information, I want them to be unable to submit a blank username`
* `As a developer, so that users register with the right information, I want them to be unable to submit a blank password`
* `As a developer, so that users register with the right information, I want them to be have to submit a valid email`

### Yet to be completed:

* `As a developer, so that I keep my code clean and lean, I want to use an ORM for my databases`
* `As a developer, so that there's no confusion between users, I want to ensure each email is unique on sign up`
* `As a developer, so that users can interact with my application for real, I want to host it on Heroku`
* `As a developer, so that nothing breaks when deploying, I want to integrate CodeShip with my application`
* `As a user, so I can see well structured information, I want to add ingredients and instructions in separate fields`
* `As a user, so I can refer back to the original recipe, I want to be able to add a link to the original recipe (if there is one)`
* `As a user, so I can find recipes to cook with ingredients I already have, I want to be able to search for content in the existing recipes on the site`
* `As a user, so that I can let other people know what I thought of their recipe, I want to give it a numerical rating`
* `As a user, so that I can pick popular recipes, I want to see the average score of each recipe`

## Other frameworks

* Encryption of passwords is done using [bcrypt](https://rubygems.org/gems/bcrypt/versions/3.1.12)
