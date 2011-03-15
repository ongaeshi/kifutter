# -*- coding: utf-8 -*-
require 'rubygems'
require 'sinatra'
require 'model/users.rb'

helpers do
  include Rack::Utils; alias_method :h, :escape_html
end

get '/style.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass :style
end

get '/' do
  @total_price = Users.total_price
  @total_count = Users.total_count
  haml :index
end

get '/create_dummy_data' do
  (1...100000).each do
    Users.create({
                   :name => 'ongaeshi',
                   :message => '100円寄付したよ！',
                   :price => 10233,
                 })
  end

  redirect '/'
end
