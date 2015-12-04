# SimElevator

Simple simulation of a common elevator.

Simulates the behavior of a common elevator. Supports floors with unique codes and up/down buttons for calling the elevator from each floor.

## Usage

Run `bin/console` to drop into a Pry console with a default Elevator preloaded.

You can issue the following commands to the elevator:

* `floor` - Get the elevator's current `Floor` object
* `direction` - Get the elevator's current direction (`:up`, `:down` or `nil`)
* `add_floor(code)` - Add a new floor to the top of the building with the specified `code` (must be unique)
* `add_floor_above(base, code)` - Insert a new floor with the specified `code` above the `base` floor
* `add_floor_below(base, code)` - Insert a new floor with the specified `code` below the `base` floor
* `get_floor_by_code(code)` - Get the `Floor` object with the specified `code`
* `press_up_on(code)` - Press the up button on the floor with the specified `code`
* `press_down_on(code)` - Press the down button on the floor with the specified `code`
* `move(code)` - Move the elevator instantly to the floor with the specified `code`
* `step!` - Step the elevator once, moving either up, down or leaving it in place as needed
* `run!` - Run the elevator processing all the queued requests

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/attilahorvath/sim_elevator.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
