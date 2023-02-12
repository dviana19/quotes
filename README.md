# Quotes App - Rails 7 and hotwire
[Hotwire](https://hotwired.dev/) is amazing. It took all the good things Rails already did and improved it into a technique that allows you to write little(sometimes none) Javascript.

That's great for developers that want to write their full stack application but don't want to have trouble writing or learning React/Typescript/Vue and the whole modern stack frontend developers use these days.

Real time updates with turbo-stream which abstracts all the javascript part from Action Cable and turbo-frames for replacing only parts of pages gives your rails application the look and feel of any other app writen in React or any JS library.

So, give it a chance and try it yourself to build something with it.
###### Following the tutorial:
I wrote this application based on this [tutorial](https://www.hotrails.dev/turbo-rails) with some changes that combined serve as the foundation for all my Rails projects.
###### First, the changes:
I used [Rspec](https://github.com/rspec/rspec-rails) as a test framework instead of Mini-test and I wrote a small class to dry-up a the controller responses. Normally I use the [responders gem](https://github.com/heartcombo/responders) for this, but somehow it's not working with flash messages and turbo stream response format.
###### Now, let me walk you through the foundation:
1. [Docker](https://www.docker.com/products/docker-desktop/). I always use docker no matter what. If you get my laptop the only thing installed is a docker desktop application. Nothing else, no database, no programing language, nothing. Even when I need to run one ruby script, I use docker. [Follow this tutorial](https://github.com/docker/awesome-compose/tree/master/official-documentation-samples/rails/) for docker and rails quick start.
1. [Devise Gem](https://github.com/heartcombo/devise) for user management, including login, registration, forget the password, and so on.
1. [Simple Form gem](https://github.com/heartcombo/devise) plays nice with devise so you can build forms with ease. You set up one time and all your forms will be ready to reuse throughout the whole application.
1. [Rspec gem](https://github.com/rspec/rspec-rails) for tests. Nothing against the default rails test framework, but I feel much more productive with Rspec. Along with it, I also use [shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers), [faker](https://github.com/faker-ruby/faker), [factory_bot_rails](https://github.com/thoughtbot/factory_bot_rails), and [rspec-its](https://github.com/rspec/rspec-its).
1. [Rubocop](https://github.com/rubocop/rubocop-rails). It helps me write better quality code and once you use it's hard to go back.
1. [Dotenv-rails](https://github.com/bkeepers/dotenv) for better management of environment variables.
1. [Simplecov](https://github.com/simplecov-ruby/simplecov) for checking if I'm covering at least 90% of the project with tests.
##### One note about tests:
Normally I write tests for all models trying to cover all possible edge cases.

Then I write [feature](https://relishapp.com/rspec/rspec-rails/docs/feature-specs/feature-spec) tests using capybara which also acts as integration and end 2 end tests. If I'm writing an API-only application then I favor [requests](https://relishapp.com/rspec/rspec-rails/v/6-0/docs/request-specs/request-spec) tests. Do not write controller tests. Favor always features or requests over controller tests.

### Prerequisites

1. Install docker
### Running using docker

1. Everything is set, just run spin up the container.
```bash
docker compose run --rm web bash rails db:prepare
docker compose up
```
### Tests

You can run the tests using rspec:
![Tests](https://github.com/dviana19/quotes/actions/workflows/test-action.yml/badge.svg)
![Linting](https://github.com/dviana19/quotes/actions/workflows/linting.yml/badge.svg)

```bash
docker compose run --rm web bash bundle exec rspec
```
## Deployment

This version is not deployed anywhere but you can see how it is supposed to work [here](https://www.hotrails.dev/quotes).
