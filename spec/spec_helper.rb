$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rubygems'
require 'sqlite3'
require 'active_record'
require 'acts_as_orderable'
require 'acts_as_tree'

ActiveRecord::Base.establish_connection(
    :adapter => "sqlite3",
    :database  => ":memory:"
)

ActiveRecord::Schema.define do
    create_table :cool_elements do |table|
        table.integer :element_order, :default => 0
    end

    create_table :cooler_elements do |table|
        table.integer :element_order, :default => 0
    end

    create_table :way_cooler_elements do |table|
        table.integer :parent_id
        table.integer :element_order, :default => 0
    end
end

