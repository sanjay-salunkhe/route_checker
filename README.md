# RouteChecker
route checker gem helps to find unused routes and unreachable actions in rails application.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'route_checker'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install route_checker

## Usage

Open rails console
```ruby
rails console
```
and then

To find unreachable actions
```ruby
RouteChecker::Result::unreachable_actions
```
To find unused routes
```ruby
RouteChecker::Result::unused_routes
```
To find uninitialized controllers
```ruby
RouteChecker::Result::uninitialized_controllers
```
To print all result in single command
```ruby
RouteChecker::Result::print
```
To save result to .txt file
```ruby
RouteChecker::Result::save_to('/Users/ssalunkhe','demo.txt','w+')
Or
RouteChecker::Result::save_to('/Users/ssalunkhe','demo.txt','a+')
```


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
