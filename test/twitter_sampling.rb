# -*- coding: utf-8 -*-
#
# @file 
# @brief
# @author ongaeshi
# @date   Twitterからデータをサンプリング

require 'rubygems'
require 'twitterstream'
require 'sequel'
Sequel::Model.plugin(:schema)

DB = Sequel.connect("sqlite://twitter-sampling.db")

unless (DB.table_exists? :tweets)
  DB.create_table :tweets do
    primary_key :id
    string :user_screen_name  # ongaeshi
    string :text              # 100円寄付したよ！
  end
end

class Tweet < Sequel::Model
  primary_key :id
  string :user_screen_name  # ongaeshi
  string :text              # 100円寄付したよ！
end

tweets = DB[:tweets]

USERNAME = 'kifutter_jp'
PASSWORD = 'dk39wqld01.20swl'

TwitterStream.new({:username => USERNAME, :password => PASSWORD}).sample do |status|
  next unless status['text']

  user = status['user']
  username = user['screen_name']
  text = status['text']
  
  # puts "#{username}: #{text}"
  tweets.insert(:user_screen_name => username, :text => text)

  if (tweets.count % 100 == 0)
    puts "#{Time.now.strftime("%Y/%m/%d %H:%M:%S")} #{tweets.count} tweets #{File.size? 'twitter-sampling.db'} byte"
  end
end
