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

get Kifutter::url_root('/*.css') do
  scss params[:splat][0].to_sym
end

# hoge/ のような '/' 終わりを '/' 無しへリダイレクト
# ただし、 http://example.com の場合は末尾 '/' が付く
get %r{^(.+)/$} do |c|
  redirect c, 303
end

get Kifutter::url_root do
  @total_price = Tweet.sum_price
  @total_count = Tweet.count
  @user_count = User.count
  haml :index
end
