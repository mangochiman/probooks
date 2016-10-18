
user = User.new
user.first_name = 'Super'
user.last_name = 'User'
user.email = 'superuser@gmail.com'
user.phone_number = '0111111111'
user.password = 'user'
user. username = 'super'
user.save

user_role = UserRole.new
user_role.username = user.username
user_role.role = 'admin'
user_role.save

categories = ['Primary', 'Secondary', 'Tertiary']
categories.each do |category_name|
  new_category = Category.new
  new_category.name = category_name
  new_category.save
end