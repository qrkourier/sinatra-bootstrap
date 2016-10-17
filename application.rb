
require 'sinatra'
require 'haml'
require 'sass'
require 'sprockets'
require 'uglifier'
require 'yui/compressor'
require 'active_record'
require 'pry'

class Domains < ActiveRecord::Base
  validates_uniqueness_of :list, :scope => :list
end

ActiveRecord::Base.establish_connection(
    ENV['DATABASE_URL'] || 'postgres://kbingham:asdf;lkj@localhost/stackdom'
)

class StackDomApp < Sinatra::Base
  #set :root, File.dirname(__FILE__)
  #set :logging, true

  get '/' do
    @lists = []
    @domains = Domains.all()
    @domains.each do |domain|
      @lists << domain['list']
    end
    haml :index
  end
end
