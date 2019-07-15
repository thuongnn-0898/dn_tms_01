30.times do
  name = Faker::Educator.subject
  description = Faker::Lorem.character
  Subject.create! name: name, description: description
15.times do |n|
  email = "thuong#{n+1}@fpt.edu.vn"
  password = "123123"
  role = rand(2)
  fullname = Faker::Name.name
  birthday = "1999/04/13"
  gender = rand(2)
  User.create!(email: email, password: password,role: role,fullname: fullname,
    birthday: birthday,gender: gender)
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
