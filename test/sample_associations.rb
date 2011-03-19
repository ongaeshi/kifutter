# -*- coding: utf-8 -*-
#
# @file 
# @brief 表同士の関係構築サンプル
# @author ongaeshi
# @date   2011/03/19

require 'rubygems'
require 'sequel'
Sequel::Model.plugin(:schema)

DB = Sequel.sqlite

class Post < Sequel::Model
  unless table_exists?
    set_schema do
      primary_key :id
      String :name
    end
  end
  create_table

  one_to_many :comments
  many_to_many :tags # 複数の記事が、複数のタグを持っている
end

class Comment < Sequel::Model
  unless table_exists?
    set_schema do
      primary_key :id
      String :text
      foreign_key :post_id, :posts
    end
  end
  create_table

  many_to_one :post
end

class Tag < Sequel::Model
  unless table_exists?
    set_schema do
      primary_key :id
      String :name
    end
  end
  create_table

  many_to_many :posts
end

DB.create_table(:posts_tags) do
  foreign_key :post_id, :posts
  foreign_key :tag_id, :tags
end

post = Post.create(:name => 'title1')
post.add_comment(Comment.create(:text => 'Hi'))
post.add_comment(Comment.create(:text => 'Bye!!'))
post.add_tag(Tag.create(:name => 'funny'))
post.add_tag(Tag.create(:name => 'death'))

post2 = Post.create(:name => 'title2')
post2.add_tag(Tag.filter(:name => 'death').first)

post3 = Post.create(:name => 'title2')
post3.add_tag(Tag.create(:name => 'head'))

def new_tag(post, tag_name)
  tag = Tag[:name => tag_name]
  post.add_tag(tag ? tag : Tag.create(:name => tag_name))
end

new_tag(post3, 'dummy')
new_tag(post3, 'head')
new_tag(post3, 'bat')
new_tag(post3, 'cannnon')
new_tag(post3, 'death')

p Post.count

puts "-- Post1"
p Post[1].values
p Post[1].comments
p Post[1].tags

puts "-- Post2"
p Post[2].values
p Post[2].comments
p Post[2].tags

puts "-- Post3"
p Post[3].values
p Post[3].comments
p Post[3].tags

puts "-- Tags"
p Tag.all



