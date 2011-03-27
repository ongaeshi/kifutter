# -*- coding: utf-8 -*-
#
# @file 
# @brief
# @author ongaeshi
# @date   2011/03/25

require 'rubygems'
require 'test/unit'
require 'lib/lib'

class TestLib < Test::Unit::TestCase
  include Kifutter

  def test_parse_price
    assert_equal parse_price('@kifutter_jp ○○で500円募金したよ'), 500
    assert_equal parse_price('@kifutter_jp ○○で５００円募金したよ'), 500
    assert_equal parse_price('@kifutter_jp ○○で12９０円募金したよ'), 1290
    assert_equal parse_price('@kifutter_jp 思い切って1000円入れてみた！！ http://bit.ly/eCJ38H'), 1000
  end

  def test_parse_url
  end
end



