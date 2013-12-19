Seeder = Dibber::Seeder

Seeder.seed(:role)
admin = Role.find_by_name('admin')

Seeder.monitor User
email = 'robnichols@warwickshire.gov.uk'
if User.exists?(:email => email)
  user = User.find_by_email(email)
else
  password = 'change_me'
  user = User.create!(
    email: email,
    password: password,
    password_confirmation: password,
  )
end

admin.users << user if admin.users.empty?


puts Seeder.report