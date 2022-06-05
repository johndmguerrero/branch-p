# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


branch = Branch.new( name: 'Mister Donuts', address: 'Bacoor, Cavite')
branch.save
owner = branch.users.create( email: 'owner@gmail.com', password: 'Testing123', password_confirmation: 'Testing123')
owner.owner!

wallet = branch.create_wallet!

systad = branch.users.create( email: 'System@gmail.com', password: 'Testing123', password_confirmation: 'Testing123')


uncategorized_pro = Categories::Product.create(name: 'Uncategorized', description: '')
uncategorized_itm = Categories::Item.create(name: 'Uncategorized', description: '')



