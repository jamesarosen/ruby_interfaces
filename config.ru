require 'rubygems'
require 'yaml'
require 'rack/jekyll'

app = Rack::Builder.new do
  use Rack::ShowExceptions
  map '/ruby_interfaces' do
    run Rack::Jekyll.new
  end
  lambda { |env|
    [404, {'Content-Type' => 'text/plain', 'Content-Length' => '10'}, 'Not found.']
  }
end

run app