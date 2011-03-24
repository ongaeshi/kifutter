# -*- coding: utf-8 -*-
#
# @file 
# @brief
# @author ongaeshi
# @date   2011/03/16

require 'sequel'
require 'logger'

module Kifutter
  DB_NAME = 'kifutter.db'

  Sequel.connect("sqlite://#{DB_NAME}", :loggers => [Logger.new('kifutter.log')])

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
