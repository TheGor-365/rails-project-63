# HexletCode

![CI](https://github.com/TheGor-365/rails-project-63/blob/main/.github/workflows/main.yml/badge.svg)
![CI](https://github.com/TheGor-365/rails-project-63/blob/main/.github/workflows/hexlet-check.yml/badge.svg)

## Summary

This gem generates tags and attributes for HTML forms. It helps backend developers do they job faster.

## Installation

Add this line to your application's `Gemfile`:

```ruby
gem 'hexlet_code'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install hexlet_code

## Usage

The gem contains the `build('your_tag', some_attr: 'attr_value') { block }` method, which generates clean HTML. Use next methods for
```ruby
require 'rails-project-63'

form = HexletCode::Tag.build('form', action: "action_page/:id", method: "post") { 'Something' }
puts form #=> <form action='action_page/:id' method='post'>Something</form>
```

You can get `paired tags`:

```ruby
HexletCode::Tag.build('div', class: 'text-muted') { 'Hello' } #=> <div class='text-muted'>Hello</div>
```

You can get `unpaired tags`:

```ruby
HexletCode::Tag.build('img', src: 'some/path', alt: 'avatar') #=> <img src='some/path' alt='avatar'>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run:
```
$ gem install specific_install && gem specific_install -l https://github.com/TheGor-365/rails-project-63
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/hexlet_code. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/hexlet_code/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the HexletCode project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/hexlet_code/blob/master/CODE_OF_CONDUCT.md).
