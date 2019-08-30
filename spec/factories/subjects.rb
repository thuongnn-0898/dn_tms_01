FactoryBot.define do
  factory :subject do |f|
    f.name {Faker::Name.name_with_middle}
    f.description {Faker::Lorem.paragraph}
  end
end


