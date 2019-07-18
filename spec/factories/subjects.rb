FactoryBot.define do
  factory :subject do |s|
    s.name {Faker::Name.name_with_middle}
    s.description {Faker::Lorem.paragraph}
  end
end
