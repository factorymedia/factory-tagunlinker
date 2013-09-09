# Factory::Tagunlinker

Remove dead tagged links from content

## Installation

Add this line to your application's Gemfile:

    gem 'factory-tagunlinker'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install factory-tagunlinker

## Usage

```ruby
unlinker = Factory::Tagunlinker.new("list","of","tags")
unlinker.file_name = "file.txt"
puts unlinker.unlink!
```

or
```ruby
unlinker = Factory::Tagunlinker.new("list","of","tags")
unlinker.text = File.read('file.txt').readlines
puts unlinker.unlink!
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
