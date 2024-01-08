# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Admin.create(name: 'admin', email: 'admin@gmail.com', password: 'admin@123', type: 'Admin')


# 5.times do |i|
#   Category.create(name:"catg#{i+1}")
# ends

# Account.create(cc:1000,category_id:1)
# Account.create(cc:500,category_id:2)
# Account.create(cc:600,category_id:3)
# Account.create(cc:800,category_id:4)
# Account.create(cc:900,category_id:5)


# Account.all.each do |account|
#    account.ratings.create(account_id:account.id)
# end

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?