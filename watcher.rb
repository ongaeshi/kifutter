# -*- coding: utf-8 -*-
#
# @file 
# @brief
# @author ongaeshi
# @date   2011/03/25

require 'rubygems'
require 'twitterstream'
require 'sequel'
require 'logger'
require 'lib/lib'
require 'db/kifutter'
include Kifutter

module Kifutter
  class Watcher
    def self.exec
      data = Marshal.load(open(TEST_DB))
      Watcher.new(DB_NAME, data[0], data[1], LOG_NAME).start
    end

    def initialize(db_name, username, password, log_file)
      @db_name = db_name
      @username = username
      @password = password
      @log = Logger.new(log_file)
    end
    
    def start
      # TwitterStream.new({:username => @username, :password => @password}).sample do |status|
      TwitterStream.new({:username => @username, :password => @password}).follow([266062941]) do |status|
        next unless status['text']

        # ユーザー
        u = status['user']
        user = User[:tw_id => u['id']] || User.new
        user.tw_id = u['id']
        user.name = u['name']
        user.screen_name = u['screen_name']
        user.profile_image_url = u['profile_image_url']
        user.save

        # つぶやき
        tweet = Tweet[:tw_id => status['id']] || Tweet.new
        tweet.tw_id = status['id']
        tweet.text = status['text']
        tweet.created_at = status['created_at']
        tweet.user = user
        tweet.price = parse_price(tweet.text)
        tweet.url = parse_url(tweet.text)
        tweet.save
        
        # 定期的にデバッグ表示
        if (Tweet.count % 100 == 0)
          @log.info "#{Time.now.strftime("%Y/%m/%d %H:%M:%S")} #{Tweet.count} tweets #{File.size? @db_name} byte"
        end
      end
    end
  end
end

if __FILE__ == $0
  Kifutter::Watcher.exec
end

