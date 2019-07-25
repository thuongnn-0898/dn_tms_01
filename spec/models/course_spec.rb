require "rails_helper"

RSpec.shared_examples "when empty" do |field|
  it do
    course.save
    expect(course.errors[field].first).to eql I18n.t("errors.messages.blank")
  end
end

RSpec.shared_examples "too long" do |field, count|
  it do
    course.save
    expect(course.errors[field].first).to eql I18n.t "errors.messages.too_long",
      count: count
  end
end

RSpec.describe Course, type: :model do
  let(:course) {FactoryBot.create :course}
  let(:sub) {FactoryBot.create :subject}

  subject{course}

  before{sub.save}


  it "should be valid" do
    expect(course).to be_valid
  end

  describe "#name" do
    it{is_expected.to validate_presence_of :name}
    it{is_expected.to validate_length_of(:name).
      is_at_most Settings.name_length_maximum}

    context "when the name is empty" do
      before{course.name = nil}
      it_behaves_like "when empty", :name
    end

    context "when the name is too long" do
      before{course.name = Faker::Lorem.paragraphs Settings.
        name_length_maximum * 2}
      it_behaves_like "too long", :name, Settings.name_length_maximum
    end
  end

  describe "#description" do
    it{is_expected.to validate_presence_of :description}
    it{is_expected.to validate_length_of(:description).is_at_most Settings.
      content_text_max_length}

    context "when the description is empty" do
      before{course.description = nil}
      it_behaves_like "when empty", :description
    end

    context "when the description is too long" do
      before {course.description = Faker::Lorem.paragraphs Settings.
        content_text_max_length * 2}
      it_behaves_like "too long", :description, Settings.content_text_max_length
    end
  end

  describe "#date_start" do
    it{is_expected.to validate_presence_of :date_start}

    context "when the date_start smaller current date" do
      before{course.date_start = course.date_end - 100.days}
      it do
        course.save
        expect(course.errors[:date_start].first).to eql I18n.
          t "activerecord.errors.models.course.attributes.date_start.date_start_must_be_large_than_today"
      end
    end
  end

  describe "#date_end" do
    it{is_expected.to validate_presence_of :date_end}

    context "when the date_end smaller date start" do
      before{course.date_end = course.date_start - 100.days}
      it do
        course.save
        expect(course.errors[:date_end].first).to eql I18n.
          t "activerecord.errors.models.course.attributes.date_end.date_end_must_be_equal_large_than_date_start"
      end
    end
  end

end
