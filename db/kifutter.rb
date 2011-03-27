# -*- coding: utf-8 -*-
#
# @file 
# @brief
# @author ongaeshi
# @date   2011/03/16

require 'sequel'
require 'logger'

module Kifutter
  DB_NAME = File.join(DIR, 'db/kifutter.db')
  LOG_NAME = File.join(DIR, 'log/kifutter.log')
  TEST_DB = File.join(DIR, 'db/test.db')

  Sequel.connect("sqlite://#{DB_NAME}", :loggers => [Logger.new(LOG_NAME, 5)])

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
