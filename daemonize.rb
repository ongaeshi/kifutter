# -*- coding: utf-8 -*-
#
# @file 
# @brief
# @author ongaeshi
# @date   2011/03/27

if Process.respond_to? :daemon  # Ruby 1.9
  Process.daemon
else                            # Ruby 1.8
  require 'webrick'
  WEBrick::Daemon.start
end


