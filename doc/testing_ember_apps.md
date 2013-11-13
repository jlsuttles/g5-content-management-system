# [Testing Ember Apps by Jo Liss](http://www.slideshare.net/jo_liss/testing-ember-apps)

## Part 1: Full-Stack Integration Tests with Capybara*

* Note: We are using Capybara.

- Powerful because they can test the whole stack.
- Painfully slow because of the architecture.
- Only test one happy path for each model to ensure DB data
  ends up in DOM and vice versa.

## Part 2: Client-Side Integration Tests with Konacha*

* Note: We are using Teaspoon, not Konacha.

Client-side integration tests don't involve the backend, but
on the frontend, they exercise the entire Ember app.

- Not full stack.
- Fast because it limits the architectural complexity:
    - No backend server.
    - No DB. * Note: We use fixtures.
    - Tests run directly in the browser, not a separate process.

Avoid unit tests in Ember. The individual layers of an
Ember app are very simple. The important bit to test is
that they all play well together. Unit tests will keep
passing even when your app breaks.

## Ember Setup

* Note: Outdated

- Start app
- Tell router not to mess with the URL
- Before each test, transition back to the root state. * Note:`App.reset()`
- Reset store
- Ember automatically schedules runloops with setTimeout,
  but setTimeout is the enemy of deterministing tests. So
  we disable automatic runloop creation by enabling the
  Ember.testing flag. This should be set before loading
  your app modules.
- It's okay to have Em.run everywhere. Most actions have
  their effects deferred to the end of the runloop. In test
  code you need the effects immediately, so you wrap things
  in Ember.run.

## Model Fixtures

Probably the trickiest thing.

1. Client-side fixtures with Ember's FixtureAdapter
    - + Easy
    - - Goes out of sync with backend
    - - Fragile
    - - Server-side computer attributes
2. Server-side fixtures with rake test:fixtures
    1. Write fixtures to DB
    2. Generate JSON to fixtures.js and load through RESTAdpater
        - + Covers models, serializers, adapter
        - + Easy to maintain
        - - Usability
        - - Complex to set up
            - You end up with some custom code and it ties
              tightly into the backend.
3. Want global fixtures like FactoryGirl but not there yet.
