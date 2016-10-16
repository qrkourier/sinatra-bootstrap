$:.unshift File.expand_path("../", __FILE__)

require_relative "application.rb"

map '/assets' do
  environment = Sprockets::Environment.new
  environment.append_path 'assets/javascripts'
  environment.append_path 'assets/stylesheets'
  # environment.js_compressor = Uglifier.new(:copyright => false)
  # environment.css_compressor = YUI::CssCompressor.new
  run environment
end

map '/' do
  run Application
end

