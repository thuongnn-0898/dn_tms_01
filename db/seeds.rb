
30.times do
  name = Faker::Educator.subject
  description = Faker::Lorem.character
  Subject.create! name: name, description: description
end
