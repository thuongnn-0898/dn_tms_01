require "rails_helper"

RSpec.shared_examples "when empty" do |field|
  it do
    sub.save
    expect(sub.errors[field].first).to eql I18n.t("errors.messages.blank")
  end
end

RSpec.shared_examples "when too short" do |field, count|
  it do
    sub.save
    expect(sub.errors[field].first).to eql I18n.t("errors.messages.too_short",
      count: count)
  end
end

RSpec.shared_examples "when too long" do |field, count|
  it do
    sub.save
    expect(sub.errors[field].first).to eql I18n.t("errors.messages.too_long",
      count: count)
  end
end

RSpec.describe Subject, type: :model do
  context "association_tasks" do
    it {is_expected.to have_many :tasks}
  end

  let(:sub) {FactoryBot.create :subject}
  subject{sub}

  it "should be valid" do
    expect(sub).to be_valid
  end

  describe "#name" do
    it {is_expected.to validate_presence_of :name}
    it {is_expected.to validate_length_of(:name)
      .is_at_most(Settings.name_length_maximum)}
    it {is_expected.to validate_length_of(:name)
      .is_at_least(Settings.name_length_minimum)}

    context "when name empty" do
      before {sub.name = nil}
      it_behaves_like "when empty", :name
      puts "Name null oke"
    end

    context "when too short" do
      before{ sub.name = "Thuongne" }
      it_behaves_like "when too short", :name, Settings.name_length_minimum
    end

    context "when too long" do
      before{ sub.name = Faker::Educator.subject * 100 }
      it_behaves_like "when too long", :name, Settings.name_length_maximum
    end
  end

  describe "#description" do
    it{is_expected.to validate_presence_of :description}
    it{is_expected.to validate_length_of(:description).
      is_at_most(Settings.content_text_max_length)}

    context "when description empty" do
      before { sub.description = nil}
      it_behaves_like "when empty", :description
    end

    context "when description too long" do
      before{ sub.description = Faker::Educator.subject * 100 }
      it_behaves_like "when too long", :description, Settings.content_text_max_length
    end
  end
end
