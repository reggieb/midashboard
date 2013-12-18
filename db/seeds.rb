
email = 'robnichols@warwickshire.gov.uk'
unless User.exists?(:email => email)
  password = 'change_me'
  User.create!(
    :email => email,
    :password => password,
    :password_confirmation => password
  )
  puts "User added"
end
