# -*- coding: utf-8 -*-
#
# @file 
# @brief
# @author ongaeshi
# @date   2011/03/25

require 'nkf'

module Kifutter
  def zensuji_to_han(s)
    return NKF::nkf( '-Wwxm0Z0', s )
  end

  def parse_price(text)
    text = zensuji_to_han(text)
    text =~ /(\d+)円/
    $1.to_i
  end

  def parse_url(text)
    ''
  end
end

