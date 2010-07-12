require 'rubygems'
require 'yaml'
require 'rack/jekyll'

use Rack::ShowExceptions
use Rack::Lint
run Rack::Jekyll.new
