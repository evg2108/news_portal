# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
admin_role = Role.find_or_create_by(name: 'admin')
Role.find_or_create_by(name: 'user')

if Rails.env.development?
  User.create!(email: 'admin@admin.com',
               name: 'admin',
               password: 'password',
               password_confirmation: 'password',
               roles: [admin_role]
  )
end