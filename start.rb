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
  haml :index
end

get '/create_dummy_data' do
  Users.create({
    :name => 'ongaeshi',
    :message => '100円寄付したよ！',
    :price => 10233,
  })
  redirect '/'
end
