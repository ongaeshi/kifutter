# -*- coding: utf-8 -*-

#DIR = File.dirname(__FILE__)
DIR = '/Users/ongaeshi/Documents/kifutter'

require 'rubygems'
require 'sinatra'
require File.join(DIR, "db/kifutter")
include Kifutter

helpers do
  include Rack::Utils; alias_method :h, :escape_html
end

get '/' do
  @total_price = Tweet.sum_price
  @total_count = Tweet.count
  @user_count = User.count
  haml :index
end
