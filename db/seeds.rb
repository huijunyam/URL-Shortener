# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user1 = User.create(email: "rnj@clemson.edu")
user2 = User.create(email: "huijunyam@gmail.com")

url1 = ShortenedUrl.create(short_url: "https://goo.gl/r5Pl", long_url: "yahoo.com", user_id: 1)
