# Server Status

[![Build Status](https://travis-ci.org/shopkeep/server_status.png)](https://travis-ci.org/shopkeep/server_status)

Mount a Rack application, that will act as a health check that ELB, Varnish, etc can use to verify that the application is healthy

## Installation

Add this line to your application's Gemfile:

    gem 'server_status'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install server_status

## Usage

In `config/routes.rb`:

    mount ServerStatus::Engine => "/server-status"

cURL the mounted endpoint:

    curl http://localhost:3000/server-status

    HTTP/1.1 200 OK
    up 48699 1.14 192.168.50.206

As JSON:

    curl -H "Accept: application/json" http://localhost:3000/server-status

    HTTP/1.1 200 OK
    {"database":"up","pid":52509,"uptime":1.16,"ip_address":"192.168.50.206"}

## Requirements

* Ruby 2.0.0-p247

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
