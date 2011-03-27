# -*- coding: utf-8 -*-
#
# @file 
# @brief
# @author ongaeshi
# @date   2011/03/16

require 'sequel'
require 'lib/init'

module Kifutter
  Sequel.connect(database_url, :loggers => [Logger.new(log_file('kifutter.log'), 5)])

  class User < Sequel::Model
    one_to_many :tweets
  end

  class Tweet < Sequel::Model
    many_to_one :user

    def self.sum_price
      sum(:price)
    end
  end
end
