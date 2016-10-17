#!/usr/bin/env ruby

#
# slurp some XML over HTTP and parse to find equivalent domain
# names for the Stack Exchange network of sites
#
# shell $ gem install xml-simple domainatrix
#
# tested with >= Ruby 1.9.2
#
#

# stdlib
require 'net/http'
# gems
require 'rubygems'
require 'xmlsimple'
require 'domainatrix'
require 'pry'
require './application'

domains = []

# get the list of SE sites from their XML feed
feed = 'http://stackexchange.com/feeds/sites'
doc = Net::HTTP.get_response(URI.parse(feed)).body

# parse the document to compose a data object
data = XmlSimple.xml_in(doc)

# iterate over each id in the entry array and join the top-level and
# registrar-assigned domain names, discarding the subdomain and path parts, and
# push the result into an array
data['entry'].each do |entry|
  url = Domainatrix.parse(entry["id"][0])
  domains << url.domain + "." + url.public_suffix
end

ActiveRecord::Base.establish_connection(
  :adapter   => 'postgresql',
  :database  => 'stackdom'
)

# for each unique domain name create a record in the domains table in the list
# column unless it already exists; the Domains model in application.rb
# validates_uniqueness_of the record
domains.uniq.each do |domain|
  #binding.pry
  Domains.create(:list => domain)
end

# print a comma-separated list of unique domain names
#puts domains.uniq * ","
