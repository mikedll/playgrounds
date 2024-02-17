#!/usr/bin/env ruby

ENV['BUNDLE_GEMFILE'] = File.join(File.dirname(__FILE__), '/Gemfile')

require 'rubygems'
require 'bundler/setup'
Bundler.require

require 'logger'
require 'active_record'
require 'pry'

class AppRecord < ActiveRecord::Base
  establish_connection 'sqlite3::memory:'

  self.abstract_class = true
end

class MyModel < AppRecord
end


ActiveRecord::Base.logger = Logger.new(STDOUT)

class MySchema < ActiveRecord::Schema
  def connection
    AppRecord.connection
  end

  def define(info, &block) # :nodoc:
    instance_eval(&block)

    if info[:version].present?
      connection.schema_migration.create_table
      connection.assume_migrated_upto_version(info[:version])
    end
  end
end

MySchema.define do
  create_table :my_models do |t|
    t.datetime  :marked_at
    t.timestamps
  end
end

m = MyModel.new(:marked_at => Time.now)
m.save

m.update(marked_at: Time.now - 3.days)

puts m.marked_at



