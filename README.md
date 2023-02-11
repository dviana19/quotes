# Quotes App - Rails 7 and hotwire


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
