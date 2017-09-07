# TeacherGaming
TeacherGaming is an unofficial Ruby wrapper for TeacherGaming's HTTP API. It dynamically generates API objects from json definitions in `lib/teacher_gaming/api_definitions`.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'teacher_gaming'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install teacher_gaming
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
event = TeacherGaming::Event.new(studentid: 'mystudentid', classid: 'myclassid', eventname: 'LevelCompletion', levelid: 4)  #=> TeacherGaming::Event object
event.levelid                                                                                                               #=> 4
event.create                                                                                                                #=> TeacherGaming::Response object
```

Full object definitions are stored in lib/teacher_gaming/api_definitions/v\*.json files.

See TeacherGaming's HTTP documentation for more info [here](https://teachergaming.github.io/slate/#manual-integration-and-http-api7.).

## Todo
- Testing strategies to help catch and prevent typos in the json definition files
- Implement the "type" attribute (HTTP request type, ie something other than just "get") for object method definitions
- Turn the "params" attribute for object methods into "required_params" or something. Right now "params" isn't used anywhere.

## Contributing
If you wish to further develop this gem, clone the repo and copy `spec/dummy/config/secrets.example.yml` to `spec/dummy/config/secrets.yml`. Fill in the keys and ids with whatever you normally use to test with. The values can be accessed in your specs with `test_api_key`, `test_student_id`, and `test_class_id`.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
