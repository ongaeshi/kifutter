# -*- coding: utf-8 -*-
require 'rubygems'
require 'sinatra'
require File.join(File.dirname(__FILE__), "model/kifutter")
include Kifutter

helpers do
  include Rack::Utils; alias_method :h, :escape_html
end

get '/kifutter.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass :style
end

get '/' do
  @total_price = Tweet.sum_price
  @total_count = Tweet.count
  haml :index
end
