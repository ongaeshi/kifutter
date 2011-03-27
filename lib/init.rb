# -*- coding: utf-8 -*-
#
# @file 
# @brief
# @author ongaeshi
# @date   2011/03/27

require 'logger'

module Kifutter
  #DIR = File.dirname(__FILE__)
  DIR = '/Users/ongaeshi/Documents/kifutter'

  DATABASE_URL = 'sqlite://db/kifutter.db'
  LOG_DIR = 'log'
  
  # DB_NAME = File.join(DIR, 'db/kifutter.db')
  TEST_DB = File.join(DIR, 'db/test.db')
  # LOG_NAME = File.join(DIR, 'log/kifutter.log')

  def self.database_url
    ENV['DATABASE_URL'] || DATABASE_URL
  end

  def self.log_file(filename)
    dir = ENV['LOG_DIR'] || LOG_DIR
    File.join(dir, filename)
  end
end


