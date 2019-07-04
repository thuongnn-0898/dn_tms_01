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
