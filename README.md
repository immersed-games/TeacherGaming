# TeacherGaming
TeacherGamingRuby is a Ruby wrapper for TeacherGaming's HTTP API. It dynamically generates API objects from json definitions in `lib/teacher_gaming/api_definitions`.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'teacher_gaming_ruby'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install teacher_gaming_ruby
```


Finally, run
```bash
$ bundle exec teacher-gaming install
```
This will generate an initializer where you can set your API key and the desired API version (not really relevant right now since there's only one available version).


## Usage
This wrapper organizes TeacherGaming's API into discrete objects where the actual API calls are made via methods. Each object's methods exist on both an instance and a class level depending on whether or not statefulness is desired. For example,

```ruby
TeacherGaming::Session.create(studentid: 'mystudentid', classid: 'myclassid')         #=> TeacherGaming::Response object
```
is equivalent to
```ruby
session = TeacherGaming::Session.new(studentid: 'mystudentid', classid: 'myclassid')  #=> TeacherGaming::Session object
session.create                                                                        #=> TeacherGaming::Response object
```

Some requests can be given an arbitrary number of attributes like the Event endpoints. Their corresponding objects can similarly receive and hold an arbitraty number of attributes:
```ruby
event = TeacherGaming::Event.new(studentid: 'mystudentid', classid: 'myclassid', eventname: 'LevelCompletion', levelid: 4)         #=> TeacherGaming::Event object
event.levelid       #=> 4
event.create        #=> TeacherGaming::Response object
```

Full object definitions are stored in lib/teacher_gaming/api_definitions/v\*.json files.

See TeacherGaming's HTTP documentation for more info [here](https://teachergaming.github.io/slate/#manual-integration-and-http-api7.).

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
