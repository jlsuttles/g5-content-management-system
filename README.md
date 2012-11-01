# G5 Client Hub

* Creates and deploys location sites
* TODO: 
    * Consumes configurator's feed
    * Updates client hub deployer

## Setup

1. Install all the required gems
```bash
bundle
```

1. Set up your database
```bash
cp config/database.example.yml config/database.yml
vi config/database.yml # edit username
rake db:create db:schema:load db:seed
```


1. Create a new private key and add it to Github and Heroku
    * [https://help.github.com/articles/generating-ssh-keys](https://help.github.com/articles/generating-ssh-keys)
    * [https://devcenter.heroku.com/articles/keys](https://devcenter.heroku.com/articles/keys)


1. Export you environment variables wherever you do that:
```bash
export HEROKU_USERNAME=your_username
export HEROKU_API_KEY=your_api_key
export HEROKU_APP_NAME=static-sinatra-prototype
export HEROKU_REPO=git@heroku.com:static-sinatra-prototype.git
export GITHUB_REPO=git@github.com:G5/static-sinatra-prototype.git
export ID_RSA=your_private_key
```


## Authors

  * Jessica Lynn Suttles / [@jlsuttles](https://github.com/jlsuttles)


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

Set ENV variables
```
export PUBLIC_GITHUB_REPO=git@github.com:G5/static-sinatra-prototype.git
export PRIVATE_GITHUB_REPO=git@github.com:g5search/g5-client-location.git
```
