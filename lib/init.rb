# -*- coding: utf-8 -*-
#
# @file 
# @brief
# @author ongaeshi
# @date   2011/03/27

require 'logger'

module Kifutter
  DATABASE_URL = 'sqlite://db/kifutter.db'
  LOG_DIR = 'log'
  SETUP_FILE = 'setup'
  
  def self.database_url
    ENV['DATABASE_URL'] || DATABASE_URL
  end

  def self.log_file(filename)
    dir = ENV['LOG_DIR'] || LOG_DIR
    File.join(dir, filename)
  end

  def self.setup_file
    ENV['SETUP_FILE'] || SETUP_FILE    
  end

  def self.url_root(path = nil)
    #root = '/'
    root = '/kifutter'

    if (path)
      File.join(root, path)
    else
      root
    end
  end
end


