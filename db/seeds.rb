# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


b01= User.create!({:email => "zack@collectinpost", :password => "collectin2016", :password_confirmation => "collectin2016", :admin => true, :name => "Zack" })
b02= User.create!({:email => "daniel@collectinpost", :password => "collectin2016", :password_confirmation => "collectin2016", :admin => true, :name => "Daniel" })