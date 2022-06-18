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

To find unreachable actions run below command. unreachable actions are those actions where actions are defined in controllers but their routes are missing in routes.rb file.
```ruby
RouteChecker::Result::unreachable_actions
```
To find unused routes run below command. unused route are those routes where path is defined in routes.rb file but their actions are not defined in the controllers.
```ruby
RouteChecker::Result::unused_routes
```
To find uninitialized controllers run below command. uninitialized controllers are those controllers where paths are defined in routes.rb file but the controllers itselfs are missing.
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

## Important Note
Whenever changes are made to rails project then from rails console run `reload!` command so that changes will be pick up by route_checker gem.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
