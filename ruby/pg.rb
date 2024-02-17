#!/usr/bin/env ruby

ENV['BUNDLE_GEMFILE'] = File.join(File.dirname(__FILE__), '/Gemfile')

require 'rubygems'
require 'bundler/setup'
Bundler.require

conn = PG.connect(dbname: 'baseball')

# conn.exec('create table players (id serial primary key, name varchar(255))') do |res|
#   res.each do |row|
#     puts row
#   end
# end

# ['Alex Smith', 'Alex Jones'].each do |name|
#   conn.exec_params('insert into players (name) values ($1)', [name]) do |res|
#     res.each do |row|
#       puts row
#     end
#   end

# end

# conn.exec_params("select * from players where name like $1", ['Alex%']) do |result|
#   result.each do |row|
#     puts "#{row['id']}, #{row['name']}"
#   end
# end

# conn.exec_params("select * from players where name like $1", ['Mike%']) do |result|
#   result.each do |row|
#     puts "#{row['id']}, #{row['name']}"
#   end
# end

conn.exec_params("insert into players (name) values ($1) returning id", ['Ricky Ricardo']) do |result|
  result.each do |row|
    puts "#{row['id']}"
  end
end


