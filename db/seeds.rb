
30.times do
  name = Faker::Educator.subject
  description = Faker::Lorem.character
  Subject.create! name: name, description: description
end

50.times do
  email = Faker::Internet.email
  password = "abc123"
  role = User.roles[:trainee]
  fullname = Faker::Name.name_with_middle
  birthday = Date.today.to_date
  gender = rand(0..1)
  User.create! email: email, password: password,
    password_confirmation: password, role: role, fullname: fullname,
    birthday: birthday, gender: gender
end
