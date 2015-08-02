# U.S. Vote Foundation API

This is the home of the 2015 [Ruby for Good](http://rubyforgood.com/) project to create a State Voter Information API for the [U.S. Foundation](https://www.usvotefoundation.org/).

The aim of this application is to take data from the already existing US Vote State Voting Requirements directory, Election Dates and Deadlines and Voting Methods and Options databases and make it available to other voter outreach organizations and even states via a REST API. 

## Getting Started:

    bundle install
    rake db:create db:migrate

## Contributing:

Branch off of master:

    git checkout -b <name of your feature branch>

Make changes, commit, then push your changes.

    rake db:migrate

    git push origin <name of your feature branch>

Submit PR into master.


