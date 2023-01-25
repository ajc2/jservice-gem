# Jservice

This gem provides bindings to the HTTP REST API hosted at [jService](https://jservice.io). This is a simple 1 to 1 API binding, nothing extra like caching is provided.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jservice'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install jservice

## Usage

### 1. Create Jservice class
```ruby
js = Jservice.new(
  # base URL of API
  url: 'jservice.io',
  # use https
  use_ssl: true,
  # port to use for API (`nil` for default)
  port: nil
)
```
All hash options are optional and will use the default values if not given. 99% of the time, you just want `Jservice.new()`.

### 2. Get a page of clues
```ruby
clues = js.clues(
  # value of clue (100-1000 or nil for Final Jeopardy)
  value: 100,
  # ID of category you want
  # you'll likely want to use `categories` to find these
  category: 0,
  # specify a range of dates for clues
  min_date: "1993-11-17T20:00:00.000Z"
  max_date: "1993-11-20T20:00:00.000Z"
  # offset of returned clues. used for paginating results
  offset: 0
)
```
`Jservice#clues` returns an array of clue objects as Hashes (with String keys.) As before, all options are optional and if not given the server will use whatever defaults. The clues are returned in a fixed order (evidently most recently added to the database.)

Example clue output (JSON):

```json
{
  "id": 35885,
  "answer": "Madagascar",
  "question": "Extinct for hundreds of years, the elephant bird weighed 1,000 pounds & lived on this east African island",
  "value": 500,
  "airdate": "1993-11-17T20:00:00.000Z",
  "created_at": "2022-12-30T18:52:26.957Z",
  "updated_at": "2022-12-30T18:52:26.957Z",
  "category_id": 109,
  "game_id": 1411,
  "invalid_count": null,
  "category": {
    "id": 109,
    "title": "animals",
    "created_at": "2022-12-30T18:37:49.289Z",
    "updated_at": "2022-12-30T18:37:49.289Z",
    "clues_count": 536
  }
}
```

### 3. Get random clues
```ruby
clues = js.random_clues(5)
```
`Jservice#random_clues` returns `count` random clues from the API. Notably, this endpoint does **not** support any kind of search parameters.

### 4. Get random Final Jeopardies
```ruby
clues = js.random_finals(5)
```
`Jservice#random_finals` returns `count` random Final Jeopardies from the API.
Notably, this endpoint does **not** support any kind of search parameters.

### 5. Get a list of categories
```ruby
cats = js.categories(
  # number of categories
  count: 1,
  # offset of returned categories. used for paginating results
  offset: 0
)
```
`Jservice#categories` is similar to `clues`. It returns a list of categories from the server (seemingly in most-recently-added order.) Both options are optional.

Category object example (JSON):

```json
{
  "id":68,
  "title": "gardens",
  "clues_count": 18
}
```

### 6. Get a specific category by ID
```ruby
cat = js.category(68)
```
`Jservice#category` returns a specific category given its ID

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ajc2/jservice-gem.
