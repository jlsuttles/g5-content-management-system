# G5 Client Hub

* Consumes gardens's feeds
* Creates and deploys location sites
* Consumes configurator's feed
* Updates a client hub deployer


## Setup

1. Install all the required gems.
```bash
$ bundle
```

1. Set up your database.
[rails-default-database](https://github.com/tpope/rails-default-database)
automatically uses sensible defaults for the primary ActiveRecord database.
```bash
$ rake db:setup
```


### Optional: To Seed a Client from the G5 Hub

In the previous step `$ rake db:setup` seeds a client from `spec/support/client.html`. If you want to seed a different client, this is what you do.

1. [Find a client UID on the g5-hub.](http://g5-hub.herokuapp.com)
It should look like: http://g5-hub.herokuapp.com/clients/g5-c-*

1. Export the client UID and run the rake task.
```bash
$ export G5_CLIENT_UID=found_client_uid
$ rake seed_client
```


### Optional: To Deploy Location Sites to Heroku

1. [Create a new private key and add it to Github.](https://help.github.com/articles/generating-ssh-keys)

1. [Add your private key to Heroku.](https://devcenter.heroku.com/articles/keys)

1. Export environment variables.
```bash
export G5_CLIENT_UID=client_uid
export HEROKU_USERNAME=your_username
export HEROKU_API_KEY=your_api_key
export ID_RSA=your_private_key
# HEROKU_APP_NAME is only needed in production for dyno autoscaling
export HEROKU_APP_NAME=g5-ch-*
```

1. Install [redis](http://redis.io/) and start it.
```bash
$ brew install redis
$ redis-server > ~/redis.log &
```

1. Use foreman to start the web and worker proccesses.
```bash
$ foreman start
```
Or if you are using pow or something start the job queue.
```bash
$ rake jobs:work
```


## Authors

  * Jessica Lynn Suttles / [@jlsuttles](https://github.com/jlsuttles)
  * Bookis Smuin / [@bookis](https://github.com/bookis)


## Contributing

1. Fork it
1. Get it running
1. Create your feature branch (`git checkout -b my-new-feature`)
1. Write your code and **specs**
1. Commit your changes (`git commit -am 'Add some feature'`)
1. Push to the branch (`git push origin my-new-feature`)
1. Create new Pull Request

If you find bugs, have feature requests or questions, please
[file an issue](https://github.com/g5search/g5-client-hub/issues).


## Deploy Topic Branch to Heroku

The Heroku Fork plugin copies over addons, database, and config vars.

```bash
$ heroku plugins:install https://github.com/heroku/heroku-fork
$ heroku fork -a g5-client-hub g5-ch-my-new-feature
$ git remote add g5-ch-my-new-feature git@heroku.g5:g5-ch-my-new-feature.git
$ git push g5-ch-my-new-feature my-new-feature:master
```


## Specs

Run once.
```bash
$ rspec spec
```

Keep them running.
```bash
$ guard
```

Coverage.
```bash
$ rspec spec
$ open coverage/index.html
```
