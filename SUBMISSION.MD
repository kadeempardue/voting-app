# Vote Music Festival

## Link: [https://votemusicfestival.com](https://votemusicfestival.com)

### How To Run Locally

It's a standard Rails app using Postgres so you'll just want to follow the readme instructions.

```sh
brew install postgresql@14
brew services start postgresql@14

bundle install

rails db:create
rails db:migrate
rails db:seed
```

The seed file creates two users (`attendee@example.com` and `fan@example.com` with `12345` as the zip code for both).

Password does not matter when logging in.

### Decisions

#### Database

I chose to swap out Sqlite for Postgres since I wanted to host the app on Heroku and since those instances are ephemereal (and reboot every 24 hours) this application required a production-grade persistent data storage.

#### Password

I added bcrypt to the Gemfile since passwords should be securely stored in a system and use encryption. It comes with the has_secure_password macro that handles validations out of the box so it's a good choice for Rails applications.

Authentication in the login form bypasses actually checking the password, however there is a comment in the SessionsController to show where that check would actually occur. Any password provided in the login screen will work (granted the email and zip code are valid in the system)

#### Specs

I added specs for the models and features (integration tests).

#### FactoryBot and Should Matchers

I added some pretty common gems so that Rspec can use factories instead of fixtures and some helpful validation matchers.

#### Capybara

I added some feature tests in Capybara (rather than request tests) which offers good integration and end-to-end tests. I enhanced the driver setup to run the driver in headless chrome (listed at the bottom of the `rails_helper.rb` file)

#### Architecture

Since the Rails app uses react-rails I figured I'd build all frontend components in React and of course leave the business logic and controller routing to the Rails application. I chose not to add react-router-dom which allows the frontend to navigate using hooks since it is not a purely React-only application. Thus `redirect_to` handles redirects where needed and often the frontend merely needs to reload the page via `window.location.reload()` or explicitly load the page it wants using `window.location.href=`.

I chose to implement a Serializer to showcase how to serialize data back to the frontend.

I chose to implement a VoteCreateService class to showcase encapsulated classes that handle specific or complex actions

I chose to implement a VotingBooth to ensure that only 1 user can vote at a time (within 30 seconds), and that they can only vote once. Visual badges are displayed in the header to indicate to users when the voting booth is open or in use.

I chose to use Bootstrap as my css framework of choice, specifically the react-bootstrap package which provides React based Bootstrap 4 components.
