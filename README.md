# Quake Logs Parser

## Techonologics used at this project

* Ruby
* Bundler

* Faker
* RSpec

* Rubocop
* Solargraph

## To start this project

* You can run this project through these commands line with docker-composer

  ```bash
  docker-compose build
  docker-compose up
  ```

OR

* You can run this project through these cammands line with docker

  ```bash
  docker build -t ruby-quake-logs:latest .
  docker run -it ruby-quake-logs:latest
  ```

OR

* If you would be installed ruby your computer, you'll follow this staps to run this project

  1. You'll need to install the bundler gem and if you don't have it installed on your computergem install bundler

     ```bash
     gem install bundler
     ```
  2. After install the gem bundler, you need to run this command

     ```
     bundler install
     ```
  3. After install the dependence this project, you can run this command

     ```
     ruby bin/quake_logs.rb
     ```

     OR

     1. You can run this project through with this command line

        ```
        sh bin/start.sh
        ```

## Documentation this project

Exists a folder in this project with called documentation. In this folder exist the file called `documentation.md`, this documentation describe all specification about this project and exists a file called qgames.log this file it's used to run this project at this folder. It's contains all games log from Quake 3 Arena.
