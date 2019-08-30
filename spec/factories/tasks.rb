FactoryBot.define do
  factory :task do |c|
    c.name {Faker::Educator.subject}
  end
end
