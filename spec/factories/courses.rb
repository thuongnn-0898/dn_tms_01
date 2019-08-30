# FactoryBot.define do
#   factory :course do |c|
#     c.name {Faker::Educator.subject}
#     c.description {Faker::Lorem.paragraphs}
#     c.duration {5}
#     c.duration_type {2}
#     c.date_start {DateTime.now.to_date}
#     c.date_end {DateTime.now.to_date}
#     c.course_subjects {[CourseSubject.new(subject_id: Subject.first.id)]}
#   end
# end
