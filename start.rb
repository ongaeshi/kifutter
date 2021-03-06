# -*- coding: utf-8 -*-

require 'rubygems'
require 'sinatra'
require 'haml'
require 'lib/init'
require 'db/kifutter'
include Kifutter

helpers do
  include Rack::Utils
  alias_method :h, :escape_html
end

get '*/*.css' do
  scss params[:splat][1].to_sym
end

get '/' do
  @total_price = Tweet.sum_price
  @total_count = Tweet.count
  @user_count = User.count
  haml :index
end
