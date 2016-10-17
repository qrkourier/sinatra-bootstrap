
require 'sinatra'
require 'sass'
require 'haml'
require 'sprockets'
require 'uglifier'
require 'yui/compressor'
require 'active_record'
require 'pry'

class Gets < ActiveRecord::Base
end

class Domains < ActiveRecord::Base
  validates_uniqueness_of :list, :scope => :list
end

ActiveRecord::Base.establish_connection(
  ENV['DATABASE_URL'] || 'postgres://kbingham:asdf;lkj@localhost/stackdom'
)

class StackDomApp < Sinatra::Base
  #set :root, File.dirname(__FILE__)
  set :logging, true

  get '/' do
    # initialize a couple of empty lists
    @lists = []
    @timestamps = []
    # fetch the domains table as a relation
    @domains = Domains.all()
    # iterate over records and extract the domain names as strings and the
    # timestamps when they were last updated
    @domains.each do |domain|
      @lists << domain['list']
      @timestamps << domain['created_on']
    end
    # return the output of haml views/index.haml
    haml :index
  end
end
