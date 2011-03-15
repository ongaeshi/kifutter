# -*- coding: utf-8 -*-
#
# @file 
# @brief
# @author ongaeshi
# @date   2011/03/16

require 'sequel'
Sequel::Model.plugin(:schema)

Sequel.connect("sqlite://users.db")

class Users < Sequel::Model
  unless table_exists?
    set_schema do
      primary_key :id
      string :name              # ongaeshi
      string :message           # 100円寄付したよ！
      Bignum :price             # 100
    end
    create_table
  end
end
