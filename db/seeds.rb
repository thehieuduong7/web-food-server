# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# TODO: Seed user
user_service = UsersService.new
password = '123QWEasd'
# seed admin
User.create(
  {
    id: 1,
    email: 'admin@gmail.com',
    password: user_service.hash_bcrypt(password),
    first_name: 'admin',
    last_name: 'admin',
    gender: true,
    is_active: true,
    is_admin: true
  }
)
users = (1..20).reduce([]) do |assume, current|
  user = {
    id: current+1,
    email: "user#{current}@gmail.com",
    password: user_service.hash_bcrypt(password),
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    gender: Faker::Boolean.boolean,
    dob: Faker::Date.birthday(min_age: 18, max_age: 65),
    avatar: Faker::Avatar.image(slug: 'my-own-slug', size: '50x50', format: 'jpg'),
    phone: Faker::PhoneNumber.cell_phone_in_e164,
    address: Faker::Address.full_address,
    is_active: Faker::Boolean.boolean(true_ratio: 0.8),
    is_admin: false
  }
  assume.append(user)
end
User.create(users)
# seed categories

categories = (1..10).reduce([]) do |assume, current|
  category = {
    id: current,
    name: Faker::Food.ethnic_category,
    description: Faker::Food.description,
    url: Faker::Avatar.image(slug: 'my-own-slug', size: '50x50', format: 'jpg')
  }
  assume.append(category)
end
Category.create(categories)

# seed products

products = (1..20).reduce([]) do |assume, current|
  product = {
    id: current,
    name: Faker::Food.dish,
    description: Faker::Food.description,
    price: Faker::Number.between(from: 1, to: 20) * 1000,
    total_sold: Faker::Number.between(from: 100, to: 200),
    percent_sale: Faker::Number.between(from: 0.0, to: 1.0).round(2),
    status: ["active","inactive"].sample,
    categories:
  }
  assume.append(product)

end
Product.upsert_all(products)

# seed prodcut_images
product_images = Product.all()
