# G5 Client Hub

- Seeds client from client uid
- Seeds default website for each location
- Gardens provide components that make up websites and web pages
- Page builder allows for customization of web pages
- Websites compile and deploy to Heroku
- Read's configurator's feed and updates sibling applications


## Setup

1. Install all the required gems.

    ```bash
    $ bundle
    ```

1. Customize client ENV variable __or don't__. Format is shown.

    ```bash
    $ export G5_CLIENT_UID=http://g5-hub.herokuapp.com/clients/:client-urn
    ```

    Default is `spec/support/client.html` and is set in
    `config/initializers/env.rb`.

    __ProTip™:__ The client uid will be used to seed the database so it must
    to point to an html file that uses microformats to mark up a client and
    their locations.

1. Set up your database.

    ```bash
    $ rake db:setup
    ```

    [rails-default-database](https://github.com/tpope/rails-default-database)
    automatically uses sensible defaults for the primary ActiveRecord database.

    __ProTip™:__ If you have trouble in development try running `bundle --without
    production` before `rake db:setup`.

1. Customize garden ENV variables __or don't__. Defaults are shown.

    ```bash
    $ export LAYOUT_GARDEN_URL=http://g5-layout-garden.herokuapp.com
    $ export THEME_GARDEN_URL=http://g5-theme-garden.herokuapp.com
    $ export WIDGET_GARDEN_URL=http://g5-widget-garden.herokuapp.com
    ```

    Defaults are set in `config/initializers/env.rb`.

1. Run the specs.

    ```bash
    $ rake db:test:prepare
    $ rspec
    ```

1. Start the application.

    ```bash
    $ rails s
    ```


### Client Location Deployment

1. [Create a new private key and add it to
   Github.](https://help.github.com/articles/generating-ssh-keys)

1. [Also add your private key to
   Heroku.](https://devcenter.heroku.com/articles/keys)

1. Set ENV variables.

    ```bash
    $ export HEROKU_APP_NAME=g5-ch-default
    $ export HEROKU_USERNAME=your-username
    $ export HEROKU_API_KEY=your-api-key
    $ export ID_RSA=your-private-key
    ```

1. Install [redis](http://redis.io/) and start it.

1. Start the job queue.

    ```bash
    $ rake jobs:work
    ```


## CSS Naming Conventions

Most CSS will go inside the modules folder. A module is simply a reusable chunk
of CSS. To create a new module do the following:

1. Create a new file inside the modules folder. It should start with an
   underscore and contain the module name. Example: `_panel.css.scss`
1. The module name is the base class, which contains the basic styles for the
   module. Example: `.panel`
1. If there are multiple words in the base class, use dashes. Example:
   `.my-panel`
1. Any component, or part, of the module is a sub-module. The class should be
   the module name, a dash, and the sub-module. Example: `.panel-title`,
   `.panel-footer`
1. For any alternate styles of the module the class should be module name, two
   dashes, and the alternate style name. Example: `.panel--b`, `.panel--large`


## Authors

  * Jessica Lynn Suttles / [@jlsuttles](https://github.com/jlsuttles)
  * Bookis Smuin / [@bookis](https://github.com/bookis)
  * Chris Stringer / [@jcstringer](https://github.com/jcstringer)
  * Michael Mitchell / [@variousred](https://github.com/variousred)
  * Jessica Dillon / [@jessicard](https://github.com/jessicard)
  * Chad Crissman / [@crissmancd](https://github.com/crissmancd)


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

Run once.

```bash
$ rspec
```

Keep them running.

```bash
$ guard
```

Coverage.

```bash
$ rspec
$ open coverage/index.html
```


## Model & Controller Diagrams

The [railroady](https://github.com/preston/railroady) gem generates Rails model
and controller UML diagrams as cross-platform .svg files, as well as in the DOT
language.

```bash
$ brew install graphviz
$ rake diagram:all
$ open doc/*.svg
```
