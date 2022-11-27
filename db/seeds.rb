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

uncategorized_pro = Categories::Product.create(name: 'Donuts', description: 'Collection of Donuts')

branch = Branch.first

category = Categories::Product.all.last

["2D Premium Cake Donut - Ube Crunch", "2D Premium Choco cake new Dutch Choco Crunch","Smidgets Choco Peanut", "2D Smidgets, New Dutch Choco Crunch", "Smidgets Big - Choco Crinkles", "Choco Cake - p100 - Choco glated", "2D Choco Butternut Prem Choco Cake Donut", "Choco Bavarian Triple Choco Donut", "Kopi Kreme Donut Black Coffee", "Honey Dip", "Bav Doubles", "2D Classic Bavarian New Donut", "2D Strawberry filled new Donut", "2D Choco Fudge filled new Donut", "Premium twist - Double Dutch", "Premium Twist - Choco Nibes", "2D Smidgets, Berry Strawberry", "Donuts N'Dip Jr. Duos", "Cream Filled Donut - Coffee", "Cream Filled Donut - Peanut", "Cream Filled Donut - Strawberry", "20 Smidgets - Bavarian Classic", "20 Choco Nuts - Ring Donut", "2D Creamy Brew - Ring Donut", "Election Donuts Red", "Election Donuts Pink", "Election Donuts Blue", "Election Donuts White"].each do |name|
  product = Product.new(name: name, type: 'Product', category_id: category.id, branch_id: branch.id)

  if product.save
    puts "#{name} is saved"
  else
    puts product.errors.full_messages
  end
end
