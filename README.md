# Picturefill

This is a Rails-Wrapper for picturefill.js: https://github.com/scottjehl/picturefill

## Installation

Add this line to your application's Gemfile:

    gem 'picturefill'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install picturefill

## Usage

Add this line to your application layout (asset-pipeline enabled)

    = javascript_include_tag 'picturefill.all'

Or w/o asset-pipeline, add these two lines:

    = javascript_include_tag 'matchmedia.min'
    = javascript_include_tag 'picturefill.min'

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
