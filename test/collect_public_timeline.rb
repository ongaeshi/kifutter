# -*- coding: utf-8 -*-
#
# @file 
# @brief
# @author ongaeshi
# @date   public time line からデータを収集

require 'rubygems'
require 'twitterstream'

USERNAME = 'kifutter_jp'
PASSWORD = 'dk39wqld01.20swl'

TwitterStream.new({:username => USERNAME, :password => PASSWORD}).sample do |status|
  next unless status['text']
  user = status['user']
  puts "#{user['screen_name']}: #{status['text']}"
end
