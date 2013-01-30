# G5 Client Hub

* Creates and deploys location sites
* TODO:
    * Consumes configurator's feed
    * Updates a client hub deployer


## Setup

1. Install all the required gems
```bash
bundle
```

1. Set up your database.
[rails-default-database](https://github.com/tpope/rails-default-database)
automatically uses sensible defaults for the primary ActiveRecord database.
```bash
rake db:setup
```

1. Install [redis](http://redis.io/) and start it
```bash
brew install redis
redis-server > ~/redis.log &
```

1. Create a new private key and add it to Github and Heroku
    * [https://help.github.com/articles/generating-ssh-keys](https://help.github.com/articles/generating-ssh-keys)
    * [https://devcenter.heroku.com/articles/keys](https://devcenter.heroku.com/articles/keys)


1. Export environment variables
```bash
export HEROKU_USERNAME=your_username
export HEROKU_API_KEY=your_api_key
export ID_RSA=your_private_key
export HEROKU_APP_NAME=g5-ch-* # this is only needed in production
```

1. Use foreman to start the web and worker proccesses
```bash
foreman start
```
Or if you are using pow or something start the job queue
```bash
rake jobs:work
```

1. Seed a Client
```bash
G5_CLIENT_UID=http://g5-hub.herokuapp.com/clients/g5-c-685e4rp-moo-man rake seed_client
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

## Specs

```bash
guard
```
